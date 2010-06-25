From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 11/16] ASoC: multi-component - Wolfson wm8960,
	8961 and 8940 CODECs
Date: Fri, 25 Jun 2010 18:52:58 +0100
Message-ID: <1277488383-31287-12-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F2319103A1D
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:33 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166789wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:33 -0700 (PDT)
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

Move Wolfson CODECs to multi-component model

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o wm8960: codec device no longer has set_bias(), so func moved to private data.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8940.c |  198 ++++++++++++--------------------------
 sound/soc/codecs/wm8940.h |    4 +-
 sound/soc/codecs/wm8960.c |  206 +++++++++++++--------------------------
 sound/soc/codecs/wm8960.h |    4 +-
 sound/soc/codecs/wm8961.c |  237 +++++++++++++++------------------------------
 sound/soc/codecs/wm8961.h |    4 +-
 6 files changed, 213 insertions(+), 440 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index e3c4bbf..1245cf6 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -44,7 +44,8 @@
 struct wm8940_priv {
 	unsigned int sysclk;
 	u16 reg_cache[WM8940_CACHEREGNUM];
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
 static u16 wm8940_reg_defaults[] = {
@@ -365,8 +366,7 @@ static int wm8940_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 iface = snd_soc_read(codec, WM8940_IFACE) & 0xFD9F;
 	u16 addcntrl = snd_soc_read(codec, WM8940_ADDCNTRL) & 0xFFF1;
 	u16 companding =  snd_soc_read(codec,
@@ -636,7 +636,7 @@ static struct snd_soc_dai_ops wm8940_dai_ops = {
 	.set_pll = wm8940_set_dai_pll,
 };
 
-struct snd_soc_dai wm8940_dai = {
+struct snd_soc_dai_driver wm8940_dai = {
 	.name = "WM8940",
 	.playback = {
 		.stream_name = "Playback",
@@ -657,18 +657,13 @@ struct snd_soc_dai wm8940_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8940_dai);
 
-static int wm8940_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8940_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	return wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
 
-static int wm8940_resume(struct platform_device *pdev)
+static int wm8940_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	int ret;
 	u8 data[3];
@@ -697,108 +692,26 @@ error_ret:
 	return ret;
 }
 
-static struct snd_soc_codec *wm8940_codec;
-
-static int wm8940_probe(struct platform_device *pdev)
+static int wm8940_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-
-	int ret = 0;
-
-	if (wm8940_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8940_codec;
-	codec = wm8940_codec;
-
-	mutex_init(&codec->mutex);
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	ret = snd_soc_add_controls(codec, wm8940_snd_controls,
-			     ARRAY_SIZE(wm8940_snd_controls));
-	if (ret)
-		goto error_free_pcms;
-	ret = wm8940_add_widgets(codec);
-	if (ret)
-		goto error_free_pcms;
-
-	return ret;
-
-error_free_pcms:
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-pcm_err:
-	return ret;
-}
-
-static int wm8940_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8940 = {
-	.probe = wm8940_probe,
-	.remove = wm8940_remove,
-	.suspend = wm8940_suspend,
-	.resume = wm8940_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8940);
-
-static int wm8940_register(struct wm8940_priv *wm8940,
-			   enum snd_soc_control_type control)
-{
-	struct wm8940_setup_data *pdata = wm8940->codec.dev->platform_data;
-	struct snd_soc_codec *codec = &wm8940->codec;
+	struct wm8940_priv *wm8940 = snd_soc_codec_get_drvdata(codec);
+	struct wm8940_setup_data *pdata = codec->dev->platform_data;
 	int ret;
 	u16 reg;
-	if (wm8940_codec) {
-		dev_err(codec->dev, "Another WM8940 is registered\n");
-		return -EINVAL;
-	}
-
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8940);
-	codec->name = "WM8940";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8940_set_bias_level;
-	codec->dai = &wm8940_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults);
-	codec->reg_cache = &wm8940->reg_cache;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	codec->control_data = wm8940->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8940->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
-	memcpy(codec->reg_cache, wm8940_reg_defaults,
-	       sizeof(wm8940_reg_defaults));
-
 	ret = wm8940_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
 		return ret;
 	}
 
-	wm8940_dai.dev = codec->dev;
-
 	wm8940_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	ret = snd_soc_write(codec, WM8940_POWER1, 0x180);
@@ -814,59 +727,63 @@ static int wm8940_register(struct wm8940_priv *wm8940,
 			return ret;
 	}
 
-
-	wm8940_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
+	ret = snd_soc_add_controls(codec, wm8940_snd_controls,
+			     ARRAY_SIZE(wm8940_snd_controls));
+	if (ret)
 		return ret;
-	}
-
-	ret = snd_soc_register_dai(&wm8940_dai);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
+	ret = wm8940_add_widgets(codec);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
+	return ret;
+;
 }
 
