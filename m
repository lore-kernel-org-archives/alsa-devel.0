From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 12/16] ASoC: multi-component - Wolfson WM8971,
	8993, 8990 and 8974 CODECs
Date: Fri, 25 Jun 2010 18:52:59 +0100
Message-ID: <1277488383-31287-13-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D7BCC103849
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:35 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so187430wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:35 -0700 (PDT)
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

Move Wolfson CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o wm8993: set_fll() needs to be accessed from both codec and dai
 device context, so wrapper added to acces from dai context.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8971.c |  248 ++++++++++--------------------------
 sound/soc/codecs/wm8971.h |    9 +-
 sound/soc/codecs/wm8974.c |  168 +++++++------------------
 sound/soc/codecs/wm8974.h |    4 +-
 sound/soc/codecs/wm8990.c |  226 ++++++++-------------------------
 sound/soc/codecs/wm8990.h |    9 +-
 sound/soc/codecs/wm8993.c |  305 ++++++++++++++++++---------------------------
 sound/soc/codecs/wm8993.h |    4 +-
 8 files changed, 305 insertions(+), 668 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index a99620f..31f4b0e 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -38,6 +38,8 @@ static struct workqueue_struct *wm8971_workq = NULL;
 
 /* codec private data */
 struct wm8971_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int sysclk;
 };
 
@@ -492,8 +494,7 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8971_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8971_SRATE) & 0x1c0;
@@ -573,7 +574,7 @@ static struct snd_soc_dai_ops wm8971_dai_ops = {
 	.set_sysclk	= wm8971_set_dai_sysclk,
 };
 
-struct snd_soc_dai wm8971_dai = {
+struct snd_soc_dai_driver wm8971_dai = {
 	.name = "WM8971",
 	.playback = {
 		.stream_name = "Playback",
@@ -598,19 +599,14 @@ static void wm8971_work(struct work_struct *work)
 	wm8971_set_bias_level(codec, codec->bias_level);
 }
 
-static int wm8971_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8971_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8971_resume(struct platform_device *pdev)
+static int wm8971_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -639,37 +635,27 @@ static int wm8971_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8971_init(struct snd_soc_device *socdev,
-		       enum snd_soc_control_type control)
+static int wm8971_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int reg, ret = 0;
-
-	codec->name = "WM8971";
-	codec->owner = THIS_MODULE;
-	codec->set_bias_level = wm8971_set_bias_level;
-	codec->dai = &wm8971_dai;
-	codec->reg_cache_size = ARRAY_SIZE(wm8971_reg);
-	codec->num_dai = 1;
-	codec->reg_cache = kmemdup(wm8971_reg, sizeof(wm8971_reg), GFP_KERNEL);
-
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+	u16 reg;
+
+	pr_info("WM8971 Audio Codec %s", WM8971_VERSION);
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8971->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8971->control_type);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8971: failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	wm8971_reset(codec);
+	INIT_DELAYED_WORK(&codec->delayed_work, wm8971_work);
+	wm8971_workq = create_workqueue("wm8971");
+	if (wm8971_workq == NULL)
+		return -ENOMEM;
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8971: failed to create pcms\n");
-		goto err;
-	}
+	wm8971_reset(codec);
 
 	/* charge output caps - set vmid to 5k for quick power up */
 	reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
@@ -704,40 +690,58 @@ static int wm8971_init(struct snd_soc_device *socdev,
 	wm8971_add_widgets(codec);
 
 	return ret;
-
-err:
-	kfree(codec->reg_cache);
-	return ret;
 }
 
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8971_socdev;
 
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
+/* power down chip */
+static int wm8971_remove(struct snd_soc_codec *codec)
+{
+	wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
+	if (wm8971_workq)
+		destroy_workqueue(wm8971_workq);
+	return 0;
+}
+
+struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
+	.name = "wm8971",
+	.owner = THIS_MODULE,
+	.probe = 	wm8971_probe,
+	.remove = 	wm8971_remove,
+	.suspend = 	wm8971_suspend,
+	.resume =	wm8971_resume,
+	.set_bias_level = wm8971_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8971_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8971_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8971);
 
-static int wm8971_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8971_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8971_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8971_priv *wm8971;
 	int ret;
 
