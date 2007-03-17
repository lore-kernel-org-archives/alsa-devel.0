From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: Static build of alsa-lib
Date: Sat, 17 Mar 2007 03:13:06 -0700 (PDT)
Message-ID: <879835.22038.qm@web31007.mail.mud.yahoo.com>
References: <s5h3b45w9ur.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h3b45w9ur.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
I downloaded the last snapshot from hg
(alsa-lib-hg20070317) and I applied the patch you
included in your email. Then I configured alsa-lib as
following:

./configure --enable-static --disable-shared
--disable-mixer --disable-hwdep --disable-rawmidi
--disable-seq --disable-instr --disable-alisp
-with-pcm-plugins=no


I just need PCM, so I disable all the packages but
PCM. Then I compiled my mini application (just
snd_pcm_open, configure it and write some data to it)
with the following command-line (I'm using gcc 4.1):

$ gcc -o test test.c
-L/tmp/alsa-lib-hg20070317/src/.libs/ -lasound -lm
-lpthread -static
          
and I got the following errors/warnings:

/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(control_shm.o):
In function `_snd_ctl_shm_open':
/tmp/alsa-lib-hg20070317/src/control/control_shm.c:664:
warning: Using 'gethostbyname' in statically linked
applications requires at runtime the shared libraries
from the glibc version used for linking
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
In function `snd_dlsym_verify':
/tmp/alsa-lib-hg20070317/src/dlmisc.c:115: undefined
reference to `dlsym'
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
In function `snd_dlsym':
/tmp/alsa-lib-hg20070317/src/dlmisc.c:159: undefined
reference to `dlsym'
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
In function `snd_dlclose':
/tmp/alsa-lib-hg20070317/src/dlmisc.c:85: undefined
reference to `dlclose'
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
In function `snd_dlopen':
/tmp/alsa-lib-hg20070317/src/dlmisc.c:64: undefined
reference to `dlopen'
collect2: ld returned 1 exit status
                                      
Am I doing something wrong?!?

Thanks
Bye
Andrea

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 16 Mar 2007 06:17:00 -0700 (PDT),
> Ciaccia wrote:
> > 
> > Hi there,
> > I would like to compile an alsa application for an
> > embedded system with no shared-libraries support.
> My
> > application just needs PCM, with no plug-ins, no
> mixer
> > and no midi and the application should be a
> standalone
> > executable with no external dependencies,
> otherwise it
> > will not work.
> > 
> > I tried to compile alsa-lib with static support,
> but
> > without luck (-ldl is always needed in the gcc
> line
> > and gcc always prints some weird warnings). Since
> I
> > don't need external plugins nor ladspa, I think
> there
> > should be a way to compile an application in a
> 100%
> > static manner, but I still have to figure out how.
> > 
> > I also found this thread with a similar problem
> with
> > uClinux
> >
>
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg18253.html
> > but at the end I did not understand how/if the
> problem
> > was solved.
> > 
> > Do you think it should be possible to compile
> alsa-lib
> > with no dependencies on dl? How?
> > 
> > Otherwise, would it be possible to write an alsa
> > application that does not rely on alsa-lib (i.e.,
> > by using the alsa kernel APIs directly)? Has
> someone
> > already tried it? Some hints?
> > 
> > Every hint is extremely welcome
> 
> I worked on this sometime ago, and made a patch to
> build alsa-lib
> without pthread and libdl.  I don't remember why
> this wasn't applied.
> IIRC, ulibc has the wrappers for pthread and libdl,
> so this wasn't
> needed at that time in the end.
> 
> Otherwise, it should work.  Build with
> --enable-static
> --disable-shared, --disble-mixer, --disable-hwdep,
> etc.
> 
> 
> Takashi
> 
> diff -r f1203eb7eb48 configure.in
> --- a/configure.in	Tue Mar 13 10:44:28 2007 +0100
> +++ b/configure.in	Fri Mar 16 15:07:51 2007 +0100
> @@ -148,6 +148,23 @@ else
>  else
>    AC_MSG_RESULT(no)
>  fi
> +
> +AC_CHECK_LIB([dl], [dlsym], [HAVE_LIBDL="yes"])
> +AC_CHECK_LIB([pthread], [pthread_join],
> [HAVE_LIBPTHREAD="yes"])
> +
> +ALSA_DEPLIBS=""
> +if test "$softfloat" != "yes"; then
> +  ALSA_DEPLIBS="-lm"
> +fi
> +if test "$HAVE_LIBDL" = "yes"; then
> +  ALSA_DEPLIBS="$ALSA_DEPLIBS -ldl"
> +  AC_DEFINE([HAVE_LIBDL], 1, [Have libdl])
> +fi
> +if test "$HAVE_LIBPTHREAD" = "yes"; then
> +  ALSA_DEPLIBS="$ALSA_DEPLIBS -lpthread"
> +  AC_DEFINE([HAVE_LIBPTHREAD], 1, [Have
> libpthread])
> +fi
> +AC_SUBST(ALSA_DEPLIBS)
>  
>  dnl Check for architecture
>  AC_MSG_CHECKING(for architecture)
> diff -r f1203eb7eb48 include/local.h
> --- a/include/local.h	Tue Mar 13 10:44:28 2007 +0100
> +++ b/include/local.h	Fri Mar 16 15:07:51 2007 +0100
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
> diff -r f1203eb7eb48 src/Makefile.am
> --- a/src/Makefile.am	Tue Mar 13 10:44:28 2007 +0100
> +++ b/src/Makefile.am	Fri Mar 16 15:07:51 2007 +0100
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
> diff -r f1203eb7eb48 src/async.c
> --- a/src/async.c	Tue Mar 13 10:44:28 2007 +0100
> +++ b/src/async.c	Fri Mar 16 15:07:51 2007 +0100
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
> diff -r f1203eb7eb48 src/conf.c
> --- a/src/conf.c	Tue Mar 13 10:44:28 2007 +0100
> +++ b/src/conf.c	Fri Mar 16 15:07:51 2007 +0100
> @@ -415,12 +415,13 @@ beginning:</P>
>  
>  
>  #include <stdarg.h>
> -#include <dlfcn.h>
>  #include <limits.h>
>  #include <sys/stat.h>
> -#include <pthread.h>
>  #include <locale.h>
>  #include "local.h"
> +#ifdef HAVE_LIBPTHREAD
> +#include <pthread.h>
> +#endif
>  
>  #ifndef DOC_HIDDEN
>  
> @@ -3080,7 +3081,9 @@ int
> snd_config_update_r(snd_config_t **_
>  	return 1;
>  }
>  
> +#ifdef HAVE_LIBPTHREAD
>  static pthread_mutex_t snd_config_update_mutex =
> PTHREAD_MUTEX_INITIALIZER;
> +#endif
>  
>  /** 
>   * \brief Updates #snd_config by rereading the
> global configuration files (if needed).
> @@ -3099,9 +3102,13 @@ int snd_config_update(void)
>  {
>  	int err;
>  
> +#ifdef HAVE_LIBPTHREAD
>  	pthread_mutex_lock(&snd_config_update_mutex);
> +#endif
>  	err = snd_config_update_r(&snd_config,
> &snd_config_global_update, NULL);
> +#ifdef HAVE_LIBPTHREAD
>  	pthread_mutex_unlock(&snd_config_update_mutex);
> +#endif
>  	return err;
>  }
>  
> @@ -3128,15 +3135,18 @@ int
> snd_config_update_free(snd_config_up
>   */
>  int snd_config_update_free_global(void)
>  {
> +#ifdef HAVE_LIBPTHREAD
>  	pthread_mutex_lock(&snd_config_update_mutex);
> +#endif
>  	if (snd_config)
>  		snd_config_delete(snd_config);
>  	snd_config = NULL;
>  	if (snd_config_global_update)
>  		snd_config_update_free(snd_config_global_update);
>  	snd_config_global_update = NULL;
> 
=== message truncated ===



 
____________________________________________________________________________________
Bored stiff? Loosen up... 
Download and play hundreds of games for free on Yahoo! Games.
http://games.yahoo.com/games/front

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
