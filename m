From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] jack: use eventfd which never blocks.
Date: Sun, 21 Nov 2010 15:15:40 +0500
Message-ID: <4CE8F14C.4040003@gmail.com>
References: <1290176549-31258-1-git-send-email-torbenh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id C7C542436F
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 11:15:52 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PK6xc-0001GY-DJ
	for alsa-devel@alsa-project.org; Sun, 21 Nov 2010 11:15:52 +0100
Received: from 188.16.198.194 ([188.16.198.194])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 11:15:52 +0100
Received: from patrakov by 188.16.198.194 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 11:15:52 +0100
In-Reply-To: <1290176549-31258-1-git-send-email-torbenh@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

19.11.2010 19:22, Torben Hohn wrote:
> the use of the socketpair for synchronisation is not correct.
> jack does not allow blocking calls in the process_callback,
> the socket buffers are quite small, and seem to overflow under some
> conditions.

Some remarks.

First, your patch preserves the incorrect code for the case when eventfd 
is not available. While this is not a regression, I think you can do 
better (possibly in a separate patch).

Second, I disagree that socketpair()-based synchronization cannot be 
made correct and thus that eventfd is needed for correctness. It might 
be needed for efficiency, though.

> the result was write(2) blocking, and jack kicking the client.

So why not just make the file descriptor non-blocking? This way, instead 
of blocking the write(2), the socket pair would lose data when it gets 
too many writes. No problem - the reader will still see its file 
descriptor as active, eat a byte from the socket in 
snd_pcm_jack_poll_revents() and presumably do something to fill the 
audio buffer.

> (jack needs to be running in RT mode, with a pretty low period size (<=128)
> but this really is the normal usecase)
>
> this patch uses eventfd(2) when its available to mitigate the problem.
>
> Signed-off-by: Torben Hohn<torbenh@gmx.de>
> ---
>   configure.in    |    5 +++++
>   jack/pcm_jack.c |   30 +++++++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/configure.in b/configure.in
> index 5d71cae..9fa7f27 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -21,6 +21,11 @@ AC_CHECK_LIB(asound, snd_pcm_ioplug_create,,
>   AC_ARG_ENABLE([jack],
>         AS_HELP_STRING([--disable-jack], [Disable building of JACK plugin]))
>
> +AC_CHECK_HEADER([sys/eventfd.h], [HAVE_EVENTFD=yes], [HAVE_EVENTFD=no])
> +if test "$HAVE_EVENTFD" = "yes"; then
> +	AC_DEFINE(HAVE_EVENTFD, 1,"eventfd is available")
> +fi
> +
>   if test "x$enable_jack" != "xno"; then
>     PKG_CHECK_MODULES(JACK, jack>= 0.98, [HAVE_JACK=yes], [HAVE_JACK=no])
>   fi
> diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
> index 3370a26..83ac56a 100644
> --- a/jack/pcm_jack.c
> +++ b/jack/pcm_jack.c
> @@ -20,6 +20,8 @@
>    *
>    */
>
> +#include "config.h"
> +
>   #include<byteswap.h>
>   #include<sys/shm.h>
>   #include<sys/types.h>
> @@ -28,6 +30,10 @@
>   #include<alsa/asoundlib.h>
>   #include<alsa/pcm_external.h>
>
> +#ifdef HAVE_EVENTFD
> +#include<sys/eventfd.h>
> +#endif
> +
>   typedef enum _jack_format {
>   	SND_PCM_JACK_FORMAT_RAW
>   } snd_pcm_jack_format_t;
> @@ -63,8 +69,10 @@ static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
>   		}
>   		if (jack->fd>= 0)
>   			close(jack->fd);
> +#ifndef HAVE_EVENTFD
>   		if (jack->io.poll_fd>= 0)
>   			close(jack->io.poll_fd);
> +#endif
>   		free(jack->areas);
>   		free(jack);
>   	}
> @@ -81,11 +89,19 @@ static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io ATTRIBUTE_UNUSED,
>   				     struct pollfd *pfds, unsigned int nfds,
>   				     unsigned short *revents)
>   {
> +#ifdef HAVE_EVENTFD
> +	eventfd_t buf[1];
> +#else
>   	static char buf[1];
> -	
> +#endif
> +
>   	assert(pfds&&  nfds == 1&&  revents);
>
> -	read(pfds[0].fd, buf, 1);
> +	read(pfds[0].fd, buf, sizeof(buf));
> +#ifdef HAVE_EVENTFD
> +	buf[0] -= 1;
> +	write(pfds[0].fd, buf, sizeof(buf));
> +#endif
>
>   	*revents = pfds[0].revents;
>   	return 0;
> @@ -103,7 +119,11 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
>   	snd_pcm_jack_t *jack = io->private_data;
>   	const snd_pcm_channel_area_t *areas;
>   	snd_pcm_uframes_t xfer = 0;
> +#ifdef HAVE_EVENTFD
> +	static eventfd_t buf[1] = { 0x00000001 };
> +#else
>   	static char buf[1];
> +#endif
>   	unsigned int channel;
>   	
>   	for (channel = 0; channel<  io->channels; channel++) {
> @@ -143,7 +163,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
>   		xfer += frames;
>   	}
>
> -	write(jack->fd, buf, 1); /* for polling */
> +	write(jack->fd, buf, sizeof(buf)); /* for polling */
>
>   	return 0;
>   }
> @@ -361,7 +381,11 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
>   		return -ENOMEM;
>   	}
>
> +#ifdef HAVE_EVENTFD
> +	fd[0] = fd[1] = eventfd(0, 0);
> +#else
>   	socketpair(AF_LOCAL, SOCK_STREAM, 0, fd);
> +#endif
>   	
>   	jack->fd = fd[0];
>
