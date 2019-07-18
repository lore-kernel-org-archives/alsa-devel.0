From: Jon Flatley <jflat@chromium.org>
Subject: [PATCH] ASoC: intel: Add Broadwell rt5650 machine
	driver
Date: Thu, 18 Jul 2019 16:12:25 -0700
Message-ID: <20190718231225.88991-1-jflat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 78BB9F800C4
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 01:12:31 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id i189so13291479pfg.10
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 16:12:30 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: benzh@chromium.org, broonie@kernel.org, jflat@chromium.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Ben Zhang <benzh@chromium.org>

Add machine driver for Broadwell + rt5650.

Signed-off-by: Jon Flatley <jflat@chromium.org>
Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/intel/boards/Kconfig                |  11 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/bdw-rt5650.c           | 305 ++++++++++++++++++
 .../common/soc-acpi-intel-hsw-bdw-match.c     |   5 +
 4 files changed, 323 insertions(+)
 create mode 100644 sound/soc/intel/boards/bdw-rt5650.c

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 50bf149818b5..c111ae177b4a 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -31,6 +31,17 @@ endif ## SND_SOC_INTEL_HASWELL
 
 if SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
 
+config SND_SOC_INTEL_BDW_RT5650_MACH
+	tristate "Broadwell with RT5650 codec"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && DW_DMAC
+	select SND_COMPRESS_OFFLOAD
+	select SND_SOC_RT5645
+	help
+	  This adds the ASoC machine driver for Intel Broadwell platforms with
+	  the RT5650 codec.
+	  Say Y if you have such a device
+	  If unsure select "N".
+
 config SND_SOC_INTEL_BDW_RT5677_MACH
 	tristate "Broadwell with RT5677 codec"
 	depends on I2C
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 6445f90ea542..b5e2619607be 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -2,6 +2,7 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
+snd-soc-sst-bdw-rt5650-mach-objs := bdw-rt5650.o
 snd-soc-sst-bdw-rt5677-mach-objs := bdw-rt5677.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bxt-da7219_max98357a-objs := bxt_da7219_max98357a.o
@@ -36,6 +37,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH) += snd-soc-sst-bxt-da7219_
 obj-$(CONFIG_SND_SOC_INTEL_BXT_RT298_MACH) += snd-soc-sst-bxt-rt298.o
 obj-$(CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH) += snd-soc-sst-glk-rt5682_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+obj-$(CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH) += snd-soc-sst-bdw-rt5650-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH) += snd-soc-sst-bdw-rt5677-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
