From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 02/16] ASoC: multi-component - cs4720,
	cs42l51 and da7210 CODECs
Date: Fri, 25 Jun 2010 18:52:49 +0100
Message-ID: <1277488383-31287-3-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5730D103840
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:21 +0200 (CEST)
Received: by wyf23 with SMTP id 23so166789wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:19 -0700 (PDT)
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

Move codecs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o cs42151 and cs4270: set_dai_sysclk() - we no longer change static _driver_
 rates on clock changes (as the driver can be used by other cs24xx codec
 devices). The codec device rate is checked at hw_params() time.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c  |  390 ++++++++++++++++----------------------------
 sound/soc/codecs/cs4270.h  |    4 +-
 sound/soc/codecs/cs42l51.c |  292 +++++++++++----------------------
 sound/soc/codecs/cs42l51.h |    4 +-
 sound/soc/codecs/da7210.c  |  145 ++++-------------
 sound/soc/codecs/da7210.h  |    4 +-
 6 files changed, 270 insertions(+), 569 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 30d9492..8d3a3af 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -114,7 +114,8 @@ static const char *supply_names[] = {
 
 /* Private data for the CS4270 */
 struct cs4270_private {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u8 reg_cache[CS4270_NUMREGS];
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
@@ -212,44 +213,8 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	unsigned int rates = 0;
-	unsigned int rate_min = -1;
-	unsigned int rate_max = 0;
-	unsigned int i;
 
 	cs4270->mclk = freq;
-
-	if (cs4270->mclk) {
-		for (i = 0; i < NUM_MCLK_RATIOS; i++) {
-			unsigned int rate = freq / cs4270_mode_ratios[i].ratio;
-			rates |= snd_pcm_rate_to_rate_bit(rate);
-			if (rate < rate_min)
-				rate_min = rate;
-			if (rate > rate_max)
-				rate_max = rate;
-		}
-		/* FIXME: soc should support a rate list */
-		rates &= ~SNDRV_PCM_RATE_KNOT;
-
-		if (!rates) {
-			dev_err(codec->dev, "could not find a valid sample rate\n");
-			return -EINVAL;
-		}
-	} else {
-		/* enable all possible rates */
-		rates = SNDRV_PCM_RATE_8000_192000;
-		rate_min = 8000;
-		rate_max = 192000;
-	}
-
-	codec_dai->playback.rates = rates;
-	codec_dai->playback.rate_min = rate_min;
-	codec_dai->playback.rate_max = rate_max;
-
-	codec_dai->capture.rates = rates;
-	codec_dai->capture.rate_min = rate_min;
-	codec_dai->capture.rate_max = rate_max;
-
 	return 0;
 }
 
@@ -410,8 +375,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	unsigned int i;
@@ -549,19 +513,6 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 		snd_soc_get_volsw, cs4270_soc_put_mute),
 };
 
