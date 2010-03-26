From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] WM8750: Convert to new API
Date: Fri, 26 Mar 2010 03:23:13 +0100
Message-ID: <1269570193-8151-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 82DA4243AF
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 03:23:57 +0100 (CET)
Received: by fxm20 with SMTP id 20so12527075fxm.32
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 19:23:55 -0700 (PDT)
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
Cc: Marek Vasut <marek.vasut@gmail.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
around. Hugely inspired by WM8753 which was already converted.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/codecs/wm8750.c |  411 +++++++++++++++++++++++++--------------------
 1 files changed, 232 insertions(+), 179 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 475c67a..c7ee6d2 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -29,13 +29,6 @@
 
 #include "wm8750.h"
 
-#define WM8750_VERSION "0.12"
-
-/* codec private data */
-struct wm8750_priv {
-	unsigned int sysclk;
-};
-
 /*
  * wm8750 register cache
  * We can't read the WM8750 register space when we
@@ -55,6 +48,59 @@ static const u16 wm8750_reg[] = {
 	0x0079, 0x0079, 0x0079,          /* 40 */
 };
 
+/* codec private data */
+struct wm8750_priv {
+	unsigned int sysclk;
+	struct snd_soc_codec codec;
+	u16 reg_cache[ARRAY_SIZE(wm8750_reg)];
+};
+
+/*
+ * read wm8750 register cache
+ */
+static inline unsigned int wm8750_read_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg < 1 || reg >= (ARRAY_SIZE(wm8750_reg) + 1))
+		return -1;
+	return cache[reg - 1];
+}
+
+/*
+ * write wm8750 register cache
+ */
+static inline void wm8750_write_reg_cache(struct snd_soc_codec *codec,
+	unsigned int reg, unsigned int value)
+{
+	u16 *cache = codec->reg_cache;
+	if (reg < 1 || reg >= (ARRAY_SIZE(wm8750_reg) + 1))
+		return;
+	cache[reg - 1] = value;
+}
+
+/*
+ * write to the WM8750 register space
+ */
+static int wm8750_write(struct snd_soc_codec *codec, unsigned int reg,
+	unsigned int value)
+{
+	u8 data[2];
+
+	/* data is
+	 *   D15..D9 WM8750 register offset
+	 *   D8...D0 register data
+	 */
+	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
+	data[1] = value & 0x00ff;
+
+	wm8750_write_reg_cache(codec, reg, value);
+	if (codec->hw_write(codec->control_data, data, 2) == 2)
+		return 0;
+	else
+		return -EIO;
+}
+
 #define wm8750_reset(c)	snd_soc_write(c, WM8750_RESET, 0)
 
 /*
@@ -688,6 +734,11 @@ static int wm8750_resume(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(wm8750_reg); i++) {
 		if (i == WM8750_RESET)
 			continue;
+
+		/* No point in writing hardware default values back */
+		if (cache[i] == wm8750_reg[i])
+			continue;
+
 		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
 		data[1] = cache[i] & 0x00ff;
 		codec->hw_write(codec->control_data, data, 2);
@@ -706,31 +757,111 @@ static int wm8750_resume(struct platform_device *pdev)
 	return 0;
 }
 
