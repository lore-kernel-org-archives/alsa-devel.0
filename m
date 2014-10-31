From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Add Merrifield machine driver
Date: Fri, 31 Oct 2014 15:41:38 +0530
Message-ID: <1414750298-23287-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D093260597
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 11:53:00 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds machine driver support for Merrifield platform.
Patch has dependency on Merrifield DSP driver.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
this is standalone patch with no depends on other code posted

 sound/soc/intel/Kconfig            |   15 ++
 sound/soc/intel/Makefile           |    2 +
 sound/soc/intel/merr_dpcm_wm8958.c |  430 ++++++++++++++++++++++++++++++++++++
 3 files changed, 447 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/merr_dpcm_wm8958.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2a3af88..16d1801 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -76,3 +76,18 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y if you have such a device
 	  If unsure select "N".
+
+config SND_SOC_INTEL_MRFLD_WM8958_MACH
+	tristate "SOC Machine Audio driver for Intel Merrifield MID platform"
+	depends on X86
+	select SND_SOC_WM8994
+	select MFD_CORE
+	select MFD_WM8994
+	select REGULATOR_WM8994
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC
+	help
+	  This adds support for ASoC machine driver for Intel(R) MID Merrifield platform
+          used as alsa device in audio substem in Intel(R) MID devices
+          Say Y if you have such a device
+          If unsure select "N".
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 9ab43be..9d4b3d4 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -26,6 +26,7 @@ snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
+snd-merr-dpcm-wm8958-objs := merr_dpcm_wm8958.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
@@ -34,3 +35,4 @@ obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 
 # DSP driver
 obj-$(CONFIG_SND_SST_IPC) += sst/
