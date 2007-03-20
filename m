From: Ciaccia <ciacciax@yahoo.com>
Subject: Re: Static build of alsa-lib
Date: Tue, 20 Mar 2007 08:13:41 -0700 (PDT)
Message-ID: <863949.37973.qm@web31010.mail.mud.yahoo.com>
References: <s5hircwdwbo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hircwdwbo.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,
It's clear that the concept of dynamic loading doesn't
conflict with static library, I think my original
question was not completely clear. 

I would like to port a sound application (just PCM, no
midi or other stuff) to an embedded system. The core
of this embedded system is a Cirrus EP9302 ARM
processor, which supports hardware floating points.

ARM processors have several ABIs (EABI, OABI, ???) and
programs compiled using one ABI are not linkable
(neither at compile time, nor at run time) with other
binaries, because of the different format. This is a
problem for binary distributions (such as Debian),
since the same binary does not work on all ARM
architectures.

For a reason I really don't understand, EP9302
hardware floating point binaries only work when
compiled with -static (don't ask me why...), and
therefore I wanted to have a "static" (=without shared
libraries) ALSA application. If this would not be
possible I can always use OSS (which does not requires
shared objects to be loaded at run time), but I still
think it should be possible to develop ALSA
applications for architectures where dynamic loading
is not available...

Is there a way to achieve this?

Thanks again
Andrea

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Sat, 17 Mar 2007 03:13:06 -0700 (PDT),
> Ciaccia wrote:
> > 
> > Hi Takashi,
> > I downloaded the last snapshot from hg
> > (alsa-lib-hg20070317) and I applied the patch you
> > included in your email. Then I configured alsa-lib
> as
> > following:
> > 
> > ./configure --enable-static --disable-shared
> > --disable-mixer --disable-hwdep --disable-rawmidi
> > --disable-seq --disable-instr --disable-alisp
> > -with-pcm-plugins=no
> > 
> > 
> > I just need PCM, so I disable all the packages but
> > PCM. Then I compiled my mini application (just
> > snd_pcm_open, configure it and write some data to
> it)
> > with the following command-line (I'm using gcc
> 4.1):
> > 
> > $ gcc -o test test.c
> > -L/tmp/alsa-lib-hg20070317/src/.libs/ -lasound -lm
> > -lpthread -static
> >           
> > and I got the following errors/warnings:
> > 
> >
>
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(control_shm.o):
> > In function `_snd_ctl_shm_open':
> >
>
/tmp/alsa-lib-hg20070317/src/control/control_shm.c:664:
> > warning: Using 'gethostbyname' in statically
> linked
> > applications requires at runtime the shared
> libraries
> > from the glibc version used for linking
> >
>
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
> > In function `snd_dlsym_verify':
> > /tmp/alsa-lib-hg20070317/src/dlmisc.c:115:
> undefined
> > reference to `dlsym'
> >
>
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
> > In function `snd_dlsym':
> > /tmp/alsa-lib-hg20070317/src/dlmisc.c:159:
> undefined
> > reference to `dlsym'
> >
>
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
> > In function `snd_dlclose':
> > /tmp/alsa-lib-hg20070317/src/dlmisc.c:85:
> undefined
> > reference to `dlclose'
> >
>
/tmp/alsa-lib-hg20070317/src/.libs//libasound.a(dlmisc.o):
> > In function `snd_dlopen':
> > /tmp/alsa-lib-hg20070317/src/dlmisc.c:64:
> undefined
> > reference to `dlopen'
> > collect2: ld returned 1 exit status
> >                                       
> > Am I doing something wrong?!?
> 
> No.  But, as you find in my patch, the configure
> checks whether libdl
> and pthread are available and doesn't provide the
> flag to disable
> them.  That's why these functions are still there.
> 
> Note that the concept of dynamic loading doesn't
> conflict with static
> library.  So, unconditionally disabling libdl with a
> static lib is a
> bad idea.  Rather we can add options to disable
> libdl and libpthread,
> not only detecting them.
> 
> 
> Takashi
> 
> > 
> > Thanks
> > Bye
> > Andrea
> > 
> > --- Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Fri, 16 Mar 2007 06:17:00 -0700 (PDT),
> > > Ciaccia wrote:
> > > > 
> > > > Hi there,
> > > > I would like to compile an alsa application
> for an
> > > > embedded system with no shared-libraries
> support.
> > > My
> > > > application just needs PCM, with no plug-ins,
> no
> > > mixer
> > > > and no midi and the application should be a
> > > standalone
> > > > executable with no external dependencies,
> > > otherwise it
> > > > will not work.
> > > > 
> > > > I tried to compile alsa-lib with static
> support,
> > > but
> > > > without luck (-ldl is always needed in the gcc
> > > line
> > > > and gcc always prints some weird warnings).
> Since
> > > I
> > > > don't need external plugins nor ladspa, I
> think
> > > there
> > > > should be a way to compile an application in a
> > > 100%
> > > > static manner, but I still have to figure out
> how.
> > > > 
> > > > I also found this thread with a similar
> problem
> > > with
> > > > uClinux
> > > >
> > >
> >
>
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg18253.html
> > > > but at the end I did not understand how/if the
> > > problem
> > > > was solved.
> > > > 
> > > > Do you think it should be possible to compile
> > > alsa-lib
> > > > with no dependencies on dl? How?
> > > > 
> > > > Otherwise, would it be possible to write an
> alsa
> > > > application that does not rely on alsa-lib
> (i.e.,
> > > > by using the alsa kernel APIs directly)? Has
> > > someone
> > > > already tried it? Some hints?
> > > > 
> > > > Every hint is extremely welcome
> > > 
> > > I worked on this sometime ago, and made a patch
> to
> > > build alsa-lib
> > > without pthread and libdl.  I don't remember why
> > > this wasn't applied.
> > > IIRC, ulibc has the wrappers for pthread and
> libdl,
> > > so this wasn't
> > > needed at that time in the end.
> > > 
> > > Otherwise, it should work.  Build with
> > > --enable-static
> > > --disable-shared, --disble-mixer,
> --disable-hwdep,
> > > etc.
> > > 
> > > 
> > > Takashi
> > > 
> > > diff -r f1203eb7eb48 configure.in
> > > --- a/configure.in	Tue Mar 13 10:44:28 2007
> +0100
> > > +++ b/configure.in	Fri Mar 16 15:07:51 2007
> +0100
> > > @@ -148,6 +148,23 @@ else
> > >  else
> > >    AC_MSG_RESULT(no)
> > >  fi
> > > +
> > > +AC_CHECK_LIB([dl], [dlsym], [HAVE_LIBDL="yes"])
> > > +AC_CHECK_LIB([pthread], [pthread_join],
> > > [HAVE_LIBPTHREAD="yes"])
> > > +
> > > +ALSA_DEPLIBS=""
> > > +if test "$softfloat" != "yes"; then
> > > +  ALSA_DEPLIBS="-lm"
> > > +fi
> > > +if test "$HAVE_LIBDL" = "yes"; then
> > > +  ALSA_DEPLIBS="$ALSA_DEPLIBS -ldl"
> > > +  AC_DEFINE([HAVE_LIBDL], 1, [Have libdl])
> > > +fi
> > > +if test "$HAVE_LIBPTHREAD" = "yes"; then
> > > +  ALSA_DEPLIBS="$ALSA_DEPLIBS -lpthread"
> > > +  AC_DEFINE([HAVE_LIBPTHREAD], 1, [Have
> > > libpthread])
> > > +fi
> > > +AC_SUBST(ALSA_DEPLIBS)
> > >  
> > >  dnl Check for architecture
> > >  AC_MSG_CHECKING(for architecture)
> 
=== message truncated ===



 
____________________________________________________________________________________
Don't get soaked.  Take a quick peek at the forecast
with the Yahoo! Search weather shortcut.
http://tools.search.yahoo.com/shortcuts/#loc_weather

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
