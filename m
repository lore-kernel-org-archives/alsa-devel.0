From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add AZX_DCAPS_SNOOP_OFF (and
	refactor snoop setup)
Date: Tue, 25 Nov 2014 11:34:15 +0100
Message-ID: <1416911655-31438-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 701E92605B4
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 11:34:17 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 13D53ACD3
 for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2014 10:34:17 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Add a new driver_caps bit, AZX_DCAPS_SNOOP_OFF, to set the snoop off
as default.  This new bit is used for the checks in
azx_check_snoop_available().  Most of case-switches are replaced with
the new dcaps in each entry.

While working on it, for avoiding to spend more bits, combine three
bits AZX_DCAPS_SNOOP_SCH, AZX_DCAPS_SNOOP_ATI and
AZX_DCAPS_SNOOP_NVIDIA bits into a flat type of two bits.  This
reduces the bits usages, and assign AZX_DCAPS_OFF to this empty bit
now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 71 +++++++++++++++++++++++++----------------------
 sound/pci/hda/hda_priv.h  | 12 ++++++--
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 91fa959d05fe..b1b4a72cf29c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -271,42 +271,51 @@ enum {
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
 
+#define azx_get_snoop_type(chip) \
+	(((chip)->driver_caps & AZX_DCAPS_SNOOP_MASK) >> 10)
+#define AZX_DCAPS_SNOOP_TYPE(type) ((AZX_SNOOP_TYPE_ ## type) << 10)
+
 /* quirks for Intel PCH */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
-	(AZX_DCAPS_SCH_SNOOP | AZX_DCAPS_BUFSIZE | \
-	 AZX_DCAPS_COUNT_LPIB_DELAY | AZX_DCAPS_REVERSE_ASSIGN)
+	(AZX_DCAPS_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
+	 AZX_DCAPS_REVERSE_ASSIGN | AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_PCH \
 	(AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
 
 #define AZX_DCAPS_INTEL_HASWELL \
-	(AZX_DCAPS_SCH_SNOOP | AZX_DCAPS_ALIGN_BUFSIZE | \
-	 AZX_DCAPS_COUNT_LPIB_DELAY | AZX_DCAPS_PM_RUNTIME | \
-	 AZX_DCAPS_I915_POWERWELL)
+	(AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
+	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* Broadwell HDMI can't use position buffer reliably, force to use LPIB */
 #define AZX_DCAPS_INTEL_BROADWELL \
-	(AZX_DCAPS_SCH_SNOOP | AZX_DCAPS_ALIGN_BUFSIZE | \
-	 AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_PM_RUNTIME | \
-	 AZX_DCAPS_I915_POWERWELL)
+	(AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_POSFIX_LPIB |\
+	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
+	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
-	(AZX_DCAPS_ATI_SNOOP | AZX_DCAPS_NO_TCSEL | \
-	 AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
+	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB |\
+	 AZX_DCAPS_SNOOP_TYPE(ATI))
 
 /* quirks for ATI/AMD HDMI */
 #define AZX_DCAPS_PRESET_ATI_HDMI \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
 
+/* quirks for ATI HDMI with snoop off */
+#define AZX_DCAPS_PRESET_ATI_HDMI_NS \
+	(AZX_DCAPS_PRESET_ATI_HDMI | AZX_DCAPS_SNOOP_OFF)
+
 /* quirks for Nvidia */
 #define AZX_DCAPS_PRESET_NVIDIA \
-	(AZX_DCAPS_NVIDIA_SNOOP | AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI |\
-	 AZX_DCAPS_ALIGN_BUFSIZE | AZX_DCAPS_NO_64BIT |\
-	 AZX_DCAPS_CORBRP_SELF_CLEAR)
+	(AZX_DCAPS_RIRB_DELAY | AZX_DCAPS_NO_MSI | AZX_DCAPS_ALIGN_BUFSIZE |\
+	 AZX_DCAPS_NO_64BIT | AZX_DCAPS_CORBRP_SELF_CLEAR |\
+	 AZX_DCAPS_SNOOP_TYPE(NVIDIA))
 
 #define AZX_DCAPS_PRESET_CTHDA \
-	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_4K_BDLE_BOUNDARY)
+	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB |\
+	 AZX_DCAPS_4K_BDLE_BOUNDARY | AZX_DCAPS_SNOOP_OFF)
 
 /*
  * VGA-switcher support
@@ -435,6 +444,8 @@ static void update_pci_byte(struct pci_dev *pci, unsigned int reg,
 
 static void azx_init_pci(struct azx *chip)
 {
+	int snoop_type = azx_get_snoop_type(chip);
+
 	/* Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
 	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
 	 * Ensuring these bits are 0 clears playback static on some HD Audio
@@ -449,7 +460,7 @@ static void azx_init_pci(struct azx *chip)
 	/* For ATI SB450/600/700/800/900 and AMD Hudson azalia HD audio,
 	 * we need to enable snoop.
 	 */
-	if (chip->driver_caps & AZX_DCAPS_ATI_SNOOP) {
+	if (snoop_type == AZX_SNOOP_TYPE_ATI) {
 		dev_dbg(chip->card->dev, "Setting ATI snoop: %d\n",
 			azx_snoop(chip));
 		update_pci_byte(chip->pci,
@@ -458,7 +469,7 @@ static void azx_init_pci(struct azx *chip)
 	}
 
 	/* For NVIDIA HDA, enable snoop */
-	if (chip->driver_caps & AZX_DCAPS_NVIDIA_SNOOP) {
+	if (snoop_type == AZX_SNOOP_TYPE_NVIDIA) {
 		dev_dbg(chip->card->dev, "Setting Nvidia snoop: %d\n",
 			azx_snoop(chip));
 		update_pci_byte(chip->pci,
@@ -473,7 +484,7 @@ static void azx_init_pci(struct azx *chip)
 	}
 
 	/* Enable SCH/PCH snoop if needed */
-	if (chip->driver_caps & AZX_DCAPS_SCH_SNOOP) {
+	if (snoop_type == AZX_SNOOP_TYPE_SCH) {
 		unsigned short snoop;
 		pci_read_config_word(chip->pci, INTEL_SCH_HDA_DEVC, &snoop);
 		if ((!azx_snoop(chip) && !(snoop & INTEL_SCH_HDA_DEVC_NOSNOOP)) ||
@@ -1360,8 +1371,8 @@ static void azx_check_snoop_available(struct azx *chip)
 {
 	bool snoop = chip->snoop;
 
-	switch (chip->driver_type) {
-	case AZX_DRIVER_VIA:
+	if (azx_get_snoop_type(chip) == AZX_SNOOP_TYPE_NONE &&
+	    chip->driver_type == AZX_DRIVER_VIA) {
 		/* force to non-snoop mode for a new VIA controller
 		 * when BIOS is set
 		 */
@@ -1371,17 +1382,11 @@ static void azx_check_snoop_available(struct azx *chip)
 			if (!(val & 0x80) && chip->pci->revision == 0x30)
 				snoop = false;
 		}
-		break;
-	case AZX_DRIVER_ATIHDMI_NS:
-		/* new ATI HDMI requires non-snoop */
-		snoop = false;
-		break;
-	case AZX_DRIVER_CTHDA:
-	case AZX_DRIVER_CMEDIA:
-		snoop = false;
-		break;
 	}
 
+	if (chip->driver_caps & AZX_DCAPS_SNOOP_OFF)
+		snoop = false;
+
 	if (snoop != chip->snoop) {
 		dev_info(chip->card->dev, "Force to %s mode\n",
 			 snoop ? "snoop" : "non-snoop");
@@ -2112,13 +2117,13 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xaa98),
 	  .driver_data = AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
 	{ PCI_DEVICE(0x1002, 0x9902),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaaa0),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaaa8),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	{ PCI_DEVICE(0x1002, 0xaab0),
-	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI },
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS },
 	/* VIA VT8251/VT8237A */
 	{ PCI_DEVICE(0x1106, 0x3288),
 	  .driver_data = AZX_DRIVER_VIA | AZX_DCAPS_POSFIX_VIA },
@@ -2165,7 +2170,7 @@ static const struct pci_device_id azx_ids[] = {
 	/* CM8888 */
 	{ PCI_DEVICE(0x13f6, 0x5011),
 	  .driver_data = AZX_DRIVER_CMEDIA |
-	  AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB },
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB | AZX_DCAPS_SNOOP_OFF },
 	/* Vortex86MX */
 	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
 	/* VMware HDAudio */
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 949cd437eeb2..602536c2147d 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -152,9 +152,8 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 /* bits 0-7 are used for indicating driver type */
 #define AZX_DCAPS_NO_TCSEL	(1 << 8)	/* No Intel TCSEL bit */
 #define AZX_DCAPS_NO_MSI	(1 << 9)	/* No MSI support */
-#define AZX_DCAPS_ATI_SNOOP	(1 << 10)	/* ATI snoop enable */
-#define AZX_DCAPS_NVIDIA_SNOOP	(1 << 11)	/* Nvidia snoop enable */
-#define AZX_DCAPS_SCH_SNOOP	(1 << 12)	/* SCH/PCH snoop enable */
+#define AZX_DCAPS_SNOOP_MASK	(3 << 10)	/* snoop type mask */
+#define AZX_DCAPS_SNOOP_OFF	(1 << 12)	/* snoop default off */
 #define AZX_DCAPS_RIRB_DELAY	(1 << 13)	/* Long delay in read loop */
 #define AZX_DCAPS_RIRB_PRE_DELAY (1 << 14)	/* Put a delay before read */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
@@ -172,6 +171,13 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_I915_POWERWELL (1 << 27)	/* HSW i915 powerwell support */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 
+enum {
+	AZX_SNOOP_TYPE_NONE ,
+	AZX_SNOOP_TYPE_SCH,
+	AZX_SNOOP_TYPE_ATI,
+	AZX_SNOOP_TYPE_NVIDIA,
+};
+
 /* HD Audio class code */
 #define PCI_CLASS_MULTIMEDIA_HD_AUDIO	0x0403
 
-- 
2.1.3
