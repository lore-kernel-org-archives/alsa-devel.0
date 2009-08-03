From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/8] ASoC: Add I/O control bus information to
	factored out cache setup
Date: Mon,  3 Aug 2009 17:09:47 +0100
Message-ID: <1249315790-22814-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4E6DD24796
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:55 +0200 (CEST)
In-Reply-To: <1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

While writes tend to be able to use a fairly bus independant format to
do the writes reads are all bus specific. To allow us to factor out
this code include the bus type as a parameter when setting up the
cache.

Initially just use this to factor out hw_write_t for I2C.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h       |    9 ++++++++-
 sound/soc/codecs/wm8510.c |   10 +++++-----
 sound/soc/codecs/wm8580.c |    8 ++++----
 sound/soc/codecs/wm8728.c |   10 +++++-----
 sound/soc/codecs/wm8731.c |   10 +++++-----
 sound/soc/codecs/wm8750.c |   10 +++++-----
 sound/soc/codecs/wm8960.c |    8 ++++----
 sound/soc/codecs/wm8971.c |    8 ++++----
 sound/soc/codecs/wm8988.c |   10 +++++-----
 sound/soc/soc-cache.c     |   19 ++++++++++++++++++-
 10 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 27409dd..d0b29a5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -187,13 +187,20 @@ typedef int (*hw_read_t)(void *,char* ,int);
 
 extern struct snd_ac97_bus_ops soc_ac97_ops;
 
+enum snd_soc_control_type {
+	SND_SOC_CUSTOM,
+	SND_SOC_I2C,
+	SND_SOC_SPI,
+};
+
 int snd_soc_register_platform(struct snd_soc_platform *platform);
 void snd_soc_unregister_platform(struct snd_soc_platform *platform);
 int snd_soc_register_codec(struct snd_soc_codec *codec);
 void snd_soc_unregister_codec(struct snd_soc_codec *codec);
 int snd_soc_codec_volatile_register(struct snd_soc_codec *codec, int reg);
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits);
+			       int addr_bits, int data_bits,
+			       enum snd_soc_control_type control);
 
 #ifdef CONFIG_PM
 int snd_soc_suspend_device(struct device *dev);
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 7a169bf..4ca724f 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -564,7 +564,8 @@ static int wm8510_resume(struct platform_device *pdev)
  * initialise the WM8510 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8510_init(struct snd_soc_device *socdev)
+static int wm8510_init(struct snd_soc_device *socdev,
+		       enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret = 0;
@@ -580,7 +581,7 @@ static int wm8510_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8510: failed to set cache I/O: %d\n",
 		       ret);
@@ -635,7 +636,7 @@ static int wm8510_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = wm8510_init(socdev);
+	ret = wm8510_init(socdev, SND_SOC_I2C);
 	if (ret < 0)
 		pr_err("failed to initialise WM8510\n");
 
@@ -715,7 +716,7 @@ static int __devinit wm8510_spi_probe(struct spi_device *spi)
 
 	codec->control_data = spi;
 
-	ret = wm8510_init(socdev);
+	ret = wm8510_init(socdev, SND_SOC_SPI);
 	if (ret < 0)
 		dev_err(&spi->dev, "failed to initialise WM8510\n");
 
@@ -784,7 +785,6 @@ static int wm8510_probe(struct platform_device *pdev)
 	wm8510_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8510_add_i2c_device(pdev, setup);
 	}
 #endif
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 2250ade..d547347 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -832,7 +832,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8580 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8580);
 
-static int wm8580_register(struct wm8580_priv *wm8580)
+static int wm8580_register(struct wm8580_priv *wm8580,
+			   enum snd_soc_control_type control)
 {
 	int ret, i;
 	struct snd_soc_codec *codec = &wm8580->codec;
@@ -859,7 +860,7 @@ static int wm8580_register(struct wm8580_priv *wm8580)
 
 	memcpy(codec->reg_cache, wm8580_reg, sizeof(wm8580_reg));
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -944,14 +945,13 @@ static int wm8580_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	codec = &wm8580->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	i2c_set_clientdata(i2c, wm8580);
 	codec->control_data = i2c;
 
 	codec->dev = &i2c->dev;
 
-	return wm8580_register(wm8580);
+	return wm8580_register(wm8580, SND_SOC_I2C);
 }
 
 static int wm8580_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 66da44b..a28630d 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -248,7 +248,8 @@ static int wm8728_resume(struct platform_device *pdev)
  * initialise the WM8728 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8728_init(struct snd_soc_device *socdev)
