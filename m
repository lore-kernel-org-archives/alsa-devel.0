From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 10/17] ASoC: multi-component - Wolfson wm8900,
	8903, 8904 and 8955 CODECs
Date: Wed, 11 Aug 2010 00:03:01 +0100
Message-ID: <1281481388-3000-11-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 894BC103879
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:47 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11453003wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:47 -0700 (PDT)
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

Moved to Wolfson CODECs multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8900.c |  251 ++++++++++++++++++++----------------------
 sound/soc/codecs/wm8900.h |    3 -
 sound/soc/codecs/wm8903.c |  268 ++++++++++++++++-----------------------------
 sound/soc/codecs/wm8903.h |    3 -
 sound/soc/codecs/wm8904.c |  208 ++++++++++-------------------------
 sound/soc/codecs/wm8904.h |    3 -
 sound/soc/codecs/wm8955.c |  184 ++++++++-----------------------
 sound/soc/codecs/wm8955.h |    3 -
 8 files changed, 325 insertions(+), 598 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 5da17a7..33c3b57 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -137,11 +138,9 @@
 
 #define WM8900_LRC_MASK 0xfc00
 
-struct snd_soc_codec_device soc_codec_dev_wm8900;
-
 struct wm8900_priv {
-	struct snd_soc_codec codec;
-
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u16 reg_cache[WM8900_MAXREG];
 
 	u32 fll_in; /* FLL input frequency */
@@ -627,8 +626,7 @@ static int wm8900_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 reg;
 
 	reg = snd_soc_read(codec, WM8900_REG_AUDIO1) & ~0x60;
@@ -1015,8 +1013,8 @@ static struct snd_soc_dai_ops wm8900_dai_ops = {
 	.digital_mute	= wm8900_digital_mute,
 };
 
-struct snd_soc_dai wm8900_dai = {
-	.name = "WM8900 HiFi",
+static struct snd_soc_dai_driver wm8900_dai = {
+	.name = "wm8900-hifi",
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 1,
@@ -1033,7 +1031,6 @@ struct snd_soc_dai wm8900_dai = {
 	 },
 	.ops = &wm8900_dai_ops,
 };
-EXPORT_SYMBOL_GPL(wm8900_dai);
 
 static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
@@ -1128,10 +1125,8 @@ static int wm8900_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8900_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8900_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	int fll_out = wm8900->fll_out;
 	int fll_in  = wm8900->fll_in;
@@ -1140,7 +1135,7 @@ static int wm8900_suspend(struct platform_device *pdev, pm_message_t state)
 	/* Stop the FLL in an orderly fashion */
 	ret = wm8900_set_fll(codec, 0, 0, 0);
 	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to stop FLL\n");
+		dev_err(codec->dev, "Failed to stop FLL\n");
 		return ret;
 	}
 
@@ -1152,10 +1147,8 @@ static int wm8900_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int wm8900_resume(struct platform_device *pdev)
+static int wm8900_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
 	u16 *cache;
 	int i, ret;
@@ -1176,7 +1169,7 @@ static int wm8900_resume(struct platform_device *pdev)
 
 		ret = wm8900_set_fll(codec, 0, fll_in, fll_out);
 		if (ret != 0) {
-			dev_err(&pdev->dev, "Failed to restart FLL\n");
+			dev_err(codec->dev, "Failed to restart FLL\n");
 			return ret;
 		}
 	}
@@ -1186,60 +1179,33 @@ static int wm8900_resume(struct platform_device *pdev)
 			snd_soc_write(codec, i, cache[i]);
 		kfree(cache);
 	} else
-		dev_err(&pdev->dev, "Unable to allocate register cache\n");
+		dev_err(codec->dev, "Unable to allocate register cache\n");
 
 	return 0;
 }
 
-static struct snd_soc_codec *wm8900_codec;
-
-static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
-				      const struct i2c_device_id *id)
+static int wm8900_probe(struct snd_soc_codec *codec)
 {
-	struct wm8900_priv *wm8900;
-	struct snd_soc_codec *codec;
-	unsigned int reg;
-	int ret;
-
-	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
-	if (wm8900 == NULL)
-		return -ENOMEM;
+	struct wm8900_priv *wm8900 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, reg;
 
-	codec = &wm8900->codec;
-	snd_soc_codec_set_drvdata(codec, wm8900);
-	codec->reg_cache = &wm8900->reg_cache[0];
-	codec->reg_cache_size = WM8900_MAXREG;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "WM8900";
-	codec->owner = THIS_MODULE;
-	codec->dai = &wm8900_dai;
-	codec->num_dai = 1;
-	codec->control_data = i2c;
-	codec->set_bias_level = wm8900_set_bias_level;
-	codec->volatile_register = wm8900_volatile_register;
-	codec->dev = &i2c->dev;
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	codec->control_data = wm8900->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8900->control_type);
 	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
 	reg = snd_soc_read(codec, WM8900_REG_ID);
 	if (reg != 0x8900) {
-		dev_err(&i2c->dev, "Device is not a WM8900 - ID %x\n", reg);
-		ret = -ENODEV;
-		goto err;
+		dev_err(codec->dev, "Device is not a WM8900 - ID %x\n", reg);
+		return -ENODEV;
 	}
 
 	/* Read back from the chip */
 	reg = snd_soc_read(codec, WM8900_REG_POWER1);
 	reg = (reg >> 12) & 0xf;
-	dev_info(&i2c->dev, "WM8900 revision %d\n", reg);
+	dev_info(codec->dev, "WM8900 revision %d\n", reg);
 
 	wm8900_reset(codec);
 
