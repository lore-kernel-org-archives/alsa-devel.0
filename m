From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: Convert WM8900 to do more work at
	I2C probe time
Date: Wed, 10 Dec 2008 20:01:13 +0000
Message-ID: <1228939275-7768-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 29DD7243BF
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Redo the instantiation of the WM8900 to do most of the initialisation
work when the I2C driver probes rather than when the ASoC device is
instantiated, registering the codec with the ASoC core when done.

Also move all dynamic allocations into a single kmalloc() to simplify
error handling and rename the I2C driver to make output more sensible.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8900.c |  159 +++++++++++++++++++++++----------------------
 sound/soc/codecs/wm8900.h |    7 --
 2 files changed, 81 insertions(+), 85 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index ebf58fb..6767de1 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -138,6 +138,10 @@
 struct snd_soc_codec_device soc_codec_dev_wm8900;
 
 struct wm8900_priv {
+	struct snd_soc_codec codec;
+
+	u16 reg_cache[WM8900_MAXREG];
+
 	u32 fll_in; /* FLL input frequency */
 	u32 fll_out; /* FLL output frequency */
 };
@@ -1282,16 +1286,28 @@ static int wm8900_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the WM8900 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int wm8900_init(struct snd_soc_device *socdev)
+static struct snd_soc_codec *wm8900_codec;
+
+static int wm8900_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec = socdev->codec;
-	int ret = 0;
+	struct wm8900_priv *wm8900;
+	struct snd_soc_codec *codec;
 	unsigned int reg;
-	struct i2c_client *i2c_client = socdev->codec->control_data;
+	int ret;
+
+	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
+	if (wm8900 == NULL)
+		return -ENOMEM;
+
+	codec = &wm8900->codec;
+	codec->private_data = wm8900;
+	codec->reg_cache = &wm8900->reg_cache[0];
+	codec->reg_cache_size = WM8900_MAXREG;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
 
 	codec->name = "WM8900";
 	codec->owner = THIS_MODULE;
@@ -1299,33 +1315,28 @@ static int wm8900_init(struct snd_soc_device *socdev)
 	codec->write = wm8900_write;
 	codec->dai = &wm8900_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = WM8900_MAXREG;
-	codec->reg_cache = kmemdup(wm8900_reg_defaults,
-				   sizeof(wm8900_reg_defaults), GFP_KERNEL);
-
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->control_data = i2c;
+	codec->set_bias_level = wm8900_set_bias_level;
+	codec->dev = &i2c->dev;
 
 	reg = wm8900_read(codec, WM8900_REG_ID);
 	if (reg != 0x8900) {
-		dev_err(&i2c_client->dev, "Device is not a WM8900 - ID %x\n",
-			reg);
-		return -ENODEV;
-	}
-
-	codec->private_data = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
-	if (codec->private_data == NULL) {
-		ret = -ENOMEM;
-		goto priv_err;
+		dev_err(&i2c->dev, "Device is not a WM8900 - ID %x\n", reg);
+		ret = -ENODEV;
+		goto err;
 	}
 
 	/* Read back from the chip */
 	reg = wm8900_chip_read(codec, WM8900_REG_POWER1);
 	reg = (reg >> 12) & 0xf;
-	dev_info(&i2c_client->dev, "WM8900 revision %d\n", reg);
+	dev_info(&i2c->dev, "WM8900 revision %d\n", reg);
 
 	wm8900_reset(codec);
 
+	/* Turn the chip on */
+	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	/* Latch the volume update bits */
 	wm8900_write(codec, WM8900_REG_LINVOL,
 		     wm8900_read(codec, WM8900_REG_LINVOL) | 0x100);
@@ -1351,52 +1362,43 @@ static int wm8900_init(struct snd_soc_device *socdev)
 	/* Set the DAC and mixer output bias */
 	wm8900_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
 
