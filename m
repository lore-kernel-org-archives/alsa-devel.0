From: libin.yang@intel.com
Subject: [PATCH 2/2 v2] ALSA: hda - set intel audio clock to a
	proper value
Date: Thu,  6 Apr 2017 19:18:21 +0800
Message-ID: <1491477501-12379-2-git-send-email-libin.yang@intel.com>
References: <1491477501-12379-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AB5026720E
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 04:04:45 +0200 (CEST)
In-Reply-To: <1491477501-12379-1-git-send-email-libin.yang@intel.com>
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, infernix@infernix.net, rakesh.a.ughreja@intel.com, jeeja.kp@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

On some Intel platforms, the audio clock may not be set correctly
with initial setting. This will cause the audio playback/capture
rates wrong.

This patch checks the audio clock setting and will set it to a
proper value if it is set incorrectly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188411

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c8256a8..7b85132 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -539,6 +539,98 @@ static void bxt_reduce_dma_latency(struct azx *chip)
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
+	struct hdac_bus *bus = azx_bus(chip);
+	static int preferred_bits[] = { 2, 3, 1, 4, 5 };
+	u32 val, t;
+	int i;
+
+	val = readl(bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCAP);
+
+	for (i = 0; i < ARRAY_SIZE(preferred_bits); i++) {
+		t = preferred_bits[i];
+		if (val & (1 << t))
+			return t;
+	}
+
+	dev_warn(chip->card->dev, "set audio clock frequency to 6MHz");
+	return 0;
+}
+
+static int intel_ml_lctl_set_power(struct azx *chip, int state)
+{
+	struct hdac_bus *bus = azx_bus(chip);
+	u32 val;
+	int timeout;
+
+	/*
+	 * the codecs are sharing the first link setting by default
+	 * If other links are enabled for stream, they need similar fix
+	 */
+	val = readl(bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCTL);
+	val &= ~AZX_MLCTL_SPA;
+	val |= state << AZX_MLCTL_SPA_SHIFT;
+	writel(val, bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCTL);
+	/* wait for CPA */
+	timeout = 50;
+	while (timeout) {
+		if (((readl(bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCTL)) &
+		    AZX_MLCTL_CPA) == (state << AZX_MLCTL_CPA_SHIFT))
+			return 0;
+		timeout--;
+		udelay(10);
+	}
+
+	return -1;
+}
+
+static void intel_init_lctl(struct azx *chip)
+{
+	struct hdac_bus *bus = azx_bus(chip);
+	u32 val;
+	int ret;
+
+	/* 0. check lctl register value is correct or not */
+	val = readl(bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCTL);
+	/* if SCF is already set, let's use it */
+	if ((val & ML_LCTL_SCF_MASK) != 0)
+		return;
+
+	/*
+	 * Before operating on SPA, CPA must match SPA.
+	 * Any deviation may result in undefined behavior.
+	 */
+	if (((val & AZX_MLCTL_SPA) >> AZX_MLCTL_SPA_SHIFT) !=
+		((val & AZX_MLCTL_CPA) >> AZX_MLCTL_CPA_SHIFT))
+		return;
+
+	/* 1. turn link down: set SPA to 0 and wait CPA to 0 */
+	ret = intel_ml_lctl_set_power(chip, 0);
+	udelay(100);
+	if (ret)
+		goto set_spa;
+
+	/* 2. update SCF to select a properly audio clock*/
+	val &= ~ML_LCTL_SCF_MASK;
+	val |= intel_get_lctl_scf(chip);
+	writel(val, bus->mlcap + AZX_ML_BASE + AZX_REG_ML_LCTL);
+
+set_spa:
+	/* 4. turn link up: set SPA to 1 and wait CPA to 1 */
+	intel_ml_lctl_set_power(chip, 1);
+	udelay(100);
+}
+
 static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 {
 	struct hdac_bus *bus = azx_bus(chip);
@@ -564,6 +656,9 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 	/* reduce dma latency to avoid noise */
 	if (IS_BXT(pci))
 		bxt_reduce_dma_latency(chip);
+
+	if (bus->mlcap != NULL)
+		intel_init_lctl(chip);
 }
 
 /* calculate runtime delay from LPIB */
-- 
2.7.4