-/*
- * cs4270_codec - global variable to store codec for the ASoC probe function
- *
- * If struct i2c_driver had a private_data field, we wouldn't need to use
- * cs4270_codec.  This is the only way to pass the codec structure from
- * cs4270_i2c_probe() to cs4270_probe().  Unfortunately, there is no good
- * way to synchronize these two functions.  cs4270_i2c_probe() can be called
- * multiple times before cs4270_probe() is called even once.  So for now, we
- * also only allow cs4270_i2c_probe() to be run once.  That means that we do
- * not support more than one cs4270 device in the system, at least for now.
- */
-static struct snd_soc_codec *cs4270_codec;
-
 static struct snd_soc_dai_ops cs4270_dai_ops = {
 	.hw_params	= cs4270_hw_params,
 	.set_sysclk	= cs4270_set_dai_sysclk,
@@ -569,20 +520,24 @@ static struct snd_soc_dai_ops cs4270_dai_ops = {
 	.digital_mute	= cs4270_dai_mute,
 };
 
-struct snd_soc_dai cs4270_dai = {
+struct snd_soc_dai_driver cs4270_dai = {
 	.name = "cs4270",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = 0,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 4000,
+		.rate_max = 216000,
 		.formats = CS4270_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = 0,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 4000,
+		.rate_max = 216000,
 		.formats = CS4270_FORMATS,
 	},
 	.ops = &cs4270_dai_ops,
@@ -596,20 +551,46 @@ EXPORT_SYMBOL_GPL(cs4270_dai);
  * This function is called when ASoC has all the pieces it needs to
  * instantiate a sound driver.
  */
-static int cs4270_probe(struct platform_device *pdev)
+static int cs4270_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = cs4270_codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
+	int i, ret, reg;
+
+	codec->control_data = cs4270->control_data;
+
+	/* The I2C interface is set up, so pre-fill our register cache */
+
+	ret = cs4270_fill_cache(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to fill register cache\n");
+		return ret;
+	}
+
+	/* Disable auto-mute.  This feature appears to be buggy.  In some
+	 * situations, auto-mute will not deactivate when it should, so we want
+	 * this feature disabled by default.  An application (e.g. alsactl) can
+	 * re-enabled it by using the controls.
+	 */
+
+	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
+	reg &= ~CS4270_MUTE_AUTO;
+	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
+	if (ret < 0) {
+		dev_err(codec->dev, "i2c write failed\n");
+		return ret;
+	}
 
-	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
-	socdev->card->codec = codec;
+	/* Disable automatic volume control.  The hardware enables, and it
+	 * causes volume change commands to be delayed, sometimes until after
+	 * playback has started.  An application (e.g. alsactl) can
+	 * re-enabled it by using the controls.
+	 */
 
-	/* Register PCMs */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
+	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
+	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -618,7 +599,7 @@ static int cs4270_probe(struct platform_device *pdev)
 				ARRAY_SIZE(cs4270_snd_controls));
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to add controls\n");
-		goto error_free_pcms;
+		return ret;
 	}
 
 	/* get the power supply regulators */
@@ -628,7 +609,7 @@ static int cs4270_probe(struct platform_device *pdev)
 	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(cs4270->supplies),
 				 cs4270->supplies);
 	if (ret < 0)
-		goto error_free_pcms;
+		return ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
 				    cs4270->supplies);
@@ -641,9 +622,6 @@ error_free_regulators:
 	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
 			    cs4270->supplies);
 
-error_free_pcms:
-	snd_soc_free_pcms(socdev);
-
 	return ret;
 }
 
@@ -653,19 +631,100 @@ error_free_pcms:
  *
  * This function is the counterpart to cs4270_probe().
  */
-static int cs4270_remove(struct platform_device *pdev)
+static int cs4270_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = cs4270_codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_free_pcms(socdev);
 	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 
 	return 0;
 };
 
