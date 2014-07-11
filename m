From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Add Broadwell Machine support
Date: Fri, 11 Jul 2014 11:22:00 +0800
Message-ID: <1405048920-25169-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BFE57261AE9
 for <alsa-devel@alsa-project.org>; Fri, 11 Jul 2014 05:22:48 +0200 (CEST)
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
Cc: broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add support for Broadwell based machines with SST DSP audio.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig     |  12 +++
 sound/soc/intel/Makefile    |   2 +
 sound/soc/intel/broadwell.c | 251 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 sound/soc/intel/broadwell.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c30fedb..0b305f9 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -58,3 +58,15 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
 	help
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the MAX98090 audio codec.
+
+config SND_SOC_INTEL_BROADWELL_MACH
+	tristate "ASoC Audio DSP support for Intel Broadwell Wildcatpoint"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
+	select SND_SOC_INTEL_HASWELL
+	select SND_COMPRESS_OFFLOAD
+	select SND_SOC_RT286
+	help
+	  This adds support for the Wilcatpoint Audio DSP on Intel(R) Broadwell
+	  Ultrabook platforms.
+	  Say Y if you have such a device
+	  If unsure select "N".
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 4bfca79..7acbfc4 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -24,7 +24,9 @@ obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += snd-soc-sst-baytrail-pcm.o
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
+snd-soc-sst-broadwell-objs := broadwell.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
new file mode 100644
index 0000000..0e550f1
--- /dev/null
+++ b/sound/soc/intel/broadwell.c
@@ -0,0 +1,251 @@
+/*
+ * Intel Broadwell Wildcatpoint SST Audio
+ *
+ * Copyright (C) 2013, Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "sst-dsp.h"
+#include "sst-haswell-ipc.h"
+
+#include "../codecs/rt286.h"
+
+static const struct snd_soc_dapm_widget broadwell_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_MIC("DMIC1", NULL),
+	SND_SOC_DAPM_MIC("DMIC2", NULL),
+	SND_SOC_DAPM_LINE("Line Jack", NULL),
+};
+
+static const struct snd_soc_dapm_route broadwell_rt286_map[] = {
+
+	/* speaker */
+	{"Speaker", NULL, "SPOR"},
+	{"Speaker", NULL, "SPOL"},
+
+	/* HP jack connectors - unknown if we have jack deteck */
+	{"Headphones", NULL, "HPO Pin"},
+
+	/* other jacks */
+	{"MIC1", NULL, "Mic Jack"},
+	{"LINE1", NULL, "Line Jack"},
+
+	/* digital mics */
+	{"DMIC1 Pin", NULL, "DMIC1"},
+	{"DMIC2 Pin", NULL, "DMIC2"},
+
+	/* CODEC BE connections */
+	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
+	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
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
+static int broadwell_rt286_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT286_SCLK_S_PLL, 24000000,
+		SND_SOC_CLOCK_IN);
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops broadwell_rt286_ops = {
+	.hw_params = broadwell_rt286_hw_params,
+};
+
+static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
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
+	/* always connected - check HP for jack detect */
+	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line Jack");
+	snd_soc_dapm_enable_pin(dapm, "DMIC1");
+	snd_soc_dapm_enable_pin(dapm, "DMIC2");
+
+	return 0;
+}
+
+/* broadwell digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link broadwell_rt286_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "System PCM",
+		.stream_name = "System Playback",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = broadwell_rtd_init,
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Offload0",
+		.stream_name = "Offload0 Playback",
+		.cpu_dai_name = "Offload0 Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Offload1",
+		.stream_name = "Offload1 Playback",
+		.cpu_dai_name = "Offload1 Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Loopback PCM",
+		.stream_name = "Loopback",
+		.cpu_dai_name = "Loopback Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 0,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+	},
+	{
+		.name = "Capture PCM",
+		.stream_name = "Capture",
+		.cpu_dai_name = "Capture Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+	},
+
+	/* Back End DAI links */
+	{
+		/* SSP0 - Codec */
+		.name = "Codec",
+		.be_id = 0,
+		.cpu_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "snd-soc-dummy",
+		.no_pcm = 1,
+		.codec_name = "i2c-INT343A:00",
+		.codec_dai_name = "rt286-aif1",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = broadwell_ssp0_fixup,
+		.ops = &broadwell_rt286_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+};
+
+/* broadwell audio machine driver for WPT + RT286S */
+static struct snd_soc_card broadwell_rt286 = {
+	.name = "broadwell-rt286",
+	.owner = THIS_MODULE,
+	.dai_link = broadwell_rt286_dais,
+	.num_links = ARRAY_SIZE(broadwell_rt286_dais),
+	.dapm_widgets = broadwell_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(broadwell_widgets),
+	.dapm_routes = broadwell_rt286_map,
+	.num_dapm_routes = ARRAY_SIZE(broadwell_rt286_map),
+	.fully_routed = true,
+};
+
+static int broadwell_audio_probe(struct platform_device *pdev)
+{
+	broadwell_rt286.dev = &pdev->dev;
+
+	return snd_soc_register_card(&broadwell_rt286);
+}
+
+static int broadwell_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&broadwell_rt286);
+	return 0;
+}
+
+static struct platform_driver broadwell_audio = {
+	.probe = broadwell_audio_probe,
+	.remove = broadwell_audio_remove,
+	.driver = {
+		.name = "broadwell-audio",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(broadwell_audio)
+
+/* Module information */
+MODULE_AUTHOR("Liam Girdwood, Xingchao Wang");
+MODULE_DESCRIPTION("Intel SST Audio for WPT/Broadwell");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:broadwell-audio");
-- 
1.8.3.2
