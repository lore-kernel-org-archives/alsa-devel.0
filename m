From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Adding
	nau88l25+ssm4567 machine driver
Date: Thu,  5 Nov 2015 22:53:07 +0530
Message-ID: <1446744188-1274-3-git-send-email-vinod.koul@intel.com>
References: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 817D926054D
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 18:19:48 +0100 (CET)
In-Reply-To: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Conrad Cooke <conrad.cooke@intel.com>, liam.r.girdwood@linux.intel.com, Harsha Priya <harshapriya.n@intel.com>, broonie@kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, Naveen M <naveen.m@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Fang,
 Yang A" <yang.a.fang@intel.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Harsha Priya <harshapriya.n@intel.com>

Add i2s machine driver with NAU88L25 and SSM4567 codecs

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Conrad Cooke <conrad.cooke@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig                       |  14 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 368 ++++++++++++++++++++++++++
 3 files changed, 384 insertions(+)
 create mode 100644 sound/soc/intel/boards/skl_nau88l25_ssm4567.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 13a762172b5d..814b26bbad58 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -155,3 +155,17 @@ config SND_SOC_INTEL_SKL_RT286_MACH
 	   with RT286 I2S audio codec.
 	   Say Y if you have such a device
 	   If unsure select "N".
+
+config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
+	tristate "ASoC Audio driver for SKL with NAU88L25 and SSM4567 in I2S Mode"
+	depends on X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_NAU8825
+	select SND_SOC_SSM4567
+	select SND_SOC_DMIC
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for NAU88L25 + SSM4567.
+	  Say Y if you have such a device
+	  If unsure select "N".
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 371c4565cad8..a59f76277cee 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -7,6 +7,7 @@ snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 snd-soc-skl_rt286-objs := skl_rt286.o
+snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
@@ -17,3 +18,4 @@ obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_RT286_MACH) += snd-soc-skl_rt286.o
+obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH) += snd-soc-skl_nau88l25_ssm4567.o
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
new file mode 100644
index 000000000000..3f5a96b585b8
--- /dev/null
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -0,0 +1,368 @@
+/*
+ * Intel Skylake I2S Machine Driver for NAU88L25+SSM4567
+ *
+ * Copyright (C) 2015, Intel Corporation. All rights reserved.
+ *
+ * Modified from:
+ *   Intel Skylake I2S Machine Driver for NAU88L25 and SSM4567
+ *
+ *   Copyright (C) 2015, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include "../../codecs/nau8825.h"
+
+#define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
+#define SKL_SSM_CODEC_DAI	"ssm4567-hifi"
+
+static struct snd_soc_jack skylake_headset;
+static struct snd_soc_card skylake_audio_card;
+
+static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
+{
+	int i;
+
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd;
+
+		rtd = card->rtd + i;
+		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
+			     strlen(SKL_NUVOTON_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
+static const struct snd_kcontrol_new skylake_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Left Speaker"),
+	SOC_DAPM_PIN_SWITCH("Right Speaker"),
+};
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+	int ret;
+
+	codec_dai = skl_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+				NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "set sysclk err = %d\n", ret);
+			return -EIO;
+		}
+	} else {
+		ret = snd_soc_dai_set_sysclk(codec_dai,
+				NAU8825_CLK_INTERNAL, 0, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "set sysclk err = %d\n", ret);
+			return -EIO;
+		}
+	}
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget skylake_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Left Speaker", NULL),
+	SND_SOC_DAPM_SPK("Right Speaker", NULL),
+	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route skylake_map[] = {
+	/* HP jack connectors - unknown if we have jack detection */
+	{"Headphone Jack", NULL, "HPOL"},
+	{"Headphone Jack", NULL, "HPOR"},
+
+	/* speaker */
+	{"Left Speaker", NULL, "Left OUT"},
+	{"Right Speaker", NULL, "Right OUT"},
+
+	/* other jacks */
+	{"MIC", NULL, "Headset Mic"},
+	{"DMIC AIF", NULL, "SoC DMIC"},
+
+	/* CODEC BE connections */
+	{ "Left Playback", NULL, "ssp0 Tx"},
+	{ "Right Playback", NULL, "ssp0 Tx"},
+	{ "ssp0 Tx", NULL, "codec0_out"},
+
+	{ "AIF1 Playback", NULL, "ssp1 Tx"},
+	{ "ssp1 Tx", NULL, "codec1_out"},
+
+	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "ssp1 Rx", NULL, "AIF1 Capture" },
+
+	/* DMIC */
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+};
+
+static struct snd_soc_codec_conf ssm4567_codec_conf[] = {
+	{
+		.dev_name = "i2c-INT343B:00",
+		.name_prefix = "Left",
+	},
+	{
+		.dev_name = "i2c-INT343B:01",
+		.name_prefix = "Right",
+	},
+};
+
+static struct snd_soc_dai_link_component ssm4567_codec_components[] = {
+	{ /* Left */
+		.name = "i2c-INT343B:00",
+		.dai_name = SKL_SSM_CODEC_DAI,
+	},
+	{ /* Right */
+		.name = "i2c-INT343B:01",
+		.dai_name = SKL_SSM_CODEC_DAI,
+	},
+};
+
+static int skylake_ssm4567_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+
+	/* Slot 1 for left */
+	ret = snd_soc_dai_set_tdm_slot(rtd->codec_dais[0], 0x01, 0x01, 2, 48);
+	if (ret < 0)
+		return ret;
+
+	/* Slot 2 for right */
+	ret = snd_soc_dai_set_tdm_slot(rtd->codec_dais[1], 0x02, 0x02, 2, 48);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	/*
+	 * 4 buttons here map to the google Reference headset
+	 * The use of these buttons can be decided by the user space.
+	 */
+	ret = snd_soc_card_jack_new(&skylake_audio_card, "Headset Jack",
+		SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset,
+		NULL, 0);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	nau8825_enable_jack_detect(codec, &skylake_headset);
+
+	return ret;
+}
+
+static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	/* The ADSP will covert the FE rate to 48k, stereo */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP0 to 24 bit */
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int skylake_nau8825_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+			NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
+
+	if (ret < 0)
+		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+
+	return ret;
+}
+
+static struct snd_soc_ops skylake_nau8825_ops = {
+	.hw_params = skylake_nau8825_hw_params,
+};
+
+/* skylake digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link skylake_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "Skl Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Skl Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "Skl Audio Reference cap",
+		.stream_name = "refcap",
+		.cpu_dai_name = "Reference Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "SSP0-Codec",
+		.be_id = 0,
+		.cpu_dai_name = "SSP0 Pin",
+		.platform_name = "0000:00:1f.3",
+		.no_pcm = 1,
+		.codecs = ssm4567_codec_components,
+		.num_codecs = ARRAY_SIZE(ssm4567_codec_components),
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.init = skylake_ssm4567_codec_init,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = skylake_ssp_fixup,
+		.dpcm_playback = 1,
+	},
+	{
+		/* SSP1 - Codec */
+		.name = "SSP1-Codec",
+		.be_id = 0,
+		.cpu_dai_name = "SSP1 Pin",
+		.platform_name = "0000:00:1f.3",
+		.no_pcm = 1,
+		.codec_name = "i2c-10508825:00",
+		.codec_dai_name = SKL_NUVOTON_CODEC_DAI,
+		.init = skylake_nau8825_codec_init,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = skylake_ssp_fixup,
+		.ops = &skylake_nau8825_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "dmic01",
+		.be_id = 1,
+		.cpu_dai_name = "DMIC01 Pin",
+		.codec_name = "dmic-codec",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "0000:00:1f.3",
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
+};
+
+/* skylake audio machine driver for SPT + NAU88L25 */
+static struct snd_soc_card skylake_audio_card = {
+	.name = "sklnau8825adi",
+	.owner = THIS_MODULE,
+	.dai_link = skylake_dais,
+	.num_links = ARRAY_SIZE(skylake_dais),
+	.controls = skylake_controls,
+	.num_controls = ARRAY_SIZE(skylake_controls),
+	.dapm_widgets = skylake_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(skylake_widgets),
+	.dapm_routes = skylake_map,
+	.num_dapm_routes = ARRAY_SIZE(skylake_map),
+	.codec_conf = ssm4567_codec_conf,
+	.num_configs = ARRAY_SIZE(ssm4567_codec_conf),
+};
+
+static int skylake_audio_probe(struct platform_device *pdev)
+{
+	skylake_audio_card.dev = &pdev->dev;
+
+	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
+}
+
+static struct platform_driver skylake_audio = {
+	.probe = skylake_audio_probe,
+	.driver = {
+		.name = "skl_nau88l25_ssm4567_i2s",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+
+module_platform_driver(skylake_audio)
+
+/* Module information */
+MODULE_AUTHOR("Conrad Cooke  <conrad.cooke@intel.com>");
+MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
+MODULE_AUTHOR("Naveen M <naveen.m@intel.com>");
+MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
+MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
+MODULE_DESCRIPTION("Intel Audio Machine driver for SKL with NAU88L25 and SSM4567 in I2S Mode");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:skl_nau88l25_ssm4567_i2s");
-- 
1.9.1
