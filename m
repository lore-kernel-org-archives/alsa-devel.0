From: mengdong.lin@intel.com
Subject: [PATCH v5 1/2] ASoC: Intel: Add Cherrytrail & Braswell
	machine driver cht_bsw_rt5672
Date: Tue, 18 Nov 2014 13:01:36 +0800
Message-ID: <5894413aa62721f364561ad52cc68f1ae66d091b.1416286766.git.mengdong.lin@intel.com>
References: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CD832605F8
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 05:55:19 +0100 (CET)
In-Reply-To: <c59847b1110e5302ec0a82700d4e318bef2a3f66.1414148860.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com, subhransu.s.prusty@intel.com, liam.r.girdwood@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Add machine driver for two Intel Cherryview-based platforms, Cherrytrail and
Braswell, with RT5672 codec.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index a992e85..8c8ccff 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -86,3 +86,15 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y if you have such a device
 	  If unsure select "N".
+
+config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
+        tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
+        depends on X86_INTEL_LPSS
+        select SND_SOC_RT5670
+        select SND_SST_MFLD_PLATFORM
+        select SND_SST_IPC_ACPI
+        help
+          This adds support for ASoC machine driver for Intel(R) Cherrytrail & Braswell
+          platforms with RT5672 audio codec.
+          Say Y if you have such a device
+          If unsure select "N".
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 9ab43be..5939b56 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -26,11 +26,13 @@ snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
+snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 
 # DSP driver
 obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/cht_bsw_rt5672.c b/sound/soc/intel/cht_bsw_rt5672.c
new file mode 100644
index 0000000..9b8b561
--- /dev/null
+++ b/sound/soc/intel/cht_bsw_rt5672.c
@@ -0,0 +1,285 @@
+/*
+ *  cht_bsw_rt5672.c - ASoc Machine driver for Intel Cherryview-based platforms
+ *                     Cherrytrail and Braswell, with RT5672 codec.
+ *
+ *  Copyright (C) 2014 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
+ *          Mengdong Lin <mengdong.lin@intel.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../codecs/rt5670.h"
+#include "sst-atom-controls.h"
+
+/* The platform clock #3 outputs 19.2Mhz clock to codec as I2S MCLK */
+#define CHT_PLAT_CLK_3_HZ	19200000
+#define CHT_CODEC_DAI	"rt5670-aif1"
+
+static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
+{
+	int i;
+
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd;
+
+		rtd = card->rtd + i;
+		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
+			     strlen(CHT_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+	return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+
+	codec_dai = cht_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found; Unable to set platform clock\n");
+		return -EIO;
+	}
+
+	if (!SND_SOC_DAPM_EVENT_OFF(event))
+		return 0;
+
+	/* Set codec sysclk source to its internal clock because codec PLL will
+	 * be off when idle and MCLK will also be off by ACPI when codec is
+	 * runtime suspended. Codec needs clock for jack detection and button
+	 * press.
+	 */
+	snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_RCCLK,
+			       0, SND_SOC_CLOCK_IN);
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget cht_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control, SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route cht_audio_map[] = {
+	{"IN1P", NULL, "Headset Mic"},
+	{"IN1N", NULL, "Headset Mic"},
+	{"DMIC L1", NULL, "Int Mic"},
+	{"DMIC R1", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOLP"},
+	{"Ext Spk", NULL, "SPOLN"},
+	{"Ext Spk", NULL, "SPORP"},
+	{"Ext Spk", NULL, "SPORN"},
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+	{"Headphone", NULL, "Platform Clock"},
+	{"Headset Mic", NULL, "Platform Clock"},
+	{"Int Mic", NULL, "Platform Clock"},
+	{"Ext Spk", NULL, "Platform Clock"},
+};
+
+static const struct snd_kcontrol_new cht_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	/* set codec PLL source to the 19.2MHz platform clock (MCLK) */
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5670_PLL1_S_MCLK,
+				  CHT_PLAT_CLK_3_HZ, params_rate(params) * 512);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	/* set codec sysclk source to PLL */
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5670_SCLK_S_PLL1,
+				     params_rate(params) * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_dai *codec_dai = runtime->codec_dai;
+
+	/* TDM 4 slots 24 bit, set Rx & Tx bitmask to 4 active slots */
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF, 0xF, 4, 24);
+	if (ret < 0) {
+		dev_err(runtime->dev, "can't set codec TDM slot %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
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
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+
+static int cht_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops cht_aif1_ops = {
+	.startup = cht_aif1_startup,
+};
+
+static struct snd_soc_ops cht_be_ssp2_ops = {
+	.hw_params = cht_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link cht_dailink[] = {
+	/* Front End DAI links */
+	[MERR_DPCM_AUDIO] = {
+		.name = "Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &cht_aif1_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Compressed Port",
+		.stream_name = "Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP2 - Codec */
+		.name = "SSP2-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "rt5670-aif1",
+		.codec_name = "i2c-10EC5670:00",
+		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF
+					| SND_SOC_DAIFMT_CBS_CFS,
+		.init = cht_codec_init,
+		.be_hw_params_fixup = cht_codec_fixup,
+		.ignore_suspend = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &cht_be_ssp2_ops,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_cht = {
+	.name = "cherrytrailcraudio",
+	.dai_link = cht_dailink,
+	.num_links = ARRAY_SIZE(cht_dailink),
+	.dapm_widgets = cht_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cht_dapm_widgets),
+	.dapm_routes = cht_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(cht_audio_map),
+	.controls = cht_mc_controls,
+	.num_controls = ARRAY_SIZE(cht_mc_controls),
+};
+
+static int snd_cht_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	snd_soc_card_cht.dev = &pdev->dev;
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
+	if (ret_val) {
+		dev_err(&pdev->dev,
+			"snd_soc_register_card failed %d\n", ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_cht);
+	return ret_val;
+}
+
+static struct platform_driver snd_cht_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "cht-bsw-rt5672",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = snd_cht_mc_probe,
+};
+
+module_platform_driver(snd_cht_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver");
+MODULE_AUTHOR("Subhransu S. Prusty, Mengdong Lin");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:cht-bsw-rt5672");
-- 
1.9.1
