From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: [bunk@debian.org] Bug#916052: alsa-oss FTBFS with
	glibc 2.28
Date: Wed, 12 Dec 2018 14:37:43 +0100
Message-ID: <20181212133743.n2znyydhwch6e2io@toy.home.lxtec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uba6rlqxrlenwgxf"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC11267B8E
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2018 14:37:45 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 916052@bugs.debian.org
List-Id: alsa-devel@alsa-project.org


--uba6rlqxrlenwgxf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Control: forwarded -1 alsa-devel@alsa-project.org


Hi,

could you please investigate? It seems as alsa-oss doesn't built
with glibc 2.28.

Thanks in advance
Elimar
--=20
  Learned men are the cisterns of knowledge,
  not the fountainheads ;-)

--uba6rlqxrlenwgxf
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <bounces+20181209-riesebie=lxtec.de@tracker.debian.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2-lxtec_rules1 (2018-09-13) on
	toy.home.lxtec.de
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_LOW autolearn=ham autolearn_force=no
	version=3.4.2-lxtec_rules1
Envelope-to: riesebie@mail.home.lxtec.de
Delivery-date: Sun, 09 Dec 2018 18:15:05 +0100
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.91 4 (LXTEC))
	id 1gW2fZ-0001Fc-1I
	for <riesebie@mail.home.lxtec.de>; Sun, 09 Dec 2018 18:15:05 +0100
X-Virus-Scanned: at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlnY1SAQejUL for <riesebie@mail.home.lxtec.de>;
	Sun,  9 Dec 2018 18:15:04 +0100 (CET)
Received: from getmail by mail.home.lxtec.de with local (Exim 4.91 4 (LXTEC))
	id 1gW2fY-0001KU-KX
	for <riesebie@mail.home.lxtec.de>; Sun, 09 Dec 2018 18:15:04 +0100
Delivered-To: unknown
Received: from pop.lxtec.de (83.223.79.99:995) by toy.home.lxtec.de with
  POP3-SSL; 09 Dec 2018 17:15:04 -0000
