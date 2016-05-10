From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Add Broxton-P machine driver
Date: Tue, 10 May 2016 22:02:06 +0530
Message-ID: <1462897926-20271-3-git-send-email-vinod.koul@intel.com>
References: <1462897926-20271-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 928742652C5
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 18:26:31 +0200 (CEST)
In-Reply-To: <1462897926-20271-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, Ramesh Babu <ramesh.babu@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ramesh Babu <ramesh.babu@intel.com>

This patch adds the Broxton-P machine driver for Intel Broxton-P
reference boards. This machine uses the RT298 codec

Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig            |  15 ++
 sound/soc/intel/boards/Makefile    |   2 +
 sound/soc/intel/boards/bxt_rt298.c | 353 +++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 sound/soc/intel/boards/bxt_rt298.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 399afa118822..91c15abb625e 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -58,6 +58,21 @@ config SND_SOC_INTEL_HASWELL_MACH
 	  Say Y if you have such a device
 	  If unsure select "N".
 
+config SND_SOC_INTEL_BXT_RT298_MACH
+	tristate "ASoC Audio driver for Broxton with RT298 I2S mode"
+	depends on X86 && ACPI && I2C
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_RT298
+	select SND_SOC_DMIC
+	select SND_SOC_HDAC_HDMI
+	select SND_HDA_DSP_LOADER
+	help
+	   This adds support for ASoC machine driver for Broxton platforms
+	   with RT286 I2S audio codec.
+	   Say Y if you have such a device
+	   If unsure select "N".
+
 config SND_SOC_INTEL_BYT_RT5640_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with RT5640 codec"
 	depends on X86_INTEL_LPSS && I2C
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 3310c0f9c356..a8506774f510 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -2,6 +2,7 @@ snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
+snd-soc-sst-bxt-rt298-objs := bxt_rt298.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
 snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