-	/* Register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Failed to register new PCMs\n");
-		goto pcm_err;
-	}
+	wm8900_dai.dev = &i2c->dev;
 
-	/* Turn the chip on */
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	wm8900_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	wm8900_codec = codec;
 
-	wm8900_add_controls(codec);
-	wm8900_add_widgets(codec);
+	ret = snd_soc_register_codec(codec);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		goto err;
+	}
 
-	ret = snd_soc_init_card(socdev);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Failed to register card\n");
-		goto card_err;
+	ret = snd_soc_register_dai(&wm8900_dai);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register DAI: %d\n", ret);
+		goto err_codec;
 	}
-	return ret;
 
-card_err:
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-pcm_err:
-	kfree(codec->reg_cache);
-priv_err:
-	kfree(codec->private_data);
 	return ret;
-}
-
-static struct i2c_client *wm8900_client;
 
-static int wm8900_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
-{
-	wm8900_client = i2c;
-	wm8900_dai.dev = &i2c->dev;
-	return snd_soc_register_dai(&wm8900_dai);
+err_codec:
+	snd_soc_unregister_codec(codec);
+err:
+	kfree(wm8900);
+	wm8900_codec = NULL;
+	return ret;
 }
 
 static int wm8900_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_dai(&wm8900_dai);
+	snd_soc_unregister_codec(wm8900_codec);
+
+	wm8900_set_bias_level(wm8900_codec, SND_SOC_BIAS_OFF);
+
 	wm8900_dai.dev = NULL;
-	wm8900_client = NULL;
+	kfree(wm8900_codec->private_data);
+	wm8900_codec = NULL;
+
 	return 0;
 }
 
@@ -1408,7 +1410,7 @@ MODULE_DEVICE_TABLE(i2c, wm8900_i2c_id);
 
 static struct i2c_driver wm8900_i2c_driver = {
 	.driver = {
-		.name = "WM8900 I2C codec",
+		.name = "WM8900",
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8900_i2c_probe,
@@ -1422,30 +1424,36 @@ static int wm8900_probe(struct platform_device *pdev)
 	struct snd_soc_codec *codec;
 	int ret = 0;
 
-	if (!wm8900_client) {
+	if (!wm8900_codec) {
 		dev_err(&pdev->dev, "I2C client not yet instantiated\n");
 		return -ENODEV;
 	}
 
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
+	codec = wm8900_codec;
 	socdev->codec = codec;
 
-	codec->set_bias_level = wm8900_set_bias_level;
+	/* Register pcms */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register new PCMs\n");
+		goto pcm_err;
+	}
 
-	codec->hw_write = (hw_write_t)i2c_master_send;
-	codec->control_data = wm8900_client;
+	wm8900_add_controls(codec);
+	wm8900_add_widgets(codec);
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register card\n");
+		goto card_err;
+	}
 
-	ret = wm8900_init(socdev);
-	if (ret != 0)
-		kfree(codec);
+	return ret;
 
+card_err:
+	snd_soc_free_pcms(socdev);
+	snd_soc_dapm_free(socdev);
+pcm_err:
 	return ret;
 }
 
@@ -1453,14 +1461,9 @@ static int wm8900_probe(struct platform_device *pdev)
 static int wm8900_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->codec;
-
-	if (codec->control_data)
-		wm8900_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
-	kfree(codec);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/wm8900.h b/sound/soc/codecs/wm8900.h
index 2249a44..fd15007 100644
--- a/sound/soc/codecs/wm8900.h
+++ b/sound/soc/codecs/wm8900.h
@@ -52,13 +52,6 @@
 #define WM8900_DAC_CLKDIV_5_5 0x14
 #define WM8900_DAC_CLKDIV_6   0x18
 
-#define WM8900_
-
-struct wm8900_setup_data {
-	int i2c_bus;
-	unsigned short i2c_address;
-};
-
 extern struct snd_soc_dai wm8900_dai;
 extern struct snd_soc_codec_device soc_codec_dev_wm8900;
 
-- 
1.5.6.5
