From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 09/16] ASoC: multi-component - Wolfson WM87xx
	CODECs
Date: Fri, 25 Jun 2010 18:52:56 +0100
Message-ID: <1277488383-31287-10-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AAFD103A10
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:30 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166806wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:30 -0700 (PDT)
In-Reply-To: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Moved Wolfson WM87xx CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o wm8753: dai mode configuration now modifies private data to store mode.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8711.c |  199 +++++++----------------
 sound/soc/codecs/wm8711.h |    4 +-
 sound/soc/codecs/wm8727.c |  100 ++----------
 sound/soc/codecs/wm8727.h |    4 +-
 sound/soc/codecs/wm8728.c |  292 +++++++++++-----------------------
 sound/soc/codecs/wm8728.h |   10 +-
 sound/soc/codecs/wm8731.c |  213 ++++++++-----------------
 sound/soc/codecs/wm8731.h |    4 +-
 sound/soc/codecs/wm8750.c |  269 +++++++++++---------------------
 sound/soc/codecs/wm8750.h |   10 +-
 sound/soc/codecs/wm8753.c |  389 ++++++++++++++++-----------------------------
 sound/soc/codecs/wm8753.h |    4 +-
 sound/soc/codecs/wm8776.c |  231 +++++++--------------------
 sound/soc/codecs/wm8776.h |    4 +-
 14 files changed, 532 insertions(+), 1201 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index effb14e..d903608 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -31,11 +31,10 @@
 
 #include "wm8711.h"
 
-static struct snd_soc_codec *wm8711_codec;
-
 /* codec private data */
 struct wm8711_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type bus_type;
+	void *control_data;
 	u16 reg_cache[WM8711_CACHEREGNUM];
 	unsigned int sysclk;
 };
@@ -163,7 +162,7 @@ static int wm8711_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
+	struct wm8711_priv *wm8711 =  snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8711_IFACE) & 0xfffc;
 	int i = get_coeff(wm8711->sysclk, params_rate(params));
 	u16 srate = (coeff_div[i].sr << 2) |
