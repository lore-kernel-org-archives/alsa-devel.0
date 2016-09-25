From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: Add bdw-rt5677 machine driver" to the asoc tree
Date: Sat, 24 Sep 2016 22:57:27 -0700
Message-ID: <E1bo2RL-0002kj-7T@finisterre>
References: <e78e1411cdafcffa7e0693b257dd8e32571f9fc1.1472071966.git.john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e78e1411cdafcffa7e0693b257dd8e32571f9fc1.1472071966.git.john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Ben Zhang <benzh@chromium.org>, Dylan Reid <dgreid@chromium.org>, Genki Marshall <genki@genki.is>, Tom Rini <trini@konsulko.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>Tom Rini <trini@konsulko.com>Genki Marshall <genki@genki.is>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgBen Zhang <benzh@chromium.org>Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>Dylan Reid <dgreid@chromium.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: Add bdw-rt5677 machine driver

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

>From 2d995e5dc283adbfbf9c1eb81bf35ca7af2d22a6 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Wed, 24 Aug 2016 22:06:36 +0100
Subject: [PATCH] ASoC: Intel: boards: Add bdw-rt5677 machine driver

This is used by the Chromebook Pixel 2015.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Dylan Reid <dgreid@chromium.org>
[john@metanate.com:
 - forward-port driver from Chromium OS 3.14 tree to master
 - remove wake on voice function that isn't supported by upstream rt5677
   driver
 - remote owner assignment in platform_driver (Evan McClain)
 - convert to devm_snd_soc_register_card (Evan McClain)
 - add a full copyright header based on module license and Chromium OS
   Git history
]
Signed-off-by: John Keeping <john@metanate.com>
Tested-by: Genki Marshall <genki@genki.is>
Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig             |  11 ++
 sound/soc/intel/boards/Makefile     |   2 +
 sound/soc/intel/boards/bdw-rt5677.c | 347 ++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c   |   1 +
 4 files changed, 361 insertions(+)
 create mode 100644 sound/soc/intel/boards/bdw-rt5677.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index fc6e78050a79..26eb5a0a5575 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -121,6 +121,17 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the MAX98090 audio codec.
 
+config SND_SOC_INTEL_BDW_RT5677_MACH
+	tristate "ASoC Audio driver for Intel Broadwell with RT5677 codec"
+	depends on X86_INTEL_LPSS && GPIOLIB && I2C && DW_DMAC
+	depends on DW_DMAC_CORE=y
+	select SND_SOC_INTEL_SST
+	select SND_SOC_INTEL_HASWELL
+	select SND_SOC_RT5677
+	help
+	  This adds support for Intel Broadwell platform based boards with
+	  the RT5677 audio codec.
+
 config SND_SOC_INTEL_BROADWELL_MACH
 	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
 	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index dac03a06bfd8..5639f10774e6 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,6 +1,7 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
+snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o
 snd-soc-sst-bxt-rt298-objs := bxt_rt298.o