+static int wm8728_init(struct snd_soc_device *socdev,
+		       enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int ret = 0;
@@ -266,7 +267,7 @@ static int wm8728_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to configure cache I/O: %d\n",
 		       ret);
@@ -323,7 +324,7 @@ static int wm8728_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = wm8728_init(socdev);
+	ret = wm8728_init(socdev, SND_SOC_I2C);
 	if (ret < 0)
 		pr_err("failed to initialise WM8728\n");
 
@@ -403,7 +404,7 @@ static int __devinit wm8728_spi_probe(struct spi_device *spi)
 
 	codec->control_data = spi;
 
-	ret = wm8728_init(socdev);
+	ret = wm8728_init(socdev, SND_SOC_SPI);
 	if (ret < 0)
 		dev_err(&spi->dev, "failed to initialise WM8728\n");
 
@@ -472,7 +473,6 @@ static int wm8728_probe(struct platform_device *pdev)
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8728_add_i2c_device(pdev, setup);
 	}
 #endif
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4eb84ff..27fc942 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -504,7 +504,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8731 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
 
-static int wm8731_register(struct wm8731_priv *wm8731)
+static int wm8731_register(struct wm8731_priv *wm8731,
+			   enum snd_soc_control_type control)
 {
 	int ret;
 	struct snd_soc_codec *codec = &wm8731->codec;
@@ -531,7 +532,7 @@ static int wm8731_register(struct wm8731_priv *wm8731)
 
 	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -630,7 +631,7 @@ static int __devinit wm8731_spi_probe(struct spi_device *spi)
 
 	dev_set_drvdata(&spi->dev, wm8731);
 
-	return wm8731_register(wm8731);
+	return wm8731_register(wm8731, SND_SOC_SPI);
 }
 
 static int __devexit wm8731_spi_remove(struct spi_device *spi)
@@ -682,14 +683,13 @@ static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	codec = &wm8731->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	i2c_set_clientdata(i2c, wm8731);
 	codec->control_data = i2c;
 
 	codec->dev = &i2c->dev;
 
-	return wm8731_register(wm8731);
+	return wm8731_register(wm8731, SND_SOC_I2C);
 }
 
 static __devexit int wm8731_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index ed09043..e6422b1 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -711,7 +711,8 @@ static int wm8750_resume(struct platform_device *pdev)
  * initialise the WM8750 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8750_init(struct snd_soc_device *socdev)
+static int wm8750_init(struct snd_soc_device *socdev,
+		       enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int reg, ret = 0;
@@ -726,7 +727,7 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -809,7 +810,7 @@ static int wm8750_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, codec);
 	codec->control_data = i2c;
 
-	ret = wm8750_init(socdev);
+	ret = wm8750_init(socdev, SND_SOC_I2C);
 	if (ret < 0)
 		pr_err("failed to initialise WM8750\n");
 
@@ -889,7 +890,7 @@ static int __devinit wm8750_spi_probe(struct spi_device *spi)
 
 	codec->control_data = spi;
 
-	ret = wm8750_init(socdev);
+	ret = wm8750_init(socdev, SND_SOC_SPI);
 	if (ret < 0)
 		dev_err(&spi->dev, "failed to initialise WM8750\n");
 
@@ -967,7 +968,6 @@ static int wm8750_probe(struct platform_device *pdev)
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8750_add_i2c_device(pdev, setup);
 	}
 #endif
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index c529ffc..f59703b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -747,7 +747,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8960 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8960);
 
