From: owner@bugs.debian.org (Debian Bug Tracking System)
Subject: Bug#407690: marked as done (ld10k1 segfaults on 2.6.19
	kernel)
Date: Tue, 11 Sep 2007 20:06:03 +0000
Message-ID: <handler.407690.D407690.118954108415687.ackdone@bugs.debian.org>
References: <20070911200437.GS17585@frodo.home.lxtec.de>
	<20070120144825.28798.9415.reportbug@nias.19.ros.03046.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1189541163-16718-0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 759CD24454
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:26 +0200 (CEST)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id D55AC200009D
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:25 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B14513F.dip.t-dialin.net [91.20.81.63])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 426E716214061
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:25 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVYoy-0007da-J4
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:24 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EUTwg3yeBHcE for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:18 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVYos-0007d5-QN
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:18 +0200
Resent-Message-ID: <20070912202818.GD4125@frodo.home.lxtec.de>
Resent-To: alsa-devel <alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1189541163-16718-0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Your message dated Tue, 11 Sep 2007 22:04:37 +0200
with message-id <20070911200437.GS17585@frodo.home.lxtec.de>
and subject line Bug#407690: [Pkg-alsa-devel] Bug#407690: kernel 2.6.19.2 i=
ncompatibel with debian libasound2-dev
has caused the attached Bug report to be marked as done.

This means that you claim that the problem has been dealt with.
If this is not the case it is now your responsibility to reopen the
Bug report if necessary, and/or fix the problem forthwith.

(NB: If you are a system administrator and have no idea what I am
talking about this indicates a serious mail system misconfiguration
somewhere.  Please contact me immediately.)

Debian bug tracking system administrator
(administrator, Debian Bugs database)


------------=_1189541163-16718-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at submit) by bugs.debian.org; 20 Jan 2007 14:48:52 +0000
Return-path: <msc@antzsystem.de>
Received: from mail.tastatur-junkie.de ([213.239.206.74])
	by spohr.debian.org with esmtp (Exim 4.50)
	id 1H8HWW-0005uA-Dr
	for submit@bugs.debian.org; Sat, 20 Jan 2007 06:48:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by mail.tastatur-junkie.de (Postfix) with ESMTP id 9590B190A248A;
	Sat, 20 Jan 2007 15:48:37 +0100 (CET)
Received: from mail.tastatur-junkie.de ([127.0.0.1])
	by localhost (mail.tastatur-junkie.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17352-06; Sat, 20 Jan 2007 15:48:28 +0100 (CET)
Received: from nias.19.ros.03046.com (dslb-088-072-205-187.pools.arcor-ip.net [88.72.205.187])
	by mail.tastatur-junkie.de (Postfix) with ESMTP id E1763190A248B;
	Sat, 20 Jan 2007 15:48:27 +0100 (CET)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Markus Schulz <msc@antzsystem.de>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: segfault on starting ld10k1
Message-ID: <20070120144825.28798.9415.reportbug@nias.19.ros.03046.com>
X-Mailer: reportbug 3.33
Date: Sat, 20 Jan 2007 15:48:25 +0100
X-Virus-Scanned: by AMAVIS (Debian) at tastatur-junkie.de
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on spohr.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-8.0 required=4.0 tests=BAYES_00,HAS_PACKAGE
	autolearn=no version=2.60-bugs.debian.org_2005_01_02

Package: ld10k1
Version: 1.0.13-1
Severity: grave
Justification: renders package unusable

segfaults at startup

if compiled source-package version and generated a backtrace.

(gdb) bt
#0  0xb7ef9410 in ?? ()
#1  0xbf92f5fc in ?? ()
#2  0x00000006 in ?? ()
#3  0x00006fdc in ?? ()
#4  0xb7cd69d1 in raise () from /lib/tls/i686/cmov/libc.so.6
#5  0xb7cd8219 in abort () from /lib/tls/i686/cmov/libc.so.6
#6  0xb7d0c88a in __fsetlocking () from /lib/tls/i686/cmov/libc.so.6
#7  0xb7d141df in mallopt () from /lib/tls/i686/cmov/libc.so.6
#8  0xb7d14282 in free () from /lib/tls/i686/cmov/libc.so.6
#9  0x08052264 in ld10k1_init_driver (dsp_mgr=0x8056dc0, tram_size=0) at
ld10k1_driver.c:414
#10 0x0805037c in main_loop (param=0xbf9307b8, audigy=0,
    card_id=0xbf9304d8 "Live",
        tram_size=0, ctlp=0x8066260) at ld10k1_fnc1.c:202