@@ -19,6 +20,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH) += snd-soc-sst-bxt-da7219_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_BXT_RT298_MACH) += snd-soc-sst-bxt-rt298.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+obj-$(CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH) += snd-soc-sst-bdw-rt5677-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
new file mode 100644
index 000000000000..547e6705bf6d
--- /dev/null
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -0,0 +1,347 @@
+/*
+ * ASoC machine driver for Intel Broadwell platforms with RT5677 codec
+ *
+ * Copyright (c) 2014, The Chromium OS Authors.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+#include <sound/jack.h>
+
+#include "../common/sst-dsp.h"
+#include "../haswell/sst-haswell-ipc.h"
+
+#include "../../codecs/rt5677.h"
+
+struct bdw_rt5677_priv {
+	struct gpio_desc *gpio_hp_en;
+	struct snd_soc_codec *codec;
+};
+
+static int bdw_rt5677_event_hp(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct bdw_rt5677_priv *bdw_rt5677 = snd_soc_card_get_drvdata(card);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		msleep(70);
+
+	gpiod_set_value_cansleep(bdw_rt5677->gpio_hp_en,
+		SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget bdw_rt5677_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", bdw_rt5677_event_hp),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Local DMICs", NULL),
+	SND_SOC_DAPM_MIC("Remote DMICs", NULL),
+};
+
+static const struct snd_soc_dapm_route bdw_rt5677_map[] = {
+	/* Speakers */
+	{"Speaker", NULL, "PDM1L"},
+	{"Speaker", NULL, "PDM1R"},
+
+	/* Headset jack connectors */
+	{"Headphone", NULL, "LOUT1"},
+	{"Headphone", NULL, "LOUT2"},
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+
+	/* Digital MICs
+	 * Local DMICs: the two DMICs on the mainboard
+	 * Remote DMICs: the two DMICs on the camera module
+	 */
+	{"DMIC L1", NULL, "Remote DMICs"},
+	{"DMIC R1", NULL, "Remote DMICs"},
+	{"DMIC L2", NULL, "Local DMICs"},
+	{"DMIC R2", NULL, "Local DMICs"},
+
+	/* CODEC BE connections */
+	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
+	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
+};
+
+static const struct snd_kcontrol_new bdw_rt5677_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Local DMICs"),
+	SOC_DAPM_PIN_SWITCH("Remote DMICs"),
+};
+
+
+static struct snd_soc_jack headphone_jack;
+static struct snd_soc_jack mic_jack;
+
+static struct snd_soc_jack_pin headphone_jack_pin = {
+	.pin	= "Headphone",
+	.mask	= SND_JACK_HEADPHONE,
+};
+
+static struct snd_soc_jack_pin mic_jack_pin = {
+	.pin	= "Headset Mic",
+	.mask	= SND_JACK_MICROPHONE,
+};
+
+static struct snd_soc_jack_gpio headphone_jack_gpio = {
+	.name			= "plug-det",
+	.report			= SND_JACK_HEADPHONE,
+	.debounce_time		= 200,
+};
+
+static struct snd_soc_jack_gpio mic_jack_gpio = {
+	.name			= "mic-present",
+	.report			= SND_JACK_MICROPHONE,
+	.debounce_time		= 200,
+	.invert			= 1,
+};
+
+static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* The ADSP will covert the FE rate to 48k, stereo */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP0 to 16 bit */
+	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
+				    SNDRV_PCM_FORMAT_S16_LE);
+	return 0;
+}
+
+static int bdw_rt5677_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5677_SCLK_S_MCLK, 24576000,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops bdw_rt5677_ops = {
+	.hw_params = bdw_rt5677_hw_params,
+};
+
+static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct sst_pdata *pdata = dev_get_platdata(rtd->platform->dev);
+	struct sst_hsw *broadwell = pdata->dsp;
+	int ret;
+
+	/* Set ADSP SSP port settings */
+	ret = sst_hsw_device_set_config(broadwell, SST_HSW_DEVICE_SSP_0,
+		SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
+		SST_HSW_DEVICE_CLOCK_MASTER, 9);
+	if (ret < 0) {
+		dev_err(rtd->dev, "error: failed to set device config\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct bdw_rt5677_priv *bdw_rt5677 =
+			snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+
+	/* Enable codec ASRC function for Stereo DAC/Stereo1 ADC/DMIC/I2S1.
+	 * The ASRC clock source is clk_i2s1_asrc.
+	 */
+	rt5677_sel_asrc_clk_src(codec, RT5677_DA_STEREO_FILTER |
+			RT5677_AD_STEREO1_FILTER | RT5677_I2S1_SOURCE,
+			RT5677_CLK_SEL_I2S1_ASRC);
+
+	/* Request rt5677 GPIO for headphone amp control */
+	bdw_rt5677->gpio_hp_en = devm_gpiod_get_index(codec->dev,
+			"headphone-enable", 0, 0);
+	if (IS_ERR(bdw_rt5677->gpio_hp_en)) {
+		dev_err(codec->dev, "Can't find HP_AMP_SHDN_L gpio\n");
+		return PTR_ERR(bdw_rt5677->gpio_hp_en);
+	}
+	gpiod_direction_output(bdw_rt5677->gpio_hp_en, 0);
+
+	/* Create and initialize headphone jack */
+	if (!snd_soc_card_jack_new(rtd->card, "Headphone Jack",
+			SND_JACK_HEADPHONE, &headphone_jack,
+			&headphone_jack_pin, 1)) {
+		headphone_jack_gpio.gpiod_dev = codec->dev;
+		if (snd_soc_jack_add_gpios(&headphone_jack, 1,
+				&headphone_jack_gpio))
+			dev_err(codec->dev, "Can't add headphone jack gpio\n");
+	} else {
+		dev_err(codec->dev, "Can't create headphone jack\n");
+	}
+
+	/* Create and initialize mic jack */
+	if (!snd_soc_card_jack_new(rtd->card, "Mic Jack",
+			SND_JACK_MICROPHONE, &mic_jack,
+			&mic_jack_pin, 1)) {
+		mic_jack_gpio.gpiod_dev = codec->dev;
+		if (snd_soc_jack_add_gpios(&mic_jack, 1, &mic_jack_gpio))
+			dev_err(codec->dev, "Can't add mic jack gpio\n");
+	} else {
+		dev_err(codec->dev, "Can't create mic jack\n");
+	}
+	bdw_rt5677->codec = codec;
+
+	snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
+	return 0;
+}
+
+/* broadwell digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link bdw_rt5677_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "System PCM",
+		.stream_name = "System Playback/Capture",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = bdw_rt5677_rtd_init,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST
+		},
+		.dpcm_capture = 1,
+		.dpcm_playback = 1,
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "Codec",
+		.id = 0,
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.no_pcm = 1,
+		.codec_name = "i2c-RT5677CE:00",
+		.codec_dai_name = "rt5677-aif1",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = broadwell_ssp0_fixup,
+		.ops = &bdw_rt5677_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = bdw_rt5677_init,
+	},
+};
+
+static int bdw_rt5677_suspend_pre(struct snd_soc_card *card)
+{
+	struct bdw_rt5677_priv *bdw_rt5677 = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dapm_context *dapm;
+
+	if (bdw_rt5677->codec) {
+		dapm = snd_soc_codec_get_dapm(bdw_rt5677->codec);
+		snd_soc_dapm_disable_pin(dapm, "MICBIAS1");
+	}
+	return 0;
+}
+
+static int bdw_rt5677_resume_post(struct snd_soc_card *card)
+{
+	struct bdw_rt5677_priv *bdw_rt5677 = snd_soc_card_get_drvdata(card);
+	struct snd_soc_dapm_context *dapm;
+
+	if (bdw_rt5677->codec) {
+		dapm = snd_soc_codec_get_dapm(bdw_rt5677->codec);
+		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
+	}
+	return 0;
+}
+
+/* ASoC machine driver for Broadwell DSP + RT5677 */
+static struct snd_soc_card bdw_rt5677_card = {
+	.name = "bdw-rt5677",
+	.owner = THIS_MODULE,
+	.dai_link = bdw_rt5677_dais,
+	.num_links = ARRAY_SIZE(bdw_rt5677_dais),
+	.dapm_widgets = bdw_rt5677_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(bdw_rt5677_widgets),
+	.dapm_routes = bdw_rt5677_map,
+	.num_dapm_routes = ARRAY_SIZE(bdw_rt5677_map),
+	.controls = bdw_rt5677_controls,
+	.num_controls = ARRAY_SIZE(bdw_rt5677_controls),
+	.fully_routed = true,
+	.suspend_pre = bdw_rt5677_suspend_pre,
+	.resume_post = bdw_rt5677_resume_post,
+};
+
+static int bdw_rt5677_probe(struct platform_device *pdev)
+{
+	struct bdw_rt5677_priv *bdw_rt5677;
+
+	bdw_rt5677_card.dev = &pdev->dev;
+
+	/* Allocate driver private struct */
+	bdw_rt5677 = devm_kzalloc(&pdev->dev, sizeof(struct bdw_rt5677_priv),
+		GFP_KERNEL);
+	if (!bdw_rt5677) {
+		dev_err(&pdev->dev, "Can't allocate bdw_rt5677\n");
+		return -ENOMEM;
+	}
+
+	snd_soc_card_set_drvdata(&bdw_rt5677_card, bdw_rt5677);
+
+	return devm_snd_soc_register_card(&pdev->dev, &bdw_rt5677_card);
+}
+
+static struct platform_driver bdw_rt5677_audio = {
+	.probe = bdw_rt5677_probe,
+	.driver = {
+		.name = "bdw-rt5677",
+	},
+};
+
+module_platform_driver(bdw_rt5677_audio)
+
+/* Module information */
+MODULE_AUTHOR("Ben Zhang");
+MODULE_DESCRIPTION("Intel Broadwell RT5677 machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bdw-rt5677");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 2c5eda14d510..1285cc597b6b 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -199,6 +199,7 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
 
 static struct sst_acpi_mach broadwell_machines[] = {
 	{ "INT343A", "broadwell-audio", "intel/IntcSST2.bin", NULL, NULL, NULL },
+	{ "RT5677CE", "bdw-rt5677", "intel/IntcSST2.bin", NULL, NULL, NULL },
 	{}
 };
 
-- 
2.9.3