@@ -227,7 +226,7 @@ static int wm8711_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
+	struct wm8711_priv *wm8711 =  snd_soc_codec_get_drvdata(codec);
 
 	switch (freq) {
 	case 11289600:
@@ -338,7 +337,7 @@ static struct snd_soc_dai_ops wm8711_ops = {
 	.set_fmt = wm8711_set_dai_fmt,
 };
 
-struct snd_soc_dai wm8711_dai = {
+struct snd_soc_dai_driver wm8711_dai = {
 	.name = "WM8711",
 	.playback = {
 		.stream_name = "Playback",
@@ -351,20 +350,15 @@ struct snd_soc_dai wm8711_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8711_dai);
 
-static int wm8711_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8711_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	snd_soc_write(codec, WM8711_ACTIVE, 0x0);
 	wm8711_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8711_resume(struct platform_device *pdev)
+static int wm8711_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -380,163 +374,86 @@ static int wm8711_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8711_probe(struct platform_device *pdev)
+static int wm8711_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
+	struct wm8711_priv *wm8711 = snd_soc_codec_get_drvdata(codec);
+	int ret, reg;
 
-	if (wm8711_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
+	codec->control_data = wm8711->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8711->bus_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm8711_codec;
-	codec = wm8711_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = wm8711_reset(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
 	}
 
+	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* Latch the update bits */
+	reg = snd_soc_read(codec, WM8711_LOUT1V);
+	snd_soc_write(codec, WM8711_LOUT1V, reg | 0x0100);
+	reg = snd_soc_read(codec, WM8711_ROUT1V);
+	snd_soc_write(codec, WM8711_ROUT1V, reg | 0x0100);
+
 	snd_soc_add_controls(codec, wm8711_snd_controls,
 			     ARRAY_SIZE(wm8711_snd_controls));
 	wm8711_add_widgets(codec);
 
 	return ret;
 
-pcm_err:
-	return ret;
 }
 
 /* power down chip */
-static int wm8711_remove(struct platform_device *pdev)
+static int wm8711_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	wm8711_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm8711 = {
+struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
+	.name = "WM8711",
+	.owner = THIS_MODULE,
 	.probe = 	wm8711_probe,
 	.remove = 	wm8711_remove,
 	.suspend = 	wm8711_suspend,
 	.resume =	wm8711_resume,
+	.set_bias_level = wm8711_set_bias_level,
+	.reg_cache_size = sizeof(wm8711_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8711_reg,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8711);
 
-static int wm8711_register(struct wm8711_priv *wm8711,
-			   enum snd_soc_control_type control)
-{
-	int ret;
-	struct snd_soc_codec *codec = &wm8711->codec;
-	u16 reg;
-
-	if (wm8711_codec) {
-		dev_err(codec->dev, "Another WM8711 is registered\n");
-		return -EINVAL;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8711);
-	codec->name = "WM8711";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8711_set_bias_level;
-	codec->dai = &wm8711_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8711_CACHEREGNUM;
-	codec->reg_cache = &wm8711->reg_cache;
-
-	memcpy(codec->reg_cache, wm8711_reg, sizeof(wm8711_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
-	ret = wm8711_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
-	}
-
-	wm8711_dai.dev = codec->dev;
-
-	wm8711_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Latch the update bits */
-	reg = snd_soc_read(codec, WM8711_LOUT1V);
-	snd_soc_write(codec, WM8711_LOUT1V, reg | 0x0100);
-	reg = snd_soc_read(codec, WM8711_ROUT1V);
-	snd_soc_write(codec, WM8711_ROUT1V, reg | 0x0100);
-
-	wm8711_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8711_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8711);
-	return ret;
-}
-
-static void wm8711_unregister(struct wm8711_priv *wm8711)
-{
-	wm8711_set_bias_level(&wm8711->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8711_dai);
-	snd_soc_unregister_codec(&wm8711->codec);
-	kfree(wm8711);
-	wm8711_codec = NULL;
-}
-
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8711_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_codec *codec;
 	struct wm8711_priv *wm8711;
+	int ret;
 
 	wm8711 = kzalloc(sizeof(struct wm8711_priv), GFP_KERNEL);
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8711->codec;
-	codec->control_data = spi;
-	codec->dev = &spi->dev;
-
-	dev_set_drvdata(&spi->dev, wm8711);
+	spi_set_drvdata(spi, wm8711);
+	wm8711->control_data = spi;
+	wm8711->bus_type = SND_SOC_SPI;
 
-	return wm8711_register(wm8711, SND_SOC_SPI);
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8711, &wm8711_dai, 1);
+	if (ret < 0)
+		kfree(wm8711);
+	return ret;
 }
 
 static int __devexit wm8711_spi_remove(struct spi_device *spi)
 {
-	struct wm8711_priv *wm8711 = dev_get_drvdata(&spi->dev);
-
-	wm8711_unregister(wm8711);
-
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -552,31 +469,31 @@ static struct spi_driver wm8711_spi_driver = {
 #endif /* CONFIG_SPI_MASTER */
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static __devinit int wm8711_i2c_probe(struct i2c_client *i2c,
+static __devinit int wm8711_i2c_probe(struct i2c_client *client,
 				      const struct i2c_device_id *id)
 {
 	struct wm8711_priv *wm8711;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8711 = kzalloc(sizeof(struct wm8711_priv), GFP_KERNEL);
 	if (wm8711 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8711->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
-	i2c_set_clientdata(i2c, wm8711);
-	codec->control_data = i2c;
+	i2c_set_clientdata(client, wm8711);
+	wm8711->control_data = client;
+	wm8711->bus_type = SND_SOC_I2C;
 
-	codec->dev = &i2c->dev;
-
-	return wm8711_register(wm8711, SND_SOC_I2C);
+	ret =  snd_soc_register_codec(&client->dev, client->addr,
+			&soc_codec_dev_wm8711, &wm8711_dai, 1);
+	if (ret < 0)
+		kfree(wm8711);
+	return ret;
 }
 
 static __devexit int wm8711_i2c_remove(struct i2c_client *client)
 {
-	struct wm8711_priv *wm8711 = i2c_get_clientdata(client);
-	wm8711_unregister(wm8711);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff --git a/sound/soc/codecs/wm8711.h b/sound/soc/codecs/wm8711.h
index 381e84a..a07b465 100644
--- a/sound/soc/codecs/wm8711.h
+++ b/sound/soc/codecs/wm8711.h
@@ -36,7 +36,7 @@ struct wm8711_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_dai wm8711_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8711;
+extern struct snd_soc_dai_driver wm8711_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8711;
 
 #endif
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 1072621..96b9094 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -33,7 +33,7 @@
 			SNDRV_PCM_RATE_192000)
 
 
-struct snd_soc_dai wm8727_dai = {
+struct snd_soc_dai_driver wm8727_dai = {
 	.name = "WM8727",
 	.playback = {
 		.stream_name = "Playback",
@@ -45,99 +45,21 @@ struct snd_soc_dai wm8727_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8727_dai);
 
-static struct snd_soc_codec *wm8727_codec;
-
-static int wm8727_soc_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	int ret = 0;
-
-	BUG_ON(!wm8727_codec);
-
-	socdev->card->codec = wm8727_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8727: failed to create pcms\n");
-		goto pcm_err;
-	}
-
-	return ret;
-
-pcm_err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
-	return ret;
-}
-
-static int wm8727_soc_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8727 = {
-	.probe = 	wm8727_soc_probe,
-	.remove = 	wm8727_soc_remove,
+struct snd_soc_codec_driver soc_codec_dev_wm8727 = {
+	.name = "WM8727",
+	.owner = THIS_MODULE,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8727);
 
-
-static __devinit int wm8727_platform_probe(struct platform_device *pdev)
+static __devinit int wm8727_probe(struct platform_device *pdev)
 {
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (wm8727_codec) {
-		dev_err(&pdev->dev, "Another WM8727 is registered\n");
-		return -EBUSY;
-	}
-
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-	wm8727_codec = codec;
-
-	platform_set_drvdata(pdev, codec);
-
-	mutex_init(&codec->mutex);
-	codec->dev = &pdev->dev;
-	codec->name = "WM8727";
-	codec->owner = THIS_MODULE;
-	codec->dai = &wm8727_dai;
-	codec->num_dai = 1;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	wm8727_dai.dev = &pdev->dev;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to register CODEC: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8727_dai);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(codec);
-	return ret;
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_wm8727, &wm8727_dai, 1);
 }
 
-static int __devexit wm8727_platform_remove(struct platform_device *pdev)
+static int __devexit wm8727_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&wm8727_dai);
-	snd_soc_unregister_codec(platform_get_drvdata(pdev));
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
@@ -147,8 +69,8 @@ static struct platform_driver wm8727_codec_driver = {
 			.owner = THIS_MODULE,
 	},
 
-	.probe = wm8727_platform_probe,
-	.remove = __devexit_p(wm8727_platform_remove),
+	.probe = wm8727_probe,
+	.remove = __devexit_p(wm8727_remove),
 };
 
 static int __init wm8727_init(void)
diff --git a/sound/soc/codecs/wm8727.h b/sound/soc/codecs/wm8727.h
index ee19aa7..21fa74b 100644
--- a/sound/soc/codecs/wm8727.h
+++ b/sound/soc/codecs/wm8727.h
@@ -15,7 +15,7 @@
 #ifndef WM8727_H_
 #define WM8727_H_
 
-extern struct snd_soc_dai wm8727_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8727;
+extern struct snd_soc_dai_driver wm8727_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8727;
 
 #endif /* WM8727_H_ */
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 34be2d2..5eff03d 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -29,8 +29,6 @@
 
 #include "wm8728.h"
 
-struct snd_soc_codec_device soc_codec_dev_wm8728;
-
 /*
  * We can't read the WM8728 register space so we cache them instead.
  * Note that the defaults here aren't the physical defaults, we latch
@@ -44,6 +42,12 @@ static const u16 wm8728_reg_defaults[] = {
 	0x100,
 };
 
+/* codec private data */
+struct wm8728_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
+};
+
 static const DECLARE_TLV_DB_SCALE(wm8728_tlv, -12750, 50, 1);
 
 static const struct snd_kcontrol_new wm8728_snd_controls[] = {
@@ -96,8 +100,7 @@ static int wm8728_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 dac = snd_soc_read(codec, WM8728_DACCTL);
 
 	dac &= ~0x18;
@@ -210,7 +213,7 @@ static struct snd_soc_dai_ops wm8728_dai_ops = {
 	.set_fmt	= wm8728_set_dai_fmt,
 };
 
-struct snd_soc_dai wm8728_dai = {
+struct snd_soc_dai_driver wm8728_dai = {
 	.name = "WM8728",
 	.playback = {
 		.stream_name = "Playback",
@@ -223,61 +226,31 @@ struct snd_soc_dai wm8728_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8728_dai);
 
-static int wm8728_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8728_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8728_resume(struct platform_device *pdev)
+static int wm8728_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8728_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
 
-/*
- * initialise the WM8728 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8728_init(struct snd_soc_device *socdev,
-		       enum snd_soc_control_type control)
+static int wm8728_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret = 0;
-
-	codec->name = "WM8728";
-	codec->owner = THIS_MODULE;
-	codec->set_bias_level = wm8728_set_bias_level;
-	codec->dai = &wm8728_dai;
-	codec->num_dai = 1;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults);
-	codec->reg_cache = kmemdup(wm8728_reg_defaults,
-				   sizeof(wm8728_reg_defaults),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	struct wm8728_priv *wm8728 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8728->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8728->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8728: failed to configure cache I/O: %d\n",
 		       ret);
-		goto err;
-	}
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8728: failed to create pcms\n");
-		goto err;
+		return ret;
 	}
 
 	/* power on device */
@@ -288,122 +261,53 @@ static int wm8728_init(struct snd_soc_device *socdev,
 	wm8728_add_widgets(codec);
 
 	return ret;
-
-err:
-	kfree(codec->reg_cache);
-	return ret;
 }
 
-static struct snd_soc_device *wm8728_socdev;
-
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8728 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-
-static int wm8728_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
-{
-	struct snd_soc_device *socdev = wm8728_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret;
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
-
-	ret = wm8728_init(socdev, SND_SOC_I2C);
-	if (ret < 0)
-		pr_err("failed to initialise WM8728\n");
-
-	return ret;
-}
-
-static int wm8728_i2c_remove(struct i2c_client *client)
+static int wm8728_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static const struct i2c_device_id wm8728_i2c_id[] = {
-	{ "wm8728", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8728_i2c_id);
-
-static struct i2c_driver wm8728_i2c_driver = {
-	.driver = {
-		.name = "WM8728 I2C Codec",
-		.owner = THIS_MODULE,
-	},
-	.probe =    wm8728_i2c_probe,
-	.remove =   wm8728_i2c_remove,
-	.id_table = wm8728_i2c_id,
+struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
+	.name = "wm8728",
+	.probe = 	wm8728_probe,
+	.remove = 	wm8728_remove,
+	.suspend = 	wm8728_suspend,
+	.resume =	wm8728_resume,
+	.owner = THIS_MODULE,
+	.set_bias_level = wm8728_set_bias_level,
+	.reg_cache_size = sizeof(wm8728_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8728_reg_defaults,
 };
-
-static int wm8728_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8728_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8728_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8728", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&wm8728_i2c_driver);
-	return -ENODEV;
-}
-#endif
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8728);
 
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8728_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = wm8728_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8728_priv *wm8728;
 	int ret;
 
-	codec->control_data = spi;
+	wm8728 = kzalloc(sizeof(struct wm8728_priv), GFP_KERNEL);
+	if (wm8728 == NULL)
+		return -ENOMEM;
 
-	ret = wm8728_init(socdev, SND_SOC_SPI);
-	if (ret < 0)
-		dev_err(&spi->dev, "failed to initialise WM8728\n");
+	wm8728->control_data = spi;
+	wm8728->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8728);
 
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8728, &wm8728_dai, 1);
+	if (ret < 0)
+		kfree(wm8728);
 	return ret;
 }
 
 static int __devexit wm8728_spi_remove(struct spi_device *spi)
 {
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -418,85 +322,81 @@ static struct spi_driver wm8728_spi_driver = {
 };
 #endif /* CONFIG_SPI_MASTER */
 
-static int wm8728_probe(struct platform_device *pdev)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8728_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8728_setup_data *setup;
-	struct snd_soc_codec *codec;
-	int ret = 0;
+	struct wm8728_priv *wm8728;
+	int ret;
 
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
+	wm8728 = kzalloc(sizeof(struct wm8728_priv), GFP_KERNEL);
+	if (wm8728 == NULL)
 		return -ENOMEM;
 
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	i2c_set_clientdata(i2c, wm8728);
+	wm8728->control_data = i2c;
+	wm8728->control_type = SND_SOC_I2C;
+
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8728, &wm8728_dai, 1);
+	if (ret < 0)
+		kfree(wm8728);
+	return ret;
+}
+
+static __devexit int wm8728_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static const struct i2c_device_id wm8728_i2c_id[] = {
+	{ "wm8728", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8728_i2c_id);
 
-	wm8728_socdev = socdev;
-	ret = -ENODEV;
+static struct i2c_driver wm8728_i2c_driver = {
+	.driver = {
+		.name = "wm8728 I2C Codec",
+		.owner = THIS_MODULE,
+	},
+	.probe =    wm8728_i2c_probe,
+	.remove =   __devexit_p(wm8728_i2c_remove),
+	.id_table = wm8728_i2c_id,
+};
+#endif
 
+static int __init wm8728_modinit(void)
+{
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		ret = wm8728_add_i2c_device(pdev, setup);
+	ret = i2c_add_driver(&wm8728_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8728 I2C driver: %d\n",
+		       ret);
 	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
-	if (setup->spi) {
-		ret = spi_register_driver(&wm8728_spi_driver);
-		if (ret != 0)
-			printk(KERN_ERR "can't add spi driver");
+	ret = spi_register_driver(&wm8728_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8728 SPI driver: %d\n",
+		       ret);
 	}
 #endif
-
-	if (ret != 0)
-		kfree(codec);
-
 	return ret;
 }
+module_init(wm8728_modinit);
 
-/* power down chip */
-static int wm8728_remove(struct platform_device *pdev)
+static void __exit wm8728_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8728_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8728_i2c_driver);
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	spi_unregister_driver(&wm8728_spi_driver);
 #endif
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8728 = {
-	.probe = 	wm8728_probe,
-	.remove = 	wm8728_remove,
-	.suspend = 	wm8728_suspend,
-	.resume =	wm8728_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8728);
-
-static int __init wm8728_modinit(void)
-{
-	return snd_soc_register_dai(&wm8728_dai);
-}
-module_init(wm8728_modinit);
-
-static void __exit wm8728_exit(void)
-{
-	snd_soc_unregister_dai(&wm8728_dai);
 }
 module_exit(wm8728_exit);
 
diff --git a/sound/soc/codecs/wm8728.h b/sound/soc/codecs/wm8728.h
index d269c13..3769a7f 100644
--- a/sound/soc/codecs/wm8728.h
+++ b/sound/soc/codecs/wm8728.h
@@ -18,13 +18,7 @@
 #define WM8728_DACCTL    0x02
 #define WM8728_IFCTL     0x03
 
-struct wm8728_setup_data {
-	int            spi;
-	int            i2c_bus;
-	unsigned short i2c_address;
-};
-
-extern struct snd_soc_dai wm8728_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8728;
+extern struct snd_soc_dai_driver wm8728_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8728;
 
 #endif
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0ab9b63..3abe6ee 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -32,9 +32,6 @@
 
 #include "wm8731.h"
 
-static struct snd_soc_codec *wm8731_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8731;
-
 #define WM8731_NUM_SUPPLIES 4
 static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 	"AVDD",
@@ -45,7 +42,8 @@ static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8731_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	struct regulator_bulk_data supplies[WM8731_NUM_SUPPLIES];
 	u16 reg_cache[WM8731_CACHEREGNUM];
 	unsigned int sysclk;
@@ -222,9 +220,7 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8731_IFACE) & 0xfff3;
 	int i = get_coeff(wm8731->sysclk, params_rate(params));