-	i2c_set_clientdata(i2c, codec);
+	wm8971 = kzalloc(sizeof(struct wm8971_priv), GFP_KERNEL);
+	if (wm8971 == NULL)
+		return -ENOMEM;
 
-	codec->control_data = i2c;
+	i2c_set_clientdata(i2c, wm8971);
+	wm8971->control_data = i2c;
 
-	ret = wm8971_init(socdev, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8971, &wm8971_dai, 1);
 	if (ret < 0)
-		pr_err("failed to initialise WM8971\n");
-
+		kfree(wm8971);
 	return ret;
 }
 
-static int wm8971_i2c_remove(struct i2c_client *client)
+static __devexit int wm8971_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -752,145 +756,31 @@ static struct i2c_driver wm8971_i2c_driver = {
 		.name = "WM8971 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.probe    = wm8971_i2c_probe,
-	.remove   = wm8971_i2c_remove,
+	.probe =    wm8971_i2c_probe,
+	.remove =   __devexit_p(wm8971_i2c_remove),
 	.id_table = wm8971_i2c_id,
 };
-
-static int wm8971_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8971_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8971_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8971", I2C_NAME_SIZE);
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
-	i2c_del_driver(&wm8971_i2c_driver);
-	return -ENODEV;
-}
-
 #endif
 
-static int wm8971_probe(struct platform_device *pdev)
+static int __init wm8971_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8971_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct wm8971_priv *wm8971;
 	int ret = 0;
-
-	pr_info("WM8971 Audio Codec %s", WM8971_VERSION);
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8971 = kzalloc(sizeof(struct wm8971_priv), GFP_KERNEL);
-	if (wm8971 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	snd_soc_codec_set_drvdata(codec, wm8971);
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8971_socdev = socdev;
-
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8971_work);
-	wm8971_workq = create_workqueue("wm8971");
-	if (wm8971_workq == NULL) {
-		kfree(snd_soc_codec_get_drvdata(codec));
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		ret = wm8971_add_i2c_device(pdev, setup);
-	}
-#endif
-	/* Add other interfaces here */
-
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8971_i2c_driver);
 	if (ret != 0) {
-		destroy_workqueue(wm8971_workq);
-		kfree(snd_soc_codec_get_drvdata(codec));
-		kfree(codec);
+		printk(KERN_ERR "Failed to register WM8971 I2C driver: %d\n",
+		       ret);
 	}
-
-	return ret;
-}
-
-/* power down chip */
-static int wm8971_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8971_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	if (wm8971_workq)
-		destroy_workqueue(wm8971_workq);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
-	i2c_del_driver(&wm8971_i2c_driver);
 #endif
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8971 = {
-	.probe = 	wm8971_probe,
-	.remove = 	wm8971_remove,
-	.suspend = 	wm8971_suspend,
-	.resume =	wm8971_resume,
-};
-
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8971);
-
-static int __init wm8971_modinit(void)
-{
-	return snd_soc_register_dai(&wm8971_dai);
+	return ret;
 }
 module_init(wm8971_modinit);
 
 static void __exit wm8971_exit(void)
 {
-	snd_soc_unregister_dai(&wm8971_dai);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&wm8971_i2c_driver);
+#endif
 }
 module_exit(wm8971_exit);
 
diff --git a/sound/soc/codecs/wm8971.h b/sound/soc/codecs/wm8971.h
index ef4f08f..a5a3292 100644
--- a/sound/soc/codecs/wm8971.h
+++ b/sound/soc/codecs/wm8971.h
@@ -53,12 +53,7 @@
 
 #define WM8971_SYSCLK	0
 
-struct wm8971_setup_data {
-	int i2c_bus;
-	unsigned short i2c_address;
-};
-
-extern struct snd_soc_dai wm8971_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8971;
+extern struct snd_soc_dai_driver wm8971_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8971;
 
 #endif
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index a2c4b2f..f290fad 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -51,12 +51,11 @@ static const u16 wm8974_reg[WM8974_CACHEREGNUM] = {
 #define WM8974_POWER1_BUFIOEN 0x04
 
 struct wm8974_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[WM8974_CACHEREGNUM];
 };
 
-static struct snd_soc_codec *wm8974_codec;
-
 #define wm8974_reset(c)	snd_soc_write(c, WM8974_RESET, 0)
 
 static const char *wm8974_companding[] = {"Off", "NC", "u-law", "A-law" };
