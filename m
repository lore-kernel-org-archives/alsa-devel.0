From: Jeremy McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 3/3] ASoC: tlv320aic32x4: Add SPI support.
Date: Mon, 18 Apr 2016 17:24:06 -0700
Message-ID: <1461025446-7693-4-git-send-email-nh6z@nh6z.net>
References: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.xenotropic.com (mail.xenotropic.com [198.178.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 94B1026581B
 for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2016 02:24:24 +0200 (CEST)
In-Reply-To: <1461025446-7693-1-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: Jeremy McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

Add support for running the tlv32x4 control channel over SPI rather than I2C.

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/Kconfig             |  6 +++
 sound/soc/codecs/Makefile            |  2 +
 sound/soc/codecs/tlv320aic32x4-spi.c | 76 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 sound/soc/codecs/tlv320aic32x4-spi.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e313fdd..2e32ef0 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -121,6 +121,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
 	select SND_SOC_TLV320AIC31XX if I2C
 	select SND_SOC_TLV320AIC32X4_I2C if I2C
+	select SND_SOC_TLV320AIC32X4_SPI if SPI_MASTER
 	select SND_SOC_TLV320AIC3X if I2C
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
@@ -708,6 +709,11 @@ config SND_SOC_TLV320AIC32X4_I2C
 	depends on I2C
 	select SND_SOC_TLV320AIC32X4
 
+config SND_SOC_TLV320AIC32X4_SPI
+	tristate
+	depends on SPI_MASTER
+	select SND_SOC_TLV320AIC32X4
+
 config SND_SOC_TLV320AIC3X
 	tristate "Texas Instruments TLV320AIC3x CODECs"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2f7c4c1..926acc5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -126,6 +126,7 @@ snd-soc-tlv320aic26-objs := tlv320aic26.o
 snd-soc-tlv320aic31xx-objs := tlv320aic31xx.o
 snd-soc-tlv320aic32x4-objs := tlv320aic32x4.o
 snd-soc-tlv320aic32x4-i2c-objs := tlv320aic32x4-i2c.o
+snd-soc-tlv320aic32x4-spi-objs := tlv320aic32x4-spi.o
 snd-soc-tlv320aic3x-objs := tlv320aic3x.o
 snd-soc-tlv320dac33-objs := tlv320dac33.o
 snd-soc-ts3a227e-objs := ts3a227e.o
@@ -322,6 +323,7 @@ obj-$(CONFIG_SND_SOC_TLV320AIC26)	+= snd-soc-tlv320aic26.o
 obj-$(CONFIG_SND_SOC_TLV320AIC31XX)     += snd-soc-tlv320aic31xx.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4)     += snd-soc-tlv320aic32x4.o
 obj-$(CONFIG_SND_SOC_TLV320AIC32X4_I2C)	+= snd-soc-tlv320aic32x4-i2c.o
+obj-$(CONFIG_SND_SOC_TLV320AIC32X4_SPI)	+= snd-soc-tlv320aic32x4-spi.o
 obj-$(CONFIG_SND_SOC_TLV320AIC3X)	+= snd-soc-tlv320aic3x.o
 obj-$(CONFIG_SND_SOC_TLV320DAC33)	+= snd-soc-tlv320dac33.o
 obj-$(CONFIG_SND_SOC_TS3A227E)	+= snd-soc-ts3a227e.o
diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
new file mode 100644
index 0000000..724fcdd
--- /dev/null
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -0,0 +1,76 @@
+/*
+ * linux/sound/soc/codecs/tlv320aic32x4-spi.c
+ *
+ * Copyright 2011 NW Digital Radio
+ *
+ * Author: Jeremy McDermond <nh6z@nh6z.net>
+ *
+ * Based on sound/soc/codecs/wm8974 and TI driver for kernel 2.6.27.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "tlv320aic32x4.h"
+
+static int aic32x4_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	struct regmap_config config;
+
+	config = aic32x4_regmap_config;
+	config.reg_bits = 7;
+	config.pad_bits = 1;
+	config.val_bits = 8;
+	config.read_flag_mask = 0x01;
+
+	regmap = devm_regmap_init_spi(spi, &config);
+	return aic32x4_probe(&spi->dev, regmap);
+}
+
+static int aic32x4_spi_remove(struct spi_device *spi)
+{
+	return aic32x4_remove(&spi->dev);
+}
+
+static const struct spi_device_id aic32x4_spi_id[] = {
+	{ "tlv320aic32x4", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, aic32x4_spi_id);
+
+static const struct of_device_id aic32x4_of_id[] = {
+	{ .compatible = "ti,tlv320aic32x4", },
+	{ /* senitel */ }
+};
+MODULE_DEVICE_TABLE(of, aic32x4_of_id);
+
+static struct spi_driver aic32x4_spi_driver = {
+	.driver = {
+		.name = "tlv320aic32x4",
+		.owner = THIS_MODULE,
+		.of_match_table = aic32x4_of_id,
+	},
+	.probe =    aic32x4_spi_probe,
+	.remove =   aic32x4_spi_remove,
+	.id_table = aic32x4_spi_id,
+};
+
+module_spi_driver(aic32x4_spi_driver);
+
+MODULE_DESCRIPTION("ASoC TLV320AIC32x4 codec driver SPI");
+MODULE_AUTHOR("Jeremy McDermond <nh6z@nh6z.net>");
+MODULE_LICENSE("GPL");
-- 
2.5.0
