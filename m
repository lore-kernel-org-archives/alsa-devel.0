From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add Nuvoton Maxim
	machine driver" to the asoc tree
Date: Fri, 18 Dec 2015 12:15:35 +0000
Message-ID: <E1a9twd-00069m-Jf@debutante>
References: <1449862153-68738-3-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64FD4266666
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:42 +0100 (CET)
In-Reply-To: <1449862153-68738-3-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rohit Ainapure <rohit.m.ainapure@intel.com>, Fang Yang A <yang.a.fang@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add Nuvoton Maxim machine driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8eaf2b31dd316ff5ffbdad14853d2bf8779bab13 Mon Sep 17 00:00:00 2001
From: Rohit Ainapure <rohit.m.ainapure@intel.com>
Date: Fri, 11 Dec 2015 11:29:08 -0800
Subject: [PATCH] ASoC: Intel: Skylake: Add Nuvoton Maxim machine driver

This adds Skylake I2S machine driver which uses NAU88L25 as anlog codec and
MAX98357A as speakers

Signed-off-by: Rohit Ainapure <rohit.m.ainapure@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig                         |  14 +
 sound/soc/intel/boards/Makefile                 |   2 +
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 485 ++++++++++++++++++++++++
 3 files changed, 501 insertions(+)
 create mode 100644 sound/soc/intel/boards/skl_nau88l25_max98357a.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 2d3b12401db1..9b1c0aa8d2d9 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -169,3 +169,17 @@ config SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH
 	  create an alsa sound card for NAU88L25 + SSM4567.
 	  Say Y if you have such a device
 	  If unsure select "N".
+
+config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
+	tristate "ASoC Audio driver for SKL with NAU88L25 and MAX98357A in I2S Mode"
+	depends on X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_SKYLAKE
+	select SND_SOC_NAU8825
+	select SND_SOC_MAX98357A
+	select SND_SOC_DMIC
+	help
+	  This adds support for ASoC Onboard Codec I2S machine driver. This will
+	  create an alsa sound card for NAU88L25 + MAX98357A.
+	  Say Y if you have such a device
+	  If unsure select "N".
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index a59f76277cee..2485ea9434ad 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -7,6 +7,7 @@ snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 snd-soc-skl_rt286-objs := skl_rt286.o
+snd-skl_nau88l25_max98357a-objs := skl_nau88l25_max98357a.o
 snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
