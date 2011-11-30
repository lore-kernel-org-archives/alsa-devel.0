From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Rename Speyside WM8962 to Tobermory
Date: Wed, 30 Nov 2011 13:31:20 +0000
Message-ID: <1322659880-3910-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1ACE4245E9
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 14:31:25 +0100 (CET)
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

All the other machine drivers for non-default configurations are named
after the relevant audio module so do so for Tobermory also.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    6 +-
 sound/soc/samsung/Kconfig             |    4 +-
 sound/soc/samsung/Makefile            |    4 +-
 sound/soc/samsung/speyside_wm8962.c   |  257 ---------------------------------
 sound/soc/samsung/tobermory.c         |  257 +++++++++++++++++++++++++++++++++
 5 files changed, 264 insertions(+), 264 deletions(-)
 delete mode 100644 sound/soc/samsung/speyside_wm8962.c
 create mode 100644 sound/soc/samsung/tobermory.c

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 633f729..4ce4a74 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -286,8 +286,8 @@ static struct platform_device lowland_device = {
 	.id		= -1,
 };
 
-static struct platform_device speyside_wm8962_device = {
-	.name		= "speyside-wm8962",
+static struct platform_device tobermory_device = {
+	.name		= "tobermory",
 	.id		= -1,
 };
 
@@ -347,7 +347,7 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&crag6410_lcd_powerdev,
 	&crag6410_backlight_device,
 	&speyside_device,
-	&speyside_wm8962_device,
+	&tobermory_device,
 	&littlemill_device,
 	&lowland_device,
 	&wallvdd_device,
diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 9634564..f5a857f 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -194,8 +194,8 @@ config SND_SOC_SPEYSIDE
 	select SND_SOC_WM1250_EV1
 	select SND_SOC_WM0010
 
-config SND_SOC_SPEYSIDE_WM8962
-	tristate "Audio support for Wolfson Speyside with WM8962"
+config SND_SOC_TOBERMORY
+	tristate "Audio support for Wolfson Tobermory"
 	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8962
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index c9564e3..9d03beb 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -39,7 +39,7 @@ snd-soc-smdk-spdif-objs := smdk_spdif.o
 snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
 snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
 snd-soc-speyside-objs := speyside.o
-snd-soc-speyside-wm8962-objs := speyside_wm8962.o
+snd-soc-tobermory-objs := tobermory.o
 snd-soc-lowland-objs := lowland.o
 snd-soc-littlemill-objs := littlemill.o
 
@@ -62,6 +62,6 @@ obj-$(CONFIG_SND_SOC_GONI_AQUILA_WM8994) += snd-soc-goni-wm8994.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8994_PCM) += snd-soc-smdk-wm8994pcm.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
-obj-$(CONFIG_SND_SOC_SPEYSIDE_WM8962) += snd-soc-speyside-wm8962.o
+obj-$(CONFIG_SND_SOC_TOBERMORY) += snd-soc-tobermory.o
 obj-$(CONFIG_SND_SOC_LOWLAND) += snd-soc-lowland.o
 obj-$(CONFIG_SND_SOC_LITTLEMILL) += snd-soc-littlemill.o
diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
deleted file mode 100644
index c09648e..0000000
--- a/sound/soc/samsung/speyside_wm8962.c
+++ /dev/null
@@ -1,257 +0,0 @@
-/*
- * Speyside with WM8962 audio support
- *
- * Copyright 2011 Wolfson Microelectronics
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/jack.h>
-#include <linux/gpio.h>
-#include <linux/module.h>
-
-#include "../codecs/wm8962.h"
-
-static int sample_rate = 44100;
-
-static int speyside_wm8962_set_bias_level(struct snd_soc_card *card,
-					  struct snd_soc_dapm_context *dapm,
-					  enum snd_soc_bias_level level)
-{
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	int ret;
-
-	if (dapm->dev != codec_dai->dev)
-		return 0;
-
-	switch (level) {
-	case SND_SOC_BIAS_PREPARE:
-		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
-			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-						  WM8962_FLL_MCLK, 32768,
-						  sample_rate * 512);
-			if (ret < 0)
-				pr_err("Failed to start FLL: %d\n", ret);
-
-			ret = snd_soc_dai_set_sysclk(codec_dai,
-						     WM8962_SYSCLK_FLL,
-						     sample_rate * 512,
-						     SND_SOC_CLOCK_IN);
-			if (ret < 0) {
-				pr_err("Failed to set SYSCLK: %d\n", ret);
-				return ret;
-			}
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int speyside_wm8962_set_bias_level_post(struct snd_soc_card *card,
-					       struct snd_soc_dapm_context *dapm,
-					       enum snd_soc_bias_level level)
-{
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	int ret;
-
-	if (dapm->dev != codec_dai->dev)
-		return 0;
-
-	switch (level) {
-	case SND_SOC_BIAS_STANDBY:
-		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
-					     32768, SND_SOC_CLOCK_IN);
-		if (ret < 0) {
-			pr_err("Failed to switch away from FLL: %d\n", ret);
-			return ret;
-		}
-
-		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
-					  0, 0, 0);
-		if (ret < 0) {
-			pr_err("Failed to stop FLL: %d\n", ret);
-			return ret;
-		}
-		break;
-
-	default:
-		break;
-	}
-
-	dapm->bias_level = level;
-
-	return 0;
-}
-
-static int speyside_wm8962_hw_params(struct snd_pcm_substream *substream,
-			      struct snd_pcm_hw_params *params)
-{
-	sample_rate = params_rate(params);
-
-	return 0;
-}
-
-static struct snd_soc_ops speyside_wm8962_ops = {
-	.hw_params = speyside_wm8962_hw_params,
-};
-
-static struct snd_soc_dai_link speyside_wm8962_dai[] = {
-	{
-		.name = "CPU",
-		.stream_name = "CPU",
-		.cpu_dai_name = "samsung-i2s.0",
-		.codec_dai_name = "wm8962",
-		.platform_name = "samsung-audio",
-		.codec_name = "wm8962.1-001a",
-		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-				| SND_SOC_DAIFMT_CBM_CFM,
-		.ops = &speyside_wm8962_ops,
-	},
-};
-
-static const struct snd_kcontrol_new controls[] = {
-	SOC_DAPM_PIN_SWITCH("Main Speaker"),
-	SOC_DAPM_PIN_SWITCH("DMIC"),
-};
-
-static struct snd_soc_dapm_widget widgets[] = {
-	SND_SOC_DAPM_HP("Headphone", NULL),
-	SND_SOC_DAPM_MIC("Headset Mic", NULL),
-
-	SND_SOC_DAPM_MIC("DMIC", NULL),
-	SND_SOC_DAPM_MIC("AMIC", NULL),
-
-	SND_SOC_DAPM_SPK("Main Speaker", NULL),
-};
-
-static struct snd_soc_dapm_route audio_paths[] = {
-	{ "Headphone", NULL, "HPOUTL" },
-	{ "Headphone", NULL, "HPOUTR" },
-
-	{ "Main Speaker", NULL, "SPKOUTL" },
-	{ "Main Speaker", NULL, "SPKOUTR" },
-
-	{ "Headset Mic", NULL, "MICBIAS" },
-	{ "IN4L", NULL, "Headset Mic" },
-	{ "IN4R", NULL, "Headset Mic" },
-
-	{ "AMIC", NULL, "MICBIAS" },
-	{ "IN1L", NULL, "AMIC" },
-	{ "IN1R", NULL, "AMIC" },
-
-	{ "DMIC", NULL, "MICBIAS" },
-	{ "DMICDAT", NULL, "DMIC" },
-};
-
-static struct snd_soc_jack speyside_wm8962_headset;
-
-/* Headset jack detection DAPM pins */
-static struct snd_soc_jack_pin speyside_wm8962_headset_pins[] = {
-	{
-		.pin = "Headset Mic",
-		.mask = SND_JACK_MICROPHONE,
-	},
-	{
-		.pin = "Headphone",
-		.mask = SND_JACK_MICROPHONE,
-	},
-};
-
-static int speyside_wm8962_late_probe(struct snd_soc_card *card)
-{
-	struct snd_soc_codec *codec = card->rtd[0].codec;
-	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
-				     32768, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_jack_new(codec, "Headset",
-			       SND_JACK_HEADSET | SND_JACK_BTN_0,
-			       &speyside_wm8962_headset);
-	if (ret)
-		return ret;
-
-	ret = snd_soc_jack_add_pins(&speyside_wm8962_headset,
-				    ARRAY_SIZE(speyside_wm8962_headset_pins),
-				    speyside_wm8962_headset_pins);
-	if (ret)
-		return ret;
-
-	wm8962_mic_detect(codec, &speyside_wm8962_headset);
-
-	return 0;
-}
-
-static struct snd_soc_card speyside_wm8962 = {
-	.name = "Speyside WM8962",
-	.dai_link = speyside_wm8962_dai,
-	.num_links = ARRAY_SIZE(speyside_wm8962_dai),
-
-	.set_bias_level = speyside_wm8962_set_bias_level,
-	.set_bias_level_post = speyside_wm8962_set_bias_level_post,
-
-	.controls = controls,
-	.num_controls = ARRAY_SIZE(controls),
-	.dapm_widgets = widgets,
-	.num_dapm_widgets = ARRAY_SIZE(widgets),
-	.dapm_routes = audio_paths,
-	.num_dapm_routes = ARRAY_SIZE(audio_paths),
-	.fully_routed = true,
-
-	.late_probe = speyside_wm8962_late_probe,
-};
-
-static __devinit int speyside_wm8962_probe(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = &speyside_wm8962;
-	int ret;
-
-	card->dev = &pdev->dev;
-
-	ret = snd_soc_register_card(card);
-	if (ret) {
-		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-			ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int __devexit speyside_wm8962_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
-}
-
-static struct platform_driver speyside_wm8962_driver = {
-	.driver = {
-		.name = "speyside-wm8962",
-		.owner = THIS_MODULE,
-		.pm = &snd_soc_pm_ops,
-	},
-	.probe = speyside_wm8962_probe,
-	.remove = __devexit_p(speyside_wm8962_remove),
-};
-
-module_platform_driver(speyside_wm8962_driver);
-
-MODULE_DESCRIPTION("Speyside WM8962 audio support");
-MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:speyside-wm8962");
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
new file mode 100644
index 0000000..6f91c65
--- /dev/null
+++ b/sound/soc/samsung/tobermory.c
@@ -0,0 +1,257 @@
+/*
+ * Tobermory audio support
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
+#include "../codecs/wm8962.h"
+
+static int sample_rate = 44100;
+
+static int tobermory_set_bias_level(struct snd_soc_card *card,
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
+		if (dapm->bias_level == SND_SOC_BIAS_STANDBY) {
+			ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
+						  WM8962_FLL_MCLK, 32768,
+						  sample_rate * 512);
+			if (ret < 0)
+				pr_err("Failed to start FLL: %d\n", ret);
+
+			ret = snd_soc_dai_set_sysclk(codec_dai,
+						     WM8962_SYSCLK_FLL,
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
+static int tobermory_set_bias_level_post(struct snd_soc_card *card,
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
+		ret = snd_soc_dai_set_sysclk(codec_dai, WM8962_SYSCLK_MCLK,
+					     32768, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			pr_err("Failed to switch away from FLL: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_dai_set_pll(codec_dai, WM8962_FLL,
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
+static int tobermory_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	sample_rate = params_rate(params);
+
+	return 0;
+}
+
+static struct snd_soc_ops tobermory_ops = {
+	.hw_params = tobermory_hw_params,
+};
+
+static struct snd_soc_dai_link tobermory_dai[] = {
+	{
+		.name = "CPU",
+		.stream_name = "CPU",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm8962",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8962.1-001a",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
+		.ops = &tobermory_ops,
+	},
+};
+
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Main Speaker"),
+	SOC_DAPM_PIN_SWITCH("DMIC"),
+};
+
+static struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+
+	SND_SOC_DAPM_MIC("DMIC", NULL),
+	SND_SOC_DAPM_MIC("AMIC", NULL),
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
+	{ "Headset Mic", NULL, "MICBIAS" },
+	{ "IN4L", NULL, "Headset Mic" },
+	{ "IN4R", NULL, "Headset Mic" },
+
+	{ "AMIC", NULL, "MICBIAS" },
+	{ "IN1L", NULL, "AMIC" },
+	{ "IN1R", NULL, "AMIC" },
+
+	{ "DMIC", NULL, "MICBIAS" },
+	{ "DMICDAT", NULL, "DMIC" },
+};
+
+static struct snd_soc_jack tobermory_headset;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin tobermory_headset_pins[] = {
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
+static int tobermory_late_probe(struct snd_soc_card *card)
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
+			       &tobermory_headset);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&tobermory_headset,
+				    ARRAY_SIZE(tobermory_headset_pins),
+				    tobermory_headset_pins);
+	if (ret)
+		return ret;
+
+	wm8962_mic_detect(codec, &tobermory_headset);
+
+	return 0;
+}
+
+static struct snd_soc_card tobermory = {
+	.name = "Tobermory",
+	.dai_link = tobermory_dai,
+	.num_links = ARRAY_SIZE(tobermory_dai),
+
+	.set_bias_level = tobermory_set_bias_level,
+	.set_bias_level_post = tobermory_set_bias_level_post,
+
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+	.fully_routed = true,
+
+	.late_probe = tobermory_late_probe,
+};
+
+static __devinit int tobermory_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &tobermory;
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
+static int __devexit tobermory_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver tobermory_driver = {
+	.driver = {
+		.name = "tobermory",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = tobermory_probe,
+	.remove = __devexit_p(tobermory_remove),
+};
+
+module_platform_driver(tobermory_driver);
+
+MODULE_DESCRIPTION("Tobermory audio support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tobermory");
-- 
1.7.7.3