+#ifdef CONFIG_PM
+
+/* This suspend/resume implementation can handle both - a simple standby
+ * where the codec remains powered, and a full suspend, where the voltage
+ * domain the codec is connected to is teared down and/or any other hardware
+ * reset condition is asserted.
+ *
+ * The codec's own power saving features are enabled in the suspend callback,
+ * and all registers are written back to the hardware when resuming.
+ */
+
+static int cs4270_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
+{
+	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
+	int reg, ret;
+
+	reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+	if (reg < 0)
+		return reg;
+
+	ret = snd_soc_write(codec, CS4270_PWRCTL, reg);
+	if (ret < 0)
+		return ret;
+
+	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies),
+			       cs4270->supplies);
+
+	return 0;
+}
+
+static int cs4270_soc_resume(struct snd_soc_codec *codec)
+{
+	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *i2c_client = codec->control_data;
+	int reg;
+
+	regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
+			      cs4270->supplies);
+
+	/* In case the device was put to hard reset during sleep, we need to
+	 * wait 500ns here before any I2C communication. */
+	ndelay(500);
+
+	/* first restore the entire register cache ... */
+	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
+		u8 val = snd_soc_read(codec, reg);
+
+		if (i2c_smbus_write_byte_data(i2c_client, reg, val)) {
+			dev_err(codec->dev, "i2c write failed\n");
+			return -EIO;
+		}
+	}
+
+	/* ... then disable the power-down bits */
+	reg = snd_soc_read(codec, CS4270_PWRCTL);
+	reg &= ~CS4270_PWRCTL_PDN_ALL;
+
+	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+}
+#else
+#define cs4270_soc_suspend	NULL
+#define cs4270_soc_resume	NULL
+#endif /* CONFIG_PM */
+
+/*
+ * ASoC codec device structure
+ *
+ * Assign this variable to the codec_dev field of the machine driver's
+ * snd_soc_device structure.
+ */
+struct snd_soc_codec_driver soc_codec_device_cs4270 = {
+	.name = "CS4270",
+	.owner = THIS_MODULE,
+	.probe = 	cs4270_probe,
+	.remove = 	cs4270_remove,
+	.suspend =	cs4270_soc_suspend,
+	.resume =	cs4270_soc_resume,
+	.read = cs4270_read_reg_cache,
+	.write = cs4270_i2c_write,
+	.reg_cache_size = CS4270_NUMREGS,
+	.reg_word_size = sizeof(u8),
+};
+EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
+
 /**
  * cs4270_i2c_probe - initialize the I2C interface of the CS4270
  * @i2c_client: the I2C client object
@@ -677,22 +736,9 @@ static int cs4270_remove(struct platform_device *pdev)
 static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec;
 	struct cs4270_private *cs4270;
-	unsigned int reg;
 	int ret;
 
-	/* For now, we only support one cs4270 device in the system.  See the
-	 * comment for cs4270_codec.
-	 */
-	if (cs4270_codec) {
-		dev_err(&i2c_client->dev, "ignoring CS4270 at addr %X\n",
-		       i2c_client->addr);
-		dev_err(&i2c_client->dev, "only one per board allowed\n");
-		/* Should we return something other than ENODEV here? */
-		return -ENODEV;
-	}
-
 	/* Verify that we have a CS4270 */
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
@@ -719,87 +765,15 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		dev_err(&i2c_client->dev, "could not allocate codec\n");
 		return -ENOMEM;
 	}
-	codec = &cs4270->codec;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->dev = &i2c_client->dev;
-	codec->name = "CS4270";
-	codec->owner = THIS_MODULE;
-	codec->dai = &cs4270_dai;
-	codec->num_dai = 1;
-	snd_soc_codec_set_drvdata(codec, cs4270);
-	codec->control_data = i2c_client;
-	codec->read = cs4270_read_reg_cache;
-	codec->write = cs4270_i2c_write;
-	codec->reg_cache = cs4270->reg_cache;
-	codec->reg_cache_size = CS4270_NUMREGS;
-
-	/* The I2C interface is set up, so pre-fill our register cache */
-
-	ret = cs4270_fill_cache(codec);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to fill register cache\n");
-		goto error_free_codec;
-	}
-
-	/* Disable auto-mute.  This feature appears to be buggy.  In some
-	 * situations, auto-mute will not deactivate when it should, so we want
-	 * this feature disabled by default.  An application (e.g. alsactl) can
-	 * re-enabled it by using the controls.
-	 */
-
-	reg = cs4270_read_reg_cache(codec, CS4270_MUTE);
-	reg &= ~CS4270_MUTE_AUTO;
-	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "i2c write failed\n");
-		return ret;
-	}
-
-	/* Disable automatic volume control.  The hardware enables, and it
-	 * causes volume change commands to be delayed, sometimes until after
-	 * playback has started.  An application (e.g. alsactl) can
-	 * re-enabled it by using the controls.
-	 */
-
-	reg = cs4270_read_reg_cache(codec, CS4270_TRANS);
-	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
-	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "i2c write failed\n");
-		return ret;
-	}
-
-	/* Initialize the DAI. Normally, we'd prefer to have a kmalloc'd DAI
-	 * structure for each CS4270 device, but the machine driver needs to
-	 * have a pointer to the DAI structure, so for now it must be a global
-	 * variable.
-	 */
-	cs4270_dai.dev = &i2c_client->dev;
-
-	/* Register the DAI.  If all the other ASoC driver have already
-	 * registered, then this will call our probe function, so
-	 * cs4270_codec needs to be ready.
-	 */
-	cs4270_codec = codec;
-	ret = snd_soc_register_dai(&cs4270_dai);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to register DAIe\n");
-		goto error_free_codec;
-	}
 
 	i2c_set_clientdata(i2c_client, cs4270);
+	cs4270->control_data = i2c_client;
+	cs4270->control_type = SND_SOC_I2C;
 