+static struct snd_soc_codec *wm8750_codec;
+
+static int wm8750_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec;
+	int ret = 0;
+
+	if (!wm8750_codec) {
+		dev_err(&pdev->dev, "WM8750 codec not yet registered\n");
+		return -EINVAL;
+	}
+
+	socdev->card->codec = wm8750_codec;
+	codec = wm8750_codec;
+
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8750: failed to create pcms\n");
+		goto err;
+	}
+
+	snd_soc_add_controls(codec, wm8750_snd_controls,
+				ARRAY_SIZE(wm8750_snd_controls));
+	wm8750_add_widgets(codec);
+
+	return 0;
+
+err:
+	return ret;
+}
+
+/*
+ * This function forces any delayed work to be queued and run.
+ */
+static int run_delayed_work(struct delayed_work *dwork)
+{
+	int ret;
+
+	/* cancel any work waiting to be queued. */
+	ret = cancel_delayed_work(dwork);
+
+	/* if there was any work waiting then we run it now and
+	 * wait for it's completion */
+	if (ret) {
+		schedule_delayed_work(dwork, 0);
+		flush_scheduled_work();
+	}
+	return ret;
+}
+
+/* power down chip */
+static int wm8750_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+
+	return 0;
+}
+
+struct snd_soc_codec_device soc_codec_dev_wm8750 = {
+	.probe = 	wm8750_probe,
+	.remove = 	wm8750_remove,
+	.suspend = 	wm8750_suspend,
+	.resume =	wm8750_resume,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
+
 /*
  * initialise the WM8750 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8750_init(struct snd_soc_device *socdev,
-		       enum snd_soc_control_type control)
+static int wm8750_register(struct wm8750_priv *wm8750)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = &wm8750->codec;
 	int reg, ret = 0;
 
+	if (wm8750_codec) {
+		dev_err(codec->dev, "Multiple WM8750 devices not supported\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
 	codec->name = "WM8750";
 	codec->owner = THIS_MODULE;
+	codec->read = wm8750_read_reg_cache;
+	codec->write = wm8750_write;
+	codec->bias_level = SND_SOC_BIAS_STANDBY;
 	codec->set_bias_level = wm8750_set_bias_level;
 	codec->dai = &wm8750_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8750_reg);
-	codec->reg_cache = kmemdup(wm8750_reg, sizeof(wm8750_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	codec->private_data = wm8750;
+	codec->reg_cache_size = ARRAY_SIZE(wm8750->reg_cache) + 1;
+	codec->reg_cache = &wm8750->reg_cache;
+	codec->private_data = wm8750;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
+	memcpy(codec->reg_cache, wm8750_reg, sizeof(wm8750->reg_cache));
+	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
 
 	ret = wm8750_reset(codec);
 	if (ret < 0) {
@@ -738,13 +869,6 @@ static int wm8750_init(struct snd_soc_device *socdev,
 		goto err;
 	}
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8750: failed to create pcms\n");
-		goto err;
-	}
-
 	/* charge output caps */
 	wm8750_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 	codec->bias_level = SND_SOC_BIAS_STANDBY;
@@ -768,19 +892,39 @@ static int wm8750_init(struct snd_soc_device *socdev,
 	reg = snd_soc_read(codec, WM8750_RINVOL);
 	snd_soc_write(codec, WM8750_RINVOL, reg | 0x0100);
 
-	snd_soc_add_controls(codec, wm8750_snd_controls,
-				ARRAY_SIZE(wm8750_snd_controls));
-	wm8750_add_widgets(codec);
-	return ret;
+	wm8750_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dais(&wm8750_dai, 1);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
+		goto err_codec;
+	}
+
+	return 0;
 
+err_codec:
+	run_delayed_work(&codec->delayed_work);
+	snd_soc_unregister_codec(codec);
 err:
-	kfree(codec->reg_cache);
+	kfree(wm8750);
 	return ret;
 }
 
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8750_socdev;
+static void wm8750_unregister(struct wm8750_priv *wm8750)
+{
+	wm8750_set_bias_level(&wm8750->codec, SND_SOC_BIAS_OFF);
+	run_delayed_work(&wm8750->codec.delayed_work);
+	snd_soc_unregister_dais(&wm8750_dai, 1);
+	snd_soc_unregister_codec(&wm8750->codec);
+	kfree(wm8750);
+	wm8750_codec = NULL;
+}
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 
@@ -794,24 +938,27 @@ static struct snd_soc_device *wm8750_socdev;
 static int wm8750_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8750_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8750_priv *wm8750;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	if (wm8750 == NULL)
+		return -ENOMEM;
 
-	ret = wm8750_init(socdev, SND_SOC_I2C);
-	if (ret < 0)
-		pr_err("failed to initialise WM8750\n");
+        codec = &wm8750->codec;
+        codec->hw_write = (hw_write_t)i2c_master_send;
+        codec->control_data = i2c;
+        i2c_set_clientdata(i2c, wm8750);
 
-	return ret;
+        codec->dev = &i2c->dev;
+
+	return wm8750_register(wm8750);
 }
 
 static int wm8750_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+        struct wm8750_priv *wm8750 = i2c_get_clientdata(client);
+        wm8750_unregister(wm8750);
 	return 0;
 }
 
@@ -830,66 +977,56 @@ static struct i2c_driver wm8750_i2c_driver = {
 	.remove =   wm8750_i2c_remove,
 	.id_table = wm8750_i2c_id,
 };
+#endif
 
