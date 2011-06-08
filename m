From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/6] ASoC: Support Speyside build variants with
	WM8962 fitted
Date: Wed,  8 Jun 2011 14:50:55 +0100
Message-ID: <1307541055-10150-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82EE910392E
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
In-Reply-To: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig           |    6 +
 sound/soc/samsung/Makefile          |    2 +
 sound/soc/samsung/speyside_wm8962.c |  260 +++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/speyside_wm8962.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index d155cbb..b5d7c0d 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -177,3 +177,9 @@ config SND_SOC_SPEYSIDE
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8915
 	select SND_SOC_WM9081
+
+config SND_SOC_SPEYSIDE_WM8962
+	tristate "Audio support for Wolfson Speyside with WM8962"
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	select SND_SAMSUNG_I2S
+	select SND_SOC_WM8962
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 683843a..e04df65 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -36,6 +36,7 @@ snd-soc-goni-wm8994-objs := goni_wm8994.o
 snd-soc-smdk-spdif-objs := smdk_spdif.o
 snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
 snd-soc-speyside-objs := speyside.o
+snd-soc-speyside-wm8962-objs := speyside_wm8962.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -55,3 +56,4 @@ obj-$(CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
 obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
+obj-$(CONFIG_SND_SOC_SPEYSIDE_WM8962) += snd-soc-speyside-wm8962.o
diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
new file mode 100644
index 0000000..c0ba0bf
--- /dev/null
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -0,0 +1,260 @@
+/*
+ * Speyside with WM8962 audio support
+ *
+ * Copyright 2011 Wolfson Microelectronics
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <linux/gpio.h>
+
+#include "../codecs/wm8962.h"
+
+static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
+					  struct snd_soc_dapm_context *dapm,
+					  enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
+			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
+						  WM8962_FLL_MCLK, 32768,
+						  44100 * 256);
+			if (ret < 0)
+				pr_err("Failed to start FLL\n");
+
+			ret = snd_soc_dai_set_sysclk(codec_dai,
+						     WM8962_SYSCLK_FLL,
+						     44100 * 256,
+						     SND_SOC_CLOCK_IN);
+			if (ret < 0)
+				return ret;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int speyside_wm8962_set_bias_level_post(struct snd_soc_card *card,
+					       struct snd_soc_dapm_context *dapm,
+					       enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
+					  0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop FLL\n");
+			return ret;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	dapm->bias_level = level;
+
+	return 0;
+}
+
+static int speyside_wm8962_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops speyside_wm8962_ops = {
+	.hw_params = speyside_wm8962_hw_params,
+};
+
+static struct snd_soc_dai_link speyside_wm8962_dai[] = {
+	{
+		.name = "CPU",
+		.stream_name = "CPU",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm8962",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8962.1-001a",
+		.ops = &speyside_wm8962_ops,
+	},
+};
+
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Main Speaker"),
+};
+
+static struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+
+	SND_SOC_DAPM_MIC("DMIC", NULL),
+
+	SND_SOC_DAPM_SPK("Main Speaker", NULL),
+};
+
+static struct snd_soc_dapm_route audio_paths[] = {
+	{ "Headphone", NULL, "HPOUTL" },
+	{ "Headphone", NULL, "HPOUTR" },
+
+	{ "Main Speaker", NULL, "SPKOUTL" },
+	{ "Main Speaker", NULL, "SPKOUTR" },
+
+	{ "MICBIAS", NULL, "Headset Mic" },
+	{ "IN4L", NULL, "MICBIAS" },
+	{ "IN4R", NULL, "MICBIAS" },
+
+	{ "MICBIAS", NULL, "DMIC" },
+	{ "DMICDAT", NULL, "MICBIAS" },
+};
+
+static struct snd_soc_jack speyside_wm8962_headset;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin speyside_wm8962_headset_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static int speyside_wm8962_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_codec *codec = card->rtd[0].codec;
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
+				     32768, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_jack_new(codec, "Headset",
+			       SND_JACK_HEADSET | SND_JACK_BTN_0,
+			       &speyside_wm8962_headset);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&speyside_wm8962_headset,
+				    ARRAY_SIZE(speyside_wm8962_headset_pins),
+				    speyside_wm8962_headset_pins);
+	if (ret)
+		return ret;
+
+	wm8962_mic_detect(codec, &speyside_wm8962_headset);
+
+	return 0;
+}
+
+static struct snd_soc_card speyside_wm8962 = {
+	.name = "Speyside WM8962",
+	.dai_link = speyside_wm8962_dai,
+	.num_links = ARRAY_SIZE(speyside_wm8962_dai),
+
+	.set_bias_level = speyside_wm8962_set_bias_level,
+	.set_bias_level_post = speyside_wm8962_set_bias_level_post,
+
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+
+	.late_probe = speyside_wm8962_late_probe,
+};
+
+static __devinit int speyside_wm8962_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &speyside_wm8962;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit speyside_wm8962_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver speyside_wm8962_driver = {
+	.driver = {
+		.name = "speyside-wm8962",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = speyside_wm8962_probe,
+	.remove = __devexit_p(speyside_wm8962_remove),
+};
+
+static int __init speyside_wm8962_audio_init(void)
+{
+	return platform_driver_register(&speyside_wm8962_driver);
+}
+module_init(speyside_wm8962_audio_init);
+
+static void __exit speyside_wm8962_audio_exit(void)
+{
+	platform_driver_unregister(&speyside_wm8962_driver);
+}
+module_exit(speyside_wm8962_audio_exit);
+
+MODULE_DESCRIPTION("Speyside WM8962 audio support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:speyside-wm8962");
-- 
1.7.5.3