-	return 0;
-
-error_free_codec:
-	kfree(cs4270);
-	cs4270_codec = NULL;
-	cs4270_dai.dev = NULL;
-
+	ret = snd_soc_register_codec(&i2c_client->dev, i2c_client->addr,
+			&soc_codec_device_cs4270, &cs4270_dai, 1);
+	if (ret < 0)
+		kfree(cs4270);
 	return ret;
 }
 
@@ -811,12 +785,8 @@ error_free_codec:
  */
 static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 {
-	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
-
-	kfree(cs4270);
-	cs4270_codec = NULL;
-	cs4270_dai.dev = NULL;
-
+	snd_soc_unregister_codec(&i2c_client->dev, i2c_client->addr);
+	kfree(i2c_get_clientdata(i2c_client));
 	return 0;
 }
 
@@ -829,72 +799,6 @@ static struct i2c_device_id cs4270_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs4270_id);
 
-#ifdef CONFIG_PM
-
-/* This suspend/resume implementation can handle both - a simple standby
- * where the codec remains powered, and a full suspend, where the voltage
- * domain the codec is connected to is teared down and/or any other hardware
- * reset condition is asserted.
- *
- * The codec's own power saving features are enabled in the suspend callback,
- * and all registers are written back to the hardware when resuming.
- */
-
-static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	struct snd_soc_codec *codec = cs4270_codec;
-	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int reg, ret;
-
-	reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
-	if (reg < 0)
-		return reg;
-
-	ret = snd_soc_write(codec, CS4270_PWRCTL, reg);
-	if (ret < 0)
-		return ret;
-
-	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies),
-			       cs4270->supplies);
-
-	return 0;
-}
-
-static int cs4270_soc_resume(struct platform_device *pdev)
-{
-	struct snd_soc_codec *codec = cs4270_codec;
-	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c_client = codec->control_data;
-	int reg;
-
-	regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
-			      cs4270->supplies);
-
-	/* In case the device was put to hard reset during sleep, we need to
-	 * wait 500ns here before any I2C communication. */
-	ndelay(500);
-
-	/* first restore the entire register cache ... */
-	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
-		u8 val = snd_soc_read(codec, reg);
-
-		if (i2c_smbus_write_byte_data(i2c_client, reg, val)) {
-			dev_err(codec->dev, "i2c write failed\n");
-			return -EIO;
-		}
-	}
-
-	/* ... then disable the power-down bits */
-	reg = snd_soc_read(codec, CS4270_PWRCTL);
-	reg &= ~CS4270_PWRCTL_PDN_ALL;
-
-	return snd_soc_write(codec, CS4270_PWRCTL, reg);
-}
-#else
-#define cs4270_soc_suspend	NULL
-#define cs4270_soc_resume	NULL
-#endif /* CONFIG_PM */
-
 /*
  * cs4270_i2c_driver - I2C device identification
  *
@@ -911,20 +815,6 @@ static struct i2c_driver cs4270_i2c_driver = {
 	.remove = cs4270_i2c_remove,
 };
 
-/*
- * ASoC codec device structure
- *
- * Assign this variable to the codec_dev field of the machine driver's
- * snd_soc_device structure.
- */
-struct snd_soc_codec_device soc_codec_device_cs4270 = {
-	.probe = 	cs4270_probe,
-	.remove = 	cs4270_remove,
-	.suspend =	cs4270_soc_suspend,
-	.resume =	cs4270_soc_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
-
 static int __init cs4270_init(void)
 {
 	pr_info("Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
diff --git a/sound/soc/codecs/cs4270.h b/sound/soc/codecs/cs4270.h
index adc6cd9..19d3009 100644
--- a/sound/soc/codecs/cs4270.h
+++ b/sound/soc/codecs/cs4270.h
@@ -16,13 +16,13 @@
  * The ASoC codec DAI structure for the CS4270.  Assign this structure to
  * the .codec_dai field of your machine driver's snd_soc_dai_link structure.
  */
-extern struct snd_soc_dai cs4270_dai;
+extern struct snd_soc_dai_driver cs4270_dai;
 
 /*
  * The ASoC codec device structure for the CS4270.  Assign this structure
  * to the .codec_dev field of your machine driver's snd_soc_device
  * structure.
  */
-extern struct snd_soc_codec_device soc_codec_device_cs4270;
+extern struct snd_soc_codec_driver soc_codec_device_cs4270;
 
 #endif
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index dd9b855..db26f51 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -42,15 +42,14 @@ enum master_slave_mode {
 };
 
 struct cs42l51_private {
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int mclk;
 	unsigned int audio_mode;	/* The mode (I2S or left-justified) */
 	enum master_slave_mode func;
-	struct snd_soc_codec codec;
 	u8 reg_cache[CS42L51_NUMREGS];
 };
 
-static struct snd_soc_codec *cs42l51_codec;
-
 #define CS42L51_FORMATS ( \
 		SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE  | \
 		SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S18_3BE | \
@@ -75,134 +74,6 @@ static int cs42l51_fill_cache(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
-	const struct i2c_device_id *id)
-{
-	struct snd_soc_codec *codec;
-	struct cs42l51_private *cs42l51;
-	int ret = 0;
-	int reg;
-
-	if (cs42l51_codec)
-		return -EBUSY;
-
-	/* Verify that we have a CS42L51 */
-	ret = i2c_smbus_read_byte_data(i2c_client, CS42L51_CHIP_REV_ID);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to read I2C\n");
-		goto error;
-	}
-
-	if ((ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_A)) &&
-	    (ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_B))) {
-		dev_err(&i2c_client->dev, "Invalid chip id\n");
-		ret = -ENODEV;
-		goto error;
-	}
-
-	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
-				ret & 7);
-
-	cs42l51 = kzalloc(sizeof(struct cs42l51_private), GFP_KERNEL);
-	if (!cs42l51) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
-		return -ENOMEM;
-	}
-	codec = &cs42l51->codec;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->dev = &i2c_client->dev;
-	codec->name = "CS42L51";
-	codec->owner = THIS_MODULE;
-	codec->dai = &cs42l51_dai;
-	codec->num_dai = 1;
-	snd_soc_codec_set_drvdata(codec, cs42l51);
-
-	codec->control_data = i2c_client;
-	codec->reg_cache = cs42l51->reg_cache;
-	codec->reg_cache_size = CS42L51_NUMREGS;
-	i2c_set_clientdata(i2c_client, codec);
-
-	ret = cs42l51_fill_cache(codec);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to fill register cache\n");
-		goto error_alloc;
-	}
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "Failed to set cache I/O: %d\n", ret);
-		goto error_alloc;
-	}
-
-	/*
-	 * DAC configuration
-	 * - Use signal processor
-	 * - auto mute
-	 * - vol changes immediate
-	 * - no de-emphasize
-	 */
-	reg = CS42L51_DAC_CTL_DATA_SEL(1)
-		| CS42L51_DAC_CTL_AMUTE | CS42L51_DAC_CTL_DACSZ(0);
-	ret = snd_soc_write(codec, CS42L51_DAC_CTL, reg);
-	if (ret < 0)
-		goto error_alloc;
-
-	cs42l51_dai.dev = codec->dev;
-	cs42l51_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto error_alloc;
-	}
-
-	ret = snd_soc_register_dai(&cs42l51_dai);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to register DAIe\n");
-		goto error_reg;
-	}
-
-	return 0;
-
-error_reg:
-	snd_soc_unregister_codec(codec);
-error_alloc:
-	kfree(cs42l51);
-error:
-	return ret;
-}
-
-static int cs42l51_i2c_remove(struct i2c_client *client)
-{
-	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
-	snd_soc_unregister_dai(&cs42l51_dai);
-	snd_soc_unregister_codec(cs42l51_codec);
-	cs42l51_codec = NULL;
-	kfree(cs42l51);
-	return 0;
-}
-
-
-static const struct i2c_device_id cs42l51_id[] = {
-	{"cs42l51", 0},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, cs42l51_id);
-
-static struct i2c_driver cs42l51_i2c_driver = {
-	.driver = {
-		.name = "CS42L51 I2C",
-		.owner = THIS_MODULE,
-	},
-	.id_table = cs42l51_id,
-	.probe = cs42l51_i2c_probe,
-	.remove = cs42l51_i2c_remove,
-};
-
 static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
