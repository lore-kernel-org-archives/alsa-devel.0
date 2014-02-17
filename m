From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: ssm2602: Split SPI and I2C code into
	different modules
Date: Mon, 17 Feb 2014 13:16:53 +0100
Message-ID: <1392639416-11293-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-234.synserver.de
 [212.40.185.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 952DE261B07
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 13:16:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There are a few known (minor) problems with having the support code for both I2C
and SPI in the same module:
    * We need to be extra careful to make sure to not build the driver into the
      kernel if one of the subsystems is build as a module (Currently only SPI
      can be build as a module).
    * The module init path error handling is rather ugly. E.g. what should be
      done if either the SPI or the I2C driver fails to register? Most drivers
      that implement SPI and I2C in the same module currently fallback to
      undefined behavior in that case. Splitting the the driver into two
      modules, one for each bus allows the registration of the other bus driver
      to continue without problems if one of them fails.

This patch splits the AD193X driver into 3 modules. One core module that
implements the device logic, but is independent of the bus method used. And one
module for SPI and I2C each that registers the drivers and sets up the regmap
struct for the bus.

While we are at it also cleanup the include section of the ssm2602 driver and
remove unneeded includes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/Kconfig     |   3 +-
 sound/soc/codecs/Kconfig       |  11 ++-
 sound/soc/codecs/Makefile      |   4 ++
 sound/soc/codecs/ssm2602-i2c.c |  57 +++++++++++++++
 sound/soc/codecs/ssm2602-spi.c |  41 +++++++++++
 sound/soc/codecs/ssm2602.c     | 158 ++++++-----------------------------------
 sound/soc/codecs/ssm2602.h     |  14 ++++
 7 files changed, 148 insertions(+), 140 deletions(-)
 create mode 100644 sound/soc/codecs/ssm2602-i2c.c
 create mode 100644 sound/soc/codecs/ssm2602-spi.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 4544d8e..90262b9 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -14,7 +14,8 @@ config SND_BF5XX_SOC_SSM2602
 	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S if !BF60x
 	select SND_BF6XX_SOC_I2S if BF60x
-	select SND_SOC_SSM2602
+	select SND_SOC_SSM2602_SPI if SPI_MASTER
+	select SND_SOC_SSM2602_I2C if I2C
 	help
 	  Say Y if you want to add support for the Analog Devices
 	  SSM2602 Audio Codec Add-On Card.
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cc56201..0de36ae 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -70,7 +70,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_SN95031 if INTEL_SCU_IPC
 	select SND_SOC_SPDIF
 	select SND_SOC_SSM2518 if I2C
-	select SND_SOC_SSM2602 if SND_SOC_I2C_AND_SPI
+	select SND_SOC_SSM2602_SPI if SPI_MASTER
+	select SND_SOC_SSM2602_I2C if I2C
 	select SND_SOC_STA32X if I2C
 	select SND_SOC_STA529 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
@@ -361,6 +362,14 @@ config SND_SOC_SSM2518
 config SND_SOC_SSM2602
 	tristate
 
+config SND_SOC_SSM2602_SPI
+	select SND_SOC_SSM2602
+	tristate
+
+config SND_SOC_SSM2602_I2C
+	select SND_SOC_SSM2602
+	tristate
+
 config SND_SOC_STA32X
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index d3b536f..55d4973 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -59,6 +59,8 @@ snd-soc-spdif-tx-objs := spdif_transmitter.o
 snd-soc-spdif-rx-objs := spdif_receiver.o
 snd-soc-ssm2518-objs := ssm2518.o
 snd-soc-ssm2602-objs := ssm2602.o
+snd-soc-ssm2602-spi-objs := ssm2602-spi.o
+snd-soc-ssm2602-i2c-objs := ssm2602-i2c.o
 snd-soc-sta32x-objs := sta32x.o
 snd-soc-sta529-objs := sta529.o
 snd-soc-stac9766-objs := stac9766.o
@@ -190,6 +192,8 @@ obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
 obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SSM2518)	+= snd-soc-ssm2518.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
+obj-$(CONFIG_SND_SOC_SSM2602_SPI)	+= snd-soc-ssm2602-spi.o
+obj-$(CONFIG_SND_SOC_SSM2602_I2C)	+= snd-soc-ssm2602-i2c.o
 obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
 obj-$(CONFIG_SND_SOC_STA529)   += snd-soc-sta529.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
