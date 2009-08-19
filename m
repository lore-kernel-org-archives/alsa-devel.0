From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: add model for Intel DG45ID/DG45FC boards
Date: Wed, 19 Aug 2009 17:05:11 +0800
Message-ID: <20090819090511.GA17711@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F585244AB
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 11:05:26 +0200 (CEST)
Content-Disposition: inline
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The BIOS pin configs are in fact correct and shall not be overwritten.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_sigmatel.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_sigmatel.c	2009-08-19 16:59:50.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_sigmatel.c	2009-08-19 16:59:51.000000000 +0800
@@ -78,6 +78,7 @@ enum {
 	STAC_92HD73XX_AUTO,
 	STAC_92HD73XX_NO_JD, /* no jack-detection */
 	STAC_92HD73XX_REF,
+	STAC_92HD73XX_INTEL,
 	STAC_DELL_M6_AMIC,
 	STAC_DELL_M6_DMIC,
 	STAC_DELL_M6_BOTH,
@@ -1775,6 +1776,7 @@ static const char *stac92hd73xx_models[S
 	[STAC_92HD73XX_AUTO] = "auto",
 	[STAC_92HD73XX_NO_JD] = "no-jd",
 	[STAC_92HD73XX_REF] = "ref",
+	[STAC_92HD73XX_INTEL] = "intel",
 	[STAC_DELL_M6_AMIC] = "dell-m6-amic",
 	[STAC_DELL_M6_DMIC] = "dell-m6-dmic",
 	[STAC_DELL_M6_BOTH] = "dell-m6",
@@ -1787,6 +1789,10 @@ static struct snd_pci_quirk stac92hd73xx
 				"DFI LanParty", STAC_92HD73XX_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DFI, 0x3101,
 				"DFI LanParty", STAC_92HD73XX_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x5002,
+				"Intel DG45ID", STAC_92HD73XX_INTEL),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x5003,
+				"Intel DG45FC", STAC_92HD73XX_INTEL),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0254,
 				"Dell Studio 1535", STAC_DELL_M6_DMIC),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0255,
