From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Convert WM8903 driver to register at
	I2C probe time
Date: Wed, 10 Dec 2008 20:01:14 +0000
Message-ID: <1228939275-7768-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95F66243CD
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The driver now registers the codec and DAI when probed as an I2C device.
Also convert the driver to use a single dynamic allocation to simplify
error handling.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |  230 +++++++++++++++++++--------------------------
 sound/soc/codecs/wm8903.h |    5 -
 2 files changed, 97 insertions(+), 138 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b1f5cf7..c80968f 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -33,19 +33,6 @@
 
 #include "wm8903.h"
 
-struct wm8903_priv {
-	int sysclk;
-
-	/* Reference counts */
-	int charge_pump_users;
-	int class_w_users;
-	int playback_active;
-	int capture_active;
-
-	struct snd_pcm_substream *master_substream;
-	struct snd_pcm_substream *slave_substream;
-};
-
 /* Register defaults at reset */
 static u16 wm8903_reg_defaults[] = {
 	0x8903,     /* R0   - SW Reset and ID */
@@ -223,6 +210,23 @@ static u16 wm8903_reg_defaults[] = {
 	0x0000,     /* R172 - Analogue Output Bias 0 */
 };
 
+struct wm8903_priv {
+	struct snd_soc_codec codec;
+	u16 reg_cache[ARRAY_SIZE(wm8903_reg_defaults)];
+
+	int sysclk;
+
+	/* Reference counts */
+	int charge_pump_users;
+	int class_w_users;
+	int playback_active;
+	int capture_active;
+
+	struct snd_pcm_substream *master_substream;
+	struct snd_pcm_substream *slave_substream;
+};
+
+
 static unsigned int wm8903_read_reg_cache(struct snd_soc_codec *codec,
 						 unsigned int reg)
 {
@@ -360,6 +364,8 @@ static void wm8903_sync_reg_cache(struct snd_soc_codec *codec, u16 *cache)
 static void wm8903_reset(struct snd_soc_codec *codec)
 {
 	wm8903_write(codec, WM8903_SW_RESET_AND_ID, 0);
+	memcpy(codec->reg_cache, wm8903_reg_defaults,
+	       sizeof(wm8903_reg_defaults));
 }
 
 #define WM8903_OUTPUT_SHORT 0x8
@@ -1563,39 +1569,48 @@ static int wm8903_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the WM8903 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8903_init(struct snd_soc_device *socdev)
+static struct snd_soc_codec *wm8903_codec;
+
+static int wm8903_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec = socdev->codec;
-	struct i2c_client *i2c = codec->control_data;
-	int ret = 0;
+	struct wm8903_priv *wm8903;
+	struct snd_soc_codec *codec;
+	int ret;
 	u16 val;
 
-	val = wm8903_hw_read(codec, WM8903_SW_RESET_AND_ID);
-	if (val != wm8903_reg_defaults[WM8903_SW_RESET_AND_ID]) {
-		dev_err(&i2c->dev,
-			"Device with ID register %x is not a WM8903\n", val);
-		return -ENODEV;
-	}
+	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
+	if (wm8903 == NULL)
+		return -ENOMEM;
 
+	codec = &wm8903->codec;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->dev = &i2c->dev;
 	codec->name = "WM8903";
 	codec->owner = THIS_MODULE;
 	codec->read = wm8903_read;
 	codec->write = wm8903_write;
+	codec->hw_write = (hw_write_t)i2c_master_send;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8903_set_bias_level;
 	codec->dai = &wm8903_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8903_reg_defaults);
-	codec->reg_cache = kmemdup(wm8903_reg_defaults,
-				   sizeof(wm8903_reg_defaults),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		dev_err(&i2c->dev, "Failed to allocate register cache\n");
-		return -ENOMEM;
+	codec->reg_cache_size = ARRAY_SIZE(wm8903->reg_cache);
+	codec->reg_cache = &wm8903->reg_cache[0];
+	codec->private_data = wm8903;
+
+	i2c_set_clientdata(i2c, codec);
+	codec->control_data = i2c;
+
+	val = wm8903_hw_read(codec, WM8903_SW_RESET_AND_ID);
+	if (val != wm8903_reg_defaults[WM8903_SW_RESET_AND_ID]) {
+		dev_err(&i2c->dev,
+			"Device with ID register %x is not a WM8903\n", val);
+		return -ENODEV;
 	}
 
 	val = wm8903_read(codec, WM8903_REVISION_NUMBER);
@@ -1604,13 +1619,6 @@ static int wm8903_init(struct snd_soc_device *socdev)
 
 	wm8903_reset(codec);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&i2c->dev, "failed to create pcms\n");
-		goto pcm_err;
-	}
-
 	/* SYSCLK is required for pretty much anything */
 	wm8903_write(codec, WM8903_CLOCK_RATES_2, WM8903_CLK_SYS_ENA);
 
@@ -1648,47 +1656,45 @@ static int wm8903_init(struct snd_soc_device *socdev)
 	val |= WM8903_DAC_MUTEMODE;
 	wm8903_write(codec, WM8903_DAC_DIGITAL_1, val);
 