@@ -1271,43 +1237,97 @@ static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
 	/* Set the DAC and mixer output bias */
 	snd_soc_write(codec, WM8900_REG_OUTBIASCTL, 0x81);
 
-	wm8900_dai.dev = &i2c->dev;
+	snd_soc_add_controls(codec, wm8900_snd_controls,
+				ARRAY_SIZE(wm8900_snd_controls));
+	wm8900_add_widgets(codec);
 
-	wm8900_codec = codec;
+	return 0;
+}
 
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
+/* power down chip */
+static int wm8900_remove(struct snd_soc_codec *codec)
+{
+	wm8900_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
 
-	ret = snd_soc_register_dai(&wm8900_dai);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+static struct snd_soc_codec_driver soc_codec_dev_wm8900 = {
+	.probe =	wm8900_probe,
+	.remove =	wm8900_remove,
+	.suspend =	wm8900_suspend,
+	.resume =	wm8900_resume,
+	.set_bias_level = wm8900_set_bias_level,
+	.volatile_register = wm8900_volatile_register,
+	.reg_cache_size = sizeof(wm8900_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8900_reg_defaults,
+};
 
-	return ret;
+#if defined(CONFIG_SPI_MASTER)
+static int __devinit wm8900_spi_probe(struct spi_device *spi)
+{
+	struct wm8900_priv *wm8900;
+	int ret;
+
+	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
+	if (wm8900 == NULL)
+		return -ENOMEM;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(wm8900);
-	wm8900_codec = NULL;
+	wm8900->control_data = spi;
+	wm8900->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, wm8900);
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_dev_wm8900, &wm8900_dai, 1);
+	if (ret < 0)
+		kfree(wm8900);
 	return ret;
 }
 
-static __devexit int wm8900_i2c_remove(struct i2c_client *client)
+static int __devexit wm8900_spi_remove(struct spi_device *spi)
 {
-	snd_soc_unregister_dai(&wm8900_dai);
-	snd_soc_unregister_codec(wm8900_codec);
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
 
-	wm8900_set_bias_level(wm8900_codec, SND_SOC_BIAS_OFF);
+static struct spi_driver wm8900_spi_driver = {
+	.driver = {
+		.name	= "wm8900-codec",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= wm8900_spi_probe,
+	.remove		= __devexit_p(wm8900_spi_remove),
+};
+#endif /* CONFIG_SPI_MASTER */
+
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8900_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct wm8900_priv *wm8900;
+	int ret;
+
+	wm8900 = kzalloc(sizeof(struct wm8900_priv), GFP_KERNEL);
+	if (wm8900 == NULL)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, wm8900);
+	wm8900->control_data = i2c;
+	wm8900->control_type = SND_SOC_I2C;
 
-	wm8900_dai.dev = NULL;
-	kfree(snd_soc_codec_get_drvdata(wm8900_codec));
-	wm8900_codec = NULL;
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8900, &wm8900_dai, 1);
+	if (ret < 0)
+		kfree(wm8900);
+	return ret;
+}
 
+static __devexit int wm8900_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1319,71 +1339,44 @@ MODULE_DEVICE_TABLE(i2c, wm8900_i2c_id);
 
 static struct i2c_driver wm8900_i2c_driver = {
 	.driver = {
-		.name = "WM8900",
+		.name = "wm8900-codec",
 		.owner = THIS_MODULE,
 	},
-	.probe = wm8900_i2c_probe,
-	.remove = __devexit_p(wm8900_i2c_remove),
+	.probe =    wm8900_i2c_probe,
+	.remove =   __devexit_p(wm8900_i2c_remove),
 	.id_table = wm8900_i2c_id,
 };
+#endif
 
-static int wm8900_probe(struct platform_device *pdev)
+static int __init wm8900_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
 	int ret = 0;
-
-	if (!wm8900_codec) {
-		dev_err(&pdev->dev, "I2C client not yet instantiated\n");
-		return -ENODEV;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8900_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8900 I2C driver: %d\n",
+		       ret);
 	}
-
-	codec = wm8900_codec;
-	socdev->card->codec = codec;
-
-	/* Register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register new PCMs\n");
-		goto pcm_err;
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&wm8900_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8900 SPI driver: %d\n",
+		       ret);
 	}
-
-	snd_soc_add_controls(codec, wm8900_snd_controls,
-				ARRAY_SIZE(wm8900_snd_controls));
-	wm8900_add_widgets(codec);
-
-pcm_err:
+#endif
 	return ret;
 }
-
-/* power down chip */
-static int wm8900_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8900 = {
-	.probe = 	wm8900_probe,
-	.remove = 	wm8900_remove,
-	.suspend = 	wm8900_suspend,
-	.resume =	wm8900_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8900);
-
-static int __init wm8900_modinit(void)
-{
-	return i2c_add_driver(&wm8900_i2c_driver);
-}
 module_init(wm8900_modinit);
 
 static void __exit wm8900_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8900_i2c_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&wm8900_spi_driver);
+#endif
 }
 module_exit(wm8900_exit);
 
diff --git a/sound/soc/codecs/wm8900.h b/sound/soc/codecs/wm8900.h
index fd15007..583f257 100644
--- a/sound/soc/codecs/wm8900.h
+++ b/sound/soc/codecs/wm8900.h
@@ -52,7 +52,4 @@
 #define WM8900_DAC_CLKDIV_5_5 0x14
 #define WM8900_DAC_CLKDIV_6   0x18
 