#11 0x08049e6e in main (argc=1, argv=0xbf930884) at ld10k1.c:333



-- System Information:
Debian Release: 4.0
  APT prefers unstable
  APT policy: (990, 'unstable'), (1, 'experimental')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.19.2-nias
Locale: LANG=de_DE.UTF-8, LC_CTYPE=de_DE.UTF-8 (charmap=UTF-8)

Versions of packages ld10k1 depends on:
ii  libasound2                  1.0.13-1     ALSA library
ii  libc6                       2.3.6.ds1-10 GNU C Library: Shared libraries
ii  liblo10k1-0                 1.0.13-1     ALSA emu10k1/2 patch-loader librar
ii  lsb-base                    3.1-22       Linux Standard Base 3.1 init scrip

ld10k1 recommends no packages.

-- no debconf information


------------=_1189541163-16718-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at 407690-done) by bugs.debian.org; 11 Sep 2007 20:04:44 +0000
X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02
	(2006-07-26) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=BAYES_00,FORGED_RCVD_HELO,
	HAS_BUG_NUMBER,IMPRONONCABLE_2,MURPHY_DRUGS_REL8 autolearn=no
	version=3.1.4-bugs.debian.org_2005_01_02
Return-path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net ([83.223.95.15])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IVByW-00044T-8m; Tue, 11 Sep 2007 20:04:44 +0000
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 6A41520001E9;
	Tue, 11 Sep 2007 22:04:42 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B145E40.dip.t-dialin.net [91.20.94.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 2E5771621406E;
	Tue, 11 Sep 2007 22:04:42 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVByT-0006vG-BD; Tue, 11 Sep 2007 22:04:41 +0200
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikpegmjFhxWq; Tue, 11 Sep 2007 22:04:37 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVByP-0006v5-Iu; Tue, 11 Sep 2007 22:04:37 +0200
Received: from riesebie by frodo.home.lxtec.de with local (Exim 4.68 1 (LXTEC))
	id 1IVByP-0004oa-F3; Tue, 11 Sep 2007 22:04:37 +0200
Date: Tue, 11 Sep 2007 22:04:37 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Markus Schulz <msc@antzsystem.de>
Cc: Mikael Magnusson <mikma@users.sourceforge.net>,
	407690@bugs.debian.org, 407690-done@bugs.debian.org
Subject: Re: Bug#407690: [Pkg-alsa-devel] Bug#407690: kernel 2.6.19.2
	incompatibel with debian libasound2-dev
Message-ID: <20070911200437.GS17585@frodo.home.lxtec.de>
References: <200701210058.31546@Mail-Followup-To> <200701222258.50287@Mail-Followup-To> <20070122222058.GA15343@frodo.home.lxtec.de> <200701231948.55929@Mail-Followup-To>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <200701231948.55929@Mail-Followup-To>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
X-Editor: VIM - Vi IMproved 7.1 (2007 May 12, compiled Sep  2 2007 20:07:10)
User-Agent: Mutt/1.5.16+lxtec (2007-09-05)


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jan 2007 the mental interface of
Markus Schulz told:

> Am Montag, 22. Januar 2007 23:20 schrieb Elimar Riesebieter:
> > On Mon, 22 Jan 2007 the mental interface of
> >
> > Markus Schulz told:
> > > Am Montag, 22. Januar 2007 22:34 schrieb Elimar Riesebieter:
> > > [..wrong patch..]
> > >
> > > > No, thats me ;)
> > >
> > > ok, i will try with new kernel build soon.
>=20
> works fine with original debian ld10k1 packages and patched=20
> alsa-drivers, thanks.

Forgot to close this. Included in 1.0.14 and should work fine now.

Elimar


--=20
  You cannot propel yourself forward by
  patting yourself on the back.

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG5vTV3Ig8bsVPf7ARAmBCAJ96P+K7SHpxH2niHjCs1i5Iz+hbRQCgho1h
kMCmHvAD7Ek2b8YsXYIVJMM=
=G2ym
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--


------------=_1189541163-16718-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------------=_1189541163-16718-0--
