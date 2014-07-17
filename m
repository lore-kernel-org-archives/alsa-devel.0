From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: Intel: Add merrifield machine driver
Date: Thu, 17 Jul 2014 17:43:45 +0530
Message-ID: <1405599225-31538-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DD05F265526
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 14:34:42 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds machine driver support for merrifield platform.
Patch has dependency on merrifield DSP driver.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
Changes in v2:
	Removed get_codec/find_codec, instead use rtd index
	Using dai_fmt field of the dai_link

This patch has dependency on "add mrfld DSP support".

 sound/soc/intel/Kconfig            |  16 ++
 sound/soc/intel/Makefile           |   2 +
 sound/soc/intel/merr_dpcm_wm8958.c | 522 +++++++++++++++++++++++++++++++++++++
 3 files changed, 540 insertions(+)
 create mode 100644 sound/soc/intel/merr_dpcm_wm8958.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c6fe1e498a02..5f6345a6d77e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -58,3 +58,19 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the MAX98090 audio codec.
+
+config SND_SOC_INTEL_MRFLD_WM8958_MACH
+	tristate "SOC Machine Audio driver for Intel Merrifield MID platform"
+	depends on X86
+	select SND_SOC_WM8994
+	select MFD_CORE
+	select MFD_WM8994
+	select REGULATOR_WM8994
+	select SND_SST_MFLD_PLATFORM
+	select SND_SOC_INTEL_SST
+	default n
+	help
+	  This adds support for ASoC machine driver for Intel(R) MID Merrifield platform
+          used as alsa device in audio substem in Intel(R) MID devices
+          Say Y if you have such a device
+          If unsure select "N".
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 9480b5d40e02..05da1093c777 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -25,7 +25,9 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
+snd-merr-dpcm-wm8958-objs := merr_dpcm_wm8958.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_MRFLD_WM8958_MACH) += snd-merr-dpcm-wm8958.o
diff --git a/sound/soc/intel/merr_dpcm_wm8958.c b/sound/soc/intel/merr_dpcm_wm8958.c
new file mode 100644
index 000000000000..7ef44a3ee608
--- /dev/null
+++ b/sound/soc/intel/merr_dpcm_wm8958.c
@@ -0,0 +1,522 @@
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
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
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
+	/* "wm8994-aif1" */
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	switch (src) {
+	case CODEC_IN_MCLK1:
+		/* Turn ON the PLL to generate required sysclk rate
+		 * from MCLK1 */
+		ret = snd_soc_dai_set_pll(aif1_dai,
+			WM8994_FLL1, WM8994_FLL_SRC_MCLK1,
+			CODEC_IN_MCLK1_RATE, CODEC_SYSCLK_RATE);
+		if (ret < 0) {
+			pr_err("Failed to start FLL: %d\n", ret);
+			return ret;
+		}
+		/* Switch to MCLK1 input */
+		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_FLL1,
+				CODEC_SYSCLK_RATE, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to set codec sysclk configuration %d\n",
+				 ret);
+			return ret;
+		}
+		break;
+	case CODEC_IN_MCLK2:
+		/* Switch to MCLK2 */
+		ret = snd_soc_dai_set_sysclk(aif1_dai, WM8994_SYSCLK_MCLK2,
+				32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to switch to MCLK2: %d", ret);
+			return ret;
+		}
+		/* Turn off PLL for MCLK1 */
+		ret = snd_soc_dai_set_pll(aif1_dai, WM8994_FLL1, 0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop the FLL: %d", ret);
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
+	pr_err("setting snd_soc_dai_set_tdm_slot\n");
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xf0, 0xf0, 4, 24);
+	if (ret < 0) {
+		pr_err("can't set codec pcm format %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * FIXME: move this to SYS_CLOCK event handler when codec driver
+	 * dependency is clean.
+	 */
+	/* Switch to 19.2MHz MCLK1 input clock for codec */
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
+	if (!strcmp(codec_dai->name, "wm8994-aif1"))
+		return mrfld_wm8958_set_clk(codec_dai);
+	return 0;
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
+	pr_debug("Invoked %s for dailink %s\n", __func__, rtd->dai_link->name);
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
+	pr_debug("%s card(%s)->bias_level %u\n", __func__, card->name,
+			card->dapm.bias_level);
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
+	pr_debug("%s card(%s)->bias_level %u\n", __func__, card->name,
+			card->dapm.bias_level);
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
+	 * Machine uses 2 DMICs, other configs may use more so change below
+	 * accordingly
+	 */
+	{ "DMIC1DAT", NULL, "DMIC" },
+	{ "DMIC2DAT", NULL, "DMIC" },
+	/*{ "DMIC3DAT", NULL, "DMIC" },*/
+	/*{ "DMIC4DAT", NULL, "DMIC" },*/
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
+	/* "wm8994-aif1" */
+	struct snd_soc_dai *aif1_dai = card->rtd[CODEC_BE].codec_dai;
+	struct snd_soc_codec *codec = aif1_dai->codec;
+
+	if (!aif1_dai)
+		return -ENODEV;
+
+	pr_debug("Entry %s\n", __func__);
+
+	ret = snd_soc_dai_set_tdm_slot(aif1_dai, 0xf0, 0xf0, 4, 24);
+	if (ret < 0) {
+		pr_err("can't set codec pcm format %d\n", ret);
+		return ret;
+	}
+
+	card->dapm.idle_bias_off = true;
+
+	/* Force enable VMID to avoid cold latency constraints */
+	snd_soc_dapm_force_enable_pin(&card->dapm, "VMID");
+	snd_soc_dapm_sync(&card->dapm);
+
+	if (!codec) {
+		pr_err("%s: we didnt find the codec pointer!\n", __func__);
+		return 0;
+	}
+
+	ctx->jack_retry = 0;
+	ret = snd_soc_jack_new(codec, "Intel MID Audio Jack",
+			       SND_JACK_HEADSET | SND_JACK_HEADPHONE |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1,
+				&ctx->jack);
+	if (ret) {
+		pr_err("jack creation failed\n");
+		return ret;
+	}
+
+	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_1, KEY_MEDIA);
+	snd_jack_set_key(ctx->jack.jack, SND_JACK_BTN_0, KEY_MEDIA);
+
+	wm8958_mic_detect(codec, &ctx->jack, NULL, NULL, NULL, NULL);
+
+	/*
+	 * Micbias1 is always off, so for pm optimizations make sure the micbias1
+	 * discharge bit is set to floating to avoid discharge in disable state
+	 */
+	snd_soc_update_bits(codec, WM8958_MICBIAS1, WM8958_MICB1_DISCH, 0);
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
+#ifdef CONFIG_PM_SLEEP
+static int snd_mrfld_8958_prepare(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_codec *codec = card->rtd[CODEC_BE].codec;
+	struct snd_soc_dapm_context *dapm;
+
+	pr_debug("In %s\n", __func__);
+
+	pr_debug("found codec %s\n", codec->component.name);
+	dapm = &codec->dapm;
+
+	snd_soc_dapm_disable_pin(dapm, "VMID");
+	snd_soc_dapm_sync(dapm);
+
+	snd_soc_suspend(dev);
+	return 0;
+}
+
+static void snd_mrfld_8958_complete(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_codec *codec = card->rtd[CODEC_BE].codec;
+	struct snd_soc_dapm_context *dapm;
+
+	pr_debug("In %s\n", __func__);
+
+	pr_debug("found codec %s\n", codec->component.name);
+	dapm = &codec->dapm;
+
+	snd_soc_dapm_force_enable_pin(dapm, "VMID");
+	snd_soc_dapm_sync(dapm);
+
+	snd_soc_resume(dev);
+}
+
+static int snd_mrfld_8958_poweroff(struct device *dev)
+{
+	pr_debug("In %s\n", __func__);
+	snd_soc_poweroff(dev);
+	return 0;
+}
+#else
+#define snd_mrfld_8958_prepare NULL
+#define snd_mrfld_8958_complete NULL
+#define snd_mrfld_8958_poweroff NULL
+#endif
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
+	pr_debug("Entry %s\n", __func__);
+
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv) {
+		pr_err("allocation failed\n");
+		return -ENOMEM;
+	}
+
+	/* register the soc card */
+	snd_soc_card_mrfld.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&snd_soc_card_mrfld, drv);
+	ret_val = snd_soc_register_card(&snd_soc_card_mrfld);
+	if (ret_val) {
+		pr_err("snd_soc_register_card failed %d\n", ret_val);
+		goto unalloc;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_mrfld);
+	pr_info("%s successful\n", __func__);
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
+	pr_debug("In %s\n", __func__);
+	snd_soc_card_set_drvdata(soc_card, NULL);
+	snd_soc_unregister_card(soc_card);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+const struct dev_pm_ops snd_mrfld_8958_mc_pm_ops = {
+	.prepare = snd_mrfld_8958_prepare,
+	.complete = snd_mrfld_8958_complete,
+	.poweroff = snd_mrfld_8958_poweroff,
+};
+
+static struct platform_driver snd_mrfld_8958_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "mrfld_wm8958",
+		.pm = &snd_mrfld_8958_mc_pm_ops,
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
1.9.0
