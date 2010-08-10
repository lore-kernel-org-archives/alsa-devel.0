From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 13/17] ASoC: multi-component - Wolfson WM8978,
	8988 and 8994 CODECs
Date: Wed, 11 Aug 2010 00:03:04 +0100
Message-ID: <1281481388-3000-14-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E24A103888
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:57 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:57 -0700 (PDT)
In-Reply-To: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
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

Move to Wolfson CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o wm8994: set_fll() needs to be accessed from both codec and dai
 device context, so wrapper added to acces from dai context.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8978.c |  190 +++++++++-----------------------
 sound/soc/codecs/wm8978.h |    3 -
 sound/soc/codecs/wm8988.c |  266 +++++++++++++++------------------------------
 sound/soc/codecs/wm8988.h |    3 -
 sound/soc/codecs/wm8994.c |  230 +++++++++++++--------------------------
 sound/soc/codecs/wm8994.h |    3 -
 6 files changed, 222 insertions(+), 473 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8a1ad77..676a430 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -31,8 +31,6 @@
 
 #include "wm8978.h"
 
-static struct snd_soc_codec *wm8978_codec;
-
 /* wm8978 register cache. Note that register 0 is not included in the cache. */
 static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
 	0x0000, 0x0000, 0x0000, 0x0000,	/* 0x00...0x03 */
