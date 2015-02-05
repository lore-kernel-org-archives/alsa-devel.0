From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V4 04/10] ASoC: codec: Add MAX98357A codec driver
Date: Thu,  5 Feb 2015 12:53:40 -0800
Message-ID: <1423169626-22166-5-git-send-email-kwestfie@codeaurora.org>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add codec driver for the Maxim MAX98357A DAC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/codecs/Kconfig     |   4 ++
 sound/soc/codecs/Makefile    |   2 +
 sound/soc/codecs/max98357a.c | 138 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 sound/soc/codecs/max98357a.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3190eed43c38d8145536d1804f7686b108f97641..064e6c18e10923fd75609b750405dbc33f9db6af 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -69,6 +69,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX98088 if I2C
 	select SND_SOC_MAX98090 if I2C
 	select SND_SOC_MAX98095 if I2C
+	select SND_SOC_MAX98357A
 	select SND_SOC_MAX9850 if I2C
 	select SND_SOC_MAX9768 if I2C
 	select SND_SOC_MAX9877 if I2C
@@ -456,6 +457,9 @@ config SND_SOC_MAX98090
 config SND_SOC_MAX98095
        tristate
 
+config SND_SOC_MAX98357A
+       tristate
+
 config SND_SOC_MAX9850
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bbdfd1e1c182f9ee102f532f391f522e77a8922b..69b8666d187a0e8d1e2a532e68e2509acc95da7e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -64,6 +64,7 @@ snd-soc-max9768-objs := max9768.o
 snd-soc-max98088-objs := max98088.o
 snd-soc-max98090-objs := max98090.o
 snd-soc-max98095-objs := max98095.o
+snd-soc-max98357a-objs := max98357a.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
@@ -245,6 +246,7 @@ obj-$(CONFIG_SND_SOC_MAX9768)	+= snd-soc-max9768.o
 obj-$(CONFIG_SND_SOC_MAX98088)	+= snd-soc-max98088.o
 obj-$(CONFIG_SND_SOC_MAX98090)	+= snd-soc-max98090.o
 obj-$(CONFIG_SND_SOC_MAX98095)	+= snd-soc-max98095.o
+obj-$(CONFIG_SND_SOC_MAX98357A)	+= snd-soc-max98357a.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
new file mode 100644
index 0000000000000000000000000000000000000000..98b915314d7a00390060411fb1b910aec6f46e9d
--- /dev/null
+++ b/sound/soc/codecs/max98357a.c
@@ -0,0 +1,138 @@
+/* Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * max98357a.c -- MAX98357A ALSA SoC Codec driver
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "max98357a"
+
+static int max98357a_daiops_trigger(struct snd_pcm_substream *substream,
+		int cmd, struct snd_soc_dai *dai)
+{
+	struct gpio_desc *sdmode = snd_soc_dai_get_drvdata(dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		gpiod_set_value(sdmode, 1);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		gpiod_set_value(sdmode, 0);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget max98357a_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("SDMode", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("Speaker"),
+};
+
+static const struct snd_soc_dapm_route max98357a_dapm_routes[] = {
+	{"Speaker", NULL, "SDMode"},
+};
+
+static int max98357a_codec_probe(struct snd_soc_codec *codec)
+{
+	struct gpio_desc *sdmode;
+
+	sdmode = devm_gpiod_get(codec->dev, "sdmode");
+	if (IS_ERR(sdmode)) {
+		dev_err(codec->dev, "%s() unable to get sdmode GPIO: %ld\n",
+				__func__, PTR_ERR(sdmode));
+		return PTR_ERR(sdmode);
+	}
+	gpiod_direction_output(sdmode, 0);
+	snd_soc_codec_set_drvdata(codec, sdmode);
+
+	return 0;
+}
+
+static struct snd_soc_codec_driver max98357a_codec_driver = {
+	.probe			= max98357a_codec_probe,
+	.dapm_widgets		= max98357a_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98357a_dapm_widgets),
+	.dapm_routes		= max98357a_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
+};
+
+static struct snd_soc_dai_ops max98357a_dai_ops = {
+	.trigger	= max98357a_daiops_trigger,
+};
+
+static struct snd_soc_dai_driver max98357a_dai_driver = {
+	.name = DRV_NAME,
+	.playback = {
+		.stream_name	= DRV_NAME "-playback",
+		.formats	= SNDRV_PCM_FMTBIT_S16 |
+					SNDRV_PCM_FMTBIT_S24 |
+					SNDRV_PCM_FMTBIT_S32,
+		.rates		= SNDRV_PCM_RATE_8000 |
+					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_96000,
+		.rate_min	= 8000,
+		.rate_max	= 96000,
+		.channels_min	= 1,
+		.channels_max	= 2,
+	},
+	.ops    = &max98357a_dai_ops,
+};
+
+static int max98357a_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = snd_soc_register_codec(&pdev->dev, &max98357a_codec_driver,
+			&max98357a_dai_driver, 1);
+	if (ret)
+		dev_err(&pdev->dev, "%s() error registering codec driver: %d\n",
+				__func__, ret);
+
+	return ret;
+}
+
+static int max98357a_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id max98357a_device_id[] = {
+	{ .compatible = "maxim," DRV_NAME, },
+	{}
+};
+#endif
+
+static struct platform_driver max98357a_platform_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(max98357a_device_id),
+	},
+	.probe	= max98357a_platform_probe,
+	.remove = max98357a_platform_remove,
+};
+module_platform_driver(max98357a_platform_driver);
+
+MODULE_DESCRIPTION("Maxim MAX98357A Codec Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, max98357a_device_id);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