@@ -484,51 +355,8 @@ static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
-	struct cs42l51_ratios *ratios = NULL;
-	int nr_ratios = 0;
-	unsigned int rates = 0;
-	unsigned int rate_min = -1;
-	unsigned int rate_max = 0;
-	int i;
 
 	cs42l51->mclk = freq;
-
-	switch (cs42l51->func) {
-	case MODE_MASTER:
-		return -EINVAL;
-	case MODE_SLAVE:
-		ratios = slave_ratios;
-		nr_ratios = ARRAY_SIZE(slave_ratios);
-		break;
-	case MODE_SLAVE_AUTO:
-		ratios = slave_auto_ratios;
-		nr_ratios = ARRAY_SIZE(slave_auto_ratios);
-		break;
-	}
-
-	for (i = 0; i < nr_ratios; i++) {
-		unsigned int rate = freq / ratios[i].ratio;
-		rates |= snd_pcm_rate_to_rate_bit(rate);
-		if (rate < rate_min)
-			rate_min = rate;
-		if (rate > rate_max)
-			rate_max = rate;
-	}
-	rates &= ~SNDRV_PCM_RATE_KNOT;
-
-	if (!rates) {
-		dev_err(codec->dev, "could not find a valid sample rate\n");
-		return -EINVAL;
-	}
-
-	codec_dai->playback.rates = rates;
-	codec_dai->playback.rate_min = rate_min;
-	codec_dai->playback.rate_max = rate_max;
-
-	codec_dai->capture.rates = rates;
-	codec_dai->capture.rate_min = rate_min;
-	codec_dai->capture.rate_max = rate_max;
-
 	return 0;
 }
 