+obj-$(CONFIG_SND_SOC_INTEL_MRFLD_WM8958_MACH) += snd-merr-dpcm-wm8958.o
diff --git a/sound/soc/intel/merr_dpcm_wm8958.c b/sound/soc/intel/merr_dpcm_wm8958.c
new file mode 100644
index 0000000..4ac6a72
--- /dev/null
+++ b/sound/soc/intel/merr_dpcm_wm8958.c
@@ -0,0 +1,430 @@
+/*
+ *  merr_dpcm_wm8958.c - ASoc DPCM Machine driver for Intel Merrfield MID platform
+ *
+ *  Copyright (C) 2013-14 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/async.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <linux/input.h>
+
+#include <linux/mfd/wm8994/core.h>
+#include <linux/mfd/wm8994/registers.h>
+#include <linux/mfd/wm8994/pdata.h>
+#include "../codecs/wm8994.h"
+#include "sst-atom-controls.h"
+
+/* Codec PLL output clk rate */
+#define CODEC_SYSCLK_RATE			24576000
+/* Input clock to codec at MCLK1 PIN */
+#define CODEC_IN_MCLK1_RATE			19200000
+/* Input clock to codec at MCLK2 PIN */
+#define CODEC_IN_MCLK2_RATE			32768
+/*  define to select between MCLK1 and MCLK2 input to codec as its clock */
+#define CODEC_IN_MCLK1				1
+#define CODEC_IN_MCLK2				2
+#define CODEC_BE				1
+
+struct mrfld_8958_mc_private {
+	struct snd_soc_jack jack;
+	int jack_retry;
+};
+
+/*
+ * Function to switch the input clock for codec,  When audio is in
+ * progress input clock to codec will be through MCLK1 which is 19.2MHz
+ * while in off state input clock to codec will be through 32KHz through
+ * MCLK2
+ * card	: Sound card structure
+ * src	: Input clock source to codec
+ */
+static int mrfld_8958_set_codec_clk(struct snd_soc_card *card, int src)
+{
+	int ret;
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	switch (src) {
+	case CODEC_IN_MCLK1:
+		/* Turn ON the PLL to generate required sysclk rate
+		 * from MCLK1
+		 */
+		ret = snd_soc_dai_set_pll(aif1_dai,
+			WM8994_FLL1, WM8994_FLL_SRC_MCLK1,
+			CODEC_IN_MCLK1_RATE, CODEC_SYSCLK_RATE);
+		if (ret < 0) {
+			dev_err(card->dev, "Failed to start FLL: %d\n", ret);
+			return ret;
+		}
+		/* Switch to MCLK1 input */
+		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_FLL1,
+				CODEC_SYSCLK_RATE, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "Failed to set codec sysclk configuration %d\n",
+				 ret);
+			return ret;
+		}
+		break;
+	case CODEC_IN_MCLK2:
+		/* Switch to MCLK2 */
+		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
+				32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "Failed to switch to MCLK2: %d\n", ret);
+			return ret;
+		}
+		/* Turn off PLL for MCLK1 */
+		ret = snd_soc_dai_set_pll(aif1_dai, WM8994_FLL1, 0, 0, 0);
+		if (ret < 0) {
+			dev_err(card->dev, "Failed to stop the FLL: %d", ret);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mrfld_wm8958_set_clk(struct snd_soc_dai *codec_dai)
+{
+	int ret = 0;
+	struct snd_soc_card *card = codec_dai->card;
+
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf0, 0xf0, 4, 24);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
+		return ret;
+	}
+
+	ret = mrfld_8958_set_codec_clk(card, CODEC_IN_MCLK1);
+
+	return ret;
+}
+
+static int mrfld_8958_hw_params(struct snd_pcm_substream *substream,
+			   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	return mrfld_wm8958_set_clk(codec_dai);
+}
+
+static const struct snd_soc_pcm_stream mrfld_wm8958_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
+static int merr_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP2 to 24-bit */
+	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
+				    SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int mrfld_8958_set_bias_level(struct snd_soc_card *card,
+				struct snd_soc_dapm_context *dapm,
+				enum snd_soc_bias_level level)
+{
+	int ret = 0;
+	/* "wm8994-aif1" */
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	if (dapm->dev != aif1_dai->dev)
+		return 0;
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY)
+
+			ret = mrfld_wm8958_set_clk(aif1_dai);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int mrfld_8958_set_bias_level_post(struct snd_soc_card *card,
+		 struct snd_soc_dapm_context *dapm,
+		 enum snd_soc_bias_level level)
+{
+	int ret = 0;
+	/* "wm8994-aif1" */
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	if (dapm->dev != aif1_dai->dev)
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		/*
+		 * We are in standby down so */
+		/* Switch to 32KHz MCLK2 input clock for codec
+		 */
+		ret = mrfld_8958_set_codec_clk(card, CODEC_IN_MCLK2);
+		break;
+	default:
+		break;
+	}
+	if (&card->dapm == dapm)
+		card->dapm.bias_level = level;
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
+	SND_SOC_DAPM_MIC("DMIC", NULL),
+};
+
+static const struct snd_soc_dapm_route map[] = {
+	{ "Headphones", NULL, "HPOUT1L" },
+	{ "Headphones", NULL, "HPOUT1R" },
+
+	/*
+	 * This machine uses 2 DMICs, other configs may use more so change
+	 * below accordingly
+	 */
+	{ "DMIC1DAT", NULL, "DMIC" },
+	{ "DMIC2DAT", NULL, "DMIC" },
+
+	/*
+	 * MICBIAS2 is connected as Bias for AMIC so we link it
+	 * here. Also AMIC wires up to IN1LP pin.
+	 * DMIC is externally connected to 1.8V rail, so no link rqd.
+	 */
+	{ "AMIC", NULL, "MICBIAS2" },
+	{ "IN1LP", NULL, "AMIC" },
+
+	/* dsp map link the SWM outs to codec AIF */
+	{ "AIF1 Playback", NULL, "ssp2 Tx"},
+	{ "ssp2 Tx", NULL, "codec_out0"},
+	{ "ssp2 Tx", NULL, "codec_out1"},
+	{ "codec_in0", NULL, "ssp2 Rx" },
+	{ "codec_in1", NULL, "ssp2 Rx" },
+	{ "ssp2 Rx", NULL, "AIF1 Capture"},
+
+};
+
+static const struct wm8958_micd_rate micdet_rates[] = {
+	{ 32768,       true,  1, 4 },
+	{ 32768,       false, 1, 1 },
+	{ 44100 * 256, true,  7, 10 },
+	{ 44100 * 256, false, 7, 10 },
+};
+
+static int mrfld_8958_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+	struct mrfld_8958_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+	struct snd_soc_codec *codec = aif1_dai->codec;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	ret = snd_soc_dai_set_tdm_slot(aif1_dai, 0xf0, 0xf0, 4, 24);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set codec pcm format %d\n", ret);
+		return ret;
+	}
+
+	card->dapm.idle_bias_off = true;
+
+	if (!codec) {
+		dev_err(card->dev, "%s: we didnt find the codec pointer!\n", __func__);
+		return 0;
+	}
+
+	ctx->jack_retry = 0;
+	ret = snd_soc_jack_new(codec, "Intel MID Audio Jack",
+			       SND_JACK_HEADSET | SND_JACK_HEADPHONE |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1,
+				&ctx->jack);
+	if (ret) {
+		dev_err(card->dev, "jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
+	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+
+	wm8958_mic_detect(codec, &ctx->jack, NULL, NULL, NULL, NULL);
+
+	return 0;
+}
+
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+static int mrfld_8958_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops mrfld_8958_ops = {
+	.startup = mrfld_8958_startup,
+};
+
+static struct snd_soc_ops mrfld_8958_be_ssp2_ops = {
+	.hw_params = mrfld_8958_hw_params,
+};
+
+struct snd_soc_dai_link mrfld_8958_msic_dailink[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Merrifield Audio Port",
+		.stream_name = "Merrifield Audio",
+		.cpu_dai_name = "Headset-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "sst-platform",
+		.init = mrfld_8958_init,
+		.ignore_suspend = 1,
+		.dynamic = 1,
+		.ops = &mrfld_8958_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Merrifield Compress Port",
+		.stream_name = "Merrifield Compress",
+		.platform_name = "sst-platform",
+		.cpu_dai_name = "Compress-cpu-dai",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.dynamic = 1,
+		.init = mrfld_8958_init,
+	},
+
+	/* back ends */
+	{
+		.name = "SSP2-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "wm8994-aif1",
+		.codec_name = "wm8994-codec",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
+			SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = merr_codec_fixup,
+		.ignore_suspend = 1,
+		.ops = &mrfld_8958_be_ssp2_ops,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_mrfld = {
+	.name = "wm8958-audio",
+	.dai_link = mrfld_8958_msic_dailink,
+	.num_links = ARRAY_SIZE(mrfld_8958_msic_dailink),
+	.set_bias_level = mrfld_8958_set_bias_level,
+	.set_bias_level_post = mrfld_8958_set_bias_level_post,
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = map,
+	.num_dapm_routes = ARRAY_SIZE(map),
+	.fully_routed = true,
+};
+
+static int snd_mrfld_8958_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+	struct mrfld_8958_mc_private *drv;
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	/* register the soc card */
+	snd_soc_card_mrfld.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&snd_soc_card_mrfld, drv);
+	ret_val = snd_soc_register_card(&snd_soc_card_mrfld);
+	if (ret_val) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed %d\n", ret_val);
+		goto unalloc;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_mrfld);
+	return ret_val;
+
+unalloc:
+	return ret_val;
+}
+
+static int snd_mrfld_8958_mc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
+
+	snd_soc_card_set_drvdata(soc_card, NULL);
+	snd_soc_unregister_card(soc_card);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static struct platform_driver snd_mrfld_8958_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "mrfld_wm8958",
+	},
+	.probe = snd_mrfld_8958_mc_probe,
+	.remove = snd_mrfld_8958_mc_remove,
+};
+
+module_platform_driver(snd_mrfld_8958_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Merrifield MID Machine driver");
+MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:mrfld_wm8958");
-- 
1.7.0.4
