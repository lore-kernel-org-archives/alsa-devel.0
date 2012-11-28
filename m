From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Enable DVFS for ADSP2
Date: Wed, 28 Nov 2012 17:26:03 +0000
Message-ID: <1354123564-7005-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 943FA261725
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:26:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some ADSP devices can make use of DVFS to optimise power consumption
depending on the operating frequency of the DSP core. Implement
support for this in the generic ADSP code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   97 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h |    5 +++
 2 files changed, 100 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 43bc69f..bc780cc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -102,8 +103,9 @@
 #define ADSP1_START_SHIFT                      0  /* DSP1_START */
 #define ADSP1_START_WIDTH                      1  /* DSP1_START */
 
-#define ADSP2_CONTROL 0
-#define ADSP2_STATUS1 4
+#define ADSP2_CONTROL  0
+#define ADSP2_CLOCKING 1
+#define ADSP2_STATUS1  4
 
 /*
  * ADSP2 Control
@@ -127,6 +129,13 @@
 #define ADSP2_START_WIDTH                      1  /* DSP1_START */
 
 /*
+ * ADSP2 clocking
+ */
+#define ADSP2_CLK_SEL_MASK                0x0007  /* CLK_SEL_ENA */
+#define ADSP2_CLK_SEL_SHIFT                    0  /* CLK_SEL_ENA */
+#define ADSP2_CLK_SEL_WIDTH                    3  /* CLK_SEL_ENA */
+
+/*
  * ADSP2 Status 1
  */
 #define ADSP2_RAM_RDY                     0x0001
@@ -669,10 +678,41 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_codec *codec = w->codec;
 	struct wm_adsp *dsps = snd_soc_codec_get_drvdata(codec);
 	struct wm_adsp *dsp = &dsps[w->shift];
+	unsigned int val;
 	int ret;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
+		if (dsp->dvfs) {
+			ret = regmap_read(dsp->regmap,
+					  dsp->base + ADSP2_CLOCKING, &val);
+			if (ret != 0) {
+				dev_err(dsp->dev,
+					"Failed to read clocking: %d\n", ret);
+				return ret;
+			}
+
+			if (val & ADSP2_CLK_SEL_MASK >= 3) {
+				ret = regulator_enable(dsp->dvfs);
+				if (ret != 0) {
+					dev_err(dsp->dev,
+						"Failed to enable supply: %d\n",
+						ret);
+					return ret;
+				}
+
+				ret = regulator_set_voltage(dsp->dvfs,
+							    1800000,
+							    1800000);
+				if (ret != 0) {
+					dev_err(dsp->dev,
+						"Failed to raise supply: %d\n",
+						ret);
+					return ret;
+				}
+			}
+		}
+
 		ret = wm_adsp2_ena(dsp);
 		if (ret != 0)
 			return ret;
@@ -699,6 +739,21 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_PRE_PMD:
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				   ADSP2_SYS_ENA | ADSP2_START, 0);
+
+		if (dsp->dvfs) {
+			ret = regulator_set_voltage(dsp->dvfs, 1200000,
+						    1800000);
+			if (ret != 0)
+				dev_warn(dsp->dev,
+					 "Failed to lower supply: %d\n",
+					 ret);
+
+			ret = regulator_disable(dsp->dvfs);
+			if (ret != 0)
+				dev_err(dsp->dev,
+					"Failed to enable supply: %d\n",
+					ret);
+		}
 		break;
 
 	default:
@@ -712,3 +767,41 @@ err:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_event);
+
+int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
+{
+	int ret;
+
+	if (dvfs) {
+		adsp->dvfs = devm_regulator_get(adsp->dev, "DCVDD");
+		if (IS_ERR(adsp->dvfs)) {
+			ret = PTR_ERR(adsp->dvfs);
+			dev_err(adsp->dev, "Failed to get DCVDD: %d\n", ret);
+			return ret;
+		}
+
+		ret = regulator_enable(adsp->dvfs);
+		if (ret != 0) {
+			dev_err(adsp->dev, "Failed to enable DCVDD: %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = regulator_set_voltage(adsp->dvfs, 1200000, 1800000);
+		if (ret != 0) {
+			dev_err(adsp->dev, "Failed to initialise DVFS: %d\n",
+				ret);
+			return ret;
+		}
+
+		ret = regulator_disable(adsp->dvfs);
+		if (ret != 0) {
+			dev_err(adsp->dev, "Failed to disable DCVDD: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index b303b1f..ffd29a4 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -18,6 +18,8 @@
 
 #include "wmfw.h"
 
+struct regulator;
+
 struct wm_adsp_region {
 	int type;
 	unsigned int base;
@@ -34,6 +36,8 @@ struct wm_adsp {
 
 	const struct wm_adsp_region *mem;
 	int num_mems;
+
+	struct regulator *dvfs;
 };
 
 #define WM_ADSP1(wname, num) \
@@ -46,6 +50,7 @@ struct wm_adsp {
 	.shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
+int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs);
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
-- 
1.7.10.4
