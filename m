From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 14/16] ASoC: multi-component - Wolfson WM90xx
	CODECs
Date: Fri, 25 Jun 2010 18:53:01 +0100
Message-ID: <1277488383-31287-15-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C84DE103A23
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:38 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166789wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:38 -0700 (PDT)
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

Moved Wolfson WM90xx CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm9081.c |  205 +++++++++++++--------------------------------
 sound/soc/codecs/wm9081.h |    4 +-
 sound/soc/codecs/wm9090.c |  182 +++++++++++++---------------------------
 sound/soc/codecs/wm9090.h |    2 +-
 4 files changed, 123 insertions(+), 270 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 13186fb..7df7fd6 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -156,7 +156,8 @@ static struct {
 };
 
 struct wm9081_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[WM9081_MAX_REGISTER + 1];
 	int sysclk_source;
 	int mclk_rate;
@@ -1212,7 +1213,7 @@ static struct snd_soc_dai_ops wm9081_dai_ops = {
 /* We report two channels because the CODEC processes a stereo signal, even
  * though it is only capable of handling a mono output.
  */
-struct snd_soc_dai wm9081_dai = {
+struct snd_soc_dai_driver wm9081_dai = {
 	.name = "WM9081",
 	.playback = {
 		.stream_name = "HiFi Playback",
@@ -1225,32 +1226,41 @@ struct snd_soc_dai wm9081_dai = {
 };
 EXPORT_SYMBOL_GPL(wm9081_dai);
 
-
-static struct snd_soc_codec *wm9081_codec;
-
-static int wm9081_probe(struct platform_device *pdev)
+static int wm9081_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct wm9081_priv *wm9081;
-	int ret = 0;
+	struct wm9081_priv *wm9081 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+	u16 reg;
 
-	if (wm9081_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
+	codec->control_data = wm9081->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm9081->control_type);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm9081_codec;
-	codec = wm9081_codec;
-	wm9081 = snd_soc_codec_get_drvdata(codec);
+	reg = snd_soc_read(codec, WM9081_SOFTWARE_RESET);
+	if (reg != 0x9081) {
+		dev_err(codec->dev, "Device is not a WM9081: ID=0x%x\n", reg);
+		ret = -EINVAL;
+		return ret;
+	}
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = wm9081_reset(codec);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+		dev_err(codec->dev, "Failed to issue reset\n");
+		return ret;
 	}
 
+	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
+	/* Enable zero cross by default */
+	reg = snd_soc_read(codec, WM9081_ANALOGUE_LINEOUT);
+	snd_soc_write(codec, WM9081_ANALOGUE_LINEOUT, reg | WM9081_LINEOUTZC);
+	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_PGA);
+	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_PGA,
+		     reg | WM9081_SPKPGAZC);
+
 	snd_soc_add_controls(codec, wm9081_snd_controls,
 			     ARRAY_SIZE(wm9081_snd_controls));
 	if (!wm9081->retune) {
@@ -1265,40 +1275,28 @@ static int wm9081_probe(struct platform_device *pdev)
 	snd_soc_dapm_add_routes(codec, audio_paths, ARRAY_SIZE(audio_paths));
 
 	return ret;
-
-pcm_err:
-	return ret;
 }
 
-static int wm9081_remove(struct platform_device *pdev)
+static int wm9081_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	wm9081_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int wm9081_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm9081_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm9081_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm9081_resume(struct platform_device *pdev)
+static int wm9081_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	u16 *reg_cache = codec->reg_cache;
 	int i;
 
-	for (i = 0; i < codec->reg_cache_size; i++) {
+	for (i = 0; i < codec->driver->reg_cache_size; i++) {
 		if (i == WM9081_SOFTWARE_RESET)
 			continue;
 
@@ -1314,132 +1312,46 @@ static int wm9081_resume(struct platform_device *pdev)
 #define wm9081_resume NULL
 #endif
 
-struct snd_soc_codec_device soc_codec_dev_wm9081 = {
+struct snd_soc_codec_driver soc_codec_dev_wm9081 = {
+	.name = "wm9081",
+	.owner = THIS_MODULE,
 	.probe = 	wm9081_probe,
 	.remove = 	wm9081_remove,
-	.suspend =	wm9081_suspend,
+	.suspend = 	wm9081_suspend,
 	.resume =	wm9081_resume,
+	.set_bias_level = wm9081_set_bias_level,
+	.reg_cache_size = sizeof(wm9081_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm9081_reg_defaults,
+	.volatile_register = wm9081_volatile_register,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9081);
 
-static int wm9081_register(struct wm9081_priv *wm9081,
-			   enum snd_soc_control_type control)
-{
-	struct snd_soc_codec *codec = &wm9081->codec;
-	int ret;
-	u16 reg;
-
-	if (wm9081_codec) {
-		dev_err(codec->dev, "Another WM9081 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm9081);
-	codec->name = "WM9081";
-	codec->owner = THIS_MODULE;
-	codec->dai = &wm9081_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm9081->reg_cache);
-	codec->reg_cache = &wm9081->reg_cache;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm9081_set_bias_level;
-	codec->volatile_register = wm9081_volatile_register;
-
-	memcpy(codec->reg_cache, wm9081_reg_defaults,
-	       sizeof(wm9081_reg_defaults));
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
-
-	reg = snd_soc_read(codec, WM9081_SOFTWARE_RESET);
-	if (reg != 0x9081) {
-		dev_err(codec->dev, "Device is not a WM9081: ID=0x%x\n", reg);
-		ret = -EINVAL;
-		goto err;
-	}
-
-	ret = wm9081_reset(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
-		return ret;
-	}
-
-	wm9081_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* Enable zero cross by default */
-	reg = snd_soc_read(codec, WM9081_ANALOGUE_LINEOUT);
-	snd_soc_write(codec, WM9081_ANALOGUE_LINEOUT, reg | WM9081_LINEOUTZC);
-	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_PGA);
-	snd_soc_write(codec, WM9081_ANALOGUE_SPEAKER_PGA,
-		     reg | WM9081_SPKPGAZC);
-
-	wm9081_dai.dev = codec->dev;
-
-	wm9081_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		return ret;
-	}
-
-	ret = snd_soc_register_dai(&wm9081_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		return ret;
-	}
-
-	return 0;
-
-err:
-	kfree(wm9081);
-	return ret;
-}
-
-static void wm9081_unregister(struct wm9081_priv *wm9081)
-{
-	wm9081_set_bias_level(&wm9081->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&wm9081_dai);
-	snd_soc_unregister_codec(&wm9081->codec);
-	kfree(wm9081);
-	wm9081_codec = NULL;
-}
-
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm9081_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm9081_priv *wm9081;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm9081 = kzalloc(sizeof(struct wm9081_priv), GFP_KERNEL);
 	if (wm9081 == NULL)
 		return -ENOMEM;
 
-	codec = &wm9081->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-	wm9081->retune = i2c->dev.platform_data;
-
 	i2c_set_clientdata(i2c, wm9081);
-	codec->control_data = i2c;
+	wm9081->control_data = i2c;
 
-	codec->dev = &i2c->dev;
-
-	return wm9081_register(wm9081, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm9081, &wm9081_dai, 1);
+	if (ret < 0)
+		kfree(wm9081);
+	return ret;
 }
 
 static __devexit int wm9081_i2c_remove(struct i2c_client *client)
 {
-	struct wm9081_priv *wm9081 = i2c_get_clientdata(client);
-	wm9081_unregister(wm9081);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1458,24 +1370,27 @@ static struct i2c_driver wm9081_i2c_driver = {
 	.remove =   __devexit_p(wm9081_i2c_remove),
 	.id_table = wm9081_i2c_id,
 };
+#endif
 
 static int __init wm9081_modinit(void)
 {
-	int ret;
-
+	int ret = 0;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm9081_i2c_driver);
 	if (ret != 0) {
 		printk(KERN_ERR "Failed to register WM9081 I2C driver: %d\n",
 		       ret);
 	}
-
+#endif
 	return ret;
 }
 module_init(wm9081_modinit);
 
 static void __exit wm9081_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm9081_i2c_driver);
+#endif
 }
 module_exit(wm9081_exit);
 
diff --git a/sound/soc/codecs/wm9081.h b/sound/soc/codecs/wm9081.h
index 42d3bc7..bb4a78b 100644
--- a/sound/soc/codecs/wm9081.h
+++ b/sound/soc/codecs/wm9081.h
@@ -15,8 +15,8 @@
 
 #include <sound/soc.h>
 
-extern struct snd_soc_dai wm9081_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm9081;
+extern struct snd_soc_dai_driver wm9081_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm9081;
 
 /*
  * SYSCLK sources
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index 1592250..4ced9d3 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -34,8 +34,6 @@
 
 #include "wm9090.h"
 
-static struct snd_soc_codec *wm9090_codec;
-
 static const u16 wm9090_reg_defaults[] = {
 	0x9093,     /* R0   - Software Reset */
 	0x0006,     /* R1   - Power Management (1) */
@@ -142,15 +140,10 @@ static const u16 wm9090_reg_defaults[] = {
 
 /* This struct is used to save the context */
 struct wm9090_priv {
-	/* We're not really registering as a CODEC since ASoC core
-	 * does not yet support multiple CODECs but having the CODEC
-	 * structure means we can reuse some of the ASoC core
-	 * features.
-	 */
-	struct snd_soc_codec codec;
 	struct mutex mutex;
 	u16 reg_cache[WM9090_MAX_REGISTER + 1];
 	struct wm9090_platform_data pdata;
+	void *control_data;
 };
 
 static int wm9090_volatile(unsigned int reg)
@@ -523,7 +516,7 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Restore the register cache */
-			for (i = 1; i < codec->reg_cache_size; i++) {
+			for (i = 1; i < codec->driver->reg_cache_size; i++) {
 				if (reg_cache[i] == wm9090_reg_defaults[i])
 					continue;
 				if (wm9090_volatile(i))
@@ -556,51 +549,67 @@ static int wm9090_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm9090_probe(struct platform_device *pdev)
+static int wm9090_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
+	struct wm9090_priv *wm9090 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	if (wm9090_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
+	codec->control_data = wm9090->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
-	socdev->card->codec = wm9090_codec;
-	codec = wm9090_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+	ret = snd_soc_read(codec, WM9090_SOFTWARE_RESET);
+	if (ret < 0)
+		return ret;
+	if (ret != wm9090_reg_defaults[WM9090_SOFTWARE_RESET]) {
+		dev_err(codec->dev, "Device is not a WM9090, ID=%x\n", ret);
+		return -EINVAL;
 	}
 
+	ret = snd_soc_write(codec, WM9090_SOFTWARE_RESET, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Configure some defaults; they will be written out when we
+	 * bring the bias up.
+	 */
+	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_A_VOLUME] |= WM9090_IN1_VU
+		| WM9090_IN1A_ZC;
+	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_B_VOLUME] |= WM9090_IN1_VU
+		| WM9090_IN1B_ZC;
+	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_A_VOLUME] |= WM9090_IN2_VU
+		| WM9090_IN2A_ZC;
+	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_B_VOLUME] |= WM9090_IN2_VU
+		| WM9090_IN2B_ZC;
+	wm9090->reg_cache[WM9090_SPEAKER_VOLUME_LEFT] |=
+		WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC;
+	wm9090->reg_cache[WM9090_LEFT_OUTPUT_VOLUME] |=
+		WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC;
+	wm9090->reg_cache[WM9090_RIGHT_OUTPUT_VOLUME] |=
+		WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC;
+
+	wm9090->reg_cache[WM9090_CLOCKING_1] |= WM9090_TOCLK_ENA;
+
+	wm9090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	wm9090_add_controls(codec);
 
 	return 0;
-
-pcm_err:
-	return ret;
 }
 
 #ifdef CONFIG_PM
-static int wm9090_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm9090_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm9090_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm9090_resume(struct platform_device *pdev)
+static int wm9090_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm9090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -610,21 +619,25 @@ static int wm9090_resume(struct platform_device *pdev)
 #define wm9090_resume NULL
 #endif
 
-static int wm9090_remove(struct platform_device *pdev)
+static int wm9090_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+	wm9090_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm9090 = {
+struct snd_soc_codec_driver soc_codec_dev_wm9090 = {
+	.name = "WM9090",
+	.owner = THIS_MODULE,
 	.probe = 	wm9090_probe,
 	.remove = 	wm9090_remove,
 	.suspend = 	wm9090_suspend,
 	.resume =	wm9090_resume,
+	.set_bias_level = wm9090_set_bias_level,
+	.reg_cache_size = (WM9090_MAX_REGISTER + 1),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm9090_reg_defaults,
+	.volatile_register = wm9090_volatile,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9090);
 
@@ -632,7 +645,6 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
 	struct wm9090_priv *wm9090;
-	struct snd_soc_codec *codec;
 	int ret;
 
 	wm9090 = kzalloc(sizeof(*wm9090), GFP_KERNEL);
@@ -640,102 +652,28 @@ static int wm9090_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Can not allocate memory\n");
 		return -ENOMEM;
 	}
-	codec = &wm9090->codec;
 
 	if (i2c->dev.platform_data)
 		memcpy(&wm9090->pdata, i2c->dev.platform_data,
 		       sizeof(wm9090->pdata));
 
-	wm9090_codec = codec;
-
 	i2c_set_clientdata(i2c, wm9090);
+	wm9090->control_data = i2c;
+	mutex_init(&wm9090->mutex);
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->control_data = i2c;
-	snd_soc_codec_set_drvdata(codec, wm9090);
-	codec->dev = &i2c->dev;
-	codec->name = "WM9090";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm9090_set_bias_level,
-	codec->reg_cache_size = WM9090_MAX_REGISTER + 1;
-	codec->reg_cache = &wm9090->reg_cache;
-	codec->volatile_register = wm9090_volatile;
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
-	memcpy(&wm9090->reg_cache, wm9090_reg_defaults,
-	       sizeof(wm9090->reg_cache));
-
-	ret = snd_soc_read(codec, WM9090_SOFTWARE_RESET);
-	if (ret < 0)
-		goto err;
-	if (ret != wm9090_reg_defaults[WM9090_SOFTWARE_RESET]) {
-		dev_err(&i2c->dev, "Device is not a WM9090, ID=%x\n", ret);
-		ret = -EINVAL;
-		goto err;
-	}
-
-	ret = snd_soc_write(codec, WM9090_SOFTWARE_RESET, 0);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_wm9090,  NULL, 0);
 	if (ret < 0)
