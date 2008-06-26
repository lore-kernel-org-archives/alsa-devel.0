From: "Caloro Maurizio" <mauric@gmx.ch>
Subject: Re: Building trouble - redefinition of struct timeval
Date: Thu, 26 Jun 2008 10:40:32 +0200
Message-ID: <20080626084032.261430@gmx.net>
References: <20080625135409.236240@gmx.net> <s5hy74t7btp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 9AB00245E4
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 10:40:45 +0200 (CEST)
In-Reply-To: <s5hy74t7btp.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello Taksahi

Thanks wery mutch for your quick answer.... thats correct i dont have glibc=
 on me Netbsd =

machine so i have to cut any code from global.h .... after meny attempts i =
dont find the =

correct solutions

Please can you give me more informations about i need to comment out from c=
ode.

i have try with this to delete but the errors are after this mutch more.....

>#if !defined(_POSIX_C_SOURCE) && !defined(_POSIX_SOURCE)
>struct timeval {
>	time_t		tv_sec;		/* seconds */
>	long		tv_usec;	/* microseconds */
>};
>
>struct timespec {
>	time_t		tv_sec;		/* seconds */>
>	long		tv_nsec;	/* nanoseconds */
>};
>#endif
>
>/** Timestamp */
>typedef struct timeval snd_timestamp_t;
>/** Hi-res timestamp */
>typedef struct timespec snd_htimestamp_t;


-------- Original-Nachricht --------
> Datum: Wed, 25 Jun 2008 17:50:58 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: "Caloro Maurizio" <mauric@gmx.ch>
> CC: alsa-devel@alsa-project.org
> Betreff: Re: [alsa-devel] Building trouble - redefinition of struct timev=
al

> At Wed, 25 Jun 2008 15:54:09 +0200,
> Caloro Maurizio wrote:
> > =

> > =

> > Please i need help for following error message "redefinition of struct
> timeval - /include/global.h"
> > =

> > the configure script run without any Error, if i compile
> "alsa-lib-1.0.17rc2" on I386 Netbsd 4.0
> > i receive folowing error break.
> > =

> > "./configure --prefix=3D/usr --sysconfdir=3D/etc
> --build=3Di386-unknown-netbsdelf4.0 --host=3Di386-unknown-netbsdelf4.0 --=
target=3Di386-unknown-netbsdelf4.0
> --with-pythonlibs=3Dlpython2.5 --with-pythonincludes=3D-I/usr/include/pyt=
hon2.5
> --enable-shared=3Dno --enable-static=3Dyes" & gmake
> > =

> > gmake ... >
> > =

> > Making all in controll
> > gmake[1]: Entering directory
> `/usr/source/alsa-lib-1.0.17rc2/src/control'
> > if /bin/ksh ../../libtool --tag=3DCC --mode=3Dcompile gcc -DHAVE_CONFIG=
_H
> -I. -I. -I../../include -I../../include    -g -O2 -MT cards.lo -MD -MP -MF
> ".deps/cards.Tpo" -c -o cards.lo cards.c; \
> >         then mv -f ".deps/cards.Tpo" ".deps/cards.Plo"; else rm -f
> ".deps/cards.Tpo"; exit 1; fi
> >  gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -g -O2 -MT
> cards.lo -MD -MP -MF .deps/cards.Tpo -c cards.c -o cards.o
> > In file included from ../../include/local.h:109,
> >                  from control_local.h:22,
> >                  from cards.c:35:
> > ../../include/global.h:138: error: redefinition of 'struct timeval'
> > ../../include/global.h:143: error: redefinition of 'struct timespec'
> > gmake[1]: *** [cards.lo] Error 1
> > gmake[1]: Leaving directory `/usr/source/alsa-lib-1.0.17rc2/src/control'
> > gmake: *** [all-recursive] Error 1
> > =

> > =

> > i have see that this its a possible  handle with Posix_C_Source but i
> dont found =

> > the correct answer for me trouble.... Please for any Help i'am happy.
> =

> The code is written for glibc, and maybe yours doesn't fit with that
> part.  Simply comment out that part.
> =

> =

> Takashi




-- =

Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! =

Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
