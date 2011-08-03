From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add SPI support for WM8741
Date: Wed,  3 Aug 2011 17:47:09 +0900
Message-ID: <1312361229-30722-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1312361229-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E901B1038EA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 10:47:17 +0200 (CEST)
In-Reply-To: <1312361229-30722-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8741.c |   48 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index d4bfffd..c1b6e91 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -549,6 +550,43 @@ static struct i2c_driver wm8741_i2c_driver = {
 };
 #endif
 
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8741_spi_probe(struct spi_device *spi)
+{
+	struct wm8741_priv *wm8741;
+	int ret;
+
+	wm8741 = kzalloc(sizeof(struct wm8741_priv), GFP_KERNEL);
+	if (wm8741 == NULL)
+		return -ENOMEM;
+
+	wm8741->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8741);
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_wm8741, &wm8741_dai, 1);
+	if (ret < 0)
+		kfree(wm8741);
+	return ret;
+}
+
+static int __devexit wm8741_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver wm8741_spi_driver = {
+	.driver = {
+		.name	= "wm8741",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8741_spi_probe,
+	.remove		= __devexit_p(wm8741_spi_remove),
+};
+#endif /* CONFIG_SPI_MASTER */
+
 static int __init wm8741_modinit(void)
 {
 	int ret = 0;
@@ -558,6 +596,13 @@ static int __init wm8741_modinit(void)
 	if (ret != 0)
 		pr_err("Failed to register WM8741 I2C driver: %d\n", ret);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&wm8741_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8741 SPI driver: %d\n",
+		       ret);
+	}
+#endif
 
 	return ret;
 }
@@ -565,6 +610,9 @@ module_init(wm8741_modinit);
 
 static void __exit wm8741_exit(void)
 {
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8741_spi_driver);
+#endif
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8741_i2c_driver);
 #endif
-- 
1.7.5.4