@@ -566,7 +565,7 @@ static struct snd_soc_dai_ops wm8974_ops = {
 	.set_pll = wm8974_set_dai_pll,
 };
 
-struct snd_soc_dai wm8974_dai = {
+struct snd_soc_dai_driver wm8974_dai = {
 	.name = "WM8974 HiFi",
 	.playback = {
 		.stream_name = "Playback",
@@ -585,19 +584,14 @@ struct snd_soc_dai wm8974_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8974_dai);
 
-static int wm8974_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8974_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8974_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8974_resume(struct platform_device *pdev)
+static int wm8974_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -613,155 +607,78 @@ static int wm8974_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8974_probe(struct platform_device *pdev)
+static int wm8974_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
+	struct wm8974_priv *wm8974 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (wm8974_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
+	codec->control_data = wm8974->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm8974_codec;
-	codec = wm8974_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = wm8974_reset(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
 	}
 
+	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	snd_soc_add_controls(codec, wm8974_snd_controls,
 			     ARRAY_SIZE(wm8974_snd_controls));
 	wm8974_add_widgets(codec);
 
 	return ret;
-
-pcm_err:
-	return ret;
 }
 
 /* power down chip */
-static int wm8974_remove(struct platform_device *pdev)
+static int wm8974_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	wm8974_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm8974 = {
+struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
+	.name = "wm8974",
+	.owner = THIS_MODULE,
 	.probe = 	wm8974_probe,
 	.remove = 	wm8974_remove,
 	.suspend = 	wm8974_suspend,
 	.resume =	wm8974_resume,
+	.set_bias_level = wm8974_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8974_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8974_reg,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8974);
 
-static __devinit int wm8974_register(struct wm8974_priv *wm8974)
-{
-	int ret;
-	struct snd_soc_codec *codec = &wm8974->codec;
-
-	if (wm8974_codec) {
-		dev_err(codec->dev, "Another WM8974 is registered\n");
-		return -EINVAL;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8974);
-	codec->name = "WM8974";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8974_set_bias_level;
-	codec->dai = &wm8974_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8974_CACHEREGNUM;
-	codec->reg_cache = &wm8974->reg_cache;
-
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
-	memcpy(codec->reg_cache, wm8974_reg, sizeof(wm8974_reg));
-
-	ret = wm8974_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
-	}
-
-	wm8974_dai.dev = codec->dev;
-
-	wm8974_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	wm8974_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8974_dai);
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
-	kfree(wm8974);
-	return ret;
-}
-
-static __devexit void wm8974_unregister(struct wm8974_priv *wm8974)
-{
-	wm8974_set_bias_level(&wm8974->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8974_dai);
-	snd_soc_unregister_codec(&wm8974->codec);
-	kfree(wm8974);
-	wm8974_codec = NULL;
-}
-
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8974_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8974_priv *wm8974;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8974 = kzalloc(sizeof(struct wm8974_priv), GFP_KERNEL);
 	if (wm8974 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8974->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, wm8974);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8974->control_data = i2c;
 
-	return wm8974_register(wm8974);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8974, &wm8974_dai, 1);
+	if (ret < 0)
+		kfree(wm8974);
+	return ret;
 }
 
 static __devexit int wm8974_i2c_remove(struct i2c_client *client)
 {
-	struct wm8974_priv *wm8974 = i2c_get_clientdata(client);
-	wm8974_unregister(wm8974);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -773,23 +690,34 @@ MODULE_DEVICE_TABLE(i2c, wm8974_i2c_id);
 
 static struct i2c_driver wm8974_i2c_driver = {
 	.driver = {
-		.name = "WM8974",
+		.name = "wm8974 I2C Codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8974_i2c_probe,
 	.remove =   __devexit_p(wm8974_i2c_remove),
 	.id_table = wm8974_i2c_id,
 };
+#endif
 
 static int __init wm8974_modinit(void)
 {
-	return i2c_add_driver(&wm8974_i2c_driver);
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8974_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8974 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+	return ret;
 }
 module_init(wm8974_modinit);
 
 static void __exit wm8974_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8974_i2c_driver);
+#endif
 }
 module_exit(wm8974_exit);
 