X-Original-To: riesebie@lxtec.de
Delivered-To: o1300-riesebie@h06.hostsharing.net
Received: from mailin1.hostsharing.net (mailin1.hostsharing.net [83.223.95.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
	by h06.hostsharing.net (Postfix) with ESMTPS id 008A04175F2
	for <riesebie@lxtec.de>; Sun,  9 Dec 2018 18:12:15 +0100 (CET)
Received: from muffat.debian.org (muffat.debian.org [IPv6:2607:f8f0:614:1::1274:33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mailin1.hostsharing.net (Postfix) with ESMTPS id B645916CF83
	for <riesebie@lxtec.de>; Sun,  9 Dec 2018 18:12:14 +0100 (CET)
Received: from ticharich.debian.org ([2001:41c8:1000:21::21:23])
	from C=NA,ST=NA,L=Ankh Morpork,O=Debian SMTP,OU=Debian SMTP CA,CN=ticharich.debian.org,EMAIL=hostmaster@ticharich.debian.org (verified)
	by muffat.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <bounces+20181209-riesebie=lxtec.de@tracker.debian.org>)
	id 1gW2ck-0005TS-Ux
	for riesebie@lxtec.de; Sun, 09 Dec 2018 17:12:11 +0000
Received: from localhost ([::1] helo=ticharich.debian.org)
	by ticharich.debian.org with esmtp (Exim 4.89)
	(envelope-from <bounces+20181209-riesebie=lxtec.de@tracker.debian.org>)
	id 1gW2cj-0005sO-Gw
	for riesebie@lxtec.de; Sun, 09 Dec 2018 17:12:09 +0000
Received: from mailly.debian.org ([2001:41b8:202:deb:6564:a62:52c3:4b72])
	from C=NA,ST=NA,L=Ankh Morpork,O=Debian SMTP,OU=Debian SMTP CA,CN=mailly.debian.org,EMAIL=hostmaster@mailly.debian.org (verified)
	by ticharich.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1gW2cj-0005sH-CD
	for dispatch+alsa-oss@tracker.debian.org; Sun, 09 Dec 2018 17:12:09 +0000
Received: from quantz.debian.org ([2001:41c8:1000:21::21:28])
	from C=NA,ST=NA,L=Ankh Morpork,O=Debian SMTP,OU=Debian SMTP CA,CN=quantz.debian.org,EMAIL=hostmaster@quantz.debian.org (verified)
	by mailly.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1gW2cj-0000GW-0o
	for dispatch+alsa-oss@tracker.debian.org; Sun, 09 Dec 2018 17:12:09 +0000
Received: from qa by quantz.debian.org with local (Exim 4.89)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1gW2ci-0004Cu-NI
	for dispatch+alsa-oss@tracker.debian.org; Sun, 09 Dec 2018 17:12:08 +0000
Received: from buxtehude.debian.org ([2607:f8f0:614:1::1274:39])
	from C=NA,ST=NA,L=Ankh Morpork,O=Debian SMTP,OU=Debian SMTP CA,CN=buxtehude.debian.org,EMAIL=hostmaster@buxtehude.debian.org (verified)
	by quantz.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1gW2ci-0004CV-F6
	for alsa-oss@packages.qa.debian.org; Sun, 09 Dec 2018 17:12:08 +0000
Received: from debbugs by buxtehude.debian.org with local (Exim 4.89)
	(envelope-from <debbugs@buxtehude.debian.org>)
	id 1gW2ch-0005Ha-2R; Sun, 09 Dec 2018 17:12:07 +0000
X-Loop: owner@bugs.debian.org
Subject: Bug#916052: alsa-oss FTBFS with glibc 2.28
Reply-To: Adrian Bunk <bunk@debian.org>, 916052@bugs.debian.org
Resent-From: Adrian Bunk <bunk@debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-CC: Debian ALSA Maintainers <pkg-alsa-devel@lists.alioth.debian.org>
X-Loop: owner@bugs.debian.org
Resent-Date: Sun, 09 Dec 2018 17:12:04 +0000
Resent-Message-ID: <handler.916052.B.154437541119129@bugs.debian.org>
X-Debian-PR-Message: report 916052
X-Debian-PR-Package: src:alsa-oss
X-Debian-PR-Keywords: ftbfs
X-Debian-PR-Source: alsa-oss
Received: via spool by submit@bugs.debian.org id=B.154437541119129
          (code B); Sun, 09 Dec 2018 17:12:04 +0000
Received: (at submit) by bugs.debian.org; 9 Dec 2018 17:10:11 +0000
Received: from mail.stusta.mhn.de ([2001:4ca0:200:3:200:5efe:8d54:4505])
	by buxtehude.debian.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <bunk@debian.org>)
	id 1gW2ap-0004yD-Br
	for submit@bugs.debian.org; Sun, 09 Dec 2018 17:10:11 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.stusta.mhn.de (Postfix) with ESMTPSA id 43CXl43LNWz4p;
	Sun,  9 Dec 2018 18:10:08 +0100 (CET)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Adrian Bunk <bunk@debian.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>
Message-ID: <154437540334.14061.14376834129436759254.reportbug@localhost>
X-Mailer: reportbug 7.5.0
Date: Sun, 09 Dec 2018 19:10:03 +0200
Delivered-To: submit@bugs.debian.org
Delivered-To: alsa-oss@packages.qa.debian.org
Delivered-To: dispatch+alsa-oss@tracker.debian.org
X-Loop: dispatch@tracker.debian.org
X-Distro-Tracker-Keyword: bts
X-Distro-Tracker-Package: alsa-oss
List-Id: <alsa-oss.tracker.debian.org>
X-Debian: tracker.debian.org
X-Debian-Package: alsa-oss
X-PTS-Package: alsa-oss
X-PTS-Keyword: bts
Precedence: list
List-Unsubscribe: <mailto:control@tracker.debian.org?body=unsubscribe%20alsa-oss>

Source: alsa-oss
Version: 1.1.6-1
Severity: serious
Tags: ftbfs

https://tests.reproducible-builds.org/debian/rb-pkg/unstable/amd64/alsa-oss.html

...
In file included from alsa-oss.c:736:
stdioemu.c:40:10: fatal error: libio.h: No such file or directory
 #include <libio.h>
          ^~~~~~~~~
compilation terminated.
make[2]: *** [Makefile:517: alsa-oss.lo] Error 1


--uba6rlqxrlenwgxf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--uba6rlqxrlenwgxf--