-static void wm8940_unregister(struct wm8940_priv *wm8940)
+static int wm8940_remove(struct snd_soc_codec *codec)
 {
-	wm8940_set_bias_level(&wm8940->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8940_dai);
-	snd_soc_unregister_codec(&wm8940->codec);
-	kfree(wm8940);
-	wm8940_codec = NULL;
+	wm8940_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-static int wm8940_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
+	.name = "wm8940",
+	.owner = THIS_MODULE,
+	.probe = 	wm8940_probe,
+	.remove = 	wm8940_remove,
+	.suspend = 	wm8940_suspend,
+	.resume =	wm8940_resume,
+	.set_bias_level = wm8940_set_bias_level,
+	.reg_cache_size = sizeof(wm8940_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8940_reg_defaults,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8940);
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8940_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8940_priv *wm8940;
-	struct snd_soc_codec *codec;
+	int ret;
 
-	wm8940 = kzalloc(sizeof *wm8940, GFP_KERNEL);
+	wm8940 = kzalloc(sizeof(struct wm8940_priv), GFP_KERNEL);
 	if (wm8940 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8940->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
 	i2c_set_clientdata(i2c, wm8940);
-	codec->control_data = i2c;
-	codec->dev = &i2c->dev;
+	wm8940->control_data = i2c;
 
-	return wm8940_register(wm8940, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8940, &wm8940_dai, 1);
+	if (ret < 0)
+		kfree(wm8940);
+	return ret;
 }
 
-static int __devexit wm8940_i2c_remove(struct i2c_client *client)
+static __devexit int wm8940_i2c_remove(struct i2c_client *client)
 {
-	struct wm8940_priv *wm8940 = i2c_get_clientdata(client);
-
-	wm8940_unregister(wm8940);
-
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -881,26 +798,31 @@ static struct i2c_driver wm8940_i2c_driver = {
 		.name = "WM8940 I2C Codec",
 		.owner = THIS_MODULE,
 	},
-	.probe = wm8940_i2c_probe,
-	.remove = __devexit_p(wm8940_i2c_remove),
+	.probe =    wm8940_i2c_probe,
+	.remove =   __devexit_p(wm8940_i2c_remove),
 	.id_table = wm8940_i2c_id,
 };
+#endif
 
 static int __init wm8940_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8940_i2c_driver);
-	if (ret)
-		printk(KERN_ERR "Failed to register WM8940 I2C driver: %d\n",
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8940 I2C driver: %d\n",
 		       ret);
+	}
+#endif
 	return ret;
 }
 module_init(wm8940_modinit);
 
 static void __exit wm8940_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8940_i2c_driver);
+#endif
 }
 module_exit(wm8940_exit);
 
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
index 8410eed..7c76b87 100644
--- a/sound/soc/codecs/wm8940.h
+++ b/sound/soc/codecs/wm8940.h
@@ -15,8 +15,8 @@ struct wm8940_setup_data {
 #define WM8940_VROI_30K 1
 	unsigned int vroi:1;
 };
-extern struct snd_soc_dai wm8940_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8940;
+extern struct snd_soc_dai_driver wm8940_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8940;
 
 /* WM8940 register space */
 #define WM8940_SOFTRESET	0x00
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 7233cc6..9c88f6a 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -29,8 +29,6 @@
 
 #define AUDIO_NAME "wm8960"
 
-struct snd_soc_codec_device soc_codec_dev_wm8960;
-
 /* R25 - Power 1 */
 #define WM8960_VMID_MASK 0x180
 #define WM8960_VREF      0x40