@@ -537,8 +365,7 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	unsigned int i;
@@ -670,7 +497,7 @@ static struct snd_soc_dai_ops cs42l51_dai_ops = {
 	.digital_mute   = cs42l51_dai_mute,
 };
 
-struct snd_soc_dai cs42l51_dai = {
+struct snd_soc_dai_driver cs42l51_dai = {
 	.name = "CS42L51 HiFi",
 	.playback = {
 		.stream_name = "Playback",
@@ -691,27 +518,38 @@ struct snd_soc_dai cs42l51_dai = {
 EXPORT_SYMBOL_GPL(cs42l51_dai);
 
 
-static int cs42l51_probe(struct platform_device *pdev)
+static int cs42l51_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
+	struct cs42l51_private *cs42l51 = snd_soc_codec_get_drvdata(codec);
+	int ret, reg;
 
-	if (!cs42l51_codec) {
-		dev_err(&pdev->dev, "CS42L51 codec not yet registered\n");
-		return -EINVAL;
-	}
+	codec->control_data = cs42l51->control_data;
 
-	socdev->card->codec = cs42l51_codec;
-	codec = socdev->card->codec;
+	ret = cs42l51_fill_cache(codec);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to fill register cache\n");
+		return ret;
+	}
 
-	/* Register PCMs */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs42l51->control_type);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create PCMs\n");
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * DAC configuration
+	 * - Use signal processor
+	 * - auto mute
+	 * - vol changes immediate
+	 * - no de-emphasize
+	 */
+	reg = CS42L51_DAC_CTL_DATA_SEL(1)
+		| CS42L51_DAC_CTL_AMUTE | CS42L51_DAC_CTL_DACSZ(0);
+	ret = snd_soc_write(codec, CS42L51_DAC_CTL, reg);
+	if (ret < 0)
+		return ret;
+
 	snd_soc_add_controls(codec, cs42l51_snd_controls,
 		ARRAY_SIZE(cs42l51_snd_controls));
 	snd_soc_dapm_new_controls(codec, cs42l51_dapm_widgets,
@@ -722,22 +560,80 @@ static int cs42l51_probe(struct platform_device *pdev)
 	return 0;
 }
 
+struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
+	.name = "CS42L51",
+	.owner = THIS_MODULE,
+	.probe =	cs42l51_probe,
+	.reg_cache_size = CS42L51_NUMREGS,
+	.reg_word_size = sizeof(u8),
+};
+EXPORT_SYMBOL_GPL(soc_codec_device_cs42l51);
 
-static int cs42l51_remove(struct platform_device *pdev)
+static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
+	const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct cs42l51_private *cs42l51;
+	int ret;
+
+	/* Verify that we have a CS42L51 */
+	ret = i2c_smbus_read_byte_data(i2c_client, CS42L51_CHIP_REV_ID);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to read I2C\n");
+		goto error;
+	}
+
+	if ((ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_A)) &&
+	    (ret != CS42L51_MK_CHIP_REV(CS42L51_CHIP_ID, CS42L51_CHIP_REV_B))) {
+		dev_err(&i2c_client->dev, "Invalid chip id\n");
+		ret = -ENODEV;
+		goto error;
+	}
+
+	dev_info(&i2c_client->dev, "found device cs42l51 rev %d\n",
+				ret & 7);
+
+	cs42l51 = kzalloc(sizeof(struct cs42l51_private), GFP_KERNEL);
+	if (!cs42l51) {
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(i2c_client, cs42l51);
+	cs42l51->control_data = i2c_client;
+	cs42l51->control_type = SND_SOC_I2C;
+
+	ret =  snd_soc_register_codec(&i2c_client->dev, i2c_client->addr,
+			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
+	if (ret < 0)
+		kfree(cs42l51);
+error:
+	return ret;
+}
 
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+static int cs42l51_i2c_remove(struct i2c_client *client)
+{
+	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
 
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(cs42l51);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_device_cs42l51 = {
-	.probe =	cs42l51_probe,
-	.remove =	cs42l51_remove
+static const struct i2c_device_id cs42l51_id[] = {
+	{"cs42l51", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs42l51_id);
+
+static struct i2c_driver cs42l51_i2c_driver = {
+	.driver = {
+		.name = "CS42L51 I2C",
+		.owner = THIS_MODULE,
+	},
+	.id_table = cs42l51_id,
+	.probe = cs42l51_i2c_probe,
+	.remove = cs42l51_i2c_remove,
 };
-EXPORT_SYMBOL_GPL(soc_codec_device_cs42l51);
 
 static int __init cs42l51_init(void)
 {
diff --git a/sound/soc/codecs/cs42l51.h b/sound/soc/codecs/cs42l51.h
index 8f0bd97..2144b90 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -158,6 +158,6 @@
 #define CS42L51_LASTREG		0x20
 #define CS42L51_NUMREGS		(CS42L51_LASTREG - CS42L51_FIRSTREG + 1)
 
-extern struct snd_soc_dai cs42l51_dai;
-extern struct snd_soc_codec_device soc_codec_device_cs42l51;
+extern struct snd_soc_dai_driver cs42l51_dai;
+extern struct snd_soc_codec_driver soc_codec_device_cs42l51;
 #endif
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index a83aa18..9c50db1 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -138,11 +138,10 @@
 
 /* Codec private data */
 struct da7210_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
-static struct snd_soc_codec *da7210_codec;
-
 /*
  * Register cache
  */
@@ -185,12 +184,12 @@ static int da7210_write(struct snd_soc_codec *codec, u32 reg, u32 value)
 	u8 *cache = codec->reg_cache;
 	u8 data[2];
 
-	BUG_ON(codec->volatile_register);
+	BUG_ON(codec->driver->volatile_register);
 
 	data[0] = reg & 0xff;
 	data[1] = value & 0xff;
 
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -EIO;
 
 	if (2 != codec->hw_write(codec->control_data, data, 2))
@@ -247,8 +246,7 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u32 dai_cfg1;
 	u32 hpf_reg, hpf_mask, hpf_value;
 	u32 fs, bypass;
@@ -410,9 +408,8 @@ static struct snd_soc_dai_ops da7210_dai_ops = {
 	.set_fmt	= da7210_set_dai_fmt,
 };
 
-struct snd_soc_dai da7210_dai = {
+struct snd_soc_dai_driver da7210_dai = {
 	.name = "DA7210 IIS",
-	.id = 0,
 	/* playback capabilities */
 	.playback = {
 		.stream_name = "Playback",
@@ -434,53 +431,14 @@ struct snd_soc_dai da7210_dai = {
 };
 EXPORT_SYMBOL_GPL(da7210_dai);
 
-/*
- * Initialize the DA7210 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int da7210_init(struct da7210_priv *da7210)
+static int da7210_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = &da7210->codec;
-	int ret = 0;
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
 
-	if (da7210_codec) {
-		dev_err(codec->dev, "Another da7210 is registered\n");
-		return -EINVAL;
-	}
+	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, da7210);
-	codec->name		= "DA7210";
-	codec->owner		= THIS_MODULE;
-	codec->read		= da7210_read;
-	codec->write		= da7210_write;
-	codec->dai		= &da7210_dai;
-	codec->num_dai		= 1;
+	codec->control_data = da7210->control_data;
 	codec->hw_write		= (hw_write_t)i2c_master_send;
-	codec->reg_cache_size	= ARRAY_SIZE(da7210_reg);
-	codec->reg_cache	= kmemdup(da7210_reg,
-					  sizeof(da7210_reg), GFP_KERNEL);
-
-	if (!codec->reg_cache)
-		return -ENOMEM;
-
-	da7210_dai.dev = codec->dev;
-	da7210_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register CODEC: %d\n", ret);
-		goto init_err;
-	}
-
-	ret = snd_soc_register_dai(&da7210_dai);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto init_err;
-	}
 
 	/* FIXME
 	 *
@@ -563,50 +521,48 @@ static int da7210_init(struct da7210_priv *da7210)
 	/* Activate all enabled subsystem */
 	da7210_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
-	return ret;
-
-init_err:
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-
-	return ret;
-
+	return 0;
 }
 
+struct snd_soc_codec_driver soc_codec_dev_da7210 = {
+	.name		= "DA7210",
+	.owner		= THIS_MODULE,
+	.probe =	da7210_probe,
+	.read		= da7210_read,
+	.write		= da7210_write,
+	.reg_cache_size	= ARRAY_SIZE(da7210_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default	= da7210_reg,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_da7210);
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static int __devinit da7210_i2c_probe(struct i2c_client *i2c,
 			   	      const struct i2c_device_id *id)
 {
 	struct da7210_priv *da7210;
-	struct snd_soc_codec *codec;
 	int ret;
 
 	da7210 = kzalloc(sizeof(struct da7210_priv), GFP_KERNEL);
 	if (!da7210)
 		return -ENOMEM;
 
-	codec = &da7210->codec;
-	codec->dev = &i2c->dev;
-
 	i2c_set_clientdata(i2c, da7210);
-	codec->control_data = i2c;
+	da7210->control_data = i2c;
+	da7210->control_type = SND_SOC_I2C;
 
-	ret = da7210_init(da7210);
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_da7210, &da7210_dai, 1);
 	if (ret < 0)
-		pr_err("Failed to initialise da7210 audio codec\n");
+		kfree(da7210);
 
 	return ret;
 }
 
 static int __devexit da7210_i2c_remove(struct i2c_client *client)
 {
-	struct da7210_priv *da7210 = i2c_get_clientdata(client);
-
-	snd_soc_unregister_dai(&da7210_dai);
-	kfree(da7210->codec.reg_cache);
-	kfree(da7210);
-	da7210_codec = NULL;
-
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -628,47 +584,6 @@ static struct i2c_driver da7210_i2c_driver = {
 };
 #endif
 
-static int da7210_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (!da7210_codec) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = da7210_codec;
-	codec = da7210_codec;
-
-	/* Register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0)
-		goto pcm_err;
-
-	dev_info(&pdev->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
-
-pcm_err:
-	return ret;
-}
-
-static int da7210_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_da7210 = {
-	.probe =	da7210_probe,
-	.remove =	da7210_remove,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_da7210);
-
 static int __init da7210_modinit(void)
 {
 	int ret = 0;
diff --git a/sound/soc/codecs/da7210.h b/sound/soc/codecs/da7210.h
index 390d621..c530692 100644
--- a/sound/soc/codecs/da7210.h
+++ b/sound/soc/codecs/da7210.h
@@ -17,8 +17,8 @@
 #ifndef _DA7210_H
 #define _DA7210_H
 
-extern struct snd_soc_dai da7210_dai;
-extern struct snd_soc_codec_device soc_codec_dev_da7210;
+extern struct snd_soc_dai_driver da7210_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_da7210;
 
 #endif
 
-- 
1.7.0.4