diff --git a/sound/soc/codecs/wm8974.h b/sound/soc/codecs/wm8974.h
index 896a7f0..636cbe4 100644
--- a/sound/soc/codecs/wm8974.h
+++ b/sound/soc/codecs/wm8974.h
@@ -83,7 +83,7 @@
 #define WM8974_MCLKDIV_8	(6 << 5)
 #define WM8974_MCLKDIV_12	(7 << 5)
 
-extern struct snd_soc_dai wm8974_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8974;
+extern struct snd_soc_dai_driver wm8974_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8974;
 
 #endif
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index dd8d909..426a573 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -32,6 +32,8 @@
 
 /* codec private data */
 struct wm8990_priv {
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int sysclk;
 	unsigned int pcmclk;
 };
@@ -1114,8 +1116,7 @@ static int wm8990_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 audio1 = snd_soc_read(codec, WM8990_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8990_AIF_WL_MASK;
@@ -1293,10 +1294,9 @@ static struct snd_soc_dai_ops wm8990_dai_ops = {
 	.set_sysclk	= wm8990_set_dai_sysclk,
 };
 
-struct snd_soc_dai wm8990_dai = {
+struct snd_soc_dai_driver wm8990_dai = {
 /* ADC/DAC on primary */
 	.name = "WM8990 ADC/DAC Primary",
-	.id = 1,
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -1313,19 +1313,14 @@ struct snd_soc_dai wm8990_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8990_dai);
 
-static int wm8990_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8990_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8990_resume(struct platform_device *pdev)
+static int wm8990_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -1347,38 +1342,21 @@ static int wm8990_resume(struct platform_device *pdev)
  * initialise the WM8990 driver
  * register the mixer and dsp interfaces with the kernel
  */
-static int wm8990_init(struct snd_soc_device *socdev)
+static int wm8990_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8990_priv *wm8990 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 	u16 reg;
-	int ret = 0;
-
-	codec->name = "WM8990";
-	codec->owner = THIS_MODULE;
-	codec->set_bias_level = wm8990_set_bias_level;
-	codec->dai = &wm8990_dai;
-	codec->num_dai = 2;
-	codec->reg_cache_size = ARRAY_SIZE(wm8990_reg);
-	codec->reg_cache = kmemdup(wm8990_reg, sizeof(wm8990_reg), GFP_KERNEL);
-
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
 
+	codec->control_data = wm8990->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret < 0) {
 		printk(KERN_ERR "wm8990: failed to set cache I/O: %d\n", ret);
-		goto pcm_err;
+		return ret;
 	}
 
 	wm8990_reset(codec);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "wm8990: failed to create pcms\n");
-		goto pcm_err;
-	}
-
 	/* charge output caps */
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	wm8990_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -1400,47 +1378,55 @@ static int wm8990_init(struct snd_soc_device *socdev)
 				ARRAY_SIZE(wm8990_snd_controls));
 	wm8990_add_widgets(codec);
 
-	return ret;
+	return 0;
+}
 
-pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
+/* power down chip */
+static int wm8990_remove(struct snd_soc_codec *codec)
+{
+	wm8990_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-/* If the i2c layer weren't so broken, we could pass this kind of data
-   around */
-static struct snd_soc_device *wm8990_socdev;
+struct snd_soc_codec_driver soc_codec_dev_wm8990 = {
+	.name = "wm8990",
+	.owner = THIS_MODULE,
+	.probe = 	wm8990_probe,
+	.remove = 	wm8990_remove,
+	.suspend = 	wm8990_suspend,
+	.resume =	wm8990_resume,
+	.set_bias_level = wm8990_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8990_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8990_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8990);
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-/*
- * WM891 2 wire address is determined by GPIO5
- * state during powerup.
- *    low  = 0x34
- *    high = 0x36
- */
-
-static int wm8990_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int wm8990_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = wm8990_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8990_priv *wm8990;
 	int ret;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	wm8990 = kzalloc(sizeof(struct wm8990_priv), GFP_KERNEL);
+	if (wm8990 == NULL)
+		return -ENOMEM;
 
-	ret = wm8990_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise WM8990\n");
+	i2c_set_clientdata(i2c, wm8990);
+	wm8990->control_data = i2c;
 
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8990, &wm8990_dai, 1);
+	if (ret < 0)
+		kfree(wm8990);
 	return ret;
 }
 
