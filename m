From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 7/7] ASoC: hda - added Skylake I2S machine
	driver
Date: Fri, 17 Apr 2015 14:43:20 +0530
Message-ID: <1429262000-21517-8-git-send-email-vinod.koul@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D1B99260582
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 11:18:53 +0200 (CEST)
In-Reply-To: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Omair M Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Add the SKL I2S machine driver using Realtek ALC286S codec
in I2S mode.

Signed-off-by: Omair M Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/Kconfig            |   14 ++
 sound/soc/hda/Makefile           |    3 +
 sound/soc/hda/boards/Makefile    |    3 +
 sound/soc/hda/boards/skl_rt286.c |  313 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 333 insertions(+)
 create mode 100644 sound/soc/hda/boards/Makefile
 create mode 100644 sound/soc/hda/boards/skl_rt286.c

diff --git a/sound/soc/hda/Kconfig b/sound/soc/hda/Kconfig
index f4a7cfa24eb7..8781f63abcf6 100644
--- a/sound/soc/hda/Kconfig
+++ b/sound/soc/hda/Kconfig
@@ -26,4 +26,18 @@ config SND_SOC_HDA_SKL
 
 	To compile this driver as a module, choose M here: the module
 	will be called snd-soc-hda-skl.
+
+config SND_SOC_I2S_SKL_MACH
+        tristate "SOC Machine Audio driver for SKL Onboard I2S"
+        select SND_SOC_HDA_SKL
+        select SND_SOC_RT286
+        select SND_SOC_HDMI
+        select SND_SOC_DMIC
+        default n
+        help
+        This adds support for ASoC Onboard Codec I2S machine driver. This will
+        create an alsa sound card.
+        Say Y if you have such a device
+        If unsure select "N".
+
 endmenu
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index 99aee14b85ed..d9bd33259233 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,3 +1,6 @@
 snd-soc-hda-skl-objs := hda_skl.o hda_skl_pcm.o
 
 obj-$(CONFIG_SND_SOC_HDA_SKL) += snd-soc-hda-skl.o