-static int wm8750_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8750_setup_data *setup)
+#if defined(CONFIG_SPI_MASTER)
+static int wm8750_spi_write(struct spi_device *spi, const char *data, int len)
 {
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
+	struct spi_transfer t;
+	struct spi_message m;
+	u8 msg[2];
 
-	ret = i2c_add_driver(&wm8750_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
+	if (len <= 0)
+		return 0;
 
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8750", I2C_NAME_SIZE);
+	msg[0] = data[0];
+	msg[1] = data[1];
 
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
+	spi_message_init(&m);
+	memset(&t, 0, (sizeof t));
 
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
+	t.tx_buf = &msg[0];
+	t.len = len;
 
-	return 0;
+	spi_message_add_tail(&t, &m);
+	spi_sync(spi, &m);
 
-err_driver:
-	i2c_del_driver(&wm8750_i2c_driver);
-	return -ENODEV;
+	return len;
 }
-#endif
 
-#if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8750_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = wm8750_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
+	struct snd_soc_codec *codec;
+	struct wm8750_priv *wm8750;
+
+	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
+	if (wm8750 == NULL)
+		return -ENOMEM;
 
+	codec = &wm8750->codec;
+	codec->hw_write = (hw_write_t)wm8750_spi_write;
 	codec->control_data = spi;
+	codec->dev = &spi->dev;
 
-	ret = wm8750_init(socdev, SND_SOC_SPI);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8750\n");
+	dev_set_drvdata(&spi->dev, wm8750);
 
-	return ret;
+	return wm8750_register(wm8750);
 }
 
 static int __devexit wm8750_spi_remove(struct spi_device *spi)
 {
+	struct wm8750_priv *wm8750 = dev_get_drvdata(&spi->dev);
+	wm8750_unregister(wm8750);
 	return 0;
 }
 
@@ -904,115 +1041,31 @@ static struct spi_driver wm8750_spi_driver = {
 };
 #endif
 
-static int wm8750_probe(struct platform_device *pdev)
+static int __init wm8750_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8750_setup_data *setup = socdev->codec_data;
-	struct snd_soc_codec *codec;
-	struct wm8750_priv *wm8750;
 	int ret;
-
-	pr_info("WM8750 Audio Codec %s", WM8750_VERSION);
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
-	if (wm8750 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	codec->private_data = wm8750;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8750_socdev = socdev;
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8750_work);
-
-	ret = -ENODEV;
-
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		ret = wm8750_add_i2c_device(pdev, setup);
-	}
+	ret = i2c_add_driver(&wm8750_i2c_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8750 I2C driver: %d\n", ret);
 #endif
 #if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		ret = spi_register_driver(&wm8750_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
-	}
+	ret = spi_register_driver(&wm8750_spi_driver);
+	if (ret != 0)
+		pr_err("Failed to register WM8750 SPI driver: %d\n", ret);
 #endif
-
-	if (ret != 0) {
-		kfree(codec->private_data);
-		kfree(codec);
-	}
-	return ret;
-}
-
-/*
- * This function forces any delayed work to be queued and run.
- */
-static int run_delayed_work(struct delayed_work *dwork)
-{
-	int ret;
-
-	/* cancel any work waiting to be queued. */
-	ret = cancel_delayed_work(dwork);
-
-	/* if there was any work waiting then we run it now and
-	 * wait for it's completion */
-	if (ret) {
-		schedule_delayed_work(dwork, 0);
-		flush_scheduled_work();
-	}
-	return ret;
+	return 0;
 }
+module_init(wm8750_modinit);
 
-/* power down chip */
-static int wm8750_remove(struct platform_device *pdev)
+static void __exit wm8750_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	run_delayed_work(&codec->delayed_work);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8750_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&wm8750_spi_driver);
 #endif
-	kfree(codec->private_data);
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8750 = {
-	.probe = 	wm8750_probe,
-	.remove = 	wm8750_remove,
-	.suspend = 	wm8750_suspend,
-	.resume =	wm8750_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
-
-static int __init wm8750_modinit(void)
-{
-	return snd_soc_register_dai(&wm8750_dai);
-}
-module_init(wm8750_modinit);
-
-static void __exit wm8750_exit(void)
-{
-	snd_soc_unregister_dai(&wm8750_dai);
 }
 module_exit(wm8750_exit);
 
-- 
1.7.0
