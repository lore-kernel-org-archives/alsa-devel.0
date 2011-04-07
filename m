From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: SSM2602: add SPI support
Date: Thu,  7 Apr 2011 02:05:11 -0400
Message-ID: <1302156311-16536-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id A8395103870
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 08:05:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

The ssm2602 codec has a SPI interface as well as I2C, so add the simple
bit of glue to make it usable.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/Kconfig   |    2 +-
 sound/soc/codecs/ssm2602.c |   56 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e24d075..910bb66 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -40,7 +40,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_MAX9877 if I2C
 	select SND_SOC_PCM3008
 	select SND_SOC_SPDIF
-	select SND_SOC_SSM2602 if I2C
+	select SND_SOC_SSM2602 if SND_SOC_I2C_AND_SPI
 	select SND_SOC_SSM2604 if I2C
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6b12cff..86fb64c 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -504,6 +505,43 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.reg_cache_default = ssm2602_reg,
 };
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit ssm2602_spi_probe(struct spi_device *spi)
+{
+	struct ssm2602_priv *ssm2602;
+	int ret;
+
+	ssm2602 = kzalloc(sizeof(struct ssm2602_priv), GFP_KERNEL);
+	if (ssm2602 == NULL)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, ssm2602);
+	ssm2602->control_type = SND_SOC_SPI;
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
+	if (ret < 0)
+		kfree(ssm2602);
+	return ret;
+}
+
+static int __devexit ssm2602_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver ssm2602_spi_driver = {
+	.driver = {
+		.name	= "ssm2602",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ssm2602_spi_probe,
+	.remove		= __devexit_p(ssm2602_spi_remove),
+};
+#endif
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * ssm2602 2 wire address is determined by GPIO5
@@ -560,19 +598,29 @@ static struct i2c_driver ssm2602_i2c_driver = {
 static int __init ssm2602_modinit(void)
 {
 	int ret = 0;
+
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&ssm2602_spi_driver);
+	if (ret)
+		return ret;
+#endif
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&ssm2602_i2c_driver);
-	if (ret != 0) {
-		printk(KERN_ERR "Failed to register SSM2602 I2C driver: %d\n",
-		       ret);
-	}
+	if (ret)
+		return ret;
 #endif
+
 	return ret;
 }
 module_init(ssm2602_modinit);
 
 static void __exit ssm2602_exit(void)
 {
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&ssm2602_spi_driver);
+#endif
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&ssm2602_i2c_driver);
 #endif
-- 
1.7.4.1
