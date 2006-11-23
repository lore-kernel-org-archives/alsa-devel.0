From: owner@bugs.debian.org (Debian Bug Tracking System)
Subject: Bug#399342: marked as done (alsa-base: no (or
 horrible) sound with Ali M5455 AC'97)
Date: Thu, 23 Nov 2006 14:03:38 -0800
Message-ID: <handler.399342.D399342.116431907714591.ackdone@bugs.debian.org>
References: <20061123215742.GA26934@frodo.home.lxtec.de>
	<20061119113805.4186.27741.reportbug@Estello>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1164319418-21084-0"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Resent-Message-ID: <20061125124256.GB3957@frodo.home.lxtec.de>
Resent-To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Elimar Riesebieter <riesebie@lxtec.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1164319418-21084-0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Your message dated Thu, 23 Nov 2006 22:57:43 +0100
with message-id <20061123215742.GA26934@frodo.home.lxtec.de>
and subject line Bug#399342: [Pkg-alsa-devel] Bug#399342: alsa-base: no (or=
 horrible) sound with Ali M5455 AC'97
has caused the attached Bug report to be marked as done.

This means that you claim that the problem has been dealt with.
If this is not the case it is now your responsibility to reopen the
Bug report if necessary, and/or fix the problem forthwith.

(NB: If you are a system administrator and have no idea what I am
talking about this indicates a serious mail system misconfiguration
somewhere.  Please contact me immediately.)

Debian bug tracking system administrator
(administrator, Debian Bugs database)


------------=_1164319418-21084-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at submit) by bugs.debian.org; 19 Nov 2006 11:42:26 +0000
Return-path: <alexandre.pineau@free.fr>
Received: from smtp6-g19.free.fr ([212.27.42.36])
	by spohr.debian.org with esmtp (Exim 4.50) id 1GlkzQ-0001Ck-UM
	for submit@bugs.debian.org; Sun, 19 Nov 2006 03:37:37 -0800
Received: from Estello (nas-cbv-7-62-147-100-144.dial.proxad.net
	[62.147.100.144])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 0A70B435E7
	for <submit@bugs.debian.org>; Sun, 19 Nov 2006 12:37:34 +0100 (CET)
Received: by Estello (Postfix, from userid 1000)
	id AC14B7E515; Sun, 19 Nov 2006 12:38:05 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
From: Alexandre Pineau <alexandre.pineau@free.fr>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: alsa-base: no (or horrible) sound with Ali M5455 AC'97
Message-ID: <20061119113805.4186.27741.reportbug@Estello>
X-Mailer: reportbug 3.31
Date: Sun, 19 Nov 2006 12:38:05 +0100
Content-Transfer-Encoding: quoted-printable
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-7.0 required=4.0 tests=BAYES_00,HAS_PACKAGE,
	RCVD_IN_SORBS autolearn=no version=2.60-bugs.debian.org_2005_01_02

Package: alsa-base
Version: 1.0.13-1
Severity: grave
Justification: renders package unusable

After an upgrade to the last version of alsa / kernel, I have no sound=20
(or more exactly horrible sound after the use of alsa-config).

result of lspci :
00:04.0 Multimedia audio controller: ALi Corporation M5455 PCI AC-Link=20
Controller Audio Device (rev 20)

result of dsmeg :
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
Unable to initialize codec #1
intel8x0_measure_ac97_clock: measured 54888 usecs
intel8x0: clocking to 48000

result of lsmod | grep snd
snd_intel8x0           29596  0
snd_ac97_codec         82336  1 snd_intel8x0
snd_ac97_bus            2304  1 snd_ac97_codec
snd_pcm_oss            35616  0
snd_mixer_oss          15616  1 snd_pcm_oss
snd_pcm                71432  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              19716  1 snd_pcm
snd                    45668  6=20
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               8800  1 snd
snd_page_alloc          9480  2 snd_intel8x0,snd_pcm

Many thanks for your help.

	Best regards,

Alexandre Pineau

(The sound works perfectly before the upgrade, that's why I have choose=20
to say that it is a grave bug. You can lower the severity if you want)

-- Package-specific info:
--- Begin additional package status ---
Souhait=3DinconnU/Install=C3=A9/suppRim=C3=A9/Purg=C3=A9/H=3D=C3=A0 garde=
r
| =C3=89tat=3DNon/Install=C3=A9/fichier-Config/d=C3=A9paqUet=C3=A9/=C3=A9=
chec-conFig/H=3Dsemi-install=C3=A9
|/ Err?=3D(aucune)/H=3D=C3=A0 garder/besoin R=C3=A9installation/X=3Dles d=
eux (=C3=89tat,Err: majuscule=3Dmauvais)
||/ Nom            Version        Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  libasound2     1.0.13-1       ALSA library
--- End additional package status ---
--- Begin /proc/asound/version ---
Advanced Linux Sound Architecture Driver Version 1.0.11rc4 (Wed Mar 22 10=
:27:24 2006 UTC).
--- End /proc/asound/version ---
--- Begin /proc/asound/cards ---
 0 [M5455          ]: ICH - ALi M5455
                      ALi M5455 with ALC850 at 0x0, irq 217