+
+# Machine support
+obj-$(CONFIG_SND_SOC_HDA_SKL) += boards/
diff --git a/sound/soc/hda/boards/Makefile b/sound/soc/hda/boards/Makefile
new file mode 100644
index 000000000000..26a507de678a
--- /dev/null
+++ b/sound/soc/hda/boards/Makefile
@@ -0,0 +1,3 @@
+snd-soc-skl_rt286-objs := skl_rt286.o
+
+obj-$(CONFIG_SND_SOC_I2S_SKL_MACH) += snd-soc-skl_rt286.o
diff --git a/sound/soc/hda/boards/skl_rt286.c b/sound/soc/hda/boards/skl_rt286.c
new file mode 100644
index 000000000000..459d4c0035d3
--- /dev/null
+++ b/sound/soc/hda/boards/skl_rt286.c
@@ -0,0 +1,313 @@
+/*
+ * Intel Skylake I2S Machine Driver
+ *
+ * Copyright (C) 2014-2015, Intel Corporation. All rights reserved.
+ *
+ * Modified from:
+ *   Intel Broadwell Wildcatpoint SST Audio
+ *
+ *   Copyright (C) 2013, Intel Corporation. All rights reserved.
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
+
+#include "../../codecs/rt286.h"
+
+static struct snd_soc_jack skylake_headset;
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin skylake_headset_pins[] = {
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
+static const struct snd_kcontrol_new skylake_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Mic Jack"),
+};
+
+static const struct snd_soc_dapm_widget skylake_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_MIC("DMIC2", NULL),
+};
+
+static const struct snd_soc_dapm_route skylake_rt286_map[] = {
+	/* speaker */
+	{"Speaker", NULL, "SPOR"},
+	{"Speaker", NULL, "SPOL"},
+
+	/* HP jack connectors - unknown if we have jack deteck */
+	{"Headphone Jack", NULL, "HPO Pin"},
+
+	/* other jacks */
+	{"MIC1", NULL, "Mic Jack"},
+
+	/* digital mics */
+	{"DMIC2 Pin", NULL, "DMIC2"},
+
+	/* CODEC BE connections */
+	{ "AIF1 Playback", NULL, "ssp0 Tx"},
+	{ "ssp0 Tx", NULL, "codec0_out"},
+	{ "ssp0 Tx", NULL, "codec1_out"},
+
+	{ "codec0_in", NULL, "ssp0 Rx" },
+	{ "codec1_in", NULL, "ssp0 Rx" },
+	{ "ssp0 Rx", NULL, "AIF1 Capture" },
+
+	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
+	{ "dmic23_hifi", NULL, "DMIC23 Rx" },
+	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "DMIC23 Rx", NULL, "Capture" },
+
+	{ "hif1", NULL, "iDisp Tx"},
+	{ "iDisp Tx", NULL, "iDisp_out"},
+
+};
+
+static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret = 0;
+
+	ret = snd_soc_card_jack_new(rtd->card, "Headset",
+		SND_JACK_HEADSET | SND_JACK_BTN_0,
+		&skylake_headset,
+		skylake_headset_pins, ARRAY_SIZE(skylake_headset_pins));
+
+	if (ret)
+		return ret;
+
+	rt286_mic_detect(codec, &skylake_headset);
+	return 0;
+}
+
+
+static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
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
+static int skylake_rt286_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT286_SCLK_S_PLL, 24000000,
+		SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_ops skylake_rt286_ops = {
+	.hw_params = skylake_rt286_hw_params,
+};
+
+static int skylake_rtd_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	/* always connected - check HP for jack detect */
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "DMIC2");
+
+	return 0;
+}
+
+/* skylake digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link skylake_rt286_dais[] = {
+	/* Front End DAI links */
+	{
+		.name = "Skl Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.init = skylake_rtd_init,
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	{
+		.name = "Skl Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.nonatomic = 1,
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
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
+	{
+		.name = "Skl HDMI Port",
+		.stream_name = "Hdmi",
+		.cpu_dai_name = "System Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.ignore_suspend = 1,
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
+		.codec_name = "i2c-INT343A:00",
+		.codec_dai_name = "rt286-aif1",
+		.init = skylake_rt286_codec_init,
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBS_CFS,
+		.ignore_suspend = 1,
+		.ignore_pmdown_time = 1,
+		.be_hw_params_fixup = skylake_ssp0_fixup,
+		.ops = &skylake_rt286_ops,
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
+	{
+		.name = "dmic23",
+		.be_id = 2,
+		.cpu_dai_name = "DMIC23 Pin",
+		.codec_name = "dmic-codec",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "0000:00:1f.3",
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp",
+		.be_id = 3,
+		.cpu_dai_name = "iDisp Pin",
+		.codec_name = "codec#002.2",
+		.codec_dai_name = "intel-hdmi-hif1",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.ignore_suspend = 1,
+		.no_pcm = 1,
+	},
+};
+
+/* skylake audio machine driver for SPT + RT286S */
+static struct snd_soc_card skylake_rt286 = {
+	.name = "skylake-rt286",
+	.owner = THIS_MODULE,
+	.dai_link = skylake_rt286_dais,
+	.num_links = ARRAY_SIZE(skylake_rt286_dais),
+	.controls = skylake_controls,
+	.num_controls = ARRAY_SIZE(skylake_controls),
+	.dapm_widgets = skylake_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(skylake_widgets),
+	.dapm_routes = skylake_rt286_map,
+	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
+};
+
+static int skylake_audio_probe(struct platform_device *pdev)
+{
+	skylake_rt286.dev = &pdev->dev;
+
+	return snd_soc_register_card(&skylake_rt286);
+}
+
+static int skylake_audio_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_card(&skylake_rt286);
+	return 0;
+}
+
+static struct platform_driver skylake_audio = {
+	.probe = skylake_audio_probe,
+	.remove = skylake_audio_remove,
+	.driver = {
+		.name = "skl_alc286s_i2s",
+	},
+};
+
+module_platform_driver(skylake_audio)
+
+/* Module information */
+MODULE_AUTHOR("Omair Mohammed Abdullah <omair.m.abdullah@intel.com>");
+MODULE_DESCRIPTION("Intel SST Audio for Skylake");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:skl_alc286s_i2s");
-- 
1.7.9.5
