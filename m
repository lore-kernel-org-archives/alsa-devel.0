From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - only sync BCLK to the display
	clock for Haswell & Broadwell
Date: Mon, 20 Apr 2015 16:04:05 +0800
Message-ID: <6f881935a29f44b895ae6854bcd40ea62a7364a5.1429517003.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD02265317
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 09:53:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Only Intel Haswell and Broadwell have a separate HD-A controller (PCI device 3)
for display audio, which needs to get 24MHz HD-A link BCLK from the variable
display core clock through vendor specific registers EM4 & EM5. Other platforms
(Baytrail, Braswell and Skylake) don't have this feature.

So a new driver quirk AZX_DCAPS_I915_SYNC_CLK is defined for the HSW/BDW display
HD-A controller, to sync clock after the shared display power is restored.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be1b7de..1729004 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -175,6 +175,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
+#define AZX_DCAPS_I915_SYNC_CLK (1 << 31)	/* Need to sync BCLK with display clock */
 
 enum {
 	AZX_SNOOP_TYPE_NONE,
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e1c2105..951263d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -289,13 +289,13 @@ enum {
 #define AZX_DCAPS_INTEL_HASWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
-	 AZX_DCAPS_SNOOP_TYPE(SCH))
+	 AZX_DCAPS_I915_SYNC_CLK | AZX_DCAPS_SNOOP_TYPE(SCH))
 
 /* Broadwell HDMI can't use position buffer reliably, force to use LPIB */
 #define AZX_DCAPS_INTEL_BROADWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_POSFIX_LPIB |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
-	 AZX_DCAPS_SNOOP_TYPE(SCH))
+	 AZX_DCAPS_I915_SYNC_CLK | AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_BRASWELL \
 	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_I915_POWERWELL)
@@ -815,7 +815,8 @@ static int azx_resume(struct device *dev)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(hda, true);
-		haswell_set_bclk(hda);
+		if (chip->driver_caps & AZX_DCAPS_I915_SYNC_CLK)
+			haswell_set_bclk(hda);
 	}
 	if (chip->msi)
 		if (pci_enable_msi(pci) < 0)
@@ -884,7 +885,8 @@ static int azx_runtime_resume(struct device *dev)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
 		hda_display_power(hda, true);
-		haswell_set_bclk(hda);
+		if (chip->driver_caps & AZX_DCAPS_I915_SYNC_CLK)
+			haswell_set_bclk(hda);
 	}
 
 	/* Read STATESTS before controller reset */
@@ -1578,7 +1580,7 @@ static int azx_first_init(struct azx *chip)
 	/* initialize chip */
 	azx_init_pci(chip);
 
-	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+	if (chip->driver_caps & AZX_DCAPS_I915_SYNC_CLK) {
 		struct hda_intel *hda;
 
 		hda = container_of(chip, struct hda_intel, chip);
-- 
1.9.1
