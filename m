From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Dump scratch registers on DSP shutdown
Date: Thu, 28 May 2015 17:32:29 +0100
Message-ID: <1432830749-1252-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The SCRATCH registers are used by firmwares to hold diagnostic
information. Log this during shutdown to assist analysis and debug
of firmwares.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f6642c1..6e7a7000 100644
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
@@ -364,6 +369,25 @@ static unsigned int wm_adsp_region_to_reg(struct wm_adsp_region const *mem,
 	}
 }
 
+static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
+{
+	u16 scratch[4];
+	int ret;
+
+	ret = regmap_raw_read(dsp->regmap, dsp->base + ADSP2_SCRATCH0,
+				scratch, sizeof(scratch));
+	if (ret) {
+		adsp_err(dsp, "Failed to read SCRATCH regs: %d\n", ret);
+		return;
+	}
+
+	adsp_info(dsp, "FW SCRATCH 0:0x%x 1:0x%x 2:0x%x 3:0x%x\n",
+		  be16_to_cpu(scratch[0]),
+		  be16_to_cpu(scratch[1]),
+		  be16_to_cpu(scratch[2]),
+		  be16_to_cpu(scratch[3]));
+}
+
 static int wm_coeff_info(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_info *uinfo)
 {
@@ -1898,6 +1922,9 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		/* Log firmware state, it can be useful for analysis */
+		wm_adsp2_show_fw_status(dsp);
+
 		dsp->running = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-- 
1.7.2.5
