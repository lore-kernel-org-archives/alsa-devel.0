From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: [Alsa-devel] Static build of alsa-lib
Date: Wed, 21 Mar 2007 12:00:23 -0700 (PDT)
Message-ID: <83409.85532.qm@web31007.mail.mud.yahoo.com>
References: <s5haby7dhuy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web31007.mail.mud.yahoo.com (web31007.mail.mud.yahoo.com
	[68.142.200.170]) by alsa0.perex.cz (Postfix) with SMTP id E5FA024426
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2007 20:00:25 +0100 (CET)
In-Reply-To: <s5haby7dhuy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
I have just tried the patch you provided me. I applied
the patch and then I configured alsa-lib as following:

./configure --enable-static --disable-shared
--disable-mixer --disable-hwdep --disable-rawmidi
--disable-seq --disable-instr --disable-alisp
--with-pcm-plugins=no --with-libdl=no
--with-pthread=no 

The compilation works fine, ant the static library is
created. When I try to link my application to it, I
get the following warning:

~/alsa $ gcc -Wall -O2 -o test test.c
-L/tmp/alsa-lib-hg20070317/src/.libs/ -lasound -static

/tmp/alsa-lib-hg20070317/src/.libs/libasound.a(control_shm.o):
In function `_snd_ctl_shm_open':
/tmp/alsa-lib-hg20070317/src/control/control_shm.c:664:
warning: Using 'gethostbyname' in statically linked
applications requires at runtime the shared libraries
from the glibc version used for linking

I think we are getting closer, but I could not figure
out how to exclude this from the compilation. The file
control_shm.c contains only few macro #IFDEFS, and
none for it.

Takashi, could you tell me why/when the pthread lib is
needed? Do I need it for PCM, or is it used just for
MIDI?

Last but not least, the ./configure --help does not
give information about the the new switches
(--with-libdl=no --with-pthread=no), shouldn't they be
visible in the "help" page?

Thanks again,
Bye bye

Andrea

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 20 Mar 2007 08:13:41 -0700 (PDT),
> Ciaccia wrote:
> > 
> > Hi Takashi,
> > It's clear that the concept of dynamic loading
> doesn't
> > conflict with static library, I think my original
> > question was not completely clear. 
> > 
> > I would like to port a sound application (just
> PCM, no
> > midi or other stuff) to an embedded system. The
> core
> > of this embedded system is a Cirrus EP9302 ARM
> > processor, which supports hardware floating
> points.
> > 
> > ARM processors have several ABIs (EABI, OABI, ???)
> and
> > programs compiled using one ABI are not linkable
> > (neither at compile time, nor at run time) with
> other
> > binaries, because of the different format. This is
> a
> > problem for binary distributions (such as Debian),
> > since the same binary does not work on all ARM
> > architectures.
> > 
> > For a reason I really don't understand, EP9302
> > hardware floating point binaries only work when
> > compiled with -static (don't ask me why...), and
> > therefore I wanted to have a "static" (=without
> shared
> > libraries) ALSA application. If this would not be
> > possible I can always use OSS (which does not
> requires
> > shared objects to be loaded at run time), but I
> still
> > think it should be possible to develop ALSA
> > applications for architectures where dynamic
> loading
> > is not available...
> > 
> > Is there a way to achieve this?
> 
> Sure, what I meant is that the patch had no function
> to disable the
> libdl and libpthread explicitly but only checked. 
> The new patch
> below, for example, can give you options
> --with-libdl and
> --with-pthread.  For disabling libdl, pass
> --with-libdl=no.
> 
> If this works for you, I'll apply it to the
> upstream.
> 
> 
> Takashi
> 
> 
> diff -r 6d0a999aef24 Makefile.am
> --- a/Makefile.am	Fri Mar 16 15:22:27 2007 +0100
> +++ b/Makefile.am	Tue Mar 20 16:55:23 2007 +0100
> @@ -1,4 +1,7 @@ SUBDIRS=doc include src modules
> -SUBDIRS=doc include src modules
> +SUBDIRS=doc include src
> +if BUILD_MODULES
> +SUBDIRS += modules
> +endif
>  if BUILD_PCM_PLUGIN_SHM
>  SUBDIRS += aserver
>  endif
> diff -r 6d0a999aef24 configure.in
> --- a/configure.in	Fri Mar 16 15:22:27 2007 +0100
> +++ b/configure.in	Tue Mar 20 16:55:00 2007 +0100
> @@ -148,6 +148,44 @@ else
>  else
>    AC_MSG_RESULT(no)
>  fi
> +
> +ALSA_DEPLIBS=""
> +if test "$softfloat" != "yes"; then
> +  ALSA_DEPLIBS="-lm"
> +fi
> +
> +dnl Check for libdl
> +AC_MSG_CHECKING(for libdl)
> +AC_ARG_WITH(libdl,
> +  [  --with-libdl        Use libdl for plugins
> (default = yes)],
> +  [ have_libdl="$withval" ], [ have_libdl="yes" ])
> +if test "$have_libdl" = "yes"; then
> +  AC_CHECK_LIB([dl], [dlsym], [HAVE_LIBDL="yes"])
> +  if test "$HAVE_LIBDL" = "yes" ; then
> +    ALSA_DEPLIBS="$ALSA_DEPLIBS -ldl"
> +    AC_DEFINE([HAVE_LIBDL], 1, [Have libdl])
> +  fi
> +else
> +  AC_MSG_RESULT(no)
> +fi
> +AM_CONDITIONAL(BUILD_MODULES, test
> "$HAVE_LIBDL"="yes")
> +
> +dnl Check for pthread
> +AC_MSG_CHECKING(for pthread)
> +AC_ARG_WITH(pthread,
> +  [  --with-pthread      Use pthread (default =
> yes)],
> +  [ have_pthread="$withval" ], [ have_pthread="yes"
> ])
> +if test "$have_pthread" = "yes"; then
> +  AC_CHECK_LIB([pthread], [pthread_join],
> [HAVE_LIBPTHREAD="yes"])
> +  if test "$HAVE_LIBPTHREAD" = "yes"; then
> +    ALSA_DEPLIBS="$ALSA_DEPLIBS -lpthread"
> +    AC_DEFINE([HAVE_LIBPTHREAD], 1, [Have
> libpthread])
> +  fi
> +else
> +  AC_MSG_RESULT(no)
> +fi
> +
> +AC_SUBST(ALSA_DEPLIBS)
>  
>  dnl Check for architecture
>  AC_MSG_CHECKING(for architecture)
> @@ -318,6 +356,21 @@ fi
>  
>  if test "$build_pcm_ioplug" = "yes"; then
>    build_pcm_extplug="yes"
> +fi
> +
> +if test "$HAVE_LIBDL" != "yes"; then
> +  build_pcm_meter="no"
> +  build_pcm_ladspa="no"
> +  build_pcm_pcm_ioplug="no"
> +  build_pcm_pcm_extplug="no"
> +fi
> +
> +if test "$HAVE_LIBPTHREAD" != "yes"; then
> +  build_pcm_share="no"
> +fi
> +
> +if test "$softfloat" != "yes"; then
> +  build_pcm_lfloat="no"
>  fi
>  
>  AM_CONDITIONAL(BUILD_PCM_PLUGIN, test
> x$build_pcm_plugin = xyes)
> diff -r 6d0a999aef24 include/local.h
> --- a/include/local.h	Fri Mar 16 15:22:27 2007 +0100
> +++ b/include/local.h	Tue Mar 20 16:16:36 2007 +0100
> @@ -36,6 +36,11 @@
>  #include "config.h"
>  #ifdef SUPPORT_RESMGR
>  #include <resmgr.h>
> +#endif
> +#ifdef HAVE_LIBDL
> +#include <dlfcn.h>
> +#else
> +#define RTLD_NOW	0
>  #endif
>  
>  #define _snd_config_iterator list_head
> diff -r 6d0a999aef24 src/Makefile.am
> --- a/src/Makefile.am	Fri Mar 16 15:22:27 2007 +0100
> +++ b/src/Makefile.am	Tue Mar 20 16:16:36 2007 +0100
> @@ -41,7 +41,7 @@ libasound_la_LIBADD +=
> alisp/libalisp.la
>  libasound_la_LIBADD += alisp/libalisp.la
>  endif
>  SUBDIRS += compat conf
> -libasound_la_LIBADD += compat/libcompat.la -lm -ldl
> -lpthread
> +libasound_la_LIBADD += compat/libcompat.la
> @ALSA_DEPLIBS@
>  
>  libasound_la_LDFLAGS = -version-info $(COMPATNUM)
> $(VSYMS)
>  
> diff -r 6d0a999aef24 src/async.c
> --- a/src/async.c	Fri Mar 16 15:22:27 2007 +0100
> +++ b/src/async.c	Tue Mar 20 16:16:36 2007 +0100
> @@ -151,9 +151,11 @@ int
> snd_async_del_handler(snd_async_hand
>  	if (!list_empty(&handler->hlist))
>  		goto _end;
>  	switch (handler->type) {
> +#ifdef BUILD_PCM
>  	case SND_ASYNC_HANDLER_PCM:
>  		err = snd_pcm_async(handler->u.pcm, -1, 1);
>  		break;
> +#endif
>  	case SND_ASYNC_HANDLER_CTL:
>  		err = snd_ctl_async(handler->u.ctl, -1, 1);
>  		break;
> diff -r 6d0a999aef24 src/conf.c
> --- a/src/conf.c	Fri Mar 16 15:22:27 2007 +0100
> +++ b/src/conf.c	Tue Mar 20 16:16:36 2007 +0100
> @@ -415,12 +415,13 @@ beginning:</P>
> 
=== message truncated ===



 
____________________________________________________________________________________
Bored stiff? Loosen up... 
Download and play hundreds of games for free on Yahoo! Games.
http://games.yahoo.com/games/front
