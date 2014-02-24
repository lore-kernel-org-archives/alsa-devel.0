From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 5/7] ASoC: Intel: Add machine driver for
	Baytrail SST with RT5640 codec
Date: Mon, 24 Feb 2014 17:27:00 +0200
Message-ID: <1393255622-31365-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D24AB265324
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 16:27:24 +0100 (CET)
In-Reply-To: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add machine driver for Baytrail SST DSP platform with RT5640 audio codec.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 194 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 sound/soc/intel/byt-rt5640.c

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
new file mode 100644
index 000000000000..038547b48b2d
--- /dev/null
+++ b/sound/soc/intel/byt-rt5640.c
@@ -0,0 +1,194 @@
+/*
+ * Intel Baytrail SST RT5640 machine driver
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../codecs/rt5640.h"
+
+#include "sst-dsp.h"
+
+static const struct snd_soc_dapm_widget byt_rt5640_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_rt5640_audio_map[] = {
+	{"IN2P", NULL, "Headset Mic"},
+	{"IN2N", NULL, "Headset Mic"},
+	{"DMIC1", NULL, "Int Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Ext Spk", NULL, "SPOLP"},
+	{"Ext Spk", NULL, "SPOLN"},
+	{"Ext Spk", NULL, "SPORP"},
+	{"Ext Spk", NULL, "SPORN"},
+};
+
+static const struct snd_kcontrol_new byt_rt5640_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
+};
+
+static int byt_rt5640_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int fmt;
+	int ret;
+
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+	      SND_SOC_DAIFMT_CBS_CFS;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		dev_err(codec_dai->dev,
+			"can't set codec DAI configuration %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_PLL1,
+				     params_rate(params) * 256,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5640_PLL1_S_BCLK1,
+				  params_rate(params) * 64,
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = runtime->card;
+
+	card->dapm.idle_bias_off = true;
+
+	ret = snd_soc_add_card_controls(card, byt_rt5640_controls,
+					ARRAY_SIZE(byt_rt5640_controls));
+	if (ret) {
+		dev_err(card->dev, "unable to add card controls\n");
+		return ret;
+	}
+
+	snd_soc_dapm_ignore_suspend(dapm, "HPOL");
+	snd_soc_dapm_ignore_suspend(dapm, "HPOR");
+
+	snd_soc_dapm_ignore_suspend(dapm, "SPOLP");
+	snd_soc_dapm_ignore_suspend(dapm, "SPOLN");
+	snd_soc_dapm_ignore_suspend(dapm, "SPORP");
+	snd_soc_dapm_ignore_suspend(dapm, "SPORN");
+
+	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+	snd_soc_dapm_enable_pin(dapm, "Headphone");
+	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+	snd_soc_dapm_enable_pin(dapm, "Int Mic");
+
+	snd_soc_dapm_sync(dapm);
+	return ret;
+}
+
+static struct snd_soc_ops byt_rt5640_ops = {
+	.hw_params = byt_rt5640_hw_params,
+};
+
+static struct snd_soc_dai_link byt_rt5640_dais[] = {
+	{
+		.name = "Baytrail Audio",
+		.stream_name = "Audio",
+		.cpu_dai_name = "Front-cpu-dai",
+		.codec_dai_name = "rt5640-aif1",
+		.codec_name = "i2c-10EC5640:00",
+		.platform_name = "baytrail-pcm-audio",
+		.init = byt_rt5640_init,
+		.ignore_suspend = 1,
+		.ops = &byt_rt5640_ops,
+	},
+	{
+		.name = "Baytrail Voice",
+		.stream_name = "Voice",
+		.cpu_dai_name = "Mic1-cpu-dai",
+		.codec_dai_name = "rt5640-aif1",
+		.codec_name = "i2c-10EC5640:00",
+		.platform_name = "baytrail-pcm-audio",
+		.init = NULL,
+		.ignore_suspend = 1,
+		.ops = &byt_rt5640_ops,
+	},
+};
+
+static struct snd_soc_card byt_rt5640_card = {
+	.name = "byt-rt5640",
+	.dai_link = byt_rt5640_dais,
+	.num_links = ARRAY_SIZE(byt_rt5640_dais),
+	.dapm_widgets = byt_rt5640_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5640_widgets),
+	.dapm_routes = byt_rt5640_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
+};
+
+static int byt_rt5640_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &byt_rt5640_card;
+	struct device *dev = &pdev->dev;
+
+	card->dev = &pdev->dev;
+	dev_set_drvdata(dev, card);
+	return snd_soc_register_card(card);
+}
+
+static int byt_rt5640_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver byt_rt5640_audio = {
+	.probe = byt_rt5640_probe,
+	.remove = byt_rt5640_remove,
+	.driver = {
+		.name = "byt-rt5640",
+		.owner = THIS_MODULE,
+	},
+};
+module_platform_driver(byt_rt5640_audio)
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail Machine driver");
+MODULE_AUTHOR("Omair Md Abdullah, Jarkko Nikula");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:byt-rt5640");
-- 
1.8.5.3
