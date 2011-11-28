From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add basic 1277-EV1 Littlemill audio
	driver
Date: Mon, 28 Nov 2011 22:06:51 +0000
Message-ID: <1322518011-12317-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 983382447C
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 23:06:55 +0100 (CET)
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

The Littlemill audio card supports a number of pluggable miniboards,
normally for the WM8994 family of devices. As all these devices look
mostly the same from an external configuration point of view and are
runtime enumerable we can write a standard machine driver which will
work out of the box with any of them. Start doing that with the bare
bones of a driver, only supporting AIF1.

Future patches will flesh this out to be more fully featured.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig      |    6 +
 sound/soc/samsung/Makefile     |    2 +
 sound/soc/samsung/littlemill.c |  227 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 235 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/littlemill.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 4520cc1..9634564 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -206,3 +206,9 @@ config SND_SOC_LOWLAND
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5100
 	select SND_SOC_WM9081
+
+config SND_SOC_LITTLEMILL
+	tristate "Audio support for Wolfson Littlemill"
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	select SND_SAMSUNG_I2S
+	select SND_SOC_WM8994
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 7802c25..c9564e3 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -41,6 +41,7 @@ snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
 snd-soc-speyside-objs := speyside.o
 snd-soc-speyside-wm8962-objs := speyside_wm8962.o
 snd-soc-lowland-objs := lowland.o
+snd-soc-littlemill-objs := littlemill.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -63,3 +64,4 @@ obj-$(CONFIG_SND_SOC_SMDK_WM8994_PCM) += snd-soc-smdk-wm8994pcm.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE_WM8962) += snd-soc-speyside-wm8962.o
 obj-$(CONFIG_SND_SOC_LOWLAND) += snd-soc-lowland.o
+obj-$(CONFIG_SND_SOC_LITTLEMILL) += snd-soc-littlemill.o
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
new file mode 100644
index 0000000..d2a44ab
--- /dev/null
+++ b/sound/soc/samsung/littlemill.c
@@ -0,0 +1,227 @@
+/*
+ * Littlemill audio support
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
+#include <linux/module.h>
+
+#include "../codecs/wm8994.h"
+
+static int sample_rate = 44100;
+
+static int littlemill_set_bias_level(struct snd_soc_card *card,
+					  struct snd_soc_dapm_context *dapm,
+					  enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	if (dapm->dev != codec_dai->dev)
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_PREPARE:
+		/*
+		 * If we've not already clocked things via hw_params()
+		 * then do so now, otherwise these are noops.
+		 */
+		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
+			ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1,
+						  WM8994_FLL_SRC_MCLK2, 32768,
+						  sample_rate * 512);
+			if (ret < 0) {
+				pr_err("Failed to start FLL: %d\n", ret);
+				return ret;
+			}
+
+			ret = snd_soc_dai_set_sysclk(codec_dai,
+						     WM8994_SYSCLK_FLL1,
+						     sample_rate * 512,
+						     SND_SOC_CLOCK_IN);
+			if (ret < 0) {
+				pr_err("Failed to set SYSCLK: %d\n", ret);
+				return ret;
+			}
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
+static int littlemill_set_bias_level_post(struct snd_soc_card *card,
+					       struct snd_soc_dapm_context *dapm,
+					       enum snd_soc_bias_level level)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	if (dapm->dev != codec_dai->dev)
+		return 0;
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_MCLK2,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to switch away from FLL: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1,
+					  0, 0, 0);
+		if (ret < 0) {
+			pr_err("Failed to stop FLL: %d\n", ret);
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
+static int littlemill_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	sample_rate = params_rate(params);
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1,
+				  WM8994_FLL_SRC_MCLK2, 32768,
+				  sample_rate * 512);
+	if (ret < 0) {
+		pr_err("Failed to start FLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+				     WM8994_SYSCLK_FLL1,
+				     sample_rate * 512,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err("Failed to set SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops littlemill_ops = {
+	.hw_params = littlemill_hw_params,
+};
+
+static struct snd_soc_dai_link littlemill_dai[] = {
+	{
+		.name = "CPU",
+		.stream_name = "CPU",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm8994-aif1",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8994-codec",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.ops = &littlemill_ops,
+	},
+};
+
+static struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+};
+
+static struct snd_soc_dapm_route audio_paths[] = {
+	{ "Headphone", NULL, "HPOUT1L" },
+	{ "Headphone", NULL, "HPOUT1R" },
+};
+
+static int littlemill_late_probe(struct snd_soc_card *card)
+{
+	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_MCLK2,
+				     32768, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_card littlemill = {
+	.name = "Littlemill",
+	.dai_link = littlemill_dai,
+	.num_links = ARRAY_SIZE(littlemill_dai),
+
+	.set_bias_level = littlemill_set_bias_level,
+	.set_bias_level_post = littlemill_set_bias_level_post,
+
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+
+	.late_probe = littlemill_late_probe,
+};
+
+static __devinit int littlemill_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &littlemill;
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
+static int __devexit littlemill_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver littlemill_driver = {
+	.driver = {
+		.name = "littlemill",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = littlemill_probe,
+	.remove = __devexit_p(littlemill_remove),
+};
+
+module_platform_driver(littlemill_driver);
+
+MODULE_DESCRIPTION("Littlemill audio support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:littlemill");
-- 
1.7.7.3