-static int wm8990_i2c_remove(struct i2c_client *client)
+static __devexit int wm8990_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1452,134 +1438,34 @@ MODULE_DEVICE_TABLE(i2c, wm8990_i2c_id);
 
 static struct i2c_driver wm8990_i2c_driver = {
 	.driver = {
-		.name = "WM8990 I2C Codec",
+		.name = "wm8990 I2C Codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8990_i2c_probe,
-	.remove =   wm8990_i2c_remove,
+	.remove =   __devexit_p(wm8990_i2c_remove),
 	.id_table = wm8990_i2c_id,
 };
-
-static int wm8990_add_i2c_device(struct platform_device *pdev,
-				 const struct wm8990_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&wm8990_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "wm8990", I2C_NAME_SIZE);
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
-	i2c_del_driver(&wm8990_i2c_driver);
-	return -ENODEV;
-}
 #endif
 
-static int wm8990_probe(struct platform_device *pdev)
+static int __init wm8990_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8990_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct wm8990_priv *wm8990;
-	int ret;
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	wm8990 = kzalloc(sizeof(struct wm8990_priv), GFP_KERNEL);
-	if (wm8990 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	snd_soc_codec_set_drvdata(codec, wm8990);
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	wm8990_socdev = socdev;
-
-	ret = -ENODEV;
-
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = wm8990_add_i2c_device(pdev, setup);
-	}
-#endif
-
+	ret = i2c_add_driver(&wm8990_i2c_driver);
 	if (ret != 0) {
-		kfree(snd_soc_codec_get_drvdata(codec));
-		kfree(codec);
+		printk(KERN_ERR "Failed to register wm8990 I2C driver: %d\n",
+		       ret);
 	}
+#endif
 	return ret;
 }
+module_init(wm8990_modinit);
 
-/* power down chip */
-static int wm8990_remove(struct platform_device *pdev)
+static void __exit wm8990_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8990_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&wm8990_i2c_driver);
 #endif
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8990 = {
-	.probe =	wm8990_probe,
-	.remove =	wm8990_remove,
-	.suspend =	wm8990_suspend,
-	.resume =	wm8990_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8990);
-
-static int __init wm8990_modinit(void)
-{
-	return snd_soc_register_dai(&wm8990_dai);
-}
-module_init(wm8990_modinit);
-
-static void __exit wm8990_exit(void)
-{
-	snd_soc_unregister_dai(&wm8990_dai);
 }
 module_exit(wm8990_exit);
 
diff --git a/sound/soc/codecs/wm8990.h b/sound/soc/codecs/wm8990.h
index 7114ddc..4c7bede 100644
--- a/sound/soc/codecs/wm8990.h
+++ b/sound/soc/codecs/wm8990.h
@@ -826,18 +826,13 @@
 #define WM8990_INMIXR_PWR_BIT			2
 #define WM8990_AINRMUX_PWR_BIT			3
 
-struct wm8990_setup_data {
-	unsigned i2c_bus;
-	unsigned short i2c_address;
-};
-
 #define WM8990_MCLK_DIV 0
 #define WM8990_DACCLK_DIV 1
 #define WM8990_ADCCLK_DIV 2
 #define WM8990_BCLK_DIV 3
 
-extern struct snd_soc_dai wm8990_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8990;
+extern struct snd_soc_dai_driver wm8990_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8990;
 
 #endif	/* __WM8990REGISTERDEFS_H__ */
 /*------------------------------ END OF FILE ---------------------------------*/
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index d8d300c..6f6a2af 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -229,7 +229,8 @@ struct wm8993_priv {
 	u16 reg_cache[WM8993_REGISTER_COUNT];
 	struct regulator_bulk_data supplies[WM8993_NUM_SUPPLIES];
 	struct wm8993_platform_data pdata;
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	int master;
 	int sysclk_source;
 	int tdm_slots;
@@ -367,10 +368,9 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm8993_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
+static int _wm8993_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	u16 reg1, reg4, reg5;
 	struct _fll_div fll_div;
@@ -456,6 +456,12 @@ static int wm8993_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	return 0;
 }
 