@@ -75,7 +73,10 @@ static const u16 wm8960_reg[WM8960_CACHEREGNUM] = {
 
 struct wm8960_priv {
 	u16 reg_cache[WM8960_CACHEREGNUM];
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
+	int (*set_bias_level)(struct snd_soc_codec *,
+			      enum snd_soc_bias_level level);
 	struct snd_soc_dapm_widget *lout1;
 	struct snd_soc_dapm_widget *rout1;
 	struct snd_soc_dapm_widget *out3;
@@ -438,8 +439,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
 
 	/* bit size */
@@ -766,6 +766,14 @@ static int wm8960_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8960_set_bias_level(struct snd_soc_codec *codec,
+				 enum snd_soc_bias_level level)
+{
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
+	return wm8960->set_bias_level(codec, level);
+}
+
 #define WM8960_RATES SNDRV_PCM_RATE_8000_48000
 
 #define WM8960_FORMATS \
@@ -780,7 +788,7 @@ static struct snd_soc_dai_ops wm8960_dai_ops = {
 	.set_pll = wm8960_set_dai_pll,
 };
 
-struct snd_soc_dai wm8960_dai = {
+struct snd_soc_dai_driver wm8960_dai = {
 	.name = "WM8960",
 	.playback = {
 		.stream_name = "Playback",
@@ -799,19 +807,17 @@ struct snd_soc_dai wm8960_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8960_dai);
 
-static int wm8960_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8960_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 
-	codec->set_bias_level(codec, SND_SOC_BIAS_OFF);
+	wm8960->set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8960_resume(struct platform_device *pdev)
+static int wm8960_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -823,78 +829,19 @@ static int wm8960_resume(struct platform_device *pdev)
 		codec->hw_write(codec->control_data, data, 2);
 	}
 
-	codec->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
+	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
-static struct snd_soc_codec *wm8960_codec;
-
-static int wm8960_probe(struct platform_device *pdev)
+static int wm8960_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8960_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8960_codec;
-	codec = wm8960_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8960_snd_controls,
-			     ARRAY_SIZE(wm8960_snd_controls));
-	wm8960_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8960_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8960 = {
-	.probe = 	wm8960_probe,
-	.remove = 	wm8960_remove,
-	.suspend = 	wm8960_suspend,
-	.resume =	wm8960_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8960);
-
-static int wm8960_register(struct wm8960_priv *wm8960,
-			   enum snd_soc_control_type control)
-{
-	struct wm8960_data *pdata = wm8960->codec.dev->platform_data;
-	struct snd_soc_codec *codec = &wm8960->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	struct wm8960_data *pdata = dev_get_platdata(codec->dev);
 	int ret;
 	u16 reg;
 
-	if (wm8960_codec) {
-		dev_err(codec->dev, "Another WM8960 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	codec->set_bias_level = wm8960_set_bias_level_out3;
+	wm8960->set_bias_level = wm8960_set_bias_level_out3;
+	codec->control_data = wm8960->control_data;
 
 	if (!pdata) {
 		dev_warn(codec->dev, "No platform data supplied\n");
@@ -905,39 +852,22 @@ static int wm8960_register(struct wm8960_priv *wm8960,
 		}
 
 		if (pdata->capless)
-			codec->set_bias_level = wm8960_set_bias_level_capless;
+			wm8960->set_bias_level = wm8960_set_bias_level_capless;
 	}
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8960);
-	codec->name = "WM8960";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->dai = &wm8960_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8960_CACHEREGNUM;
-	codec->reg_cache = &wm8960->reg_cache;
-
-	memcpy(codec->reg_cache, wm8960_reg, sizeof(wm8960_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8960->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = wm8960_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
+		return ret;
 	}
 
-	wm8960_dai.dev = codec->dev;
-
-	codec->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8960->set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	/* Latch the update bits */
 	reg = snd_soc_read(codec, WM8960_LINVOL);
@@ -961,62 +891,61 @@ static int wm8960_register(struct wm8960_priv *wm8960,
 	reg = snd_soc_read(codec, WM8960_ROUT2);
 	snd_soc_write(codec, WM8960_ROUT2, reg | 0x100);
 
-	wm8960_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8960_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8960_snd_controls,
+				     ARRAY_SIZE(wm8960_snd_controls));
+	wm8960_add_widgets(codec);
 
 	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8960);
-	return ret;
 }
 
-static void wm8960_unregister(struct wm8960_priv *wm8960)
+/* power down chip */
+static int wm8960_remove(struct snd_soc_codec *codec)
 {
-	wm8960->codec.set_bias_level(&wm8960->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8960_dai);
-	snd_soc_unregister_codec(&wm8960->codec);
-	kfree(wm8960);
-	wm8960_codec = NULL;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
+	wm8960->set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
+struct snd_soc_codec_driver soc_codec_dev_wm8960 = {
+	.name = "wm8960",
+	.owner = THIS_MODULE,
+	.probe = 	wm8960_probe,
+	.remove = 	wm8960_remove,
+	.suspend = 	wm8960_suspend,
+	.resume =	wm8960_resume,
+	.set_bias_level = wm8960_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8960_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8960_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8960);
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8960_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8960_priv *wm8960;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8960 = kzalloc(sizeof(struct wm8960_priv), GFP_KERNEL);
 	if (wm8960 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8960->codec;
-
 	i2c_set_clientdata(i2c, wm8960);
-	codec->control_data = i2c;
+	wm8960->control_data = i2c;
 
-	codec->dev = &i2c->dev;
-
-	return wm8960_register(wm8960, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8960, &wm8960_dai, 1);
+	if (ret < 0)
+		kfree(wm8960);
+	return ret;
 }
 
 static __devexit int wm8960_i2c_remove(struct i2c_client *client)
 {
-	struct wm8960_priv *wm8960 = i2c_get_clientdata(client);
-	wm8960_unregister(wm8960);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1035,24 +964,27 @@ static struct i2c_driver wm8960_i2c_driver = {
 	.remove =   __devexit_p(wm8960_i2c_remove),
 	.id_table = wm8960_i2c_id,
 };
+#endif
 
 static int __init wm8960_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8960_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM8960 I2C driver: %d\n",
 		       ret);
 	}
-
+#endif
 	return ret;
 }
 module_init(wm8960_modinit);
 
 static void __exit wm8960_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8960_i2c_driver);
+#endif
 }
 module_exit(wm8960_exit);
 
