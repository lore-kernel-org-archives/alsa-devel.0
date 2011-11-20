From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: hdspm - Missing PCI ID for PCIe MADI
Date: Sun, 20 Nov 2011 23:12:58 +0100
Message-ID: <20111120231258.312526d4@revell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id BCE0324419
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2011 23:13:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Adrian,

thanks for the latest patches. While doing some testing, I noticed that
one PCI ID (d2) was missing, so the module didn't load.


$ grep 'hdsp_madi,' hdsp.inf | sort | uniq

%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_C8
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_C9
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CA
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CB
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CC
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CD
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CE
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_CF
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_D2
%DeviceDescMadi% = hdsp_madi, PCI\VEN_10EE&DEV_3FC6&REV_D5


Trivial patch below, that should be all then.
Tested on CentOS 6.0, vanilla kernel 3.0.7 with RT-20 and latest
hdspm.c from GitHub.


Cheers,
  Andre


diff -up hdspm.c.orig hdspm.c
--- hdspm.c.orig	2011-11-18 11:12:36.549938179 +0100
+++ hdspm.c	2011-11-18 11:12:47.351937890 +0100
@@ -6518,8 +6518,9 @@ static int __devinit snd_hdspm_create(st
 			hdspm->io_type = AES32;
 			hdspm->card_name = "RME AES32";
 			hdspm->midiPorts = 2;
-		} else if ((hdspm->firmware_rev == 0xd5) ||
-			((hdspm->firmware_rev >= 0xc8)  &&
+		} else if ((hdspm->firmware_rev == 0xd2) ||  // D2 = PCIe MADI
+			(hdspm->firmware_rev == 0xd5) ||     // D5 = PCIe MADIface
+			((hdspm->firmware_rev >= 0xc8) &&    // C8 - CF = PCI MADI
 				(hdspm->firmware_rev <= 0xcf))) {
 			hdspm->io_type = MADI;
 			hdspm->card_name = "RME MADI";
