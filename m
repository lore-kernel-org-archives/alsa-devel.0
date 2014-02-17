From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: ad193x: Split SPI and I2C code into
	different modules
Date: Mon, 17 Feb 2014 13:16:54 +0100
Message-ID: <1392639416-11293-2-git-send-email-lars@metafoo.de>
References: <1392639416-11293-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-234.synserver.de
 [212.40.185.234])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D2E9261B19
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 13:16:47 +0100 (CET)
In-Reply-To: <1392639416-11293-1-git-send-email-lars@metafoo.de>
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
	  modules, one for each bus, allows the registration of the other bus driver
	  to continue without problems if one of them fails.

This patch splits the AD193X driver into 3 modules. One core module that
implements the device logic, but is independent of the bus method used. And one
module for SPI and I2C each that registers the drivers and sets up the regmap
struct for the bus.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/Kconfig    |   3 +-
 sound/soc/codecs/Kconfig      |  11 +++-
 sound/soc/codecs/Makefile     |   4 ++
 sound/soc/codecs/ad193x-i2c.c |  54 ++++++++++++++++
 sound/soc/codecs/ad193x-spi.c |  48 +++++++++++++++
 sound/soc/codecs/ad193x.c     | 140 +++++-------------------------------------
 sound/soc/codecs/ad193x.h     |   7 +++
 7 files changed, 140 insertions(+), 127 deletions(-)
 create mode 100644 sound/soc/codecs/ad193x-i2c.c
 create mode 100644 sound/soc/codecs/ad193x-spi.c

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 90262b9..89f7748 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -68,7 +68,8 @@ config SND_BF5XX_SOC_AD193X
 	tristate "SoC AD193X Audio support for Blackfin"
 	depends on SND_BF5XX_I2S && SND_SOC_I2C_AND_SPI
 	select SND_BF5XX_SOC_I2S
-	select SND_SOC_AD193X
+	select SND_SOC_AD193X_I2C if I2C
+	select SND_SOC_AD193X_SPI if SPI_MASTER
 	help
 	  Say Y if you want to add support for AD193X codec on Blackfin.
 	  This driver supports AD1936, AD1937, AD1938 and AD1939.
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0de36ae..a9b75c5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -18,7 +18,8 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_AB8500_CODEC if ABX500_CORE
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1836 if SPI_MASTER
-	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
+	select SND_SOC_AD193X_SPI if SPI_MASTER
+	select SND_SOC_AD193X_I2C if I2C
 	select SND_SOC_AD1980 if SND_SOC_AC97_BUS
 	select SND_SOC_AD73311
 	select SND_SOC_ADAU1373 if I2C
@@ -187,6 +188,14 @@ config SND_SOC_AD1836
 config SND_SOC_AD193X
 	tristate
 
+config SND_SOC_AD193X_SPI
+	tristate
+	select SND_SOC_AD193X
+
+config SND_SOC_AD193X_I2C
+	tristate
+	select SND_SOC_AD193X
+
 config SND_SOC_AD1980
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 55d4973..6be463b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -3,6 +3,8 @@ snd-soc-ab8500-codec-objs := ab8500-codec.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1836-objs := ad1836.o
 snd-soc-ad193x-objs := ad193x.o
+snd-soc-ad193x-spi-objs := ad193x-spi.o
+snd-soc-ad193x-i2c-objs := ad193x-i2c.o
 snd-soc-ad1980-objs := ad1980.o
 snd-soc-ad73311-objs := ad73311.o
 snd-soc-adau1701-objs := adau1701.o
@@ -137,6 +139,8 @@ obj-$(CONFIG_SND_SOC_AB8500_CODEC)	+= snd-soc-ab8500-codec.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
+obj-$(CONFIG_SND_SOC_AD193X_SPI)	+= snd-soc-ad193x-spi.o
+obj-$(CONFIG_SND_SOC_AD193X_I2C)	+= snd-soc-ad193x-i2c.o
 obj-$(CONFIG_SND_SOC_AD1980)	+= snd-soc-ad1980.o
 obj-$(CONFIG_SND_SOC_AD73311) += snd-soc-ad73311.o
 obj-$(CONFIG_SND_SOC_ADAU1373)	+= snd-soc-adau1373.o
diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
new file mode 100644
index 0000000..df3a1a4
--- /dev/null
+++ b/sound/soc/codecs/ad193x-i2c.c
@@ -0,0 +1,54 @@
+/*
+ * AD1936/AD1937 audio driver
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
+#include "ad193x.h"
+
+static const struct i2c_device_id ad193x_id[] = {
+	{ "ad1936", 0 },
+	{ "ad1937", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad193x_id);
+
+static int ad193x_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap_config config;
+
+	config = ad193x_regmap_config;
+	config.val_bits = 8;
+	config.reg_bits = 8;
+
+	return ad193x_probe(&client->dev, devm_regmap_init_i2c(client, &config));
+}
+
+static int ad193x_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
+}
+
+static struct i2c_driver ad193x_i2c_driver = {
+	.driver = {
+		.name = "ad193x",
+	},
+	.probe    = ad193x_i2c_probe,
+	.remove   = ad193x_i2c_remove,
+	.id_table = ad193x_id,
+};
+module_i2c_driver(ad193x_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC AD1936/AD1937 audio CODEC driver");
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
new file mode 100644
index 0000000..390cef9
--- /dev/null
+++ b/sound/soc/codecs/ad193x-spi.c
@@ -0,0 +1,48 @@
+/*
+ * AD1938/AD1939 audio driver
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
+#include "ad193x.h"
+
+static int ad193x_spi_probe(struct spi_device *spi)
+{
+	struct regmap_config config;
+
+	config = ad193x_regmap_config;
+	config.val_bits = 8;
+	config.reg_bits = 16;
+	config.read_flag_mask = 0x09;
+	config.write_flag_mask = 0x08;
+
+	return ad193x_probe(&spi->dev, devm_regmap_init_spi(spi, &config));
+}
+
+static int ad193x_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	return 0;
+}
+
+static struct spi_driver ad193x_spi_driver = {
+	.driver = {
+		.name	= "ad193x",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ad193x_spi_probe,
+	.remove		= ad193x_spi_remove,
+};
+module_spi_driver(ad193x_spi_driver);
+
+MODULE_DESCRIPTION("ASoC AD1938/AD1939 audio CODEC driver");
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index 5a42dca..f644a34 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -6,12 +6,10 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/i2c.h>
-#include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -19,6 +17,7 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
+
 #include "ad193x.h"
 
 /* codec private data */
@@ -320,7 +319,7 @@ static struct snd_soc_dai_driver ad193x_dai = {
 	.ops = &ad193x_dai_ops,
 };
 
