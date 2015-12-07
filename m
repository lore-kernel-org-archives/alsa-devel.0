From: han.lu@intel.com
Subject: [PATCH 1/1] audio: Fix playback noise with 24/32 bit
	sample size on BXT
Date: Mon,  7 Dec 2015 10:51:49 +0800
Message-ID: <1449456709-1135-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BC069265005
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 03:52:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, libin.yang@linux.intel.com, mengdong.lin@linux.intel.com, han.lu@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

In BXT-P A0, HD-Audio DMA requests is later than expected,
and makes an audio stream sensitive to system latencies when
24/32 bits are playing.
Adjusting threshold of DMA fifo to force the DMA request
sooner to improve latency tolerance at the expense of power.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 2ae8812..94dc6a9 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -93,6 +93,9 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_REG_HSW_EM4			0x100c
 #define AZX_REG_HSW_EM5			0x1010
 
+/* Skylake/Broxton display HD-A controller Extended Mode registers */
+#define AZX_REG_SKL_EM4L		0x1040
+
 /* PCI space */
 #define AZX_PCIREG_TCSEL		0x44
 
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 22dbfa5..6c2aa4c 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include "hda_controller.h"
@@ -34,6 +35,8 @@
 #define CREATE_TRACE_POINTS
 #include "hda_controller_trace.h"
 
+#define is_broxton(pci)	((pci)->device == 0x5a98)
+
 /* DSP lock helpers */
 #define dsp_lock(dev)		snd_hdac_dsp_lock(azx_stream(dev))
 #define dsp_unlock(dev)		snd_hdac_dsp_unlock(azx_stream(dev))
@@ -880,14 +883,35 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_load_dsp_cleanup);
 #endif /* CONFIG_SND_HDA_DSP_LOADER */
 
 /*
+ * In BXT-P A0, HD-Audio DMA requests is later than expected,
+ * and makes an audio stream sensitive to system latencies when
+ * 24/32 bits are playing.
+ * Adjusting threshold of DMA fifo to force the DMA request
+ * sooner to improve latency tolerance at the expense of power.
+ */
+static void bxt_reduce_dma_latency(struct azx *chip)
+{
+	u32 val;
+
+	val = azx_readl(chip, SKL_EM4L);
+	val &= (0x3 << 20);
+	azx_writel(chip, SKL_EM4L, val);
+}
+
+/*
  * reset and start the controller registers
  */
 void azx_init_chip(struct azx *chip, bool full_reset)
 {
+	struct pci_dev *pci = chip->pci;
+
 	if (snd_hdac_bus_init_chip(azx_bus(chip), full_reset)) {
 		/* correct RINTCNT for CXT */
 		if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
 			azx_writew(chip, RINTCNT, 0xc0);
+		/* reduce dma latency to avoid noise */
+		if (is_broxton(pci))
+			bxt_reduce_dma_latency(chip);
 	}
 }
 EXPORT_SYMBOL_GPL(azx_init_chip);
-- 
2.5.0