+static int wm8993_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
+			  unsigned int Fref, unsigned int Fout)
+{
+	return _wm8993_set_fll(dai->codec, fll_id, source, Fref, Fout);
+}
+
 static int configure_clock(struct snd_soc_codec *codec)
 {
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
@@ -1394,7 +1400,7 @@ static struct snd_soc_dai_ops wm8993_ops = {
 			SNDRV_PCM_FMTBIT_S24_LE |\
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-struct snd_soc_dai wm8993_dai = {
+struct snd_soc_dai_driver wm8993_dai = {
 	.name = "WM8993",
 	.playback = {
 		.stream_name = "Playback",
@@ -1415,30 +1421,81 @@ struct snd_soc_dai wm8993_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8993_dai);
 
-static struct snd_soc_codec *wm8993_codec;
-
-static int wm8993_probe(struct platform_device *pdev)
+static int wm8993_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct wm8993_priv *wm8993;
-	int ret = 0;
+	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
+	int ret, i, val;
+
+	codec->control_data = wm8993->control_data;
+	wm8993->hubs_data.hp_startup_mode = 1;
+	wm8993->hubs_data.dcs_codes = -2;
 
-	if (!wm8993_codec) {
-		dev_err(&pdev->dev, "I2C device not yet probed\n");
-		goto err;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm8993_codec;
-	codec = wm8993_codec;
-	wm8993 = snd_soc_codec_get_drvdata(codec);
+	for (i = 0; i < ARRAY_SIZE(wm8993->supplies); i++)
+		wm8993->supplies[i].supply = wm8993_supply_names[i];
 
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
-		goto err;
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8993->supplies),
+				 wm8993->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
+				    wm8993->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_get;
 	}
 
+	val = snd_soc_read(codec, WM8993_SOFTWARE_RESET);
+	if (val != wm8993_reg_defaults[WM8993_SOFTWARE_RESET]) {
+		dev_err(codec->dev, "Invalid ID register value %x\n", val);
+		ret = -EINVAL;
+		goto err_enable;
+	}
+
+	ret = snd_soc_write(codec, WM8993_SOFTWARE_RESET, 0xffff);
+	if (ret != 0)
+		goto err_enable;
+
+	codec->cache_only = 1;
+
+	/* By default we're using the output mixers */
+	wm8993->class_w_users = 2;
+
+	/* Latch volume update bits and default ZC on */
+	snd_soc_update_bits(codec, WM8993_RIGHT_DAC_DIGITAL_VOLUME,
+			    WM8993_DAC_VU, WM8993_DAC_VU);
+	snd_soc_update_bits(codec, WM8993_RIGHT_ADC_DIGITAL_VOLUME,
+			    WM8993_ADC_VU, WM8993_ADC_VU);
+
+	/* Manualy manage the HPOUT sequencing for independent stereo
+	 * control. */
+	snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
+			    WM8993_HPOUT1_AUTO_PU, 0);
+
+	/* Use automatic clock configuration */
+	snd_soc_update_bits(codec, WM8993_CLOCKING_4, WM8993_SR_MODE, 0);
+
+	wm_hubs_handle_analogue_pdata(codec, wm8993->pdata.lineout1_diff,
+				      wm8993->pdata.lineout2_diff,
+				      wm8993->pdata.lineout1fb,
+				      wm8993->pdata.lineout2fb,
+				      wm8993->pdata.jd_scthr,
+				      wm8993->pdata.jd_thr,
+				      wm8993->pdata.micbias1_lvl,
+				      wm8993->pdata.micbias2_lvl);
+			     
+	ret = wm8993_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	if (ret != 0)
+		goto err_enable;
+
 	snd_soc_add_controls(codec, wm8993_snd_controls,
 			     ARRAY_SIZE(wm8993_snd_controls));
 	if (wm8993->pdata.num_retune_configs != 0) {
@@ -1457,36 +1514,36 @@ static int wm8993_probe(struct platform_device *pdev)
 	wm_hubs_add_analogue_routes(codec, wm8993->pdata.lineout1_diff,
 				    wm8993->pdata.lineout2_diff);
 
-	return ret;
+	return 0;
 
-err:
+err_enable:
+	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
+err_get:
+	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 	return ret;
 }
 
-static int wm8993_remove(struct platform_device *pdev)
+static int wm8993_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 
+	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int wm8993_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8993_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int fll_fout = wm8993->fll_fout;
 	int fll_fref  = wm8993->fll_fref;
 	int ret;
 
 	/* Stop the FLL in an orderly fashion */
-	ret = wm8993_set_fll(codec->dai, 0, 0, 0, 0);
+	ret = _wm8993_set_fll(codec, 0, 0, 0, 0);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to stop FLL\n");
+		dev_err(codec->dev, "Failed to stop FLL\n");
 		return ret;
 	}
 
@@ -1498,10 +1555,8 @@ static int wm8993_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int wm8993_resume(struct platform_device *pdev)
+static int wm8993_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8993_priv *wm8993 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -1515,7 +1570,7 @@ static int wm8993_resume(struct platform_device *pdev)
 		wm8993->fll_fref = 0;
 		wm8993->fll_fout = 0;
 
-		ret = wm8993_set_fll(codec->dai, 0, wm8993->fll_src,
+		ret = _wm8993_set_fll(codec, 0, wm8993->fll_src,
 				     fll_fref, fll_fout);
 		if (ret != 0)
 			dev_err(codec->dev, "Failed to restart FLL\n");
@@ -1528,162 +1583,46 @@ static int wm8993_resume(struct platform_device *pdev)
 #define wm8993_resume NULL
 #endif
 
-struct snd_soc_codec_device soc_codec_dev_wm8993 = {
+struct snd_soc_codec_driver soc_codec_dev_wm8993 = {
+	.name = "wm8993",
+	.owner = THIS_MODULE,
 	.probe = 	wm8993_probe,
 	.remove = 	wm8993_remove,
-	.suspend =	wm8993_suspend,
+	.suspend = 	wm8993_suspend,
 	.resume =	wm8993_resume,
+	.set_bias_level = wm8993_set_bias_level,
+	.reg_cache_size = sizeof(wm8993_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8993_reg_defaults,
+	.volatile_register = wm8993_volatile,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8993);
 
-static int wm8993_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8993_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8993_priv *wm8993;
-	struct snd_soc_codec *codec;
-	unsigned int val;
 	int ret;
-	int i;
-
-	if (wm8993_codec) {
-		dev_err(&i2c->dev, "A WM8993 is already registered\n");
-		return -EINVAL;
-	}
 
 	wm8993 = kzalloc(sizeof(struct wm8993_priv), GFP_KERNEL);
 	if (wm8993 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8993->codec;
-	if (i2c->dev.platform_data)
-		memcpy(&wm8993->pdata, i2c->dev.platform_data,
-		       sizeof(wm8993->pdata));
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "WM8993";
-	codec->volatile_register = wm8993_volatile;
-	codec->reg_cache = wm8993->reg_cache;
-	codec->reg_cache_size = ARRAY_SIZE(wm8993->reg_cache);
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8993_set_bias_level;
-	codec->dai = &wm8993_dai;
-	codec->num_dai = 1;
-	snd_soc_codec_set_drvdata(codec, wm8993);
-
-	wm8993->hubs_data.hp_startup_mode = 1;
-	wm8993->hubs_data.dcs_codes = -2;
-
-	memcpy(wm8993->reg_cache, wm8993_reg_defaults,
-	       sizeof(wm8993->reg_cache));
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
 	i2c_set_clientdata(i2c, wm8993);
-	codec->control_data = i2c;
-	wm8993_codec = codec;
-
-	codec->dev = &i2c->dev;
-
-	for (i = 0; i < ARRAY_SIZE(wm8993->supplies); i++)
-		wm8993->supplies[i].supply = wm8993_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8993->supplies),
-				 wm8993->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(wm8993->supplies),
-				    wm8993->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	val = snd_soc_read(codec, WM8993_SOFTWARE_RESET);
-	if (val != wm8993_reg_defaults[WM8993_SOFTWARE_RESET]) {
-		dev_err(codec->dev, "Invalid ID register value %x\n", val);
-		ret = -EINVAL;
-		goto err_enable;
-	}
-
-	ret = snd_soc_write(codec, WM8993_SOFTWARE_RESET, 0xffff);
-	if (ret != 0)
-		goto err_enable;
-
-	codec->cache_only = 1;
-
-	/* By default we're using the output mixers */
-	wm8993->class_w_users = 2;
-
-	/* Latch volume update bits and default ZC on */
-	snd_soc_update_bits(codec, WM8993_RIGHT_DAC_DIGITAL_VOLUME,
-			    WM8993_DAC_VU, WM8993_DAC_VU);
-	snd_soc_update_bits(codec, WM8993_RIGHT_ADC_DIGITAL_VOLUME,
-			    WM8993_ADC_VU, WM8993_ADC_VU);
-
-	/* Manualy manage the HPOUT sequencing for independent stereo
-	 * control. */
-	snd_soc_update_bits(codec, WM8993_ANALOGUE_HP_0,
-			    WM8993_HPOUT1_AUTO_PU, 0);
-
-	/* Use automatic clock configuration */
-	snd_soc_update_bits(codec, WM8993_CLOCKING_4, WM8993_SR_MODE, 0);
-
-	wm_hubs_handle_analogue_pdata(codec, wm8993->pdata.lineout1_diff,
-				      wm8993->pdata.lineout2_diff,
-				      wm8993->pdata.lineout1fb,
-				      wm8993->pdata.lineout2fb,
-				      wm8993->pdata.jd_scthr,
-				      wm8993->pdata.jd_thr,
-				      wm8993->pdata.micbias1_lvl,
-				      wm8993->pdata.micbias2_lvl);
-			     
-	ret = wm8993_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	if (ret != 0)
-		goto err_enable;
-
-	wm8993_dai.dev = codec->dev;
-
-	ret = snd_soc_register_dai(&wm8993_dai);
-	if (ret != 0)
-		goto err_bias;
+	wm8993->control_data = i2c;
 
-	ret = snd_soc_register_codec(codec);
-
-	return 0;
-
-err_bias:
-	wm8993_set_bias_level(codec, SND_SOC_BIAS_OFF);
-err_enable:
-	regulator_bulk_disable(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-err:
-	wm8993_codec = NULL;
-	kfree(wm8993);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8993, &wm8993_dai, 1);
+	if (ret < 0)
+		kfree(wm8993);
 	return ret;
 }
 
-static int wm8993_i2c_remove(struct i2c_client *client)
+static __devexit int wm8993_i2c_remove(struct i2c_client *client)
 {
-	struct wm8993_priv *wm8993 = i2c_get_clientdata(client);
-
-	snd_soc_unregister_codec(&wm8993->codec);
-	snd_soc_unregister_dai(&wm8993_dai);
-
-	wm8993_set_bias_level(&wm8993->codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(wm8993->supplies), wm8993->supplies);
-	kfree(wm8993);
-
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1698,27 +1637,31 @@ static struct i2c_driver wm8993_i2c_driver = {
 		.name = "WM8993",
 		.owner = THIS_MODULE,
 	},
-	.probe = wm8993_i2c_probe,
-	.remove = wm8993_i2c_remove,
+	.probe =    wm8993_i2c_probe,
+	.remove =   __devexit_p(wm8993_i2c_remove),
 	.id_table = wm8993_i2c_id,
 };
-
+#endif
 
 static int __init wm8993_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8993_i2c_driver);
-	if (ret != 0)
-		pr_err("WM8993: Unable to register I2C driver: %d\n", ret);
-
+	if (ret != 0) {
+		pr_err("WM8993: Unable to register I2C driver: %d\n",
+		       ret);
+	}
+#endif
 	return ret;
 }
 module_init(wm8993_modinit);
 
 static void __exit wm8993_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8993_i2c_driver);
+#endif
 }
 module_exit(wm8993_exit);
 
diff --git a/sound/soc/codecs/wm8993.h b/sound/soc/codecs/wm8993.h
index 30e71ca..33b5fa3 100644
--- a/sound/soc/codecs/wm8993.h
+++ b/sound/soc/codecs/wm8993.h
@@ -1,8 +1,8 @@
 #ifndef WM8993_H
 #define WM8993_H
 
-extern struct snd_soc_dai wm8993_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8993;
+extern struct snd_soc_dai_driver wm8993_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8993;
 
 #define WM8993_SYSCLK_MCLK     1
 #define WM8993_SYSCLK_FLL      2
-- 
1.7.0.4
