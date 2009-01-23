From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: add reference board SND_PCI_QUIRK
Date: Thu, 22 Jan 2009 22:55:44 -0500
Message-ID: <49793FC0.40407@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 91AE6103804
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 04:55:55 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add another LanParty reference board SND_PCI_QUIRK to quirk lists of
all codec families. 

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index dbe8b12..032dd0b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1510,6 +1510,8 @@ static struct snd_pci_quirk stac9200_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_REF),
 	/* Dell laptops have BIOS problem */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01a8,
 		      "unknown Dell", STAC_9200_DELL_D21),
@@ -1659,6 +1661,7 @@ static struct snd_pci_quirk stac925x_codec_id_cfg_tbl[] = {
 static struct snd_pci_quirk stac925x_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101, "DFI LanParty", STAC_REF),
 	SND_PCI_QUIRK(0x8384, 0x7632, "Stac9202 Reference Board", STAC_REF),
 
 	/* Default table for unknown ID */
@@ -1702,6 +1705,8 @@ static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 				"DFI LanParty", STAC_92HD73XX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+				"DFI LanParty", STAC_92HD73XX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0254,
 				"Dell Studio 1535", STAC_DELL_M6_DMIC),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0255,
@@ -1744,6 +1749,8 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD83XXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_92HD83XXX_REF),
 	{} /* terminator */
 };
 
@@ -1793,6 +1800,8 @@ static struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_92HD71BXX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f2,
 		      "HP dv5", STAC_HP_M4),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x30f4,
@@ -1981,6 +1990,8 @@ static struct snd_pci_quirk stac922x_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D945_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_D945_REF),
 	/* Intel 945G based systems */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x0101,
 		      "Intel D945G", STAC_D945GTP3),
@@ -2137,6 +2148,8 @@ static struct snd_pci_quirk stac927x_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_D965_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_D965_REF),
 	 /* Intel 946 based systems */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x3d01, "Intel D946", STAC_D965_3ST),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0xa301, "Intel D946", STAC_D965_3ST),
@@ -2246,6 +2259,8 @@ static struct snd_pci_quirk stac9205_cfg_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_9205_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
+		      "DFI LanParty", STAC_9205_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f1,
 		      "unknown Dell", STAC_9205_DELL_M42),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01f2,
