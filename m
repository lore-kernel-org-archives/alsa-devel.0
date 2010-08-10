From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 02/17] ASoC: multi-component - cs4720,
	cs42l51 and da7210 CODECs
Date: Wed, 11 Aug 2010 00:02:53 +0100
Message-ID: <1281481388-3000-3-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F070103841
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:28 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11453003wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:28 -0700 (PDT)
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

Move codecs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o cs42151 and cs4270: set_dai_sysclk() - we no longer change static _driver_
 rates on clock changes (as the driver can be used by other cs24xx codec
 devices). The codec device rate is checked at hw_params() time.

CS4270 portions:
Acked-by: Timur Tabi <timur@freescale.com>

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c  |  393 ++++++++++++++++----------------------------
 sound/soc/codecs/cs4270.h  |   28 ---
 sound/soc/codecs/cs42l51.c |  293 ++++++++++----------------------
 sound/soc/codecs/cs42l51.h |    2 -
 sound/soc/codecs/da7210.c  |  157 ++++--------------
 5 files changed, 262 insertions(+), 611 deletions(-)
 delete mode 100644 sound/soc/codecs/cs4270.h

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 30d9492..6542dc0 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -31,8 +31,6 @@
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 
-#include "cs4270.h"
-
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
  * interface requires data to be sent serially with the MSbit first.
@@ -114,7 +112,8 @@ static const char *supply_names[] = {
 
 /* Private data for the CS4270 */
 struct cs4270_private {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u8 reg_cache[CS4270_NUMREGS];
 	unsigned int mclk; /* Input frequency of the MCLK pin */
 	unsigned int mode; /* The mode (I2S or left-justified) */
@@ -212,44 +211,8 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
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
 
@@ -410,8 +373,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 	unsigned int i;
@@ -549,19 +511,6 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
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
@@ -569,20 +518,24 @@ static struct snd_soc_dai_ops cs4270_dai_ops = {
 	.digital_mute	= cs4270_dai_mute,
 };
 
-struct snd_soc_dai cs4270_dai = {
-	.name = "cs4270",
+struct snd_soc_dai_driver cs4270_dai = {
+	.name = "cs4270-hifi",
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
@@ -596,153 +549,19 @@ EXPORT_SYMBOL_GPL(cs4270_dai);
  * This function is called when ASoC has all the pieces it needs to
  * instantiate a sound driver.
  */
-static int cs4270_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = cs4270_codec;
-	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
-	int i, ret;
-
-	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
-	socdev->card->codec = codec;
-
-	/* Register PCMs */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
-		return ret;
-	}
-
-	/* Add the non-DAPM controls */
-	ret = snd_soc_add_controls(codec, cs4270_snd_controls,
-				ARRAY_SIZE(cs4270_snd_controls));
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to add controls\n");
-		goto error_free_pcms;
-	}
-
-	/* get the power supply regulators */
-	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-		cs4270->supplies[i].supply = supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(cs4270->supplies),
-				 cs4270->supplies);
-	if (ret < 0)
-		goto error_free_pcms;
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
-				    cs4270->supplies);
-	if (ret < 0)
-		goto error_free_regulators;
-
-	return 0;
-
-error_free_regulators:
-	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
-			    cs4270->supplies);
-
-error_free_pcms:
-	snd_soc_free_pcms(socdev);
-
-	return ret;
-}
-
-/**
- * cs4270_remove - ASoC remove function
- * @pdev: platform device
- *
- * This function is the counterpart to cs4270_probe().
- */
-static int cs4270_remove(struct platform_device *pdev)
+static int cs4270_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = cs4270_codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
+	int i, ret, reg;
 