-	wm8903_add_controls(codec);
-	wm8903_add_widgets(codec);
-	ret = snd_soc_init_card(socdev);
-	if (ret < 0) {
-		dev_err(&i2c->dev, "wm8903: failed to register card\n");
-		goto card_err;
+	wm8903_dai.dev = &i2c->dev;
+	wm8903_codec = codec;
+
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
+
+	ret = snd_soc_register_dai(&wm8903_dai);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register DAI: %d\n", ret);
+		goto err_codec;
 	}
 
 	return ret;
 
-card_err:
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-pcm_err:
-	kfree(codec->reg_cache);
+err_codec:
+	snd_soc_unregister_codec(codec);
+err:
+	wm8903_codec = NULL;
+	kfree(wm8903);
 	return ret;
 }
 
-static struct snd_soc_device *wm8903_socdev;
-
-static int wm8903_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int wm8903_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_device *socdev = wm8903_socdev;
-	struct snd_soc_codec *codec = socdev->codec;
-	int ret;
+	struct snd_soc_codec *codec = i2c_get_clientdata(client);
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	snd_soc_unregister_dai(&wm8903_dai);
+	snd_soc_unregister_codec(codec);
 
-	ret = wm8903_init(socdev);
-	if (ret < 0)
-		dev_err(&i2c->dev, "Device initialisation failed\n");
+	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	return ret;
-}
+	kfree(codec->private_data);
+
+	wm8903_codec = NULL;
+	wm8903_dai.dev = NULL;
 
-static int wm8903_i2c_remove(struct i2c_client *client)
-{
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
 	return 0;
 }
 
@@ -1712,75 +1718,37 @@ static struct i2c_driver wm8903_i2c_driver = {
 static int wm8903_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct wm8903_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct wm8903_priv *wm8903;
-	struct i2c_board_info board_info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *i2c_client;
 	int ret = 0;
 
-	setup = socdev->codec_data;
-
-	if (!setup->i2c_address) {
-		dev_err(&pdev->dev, "No codec address provided\n");
-		return -ENODEV;
+	if (!wm8903_codec) {
+		dev_err(&pdev->dev, "I2C device not yet probed\n");
+		goto err;
 	}
 
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
+	socdev->codec = wm8903_codec;
 
-	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
-	if (wm8903 == NULL) {
-		ret = -ENOMEM;
-		goto err_codec;
+	/* register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create pcms\n");
+		goto err;
 	}
 
-	codec->private_data = wm8903;
-	socdev->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	wm8903_add_controls(socdev->codec);
+	wm8903_add_widgets(socdev->codec);
 
-	wm8903_socdev = socdev;
-
-	codec->hw_write = (hw_write_t)i2c_master_send;
-	ret = i2c_add_driver(&wm8903_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		goto err_priv;
-	} else {
-		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, "wm8903", I2C_NAME_SIZE);
-		board_info.addr = setup->i2c_address;
-
-		adapter = i2c_get_adapter(setup->i2c_bus);
-		if (!adapter) {
-			dev_err(&pdev->dev, "Can't get I2C bus %d\n",
-				setup->i2c_bus);
-			ret = -ENODEV;
-			goto err_adapter;
-		}
-
-		i2c_client = i2c_new_device(adapter, &board_info);
-		i2c_put_adapter(adapter);
-		if (i2c_client == NULL) {
-			dev_err(&pdev->dev,
-				"I2C driver registration failed\n");
-			ret = -ENODEV;
-			goto err_adapter;
-		}
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "wm8903: failed to register card\n");
+		goto card_err;
 	}
 
 	return ret;
 
-err_adapter:
-	i2c_del_driver(&wm8903_i2c_driver);
-err_priv:
-	kfree(codec->private_data);
-err_codec:
-	kfree(codec);
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+err:
 	return ret;
 }
 
@@ -1795,10 +1763,6 @@ static int wm8903_remove(struct platform_device *pdev)
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-	i2c_unregister_device(socdev->codec->control_data);
-	i2c_del_driver(&wm8903_i2c_driver);
-	kfree(codec->private_data);
-	kfree(codec);
 
 	return 0;
 }
@@ -1813,13 +1777,13 @@ EXPORT_SYMBOL_GPL(soc_codec_dev_wm8903);
 
 static int __init wm8903_modinit(void)
 {
-	return snd_soc_register_dai(&wm8903_dai);
+	return i2c_add_driver(&wm8903_i2c_driver);
 }
 module_init(wm8903_modinit);
 
 static void __exit wm8903_exit(void)
 {
-	snd_soc_unregister_dai(&wm8903_dai);
+	i2c_del_driver(&wm8903_i2c_driver);
 }
 module_exit(wm8903_exit);
 
diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index cec622f..0ea27e2 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -18,11 +18,6 @@
 extern struct snd_soc_dai wm8903_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8903;
 
-struct wm8903_setup_data {
-	int i2c_bus;
-	int i2c_address;
-};
-
 #define WM8903_MCLK_DIV_2 1
 #define WM8903_CLK_SYS    2
 #define WM8903_BCLK       3
-- 
1.5.6.5
