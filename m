From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP shutdown
Date: Thu, 28 May 2015 14:45:14 +0100
Message-ID: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The DSP_SCRATCH1 register is used by firmwares to hold diagnostic
information. Include this in the shutdown message - it can be
useful for debugging.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f6642c1..9b7c03c 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -121,6 +121,11 @@
 #define ADSP2_WDMA_CONFIG_2 0x31
 #define ADSP2_RDMA_CONFIG_1 0x34
 
+#define ADSP2_SCRATCH0        0x40
+#define ADSP2_SCRATCH1        0x41
+#define ADSP2_SCRATCH2        0x42
+#define ADSP2_SCRATCH3        0x43
+
 /*
  * ADSP2 Control
  */
@@ -1880,6 +1885,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp *dsp = &dsps[w->shift];
 	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
+	unsigned int scratch1 = 0xFFFFFFFF;
 	int ret;
 
 	switch (event) {
@@ -1898,6 +1904,12 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		/* Capture DSP_SCRATCH1, it can be useful for analysis */
+		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_SCRATCH1,
+				  &scratch1);
+		if (ret)
+			adsp_err(dsp, "Failed to read SCRATCH1 %d\n", ret);
+
 		dsp->running = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
@@ -1935,7 +1947,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 			kfree(alg_region);
 		}
 
-		adsp_dbg(dsp, "Shutdown complete\n");
+		adsp_info(dsp, "Shutdown complete (SCRATCH1:0x%x)\n", scratch1);
 		break;
 
 	default:
-- 
1.7.2.5
