From: =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
Subject: [PATCH] hdspm.c: make driver name generic to avoid
	user confusion
Date: Tue, 07 Jun 2011 10:48:28 +0200
Message-ID: <4DEDE5DC.40206@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060606080506050309060509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (vm-evil.stackingdwarves.net
	[78.47.233.26]) by alsa0.perex.cz (Postfix) with ESMTP id CCDB81038ED
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:41:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060606080506050309060509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

hi adi, *!


here's a trivial patch to change the driver name of hdspm.c to avoid=20
irritating users who don't have the MADI version (just happened on the=20
LAU list).

iiuc, no external software should make any assumptions about this=20
string, so there should be no side effects, but i have been wrong before =
:)

please review and apply.


best,


j=C3=B6rn






--=20
J=C3=B6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=C3=BCr Veranstaltungstechnik (B=C3=BChne/Studio)
Tonmeister (VDT)

http://stackingdwarves.net

--------------060606080506050309060509
Content-Type: text/x-patch;
 name="hdspm-driver-name.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdspm-driver-name.diff"

--- linux-2.6.39/sound/pci/rme9652/hdspm.c.orig	2011-05-19 06:06:34.000000000 +0200
+++ linux-2.6.39/sound/pci/rme9652/hdspm.c	2011-06-07 10:37:21.894932961 +0200
@@ -6775,7 +6775,7 @@
 }
 
 static struct pci_driver driver = {
-	.name = "RME Hammerfall DSP MADI",
+	.name = "RME Hammerfall HDSPe Series",
 	.id_table = snd_hdspm_ids,
 	.probe = snd_hdspm_probe,
 	.remove = __devexit_p(snd_hdspm_remove),


--------------060606080506050309060509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060606080506050309060509--