new file mode 100644
index 000000000000..cb875eeab055
--- /dev/null
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ASoC machine driver for Intel Broadwell platforms with RT5650 codec
+ *
+ * Copyright 2019, The Chromium OS Authors.  All rights reserved.
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
+#include "../../codecs/rt5645.h"
+
+struct bdw_rt5650_priv {
+	struct gpio_desc *gpio_hp_en;
+	struct snd_soc_component *component;
+};
+
+static const struct snd_soc_dapm_widget bdw_rt5650_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("DMIC Pair1", NULL),
+	SND_SOC_DAPM_MIC("DMIC Pair2", NULL),
+};
+
+static const struct snd_soc_dapm_route bdw_rt5650_map[] = {
+	/* Speakers */
+	{"Speaker", NULL, "SPOL"},
+	{"Speaker", NULL, "SPOR"},
+
+	/* Headset jack connectors */
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+
+	/* Digital MICs
+	 * DMIC Pair1 are the two DMICs connected on the DMICN1 connector.
+	 * DMIC Pair2 are the two DMICs connected on the DMICN2 connector.
+	 * Facing the camera, DMIC Pair1 are on the left side, DMIC Pair2
+	 * are on the right side.
+	 */
+	{"DMIC L1", NULL, "DMIC Pair1"},
+	{"DMIC R1", NULL, "DMIC Pair1"},
+	{"DMIC L2", NULL, "DMIC Pair2"},
+	{"DMIC R2", NULL, "DMIC Pair2"},
+
+	/* CODEC BE connections */
+	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
+	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
+};
+
+static const struct snd_kcontrol_new bdw_rt5650_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("DMIC Pair1"),
+	SOC_DAPM_PIN_SWITCH("DMIC Pair2"),
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
+static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	/* The ADSP will covert the FE rate to 48k, max 4-channels */
+	rate->min = rate->max = 48000;
+	channels->min = 2;
+	channels->max = 4;
+
+	/* set SSP0 to 24 bit */
+	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
+				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
+				    SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
+static int bdw_rt5650_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	/* Workaround: set codec PLL to 19.2MHz that PLL source is
+	 * from MCLK(24MHz) to conform 2.4MHz DMIC clock.
+	 */
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_MCLK,
+		24000000, 19200000);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	/* The actual MCLK freq is 24MHz. The codec is told that MCLK is
+	 * 24.576MHz to satisfy the requirement of rl6231_get_clk_info.
+	 * ASRC is enabled on AD and DA filters to ensure good audio quality.
+	 */
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1, 24576000,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops bdw_rt5650_ops = {
+	.hw_params = bdw_rt5650_hw_params,
+};
+
+static int bdw_rt5650_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct sst_pdata *pdata = dev_get_platdata(component->dev);
+	struct sst_hsw *broadwell = pdata->dsp;
+	int ret;
+
+	/* Set ADSP SSP port settings
+	 * clock_divider = 4 means BCLK = MCLK/5 = 24MHz/5 = 4.8MHz
+	 */
+	ret = sst_hsw_device_set_config(broadwell, SST_HSW_DEVICE_SSP_0,
+		SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
+		SST_HSW_DEVICE_TDM_CLOCK_MASTER, 4);
+	if (ret < 0) {
+		dev_err(rtd->dev, "error: failed to set device config\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct bdw_rt5650_priv *bdw_rt5650 =
+		snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = rtd->codec_dai->component;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	/* Enable codec ASRC function for Stereo DAC/Stereo1 ADC/DMIC/I2S1.
+	 * The ASRC clock source is clk_i2s1_asrc.
+	 */
+	rt5645_sel_asrc_clk_src(component,
+				RT5645_DA_STEREO_FILTER |
+				RT5645_DA_MONO_L_FILTER |
+				RT5645_DA_MONO_R_FILTER |
+				RT5645_AD_STEREO_FILTER |
+				RT5645_AD_MONO_L_FILTER |
+				RT5645_AD_MONO_R_FILTER,
+				RT5645_CLK_SEL_I2S1_ASRC);
+
+	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec TDM slot %d\n", ret);
+		return ret;
+	}
+
+	/* Create and initialize headphone jack */
+	if (snd_soc_card_jack_new(rtd->card, "Headphone Jack",
+			SND_JACK_HEADPHONE, &headphone_jack,
+			&headphone_jack_pin, 1)) {
+		dev_err(component->dev, "Can't create headphone jack\n");
+	}
+
+	/* Create and initialize mic jack */
+	if (snd_soc_card_jack_new(rtd->card, "Mic Jack", SND_JACK_MICROPHONE,
+			&mic_jack, &mic_jack_pin, 1)) {
+		dev_err(component->dev, "Can't create mic jack\n");
+	}
+
+	rt5645_set_jack_detect(component, &headphone_jack, &mic_jack, NULL);
+
+	bdw_rt5650->component = component;
+
+	return 0;
+}
+
+/* broadwell digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEF(dummy, DAILINK_COMP_ARRAY(COMP_DUMMY()));
+SND_SOC_DAILINK_DEF(fe, DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
+SND_SOC_DAILINK_DEF(platform,
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("haswell-pcm-audio")));
+SND_SOC_DAILINK_DEF(be,
+	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC5650:00", "rt5645-aif1")));
+
+static struct snd_soc_dai_link bdw_rt5650_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "System PCM",
+		.stream_name = "System Playback",
+		.dynamic = 1,
+		.init = bdw_rt5650_rtd_init,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST
+		},
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(fe, dummy, platform),
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "Codec",
+		.id = 0,
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = broadwell_ssp0_fixup,
+		.ops = &bdw_rt5650_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = bdw_rt5650_init,
+		SND_SOC_DAILINK_REG(dummy, be, dummy)
+	},
+};
+
+/* ASoC machine driver for Broadwell DSP + RT5650 */
+static struct snd_soc_card bdw_rt5650_card = {
+	.name = "bdw-rt5650",
+	.owner = THIS_MODULE,
+	.dai_link = bdw_rt5650_dais,
+	.num_links = ARRAY_SIZE(bdw_rt5650_dais),
+	.dapm_widgets = bdw_rt5650_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(bdw_rt5650_widgets),
+	.dapm_routes = bdw_rt5650_map,
+	.num_dapm_routes = ARRAY_SIZE(bdw_rt5650_map),
+	.controls = bdw_rt5650_controls,
+	.num_controls = ARRAY_SIZE(bdw_rt5650_controls),
+	.fully_routed = true,
+};
+
+static int bdw_rt5650_probe(struct platform_device *pdev)
+{
+	struct bdw_rt5650_priv *bdw_rt5650;
+
+	bdw_rt5650_card.dev = &pdev->dev;
+
+	/* Allocate driver private struct */
+	bdw_rt5650 = devm_kzalloc(&pdev->dev, sizeof(struct bdw_rt5650_priv),
+		GFP_KERNEL);
+	if (!bdw_rt5650)
+		return -ENOMEM;
+	snd_soc_card_set_drvdata(&bdw_rt5650_card, bdw_rt5650);
+
+	return snd_soc_register_card(&bdw_rt5650_card);
+}
+
+static int bdw_rt5650_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&bdw_rt5650_card);
+	return 0;
+}
+
+static struct platform_driver bdw_rt5650_audio = {
+	.probe = bdw_rt5650_probe,
+	.remove = bdw_rt5650_remove,
+	.driver = {
+		.name = "bdw-rt5650",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(bdw_rt5650_audio)
+
+/* Module information */
+MODULE_AUTHOR("Ben Zhang <benzh@chromium.org>");
+MODULE_DESCRIPTION("Intel Broadwell RT5650 machine driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bdw-rt5650");
diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index d27853e7a369..ba3d25658436 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -29,6 +29,11 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.sof_fw_filename = "sof-bdw.ri",
 		.sof_tplg_filename = "sof-bdw-rt286.tplg",
 	},
+	{
+		.id = "10EC5650",
+		.drv_name = "bdw-rt5650",
+		.fw_filename = "intel/IntcSST2.bin",
+	},
 	{
 		.id = "RT5677CE",
 		.drv_name = "bdw-rt5677",
-- 
2.22.0.657.g960e92d24f-goog