@@ -54,7 +52,8 @@ static const u16 wm8978_reg[WM8978_CACHEREGNUM] = {
 
 /* codec private data */
 struct wm8978_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int f_pllout;
 	unsigned int f_mclk;
 	unsigned int f_256fs;
@@ -374,8 +373,8 @@ struct wm8978_pll_div {
 
 #define FIXED_PLL_SIZE (1 << 24)
 
-static void pll_factors(struct wm8978_pll_div *pll_div, unsigned int target,
-			unsigned int source)
+static void pll_factors(struct snd_soc_codec *codec,
+		struct wm8978_pll_div *pll_div, unsigned int target, unsigned int source)
 {
 	u64 k_part;
 	unsigned int k, n_div, n_mod;
@@ -390,7 +389,7 @@ static void pll_factors(struct wm8978_pll_div *pll_div, unsigned int target,
 	}
 
 	if (n_div < 6 || n_div > 12)
-		dev_warn(wm8978_codec->dev,
+		dev_warn(codec->dev,
 			 "WM8978 N value exceeds recommended range! N = %u\n",
 			 n_div);
 
@@ -505,7 +504,7 @@ static int wm8978_configure_pll(struct snd_soc_codec *codec)
 	dev_dbg(codec->dev, "%s: f_MCLK=%uHz, f_PLLOUT=%uHz\n", __func__,
 		wm8978->f_mclk, wm8978->f_pllout);
 
-	pll_factors(&pll_div, f2, wm8978->f_mclk);
+	pll_factors(codec, &pll_div, f2, wm8978->f_mclk);
 
 	dev_dbg(codec->dev, "%s: calculated PLL N=0x%x, K=0x%x, div2=%d\n",
 		__func__, pll_div.n, pll_div.k, pll_div.div2);
@@ -690,8 +689,7 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
 	/* Word length mask = 0x60 */
 	u16 iface_ctl = snd_soc_read(codec, WM8978_AUDIO_INTERFACE) & ~0x60;
@@ -875,9 +873,8 @@ static struct snd_soc_dai_ops wm8978_dai_ops = {
 };
 
 /* Also supports 12kHz */
-struct snd_soc_dai wm8978_dai = {
-	.name = "WM8978 HiFi",
-	.id = 1,
+static struct snd_soc_dai_driver wm8978_dai = {
+	.name = "wm8978-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -894,13 +891,9 @@ struct snd_soc_dai wm8978_dai = {
 	},
 	.ops = &wm8978_dai_ops,
 };
-EXPORT_SYMBOL_GPL(wm8978_dai);
 
-static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8978_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	/* Also switch PLL off */
 	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);
@@ -908,10 +901,8 @@ static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int wm8978_resume(struct platform_device *pdev)
+static int wm8978_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
 	int i;
 	u16 *cache = codec->reg_cache;
@@ -933,54 +924,6 @@ static int wm8978_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int wm8978_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8978_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8978_codec;
-	codec = wm8978_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8978_snd_controls,
-			     ARRAY_SIZE(wm8978_snd_controls));
-	wm8978_add_widgets(codec);
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8978_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8978 = {
-	.probe		= wm8978_probe,
-	.remove		= wm8978_remove,
-	.suspend	= wm8978_suspend,
-	.resume		= wm8978_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8978);
-
 /*
  * These registers contain an "update" bit - bit 8. This means, for example,
  * that one can write new DAC digital volume for both channels, but only when
@@ -1000,44 +943,23 @@ static const int update_reg[] = {
 	WM8978_ROUT2_SPK_CONTROL,
 };
 
-static __devinit int wm8978_register(struct wm8978_priv *wm8978)
+static int wm8978_probe(struct snd_soc_codec *codec)
 {
-	int ret, i;
-	struct snd_soc_codec *codec = &wm8978->codec;
-
-	if (wm8978_codec) {
-		dev_err(codec->dev, "Another WM8978 is registered\n");
-		return -EINVAL;
-	}
+	struct wm8978_priv *wm8978 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, i;
 
 	/*
 	 * Set default system clock to PLL, it is more precise, this is also the
 	 * default hardware setting
 	 */
 	wm8978->sysclk = WM8978_PLL;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8978);
-	codec->name = "WM8978";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8978_set_bias_level;
-	codec->dai = &wm8978_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8978_CACHEREGNUM;
-	codec->reg_cache = &wm8978->reg_cache;
-
+	codec->control_data = wm8978->control_data;
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, SND_SOC_I2C);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	memcpy(codec->reg_cache, wm8978_reg, sizeof(wm8978_reg));
-
 	/*
 	 * Set the update bit in all registers, that have one. This way all
 	 * writes to those registers will also cause the update bit to be
@@ -1050,74 +972,61 @@ static __devinit int wm8978_register(struct wm8978_priv *wm8978)
 	ret = snd_soc_write(codec, WM8978_RESET, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
+		return ret;
 	}
 
-	wm8978_dai.dev = codec->dev;
-
 	wm8978_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	wm8978_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8978_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8978_snd_controls,
+			     ARRAY_SIZE(wm8978_snd_controls));
+	wm8978_add_widgets(codec);
 
 	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	return ret;
 }
 
-static __devexit void wm8978_unregister(struct wm8978_priv *wm8978)
+/* power down chip */
+static int wm8978_remove(struct snd_soc_codec *codec)
 {
-	wm8978_set_bias_level(&wm8978->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8978_dai);
-	snd_soc_unregister_codec(&wm8978->codec);
-	wm8978_codec = NULL;
+	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8978 = {
+	.probe =	wm8978_probe,
+	.remove =	wm8978_remove,
+	.suspend =	wm8978_suspend,
+	.resume =	wm8978_resume,
+	.set_bias_level = wm8978_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8978_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8978_reg,
+};
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8978_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
-	int ret;
 	struct wm8978_priv *wm8978;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8978 = kzalloc(sizeof(struct wm8978_priv), GFP_KERNEL);
 	if (wm8978 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8978->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, wm8978);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8978->control_data = i2c;
 
-	ret = wm8978_register(wm8978);
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8978, &wm8978_dai, 1);
 	if (ret < 0)
 		kfree(wm8978);
-
 	return ret;
 }
 
 static __devexit int wm8978_i2c_remove(struct i2c_client *client)
 {
-	struct wm8978_priv *wm8978 = i2c_get_clientdata(client);
-	wm8978_unregister(wm8978);
-	kfree(wm8978);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1129,23 +1038,34 @@ MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
 
 static struct i2c_driver wm8978_i2c_driver = {
 	.driver = {
-		.name = "WM8978",
+		.name = "WM8978-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8978_i2c_probe,
 	.remove =   __devexit_p(wm8978_i2c_remove),
 	.id_table = wm8978_i2c_id,
 };
+#endif
 
 static int __init wm8978_modinit(void)
 {
-	return i2c_add_driver(&wm8978_i2c_driver);
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8978_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8978 I2C driver: %d\n",
+		       ret);
+	}
+#endif
+	return ret;
 }
 module_init(wm8978_modinit);
 
 static void __exit wm8978_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8978_i2c_driver);