@@ -18,4 +19,5 @@ obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_RT286_MACH) += snd-soc-skl_rt286.o
+obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH) += snd-skl_nau88l25_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH) += snd-soc-skl_nau88l25_ssm4567.o
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
new file mode 100644
index 000000000000..ab7da9c304b2
--- /dev/null
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -0,0 +1,485 @@
+/*
+ * Intel Skylake I2S Machine Driver with MAXIM98357A
+ * and NAU88L25
+ *
+ * Copyright (C) 2015, Intel Corporation. All rights reserved.
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
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../../codecs/nau8825.h"
+
+#define SKL_NUVOTON_CODEC_DAI	"nau8825-hifi"
+#define SKL_MAXIM_CODEC_DAI "HiFi"
+
+static struct snd_soc_jack skylake_headset;
+static struct snd_soc_card skylake_audio_card;
+
+static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+
+		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
+			     strlen(SKL_NUVOTON_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+	int ret;
+
+	codec_dai = skl_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
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
+
+	return ret;
+}
+
+static const struct snd_kcontrol_new skylake_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Spk"),
+};
+
+static const struct snd_soc_dapm_widget skylake_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Spk", NULL),
+	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
+	SND_SOC_DAPM_SINK("WoV Sink"),
+	SND_SOC_DAPM_SPK("DP", NULL),
+	SND_SOC_DAPM_SPK("HDMI", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
+			SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route skylake_map[] = {
+	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+
+	/* speaker */
+	{ "Spk", NULL, "Speaker" },
+
+	/* other jacks */
+	{ "MIC", NULL, "Headset Mic" },
+	{ "DMic", NULL, "SoC DMIC" },
+
+	{"WoV Sink", NULL, "hwd_in sink"},
+	{"HDMI", NULL, "hif5 Output"},
+	{"DP", NULL, "hif6 Output"},
+
+	/* CODEC BE connections */
+	{ "HiFi Playback", NULL, "ssp0 Tx" },
+	{ "ssp0 Tx", NULL, "codec0_out" },
+
+	{ "Playback", NULL, "ssp1 Tx" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
+
+	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "ssp1 Rx", NULL, "Capture" },
+
+	/* DMIC */
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
+	{ "hifi1", NULL, "iDisp Tx"},
+	{ "iDisp Tx", NULL, "iDisp_out"},
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+};
+
+static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	/* The ADSP will covert the FE rate to 48k, stereo */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP0 to 24 bit */
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+
+	return 0;
+}
+
+static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_codec *codec = rtd->codec;
+
+	/*
+	 * Headset buttons map to the google Reference headset.
+	 * These can be configured by userspace.
+	 */
+	ret = snd_soc_card_jack_new(&skylake_audio_card, "Headset Jack",
+			SND_JACK_HEADSET | SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			SND_JACK_BTN_2 | SND_JACK_BTN_3, &skylake_headset,
+			NULL, 0);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	nau8825_enable_jack_detect(codec, &skylake_headset);
+
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
+	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
+
+	return ret;
+}
+
+static int skylake_nau8825_fe_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_component *component = rtd->cpu_dai->component;
+
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_ignore_suspend(dapm, "Reference Capture");
+
+	return 0;
+}
+
+static unsigned int rates[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static unsigned int channels[] = {
+	2,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int skl_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support,
+	 * 48Khz
+	 * stereo
+	 * 16 bit audio
+	 */
+
+	runtime->hw.channels_max = 2;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
+	snd_pcm_hw_constraint_list(runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops skylake_nau8825_fe_ops = {
+	.startup = skl_fe_startup,
+};
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
+static int skylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *channels = hw_param_interval(params,
+				SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	if (params_channels(params) == 2)
+		channels->min = channels->max = 2;
+	else
+		channels->min = channels->max = 4;
+
+	return 0;
+}
+
+static unsigned int channels_dmic[] = {
+	2, 4,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
+	.count = ARRAY_SIZE(channels_dmic),
+	.list = channels_dmic,
+	.mask = 0,
+};
+
+static int skylake_dmic_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	runtime->hw.channels_max = 4;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+			&constraints_dmic_channels);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
+}
+
+static struct snd_soc_ops skylake_dmic_ops = {
+	.startup = skylake_dmic_startup,
+};
+
+static unsigned int rates_16000[] = {
+	16000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_16000 = {
+	.count = ARRAY_SIZE(rates_16000),
+	.list  = rates_16000,
+};
+
+static int skylake_refcap_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE,
+				&constraints_16000);
+}
+
+static struct snd_soc_ops skylaye_refcap_ops = {
+	.startup = skylake_refcap_startup,
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
+		.init = skylake_nau8825_fe_init,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+		.ops = &skylake_nau8825_fe_ops,
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
+		.ops = &skylake_nau8825_fe_ops,
+	},
+	{
+		.name = "Skl Audio Reference cap",
+		.stream_name = "Wake on Voice",
+		.cpu_dai_name = "Reference Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &skylaye_refcap_ops,
+	},
+	{
+		.name = "Skl Audio DMIC cap",
+		.stream_name = "dmiccap",
+		.cpu_dai_name = "DMIC Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &skylake_dmic_ops,
+	},
+	{
+		.name = "Skl HDMI Port",
+		.stream_name = "Hdmi",
+		.cpu_dai_name = "HDMI Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "SSP0-Codec",
+		.be_id = 0,
+		.cpu_dai_name = "SSP0 Pin",
+		.platform_name = "0000:00:1f.3",
+		.no_pcm = 1,
+		.codec_name = "MX98357A:00",
+		.codec_dai_name = SKL_MAXIM_CODEC_DAI,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
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
+		.be_hw_params_fixup = skylake_dmic_fixup,
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp",
+		.be_id = 3,
+		.cpu_dai_name = "iDisp Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+};
+
+/* skylake audio machine driver for SPT + NAU88L25 */
+static struct snd_soc_card skylake_audio_card = {
+	.name = "sklnau8825max",
+	.owner = THIS_MODULE,
+	.dai_link = skylake_dais,
+	.num_links = ARRAY_SIZE(skylake_dais),
+	.controls = skylake_controls,
+	.num_controls = ARRAY_SIZE(skylake_controls),
+	.dapm_widgets = skylake_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(skylake_widgets),
+	.dapm_routes = skylake_map,
+	.num_dapm_routes = ARRAY_SIZE(skylake_map),
+	.fully_routed = true,
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
+		.name = "skl_nau88l25_max98357a_i2s",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+
+module_platform_driver(skylake_audio)
+
+/* Module information */
+MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode");
+MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:skl_nau88l25_max98357a_i2s");
-- 
2.6.2