-	snd_soc_free_pcms(socdev);
-	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
-	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
-
-	return 0;
-};
-
-/**
- * cs4270_i2c_probe - initialize the I2C interface of the CS4270
- * @i2c_client: the I2C client object
- * @id: the I2C device ID (ignored)
- *
- * This function is called whenever the I2C subsystem finds a device that
- * matches the device ID given via a prior call to i2c_add_driver().
- */
-static int cs4270_i2c_probe(struct i2c_client *i2c_client,
-	const struct i2c_device_id *id)
-{
-	struct snd_soc_codec *codec;
-	struct cs4270_private *cs4270;
-	unsigned int reg;
-	int ret;
-
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
-	/* Verify that we have a CS4270 */
-
-	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
-	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to read i2c at addr %X\n",
-		       i2c_client->addr);
-		return ret;
-	}
-	/* The top four bits of the chip ID should be 1100. */
-	if ((ret & 0xF0) != 0xC0) {
-		dev_err(&i2c_client->dev, "device at addr %X is not a CS4270\n",
-		       i2c_client->addr);
-		return -ENODEV;
-	}
-
-	dev_info(&i2c_client->dev, "found device at i2c address %X\n",
-		i2c_client->addr);
-	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
-
-	/* Allocate enough space for the snd_soc_codec structure
-	   and our private data together. */
-	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
-	if (!cs4270) {
-		dev_err(&i2c_client->dev, "could not allocate codec\n");
-		return -ENOMEM;
-	}
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
+	codec->control_data = cs4270->control_data;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
 
 	ret = cs4270_fill_cache(codec);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to fill register cache\n");
-		goto error_free_codec;
+		dev_err(codec->dev, "failed to fill register cache\n");
+		return ret;
 	}
 
 	/* Disable auto-mute.  This feature appears to be buggy.  In some
@@ -755,7 +574,7 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	reg &= ~CS4270_MUTE_AUTO;
 	ret = cs4270_i2c_write(codec, CS4270_MUTE, reg);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "i2c write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -769,65 +588,56 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
 	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "i2c write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
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
+	/* Add the non-DAPM controls */
+	ret = snd_soc_add_controls(codec, cs4270_snd_controls,
+				ARRAY_SIZE(cs4270_snd_controls));
 	if (ret < 0) {
-		dev_err(&i2c_client->dev, "failed to register DAIe\n");
-		goto error_free_codec;
+		dev_err(codec->dev, "failed to add controls\n");
+		return ret;
 	}
 
-	i2c_set_clientdata(i2c_client, cs4270);
+	/* get the power supply regulators */
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		cs4270->supplies[i].supply = supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(cs4270->supplies),
+				 cs4270->supplies);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
+				    cs4270->supplies);
+	if (ret < 0)
+		goto error_free_regulators;
 
 	return 0;
 
-error_free_codec:
-	kfree(cs4270);
-	cs4270_codec = NULL;
-	cs4270_dai.dev = NULL;
+error_free_regulators:
+	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies),
+			    cs4270->supplies);
 
 	return ret;
 }
 
 /**
- * cs4270_i2c_remove - remove an I2C device
- * @i2c_client: the I2C client object
+ * cs4270_remove - ASoC remove function
+ * @pdev: platform device
  *
- * This function is the counterpart to cs4270_i2c_probe().
+ * This function is the counterpart to cs4270_probe().
  */
-static int cs4270_i2c_remove(struct i2c_client *i2c_client)
+static int cs4270_remove(struct snd_soc_codec *codec)
 {
-	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
+	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 
-	kfree(cs4270);
-	cs4270_codec = NULL;
-	cs4270_dai.dev = NULL;
+	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
+	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 
 	return 0;
-}
-
-/*
- * cs4270_id - I2C device IDs supported by this driver
- */
-static struct i2c_device_id cs4270_id[] = {
-	{"cs4270", 0},
-	{}
 };
-MODULE_DEVICE_TABLE(i2c, cs4270_id);
 
 #ifdef CONFIG_PM
 
@@ -840,9 +650,8 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
  * and all registers are written back to the hardware when resuming.
  */
 
