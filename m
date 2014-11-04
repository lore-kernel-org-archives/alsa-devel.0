From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/5] ASoC: Intel: add BYTCR machine driver
	with RT5640
Date: Tue,  4 Nov 2014 11:01:08 +0530
Message-ID: <1415079068-4979-6-git-send-email-vinod.koul@intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BA7A2605E9
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 06:30:44 +0100 (CET)
In-Reply-To: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Kconfig             |   12 ++
 sound/soc/intel/Makefile            |    2 +
 sound/soc/intel/bytcr_dpcm_rt5640.c |  258 +++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index edff4a3..a8ccc3d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -85,3 +85,15 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y if you have such a device
 	  If unsure select "N".
+
+config SND_SOC_INTEL_BYTCR_RT5640_MACH
+	tristate "ASoC Audio DSP Support for MID BYT Platform"
+	depends on X86
+	select SND_SOC_RT5640
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC_ACPI
+	help
+	  This adds support for ASoC machine driver for Intel(R) MID Baytrail platform
+          used as alsa device in audio substem in Intel(R) MID devices
+          Say Y if you have such a device
+          If unsure select "N".
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 9ab43be..fbde4b0 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -26,11 +26,13 @@ snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
+snd-soc-sst-bytcr-dpcm-rt5640-objs := bytcr_dpcm_rt5640.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
+obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-dpcm-rt5640.o
 
 # DSP driver
 obj-$(CONFIG_SND_SST_IPC) += sst/
diff --git a/sound/soc/intel/bytcr_dpcm_rt5640.c b/sound/soc/intel/bytcr_dpcm_rt5640.c
new file mode 100644
index 0000000..8a15bce
--- /dev/null
+++ b/sound/soc/intel/bytcr_dpcm_rt5640.c
@@ -0,0 +1,258 @@
+/*
+ *  byt_cr_dpcm_rt5640.c - ASoc Machine driver for Intel Byt CR platform
+ *
+ *  Copyright (C) 2014 Intel Corp
+ *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
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
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../codecs/rt5640.h"
+#include "sst-atom-controls.h"
+
+static const struct snd_soc_dapm_widget byt_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_audio_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
+	{"IN2N", NULL, "Headset Mic"},
+	{"Headset Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "MICBIAS1"},
+	{"LDO2", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOLP"},
+	{"Ext Spk", NULL, "SPOLN"},
+	{"Ext Spk", NULL, "SPORP"},
+	{"Ext Spk", NULL, "SPORN"},
+
+	{"AIF1 Playback", NULL, "ssp2 Tx"},
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+	{"ssp2 Rx", NULL, "AIF1 Capture"},
+};
+
+static const struct snd_kcontrol_new byt_mc_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static int byt_aif1_hw_params(struct snd_pcm_substream *substream,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	if (strncmp(codec_dai->name, "rt5640-aif1", 11))
+		return 0;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
+				     params_rate(params) * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
+				  params_rate(params) * 50,
+				  params_rate(params) * 512);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
+	snd_soc_dai_set_bclk_ratio(codec_dai, 50);
+	return 0;
+}
+
+static const struct snd_soc_pcm_stream byt_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+static int byt_codec_fixup(struct snd_soc_pcm_runtime *rtd,
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
+static int byt_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops byt_aif1_ops = {
+	.startup = byt_aif1_startup,
+};
+
+static struct snd_soc_ops byt_be_ssp2_ops = {
+	.hw_params = byt_aif1_hw_params,
+};
+
+static struct snd_soc_dai_link byt_dailink[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Baytrail Audio Port",
+		.stream_name = "Baytrail Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_aif1_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Baytrail Compressed Port",
+		.stream_name = "Baytrail Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+	},
+		/* back ends */
+	{
+		.name = "SSP2-Codec",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "rt5640-aif1",
+		.codec_name = "i2c-10EC5640:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S| SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = byt_codec_fixup,
+		.ignore_suspend = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_be_ssp2_ops,
+	},
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int snd_byt_prepare(struct device *dev)
+{
+	return snd_soc_suspend(dev);
+}
+
+static void snd_byt_complete(struct device *dev)
+{
+	snd_soc_resume(dev);
+}
+
+static int snd_byt_poweroff(struct device *dev)
+{
+	return snd_soc_poweroff(dev);
+}
+#else
+#define snd_byt_prepare NULL
+#define snd_byt_complete NULL
+#define snd_byt_poweroff NULL
+#endif
+
+/* SoC card */
+static struct snd_soc_card snd_soc_card_byt = {
+	.name = "baytrailcraudio",
+	.dai_link = byt_dailink,
+	.num_links = ARRAY_SIZE(byt_dailink),
+	.dapm_widgets = byt_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_dapm_widgets),
+	.dapm_routes = byt_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_audio_map),
+	.controls = byt_mc_controls,
+	.num_controls = ARRAY_SIZE(byt_mc_controls),
+};
+
+static int snd_byt_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	snd_soc_card_byt.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_byt);
+	if (ret_val) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n", ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &snd_soc_card_byt);
+	return ret_val;
+}
+
+static const struct dev_pm_ops snd_byt_mc_pm_ops = {
+	.prepare = snd_byt_prepare,
+	.complete = snd_byt_complete,
+	.poweroff = snd_byt_poweroff,
+};
+
+static struct platform_driver snd_byt_mc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "bytt100_rt5640",
+		.pm = &snd_byt_mc_pm_ops,
+	},
+	.probe = snd_byt_mc_probe,
+};
+
+module_platform_driver(snd_byt_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Machine driver");
+MODULE_AUTHOR("Subhransu S. Prusty <subhransu.s.prusty@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bytrt5640-audio");
-- 
1.7.0.4