--- End /proc/asound/cards ---
--- Begin /dev/snd/ listing ---
total 0
crw-rw---- 1 root audio 116,  0 2006-11-19 11:32 controlC0
crw-rw---- 1 root audio 116, 24 2006-11-19 11:32 pcmC0D0c
crw-rw---- 1 root audio 116, 16 2006-11-19 11:32 pcmC0D0p
crw-rw---- 1 root audio 116, 25 2006-11-19 11:32 pcmC0D1c
crw-rw---- 1 root audio 116, 18 2006-11-19 11:32 pcmC0D2p
crw-rw---- 1 root audio 116, 33 2006-11-19 11:32 timer
--- End /dev/snd/ listing ---

-- System Information:
Debian Release: testing/unstable
  APT prefers testing
  APT policy: (500, 'testing')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.17-2-486
Locale: LANG=3Dfr_FR.UTF-8, LC_CTYPE=3Dfr_FR.UTF-8 (charmap=3DUTF-8)

Versions of packages alsa-base depends on:
ii  linux-sound-base           1.0.13-1      base package for ALSA and OS=
S soun
ii  lsof                       4.77.dfsg.1-3 List open files
ii  module-init-tools          3.2.2-3       tools for managing Linux ker=
nel mo
ii  modutils                   2.4.27.0-6    Linux module utilities

Versions of packages alsa-base recommends:
ii  alsa-utils                    1.0.13-1   ALSA utilities

Versions of packages libasound2 depends on:
ii  libc6                        2.3.6.ds1-4 GNU C Library: Shared librar=
ies

-- no debconf information


------------=_1164319418-21084-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at 399342-done) by bugs.debian.org; 23 Nov 2006 21:57:57 +0000
Return-path: <riesebie@lxtec.de>
Received: from h01.hostsharing.net ([212.42.230.152])
	by spohr.debian.org with esmtp (Exim 4.50)
	id 1GnMZx-0003mb-1b; Thu, 23 Nov 2006 13:57:57 -0800
Received: from mail.home.lxtec.de (p3EE06416.dip.t-dialin.net [62.224.100.22])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 30531161B88FE;
	Thu, 23 Nov 2006 22:57:54 +0100 (CET)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.63 1 (LXTEC))
	id 1GnMZt-00007T-4w; Thu, 23 Nov 2006 22:57:53 +0100
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZESSAIrA3Id9; Thu, 23 Nov 2006 22:57:43 +0100 (CET)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.63 1 (LXTEC))
	id 1GnMZj-00007K-Oe; Thu, 23 Nov 2006 22:57:43 +0100
Received: from riesebie by frodo.home.lxtec.de with local (Exim 4.63 1 (LXTEC))
	id 1GnMZj-0007jP-80; Thu, 23 Nov 2006 22:57:43 +0100
Date: Thu, 23 Nov 2006 22:57:43 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: 399342-submitter@bugs.debian.org
Cc: 399342-done@bugs.debian.org
Subject: Re: Bug#399342: [Pkg-alsa-devel] Bug#399342: alsa-base: no (or
	horrible) sound with Ali M5455 AC'97
Message-ID: <20061123215742.GA26934@frodo.home.lxtec.de>
References: <20061119113805.4186.27741.reportbug@Estello>
	<20061122185007.GB4758@frodo.home.lxtec.de>
	<20061123223147.5e3ee0c1.alexandre.pineau.p@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123223147.5e3ee0c1.alexandre.pineau.p@free.fr>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
X-Editor: VIM - Vi IMproved 7.0 (2006 May 7, compiled Nov 15 2006 16:11:06)
User-Agent: Mutt/1.5.13-muttng (2006-11-15)
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-3.5 required=4.0 tests=BAYES_10,HAS_BUG_NUMBER,
	RCVD_IN_SORBS autolearn=no version=2.60-bugs.debian.org_2005_01_02

On Thu, 23 Nov 2006 the mental interface of
Alexandre Pineau told:

> On Wed, 22 Nov 2006 19:50:07 +0100
> Elimar Riesebieter <riesebie@lxtec.de> wrote:
> 
> > > After an upgrade to the last version of alsa / kernel, I have no sound 
> > > (or more exactly horrible sound after the use of alsa-config).
> > > 
> [...]
> > Should be the right drivers for your card. Anyway, did you upgraded
> > to Version: 1.0.13-2?
> 
> Well, there is no problem in alsa, but I have a problem of sound with my package...
> I'm sorry for the disturb. You can close this bug report!

THX, done ;)

Elimar


-- 
  Alles was viel bedacht wird ist bedenklich!;-)
         Friedrich Nietzsche

------------=_1164319418-21084-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------------=_1164319418-21084-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------------=_1164319418-21084-0--