@@ -14,6 +15,7 @@ snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BXT_RT298_MACH) += snd-soc-sst-bxt-rt298.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
new file mode 100644
index 000000000000..1b845ff779f3
--- /dev/null
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -0,0 +1,353 @@
+/*
+ * Intel Broxton-P I2S Machine Driver
+ *
+ * Copyright (C) 2014-2016, Intel Corporation. All rights reserved.
+ *
+ * Modified from:
+ *   Intel Skylake I2S Machine driver
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
+#include "../../codecs/hdac_hdmi.h"
+#include "../../codecs/rt298.h"
+
+static struct snd_soc_jack broxton_headset;
+/* Headset jack detection DAPM pins */
+
+enum {
+	BXT_DPCM_AUDIO_PB = 0,
+	BXT_DPCM_AUDIO_CP,
+	BXT_DPCM_AUDIO_REF_CP,
+	BXT_DPCM_AUDIO_HDMI1_PB,
+	BXT_DPCM_AUDIO_HDMI2_PB,
+	BXT_DPCM_AUDIO_HDMI3_PB,
+};
+
+static struct snd_soc_jack_pin broxton_headset_pins[] = {
+	{
+		.pin = "Mic Jack",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone Jack",
+		.mask = SND_JACK_HEADPHONE,
+	},
+};
+
+static const struct snd_kcontrol_new broxton_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Mic Jack"),
+};
+
+static const struct snd_soc_dapm_widget broxton_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_MIC("DMIC2", NULL),
+	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+	SND_SOC_DAPM_SPK("HDMI1", NULL),
+	SND_SOC_DAPM_SPK("HDMI2", NULL),
+	SND_SOC_DAPM_SPK("HDMI3", NULL),
+};
+
+static const struct snd_soc_dapm_route broxton_rt298_map[] = {
+	/* speaker */
+	{"Speaker", NULL, "SPOR"},
+	{"Speaker", NULL, "SPOL"},
+
+	/* HP jack connectors - unknown if we have jack detect */
+	{"Headphone Jack", NULL, "HPO Pin"},
+
+	/* other jacks */
+	{"MIC1", NULL, "Mic Jack"},
+
+	/* digital mics */
+	{"DMIC1 Pin", NULL, "DMIC2"},
+	{"DMic", NULL, "SoC DMIC"},
+
+	{"HDMI1", NULL, "hif5 Output"},
+	{"HDMI2", NULL, "hif6 Output"},
+	{"HDMI3", NULL, "hif7 Output"},
+
+	/* CODEC BE connections */
+	{ "AIF1 Playback", NULL, "ssp5 Tx"},
+	{ "ssp5 Tx", NULL, "codec0_out"},
+
+	{ "codec0_in", NULL, "ssp5 Rx" },
+	{ "ssp5 Rx", NULL, "AIF1 Capture" },
+
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "DMIC01 Rx", NULL, "Capture" },
+
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+
+};
+
+static int broxton_rt298_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret = 0;
+
+	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+		SND_JACK_HEADSET | SND_JACK_BTN_0,
+		&broxton_headset,
+		broxton_headset_pins, ARRAY_SIZE(broxton_headset_pins));
+
+	if (ret)
+		return ret;
+
+	rt298_mic_detect(codec, &broxton_headset);
+	return 0;
+}
+
+static int broxton_hdmi_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *dai = rtd->codec_dai;
+
+	return hdac_hdmi_jack_init(dai, BXT_DPCM_AUDIO_HDMI1_PB + dai->id);
+}
+
+static int broxton_ssp5_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	/* The ADSP will covert the FE rate to 48k, stereo */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP5 to 24 bit */
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+
+	return 0;
+}
+
+static int broxton_rt298_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT298_SCLK_S_PLL,
+					19200000, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops broxton_rt298_ops = {
+	.hw_params = broxton_rt298_hw_params,
+};
+
+/* broxton digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link broxton_rt298_dais[] = {
+	/* Front End DAI links */
+	[BXT_DPCM_AUDIO_PB]
+	{
+		.name = "Bxt Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:0e.0",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	[BXT_DPCM_AUDIO_CP]
+	{
+		.name = "Bxt Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:0e.0",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+	},
+	[BXT_DPCM_AUDIO_REF_CP]
+	{
+		.name = "Bxt Audio Reference cap",
+		.stream_name = "refcap",
+		.cpu_dai_name = "Reference Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[BXT_DPCM_AUDIO_HDMI1_PB]
+	{
+		.name = "Bxt HDMI Port1",
+		.stream_name = "Hdmi1",
+		.cpu_dai_name = "HDMI1 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[BXT_DPCM_AUDIO_HDMI2_PB]
+	{
+		.name = "Bxt HDMI Port2",
+		.stream_name = "Hdmi2",
+		.cpu_dai_name = "HDMI2 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[BXT_DPCM_AUDIO_HDMI3_PB]
+	{
+		.name = "Bxt HDMI Port3",
+		.stream_name = "Hdmi3",
+		.cpu_dai_name = "HDMI3 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:0e.0",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	/* Back End DAI links */
+	{
+		/* SSP5 - Codec */
+		.name = "SSP5-Codec",
+		.be_id = 0,
+		.cpu_dai_name = "SSP5 Pin",
+		.platform_name = "0000:00:0e.0",
+		.no_pcm = 1,
+		.codec_name = "i2c-INT343A:00",
+		.codec_dai_name = "rt298-aif1",
+		.init = broxton_rt298_codec_init,
+		.dai_fmt = SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF |
+						SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = broxton_ssp5_fixup,
+		.ops = &broxton_rt298_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "dmic01",
+		.be_id = 1,
+		.cpu_dai_name = "DMIC01 Pin",
+		.codec_name = "dmic-codec",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "0000:00:0e.0",
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp1",
+		.be_id = 3,
+		.cpu_dai_name = "iDisp1 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:0e.0",
+		.init = broxton_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp2",
+		.be_id = 4,
+		.cpu_dai_name = "iDisp2 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi2",
+		.platform_name = "0000:00:0e.0",
+		.init = broxton_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp3",
+		.be_id = 5,
+		.cpu_dai_name = "iDisp3 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi3",
+		.platform_name = "0000:00:0e.0",
+		.init = broxton_hdmi_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+};
+
+/* broxton audio machine driver for SPT + RT298S */
+static struct snd_soc_card broxton_rt298 = {
+	.name = "broxton-rt298",
+	.owner = THIS_MODULE,
+	.dai_link = broxton_rt298_dais,
+	.num_links = ARRAY_SIZE(broxton_rt298_dais),
+	.controls = broxton_controls,
+	.num_controls = ARRAY_SIZE(broxton_controls),
+	.dapm_widgets = broxton_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(broxton_widgets),
+	.dapm_routes = broxton_rt298_map,
+	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
+	.fully_routed = true,
+};
+
+static int broxton_audio_probe(struct platform_device *pdev)
+{
+	broxton_rt298.dev = &pdev->dev;
+
+	return devm_snd_soc_register_card(&pdev->dev, &broxton_rt298);
+}
+
+static struct platform_driver broxton_audio = {
+	.probe = broxton_audio_probe,
+	.driver = {
+		.name = "bxt_alc298s_i2s",
+	},
+};
+module_platform_driver(broxton_audio)
+
+/* Module information */
+MODULE_AUTHOR("Ramesh Babu <Ramesh.Babu@intel.com>");
+MODULE_AUTHOR("Senthilnathan Veppur <senthilnathanx.veppur@intel.com>");
+MODULE_DESCRIPTION("Intel SST Audio for Broxton");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bxt_alc298s_i2s");
-- 
1.9.1
