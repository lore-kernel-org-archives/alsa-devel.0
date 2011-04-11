From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add initial WM1250-EV1 Springbank audio
	I/O module driver
Date: Sun, 10 Apr 2011 22:16:40 -0700
Message-ID: <1302499000-24376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DE6F10383E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 16:49:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM1250-EV1 Springbank audio I/O module for the Wolfson Glenfarclas
reference platform provides a simple audio I/O with an independant clock
domain, intended to simulate cellular modem and bluetooth subsystems
within the platform.

The card supports some limited GPIO based control but this is currently not
implemented.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Kconfig      |    4 ++
 sound/soc/codecs/Makefile     |    2 +
 sound/soc/codecs/wm1250-ev1.c |   87 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/wm1250-ev1.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 54d5dd6..2a69718 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -53,6 +53,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
+	select SND_SOC_WM1250_EV1 if I2C
 	select SND_SOC_WM2000 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
 	select SND_SOC_WM8400 if MFD_WM8400
@@ -246,6 +247,9 @@ config SND_SOC_UDA1380
 config SND_SOC_WL1273
 	tristate
 
+config SND_SOC_WM1250_EV1
+	tristate
+
 config SND_SOC_WM8350
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 02425e6..4cb2f42 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -38,6 +38,7 @@ snd-soc-twl6040-objs := twl6040.o
 snd-soc-uda134x-objs := uda134x.o
 snd-soc-uda1380-objs := uda1380.o
 snd-soc-wl1273-objs := wl1273.o
+snd-soc-wm1250-ev1-objs := wm1250-ev1.o
 snd-soc-wm8350-objs := wm8350.o
 snd-soc-wm8400-objs := wm8400.o
 snd-soc-wm8510-objs := wm8510.o
@@ -128,6 +129,7 @@ obj-$(CONFIG_SND_SOC_TWL6040)	+= snd-soc-twl6040.o
 obj-$(CONFIG_SND_SOC_UDA134X)	+= snd-soc-uda134x.o
 obj-$(CONFIG_SND_SOC_UDA1380)	+= snd-soc-uda1380.o
 obj-$(CONFIG_SND_SOC_WL1273)	+= snd-soc-wl1273.o
+obj-$(CONFIG_SND_SOC_WM1250_EV1) += snd-soc-wm1250-ev1.o
 obj-$(CONFIG_SND_SOC_WM8350)	+= snd-soc-wm8350.o
 obj-$(CONFIG_SND_SOC_WM8400)	+= snd-soc-wm8400.o
 obj-$(CONFIG_SND_SOC_WM8510)	+= snd-soc-wm8510.o
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
new file mode 100644
index 0000000..260a0ab
--- /dev/null
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -0,0 +1,87 @@
+/*
+ * Driver for the 1250-EV1 Springbank audio I/O module
+ *
+ * Copyright 2011 Wolfson Microelectronics plc
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+#include <sound/soc.h>
+
+static struct snd_soc_dai_driver springbank_dai = {
+	.name = "wm1250-ev1",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 1,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static struct snd_soc_codec_driver soc_codec_dev_springbank;
+
+static int __devinit springbank_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_springbank,
+				      &springbank_dai, 1);
+}
+
+static int __devexit springbank_remove(struct i2c_client *i2c)
+{
+	snd_soc_unregister_codec(&i2c->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id springbank_i2c_id[] = {
+	{ "wm1250-ev1", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, springbank__id);
+
+static struct i2c_driver springbank_i2c_driver = {
+	.driver = {
+		.name = "wm1250-ev1",
+		.owner = THIS_MODULE,
+	},
+	.probe =    springbank_probe,
+	.remove =   __devexit_p(springbank_remove),
+	.id_table = springbank_i2c_id,
+};
+
+static int __init springbank_modinit(void)
+{
+	int ret = 0;
+
+	ret = i2c_add_driver(&springbank_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM1250-EV1 I2C driver: %d\n", ret);
+
+	return ret;
+}
+module_init(springbank_modinit);
+
+static void __exit springbank_exit(void)
+{
+	i2c_del_driver(&springbank_i2c_driver);
+}
+module_exit(springbank_exit);
+
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_DESCRIPTION("WM1250-EV1 Springbank audio I/O module driver");
+MODULE_LICENSE("GPL");
-- 
1.7.4.1