-extern struct snd_soc_dai wm8900_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8900;
-
 #endif
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index bf08282..f5d73ed 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -213,10 +213,12 @@ static u16 wm8903_reg_defaults[] = {
 };
 
 struct wm8903_priv {
-	struct snd_soc_codec codec;
+
 	u16 reg_cache[ARRAY_SIZE(wm8903_reg_defaults)];
 
 	int sysclk;
+	struct i2c_client *control_data;
+	int irq;
 
 	/* Reference counts */
 	int class_w_users;
@@ -252,7 +254,6 @@ static int wm8903_volatile_register(unsigned int reg)
 static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 {
 	u16 reg[5];
-	struct i2c_client *i2c = codec->control_data;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
 	BUG_ON(start > 48);
@@ -262,7 +263,7 @@ static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0,
 		      reg[0] | WM8903_WSEQ_ENA);
 
-	dev_dbg(&i2c->dev, "Starting sequence at %d\n", start);
+	dev_dbg(codec->dev, "Starting sequence at %d\n", start);
 
 	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_3,
 		     start | WM8903_WSEQ_START);
@@ -277,7 +278,7 @@ static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 		reg[4] = snd_soc_read(codec, WM8903_WRITE_SEQUENCER_4);
 	} while (reg[4] & WM8903_WSEQ_BUSY);
 
-	dev_dbg(&i2c->dev, "Sequence complete\n");
+	dev_dbg(codec->dev, "Sequence complete\n");
 
 	/* Disable the sequencer again if we enabled it */
 	snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0, reg[0]);
@@ -422,7 +423,6 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_codec *codec = widget->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
 	u16 reg;
 	int ret;
 