diff --git a/sound/soc/codecs/wm8960.h b/sound/soc/codecs/wm8960.h
index a5ef654..ab8899c 100644
--- a/sound/soc/codecs/wm8960.h
+++ b/sound/soc/codecs/wm8960.h
@@ -110,7 +110,7 @@
 #define WM8960_OPCLK_DIV_5_5		(4 << 0)
 #define WM8960_OPCLK_DIV_6		(5 << 0)
 
-extern struct snd_soc_dai wm8960_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8960;
+extern struct snd_soc_dai_driver wm8960_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8960;
 
 #endif
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index 5b9a756..ad112c9 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -288,7 +288,8 @@ static u16 wm8961_reg_defaults[] = {
 };
 
 struct wm8961_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	int sysclk;
 	u16 reg_cache[WM8961_MAX_REGISTER];
 };
@@ -940,7 +941,7 @@ static struct snd_soc_dai_ops wm8961_dai_ops = {
 	.set_clkdiv = wm8961_set_clkdiv,
 };
 
-struct snd_soc_dai wm8961_dai = {
+struct snd_soc_dai_driver wm8961_dai = {
 	.name = "WM8961",
 	.playback = {
 		.stream_name = "HiFi Playback",
@@ -958,138 +959,24 @@ struct snd_soc_dai wm8961_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8961_dai);
 
-
-static struct snd_soc_codec *wm8961_codec;
-
-static int wm8961_probe(struct platform_device *pdev)
+static int wm8961_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
+	struct wm8961_priv *wm8961 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
-
-	if (wm8961_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8961_codec;
-	codec = wm8961_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8961_snd_controls,
-				ARRAY_SIZE(wm8961_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8961_dapm_widgets,
-				  ARRAY_SIZE(wm8961_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-static int wm8961_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int wm8961_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	wm8961_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int wm8961_resume(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 *reg_cache = codec->reg_cache;
-	int i;
-
-	for (i = 0; i < codec->reg_cache_size; i++) {
-		if (reg_cache[i] == wm8961_reg_defaults[i])
-			continue;
-
-		if (i == WM8961_SOFTWARE_RESET)
-			continue;
-
-		snd_soc_write(codec, i, reg_cache[i]);
-	}
-
-	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-#else
-#define wm8961_suspend NULL
-#define wm8961_resume NULL
-#endif
-
-struct snd_soc_codec_device soc_codec_dev_wm8961 = {
-	.probe = 	wm8961_probe,
-	.remove = 	wm8961_remove,
-	.suspend =	wm8961_suspend,
-	.resume =	wm8961_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8961);
-
-static int wm8961_register(struct wm8961_priv *wm8961)
-{
-	struct snd_soc_codec *codec = &wm8961->codec;
-	int ret;
 	u16 reg;
 
-	if (wm8961_codec) {
-		dev_err(codec->dev, "Another WM8961 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8961);
-	codec->name = "WM8961";
-	codec->owner = THIS_MODULE;
-	codec->dai = &wm8961_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8961->reg_cache);
-	codec->reg_cache = &wm8961->reg_cache;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8961_set_bias_level;
-	codec->volatile_register = wm8961_volatile_register;
-
-	memcpy(codec->reg_cache, wm8961_reg_defaults,
-	       sizeof(wm8961_reg_defaults));
-
+	codec->control_data = wm8961->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	reg = snd_soc_read(codec, WM8961_SOFTWARE_RESET);
 	if (reg != 0x1801) {
 		dev_err(codec->dev, "Device is not a WM8961: ID=0x%x\n", reg);
 		ret = -EINVAL;
-		goto err;
+		return ret;
 	}
 
 	/* This isn't volatile - readback doesn't correspond to write */
@@ -1140,63 +1027,93 @@ static int wm8961_register(struct wm8961_priv *wm8961)
 
 	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	wm8961_dai.dev = codec->dev;
+	snd_soc_add_controls(codec, wm8961_snd_controls,
+				ARRAY_SIZE(wm8961_snd_controls));
+	snd_soc_dapm_new_controls(codec, wm8961_dapm_widgets,
+				  ARRAY_SIZE(wm8961_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
 
-	wm8961_codec = codec;
+	return 0;
+}
 
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
-	}
+static int wm8961_remove(struct snd_soc_codec *codec)
+{
+	wm8961_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
 
-	ret = snd_soc_register_dai(&wm8961_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
-	}
+#ifdef CONFIG_PM
+static int wm8961_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	wm8961_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
-
-err:
-	kfree(wm8961);
-	return ret;
 }
 
-static void wm8961_unregister(struct wm8961_priv *wm8961)
+static int wm8961_resume(struct snd_soc_codec *codec)
 {
-	wm8961_set_bias_level(&wm8961->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8961_dai);
-	snd_soc_unregister_codec(&wm8961->codec);
-	kfree(wm8961);
-	wm8961_codec = NULL;
+	u16 *reg_cache = codec->reg_cache;
+	int i;
+
+	for (i = 0; i < codec->driver->reg_cache_size; i++) {
+		if (reg_cache[i] == wm8961_reg_defaults[i])
+			continue;
+
+		if (i == WM8961_SOFTWARE_RESET)
+			continue;
+
+		snd_soc_write(codec, i, reg_cache[i]);
+	}
+
+	wm8961_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	return 0;
 }
+#else
+#define wm8961_suspend NULL
+#define wm8961_resume NULL
+#endif
 
+struct snd_soc_codec_driver soc_codec_dev_wm8961 = {
+	.name = "wm8961",
+	.owner = THIS_MODULE,
+	.probe = 	wm8961_probe,
+	.remove = 	wm8961_remove,
+	.suspend = 	wm8961_suspend,
+	.resume =	wm8961_resume,
+	.set_bias_level = wm8961_set_bias_level,
+	.reg_cache_size = sizeof(wm8961_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8961_reg_defaults,
+	.volatile_register = wm8961_volatile_register,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8961);
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8961_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8961_priv *wm8961;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8961 = kzalloc(sizeof(struct wm8961_priv), GFP_KERNEL);
 	if (wm8961 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8961->codec;
-
 	i2c_set_clientdata(i2c, wm8961);
-	codec->control_data = i2c;
+	wm8961->control_data = i2c;
 
-	codec->dev = &i2c->dev;
-
-	return wm8961_register(wm8961);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm8961, &wm8961_dai, 1);
+	if (ret < 0)
+		kfree(wm8961);
+	return ret;
 }
 
 static __devexit int wm8961_i2c_remove(struct i2c_client *client)
 {
-	struct wm8961_priv *wm8961 = i2c_get_clientdata(client);
-	wm8961_unregister(wm8961);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1208,35 +1125,37 @@ MODULE_DEVICE_TABLE(i2c, wm8961_i2c_id);
 
 static struct i2c_driver wm8961_i2c_driver = {
 	.driver = {
-		.name = "wm8961",
+		.name = "wm8961 I2C Codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8961_i2c_probe,
 	.remove =   __devexit_p(wm8961_i2c_remove),
 	.id_table = wm8961_i2c_id,
 };
+#endif
 
 static int __init wm8961_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8961_i2c_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8961 I2C driver: %d\n",
+		printk(KERN_ERR "Failed to register wm8961 I2C driver: %d\n",
 		       ret);
 	}
-
+#endif
 	return ret;
 }
 module_init(wm8961_modinit);
 
 static void __exit wm8961_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8961_i2c_driver);
+#endif
 }
 module_exit(wm8961_exit);
 
-
 MODULE_DESCRIPTION("ASoC WM8961 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm8961.h b/sound/soc/codecs/wm8961.h
index 5513bfd..21443e4 100644
--- a/sound/soc/codecs/wm8961.h
+++ b/sound/soc/codecs/wm8961.h
@@ -11,8 +11,8 @@
 
 #include <sound/soc.h>
 
-extern struct snd_soc_codec_device soc_codec_dev_wm8961;
-extern struct snd_soc_dai wm8961_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8961;
+extern struct snd_soc_dai_driver wm8961_dai;
 
 #define WM8961_BCLK  1
 #define WM8961_LRCLK 2
-- 
1.7.0.4