diff --git a/sound/soc/codecs/ssm2602-i2c.c b/sound/soc/codecs/ssm2602-i2c.c
new file mode 100644
index 0000000..abd63d5
--- /dev/null
+++ b/sound/soc/codecs/ssm2602-i2c.c
@@ -0,0 +1,57 @@
+/*
+ * SSM2602/SSM2603/SSM2604 I2C audio driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+
+#include <sound/soc.h>
+
+#include "ssm2602.h"
+
+/*
+ * ssm2602 2 wire address is determined by GPIO5
+ * state during powerup.
+ *    low  = 0x1a
+ *    high = 0x1b
+ */
+static int ssm2602_i2c_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	return ssm2602_probe(&client->dev, id->driver_data,
+		devm_regmap_init_i2c(client, &ssm2602_regmap_config));
+}
+
+static int ssm2602_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static const struct i2c_device_id ssm2602_i2c_id[] = {
+	{ "ssm2602", SSM2602 },
+	{ "ssm2603", SSM2602 },
+	{ "ssm2604", SSM2604 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
+
+static struct i2c_driver ssm2602_i2c_driver = {
+	.driver = {
+		.name = "ssm2602",
+		.owner = THIS_MODULE,
+	},
+	.probe = ssm2602_i2c_probe,
+	.remove = ssm2602_i2c_remove,
+	.id_table = ssm2602_i2c_id,
+};
+module_i2c_driver(ssm2602_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC SSM2602/SSM2603/SSM2604 I2C driver");
+MODULE_AUTHOR("Cliff Cai");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ssm2602-spi.c b/sound/soc/codecs/ssm2602-spi.c
new file mode 100644
index 0000000..2bf55e2
--- /dev/null
+++ b/sound/soc/codecs/ssm2602-spi.c
@@ -0,0 +1,41 @@
+/*
+ * SSM2602 SPI audio driver
+ *
+ * Copyright 2014 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+
+#include <sound/soc.h>
+
+#include "ssm2602.h"
+
+static int ssm2602_spi_probe(struct spi_device *spi)
+{
+	return ssm2602_probe(&spi->dev, SSM2602,
+		devm_regmap_init_spi(spi, &ssm2602_regmap_config));
+}
+
+static int ssm2602_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver ssm2602_spi_driver = {
+	.driver = {
+		.name	= "ssm2602",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ssm2602_spi_probe,
+	.remove		= ssm2602_spi_remove,
+};
+module_spi_driver(ssm2602_spi_driver);
+
+MODULE_DESCRIPTION("ASoC SSM2602 SPI driver");
+MODULE_AUTHOR("Cliff Cai");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index f444d58..49d28ea 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -27,28 +27,16 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <sound/core.h>
+
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/initval.h>
 #include <sound/tlv.h>
 
 #include "ssm2602.h"
 
-enum ssm2602_type {
-	SSM2602,
-	SSM2604,
-};
-
 /* codec private data */
 struct ssm2602_priv {
 	unsigned int sysclk;
@@ -529,7 +517,7 @@ static int ssm2602_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int ssm2602_probe(struct snd_soc_codec *codec)
+static int ssm2602_codec_probe(struct snd_soc_codec *codec)
 {
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
@@ -554,7 +542,7 @@ static int ssm2602_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(ssm2602_routes));
 }
 
-static int ssm2604_probe(struct snd_soc_codec *codec)
+static int ssm2604_codec_probe(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
@@ -568,7 +556,7 @@ static int ssm2604_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(ssm2604_routes));
 }
 
-static int ssm260x_probe(struct snd_soc_codec *codec)
+static int ssm260x_codec_probe(struct snd_soc_codec *codec)
 {
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	int ret;
@@ -597,10 +585,10 @@ static int ssm260x_probe(struct snd_soc_codec *codec)
 
 	switch (ssm2602->type) {
 	case SSM2602:
-		ret = ssm2602_probe(codec);
+		ret = ssm2602_codec_probe(codec);
 		break;
 	case SSM2604:
-		ret = ssm2604_probe(codec);
+		ret = ssm2604_codec_probe(codec);
 		break;
 	}
 
@@ -620,7 +608,7 @@ static int ssm2602_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
-	.probe =	ssm260x_probe,
+	.probe =	ssm260x_codec_probe,
 	.remove =	ssm2602_remove,
 	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
@@ -639,7 +627,7 @@ static bool ssm2602_register_volatile(struct device *dev, unsigned int reg)
 	return reg == SSM2602_RESET;
 }
 
-static const struct regmap_config ssm2602_regmap_config = {
+const struct regmap_config ssm2602_regmap_config = {
 	.val_bits = 9,
 	.reg_bits = 7,
 
@@ -650,134 +638,28 @@ static const struct regmap_config ssm2602_regmap_config = {
 	.reg_defaults_raw = ssm2602_reg,
 	.num_reg_defaults_raw = ARRAY_SIZE(ssm2602_reg),
 };
+EXPORT_SYMBOL_GPL(ssm2602_regmap_config);
 
-#if defined(CONFIG_SPI_MASTER)
-static int ssm2602_spi_probe(struct spi_device *spi)
+int ssm2602_probe(struct device *dev, enum ssm2602_type type,
+	struct regmap *regmap)
 {
 	struct ssm2602_priv *ssm2602;
-	int ret;
-
-	ssm2602 = devm_kzalloc(&spi->dev, sizeof(struct ssm2602_priv),
-			       GFP_KERNEL);
-	if (ssm2602 == NULL)
-		return -ENOMEM;
-
-	spi_set_drvdata(spi, ssm2602);
-	ssm2602->type = SSM2602;
-
-	ssm2602->regmap = devm_regmap_init_spi(spi, &ssm2602_regmap_config);
-	if (IS_ERR(ssm2602->regmap))
-		return PTR_ERR(ssm2602->regmap);
-
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
-	return ret;
-}
 
-static int ssm2602_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
-static struct spi_driver ssm2602_spi_driver = {
-	.driver = {
-		.name	= "ssm2602",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= ssm2602_spi_probe,
-	.remove		= ssm2602_spi_remove,
-};
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-/*
- * ssm2602 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-static int ssm2602_i2c_probe(struct i2c_client *i2c,
-			     const struct i2c_device_id *id)
-{
-	struct ssm2602_priv *ssm2602;
-	int ret;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-	ssm2602 = devm_kzalloc(&i2c->dev, sizeof(struct ssm2602_priv),
-			       GFP_KERNEL);
+	ssm2602 = devm_kzalloc(dev, sizeof(*ssm2602), GFP_KERNEL);
 	if (ssm2602 == NULL)
 		return -ENOMEM;
 
-	i2c_set_clientdata(i2c, ssm2602);
-	ssm2602->type = id->driver_data;
-
-	ssm2602->regmap = devm_regmap_init_i2c(i2c, &ssm2602_regmap_config);
-	if (IS_ERR(ssm2602->regmap))
-		return PTR_ERR(ssm2602->regmap);
-
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
-	return ret;
-}
-
-static int ssm2602_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
-static const struct i2c_device_id ssm2602_i2c_id[] = {
-	{ "ssm2602", SSM2602 },
-	{ "ssm2603", SSM2602 },
-	{ "ssm2604", SSM2604 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
-
-/* corgi i2c codec control layer */
-static struct i2c_driver ssm2602_i2c_driver = {
-	.driver = {
-		.name = "ssm2602",
-		.owner = THIS_MODULE,
-	},
-	.probe = ssm2602_i2c_probe,
-	.remove = ssm2602_i2c_remove,
-	.id_table = ssm2602_i2c_id,
-};
-#endif
-
-
-static int __init ssm2602_modinit(void)
-{
-	int ret = 0;
-
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&ssm2602_spi_driver);
-	if (ret)
-		return ret;
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret = i2c_add_driver(&ssm2602_i2c_driver);
-	if (ret)
-		return ret;
-#endif
-
-	return ret;
-}
-module_init(ssm2602_modinit);
-
-static void __exit ssm2602_exit(void)
-{
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&ssm2602_spi_driver);
-#endif
+	dev_set_drvdata(dev, ssm2602);
+	ssm2602->type = SSM2602;
+	ssm2602->regmap = regmap;
 
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&ssm2602_i2c_driver);
-#endif
+	return snd_soc_register_codec(dev, &soc_codec_dev_ssm2602,
+		&ssm2602_dai, 1);
 }
-module_exit(ssm2602_exit);
+EXPORT_SYMBOL_GPL(ssm2602_probe);
 
 MODULE_DESCRIPTION("ASoC SSM2602/SSM2603/SSM2604 driver");
 MODULE_AUTHOR("Cliff Cai");
diff --git a/sound/soc/codecs/ssm2602.h b/sound/soc/codecs/ssm2602.h
index fbd07d7..7475388 100644
--- a/sound/soc/codecs/ssm2602.h
+++ b/sound/soc/codecs/ssm2602.h
@@ -28,6 +28,20 @@
 #ifndef _SSM2602_H
 #define _SSM2602_H
 
+#include <linux/regmap.h>
+
+struct device;
+
+enum ssm2602_type {
+	SSM2602,
+	SSM2604,
+};
+
+extern const struct regmap_config ssm2602_regmap_config;
+
+int ssm2602_probe(struct device *dev, enum ssm2602_type type,
+	struct regmap *regmap);
+
 /* SSM2602 Codec Register definitions */
 
 #define SSM2602_LINVOL   0x00
-- 
1.8.0