-		goto err;
-
-	/* Configure some defaults; they will be written out when we
-	 * bring the bias up.
-	 */
-	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_A_VOLUME] |= WM9090_IN1_VU
-		| WM9090_IN1A_ZC;
-	wm9090->reg_cache[WM9090_IN1_LINE_INPUT_B_VOLUME] |= WM9090_IN1_VU
-		| WM9090_IN1B_ZC;
-	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_A_VOLUME] |= WM9090_IN2_VU
-		| WM9090_IN2A_ZC;
-	wm9090->reg_cache[WM9090_IN2_LINE_INPUT_B_VOLUME] |= WM9090_IN2_VU
-		| WM9090_IN2B_ZC;
-	wm9090->reg_cache[WM9090_SPEAKER_VOLUME_LEFT] |=
-		WM9090_SPKOUT_VU | WM9090_SPKOUTL_ZC;
-	wm9090->reg_cache[WM9090_LEFT_OUTPUT_VOLUME] |= 
-		WM9090_HPOUT1_VU | WM9090_HPOUT1L_ZC;
-	wm9090->reg_cache[WM9090_RIGHT_OUTPUT_VOLUME] |=
-		WM9090_HPOUT1_VU | WM9090_HPOUT1R_ZC;
-
-	wm9090->reg_cache[WM9090_CLOCKING_1] |= WM9090_TOCLK_ENA;
-
-	wm9090_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
-		goto err_bias;
-	}
-
-	return 0;
-
-err_bias:
-	wm9090_set_bias_level(codec, SND_SOC_BIAS_OFF);
-err:
-	kfree(wm9090);
-	i2c_set_clientdata(i2c, NULL);
-	wm9090_codec = NULL;
-
+		kfree(wm9090);
 	return ret;
 }
 
 static int wm9090_i2c_remove(struct i2c_client *i2c)
 {
 	struct wm9090_priv *wm9090 = i2c_get_clientdata(i2c);
-	struct snd_soc_codec *codec = &wm9090->codec;
 
-	snd_soc_unregister_codec(codec);
-	wm9090_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_unregister_codec(&i2c->dev, i2c->addr);
 	kfree(wm9090);
-	wm9090_codec = NULL;
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm9090.h b/sound/soc/codecs/wm9090.h
index b08eab9..bb5c375 100644
--- a/sound/soc/codecs/wm9090.h
+++ b/sound/soc/codecs/wm9090.h
@@ -23,7 +23,7 @@
 #ifndef __WM9090_H
 #define __WM9090_H
 
-extern struct snd_soc_codec_device soc_codec_dev_wm9090;
+extern struct snd_soc_codec_driver soc_codec_dev_wm9090;
 
 /*
  * Register values.
-- 
1.7.0.4
