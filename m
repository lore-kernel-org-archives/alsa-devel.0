From: Chris Pemberton <cjpembo.mailing.lists@gmail.com>
Subject: Re: Request for test (1.0.18 final)
Date: Mon, 27 Oct 2008 12:14:19 -0500
Message-ID: <4905F6EB.8080507@gmail.com>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 3851A24157
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 18:14:37 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id c38so608756wra.24
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:14:36 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> Hello,
>
> 	I would like to release 1.0.18 final packages (driver, lib, =

> utils, tools, plugins) in few days. Please, report compilation trouble =

> with the current ALSA code.
>
> Links are for the current ALSA tarballs:
>
> http://www.alsa-project.org/snapshot/?package=3Dalsa-driver
> http://www.alsa-project.org/snapshot/?package=3Dalsa-lib
> http://www.alsa-project.org/snapshot/?package=3Dalsa-utils
> http://www.alsa-project.org/snapshot/?package=3Dalsa-tools
> http://www.alsa-project.org/snapshot/?package=3Dalsa-plugins
>
> 			Thank you for testing,
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   =

I hit the following error compiling the alsa-lib package on an =

up-to-date 64-bit ArchLinux, kernel 2.6.27:

...
...
CC [M] =

/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/s=
ound_oss.o
CC [M] =

/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/i=
nfo_oss.o
CC [M] =

/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/v=
master.o
CC [M] =

/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/j=
ack.o
In file included from =

/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/j=
ack.c:3:
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c: =

In function =91snd_jack_new=92:
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c:108: =

error: =91SW_LINEOUT_INSERT=92 undeclared (first use in this function)
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c:108: =

error: (Each undeclared identifier is reported only once
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c:108: =

error: for each function it appears in.)
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c: =

In function =91snd_jack_report=92:
/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/.=
./alsa-kernel/core/jack.c:161: =

error: =91SW_LINEOUT_INSERT=92 undeclared (first use in this function)
make[3]: *** =

[/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore/=
jack.o] =

Error 1
make[2]: *** =

[/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c1/acore] =

Error 2
make[1]: *** =

[_module_/home/cjpembo/LatestALSA/alsa-driver-1.0.18rc3.17.gd338c.191.ge29c=
1] =

Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.27-ARCH'
make: *** [compile] Error 2


Chris
