From: Andiry Xu <andiry.xu@amd.com>
Subject: [PATCH] ALSA: HDA: Use AZX_DRIVER_ATI for AMD/ATI
	platforms
Date: Wed, 25 May 2011 13:59:19 +0800
Message-ID: <1306303159.1508.3.camel@brienza-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe004.messaging.microsoft.com
	[216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BF5C10381F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 08:00:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit makes AMD/ATI platforms use AZX_DRIVER_ATI for SB HD Audio
and AZX_DRIVER_ATIHDMI for HDMI Audio, so some quirks can be applied to
AMD/ATI platforms without checking the pci vendor ID.

This also spearate SB and HDMI audio, since some quirks should only
apply to SB audio.

Signed-off-by: Andiry Xu <andiry.xu@amd.com>
---
 sound/pci/hda/hda_intel.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 43a0367..05f551c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1062,7 +1062,9 @@ static void azx_init_pci(struct azx *chip)
 
 	switch (chip->driver_type) {
 	case AZX_DRIVER_ATI:
-		/* For ATI SB450 azalia HD audio, we need to enable snoop */
+		/* For ATI SB450/600/700/800/900 and AMD Hudson azalia
+		 * HD audio, we need to enable snoop.
+		 */
 		update_pci_byte(chip->pci,
 				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR, 
 				0x07, ATI_SB450_HDAUDIO_ENABLE_SNOOP);
@@ -1092,13 +1094,6 @@ static void azx_init_pci(struct azx *chip)
 				? "Failed" : "OK");
 		}
 		break;
-	default:
-		/* AMD Hudson needs the similar snoop, as it seems... */
-		if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
-			update_pci_byte(chip->pci,
-				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR,
-				0x07, ATI_SB450_HDAUDIO_ENABLE_SNOOP);
-		break;
         }
 }
 
@@ -1457,8 +1452,7 @@ static int __devinit azx_codec_create(struct azx *chip, const char *model)
 	 * sequence like the pin-detection.  It seems that forcing the synced
 	 * access works around the stall.  Grrr...
 	 */
-	if (chip->pci->vendor == PCI_VENDOR_ID_AMD ||
-	    chip->pci->vendor == PCI_VENDOR_ID_ATI) {
+	if (chip->driver_type == AZX_DRIVER_ATI) {
 		snd_printk(KERN_INFO SFX "Enable sync_write for AMD chipset\n");
 		chip->bus->sync_write = 1;
 		chip->bus->allow_bus_reset = 1;
@@ -2370,13 +2364,8 @@ static int __devinit check_position_fix(struct azx *chip, int fix)
 		/* Use link position directly, avoid any transfer problem. */
 		return POS_FIX_VIACOMBO;
 	case AZX_DRIVER_ATI:
-		/* ATI chipsets don't work well with position-buffer */
+		/* ATI/AMD chipsets don't support position-buffer */
 		return POS_FIX_LPIB;
-	case AZX_DRIVER_GENERIC:
-		/* AMD chipsets also don't work with position-buffer */
-		if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
-			return POS_FIX_LPIB;
-		break;
 	}
 
 	return POS_FIX_AUTO;
@@ -2800,9 +2789,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_ICH },
-	/* ATI SB 450/600 */
+	/* ATI SB 450/600/700/800/900 */
 	{ PCI_DEVICE(0x1002, 0x437b), .driver_data = AZX_DRIVER_ATI },
 	{ PCI_DEVICE(0x1002, 0x4383), .driver_data = AZX_DRIVER_ATI },
+	/* AMD Hudson */
+	{ PCI_DEVICE(0x1022, 0x780d), .driver_data = AZX_DRIVER_ATI },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x793b), .driver_data = AZX_DRIVER_ATIHDMI },
 	{ PCI_DEVICE(0x1002, 0x7919), .driver_data = AZX_DRIVER_ATIHDMI },
@@ -2849,15 +2840,15 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
 	/* VMware HDAudio */
 	{ PCI_DEVICE(0x15ad, 0x1977), .driver_data = AZX_DRIVER_GENERIC },
-	/* AMD/ATI Generic, PCI class code and Vendor ID for HD Audio */
+	/* AMD/ATI Generic, PCI class code and Vendor ID for HDMI Audio */
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = AZX_DRIVER_GENERIC },
+	  .driver_data = AZX_DRIVER_ATIHDMI },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
-	  .driver_data = AZX_DRIVER_GENERIC },
+	  .driver_data = AZX_DRIVER_ATIHDMI },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
-- 
1.7.1
