From: owner@bugs.debian.org (Debian Bug Tracking System)
Subject: Bug#226538: marked as done (alsaconf expects lspci to
 be in /usr/bin not /sbin)
Date: Tue, 11 Sep 2007 20:21:09 +0000
Message-ID: <handler.226538.D226538.118954205122653.ackdone@bugs.debian.org>
References: <20070911202044.GA21118@frodo.home.lxtec.de>
	<E1Ae7x3-0005NN-00@master.debian.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1189542069-22802-0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 314FA2445E
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:32 +0200 (CEST)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id F2B042000067
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:31 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B14513F.dip.t-dialin.net [91.20.81.63])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 2B48616218480
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:31 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVYp4-0007dw-BW
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:30 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J-72RETzA8Of for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:24 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVYot-0007dH-6H
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:19 +0200
Resent-Message-ID: <20070912202818.GF4125@frodo.home.lxtec.de>
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
To: Elimar Riesebieter <riesebie@frodo.home.lxtec.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1189542069-22802-0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Your message dated Tue, 11 Sep 2007 22:20:44 +0200
with message-id <20070911202044.GA21118@frodo.home.lxtec.de>
and subject line alsaconf expects lspci to be in /usr/bin not /sbin
has caused the attached Bug report to be marked as done.

This means that you claim that the problem has been dealt with.
If this is not the case it is now your responsibility to reopen the
Bug report if necessary, and/or fix the problem forthwith.

(NB: If you are a system administrator and have no idea what I am
talking about this indicates a serious mail system misconfiguration
somewhere.  Please contact me immediately.)

Debian bug tracking system administrator
(administrator, Debian Bugs database)


------------=_1189542069-22802-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at submit) by bugs.debian.org; 7 Jan 2004 07:48:47 +0000
Return-path: <x11@h2o.pieva.net>
Received: from (rasnet.afraid.org) [81.7.84.36]
	by master.debian.org with esmtp (Exim 3.35 1 (Debian))
	id 1Ae7x3-0005NN-00; Wed, 07 Jan 2004 01:18:03 -0600
Received: from h2o.lan ([192.168.0.3] helo=[127.0.0.1])
	by rasnet.afraid.org with esmtp (Exim 4.30)
	id 1Ae7xH-0005SW-I5; Wed, 07 Jan 2004 09:18:15 +0200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Arturas Slajus <x11@h2o.pieva.net>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Subject: alsaconf expects lspci to be in /usr/bin not /sbin
Bcc: Arturas Slajus <x11@h2o.pieva.net>
X-Mailer: reportbug 2.37
Date: Wed, 07 Jan 2004 09:17:58 +0200
Message-Id: <E1Ae7x3-0005NN-00@master.debian.org>
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin
	2.60-master.debian.org_2003_11_25-bugs.debian.org_2004_1_5
	(1.212-2003-09-23-exp) on master.debian.org
X-Spam-Status: No, hits=-1.8 required=4.0 tests=FROM_ENDS_IN_NUMS,HAS_PACKAGE,
	OUR_MTA_MSGID autolearn=no
	version=2.60-master.debian.org_2003_11_25-bugs.debian.org_2004_1_5
X-Spam-Level: 

Package: alsaconf
Version: 0.9.8-3
Severity: important

This can be fixed by running `ln -s /sbin/lspci /usr/bin/lspci`. Should be
done on preinstall or fix package itself.

-- System Information:
Debian Release: 3.0
Architecture: i386
Kernel: Linux h2o 2.4.22-1-k7 #5 Sat Oct 4 14:11:12 EST 2003 i686
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8

Versions of packages alsaconf depends on:
ii  alsa-base                     0.9.8-3    ALSA sound driver common files
ii  alsa-utils                    0.9.8-1    Advanced Linux Sound Architecture 
ii  modutils                      2.4.26-1   Linux module utilities
ii  whiptail                      0.51.4-18  Displays user-friendly dialog boxe

-- no debconf information



------------=_1189542069-22802-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at 226538-done) by bugs.debian.org; 11 Sep 2007 20:20:51 +0000
X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02
	(2006-07-26) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=4.0 tests=BAYES_00,FORGED_RCVD_HELO
	autolearn=no version=3.1.4-bugs.debian.org_2005_01_02
Return-path: <riesebie@frodo.home.lxtec.de>
Received: from smtpout.hostsharing.net ([83.223.95.15])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IVCE7-0005t4-92; Tue, 11 Sep 2007 20:20:51 +0000
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id 226AA200004A;
	Tue, 11 Sep 2007 22:20:50 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B145E40.dip.t-dialin.net [91.20.94.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id E723B16214088;
	Tue, 11 Sep 2007 22:20:49 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVCE5-00077e-Av; Tue, 11 Sep 2007 22:20:49 +0200
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pW+fs-QcuUdB; Tue, 11 Sep 2007 22:20:44 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVCE0-00077I-SR; Tue, 11 Sep 2007 22:20:44 +0200
Received: from riesebie by frodo.home.lxtec.de with local (Exim 4.68 1 (LXTEC))
	id 1IVCE0-0005XO-Nn; Tue, 11 Sep 2007 22:20:44 +0200
Date: Tue, 11 Sep 2007 22:20:44 +0200
From: Elimar Riesebieter <riesebie@frodo.home.lxtec.de>
To: 226538@bugs.debian.org
Cc: 226538-done@bugs.debian.org
Subject: alsaconf expects lspci to be in /usr/bin not /sbin
Message-ID: <20070911202044.GA21118@frodo.home.lxtec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.16+lxtec (2007-09-05)


Done since ages ;)

Elimar



-- 
  Never make anything simple and efficient when a way 
  can be found to make it complex and wonderful ;-)


------------=_1189542069-22802-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------------=_1189542069-22802-0--
