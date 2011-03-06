package Plack::Middleware::SocketIO;

use strict;
use warnings;

use base 'Plack::Middleware';

our $VERSION = '0.00100';

use Plack::Util::Accessor qw(resource handler);

use Plack::Middleware::SocketIO::Impl;

sub call {
    my ($self, $env) = @_;

    my $resource = $self->resource || 'socket.io';
    $resource = quotemeta $resource;

    if ($env->{PATH_INFO} =~ m{^/$resource/}) {
        my $instance = Plack::Middleware::SocketIO::Impl->instance;

        return $instance->finalize($env, $self->handler);
    }

    return $self->app->($env);
}

1;