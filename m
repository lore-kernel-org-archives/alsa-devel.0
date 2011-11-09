From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add Lowland machine driver
Date: Wed,  9 Nov 2011 16:50:45 +0000
Message-ID: <1320857445-5983-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 34A12243A6
	for <alsa-devel@Alsa-project.org>; Wed,  9 Nov 2011 17:50:48 +0100 (CET)
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
Cc: alsa-devel@Alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Lowland platform is based on the Cragganmore system like Speyside but
uses the WM5100 audio CODEC.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig   |    7 ++
 sound/soc/samsung/Makefile  |    2 +
 sound/soc/samsung/lowland.c |  246 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/lowland.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index c7598ed..4520cc1 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -199,3 +199,10 @@ config SND_SOC_SPEYSIDE_WM8962
 	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8962
+
+config SND_SOC_LOWLAND
+	tristate "Audio support for Wolfson Lowland"
+	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
+	select SND_SAMSUNG_I2S
+	select SND_SOC_WM5100
+	select SND_SOC_WM9081
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 8509d3c..7802c25 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -40,6 +40,7 @@ snd-soc-smdk-wm8580pcm-objs := smdk_wm8580pcm.o
 snd-soc-smdk-wm8994pcm-objs := smdk_wm8994pcm.o
 snd-soc-speyside-objs := speyside.o
 snd-soc-speyside-wm8962-objs := speyside_wm8962.o
+snd-soc-lowland-objs := lowland.o
 
 obj-$(CONFIG_SND_SOC_SAMSUNG_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_SOC_SAMSUNG_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -61,3 +62,4 @@ obj-$(CONFIG_SND_SOC_SMDK_WM8580_PCM) += snd-soc-smdk-wm8580pcm.o
 obj-$(CONFIG_SND_SOC_SMDK_WM8994_PCM) += snd-soc-smdk-wm8994pcm.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE) += snd-soc-speyside.o
 obj-$(CONFIG_SND_SOC_SPEYSIDE_WM8962) += snd-soc-speyside-wm8962.o
+obj-$(CONFIG_SND_SOC_LOWLAND) += snd-soc-lowland.o
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
new file mode 100644
index 0000000..eff1b4b
--- /dev/null
+++ b/sound/soc/samsung/lowland.c
@@ -0,0 +1,246 @@
+/*
+ * Lowland audio support
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
+#include "../codecs/wm5100.h"
+#include "../codecs/wm9081.h"
+
+#define MCLK1_RATE (44100 * 512)
+#define CLKOUT_RATE (44100 * 256)
+
+static int lowland_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
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
+static struct snd_soc_ops lowland_ops = {
+	.hw_params = lowland_hw_params,
+};
+
+static struct snd_soc_jack lowland_headset;
+
+/* Headset jack detection DAPM pins */
+static struct snd_soc_jack_pin lowland_headset_pins[] = {
+	{
+		.pin = "Headphone",
+		.mask = SND_JACK_HEADPHONE | SND_JACK_LINEOUT,
+	},
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	},
+};
+
+static int lowland_wm5100_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	ret = snd_soc_codec_set_sysclk(codec, WM5100_CLK_SYSCLK,
+				       WM5100_CLKSRC_MCLK1, MCLK1_RATE,
+				       SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		pr_err("Failed to set SYSCLK clock source: %d\n", ret);
+		return ret;
+	}
+
+	/* Clock OPCLK, used by the other audio components. */
+	ret = snd_soc_codec_set_sysclk(codec, WM5100_CLK_OPCLK, 0,
+				       CLKOUT_RATE, 0);
+	if (ret < 0) {
+		pr_err("Failed to set OPCLK rate: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_jack_new(codec, "Headset",
+			       SND_JACK_LINEOUT | SND_JACK_HEADSET |
+			       SND_JACK_BTN_0,
+			       &lowland_headset);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&lowland_headset,
+				    ARRAY_SIZE(lowland_headset_pins),
+				    lowland_headset_pins);
+	if (ret)
+		return ret;
+
+	wm5100_detect(codec, &lowland_headset);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link lowland_dai[] = {
+	{
+		.name = "CPU",
+		.stream_name = "CPU",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm5100-aif1",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm5100.1-001a",
+		.ops = &lowland_ops,
+		.init = lowland_wm5100_init,
+	},
+	{
+		.name = "Baseband",
+		.stream_name = "Baseband",
+		.cpu_dai_name = "wm5100-aif2",
+		.codec_dai_name = "wm1250-ev1",
+		.codec_name = "wm1250-ev1.1-0027",
+		.ops = &lowland_ops,
+		.ignore_suspend = 1,
+	},
+};
+
+static int lowland_wm9081_init(struct snd_soc_dapm_context *dapm)
+{
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT");
+
+	/* At any time the WM9081 is active it will have this clock */
+	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK, 0,
+					CLKOUT_RATE, 0);
+}
+
+static struct snd_soc_aux_dev lowland_aux_dev[] = {
+	{
+		.name = "wm9081",
+		.codec_name = "wm9081.1-006c",
+		.init = lowland_wm9081_init,
+	},
+};
+
+static struct snd_soc_codec_conf lowland_codec_conf[] = {
+	{
+		.dev_name = "wm9081.1-006c",
+		.name_prefix = "Sub",
+	},
+};
+
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Main Speaker"),
+	SOC_DAPM_PIN_SWITCH("Main DMIC"),
+	SOC_DAPM_PIN_SWITCH("Main AMIC"),
+	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
+	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+};
+
+static struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+
+	SND_SOC_DAPM_SPK("Main Speaker", NULL),
+
+	SND_SOC_DAPM_MIC("Main AMIC", NULL),
+	SND_SOC_DAPM_MIC("Main DMIC", NULL),
+};
+
+static struct snd_soc_dapm_route audio_paths[] = {
+	{ "Sub IN1", NULL, "HPOUT2L" },
+	{ "Sub IN2", NULL, "HPOUT2R" },
+
+	{ "Main Speaker", NULL, "Sub SPKN" },
+	{ "Main Speaker", NULL, "Sub SPKP" },
+	{ "Main Speaker", NULL, "SPKDAT1" },
+};
+
+static struct snd_soc_card lowland = {
+	.name = "Lowland",
+	.dai_link = lowland_dai,
+	.num_links = ARRAY_SIZE(lowland_dai),
+	.aux_dev = lowland_aux_dev,
+	.num_aux_devs = ARRAY_SIZE(lowland_aux_dev),
+	.codec_conf = lowland_codec_conf,
+	.num_configs = ARRAY_SIZE(lowland_codec_conf),
+
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_paths,
+	.num_dapm_routes = ARRAY_SIZE(audio_paths),
+};
+
+static __devinit int lowland_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &lowland;
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
+static int __devexit lowland_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver lowland_driver = {
+	.driver = {
+		.name = "lowland",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = lowland_probe,
+	.remove = __devexit_p(lowland_remove),
+};
+
+static int __init lowland_audio_init(void)
+{
+	return platform_driver_register(&lowland_driver);
+}
+module_init(lowland_audio_init);
+
+static void __exit lowland_audio_exit(void)
+{
+	platform_driver_unregister(&lowland_driver);
+}
+module_exit(lowland_audio_exit);
+
+MODULE_DESCRIPTION("Lowland audio support");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:lowland");
-- 
1.7.7.2