@@ -252,9 +248,7 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 static int wm8731_pcm_prepare(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	/* set active */
 	snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
@@ -265,9 +259,7 @@ static int wm8731_pcm_prepare(struct snd_pcm_substream *substream,
 static void wm8731_shutdown(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = dai->codec;
 
 	/* deactivate */
 	if (!codec->active) {
@@ -428,7 +420,7 @@ static struct snd_soc_dai_ops wm8731_dai_ops = {
 	.set_fmt	= wm8731_set_dai_fmt,
 };
 
-struct snd_soc_dai wm8731_dai = {
+struct snd_soc_dai_driver wm8731_dai = {
 	.name = "WM8731",
 	.playback = {
 		.stream_name = "Playback",
@@ -448,21 +440,15 @@ struct snd_soc_dai wm8731_dai = {
 EXPORT_SYMBOL_GPL(wm8731_dai);
 
 #ifdef CONFIG_PM
-static int wm8731_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8731_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8731_resume(struct platform_device *pdev)
+static int wm8731_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -472,88 +458,18 @@ static int wm8731_resume(struct platform_device *pdev)
 #define wm8731_resume NULL
 #endif
 
-static int wm8731_probe(struct platform_device *pdev)
+static int wm8731_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8731_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8731_codec;
-	codec = wm8731_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8731_snd_controls,
-			     ARRAY_SIZE(wm8731_snd_controls));
-	wm8731_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8731_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8731 = {
-	.probe = 	wm8731_probe,
-	.remove = 	wm8731_remove,
-	.suspend = 	wm8731_suspend,
-	.resume =	wm8731_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
-
-static int wm8731_register(struct wm8731_priv *wm8731,
-			   enum snd_soc_control_type control)
-{
-	int ret, i;
-	struct snd_soc_codec *codec = &wm8731->codec;
-
-	if (wm8731_codec) {
-		dev_err(codec->dev, "Another WM8731 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8731);
-	codec->name = "WM8731";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8731_set_bias_level;
-	codec->dai = &wm8731_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8731_CACHEREGNUM;
-	codec->reg_cache = &wm8731->reg_cache;
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, i;
 
-	memcpy(codec->reg_cache, wm8731_reg, sizeof(wm8731_reg));
+	codec->bias_level = SND_SOC_BIAS_OFF,
+	codec->control_data = wm8731->control_data;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8731->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8731->supplies); i++)
@@ -563,7 +479,7 @@ static int wm8731_register(struct wm8731_priv *wm8731,
 				 wm8731->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
@@ -579,8 +495,6 @@ static int wm8731_register(struct wm8731_priv *wm8731,
 		goto err_regulator_enable;
 	}
 
-	wm8731_dai.dev = codec->dev;
-
 	wm8731_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
@@ -592,72 +506,76 @@ static int wm8731_register(struct wm8731_priv *wm8731,
 	/* Disable bypass path by default */
 	snd_soc_update_bits(codec, WM8731_APANA, 0x4, 0);
 
-	wm8731_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_regulator_enable;
-	}
-
-	ret = snd_soc_register_dai(&wm8731_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8731_snd_controls,
+			     ARRAY_SIZE(wm8731_snd_controls));
+	wm8731_add_widgets(codec);
 
 	/* Regulators will have been enabled by bias management */
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_regulator_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 err_regulator_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-err:
+
 	kfree(wm8731);
 	return ret;
 }
 
-static void wm8731_unregister(struct wm8731_priv *wm8731)
+/* power down chip */
+static int wm8731_remove(struct snd_soc_codec *codec)
 {
-	wm8731_set_bias_level(&wm8731->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8731_dai);
-	snd_soc_unregister_codec(&wm8731->codec);
+	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
+
+	wm8731_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
 	regulator_bulk_free(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
-	kfree(wm8731);
-	wm8731_codec = NULL;
+
+	return 0;
 }
 
+struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
+	.name = "WM8731",
+	.probe = 	wm8731_probe,
+	.remove = 	wm8731_remove,
+	.suspend = 	wm8731_suspend,
+	.resume =	wm8731_resume,
+	.owner = THIS_MODULE,
+	.set_bias_level = wm8731_set_bias_level,
+	.reg_cache_size = sizeof(wm8731_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8731_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit wm8731_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_codec *codec;
 	struct wm8731_priv *wm8731;
+	int ret;
 
 	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8731->codec;
-	codec->control_data = spi;
-	codec->dev = &spi->dev;
+	wm8731->control_data = spi;
+	wm8731->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8731);
 
-	dev_set_drvdata(&spi->dev, wm8731);
-
-	return wm8731_register(wm8731, SND_SOC_SPI);
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8731, &wm8731_dai, 1);
+	if (ret < 0)
+		kfree(wm8731);
+	return ret;
 }
 
 static int __devexit wm8731_spi_remove(struct spi_device *spi)
 {
-	struct wm8731_priv *wm8731 = dev_get_drvdata(&spi->dev);
-
-	wm8731_unregister(wm8731);
-
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -677,26 +595,27 @@ static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8731_priv *wm8731;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
 	if (wm8731 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8731->codec;
-
 	i2c_set_clientdata(i2c, wm8731);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8731->control_data = i2c;
+	wm8731->control_type = SND_SOC_I2C;
 
-	return wm8731_register(wm8731, SND_SOC_I2C);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8731, &wm8731_dai, 1);
+	if (ret < 0)
+		kfree(wm8731);
+	return ret;
 }
 
 static __devexit int wm8731_i2c_remove(struct i2c_client *client)
 {
-	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
-	wm8731_unregister(wm8731);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -719,7 +638,7 @@ static struct i2c_driver wm8731_i2c_driver = {
 
 static int __init wm8731_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8731_i2c_driver);
 	if (ret != 0) {
@@ -734,7 +653,7 @@ static int __init wm8731_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8731_modinit);
 
diff --git a/sound/soc/codecs/wm8731.h b/sound/soc/codecs/wm8731.h
index cd7b806..757c8a5 100644
--- a/sound/soc/codecs/wm8731.h
+++ b/sound/soc/codecs/wm8731.h
@@ -34,7 +34,7 @@
 #define WM8731_SYSCLK	0
 #define WM8731_DAI		0
 
-extern struct snd_soc_dai wm8731_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8731;
+extern struct snd_soc_dai_driver wm8731_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8731;
 
 #endif
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 9407e19..eb10567 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -52,7 +52,8 @@ static const u16 wm8750_reg[] = {
 /* codec private data */
 struct wm8750_priv {
 	unsigned int sysclk;
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[ARRAY_SIZE(wm8750_reg)];
 };
 
@@ -560,8 +561,7 @@ static int wm8750_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8750_priv *wm8750 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8750_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8750_SRATE) & 0x1c0;
@@ -649,7 +649,7 @@ static struct snd_soc_dai_ops wm8750_dai_ops = {
 	.set_sysclk	= wm8750_set_dai_sysclk,
 };
 
-struct snd_soc_dai wm8750_dai = {
+struct snd_soc_dai_driver wm8750_dai = {
 	.name = "WM8750",
 	.playback = {
 		.stream_name = "Playback",
@@ -667,19 +667,14 @@ struct snd_soc_dai wm8750_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8750_dai);
 
-static int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8750_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8750_resume(struct platform_device *pdev)
+static int wm8750_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -698,100 +693,22 @@ static int wm8750_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static struct snd_soc_codec *wm8750_codec;
-
-static int wm8750_probe(struct platform_device *pdev)
+static int wm8750_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (!wm8750_codec) {
-		dev_err(&pdev->dev, "WM8750 codec not yet registered\n");
-		return -EINVAL;
-	}
-
-	socdev->card->codec = wm8750_codec;
-	codec = wm8750_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8750: failed to create pcms\n");
-		goto err;
-	}
-
-	snd_soc_add_controls(codec, wm8750_snd_controls,
-				ARRAY_SIZE(wm8750_snd_controls));
-	wm8750_add_widgets(codec);
-
-	return 0;
-
-err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8750_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8750 = {
-	.probe		= wm8750_probe,
-	.remove		= wm8750_remove,
-	.suspend	= wm8750_suspend,
-	.resume		= wm8750_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
-
-/*
- * initialise the WM8750 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8750_register(struct wm8750_priv *wm8750,
-			enum snd_soc_control_type control)
-{
-	struct snd_soc_codec *codec = &wm8750->codec;
-	int reg, ret = 0;
-
-	if (wm8750_codec) {
-		dev_err(codec->dev, "Multiple WM8750 devices not supported\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "WM8750";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_STANDBY;
-	codec->set_bias_level = wm8750_set_bias_level;
-	codec->dai = &wm8750_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8750->reg_cache) + 1;
-	codec->reg_cache = &wm8750->reg_cache;
-	snd_soc_codec_set_drvdata(codec, wm8750);
-
-	memcpy(codec->reg_cache, wm8750_reg, sizeof(wm8750->reg_cache));
+	struct wm8750_priv *wm8750 = snd_soc_codec_get_drvdata(codec);
+	int reg, ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8750->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8750->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = wm8750_reset(codec);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8750: failed to reset: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	/* charge output caps */
@@ -815,141 +732,135 @@ static int wm8750_register(struct wm8750_priv *wm8750,
 	reg = snd_soc_read(codec, WM8750_RINVOL);
 	snd_soc_write(codec, WM8750_RINVOL, reg | 0x0100);
 
-	wm8750_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dais(&wm8750_dai, 1);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		goto err_codec;
-	}
-
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8750);
+	snd_soc_add_controls(codec, wm8750_snd_controls,
+				ARRAY_SIZE(wm8750_snd_controls));
+	wm8750_add_widgets(codec);
 	return ret;
 }
 
-static void wm8750_unregister(struct wm8750_priv *wm8750)
+static int wm8750_remove(struct snd_soc_codec *codec)
 {
-	wm8750_set_bias_level(&wm8750->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dais(&wm8750_dai, 1);
-	snd_soc_unregister_codec(&wm8750->codec);
-	kfree(wm8750);
-	wm8750_codec = NULL;
+	wm8750_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM8750 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
+struct snd_soc_codec_driver soc_codec_dev_wm8750 = {
+	.name = "wm8750",
+	.probe = 	wm8750_probe,
+	.remove = 	wm8750_remove,
+	.suspend = 	wm8750_suspend,
+	.resume =	wm8750_resume,
+	.owner = THIS_MODULE,
+	.set_bias_level = wm8750_set_bias_level,
+	.reg_cache_size = sizeof(wm8750_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8750_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8750);
 
-static int wm8750_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8750_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_codec *codec;
 	struct wm8750_priv *wm8750;
+	int ret;
 
 	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8750->codec;
-	codec->control_data = i2c;
-	i2c_set_clientdata(i2c, wm8750);
-
-	codec->dev = &i2c->dev;
+	wm8750->control_data = spi;
+	wm8750->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8750);
 
-	return wm8750_register(wm8750, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8750, &wm8750_dai, 1);
+	if (ret < 0)
+		kfree(wm8750);
+	return ret;
 }
 
-static int wm8750_i2c_remove(struct i2c_client *client)
+static int __devexit wm8750_spi_remove(struct spi_device *spi)
 {
-	struct wm8750_priv *wm8750 = i2c_get_clientdata(client);
-	wm8750_unregister(wm8750);
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
-static const struct i2c_device_id wm8750_i2c_id[] = {
-	{ "wm8750", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8750_i2c_id);
-
-static struct i2c_driver wm8750_i2c_driver = {
+static struct spi_driver wm8750_spi_driver = {
 	.driver = {
-		.name = "WM8750 I2C Codec",
-		.owner = THIS_MODULE,
+		.name	= "wm8750",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
 	},
-	.probe =    wm8750_i2c_probe,
-	.remove =   wm8750_i2c_remove,
-	.id_table = wm8750_i2c_id,
+	.probe		= wm8750_spi_probe,
+	.remove		= __devexit_p(wm8750_spi_remove),
 };
-#endif
+#endif /* CONFIG_SPI_MASTER */
 
-#if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8750_spi_probe(struct spi_device *spi)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8750_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec;
 	struct wm8750_priv *wm8750;
+	int ret;
 
 	wm8750 = kzalloc(sizeof(struct wm8750_priv), GFP_KERNEL);
 	if (wm8750 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8750->codec;
-	codec->control_data = spi;
-	codec->dev = &spi->dev;
-
-	dev_set_drvdata(&spi->dev, wm8750);
+	i2c_set_clientdata(i2c, wm8750);
+	wm8750->control_data = i2c;
+	wm8750->control_type = SND_SOC_I2C;
 
-	return wm8750_register(wm8750, SND_SOC_SPI);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8750, &wm8750_dai, 1);
+	if (ret < 0)
+		kfree(wm8750);
+	return ret;
 }
 
-static int __devexit wm8750_spi_remove(struct spi_device *spi)
+static __devexit int wm8750_i2c_remove(struct i2c_client *client)
 {
-	struct wm8750_priv *wm8750 = dev_get_drvdata(&spi->dev);
-	wm8750_unregister(wm8750);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-static struct spi_driver wm8750_spi_driver = {
+static const struct i2c_device_id wm8750_i2c_id[] = {
+	{ "wm8750", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8750_i2c_id);
+
+static struct i2c_driver wm8750_i2c_driver = {
 	.driver = {
-		.name	= "wm8750",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
+		.name = "wm8750 I2C Codec",
+		.owner = THIS_MODULE,
 	},
-	.probe		= wm8750_spi_probe,
-	.remove		= __devexit_p(wm8750_spi_remove),
+	.probe =    wm8750_i2c_probe,
+	.remove =   __devexit_p(wm8750_i2c_remove),
+	.id_table = wm8750_i2c_id,
 };
 #endif
 
 static int __init wm8750_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8750_i2c_driver);
-	if (ret != 0)
-		pr_err("Failed to register WM8750 I2C driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8750 I2C driver: %d\n",
+		       ret);
+	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8750_spi_driver);
-	if (ret != 0)
-		pr_err("Failed to register WM8750 SPI driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8750 SPI driver: %d\n",
+		       ret);
+	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8750_modinit);
 
diff --git a/sound/soc/codecs/wm8750.h b/sound/soc/codecs/wm8750.h
index 1dc100e..e90891b 100644
--- a/sound/soc/codecs/wm8750.h
+++ b/sound/soc/codecs/wm8750.h
@@ -57,13 +57,7 @@
 
 #define WM8750_SYSCLK	0
 
-struct wm8750_setup_data {
-	int spi;
-	int i2c_bus;
-	unsigned short i2c_address;
-};
-
-extern struct snd_soc_dai wm8750_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8750;
+extern struct snd_soc_dai_driver wm8750_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8750;
 
 #endif
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index b59f349..bd0676f 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -57,7 +57,7 @@ module_param(caps_charge, int, 0);
 MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
 
 static void wm8753_set_dai_mode(struct snd_soc_codec *codec,
-	unsigned int mode);
+		struct snd_soc_dai *dai, unsigned int hifi);
 
 /*
  * wm8753 register cache
@@ -85,10 +85,12 @@ static const u16 wm8753_reg[] = {
 
 /* codec private data */
 struct wm8753_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int sysclk;
 	unsigned int pcmclk;
-	struct snd_soc_codec codec;
 	u16 reg_cache[ARRAY_SIZE(wm8753_reg)];
+	int dai_func;
 };
 
 /*
@@ -228,6 +230,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
 	int mode = wm8753_read_reg_cache(codec, WM8753_IOCTL);
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
 	if (((mode & 0xc) >> 2) == ucontrol->value.integer.value[0])
 		return 0;
@@ -235,8 +238,7 @@ static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	mode &= 0xfff3;
 	mode |= (ucontrol->value.integer.value[0] << 2);
 
-	wm8753_write(codec, WM8753_IOCTL, mode);
-	wm8753_set_dai_mode(codec, ucontrol->value.integer.value[0]);
+	wm8753->dai_func =  ucontrol->value.integer.value[0];
 	return 1;
 }
 
@@ -904,6 +906,13 @@ static int wm8753_vdac_adc_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8753_pcm_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	wm8753_set_dai_mode(dai->codec, dai, 0);
+	return 0;
+}
+
 /*
  * Set PCM DAI bit size and sample rate.
  */
@@ -912,8 +921,7 @@ static int wm8753_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 voice = wm8753_read_reg_cache(codec, WM8753_PCM) & 0x01f3;
 	u16 srate = wm8753_read_reg_cache(codec, WM8753_SRATE1) & 0x017f;
@@ -1138,6 +1146,13 @@ static int wm8753_i2s_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8753_i2s_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	wm8753_set_dai_mode(dai->codec, dai, 1);
+	return 0;
+}
+
 /*
  * Set PCM DAI bit size and sample rate.
  */
@@ -1146,8 +1161,7 @@ static int wm8753_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 srate = wm8753_read_reg_cache(codec, WM8753_SRATE1) & 0x01c0;
 	u16 hifi = wm8753_read_reg_cache(codec, WM8753_HIFI) & 0x01f3;
@@ -1240,12 +1254,12 @@ static int wm8753_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	u16 mute_reg = wm8753_read_reg_cache(codec, WM8753_DAC) & 0xfff7;
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
 	/* the digital mute covers the HiFi and Voice DAC's on the WM8753.
 	 * make sure we check if they are not both active when we mute */
-	if (mute && dai->id == 1) {
-		if (!wm8753_dai[WM8753_DAI_VOICE].playback.active ||
-			!wm8753_dai[WM8753_DAI_HIFI].playback.active)
+	if (mute && wm8753->dai_func == 1) {
+		if (!codec->active)
 			wm8753_write(codec, WM8753_DAC, mute_reg | 0x8);
 	} else {
 		if (mute)
@@ -1303,6 +1317,7 @@ static int wm8753_set_bias_level(struct snd_soc_codec *codec,
  * 4. Voice disabled - HIFI over HIFI, uses voice DAI LRC for capture
  */
 static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode1 = {
+	.startup = wm8753_i2s_startup,
 	.hw_params	= wm8753_i2s_hw_params,
 	.digital_mute	= wm8753_mute,
 	.set_fmt	= wm8753_mode1h_set_dai_fmt,
@@ -1312,6 +1327,7 @@ static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode1 = {
 };
 
 static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode1 = {
+	.startup = wm8753_pcm_startup,
 	.hw_params	= wm8753_pcm_hw_params,
 	.digital_mute	= wm8753_mute,
 	.set_fmt	= wm8753_mode1v_set_dai_fmt,
@@ -1321,6 +1337,7 @@ static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode1 = {
 };
 
 static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode2 = {
+	.startup = wm8753_pcm_startup,
 	.hw_params	= wm8753_pcm_hw_params,
 	.digital_mute	= wm8753_mute,
 	.set_fmt	= wm8753_mode2_set_dai_fmt,
@@ -1330,6 +1347,7 @@ static struct snd_soc_dai_ops wm8753_dai_ops_voice_mode2 = {
 };
 
 static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode3	= {
+	.startup = wm8753_i2s_startup,
 	.hw_params	= wm8753_i2s_hw_params,
 	.digital_mute	= wm8753_mute,
 	.set_fmt	= wm8753_mode3_4_set_dai_fmt,
@@ -1339,6 +1357,7 @@ static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode3	= {
 };
 
 static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode4	= {
+	.startup = wm8753_i2s_startup,
 	.hw_params	= wm8753_i2s_hw_params,
 	.digital_mute	= wm8753_mute,
 	.set_fmt	= wm8753_mode3_4_set_dai_fmt,
@@ -1347,10 +1366,9 @@ static struct snd_soc_dai_ops wm8753_dai_ops_hifi_mode4	= {
 	.set_sysclk	= wm8753_set_dai_sysclk,
 };
 
-static const struct snd_soc_dai wm8753_all_dai[] = {
+static struct snd_soc_dai_driver wm8753_all_dai[] = {
 /* DAI HiFi mode 1 */
 {	.name = "WM8753 HiFi",
-	.id = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
@@ -1367,7 +1385,6 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 },
 /* DAI Voice mode 1 */
 {	.name = "WM8753 Voice",
-	.id = 1,
 	.playback = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
@@ -1384,11 +1401,9 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 },
 /* DAI HiFi mode 2 - dummy */
 {	.name = "WM8753 HiFi",
-	.id = 2,
 },
 /* DAI Voice mode 2 */
 {	.name = "WM8753 Voice",
-	.id = 2,
 	.playback = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
@@ -1405,7 +1420,6 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 },
 /* DAI HiFi mode 3 */
 {	.name = "WM8753 HiFi",
-	.id = 3,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
@@ -1422,11 +1436,9 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 },
 /* DAI Voice mode 3 - dummy */
 {	.name = "WM8753 Voice",
-	.id = 3,
 },
 /* DAI HiFi mode 4 */
 {	.name = "WM8753 HiFi",
-	.id = 4,
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
@@ -1443,11 +1455,10 @@ static const struct snd_soc_dai wm8753_all_dai[] = {
 },
 /* DAI Voice mode 4 - dummy */
 {	.name = "WM8753 Voice",
-	.id = 4,
 },
 };
 
-struct snd_soc_dai wm8753_dai[] = {
+struct snd_soc_dai_driver wm8753_dai[] = {
 	{
 		.name = "WM8753 DAI 0",
 	},
@@ -1457,43 +1468,18 @@ struct snd_soc_dai wm8753_dai[] = {
 };
 EXPORT_SYMBOL_GPL(wm8753_dai);
 
-static void wm8753_set_dai_mode(struct snd_soc_codec *codec, unsigned int mode)
+static void wm8753_set_dai_mode(struct snd_soc_codec *codec,
+		struct snd_soc_dai *dai, unsigned int hifi)
 {
-	if (mode < 4) {
-		int playback_active, capture_active, codec_active, pop_wait;
-		void *private_data;
-		struct list_head list;
-
-		playback_active = wm8753_dai[0].playback.active;
-		capture_active = wm8753_dai[0].capture.active;
-		codec_active = wm8753_dai[0].active;
-		private_data = wm8753_dai[0].private_data;
-		pop_wait = wm8753_dai[0].pop_wait;
-		list = wm8753_dai[0].list;
-		wm8753_dai[0] = wm8753_all_dai[mode << 1];
-		wm8753_dai[0].playback.active = playback_active;
-		wm8753_dai[0].capture.active = capture_active;
-		wm8753_dai[0].active = codec_active;
-		wm8753_dai[0].private_data = private_data;
-		wm8753_dai[0].pop_wait = pop_wait;
-		wm8753_dai[0].list = list;
-
-		playback_active = wm8753_dai[1].playback.active;
-		capture_active = wm8753_dai[1].capture.active;
-		codec_active = wm8753_dai[1].active;
-		private_data = wm8753_dai[1].private_data;
-		pop_wait = wm8753_dai[1].pop_wait;
-		list = wm8753_dai[1].list;
-		wm8753_dai[1] = wm8753_all_dai[(mode << 1) + 1];
-		wm8753_dai[1].playback.active = playback_active;
-		wm8753_dai[1].capture.active = capture_active;
-		wm8753_dai[1].active = codec_active;
-		wm8753_dai[1].private_data = private_data;
-		wm8753_dai[1].pop_wait = pop_wait;
-		wm8753_dai[1].list = list;
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+
+	if (wm8753->dai_func < 4) {
+		if (hifi)
+			dai->driver = &wm8753_all_dai[wm8753->dai_func << 1];
+		else
+			dai->driver = &wm8753_all_dai[(wm8753->dai_func << 1) + 1];
 	}
-	wm8753_dai[0].codec = codec;
-	wm8753_dai[1].codec = codec;
+	wm8753_write(codec, WM8753_IOCTL, wm8753->dai_func);
 }
 
 static void wm8753_work(struct work_struct *work)
@@ -1503,19 +1489,14 @@ static void wm8753_work(struct work_struct *work)
 	wm8753_set_bias_level(codec, codec->bias_level);
 }
 
-static int wm8753_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8753_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8753_resume(struct platform_device *pdev)
+static int wm8753_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -1547,41 +1528,6 @@ static int wm8753_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static struct snd_soc_codec *wm8753_codec;
-
-static int wm8753_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (!wm8753_codec) {
-		dev_err(&pdev->dev, "WM8753 codec not yet registered\n");
-		return -EINVAL;
-	}
-
-	socdev->card->codec = wm8753_codec;
-	codec = wm8753_codec;
-
-	wm8753_set_dai_mode(codec, 0);
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8753: failed to create pcms\n");
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8753_snd_controls,
-			     ARRAY_SIZE(wm8753_snd_controls));
-	wm8753_add_widgets(codec);
-
-	return 0;
-
-pcm_err:
-	return ret;
-}
-
 /*
  * This function forces any delayed work to be queued and run.
  */
@@ -1601,62 +1547,30 @@ static int run_delayed_work(struct delayed_work *dwork)
 	return ret;
 }
 
-/* power down chip */
-static int wm8753_remove(struct platform_device *pdev)
+static int wm8753_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8753 = {
-	.probe = 	wm8753_probe,
-	.remove = 	wm8753_remove,
-	.suspend = 	wm8753_suspend,
-	.resume =	wm8753_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8753);
+	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, reg;
 
-static int wm8753_register(struct wm8753_priv *wm8753)
-{
-	int ret, i;
-	struct snd_soc_codec *codec = &wm8753->codec;
-	u16 reg;
+	codec->bias_level = SND_SOC_BIAS_OFF,
+	codec->control_data = wm8753->control_data;
+	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
 
-	if (wm8753_codec) {
-		dev_err(codec->dev, "Multiple WM8753 devices not supported\n");
-		ret = -EINVAL;
-		goto err;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8753->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "WM8753";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8753_read_reg_cache;
-	codec->write = wm8753_write;
-	codec->bias_level = SND_SOC_BIAS_STANDBY;
-	codec->set_bias_level = wm8753_set_bias_level;
-	codec->dai = wm8753_dai;
-	codec->num_dai = 2;
-	codec->reg_cache_size = ARRAY_SIZE(wm8753->reg_cache) + 1;
-	codec->reg_cache = &wm8753->reg_cache;
-	snd_soc_codec_set_drvdata(codec, wm8753);
-
-	memcpy(codec->reg_cache, wm8753_reg, sizeof(wm8753->reg_cache));
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8753_work);
-
 	ret = wm8753_reset(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
+		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		return ret;
 	}
 
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8753->dai_func = 0;
+
 	/* charge output caps */
 	wm8753_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 	schedule_delayed_work(&codec->delayed_work,
@@ -1684,165 +1598,142 @@ static int wm8753_register(struct wm8753_priv *wm8753)
 	reg = wm8753_read_reg_cache(codec, WM8753_RINVOL);
 	wm8753_write(codec, WM8753_RINVOL, reg | 0x0100);
 
-	wm8753_codec = codec;
-
-	for (i = 0; i < ARRAY_SIZE(wm8753_dai); i++)
-		wm8753_dai[i].dev = codec->dev;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dais(&wm8753_dai[0], ARRAY_SIZE(wm8753_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8753_snd_controls,
+			     ARRAY_SIZE(wm8753_snd_controls));
+	wm8753_add_widgets(codec);
 
 	return 0;
 
-err_codec:
 	run_delayed_work(&codec->delayed_work);
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8753);
 	return ret;
 }
 
-static void wm8753_unregister(struct wm8753_priv *wm8753)
+/* power down chip */
+static int wm8753_remove(struct snd_soc_codec *codec)
 {
-	wm8753_set_bias_level(&wm8753->codec, SND_SOC_BIAS_OFF);
-	run_delayed_work(&wm8753->codec.delayed_work);
-	snd_soc_unregister_dais(&wm8753_dai[0], ARRAY_SIZE(wm8753_dai));
-	snd_soc_unregister_codec(&wm8753->codec);
-	kfree(wm8753);
-	wm8753_codec = NULL;
+	run_delayed_work(&codec->delayed_work);
+	wm8753_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	return 0;
 }
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+struct snd_soc_codec_driver soc_codec_dev_wm8753 = {
+	.name = "wm8753",
+	.probe = 	wm8753_probe,
+	.remove = 	wm8753_remove,
+	.suspend = 	wm8753_suspend,
+	.resume =	wm8753_resume,
+	.owner = THIS_MODULE,
+	.set_bias_level = wm8753_set_bias_level,
+	.reg_cache_size = sizeof(wm8753_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8753_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8753);
 
-static int wm8753_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8753_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_codec *codec;
 	struct wm8753_priv *wm8753;
+	int ret;
 
 	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
-        codec = &wm8753->codec;
-        codec->hw_write = (hw_write_t)i2c_master_send;
-        codec->control_data = i2c;
-        i2c_set_clientdata(i2c, wm8753);
-
-        codec->dev = &i2c->dev;
+	wm8753->control_data = spi;
+	wm8753->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8753);
 
-	return wm8753_register(wm8753);
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8753, wm8753_dai, ARRAY_SIZE(wm8753_dai));
+	if (ret < 0)
+		kfree(wm8753);
+	return ret;
 }
 
-static int wm8753_i2c_remove(struct i2c_client *client)
+static int __devexit wm8753_spi_remove(struct spi_device *spi)
 {
-        struct wm8753_priv *wm8753 = i2c_get_clientdata(client);
-        wm8753_unregister(wm8753);
-        return 0;
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
+	return 0;
 }
 
-static const struct i2c_device_id wm8753_i2c_id[] = {
-	{ "wm8753", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
-
-static struct i2c_driver wm8753_i2c_driver = {
+static struct spi_driver wm8753_spi_driver = {
 	.driver = {
-		.name = "wm8753",
-		.owner = THIS_MODULE,
+		.name	= "wm8753",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
 	},
-	.probe =    wm8753_i2c_probe,
-	.remove =   wm8753_i2c_remove,
-	.id_table = wm8753_i2c_id,
+	.probe		= wm8753_spi_probe,
+	.remove		= __devexit_p(wm8753_spi_remove),
 };
-#endif
-
-#if defined(CONFIG_SPI_MASTER)
-static int wm8753_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
+#endif /* CONFIG_SPI_MASTER */
 
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
-
-static int __devinit wm8753_spi_probe(struct spi_device *spi)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8753_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec;
 	struct wm8753_priv *wm8753;
+	int ret;
 
 	wm8753 = kzalloc(sizeof(struct wm8753_priv), GFP_KERNEL);
 	if (wm8753 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8753->codec;
-	codec->control_data = spi;
-	codec->hw_write = (hw_write_t)wm8753_spi_write;
-	codec->dev = &spi->dev;
+	i2c_set_clientdata(i2c, wm8753);
+	wm8753->control_data = i2c;
+	wm8753->control_type = SND_SOC_I2C;
 
-	dev_set_drvdata(&spi->dev, wm8753);
-
-	return wm8753_register(wm8753);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8753, wm8753_dai, ARRAY_SIZE(wm8753_dai));
+	if (ret < 0)
+		kfree(wm8753);
+	return ret;
 }
 
-static int __devexit wm8753_spi_remove(struct spi_device *spi)
+static __devexit int wm8753_i2c_remove(struct i2c_client *client)
 {
-	struct wm8753_priv *wm8753 = dev_get_drvdata(&spi->dev);
-	wm8753_unregister(wm8753);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-static struct spi_driver wm8753_spi_driver = {
+static const struct i2c_device_id wm8753_i2c_id[] = {
+	{ "wm8753", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
+
+static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
-		.name	= "wm8753",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
+		.name = "wm8753 I2C Codec",
+		.owner = THIS_MODULE,
 	},
-	.probe		= wm8753_spi_probe,
-	.remove		= __devexit_p(wm8753_spi_remove),
+	.probe =    wm8753_i2c_probe,
+	.remove =   __devexit_p(wm8753_i2c_remove),
+	.id_table = wm8753_i2c_id,
 };
 #endif
 
 static int __init wm8753_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8753_i2c_driver);
-	if (ret != 0)
-		pr_err("Failed to register WM8753 I2C driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8753 I2C driver: %d\n",
+		       ret);
+	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8753_spi_driver);
-	if (ret != 0)
-		pr_err("Failed to register WM8753 SPI driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8753 SPI driver: %d\n",
+		       ret);
+	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8753_modinit);
 
diff --git a/sound/soc/codecs/wm8753.h b/sound/soc/codecs/wm8753.h
index 57b2ba2..27a9336 100644
--- a/sound/soc/codecs/wm8753.h
+++ b/sound/soc/codecs/wm8753.h
@@ -115,7 +115,7 @@
 #define WM8753_DAI_HIFI		0
 #define WM8753_DAI_VOICE		1
 
-extern struct snd_soc_dai wm8753_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_wm8753;
+extern struct snd_soc_dai_driver wm8753_dai[2];
+extern struct snd_soc_codec_driver soc_codec_dev_wm8753;
 
 #endif
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 7e4a627..a0ab570 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -31,20 +31,14 @@
 
 #include "wm8776.h"
 
-static struct snd_soc_codec *wm8776_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8776;
-
 /* codec private data */
 struct wm8776_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[WM8776_CACHEREGNUM];
 	int sysclk[2];
 };
 
-#ifdef CONFIG_SPI_MASTER
-static int wm8776_spi_write(struct spi_device *spi, const char *data, int len);
-#endif
-
 static const u16 wm8776_reg[WM8776_CACHEREGNUM] = {
 	0x79, 0x79, 0x79, 0xff, 0xff,  /* 4 */
 	0xff, 0x00, 0x90, 0x00, 0x00,  /* 9 */
@@ -358,10 +352,9 @@ static struct snd_soc_dai_ops wm8776_adc_ops = {
 	.set_sysclk     = wm8776_set_sysclk,
 };
 
-struct snd_soc_dai wm8776_dai[] = {
+struct snd_soc_dai_driver wm8776_dai[] = {
 	{
 		.name = "WM8776 Playback",
-		.id = WM8776_DAI_DAC,
 		.playback = {
 			.stream_name = "Playback",
 			.channels_min = 2,
@@ -373,7 +366,6 @@ struct snd_soc_dai wm8776_dai[] = {
 	},
 	{
 		.name = "WM8776 Capture",
-		.id = WM8776_DAI_ADC,
 		.capture = {
 			.stream_name = "Capture",
 			.channels_min = 2,
@@ -387,20 +379,15 @@ struct snd_soc_dai wm8776_dai[] = {
 EXPORT_SYMBOL_GPL(wm8776_dai);
 
 #ifdef CONFIG_PM
-static int wm8776_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8776_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8776_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8776_resume(struct platform_device *pdev)
+static int wm8776_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -423,27 +410,31 @@ static int wm8776_resume(struct platform_device *pdev)
 #define wm8776_resume NULL
 #endif
 
-static int wm8776_probe(struct platform_device *pdev)
+static int wm8776_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
+	struct wm8776_priv *wm8776 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (wm8776_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
+	codec->control_data = wm8776->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8776->control_type);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm8776_codec;
-	codec = wm8776_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = wm8776_reset(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		return ret;
 	}
 
+	wm8776_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* Latch the update bits; right channel only since we always
+	 * update both. */
+	snd_soc_update_bits(codec, WM8776_HPRVOL, 0x100, 0x100);
+	snd_soc_update_bits(codec, WM8776_DACRVOL, 0x100, 0x100);
+
 	snd_soc_add_controls(codec, wm8776_snd_controls,
 			     ARRAY_SIZE(wm8776_snd_controls));
 	snd_soc_dapm_new_controls(codec, wm8776_dapm_widgets,
@@ -451,162 +442,54 @@ static int wm8776_probe(struct platform_device *pdev)
 	snd_soc_dapm_add_routes(codec, routes, ARRAY_SIZE(routes));
 
 	return ret;
-
-pcm_err:
-	return ret;
 }
 
 /* power down chip */
-static int wm8776_remove(struct platform_device *pdev)
+static int wm8776_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	wm8776_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm8776 = {
+struct snd_soc_codec_driver soc_codec_dev_wm8776 = {
+	.name = "wm8776",
 	.probe = 	wm8776_probe,
 	.remove = 	wm8776_remove,
 	.suspend = 	wm8776_suspend,
 	.resume =	wm8776_resume,
+	.owner = THIS_MODULE,
+	.set_bias_level = wm8776_set_bias_level,
+	.reg_cache_size = sizeof(wm8776_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8776_reg,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8776);
 
-static int wm8776_register(struct wm8776_priv *wm8776,
-			   enum snd_soc_control_type control)
-{
-	int ret, i;
-	struct snd_soc_codec *codec = &wm8776->codec;
-
-	if (wm8776_codec) {
-		dev_err(codec->dev, "Another WM8776 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8776);
-	codec->name = "WM8776";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8776_set_bias_level;
-	codec->dai = wm8776_dai;
-	codec->num_dai = ARRAY_SIZE(wm8776_dai);
-	codec->reg_cache_size = WM8776_CACHEREGNUM;
-	codec->reg_cache = &wm8776->reg_cache;
-
-	memcpy(codec->reg_cache, wm8776_reg, sizeof(wm8776_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(wm8776_dai); i++)
-		wm8776_dai[i].dev = codec->dev;
-
-	ret = wm8776_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
-		goto err;
-	}
-
-	wm8776_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Latch the update bits; right channel only since we always
-	 * update both. */
-	snd_soc_update_bits(codec, WM8776_HPRVOL, 0x100, 0x100);
-	snd_soc_update_bits(codec, WM8776_DACRVOL, 0x100, 0x100);
-
-	wm8776_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dais(wm8776_dai, ARRAY_SIZE(wm8776_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		goto err_codec;
-	}
-
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8776);
-	return ret;
-}
-
-static void wm8776_unregister(struct wm8776_priv *wm8776)
-{
-	wm8776_set_bias_level(&wm8776->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dais(wm8776_dai, ARRAY_SIZE(wm8776_dai));
-	snd_soc_unregister_codec(&wm8776->codec);
-	kfree(wm8776);
-	wm8776_codec = NULL;
-}
-
 #if defined(CONFIG_SPI_MASTER)
-static int wm8776_spi_write(struct spi_device *spi, const char *data, int len)
-{
-	struct spi_transfer t;
-	struct spi_message m;
-	u8 msg[2];
-
-	if (len <= 0)
-		return 0;
-
-	msg[0] = data[0];
-	msg[1] = data[1];
-
-	spi_message_init(&m);
-	memset(&t, 0, (sizeof t));
-
-	t.tx_buf = &msg[0];
-	t.len = len;
-
-	spi_message_add_tail(&t, &m);
-	spi_sync(spi, &m);
-
-	return len;
-}
-
 static int __devinit wm8776_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_codec *codec;
 	struct wm8776_priv *wm8776;
+	int ret;
 
 	wm8776 = kzalloc(sizeof(struct wm8776_priv), GFP_KERNEL);
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8776->codec;
-	codec->control_data = spi;
-	codec->hw_write = (hw_write_t)wm8776_spi_write;
-	codec->dev = &spi->dev;
+	wm8776->control_data = spi;
+	wm8776->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8776);
 
-	dev_set_drvdata(&spi->dev, wm8776);
-
-	return wm8776_register(wm8776, SND_SOC_SPI);
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
+	if (ret < 0)
+		kfree(wm8776);
+	return ret;
 }
 
 static int __devexit wm8776_spi_remove(struct spi_device *spi)
 {
-	struct wm8776_priv *wm8776 = dev_get_drvdata(&spi->dev);
-
-	wm8776_unregister(wm8776);
-
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
@@ -626,27 +509,27 @@ static __devinit int wm8776_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8776_priv *wm8776;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8776 = kzalloc(sizeof(struct wm8776_priv), GFP_KERNEL);
 	if (wm8776 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8776->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, wm8776);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8776->control_data = i2c;
+	wm8776->control_type = SND_SOC_I2C;
 
-	return wm8776_register(wm8776, SND_SOC_I2C);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8776, wm8776_dai, ARRAY_SIZE(wm8776_dai));
+	if (ret < 0)
+		kfree(wm8776);
+	return ret;
 }
 
 static __devexit int wm8776_i2c_remove(struct i2c_client *client)
 {
-	struct wm8776_priv *wm8776 = i2c_get_clientdata(client);
-	wm8776_unregister(wm8776);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -658,7 +541,7 @@ MODULE_DEVICE_TABLE(i2c, wm8776_i2c_id);
 
 static struct i2c_driver wm8776_i2c_driver = {
 	.driver = {
-		.name = "wm8776",
+		.name = "wm8776 I2C Codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8776_i2c_probe,
@@ -669,22 +552,22 @@ static struct i2c_driver wm8776_i2c_driver = {
 
 static int __init wm8776_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8776_i2c_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8776 I2C driver: %d\n",
+		printk(KERN_ERR "Failed to register wm8776 I2C driver: %d\n",
 		       ret);
 	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8776_spi_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8776 SPI driver: %d\n",
+		printk(KERN_ERR "Failed to register wm8776 SPI driver: %d\n",
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8776_modinit);
 
diff --git a/sound/soc/codecs/wm8776.h b/sound/soc/codecs/wm8776.h
index 6606d25..9780e3a 100644
--- a/sound/soc/codecs/wm8776.h
+++ b/sound/soc/codecs/wm8776.h
@@ -45,7 +45,7 @@
 #define WM8776_DAI_DAC 0
 #define WM8776_DAI_ADC 1
 
-extern struct snd_soc_dai wm8776_dai[];
-extern struct snd_soc_codec_device soc_codec_dev_wm8776;
+extern struct snd_soc_dai_driver wm8776_dai[];
+extern struct snd_soc_codec_driver soc_codec_dev_wm8776;
 
 #endif
-- 
1.7.0.4
