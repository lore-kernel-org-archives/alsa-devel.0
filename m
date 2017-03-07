From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda - set intel audio clock to a
	properly value
Date: Tue,  7 Mar 2017 14:20:22 +0800
Message-ID: <1488867622-21765-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id D0C2A2669EA
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 07:28:05 +0100 (CET)
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, infernix@infernix.net
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

On some Intel platforms, the audio clock may not be set correctly
with initial setting. This will cause the audio playback/capture
rates wrong.

This patch checks the audio clock setting and will set it to a
properly value if it is not set correct.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188411

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 include/sound/hda_register.h        | 12 +++--
 sound/hda/ext/hdac_ext_controller.c |  6 +--
 sound/pci/hda/hda_intel.c           | 91 +++++++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 0013063..7ea16cb 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -227,6 +227,8 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_PPLCLLPU		0xC
 
 /* registers for Multiple Links Capability Structure */
+/* Multiple Links Capability */
+#define AZX_REG_ML_CAP_BASE		0xc00
 #define AZX_ML_CAP_ID			0x2
 #define AZX_REG_ML_MLCH			0x00
 #define AZX_REG_ML_MLCD			0x04
@@ -243,9 +245,13 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_ML_LOUTPAY		0x20
 #define AZX_REG_ML_LINPAY		0x30
 
-#define AZX_MLCTL_SPA			(1<<16)
-#define AZX_MLCTL_CPA			23
-
+#define AZX_REG_ML_LCAPx(x)	(AZX_REG_ML_CAP_BASE + (0x40 + 0x40 * x))
+#define AZX_REG_ML_LCTLx(x)	(AZX_REG_ML_CAP_BASE + (0x44 + 0x40 * x))
+#define ML_LCTL_SCF_MASK			0xF
+#define AZX_MLCTL_SPA				(0x1 << 16)
+#define AZX_MLCTL_CPA				(0x1 << 23)
+#define AZX_MLCTL_SPA_SHIFT			16
+#define AZX_MLCTL_CPA_SHIFT			23
 
 /* registers for DMA Resume Capability Structure */
 #define AZX_DRSM_CAP_ID			0x5
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 2614691..84f3b81 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -171,7 +171,7 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 {
 	int timeout;
 	u32 val;
-	int mask = (1 << AZX_MLCTL_CPA);
+	int mask = (1 << AZX_MLCTL_CPA_SHIFT);
 
 	udelay(3);
 	timeout = 150;
@@ -179,10 +179,10 @@ static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
 	do {
 		val = readl(link->ml_addr + AZX_REG_ML_LCTL);
 		if (enable) {
-			if (((val & mask) >> AZX_MLCTL_CPA))
+			if (((val & mask) >> AZX_MLCTL_CPA_SHIFT))
 				return 0;
 		} else {
-			if (!((val & mask) >> AZX_MLCTL_CPA))
+			if (!((val & mask) >> AZX_MLCTL_CPA_SHIFT))
 				return 0;
 		}
 		udelay(3);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c8256a8..017f64f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -539,6 +539,94 @@ static void bxt_reduce_dma_latency(struct azx *chip)
 	azx_writel(chip, SKL_EM4L, val);
 }
 
+/*
+ * ML_LCAP bits:
+ *  bit 0: 6 MHz Supported
+ *  bit 1: 12 MHz Supported
+ *  bit 2: 24 MHz Supported
+ *  bit 3: 48 MHz Supported
+ *  bit 4: 96 MHz Supported
+ *  bit 5: 192 MHz Supported
+ */
+static int intel_get_lctl_scf(struct azx *chip)
+{
+	u32 val;
+
+	val = azx_readl(chip, ML_LCAPx(0));
+
+	if (val & (1 << 2))
+		return 2;
+	else if (val & (1 << 3))
+		return 3;
+	else if (val & (1 << 1))
+		return 1;
+	else if (val & (1 << 4))
+		return 4;
+	else if (val & (1 << 5))
+		return 5;
+
+	dev_warn(chip->card->dev, "set audio clock frequency to 6MHz");
+	return 0;
+}
+
+static void intel_init_lctl(struct azx *chip)
+{
+	u32 val;
+	int timeout;
+
+	/* 0. check lctl register value is correct or not */
+	/* the codecs are sharing the first link setting by default */
+	val = azx_readl(chip, ML_LCTLx(0));
+	/* if SCF is already set, let's use it */
+	if ((val & ML_LCTL_SCF_MASK) != 0)
+		return;
+
+	/*
+	 * Before operatiing on SPA, CPA must match SPA.
+	 * Any deviation may result in undefined behavior.
+	 */
+	if (((val & AZX_MLCTL_SPA) >> AZX_MLCTL_SPA_SHIFT) ^
+		((val & AZX_MLCTL_CPA) >> AZX_MLCTL_CPA_SHIFT))
+		return;
+
+	/* 1. turn link down: set SPA to 0 and wait CPA to 0 */
+	val = azx_readl(chip, ML_LCTLx(0));
+	val &= ~AZX_MLCTL_SPA;
+	azx_writel(chip, ML_LCTLx(0), val);
+	/* wait for CPA */
+	timeout = 50;
+	while (timeout) {
+		if ((azx_readl(chip, ML_LCTLx(0)) & AZX_MLCTL_CPA) == 0)
+			break;
+		timeout--;
+		udelay(10);
+	}
+	if (!timeout)
+		goto SET_SPA;
+	/* need add 100ns delay for hardware ready */
+	udelay(100);
+
+	/* 2. update SCF to select a properly audio clock*/
+	val &= ~ML_LCTL_SCF_MASK;
+	val |= intel_get_lctl_scf(chip);
+	azx_writel(chip, ML_LCTLx(0), val);
+
+SET_SPA:
+	/* 4. turn link up: set SPA to 1 and wait CPA to 1 */
+	val = azx_readl(chip, ML_LCTLx(0));
+	val |= AZX_MLCTL_SPA;
+	azx_writel(chip, ML_LCTLx(0), val);
+	timeout = 50;
+	while (timeout) {
+		if ((azx_readl(chip, ML_LCTLx(0)) & AZX_MLCTL_CPA) != 0)
+			break;
+		timeout--;
+		udelay(10);
+	}
+	/* need add 100ns delay for hardware ready */
+	udelay(100);
+}
+
 static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 {
 	struct hdac_bus *bus = azx_bus(chip);
@@ -564,6 +652,9 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 	/* reduce dma latency to avoid noise */
 	if (IS_BXT(pci))
 		bxt_reduce_dma_latency(chip);
+
+	if (IS_SKL_PLUS(pci))
+		intel_init_lctl(chip);
 }
 
 /* calculate runtime delay from LPIB */
-- 
2.7.4