-static int ad193x_probe(struct snd_soc_codec *codec)
+static int ad193x_codec_probe(struct snd_soc_codec *codec)
 {
 	struct ad193x_priv *ad193x = snd_soc_codec_get_drvdata(codec);
 	int ret;
@@ -352,7 +351,7 @@ static int ad193x_probe(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ad193x = {
-	.probe = 	ad193x_probe,
+	.probe = ad193x_codec_probe,
 	.controls = ad193x_snd_controls,
 	.num_controls = ARRAY_SIZE(ad193x_snd_controls),
 	.dapm_widgets = ad193x_dapm_widgets,
@@ -366,140 +365,31 @@ static bool adau193x_reg_volatile(struct device *dev, unsigned int reg)
 	return false;
 }
 
-#if defined(CONFIG_SPI_MASTER)
-
-static const struct regmap_config ad193x_spi_regmap_config = {
-	.val_bits = 8,
-	.reg_bits = 16,
-	.read_flag_mask = 0x09,
-	.write_flag_mask = 0x08,
-
+const struct regmap_config ad193x_regmap_config = {
 	.max_register = AD193X_NUM_REGS - 1,
 	.volatile_reg = adau193x_reg_volatile,
 };
+EXPORT_SYMBOL_GPL(ad193x_regmap_config);
 
-static int ad193x_spi_probe(struct spi_device *spi)
+int ad193x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ad193x_priv *ad193x;
 
-	ad193x = devm_kzalloc(&spi->dev, sizeof(struct ad193x_priv),
-			      GFP_KERNEL);
-	if (ad193x == NULL)
-		return -ENOMEM;
-
-	ad193x->regmap = devm_regmap_init_spi(spi, &ad193x_spi_regmap_config);
-	if (IS_ERR(ad193x->regmap))
-		return PTR_ERR(ad193x->regmap);
-
-	spi_set_drvdata(spi, ad193x);
-
-	return snd_soc_register_codec(&spi->dev, &soc_codec_dev_ad193x,
-			&ad193x_dai, 1);
-}
-
-static int ad193x_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
-static struct spi_driver ad193x_spi_driver = {
-	.driver = {
-		.name	= "ad193x",
-		.owner	= THIS_MODULE,
-	},
-	.probe		= ad193x_spi_probe,
-	.remove		= ad193x_spi_remove,
-};
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-
-static const struct regmap_config ad193x_i2c_regmap_config = {
-	.val_bits = 8,
-	.reg_bits = 8,
-
-	.max_register = AD193X_NUM_REGS - 1,
-	.volatile_reg = adau193x_reg_volatile,
-};
-
-static const struct i2c_device_id ad193x_id[] = {
-	{ "ad1936", 0 },
-	{ "ad1937", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ad193x_id);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
-static int ad193x_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
-{
-	struct ad193x_priv *ad193x;
-
-	ad193x = devm_kzalloc(&client->dev, sizeof(struct ad193x_priv),
-			      GFP_KERNEL);
+	ad193x = devm_kzalloc(dev, sizeof(*ad193x), GFP_KERNEL);
 	if (ad193x == NULL)
 		return -ENOMEM;
 
-	ad193x->regmap = devm_regmap_init_i2c(client, &ad193x_i2c_regmap_config);
-	if (IS_ERR(ad193x->regmap))
-		return PTR_ERR(ad193x->regmap);
-
-	i2c_set_clientdata(client, ad193x);
-
-	return snd_soc_register_codec(&client->dev, &soc_codec_dev_ad193x,
-			&ad193x_dai, 1);
-}
-
-static int ad193x_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
+	ad193x->regmap = regmap;
 
-static struct i2c_driver ad193x_i2c_driver = {
-	.driver = {
-		.name = "ad193x",
-	},
-	.probe    = ad193x_i2c_probe,
-	.remove   = ad193x_i2c_remove,
-	.id_table = ad193x_id,
-};
-#endif
-
-static int __init ad193x_modinit(void)
-{
-	int ret;
-
-#if IS_ENABLED(CONFIG_I2C)
-	ret =  i2c_add_driver(&ad193x_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register AD193X I2C driver: %d\n",
-				ret);
-	}
-#endif
-
-#if defined(CONFIG_SPI_MASTER)
-	ret = spi_register_driver(&ad193x_spi_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register AD193X SPI driver: %d\n",
-				ret);
-	}
-#endif
-	return ret;
-}
-module_init(ad193x_modinit);
-
-static void __exit ad193x_modexit(void)
-{
-#if defined(CONFIG_SPI_MASTER)
-	spi_unregister_driver(&ad193x_spi_driver);
-#endif
+	dev_set_drvdata(dev, ad193x);
 
-#if IS_ENABLED(CONFIG_I2C)
-	i2c_del_driver(&ad193x_i2c_driver);
-#endif
+	return snd_soc_register_codec(dev, &soc_codec_dev_ad193x,
+		&ad193x_dai, 1);
 }
-module_exit(ad193x_modexit);
+EXPORT_SYMBOL_GPL(ad193x_probe);
 
 MODULE_DESCRIPTION("ASoC ad193x driver");
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
diff --git a/sound/soc/codecs/ad193x.h b/sound/soc/codecs/ad193x.h
index 4733880..ab9a998 100644
--- a/sound/soc/codecs/ad193x.h
+++ b/sound/soc/codecs/ad193x.h
@@ -9,6 +9,13 @@
 #ifndef __AD193X_H__
 #define __AD193X_H__
 
+#include <linux/regmap.h>
+
+struct device;
+
+extern const struct regmap_config ad193x_regmap_config;
+int ad193x_probe(struct device *dev, struct regmap *regmap);
+
 #define AD193X_PLL_CLK_CTRL0    0x00
 #define AD193X_PLL_POWERDOWN           0x01
 #define AD193X_PLL_INPUT_MASK   0x6
-- 
1.8.0
