From: Travis Place <wishie@wishie.net>
Subject: [PATCH] Added correct model selection for Intel DG35EC
	mainboard - HDAIntel driver.
Date: Sat, 24 May 2008 13:29:34 +1000
Message-ID: <200805241329.34943.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eu4NIH2vXlvxXsD"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-089.dial.usertools.net [202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 188BB24743
	for <alsa-devel@alsa-project.org>;
	Sat, 24 May 2008 05:30:29 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 1022A5D4DB
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2008 03:51:32 +1000 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_eu4NIH2vXlvxXsD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Changelog: Added the correct model for the Intel DG35EC mainboard 
(http://www.intel.com/products/motherboard/DG35EC/index.htm)
The card was previously 'unknown'. The following patch, adds the card to the 
quirk table, to automatically select ALC883_3STACK_6CH.

Confirmed working for all analogue outputs, and inputs.

Patch attached.

Signed-off-by: Travis Place <wishie at wishie dot net>

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_eu4NIH2vXlvxXsD
Content-Type: text/x-diff;
  charset="us-ascii";
  name="IntelDG35EC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="IntelDG35EC.patch"

diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Sat May 24 13:28:37 2008 +1000
@@ -7785,6 +7785,7 @@ static struct snd_pci_quirk alc883_cfg_t
 	SND_PCI_QUIRK(0x17f2, 0x5000, "Albatron KI690-AM2", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1991, 0x5625, "Haier W66", ALC883_HAIER_W66),
 	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC883_3ST_6ch),
+	SND_PCI_QUIRK(0x8086, 0xd701, "Intel DG35EC", ALC883_3ST_6ch),
 	{}
 };
 

--Boundary-00=_eu4NIH2vXlvxXsD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_eu4NIH2vXlvxXsD--