+#endif
 }
 module_exit(wm8978_exit);
 
diff --git a/sound/soc/codecs/wm8978.h b/sound/soc/codecs/wm8978.h
index 56ec832..c75525b 100644
--- a/sound/soc/codecs/wm8978.h
+++ b/sound/soc/codecs/wm8978.h
@@ -80,7 +80,4 @@ enum wm8978_sysclk_src {
 	WM8978_MCLK
 };
 
-extern struct snd_soc_dai wm8978_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8978;
-
 #endif	/* __WM8978_H__ */
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 19ad590..ecbffce 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -52,7 +52,8 @@ static const u16 wm8988_reg[] = {
 /* codec private data */
 struct wm8988_priv {
 	unsigned int sysclk;
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
 	u16 reg_cache[WM8988_NUM_REG];
 };
@@ -608,8 +609,7 @@ static int wm8988_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8988_IFACE) & 0x1f3;
 	u16 srate = snd_soc_read(codec, WM8988_SRATE) & 0x180;
@@ -711,8 +711,8 @@ static struct snd_soc_dai_ops wm8988_ops = {
 	.digital_mute = wm8988_mute,
 };
 
-struct snd_soc_dai wm8988_dai = {
-	.name = "WM8988",
+static struct snd_soc_dai_driver wm8988_dai = {
+	.name = "wm8988-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -730,21 +730,15 @@ struct snd_soc_dai wm8988_dai = {
 	.ops = &wm8988_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(wm8988_dai);
 
-static int wm8988_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8988_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8988_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8988_resume(struct platform_device *pdev)
+static int wm8988_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -763,99 +757,23 @@ static int wm8988_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static struct snd_soc_codec *wm8988_codec;
-
-static int wm8988_probe(struct platform_device *pdev)
+static int wm8988_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
+	struct wm8988_priv *wm8988 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
-
-	if (wm8988_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8988_codec;
-	codec = wm8988_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(codec, wm8988_snd_controls,
-				ARRAY_SIZE(wm8988_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8988_dapm_widgets,
-				  ARRAY_SIZE(wm8988_dapm_widgets));
-	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-static int wm8988_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8988 = {
-	.probe = 	wm8988_probe,
-	.remove = 	wm8988_remove,
-	.suspend = 	wm8988_suspend,
-	.resume =	wm8988_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8988);
-
-static int wm8988_register(struct wm8988_priv *wm8988,
-			   enum snd_soc_control_type control)
-{
-	struct snd_soc_codec *codec = &wm8988->codec;
-	int ret;
 	u16 reg;
 
-	if (wm8988_codec) {
-		dev_err(codec->dev, "Another WM8988 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8988);
-	codec->name = "WM8988";
-	codec->owner = THIS_MODULE;
-	codec->dai = &wm8988_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8988->reg_cache);
-	codec->reg_cache = &wm8988->reg_cache;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8988_set_bias_level;
-
-	memcpy(codec->reg_cache, wm8988_reg,
-	       sizeof(wm8988_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8988->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8988->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = wm8988_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
-		goto err;
+		return ret;
 	}
 
 	/* set the update bits (we always update left then right) */
@@ -870,139 +788,135 @@ static int wm8988_register(struct wm8988_priv *wm8988,
 	reg = snd_soc_read(codec, WM8988_RINVOL);
 	snd_soc_write(codec, WM8988_RINVOL, reg | 0x0100);
 
-	wm8988_set_bias_level(&wm8988->codec, SND_SOC_BIAS_STANDBY);
-
-	wm8988_dai.dev = codec->dev;
-
-	wm8988_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
+	wm8988_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	ret = snd_soc_register_dai(&wm8988_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	snd_soc_add_controls(codec, wm8988_snd_controls,
+				ARRAY_SIZE(wm8988_snd_controls));
+	snd_soc_dapm_new_controls(codec, wm8988_dapm_widgets,
+				  ARRAY_SIZE(wm8988_dapm_widgets));
+	snd_soc_dapm_add_routes(codec, audio_map, ARRAY_SIZE(audio_map));
 
 	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8988);
-	return ret;
 }
 
-static void wm8988_unregister(struct wm8988_priv *wm8988)
+static int wm8988_remove(struct snd_soc_codec *codec)
 {
-	wm8988_set_bias_level(&wm8988->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm8988_dai);
-	snd_soc_unregister_codec(&wm8988->codec);
-	kfree(wm8988);
-	wm8988_codec = NULL;
+	wm8988_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static int wm8988_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static struct snd_soc_codec_driver soc_codec_dev_wm8988 = {
+	.probe =	wm8988_probe,
+	.remove =	wm8988_remove,
+	.suspend =	wm8988_suspend,
+	.resume =	wm8988_resume,
+	.set_bias_level = wm8988_set_bias_level,
+	.reg_cache_size = sizeof(wm8988_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8988_reg,
+};
+
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8988_spi_probe(struct spi_device *spi)
 {
 	struct wm8988_priv *wm8988;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8988 = kzalloc(sizeof(struct wm8988_priv), GFP_KERNEL);
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8988->codec;
-
-	i2c_set_clientdata(i2c, wm8988);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
+	wm8988->control_data = spi;
+	wm8988->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8988);
 
-	return wm8988_register(wm8988, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	if (ret < 0)
+		kfree(wm8988);
+	return ret;
 }
 
-static int wm8988_i2c_remove(struct i2c_client *client)
+static int __devexit wm8988_spi_remove(struct spi_device *spi)
 {
-	struct wm8988_priv *wm8988 = i2c_get_clientdata(client);
-	wm8988_unregister(wm8988);
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
-static const struct i2c_device_id wm8988_i2c_id[] = {
-	{ "wm8988", 0 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, wm8988_i2c_id);
-
-static struct i2c_driver wm8988_i2c_driver = {
+static struct spi_driver wm8988_spi_driver = {
 	.driver = {
-		.name = "WM8988",
-		.owner = THIS_MODULE,
+		.name	= "wm8988-codec",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
 	},
-	.probe = wm8988_i2c_probe,
-	.remove = wm8988_i2c_remove,
-	.id_table = wm8988_i2c_id,
+	.probe		= wm8988_spi_probe,
+	.remove		= __devexit_p(wm8988_spi_remove),
 };
-#endif
+#endif /* CONFIG_SPI_MASTER */
 
-#if defined(CONFIG_SPI_MASTER)
-static int __devinit wm8988_spi_probe(struct spi_device *spi)
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8988_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct wm8988_priv *wm8988;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8988 = kzalloc(sizeof(struct wm8988_priv), GFP_KERNEL);
 	if (wm8988 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8988->codec;
-	codec->control_data = spi;
-	codec->dev = &spi->dev;
-
-	dev_set_drvdata(&spi->dev, wm8988);
+	i2c_set_clientdata(i2c, wm8988);
+	wm8988->control_data = i2c;
+	wm8988->control_type = SND_SOC_I2C;
 
-	return wm8988_register(wm8988, SND_SOC_SPI);
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8988, &wm8988_dai, 1);
+	if (ret < 0)
+		kfree(wm8988);
+	return ret;
 }
 
-static int __devexit wm8988_spi_remove(struct spi_device *spi)
+static __devexit int wm8988_i2c_remove(struct i2c_client *client)
 {
-	struct wm8988_priv *wm8988 = dev_get_drvdata(&spi->dev);
-
-	wm8988_unregister(wm8988);
-
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-static struct spi_driver wm8988_spi_driver = {
+static const struct i2c_device_id wm8988_i2c_id[] = {
+	{ "wm8988", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wm8988_i2c_id);
+
+static struct i2c_driver wm8988_i2c_driver = {
 	.driver = {
-		.name	= "wm8988",
-		.bus	= &spi_bus_type,
-		.owner	= THIS_MODULE,
+		.name = "wm8988-codec",
+		.owner = THIS_MODULE,
 	},
-	.probe		= wm8988_spi_probe,
-	.remove		= __devexit_p(wm8988_spi_remove),
+	.probe =    wm8988_i2c_probe,
+	.remove =   __devexit_p(wm8988_i2c_remove),
+	.id_table = wm8988_i2c_id,
 };
 #endif
 
 static int __init wm8988_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8988_i2c_driver);
-	if (ret != 0)
-		pr_err("WM8988: Unable to register I2C driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8988 I2C driver: %d\n",
+		       ret);
+	}
 #endif
 #if defined(CONFIG_SPI_MASTER)
 	ret = spi_register_driver(&wm8988_spi_driver);
-	if (ret != 0)
-		pr_err("WM8988: Unable to register SPI driver: %d\n", ret);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register WM8988 SPI driver: %d\n",
+		       ret);
+	}
 #endif
 	return ret;
 }
diff --git a/sound/soc/codecs/wm8988.h b/sound/soc/codecs/wm8988.h
index 4552d37..5c04024 100644
--- a/sound/soc/codecs/wm8988.h
+++ b/sound/soc/codecs/wm8988.h
@@ -54,7 +54,4 @@
 
 #define WM8988_SYSCLK	0
 
-extern struct snd_soc_dai wm8988_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8988;
-
 #endif
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index a87046a..7823f92 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -36,9 +36,6 @@
 #include "wm8994.h"
 #include "wm_hubs.h"
 
-static struct snd_soc_codec *wm8994_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8994;
-
 struct fll_config {
 	int src;
 	int in;
@@ -71,7 +68,9 @@ struct wm8994_micdet {
 /* codec private data */
 struct wm8994_priv {
 	struct wm_hubs_data hubs;
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
+	struct snd_soc_codec *codec;
 	u16 reg_cache[WM8994_REG_CACHE_SIZE + 1];
 	int sysclk[2];
 	int sysclk_rate[2];
@@ -1901,8 +1900,6 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
-
-
 static void wm8994_set_drc(struct snd_soc_codec *codec, int drc)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -1941,7 +1938,7 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);	
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	int drc = wm8994_get_drc(kcontrol->id.name);
 	int value = ucontrol->value.integer.value[0];
@@ -2044,7 +2041,7 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);	
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 	int value = ucontrol->value.integer.value[0];
@@ -2066,7 +2063,7 @@ static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	struct wm8994_priv *wm8994 =snd_soc_codec_get_drvdata(codec);
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 
 	ucontrol->value.enumerated.item[0] = wm8994->retune_mobile_cfg[block];
@@ -2880,10 +2877,9 @@ static int wm8994_get_fll_config(struct fll_div *fll,
 	return 0;
 }
 
-static int wm8994_set_fll(struct snd_soc_dai *dai, int id, int src,
+static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			  unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int reg_offset, ret;
 	struct fll_div fll;
@@ -2994,8 +2990,15 @@ static int wm8994_set_fll(struct snd_soc_dai *dai, int id, int src,
 	return 0;
 }
 
+
 static int opclk_divs[] = { 10, 20, 30, 40, 55, 60, 80, 120, 160 };
 
+static int wm8994_set_fll(struct snd_soc_dai *dai, int id, int src,
+			  unsigned int freq_in, unsigned int freq_out)
+{
+	return _wm8994_set_fll(dai->codec, id, src, freq_in, freq_out);
+}
+
 static int wm8994_set_dai_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -3507,10 +3510,9 @@ static struct snd_soc_dai_ops wm8994_aif3_dai_ops = {
 	.set_tristate	= wm8994_set_tristate,
 };
 
-struct snd_soc_dai wm8994_dai[] = {
+static struct snd_soc_dai_driver wm8994_dai[] = {
 	{
-		.name = "WM8994 AIF1",
-		.id = 1,
+		.name = "wm8994-aif1",
 		.playback = {
 			.stream_name = "AIF1 Playback",
 			.channels_min = 2,
@@ -3528,8 +3530,7 @@ struct snd_soc_dai wm8994_dai[] = {
 		.ops = &wm8994_aif1_dai_ops,
 	},
 	{
-		.name = "WM8994 AIF2",
-		.id = 2,
+		.name = "wm8994-aif2",
 		.playback = {
 			.stream_name = "AIF2 Playback",
 			.channels_min = 2,
@@ -3547,8 +3548,7 @@ struct snd_soc_dai wm8994_dai[] = {
 		.ops = &wm8994_aif2_dai_ops,
 	},
 	{
-		.name = "WM8994 AIF3",
-		.id = 3,
+		.name = "wm8994-aif3",
 		.playback = {
 			.stream_name = "AIF3 Playback",
 			.channels_min = 2,
@@ -3566,20 +3566,17 @@ struct snd_soc_dai wm8994_dai[] = {
 		.ops = &wm8994_aif3_dai_ops,
 	}
 };
-EXPORT_SYMBOL_GPL(wm8994_dai);
 
 #ifdef CONFIG_PM
-static int wm8994_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8994_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		memcpy(&wm8994->fll_suspend[i], &wm8994->fll[i],
 		       sizeof(struct fll_config));
-		ret = wm8994_set_fll(&codec->dai[0], i + 1, 0, 0, 0);
+		ret = _wm8994_set_fll(codec, i + 1, 0, 0, 0);
 		if (ret < 0)
 			dev_warn(codec->dev, "Failed to stop FLL%d: %d\n",
 				 i + 1, ret);
@@ -3590,10 +3587,8 @@ static int wm8994_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int wm8994_resume(struct platform_device *pdev)
+static int wm8994_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	u16 *reg_cache = codec->reg_cache;
 	int i, ret;
@@ -3622,7 +3617,7 @@ static int wm8994_resume(struct platform_device *pdev)
 		if (!wm8994->fll_suspend[i].out)
 			continue;
 
-		ret = wm8994_set_fll(&codec->dai[0], i + 1,
+		ret = _wm8994_set_fll(codec, i + 1,
 				     wm8994->fll_suspend[i].src,
 				     wm8994->fll_suspend[i].in,
 				     wm8994->fll_suspend[i].out);
@@ -3640,7 +3635,7 @@ static int wm8994_resume(struct platform_device *pdev)
 
 static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = &wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->codec;
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	struct snd_kcontrol_new controls[] = {
 		SOC_ENUM_EXT("AIF1.1 EQ Mode",
@@ -3698,16 +3693,16 @@ static void wm8994_handle_retune_mobile_pdata(struct wm8994_priv *wm8994)
 	wm8994->retune_mobile_enum.max = wm8994->num_retune_mobile_texts;
 	wm8994->retune_mobile_enum.texts = wm8994->retune_mobile_texts;
 
-	ret = snd_soc_add_controls(&wm8994->codec, controls,
+	ret = snd_soc_add_controls(wm8994->codec, controls,
 				   ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(wm8994->codec.dev,
+		dev_err(wm8994->codec->dev,
 			"Failed to add ReTune Mobile controls: %d\n", ret);
 }
 
 static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 {
-	struct snd_soc_codec *codec = &wm8994->codec;
+	struct snd_soc_codec *codec = wm8994->codec;
 	struct wm8994_pdata *pdata = wm8994->pdata;
 	int ret, i;
 
@@ -3739,7 +3734,7 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		wm8994->drc_texts = kmalloc(sizeof(char *)
 					    * pdata->num_drc_cfgs, GFP_KERNEL);
 		if (!wm8994->drc_texts) {
-			dev_err(wm8994->codec.dev,
+			dev_err(wm8994->codec->dev,
 				"Failed to allocate %d DRC config texts\n",
 				pdata->num_drc_cfgs);
 			return;
@@ -3751,10 +3746,10 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 		wm8994->drc_enum.max = pdata->num_drc_cfgs;
 		wm8994->drc_enum.texts = wm8994->drc_texts;
 
-		ret = snd_soc_add_controls(&wm8994->codec, controls,
+		ret = snd_soc_add_controls(wm8994->codec, controls,
 					   ARRAY_SIZE(controls));
 		if (ret != 0)
-			dev_err(wm8994->codec.dev,
+			dev_err(wm8994->codec->dev,
 				"Failed to add DRC mode controls: %d\n", ret);
 
 		for (i = 0; i < WM8994_NUM_DRC; i++)
@@ -3767,62 +3762,10 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
 	if (pdata->num_retune_mobile_cfgs)
 		wm8994_handle_retune_mobile_pdata(wm8994);
 	else
-		snd_soc_add_controls(&wm8994->codec, wm8994_eq_controls,
+		snd_soc_add_controls(wm8994->codec, wm8994_eq_controls,
 				     ARRAY_SIZE(wm8994_eq_controls));
 }
 
-static int wm8994_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8994_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8994_codec;
-	codec = wm8994_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		return ret;
-	}
-
-	wm8994_handle_pdata(snd_soc_codec_get_drvdata(codec));
-
-	wm_hubs_add_analogue_controls(codec);
-	snd_soc_add_controls(codec, wm8994_snd_controls,
-			     ARRAY_SIZE(wm8994_snd_controls));
-	snd_soc_dapm_new_controls(codec, wm8994_dapm_widgets,
-				  ARRAY_SIZE(wm8994_dapm_widgets));
-	wm_hubs_add_analogue_routes(codec, 0, 0);
-	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
-static int wm8994_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8994 = {
-	.probe = 	wm8994_probe,
-	.remove = 	wm8994_remove,
-	.suspend = 	wm8994_suspend,
-	.resume =	wm8994_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8994);
-
 /**
  * wm8994_mic_detect - Enable microphone detection via the WM8994 IRQ
  *
@@ -3881,7 +3824,7 @@ EXPORT_SYMBOL_GPL(wm8994_mic_detect);
 static irqreturn_t wm8994_mic_irq(int irq, void *data)
 {
 	struct wm8994_priv *priv = data;
-	struct snd_soc_codec *codec = &priv->codec;
+	struct snd_soc_codec *codec = priv->codec;
 	int reg;
 	int report;
 
@@ -3913,47 +3856,20 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int wm8994_codec_probe(struct platform_device *pdev)
+static int wm8994_codec_probe(struct snd_soc_codec *codec)
 {
-	int ret;
 	struct wm8994_priv *wm8994;
-	struct snd_soc_codec *codec;
-	int i;
-	u16 rev;
+	int ret, i, rev;
 
-	if (wm8994_codec) {
-		dev_err(&pdev->dev, "Another WM8994 is registered\n");
-		return -EINVAL;
-	}
+	codec->control_data = dev_get_drvdata(codec->dev->parent);
 
 	wm8994 = kzalloc(sizeof(struct wm8994_priv), GFP_KERNEL);
-	if (!wm8994) {
-		dev_err(&pdev->dev, "Failed to allocate private data\n");
+	if (wm8994 == NULL)
 		return -ENOMEM;
-	}
-
-	codec = &wm8994->codec;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
 	snd_soc_codec_set_drvdata(codec, wm8994);
-	codec->control_data = dev_get_drvdata(pdev->dev.parent);
-	codec->name = "WM8994";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8994_read;
-	codec->write = wm8994_write;
-	codec->readable_register = wm8994_readable;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8994_set_bias_level;
-	codec->dai = &wm8994_dai[0];
-	codec->num_dai = 3;
-	codec->reg_cache_size = WM8994_MAX_REGISTER;
-	codec->reg_cache = &wm8994->reg_cache;
-	codec->dev = &pdev->dev;
-
-	wm8994->pdata = pdev->dev.parent->platform_data;
+
+	wm8994->pdata = dev_get_platdata(codec->dev->parent);
+	wm8994->codec = codec;
 
 	/* Fill the cache with physical values we inherited; don't reset */
 	ret = wm8994_bulk_read(codec->control_data, 0,
@@ -3989,25 +3905,25 @@ static int wm8994_codec_probe(struct platform_device *pdev)
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC1_DET,
 				 wm8994_mic_irq, "Mic 1 detect", wm8994);
 	if (ret != 0)
-		dev_warn(&pdev->dev,
+		dev_warn(codec->dev,
 			 "Failed to request Mic1 detect IRQ: %d\n", ret);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT,
 				 wm8994_mic_irq, "Mic 1 short", wm8994);
 	if (ret != 0)
-		dev_warn(&pdev->dev,
+		dev_warn(codec->dev,
 			 "Failed to request Mic1 short IRQ: %d\n", ret);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC2_DET,
 				 wm8994_mic_irq, "Mic 2 detect", wm8994);
 	if (ret != 0)
-		dev_warn(&pdev->dev,
+		dev_warn(codec->dev,
 			 "Failed to request Mic2 detect IRQ: %d\n", ret);
 
 	ret = wm8994_request_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT,
 				 wm8994_mic_irq, "Mic 2 short", wm8994);
 	if (ret != 0)
-		dev_warn(&pdev->dev,
+		dev_warn(codec->dev,
 			 "Failed to request Mic2 short IRQ: %d\n", ret);
 
 	/* Remember if AIFnLRCLK is configured as a GPIO.  This should be
@@ -4038,13 +3954,8 @@ static int wm8994_codec_probe(struct platform_device *pdev)
 		wm8994->lrclk_shared[1] = 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(wm8994_dai); i++)
-		wm8994_dai[i].dev = codec->dev;
-
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	wm8994_codec = codec;
-
 	/* Latch volume updates (right only; we always do left then right). */
 	snd_soc_update_bits(codec, WM8994_AIF1_DAC1_RIGHT_VOLUME,
 			    WM8994_AIF1DAC1_VU, WM8994_AIF1DAC1_VU);
@@ -4081,24 +3992,18 @@ static int wm8994_codec_probe(struct platform_device *pdev)
 
 	wm8994_update_class_w(codec);
 
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_irq;
-	}
-
-	ret = snd_soc_register_dais(wm8994_dai, ARRAY_SIZE(wm8994_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		goto err_codec;
-	}
+	wm8994_handle_pdata(wm8994);
 
-	platform_set_drvdata(pdev, wm8994);
+	wm_hubs_add_analogue_controls(codec);
+	snd_soc_add_controls(codec, wm8994_snd_controls,
+			     ARRAY_SIZE(wm8994_snd_controls));
+	snd_soc_dapm_new_controls(codec, wm8994_dapm_widgets,
+				  ARRAY_SIZE(wm8994_dapm_widgets));
+	wm_hubs_add_analogue_routes(codec, 0, 0);
+	snd_soc_dapm_add_routes(codec, intercon, ARRAY_SIZE(intercon));
 
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_irq:
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET, wm8994);
@@ -4109,31 +4014,50 @@ err:
 	return ret;
 }
 
-static int __devexit wm8994_codec_remove(struct platform_device *pdev)
+static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 {
-	struct wm8994_priv *wm8994 = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = &wm8994->codec;
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	wm8994_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dais(wm8994_dai, ARRAY_SIZE(wm8994_dai));
-	snd_soc_unregister_codec(&wm8994->codec);
+
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_SHRT, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC2_DET, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_SHRT, wm8994);
 	wm8994_free_irq(codec->control_data, WM8994_IRQ_MIC1_DET, wm8994);
 	kfree(wm8994);
-	wm8994_codec = NULL;
 
 	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
+	.probe =	wm8994_codec_probe,
+	.remove =	wm8994_codec_remove,
+	.suspend =	wm8994_suspend,
+	.resume =	wm8994_resume,
+	.read = wm8994_read,
+	.write = wm8994_write,
+	.set_bias_level = wm8994_set_bias_level,
+};
+
+static int __devinit wm8994_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm8994,
+			wm8994_dai, ARRAY_SIZE(wm8994_dai));
+}
+
+static int __devexit wm8994_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
 static struct platform_driver wm8994_codec_driver = {
 	.driver = {
 		   .name = "wm8994-codec",
 		   .owner = THIS_MODULE,
 		   },
-	.probe = wm8994_codec_probe,
-	.remove = __devexit_p(wm8994_codec_remove),
+	.probe = wm8994_probe,
+	.remove = __devexit_p(wm8994_remove),
 };
 
 static __init int wm8994_init(void)
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 2e0ca67..d8dce26 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -11,9 +11,6 @@
 
 #include <sound/soc.h>
 
-extern struct snd_soc_codec_device soc_codec_dev_wm8994;
-extern struct snd_soc_dai wm8994_dai[];
-
 /* Sources for AIF1/2 SYSCLK - use with set_dai_sysclk() */
 #define WM8994_SYSCLK_MCLK1 1
 #define WM8994_SYSCLK_MCLK2 2
-- 
1.7.0.4