@@ -431,7 +431,7 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	/* Turn it off if we're about to enable bypass */
 	if (ucontrol->value.integer.value[0]) {
 		if (wm8903->class_w_users == 0) {
-			dev_dbg(&i2c->dev, "Disabling Class W\n");
+			dev_dbg(codec->dev, "Disabling Class W\n");
 			snd_soc_write(codec, WM8903_CLASS_W_0, reg &
 				     ~(WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V));
 		}
@@ -444,14 +444,14 @@ static int wm8903_class_w_put(struct snd_kcontrol *kcontrol,
 	/* If we've just disabled the last bypass path turn Class W on */
 	if (!ucontrol->value.integer.value[0]) {
 		if (wm8903->class_w_users == 1) {
-			dev_dbg(&i2c->dev, "Enabling Class W\n");
+			dev_dbg(codec->dev, "Enabling Class W\n");
 			snd_soc_write(codec, WM8903_CLASS_W_0, reg |
 				     WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V);
 		}
 		wm8903->class_w_users--;
 	}
 
-	dev_dbg(&i2c->dev, "Bypass use count now %d\n",
+	dev_dbg(codec->dev, "Bypass use count now %d\n",
 		wm8903->class_w_users);
 
 	return ret;
@@ -935,7 +935,6 @@ static int wm8903_add_widgets(struct snd_soc_codec *codec)
 static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	struct i2c_client *i2c = codec->control_data;
 	u16 reg, reg2;
 
 	switch (level) {
@@ -974,7 +973,7 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 			/* By default no bypass paths are enabled so
 			 * enable Class W support.
 			 */
-			dev_dbg(&i2c->dev, "Enabling Class W\n");
+			dev_dbg(codec->dev, "Enabling Class W\n");
 			snd_soc_write(codec, WM8903_CLASS_W_0, reg |
 				     WM8903_CP_DYN_FREQ | WM8903_CP_DYN_V);
 		}
@@ -1228,10 +1227,8 @@ static int wm8903_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
 	struct snd_pcm_runtime *master_runtime;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -1245,7 +1242,7 @@ static int wm8903_startup(struct snd_pcm_substream *substream,
 	if (wm8903->master_substream) {
 		master_runtime = wm8903->master_substream->runtime;
 
-		dev_dbg(&i2c->dev, "Constraining to %d bits\n",
+		dev_dbg(codec->dev, "Constraining to %d bits\n",
 			master_runtime->sample_bits);
 
 		snd_pcm_hw_constraint_minmax(substream->runtime,
@@ -1264,8 +1261,7 @@ static void wm8903_shutdown(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -1284,10 +1280,8 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = codec->control_data;
 	int fs = params_rate(params);
 	int bclk;
 	int bclk_div;
@@ -1306,7 +1300,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	u16 dac_digital1 = snd_soc_read(codec, WM8903_DAC_DIGITAL_1);
 
 	if (substream == wm8903->slave_substream) {
-		dev_dbg(&i2c->dev, "Ignoring hw_params for slave substream\n");
+		dev_dbg(codec->dev, "Ignoring hw_params for slave substream\n");
 		return 0;
 	}
 
@@ -1332,7 +1326,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 		switch (sample_rates[dsp_config].rate) {
 		case 88200:
 		case 96000:
-			dev_err(&i2c->dev, "%dHz unsupported by ADC\n",
+			dev_err(codec->dev, "%dHz unsupported by ADC\n",
 				fs);
 			return -EINVAL;
 
@@ -1340,7 +1334,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 			break;
 		}
 
-	dev_dbg(&i2c->dev, "DSP fs = %dHz\n", sample_rates[dsp_config].rate);
+	dev_dbg(codec->dev, "DSP fs = %dHz\n", sample_rates[dsp_config].rate);
 	clock1 &= ~WM8903_SAMPLE_RATE_MASK;
 	clock1 |= sample_rates[dsp_config].value;
 
@@ -1366,7 +1360,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	dev_dbg(&i2c->dev, "MCLK = %dHz, target sample rate = %dHz\n",
+	dev_dbg(codec->dev, "MCLK = %dHz, target sample rate = %dHz\n",
 		wm8903->sysclk, fs);
 
 	/* We may not have an MCLK which allows us to generate exactly
@@ -1401,12 +1395,12 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	clock1 |= clk_sys_ratios[clk_config].rate << WM8903_CLK_SYS_RATE_SHIFT;
 	clock1 |= clk_sys_ratios[clk_config].mode << WM8903_CLK_SYS_MODE_SHIFT;
 
-	dev_dbg(&i2c->dev, "CLK_SYS_RATE=%x, CLK_SYS_MODE=%x div=%d\n",
+	dev_dbg(codec->dev, "CLK_SYS_RATE=%x, CLK_SYS_MODE=%x div=%d\n",
 		clk_sys_ratios[clk_config].rate,
 		clk_sys_ratios[clk_config].mode,
 		clk_sys_ratios[clk_config].div);
 
-	dev_dbg(&i2c->dev, "Actual CLK_SYS = %dHz\n", clk_sys);
+	dev_dbg(codec->dev, "Actual CLK_SYS = %dHz\n", clk_sys);
 
 	/* We may not get quite the right frequency if using
 	 * approximate clocks so look for the closest match that is
@@ -1428,7 +1422,7 @@ static int wm8903_hw_params(struct snd_pcm_substream *substream,
 	aif2 &= ~WM8903_BCLK_DIV_MASK;
 	aif3 &= ~WM8903_LRCLK_RATE_MASK;
 
-	dev_dbg(&i2c->dev, "BCLK ratio %d for %dHz - actual BCLK = %dHz\n",
+	dev_dbg(codec->dev, "BCLK ratio %d for %dHz - actual BCLK = %dHz\n",
 		bclk_divs[bclk_div].ratio / 10, bclk,
 		(clk_sys * 10) / bclk_divs[bclk_div].ratio);
 
@@ -1504,8 +1498,8 @@ EXPORT_SYMBOL_GPL(wm8903_mic_detect);
 
 static irqreturn_t wm8903_irq(int irq, void *data)
 {
-	struct wm8903_priv *wm8903 = data;
-	struct snd_soc_codec *codec = &wm8903->codec;
+	struct snd_soc_codec *codec = data;
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int mic_report;
 	int int_pol;
 	int int_val = 0;
@@ -1586,8 +1580,8 @@ static struct snd_soc_dai_ops wm8903_dai_ops = {
 	.set_sysclk	= wm8903_set_dai_sysclk,
 };
 
-struct snd_soc_dai wm8903_dai = {
-	.name = "WM8903",
+static struct snd_soc_dai_driver wm8903_dai = {
+	.name = "wm8903-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -1605,23 +1599,16 @@ struct snd_soc_dai wm8903_dai = {
 	.ops = &wm8903_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(wm8903_dai);
 
-static int wm8903_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8903_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8903_resume(struct platform_device *pdev)
+static int wm8903_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct i2c_client *i2c = codec->control_data;
 	int i;
 	u16 *reg_cache = codec->reg_cache;
 	u16 *tmp_cache = kmemdup(reg_cache, sizeof(wm8903_reg_defaults),
@@ -1637,65 +1624,38 @@ static int wm8903_resume(struct platform_device *pdev)
 				snd_soc_write(codec, i, tmp_cache[i]);
 		kfree(tmp_cache);
 	} else {
-		dev_err(&i2c->dev, "Failed to allocate temporary cache\n");
+		dev_err(codec->dev, "Failed to allocate temporary cache\n");
 	}
 
 	return 0;
 }
 
-static struct snd_soc_codec *wm8903_codec;
-
-static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
-				      const struct i2c_device_id *id)
+static int wm8903_probe(struct snd_soc_codec *codec)
 {
-	struct wm8903_platform_data *pdata = dev_get_platdata(&i2c->dev);
-	struct wm8903_priv *wm8903;
-	struct snd_soc_codec *codec;
+	struct wm8903_platform_data *pdata = dev_get_platdata(codec->dev);
+	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int ret, i;
 	int trigger, irq_pol;
 	u16 val;
 
-	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
-	if (wm8903 == NULL)
-		return -ENOMEM;
-
-	codec = &wm8903->codec;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->dev = &i2c->dev;
-	codec->name = "WM8903";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8903_set_bias_level;
-	codec->dai = &wm8903_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(wm8903->reg_cache);
-	codec->reg_cache = &wm8903->reg_cache[0];
-	snd_soc_codec_set_drvdata(codec, wm8903);
-	codec->volatile_register = wm8903_volatile_register;
 	init_completion(&wm8903->wseq);
-
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	codec->control_data = wm8903->control_data;
 
 	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
 	val = snd_soc_read(codec, WM8903_SW_RESET_AND_ID);
 	if (val != wm8903_reg_defaults[WM8903_SW_RESET_AND_ID]) {
-		dev_err(&i2c->dev,
+		dev_err(codec->dev,
 			"Device with ID register %x is not a WM8903\n", val);
 		return -ENODEV;
 	}
 
 	val = snd_soc_read(codec, WM8903_REVISION_NUMBER);
-	dev_info(&i2c->dev, "WM8903 revision %d\n",
+	dev_info(codec->dev, "WM8903 revision %d\n",
 		 val & WM8903_CHIP_REV_MASK);
 
 	wm8903_reset(codec);
@@ -1721,7 +1681,7 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 		wm8903->mic_delay = pdata->micdet_delay;
 	}
 	
-	if (i2c->irq) {
+	if (wm8903->irq) {
 		if (pdata && pdata->irq_active_low) {
 			trigger = IRQF_TRIGGER_LOW;
 			irq_pol = WM8903_IRQ_POL;
@@ -1733,13 +1693,13 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 		snd_soc_update_bits(codec, WM8903_INTERRUPT_CONTROL,
 				    WM8903_IRQ_POL, irq_pol);
 		
-		ret = request_threaded_irq(i2c->irq, NULL, wm8903_irq,
+		ret = request_threaded_irq(wm8903->irq, NULL, wm8903_irq,
 					   trigger | IRQF_ONESHOT,
-					   "wm8903", wm8903);
+					   "wm8903", codec);
 		if (ret != 0) {
-			dev_err(&i2c->dev, "Failed to request IRQ: %d\n",
+			dev_err(codec->dev, "Failed to request IRQ: %d\n",
 				ret);
-			goto err;
+			return ret;
 		}
 
 		/* Enable write sequencer interrupts */
@@ -1781,133 +1741,97 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 	val |= WM8903_DAC_MUTEMODE;
 	snd_soc_write(codec, WM8903_DAC_DIGITAL_1, val);
 
-	wm8903_dai.dev = &i2c->dev;
-	wm8903_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
-		goto err_irq;
-	}
-
-	ret = snd_soc_register_dai(&wm8903_dai);
-	if (ret != 0) {
-		dev_err(&i2c->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-	return ret;
+	snd_soc_add_controls(codec, wm8903_snd_controls,
+				ARRAY_SIZE(wm8903_snd_controls));
+	wm8903_add_widgets(codec);
 
-err_codec:
-	snd_soc_unregister_codec(codec);
-err_irq:
-	if (i2c->irq)
-		free_irq(i2c->irq, wm8903);
-err:
-	wm8903_codec = NULL;
-	kfree(wm8903);
 	return ret;
 }
 
-static __devexit int wm8903_i2c_remove(struct i2c_client *client)
+/* power down chip */
+static int wm8903_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	struct wm8903_priv *priv = snd_soc_codec_get_drvdata(codec);
+	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
+}
 
-	snd_soc_unregister_dai(&wm8903_dai);
-	snd_soc_unregister_codec(codec);
+static struct snd_soc_codec_driver soc_codec_dev_wm8903 = {
+	.probe =	wm8903_probe,
+	.remove =	wm8903_remove,
+	.suspend =	wm8903_suspend,
+	.resume =	wm8903_resume,
+	.set_bias_level = wm8903_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8903_reg_defaults),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8903_reg_defaults,
+	.volatile_register = wm8903_volatile_register,
+};
 
-	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
+{
+	struct wm8903_priv *wm8903;
+	int ret;
 
-	if (client->irq)
-		free_irq(client->irq, priv);
+	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
+	if (wm8903 == NULL)
+		return -ENOMEM;
 
-	kfree(priv);
+	i2c_set_clientdata(i2c, wm8903);
+	wm8903->control_data = i2c;
+	wm8903->irq = i2c->irq;
 
-	wm8903_codec = NULL;
-	wm8903_dai.dev = NULL;
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8903, &wm8903_dai, 1);
+	if (ret < 0)
+		kfree(wm8903);
+	return ret;
+}
 
+static __devexit int wm8903_i2c_remove(struct i2c_client *client)
+{
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
-/* i2c codec control layer */
 static const struct i2c_device_id wm8903_i2c_id[] = {
-       { "wm8903", 0 },
-       { }
+	{ "wm8903", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, wm8903_i2c_id);
 
 static struct i2c_driver wm8903_i2c_driver = {
 	.driver = {
-		.name = "WM8903",
+		.name = "wm8903-codec",
 		.owner = THIS_MODULE,
 	},
-	.probe    = wm8903_i2c_probe,
-	.remove   = __devexit_p(wm8903_i2c_remove),
+	.probe =    wm8903_i2c_probe,
+	.remove =   __devexit_p(wm8903_i2c_remove),
 	.id_table = wm8903_i2c_id,
 };
+#endif
 
-static int wm8903_probe(struct platform_device *pdev)
+static int __init wm8903_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	int ret = 0;
-
-	if (!wm8903_codec) {
-		dev_err(&pdev->dev, "I2C device not yet probed\n");
-		goto err;
-	}
-
-	socdev->card->codec = wm8903_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		goto err;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&wm8903_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register wm8903 I2C driver: %d\n",
+		       ret);
 	}
-
-	snd_soc_add_controls(socdev->card->codec, wm8903_snd_controls,
-				ARRAY_SIZE(wm8903_snd_controls));
-	wm8903_add_widgets(socdev->card->codec);
-
+#endif
 	return ret;
-
-err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8903_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8903 = {
-	.probe = 	wm8903_probe,
-	.remove = 	wm8903_remove,
-	.suspend = 	wm8903_suspend,
-	.resume =	wm8903_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8903);
-
-static int __init wm8903_modinit(void)
-{
-	return i2c_add_driver(&wm8903_i2c_driver);
 }
 module_init(wm8903_modinit);
 
 static void __exit wm8903_exit(void)
 {
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&wm8903_i2c_driver);
+#endif
 }
 module_exit(wm8903_exit);
 
diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index ce384a2..996435e 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -15,9 +15,6 @@
 
 #include <linux/i2c.h>
 
-extern struct snd_soc_dai wm8903_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8903;
-
 extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 			     struct snd_soc_jack *jack,
 			     int det, int shrt);
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index f7dcabf..33be84e 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -31,9 +31,6 @@
 
 #include "wm8904.h"
 
-static struct snd_soc_codec *wm8904_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8904;
-
 enum wm8904_type {
 	WM8904,
 	WM8912,
@@ -52,10 +49,11 @@ static const char *wm8904_supply_names[WM8904_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8904_priv {
-	struct snd_soc_codec codec;
+
 	u16 reg_cache[WM8904_MAX_REGISTER + 1];
 
 	enum wm8904_type devtype;
+	void *control_data;
 
 	struct regulator_bulk_data supplies[WM8904_NUM_SUPPLIES];
 
@@ -689,7 +687,7 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);	
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.integer.value[0];
 
@@ -760,7 +758,7 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);	
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.integer.value[0];
 
@@ -2218,8 +2216,8 @@ static struct snd_soc_dai_ops wm8904_dai_ops = {
 	.digital_mute = wm8904_digital_mute,
 };
 
-struct snd_soc_dai wm8904_dai = {
-	.name = "WM8904",
+static struct snd_soc_dai_driver wm8904_dai = {
+	.name = "wm8904-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -2237,24 +2235,17 @@ struct snd_soc_dai wm8904_dai = {
 	.ops = &wm8904_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(wm8904_dai);
 
 #ifdef CONFIG_PM
-static int wm8904_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8904_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8904_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8904_resume(struct platform_device *pdev)
+static int wm8904_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8904_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -2264,9 +2255,9 @@ static int wm8904_resume(struct platform_device *pdev)
 #define wm8904_resume NULL
 #endif
 
-static void wm8904_handle_retune_mobile_pdata(struct wm8904_priv *wm8904)
+static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = &wm8904->codec;
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	struct snd_kcontrol_new control =
 		SOC_ENUM_EXT("EQ Mode",
@@ -2315,20 +2306,20 @@ static void wm8904_handle_retune_mobile_pdata(struct wm8904_priv *wm8904)
 	wm8904->retune_mobile_enum.max = wm8904->num_retune_mobile_texts;
 	wm8904->retune_mobile_enum.texts = wm8904->retune_mobile_texts;
 
-	ret = snd_soc_add_controls(&wm8904->codec, &control, 1);
+	ret = snd_soc_add_controls(codec, &control, 1);
 	if (ret != 0)
-		dev_err(wm8904->codec.dev,
+		dev_err(codec->dev,
 			"Failed to add ReTune Mobile control: %d\n", ret);
 }
 
-static void wm8904_handle_pdata(struct wm8904_priv *wm8904)
+static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = &wm8904->codec;
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int ret, i;
 
 	if (!pdata) {
-		snd_soc_add_controls(&wm8904->codec, wm8904_eq_controls,
+		snd_soc_add_controls(codec, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 		return;
 	}
@@ -2344,7 +2335,7 @@ static void wm8904_handle_pdata(struct wm8904_priv *wm8904)
 		wm8904->drc_texts = kmalloc(sizeof(char *)
 					    * pdata->num_drc_cfgs, GFP_KERNEL);
 		if (!wm8904->drc_texts) {
-			dev_err(wm8904->codec.dev,
+			dev_err(codec->dev,
 				"Failed to allocate %d DRC config texts\n",
 				pdata->num_drc_cfgs);
 			return;
@@ -2356,9 +2347,9 @@ static void wm8904_handle_pdata(struct wm8904_priv *wm8904)
 		wm8904->drc_enum.max = pdata->num_drc_cfgs;
 		wm8904->drc_enum.texts = wm8904->drc_texts;
 
-		ret = snd_soc_add_controls(&wm8904->codec, &control, 1);
+		ret = snd_soc_add_controls(codec, &control, 1);
 		if (ret != 0)
-			dev_err(wm8904->codec.dev,
+			dev_err(codec->dev,
 				"Failed to add DRC mode control: %d\n", ret);
 
 		wm8904_set_drc(codec);
@@ -2368,89 +2359,19 @@ static void wm8904_handle_pdata(struct wm8904_priv *wm8904)
 		pdata->num_retune_mobile_cfgs);
 
 	if (pdata->num_retune_mobile_cfgs)
-		wm8904_handle_retune_mobile_pdata(wm8904);
+		wm8904_handle_retune_mobile_pdata(codec);
 	else
-		snd_soc_add_controls(&wm8904->codec, wm8904_eq_controls,
+		snd_soc_add_controls(codec, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 }
 
-static int wm8904_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8904_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
 
-	socdev->card->codec = wm8904_codec;
-	codec = wm8904_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	wm8904_handle_pdata(snd_soc_codec_get_drvdata(codec));
-
-	wm8904_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-static int wm8904_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8904 = {
-	.probe = 	wm8904_probe,
-	.remove = 	wm8904_remove,
-	.suspend = 	wm8904_suspend,
-	.resume =	wm8904_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8904);
-
-static int wm8904_register(struct wm8904_priv *wm8904,
-			   enum snd_soc_control_type control)
+static int wm8904_probe(struct snd_soc_codec *codec)
 {
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int ret;
-	struct snd_soc_codec *codec = &wm8904->codec;
-	int i;
-
-	if (wm8904_codec) {
-		dev_err(codec->dev, "Another WM8904 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
+	int ret, i;
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8904);
-	codec->name = "WM8904";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8904_set_bias_level;
-	codec->dai = &wm8904_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8904_MAX_REGISTER;
-	codec->reg_cache = &wm8904->reg_cache;
-	codec->volatile_register = wm8904_volatile_register;
 	codec->cache_sync = 1;
 	codec->idle_bias_off = 1;
 
@@ -2463,16 +2384,13 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 	default:
 		dev_err(codec->dev, "Unknown device type %d\n",
 			wm8904->devtype);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
-	memcpy(codec->reg_cache, wm8904_reg, sizeof(wm8904_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8904->supplies); i++)
@@ -2482,7 +2400,7 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 				 wm8904->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8904->supplies),
@@ -2517,8 +2435,6 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 		goto err_enable;
 	}
 
-	wm8904_dai.dev = codec->dev;
-
 	/* Change some default settings - latch VU and enable ZC */
 	wm8904->reg_cache[WM8904_ADC_DIGITAL_VOLUME_LEFT] |= WM8904_ADC_VU;
 	wm8904->reg_cache[WM8904_ADC_DIGITAL_VOLUME_RIGHT] |= WM8904_ADC_VU;
@@ -2563,72 +2479,68 @@ static int wm8904_register(struct wm8904_priv *wm8904,
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 
-	wm8904_codec = codec;
+	wm8904_handle_pdata(codec);
 
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_enable;
-	}
-
-	ret = snd_soc_register_dai(&wm8904_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
+	wm8904_add_widgets(codec);
 
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-err:
-	kfree(wm8904);
 	return ret;
 }
 
-static void wm8904_unregister(struct wm8904_priv *wm8904)
+static int wm8904_remove(struct snd_soc_codec *codec)
 {
-	wm8904_set_bias_level(&wm8904->codec, SND_SOC_BIAS_OFF);
+	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+
+	wm8904_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_free(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-	snd_soc_unregister_dai(&wm8904_dai);
-	snd_soc_unregister_codec(&wm8904->codec);
-	kfree(wm8904);
-	wm8904_codec = NULL;
+
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
+	.probe =	wm8904_probe,
+	.remove =	wm8904_remove,
+	.suspend =	wm8904_suspend,
+	.resume =	wm8904_resume,
+	.set_bias_level = wm8904_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8904_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8904_reg,
+	.volatile_register = wm8904_volatile_register,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8904_priv *wm8904;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8904 = kzalloc(sizeof(struct wm8904_priv), GFP_KERNEL);
 	if (wm8904 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8904->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	wm8904->devtype = id->driver_data;
-
 	i2c_set_clientdata(i2c, wm8904);
-	codec->control_data = i2c;
+	wm8904->control_data = i2c;
 	wm8904->pdata = i2c->dev.platform_data;
 
-	codec->dev = &i2c->dev;
-
-	return wm8904_register(wm8904, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8904, &wm8904_dai, 1);
+	if (ret < 0)
+		kfree(wm8904);
+	return ret;
 }
 
 static __devexit int wm8904_i2c_remove(struct i2c_client *client)
 {
-	struct wm8904_priv *wm8904 = i2c_get_clientdata(client);
-	wm8904_unregister(wm8904);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -2641,7 +2553,7 @@ MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
 
 static struct i2c_driver wm8904_i2c_driver = {
 	.driver = {
-		.name = "WM8904",
+		.name = "wm8904-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8904_i2c_probe,
@@ -2652,15 +2564,15 @@ static struct i2c_driver wm8904_i2c_driver = {
 
 static int __init wm8904_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8904_i2c_driver);
 	if (ret != 0) {
-		printk(KERN_ERR "Failed to register WM8904 I2C driver: %d\n",
+		printk(KERN_ERR "Failed to register wm8904 I2C driver: %d\n",
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8904_modinit);
 
diff --git a/sound/soc/codecs/wm8904.h b/sound/soc/codecs/wm8904.h
index abe5059..9e8c841 100644
--- a/sound/soc/codecs/wm8904.h
+++ b/sound/soc/codecs/wm8904.h
@@ -21,9 +21,6 @@
 #define WM8904_FLL_LRCLK         3
 #define WM8904_FLL_FREE_RUNNING  4
 
-extern struct snd_soc_dai wm8904_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8904;
-
 /*
  * Register values.
  */
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 5f02559..a5a9f8e 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -30,9 +30,6 @@
 
 #include "wm8955.h"
 
-static struct snd_soc_codec *wm8955_codec;
-struct snd_soc_codec_device soc_codec_dev_wm8955;
-
 #define WM8955_NUM_SUPPLIES 4
 static const char *wm8955_supply_names[WM8955_NUM_SUPPLIES] = {
 	"DCVDD",
@@ -43,7 +40,9 @@ static const char *wm8955_supply_names[WM8955_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct wm8955_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
+
 	u16 reg_cache[WM8955_MAX_REGISTER + 1];
 
 	unsigned int mclk_rate;
@@ -52,8 +51,6 @@ struct wm8955_priv {
 	int fs;
 
 	struct regulator_bulk_data supplies[WM8955_NUM_SUPPLIES];
-
-	struct wm8955_pdata *pdata;
 };
 
 static const u16 wm8955_reg[WM8955_MAX_REGISTER + 1] = {
@@ -870,8 +867,8 @@ static struct snd_soc_dai_ops wm8955_dai_ops = {
 	.digital_mute = wm8955_digital_mute,
 };
 
-struct snd_soc_dai wm8955_dai = {
-	.name = "WM8955",
+static struct snd_soc_dai_driver wm8955_dai = {
+	.name = "wm8955-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -881,24 +878,17 @@ struct snd_soc_dai wm8955_dai = {
 	},
 	.ops = &wm8955_dai_ops,
 };
-EXPORT_SYMBOL_GPL(wm8955_dai);
 
 #ifdef CONFIG_PM
-static int wm8955_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8955_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8955_resume(struct platform_device *pdev)
+static int wm8955_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8955_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -908,86 +898,17 @@ static int wm8955_resume(struct platform_device *pdev)
 #define wm8955_resume NULL
 #endif
 
-static int wm8955_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (wm8955_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = wm8955_codec;
-	codec = wm8955_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	wm8955_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-static int wm8955_remove(struct platform_device *pdev)
+static int wm8955_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8955 = {
-	.probe = 	wm8955_probe,
-	.remove = 	wm8955_remove,
-	.suspend = 	wm8955_suspend,
-	.resume =	wm8955_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8955);
-
-static int wm8955_register(struct wm8955_priv *wm8955,
-			   enum snd_soc_control_type control)
-{
-	int ret;
-	struct snd_soc_codec *codec = &wm8955->codec;
-	int i;
-
-	if (wm8955_codec) {
-		dev_err(codec->dev, "Another WM8955 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, wm8955);
-	codec->name = "WM8955";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8955_set_bias_level;
-	codec->dai = &wm8955_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8955_MAX_REGISTER;
-	codec->reg_cache = &wm8955->reg_cache;
-
-	memcpy(codec->reg_cache, wm8955_reg, sizeof(wm8955_reg));
+	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
+	struct wm8955_pdata *pdata = dev_get_platdata(codec->dev);
+	int ret, i;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, control);
+	codec->control_data = wm8955->control_data;
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9, wm8955->control_type);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8955->supplies); i++)
@@ -997,7 +918,7 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 				 wm8955->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8955->supplies),
@@ -1013,8 +934,6 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 		goto err_enable;
 	}
 
-	wm8955_dai.dev = codec->dev;
-
 	/* Change some default settings - latch VU and enable ZC */
 	wm8955->reg_cache[WM8955_LEFT_DAC_VOLUME] |= WM8955_LDVU;
 	wm8955->reg_cache[WM8955_RIGHT_DAC_VOLUME] |= WM8955_RDVU;
@@ -1028,12 +947,12 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 	wm8955->reg_cache[WM8955_BASS_CONTROL] |= WM8955_BB;
 
 	/* Set platform data values */
-	if (wm8955->pdata) {
-		if (wm8955->pdata->out2_speaker)
+	if (pdata) {
+		if (pdata->out2_speaker)
 			wm8955->reg_cache[WM8955_ADDITIONAL_CONTROL_2]
 				|= WM8955_ROUT2INV;
 
-		if (wm8955->pdata->monoin_diff)
+		if (pdata->monoin_diff)
 			wm8955->reg_cache[WM8955_MONO_OUT_MIX_1]
 				|= WM8955_DMEN;
 	}
@@ -1043,70 +962,61 @@ static int wm8955_register(struct wm8955_priv *wm8955,
 	/* Bias level configuration will have done an extra enable */
 	regulator_bulk_disable(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
 
-	wm8955_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_enable;
-	}
-
-	ret = snd_soc_register_dai(&wm8955_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
+	wm8955_add_widgets(codec);
 	return 0;
 
-err_codec:
-	snd_soc_unregister_codec(codec);
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
 err_get:
 	regulator_bulk_free(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
-err:
-	kfree(wm8955);
 	return ret;
 }
 
-static void wm8955_unregister(struct wm8955_priv *wm8955)
+static int wm8955_remove(struct snd_soc_codec *codec)
 {
-	wm8955_set_bias_level(&wm8955->codec, SND_SOC_BIAS_OFF);
+	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
+
+	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	regulator_bulk_free(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
-	snd_soc_unregister_dai(&wm8955_dai);
-	snd_soc_unregister_codec(&wm8955->codec);
-	kfree(wm8955);
-	wm8955_codec = NULL;
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_wm8955 = {
+	.probe =	wm8955_probe,
+	.remove =	wm8955_remove,
+	.suspend =	wm8955_suspend,
+	.resume =	wm8955_resume,
+	.set_bias_level = wm8955_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(wm8955_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = wm8955_reg,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int wm8955_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct wm8955_priv *wm8955;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	wm8955 = kzalloc(sizeof(struct wm8955_priv), GFP_KERNEL);
 	if (wm8955 == NULL)
 		return -ENOMEM;
 
-	codec = &wm8955->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, wm8955);
-	codec->control_data = i2c;
-	wm8955->pdata = i2c->dev.platform_data;
-
-	codec->dev = &i2c->dev;
+	wm8955->control_data = i2c;
 
-	return wm8955_register(wm8955, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_wm8955, &wm8955_dai, 1);
+	if (ret < 0)
+		kfree(wm8955);
+	return ret;
 }
 
 static __devexit int wm8955_i2c_remove(struct i2c_client *client)
 {
-	struct wm8955_priv *wm8955 = i2c_get_clientdata(client);
-	wm8955_unregister(wm8955);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -1118,7 +1028,7 @@ MODULE_DEVICE_TABLE(i2c, wm8955_i2c_id);
 
 static struct i2c_driver wm8955_i2c_driver = {
 	.driver = {
-		.name = "wm8955",
+		.name = "wm8955-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8955_i2c_probe,
@@ -1129,7 +1039,7 @@ static struct i2c_driver wm8955_i2c_driver = {
 
 static int __init wm8955_modinit(void)
 {
-	int ret;
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	ret = i2c_add_driver(&wm8955_i2c_driver);
 	if (ret != 0) {
@@ -1137,7 +1047,7 @@ static int __init wm8955_modinit(void)
 		       ret);
 	}
 #endif
-	return 0;
+	return ret;
 }
 module_init(wm8955_modinit);
 
diff --git a/sound/soc/codecs/wm8955.h b/sound/soc/codecs/wm8955.h
index ae349c8..d13fd5c 100644
--- a/sound/soc/codecs/wm8955.h
+++ b/sound/soc/codecs/wm8955.h
@@ -15,9 +15,6 @@
 
 #define WM8955_CLK_MCLK 1
 
-extern struct snd_soc_dai wm8955_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8955;
-
 /*
  * Register values.
  */
-- 
1.7.0.4