-static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int cs4270_soc_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
 {
-	struct snd_soc_codec *codec = cs4270_codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int reg, ret;
 
@@ -860,9 +669,8 @@ static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
-static int cs4270_soc_resume(struct platform_device *pdev)
+static int cs4270_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = cs4270_codec;
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c_client = codec->control_data;
 	int reg;
@@ -896,6 +704,95 @@ static int cs4270_soc_resume(struct platform_device *pdev)
 #endif /* CONFIG_PM */
 
 /*
+ * ASoC codec device structure
+ *
+ * Assign this variable to the codec_dev field of the machine driver's
+ * snd_soc_device structure.
+ */
+static struct snd_soc_codec_driver soc_codec_device_cs4270 = {
+	.probe =	cs4270_probe,
+	.remove =	cs4270_remove,
+	.suspend =	cs4270_soc_suspend,
+	.resume =	cs4270_soc_resume,
+	.read = cs4270_read_reg_cache,
+	.write = cs4270_i2c_write,
+	.reg_cache_size = CS4270_NUMREGS,
+	.reg_word_size = sizeof(u8),
+};
+
+/**
+ * cs4270_i2c_probe - initialize the I2C interface of the CS4270
+ * @i2c_client: the I2C client object
+ * @id: the I2C device ID (ignored)
+ *
+ * This function is called whenever the I2C subsystem finds a device that
+ * matches the device ID given via a prior call to i2c_add_driver().
+ */
+static int cs4270_i2c_probe(struct i2c_client *i2c_client,
+	const struct i2c_device_id *id)
+{
+	struct cs4270_private *cs4270;
+	int ret;
+
+	/* Verify that we have a CS4270 */
+
+	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
+	if (ret < 0) {
+		dev_err(&i2c_client->dev, "failed to read i2c at addr %X\n",
+		       i2c_client->addr);
+		return ret;
+	}
+	/* The top four bits of the chip ID should be 1100. */
+	if ((ret & 0xF0) != 0xC0) {
+		dev_err(&i2c_client->dev, "device at addr %X is not a CS4270\n",
+		       i2c_client->addr);
+		return -ENODEV;
+	}
+
+	dev_info(&i2c_client->dev, "found device at i2c address %X\n",
+		i2c_client->addr);
+	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
+
+	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
+	if (!cs4270) {
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(i2c_client, cs4270);
+	cs4270->control_data = i2c_client;
+	cs4270->control_type = SND_SOC_I2C;
+
+	ret = snd_soc_register_codec(&i2c_client->dev,
+			&soc_codec_device_cs4270, &cs4270_dai, 1);
+	if (ret < 0)
+		kfree(cs4270);
+	return ret;
+}
+
+/**
+ * cs4270_i2c_remove - remove an I2C device
+ * @i2c_client: the I2C client object
+ *
+ * This function is the counterpart to cs4270_i2c_probe().
+ */
+static int cs4270_i2c_remove(struct i2c_client *i2c_client)
+{
+	snd_soc_unregister_codec(&i2c_client->dev);
+	kfree(i2c_get_clientdata(i2c_client));
+	return 0;
+}
+
+/*
+ * cs4270_id - I2C device IDs supported by this driver
+ */
+static struct i2c_device_id cs4270_id[] = {
+	{"cs4270", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cs4270_id);
+
+/*
  * cs4270_i2c_driver - I2C device identification
  *
  * This structure tells the I2C subsystem how to identify and support a
@@ -903,7 +800,7 @@ static int cs4270_soc_resume(struct platform_device *pdev)
  */
 static struct i2c_driver cs4270_i2c_driver = {
 	.driver = {
-		.name = "cs4270",
+		.name = "cs4270-codec",
 		.owner = THIS_MODULE,
 	},
 	.id_table = cs4270_id,
@@ -911,20 +808,6 @@ static struct i2c_driver cs4270_i2c_driver = {
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
deleted file mode 100644
index adc6cd9..0000000
--- a/sound/soc/codecs/cs4270.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Cirrus Logic CS4270 ALSA SoC Codec Driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef _CS4270_H
-#define _CS4270_H
-
-/*
- * The ASoC codec DAI structure for the CS4270.  Assign this structure to
- * the .codec_dai field of your machine driver's snd_soc_dai_link structure.
- */
-extern struct snd_soc_dai cs4270_dai;
-
-/*
- * The ASoC codec device structure for the CS4270.  Assign this structure
- * to the .codec_dev field of your machine driver's snd_soc_device
- * structure.
- */
-extern struct snd_soc_codec_device soc_codec_device_cs4270;
-
-#endif
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index dd9b855..8a25743 100644
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
@@ -670,8 +497,8 @@ static struct snd_soc_dai_ops cs42l51_dai_ops = {
 	.digital_mute   = cs42l51_dai_mute,
 };
 
-struct snd_soc_dai cs42l51_dai = {
-	.name = "CS42L51 HiFi",
+static struct snd_soc_dai_driver cs42l51_dai = {
+	.name = "cs42l51-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -688,30 +515,39 @@ struct snd_soc_dai cs42l51_dai = {
 	},
 	.ops = &cs42l51_dai_ops,
 };
-EXPORT_SYMBOL_GPL(cs42l51_dai);
-
 
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
@@ -722,22 +558,77 @@ static int cs42l51_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_device_cs42l51 = {
+	.probe =	cs42l51_probe,
+	.reg_cache_size = CS42L51_NUMREGS,
+	.reg_word_size = sizeof(u8),
+};
 
-static int cs42l51_remove(struct platform_device *pdev)
+static int cs42l51_i2c_probe(struct i2c_client *i2c_client,
+	const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct cs42l51_private *cs42l51;
+	int ret;
 
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
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
 
+	ret =  snd_soc_register_codec(&i2c_client->dev,
+			&soc_codec_device_cs42l51, &cs42l51_dai, 1);
+	if (ret < 0)
+		kfree(cs42l51);
+error:
+	return ret;
+}
+
+static int cs42l51_i2c_remove(struct i2c_client *client)
+{
+	struct cs42l51_private *cs42l51 = i2c_get_clientdata(client);
+
+	snd_soc_unregister_codec(&client->dev);
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
+		.name = "cs42L51-codec",
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
index 8f0bd97..2beeb17 100644
--- a/sound/soc/codecs/cs42l51.h
+++ b/sound/soc/codecs/cs42l51.h
@@ -158,6 +158,4 @@
 #define CS42L51_LASTREG		0x20
 #define CS42L51_NUMREGS		(CS42L51_LASTREG - CS42L51_FIRSTREG + 1)
 
-extern struct snd_soc_dai cs42l51_dai;
-extern struct snd_soc_codec_device soc_codec_device_cs42l51;
 #endif
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 3c51d6a..eabf3c0 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -25,8 +25,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include "da7210.h"
-
 /* DA7210 register space */
 #define DA7210_STATUS			0x02
 #define DA7210_STARTUP1			0x03
@@ -162,11 +160,10 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
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
@@ -209,12 +206,12 @@ static int da7210_write(struct snd_soc_codec *codec, u32 reg, u32 value)
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
@@ -267,8 +264,7 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u32 dai_cfg1;
 	u32 hpf_reg, hpf_mask, hpf_value;
 	u32 fs, bypass;
@@ -430,9 +426,8 @@ static struct snd_soc_dai_ops da7210_dai_ops = {
 	.set_fmt	= da7210_set_dai_fmt,
 };
 
-struct snd_soc_dai da7210_dai = {
-	.name = "DA7210 IIS",
-	.id = 0,
+static struct snd_soc_dai_driver da7210_dai = {
+	.name = "da7210-hifi",
 	/* playback capabilities */
 	.playback = {
 		.stream_name = "Playback",
@@ -452,55 +447,15 @@ struct snd_soc_dai da7210_dai = {
 	.ops = &da7210_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(da7210_dai);
 
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
-		goto codec_err;
-	}
 
 	/* FIXME
 	 *
@@ -583,54 +538,50 @@ static int da7210_init(struct da7210_priv *da7210)
 	/* Activate all enabled subsystem */
 	da7210_write(codec, DA7210_STARTUP1, DA7210_SC_MST_EN);
 
-	return ret;
-
-codec_err:
-	snd_soc_unregister_codec(codec);
-init_err:
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
+	snd_soc_add_controls(codec, da7210_snd_controls,
+			     ARRAY_SIZE(da7210_snd_controls));
 
-	return ret;
+	dev_info(codec->dev, "DA7210 Audio Codec %s\n", DA7210_VERSION);
 
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_da7210 = {
+	.probe =	da7210_probe,
+	.read		= da7210_read,
+	.write		= da7210_write,
+	.reg_cache_size	= ARRAY_SIZE(da7210_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default	= da7210_reg,
+};
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
-	if (ret < 0) {
-		pr_err("Failed to initialise da7210 audio codec\n");
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_da7210, &da7210_dai, 1);
+	if (ret < 0)
 		kfree(da7210);
-	}
 
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
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -643,7 +594,7 @@ MODULE_DEVICE_TABLE(i2c, da7210_i2c_id);
 /* I2C codec control layer */
 static struct i2c_driver da7210_i2c_driver = {
 	.driver = {
-		.name = "DA7210 I2C Codec",
+		.name = "da7210-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe = da7210_i2c_probe,
@@ -652,50 +603,6 @@ static struct i2c_driver da7210_i2c_driver = {
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
-	snd_soc_add_controls(da7210_codec, da7210_snd_controls,
-			     ARRAY_SIZE(da7210_snd_controls));
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
-- 
1.7.0.4