-static int wm8960_register(struct wm8960_priv *wm8960)
+static int wm8960_register(struct wm8960_priv *wm8960,
+			   enum snd_soc_control_type control)
 {
 	struct wm8960_data *pdata = wm8960->codec.dev->platform_data;
 	struct snd_soc_codec *codec = &wm8960->codec;
@@ -785,7 +786,7 @@ static int wm8960_register(struct wm8960_priv *wm8960)
 
 	memcpy(codec->reg_cache, wm8960_reg, sizeof(wm8960_reg));
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -866,14 +867,13 @@ static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	codec = &wm8960->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	i2c_set_clientdata(i2c, wm8960);
 	codec->control_data = i2c;
 
 	codec->dev = &i2c->dev;
 
-	return wm8960_register(wm8960);
+	return wm8960_register(wm8960, SND_SOC_I2C);
 }
 
 static __devexit int wm8960_i2c_remove(struct i2c_client *client)
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 53f3bc9..d66efb0 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -640,7 +640,8 @@ static int wm8971_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8971_init(struct snd_soc_device *socdev)
+static int wm8971_init(struct snd_soc_device *socdev,
+		       enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
 	int reg, ret = 0;
@@ -656,7 +657,7 @@ static int wm8971_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -734,7 +735,7 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	codec->control_data = i2c;
 
-	ret = wm8971_init(socdev);
+	ret = wm8971_init(socdev, SND_SOC_I2C);
 	if (ret < 0)
 		pr_err("failed to initialise WM8971\n");
 
@@ -844,7 +845,6 @@ static int wm8971_probe(struct platform_device *pdev)
 
 #if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
 	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
 		ret = wm8971_add_i2c_device(pdev, setup);
 	}
 #endif
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 7d5b807..7486d3e 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -825,7 +825,8 @@ struct snd_soc_codec_device soc_codec_dev_wm8988 = {
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8988);
 
-static int wm8988_register(struct wm8988_priv *wm8988)
+static int wm8988_register(struct wm8988_priv *wm8988,
+			   enum snd_soc_control_type control)
 {
 	struct snd_soc_codec *codec = &wm8988->codec;
 	int ret;
@@ -854,7 +855,7 @@ static int wm8988_register(struct wm8988_priv *wm8988)
 	memcpy(codec->reg_cache, wm8988_reg,
 	       sizeof(wm8988_reg));
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		goto err;
@@ -927,14 +928,13 @@ static int wm8988_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	codec = &wm8988->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	i2c_set_clientdata(i2c, wm8988);
 	codec->control_data = i2c;
 
 	codec->dev = &i2c->dev;
 
-	return wm8988_register(wm8988);
+	return wm8988_register(wm8988, SND_SOC_I2C);
 }
 
 static int wm8988_i2c_remove(struct i2c_client *client)
@@ -1019,7 +1019,7 @@ static int __devinit wm8988_spi_probe(struct spi_device *spi)
 
 	spi->dev.driver_data = wm8988;
 
-	return wm8988_register(wm8988);
+	return wm8988_register(wm8988, SND_SOC_SPI);
 }
 
 static int __devexit wm8988_spi_remove(struct spi_device *spi)
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 4eb4333..8b12668 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -11,6 +11,7 @@
  *  option) any later version.
  */
 
+#include <linux/i2c.h>
 #include <sound/soc.h>
 
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
@@ -62,6 +63,7 @@ static struct {
  * @type: Type of cache.
  * @addr_bits: Number of bits of register address data.
  * @data_bits: Number of bits of data per register.
+ * @control: Control bus used.
  *
  * Register formats are frequently shared between many I2C and SPI
  * devices.  In order to promote code reuse the ASoC core provides
@@ -75,7 +77,8 @@ static struct {
  * volatile registers.
  */
 int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
-			       int addr_bits, int data_bits)
+			       int addr_bits, int data_bits,
+			       enum snd_soc_control_type control)
 {
 	int i;
 
@@ -100,6 +103,20 @@ int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
 	codec->write = io_types[i].write;
 	codec->read = io_types[i].read;
 
+	switch (control) {
+	case SND_SOC_CUSTOM:
+		break;
+
+	case SND_SOC_I2C:
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+		codec->hw_write = (hw_write_t)i2c_master_send;
+#endif
+		break;
+
+	case SND_SOC_SPI:
+		break;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
-- 
1.6.3.3
