From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 6/6] ASoC: Intel: Add Haswell Machine support
Date: Thu, 20 Feb 2014 21:48:47 +0000
Message-ID: <1392932927-9725-6-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D3C83265873
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 22:49:23 +0100 (CET)
In-Reply-To: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add support for Haswell based machines with SST DSP audio.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/Kconfig   |  11 +++
 sound/soc/intel/Makefile  |   5 +
 sound/soc/intel/haswell.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 257 insertions(+)
 create mode 100644 sound/soc/intel/haswell.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 4f1ac8f..ce5a692 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -26,3 +26,14 @@ config SND_SOC_INTEL_SST_ACPI
 
 config SND_SOC_INTEL_HASWELL
 	tristate
+
+config SND_SOC_INTEL_HASWELL_MACH
+        tristate "ASoC Audio DSP support for Intel Haswell Lynxpoint"
+        depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
+	select SND_SOC_INTEL_HASWELL
+	select SND_SOC_RT5640
+	help
+          This adds support for the Lynxpoint Audio DSP on Intel(R) Haswell
+	  Ultrabook platforms.
+          Say Y if you have such a device
+          If unsure select "N".
\ No newline at end of file
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 4c08b21..1c18815 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -16,3 +16,8 @@ snd-soc-sst-haswell-pcm-objs := \
 	sst-haswell-ipc.o sst-haswell-pcm.o sst-haswell-dsp.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += snd-soc-sst-haswell-pcm.o
+
+# Machine support
+snd-soc-sst-haswell-objs := haswell.o
+
+obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
new file mode 100644
index 0000000..0d61197
--- /dev/null
+++ b/sound/soc/intel/haswell.c
@@ -0,0 +1,241 @@
+/*
+ * Intel Haswell Lynxpoint SST Audio
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
+#include "../codecs/rt5640.h"
+
+/* Haswell ULT platforms have a Headphone and Mic jack */
+static const struct snd_soc_dapm_widget haswell_widgets[] = {
+	SND_SOC_DAPM_HP("Headphones", NULL),
+	SND_SOC_DAPM_MIC("Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route haswell_rt5640_map[] = {
+
+	{"Headphones", NULL, "HPOR"},
+	{"Headphones", NULL, "HPOL"},
+	{"IN2P", NULL, "Mic"},
+
+	/* CODEC BE connections */
+	{"SSP0 CODEC IN", NULL, "AIF1 Capture"},
+	{"AIF1 Playback", NULL, "SSP0 CODEC OUT"},
+};
+
+static int haswell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
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
+static int haswell_rt5640_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	/* Set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec DAI configuration\n");
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_MCLK, 12288000,
+		SND_SOC_CLOCK_IN);
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	/* set correct codec filter for DAI format and clock config */
+	snd_soc_update_bits(rtd->codec, 0x83, 0xffff, 0x8000);
+
+	return ret;
+}
+
+static struct snd_soc_ops haswell_rt5640_ops = {
+	.hw_params = haswell_rt5640_hw_params,
+};
+
+static int haswell_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct sst_pdata *pdata = dev_get_platdata(rtd->platform->dev);
+	struct sst_hsw *haswell = pdata->dsp;
+	int ret;
+
+	/* Set ADSP SSP port settings */
+	ret = sst_hsw_device_set_config(haswell, SST_HSW_DEVICE_SSP_0,
+		SST_HSW_DEVICE_MCLK_FREQ_24_MHZ,
+		SST_HSW_DEVICE_CLOCK_MASTER, 9);
+	if (ret < 0) {
+		dev_err(rtd->dev, "failed to set device config\n");
+		return ret;
+	}
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(dapm, "Headphones");
+	snd_soc_dapm_enable_pin(dapm, "Mic");
+
+	return 0;
+}
+
+static struct snd_soc_dai_link haswell_rt5640_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "System",
+		.stream_name = "System Playback",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "haswell-pcm-audio",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = haswell_rtd_init,
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
+		.name = "Loopback",
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
+		.name = "Capture",
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
+		.codec_name = "i2c-INT33CA:00",
+		.codec_dai_name = "rt5640-aif1",
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = haswell_ssp0_fixup,
+		.ops = &haswell_rt5640_ops,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+};
+
+/* audio machine driver for Haswell Lynxpoint DSP + RT5640 */
+static struct snd_soc_card haswell_rt5640 = {
+	.name = "haswell-rt5640",
+	.owner = THIS_MODULE,
+	.dai_link = haswell_rt5640_dais,
+	.num_links = ARRAY_SIZE(haswell_rt5640_dais),
+	.dapm_widgets = haswell_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(haswell_widgets),
+	.dapm_routes = haswell_rt5640_map,
+	.num_dapm_routes = ARRAY_SIZE(haswell_rt5640_map),
+	.fully_routed = true,
+};
+
+static int haswell_audio_probe(struct platform_device *pdev)
+{
+	haswell_rt5640.dev = &pdev->dev;
+
+	return snd_soc_register_card(&haswell_rt5640);
+}
+
+static int haswell_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&haswell_rt5640);
+	return 0;
+}
+
+static struct platform_driver haswell_audio = {
+	.probe = haswell_audio_probe,
+	.remove = haswell_audio_remove,
+	.driver = {
+		.name = "haswell-audio",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(haswell_audio)
+
+/* Module information */
+MODULE_AUTHOR("Liam Girdwood, Xingchao Wang");
+MODULE_DESCRIPTION("Intel SST Audio for Haswell Lynxpoint");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:haswell-audio");
-- 
1.8.3.2
