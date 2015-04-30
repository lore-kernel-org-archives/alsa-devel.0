From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Thu, 30 Apr 2015 23:28:01 +0200
Message-ID: <1430429283-27907-2-git-send-email-marek@goldelico.com>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430429283-27907-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@kernel.org, hns@goldelico.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Marek Belisko <marek@goldelico.com>
List-Id: alsa-devel@alsa-project.org

This driver add PCM interface to a GTM601 UMTS modem chip.
There is no configuration interface.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 sound/soc/codecs/Kconfig  |   4 ++
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/gtm601.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 sound/soc/codecs/gtm601.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..c399a5d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -170,6 +170,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_WM9705 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9712 if SND_SOC_AC97_BUS
 	select SND_SOC_WM9713 if SND_SOC_AC97_BUS
+	select SND_SOC_GTM601
         help
           Normally ASoC codec drivers are only built if a machine driver which
           uses them is also built since they are only usable with a machine
@@ -844,6 +845,9 @@ config SND_SOC_WM9712
 config SND_SOC_WM9713
 	tristate
 
+config SND_SOC_GTM601
+	tristate 'GTM601 UMTS modem audio codec'
+
 # Amp
 config SND_SOC_LM4857
 	tristate
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..bcafd4a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -175,6 +175,7 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
+snd-soc-gtm601-objs := gtm601.o
 
 # Amp
 snd-soc-max9877-objs := max9877.o
@@ -357,6 +358,7 @@ obj-$(CONFIG_SND_SOC_WM9712)	+= snd-soc-wm9712.o
 obj-$(CONFIG_SND_SOC_WM9713)	+= snd-soc-wm9713.o
 obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
+obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
diff --git a/sound/soc/codecs/gtm601.c b/sound/soc/codecs/gtm601.c
new file mode 100644
index 0000000..05234a1
--- /dev/null
+++ b/sound/soc/codecs/gtm601.c
@@ -0,0 +1,106 @@
+/*
+ * This is a simple driver for the GTM601 Voice PCM interface
+ *
+ * Copyright (C) 2015 Goldelico GmbH
+ *
+ * Author: Marek Belisko <marek@goldelico.com>
+ *
+ * Based on wm8727.c driver
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
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
+/*
+ * Note this is a simple chip with no configuration interface, sample rate is
+ * determined automatically by examining the Master clock and Bit clock ratios
+ */
+
+#define GTM601_RATES  (SNDRV_PCM_RATE_8000)
+
+struct snd_soc_dai_driver gtm601_dai = {
+	.name = "gtm601",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = GTM601_RATES,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = GTM601_RATES,
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
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
