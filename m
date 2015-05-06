From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v2 1/4] ASoC: Add gtm601 codec driver
Date: Wed,  6 May 2015 22:38:47 +0200
Message-ID: <1430944730-10480-2-git-send-email-marek@goldelico.com>
References: <1430944730-10480-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430944730-10480-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@kernel.org, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

This driver add PCM interface to a GTM601 UMTS modem chip.
There is no configuration interface.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 sound/soc/codecs/Kconfig  |  4 ++
 sound/soc/codecs/Makefile |  2 +
 sound/soc/codecs/gtm601.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 sound/soc/codecs/gtm601.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..d3a0fa8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -62,6 +62,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_BT_SCO
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
+	select SND_SOC_GTM601
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -444,6 +445,9 @@ config SND_SOC_ES8328_SPI
 	tristate
 	select SND_SOC_ES8328
 
+config SND_SOC_GTM601
+	tristate 'GTM601 UMTS modem audio codec'
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..1fbfbee 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -55,6 +55,7 @@ snd-soc-dmic-objs := dmic.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
+snd-soc-gtm601-objs := gtm601.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -240,6 +241,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
new file mode 100644
index 0000000..1b77ff2
--- /dev/null
+++ b/sound/soc/codecs/gtm601.c
@@ -0,0 +1,98 @@
+/*
+ * This is a simple driver for the GTM601 Voice PCM interface
+ *
+ * Copyright (C) 2015 Goldelico GmbH
+ *
+ * Author: Marek Belisko <marek@goldelico.com>
+ *
+ * Based on wm8727.c driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/ac97_codec.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+static const struct snd_soc_dapm_widget gtm601_dapm_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("AOUT"),
+	SND_SOC_DAPM_INPUT("AIN"),
+};
+
+static const struct snd_soc_dapm_route gtm601_dapm_routes[] = {
+	{ "AOUT", NULL, "Playback" },
+	{ "Capture", NULL, "AIN" },
+};
+
+struct snd_soc_dai_driver gtm601_dai = {
+	.name = "gtm601",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_gtm601 = {
+	.dapm_widgets = gtm601_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(gtm601_dapm_widgets),
+	.dapm_routes = gtm601_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(gtm601_dapm_routes),
+};
+
+static int gtm601_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_gtm601, &gtm601_dai, 1);
+}
+
+static int gtm601_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+MODULE_ALIAS("platform:gtm601_codec_audio");
+
+#if defined(CONFIG_OF)
+static const struct of_device_id gtm601_codec_of_match[] = {
+	{ .compatible = "option,gtm601", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gtm601_codec_of_match);
+#endif
+
+static struct platform_driver gtm601_codec_driver = {
+	.driver = {
+			.name = "gtm601",
+			.owner = THIS_MODULE,
+			.of_match_table = of_match_ptr(gtm601_codec_of_match),
+	},
+
+	.probe = gtm601_platform_probe,
+	.remove = gtm601_platform_remove,
+};
+
+module_platform_driver(gtm601_codec_driver);
+
+MODULE_DESCRIPTION("ASoC gtm601 driver");
+MODULE_AUTHOR("Marek Belisko <marek@goldelico.com>");
+MODULE_LICENSE("GPL");
-- 
1.9.1
