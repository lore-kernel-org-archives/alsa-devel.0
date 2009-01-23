From: Timur Tabi <timur@freescale.com>
Subject: [PATCH v2 2.6.30] ASoC: improve I2C initialization
	code in CS4270 driver
Date: Fri, 23 Jan 2009 16:31:19 -0600
Message-ID: <1232749879-27691-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DB9A61038FE
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 23:31:28 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Further improvements in the I2C initialization sequence of the CS4270 driver.
All ASoC initialization is now done in the I2C probe function.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |  252 ++++++++++++++++++++-------------------------
 1 files changed, 113 insertions(+), 139 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 2e4ce04..71986e1 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -29,12 +29,6 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 
-/* Private data for the CS4270 */
-struct cs4270_private {
-	unsigned int mclk; /* Input frequency of the MCLK pin */
-	unsigned int mode; /* The mode (I2S or left-justified) */
-};
-
 /*
  * The codec isn't really big-endian or little-endian, since the I2S
  * interface requires data to be sent serially with the MSbit first.
@@ -107,6 +101,14 @@ struct cs4270_private {
 #define CS4270_MUTE_DAC_A	0x01
 #define CS4270_MUTE_DAC_B	0x02
 
+/* Private data for the CS4270 */
+struct cs4270_private {
+	struct snd_soc_codec codec;
+	u8 reg_cache[CS4270_NUMREGS];
+	unsigned int mclk; /* Input frequency of the MCLK pin */
+	unsigned int mode; /* The mode (I2S or left-justified) */
+};
+
 /*
  * Clock Ratio Selection for Master Mode with I2C enabled
  *
@@ -502,6 +504,31 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
  */
 static struct snd_soc_device *cs4270_socdev;
 
+struct snd_soc_dai cs4270_dai = {
+	.name = "cs4270",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = 0,
+		.formats = CS4270_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = 0,
+		.formats = CS4270_FORMATS,
+	},
+	.ops = {
+		.hw_params = cs4270_hw_params,
+		.set_sysclk = cs4270_set_dai_sysclk,
+		.set_fmt = cs4270_set_dai_fmt,
+		.digital_mute = cs4270_mute,
+	},
+};
+EXPORT_SYMBOL_GPL(cs4270_dai);
+
 /*
  * Initialize the I2C interface of the CS4270
  *
@@ -515,47 +542,52 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
 	struct snd_soc_device *socdev = cs4270_socdev;
-	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_codec *codec;
+	struct cs4270_private *cs4270;
 	int i;
 	int ret = 0;
 
-	/* Probing all possible addresses has one drawback: if there are
-	   multiple CS4270s on the bus, then you cannot specify which
-	   socdev is matched with which CS4270.  For now, we just reject
-	   this I2C device if the socdev already has one attached. */
-	if (codec->control_data)
-		return -ENODEV;
-
-	/* Note: codec_dai->codec is NULL here */
-
-	codec->reg_cache = kzalloc(CS4270_NUMREGS, GFP_KERNEL);
-	if (!codec->reg_cache) {
-		printk(KERN_ERR "cs4270: could not allocate register cache\n");
-		ret = -ENOMEM;
-		goto error;
-	}
-
 	/* Verify that we have a CS4270 */
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: failed to read I2C\n");
-		goto error;
+		return ret;
 	}
 	/* The top four bits of the chip ID should be 1100. */
 	if ((ret & 0xF0) != 0xC0) {
-		/* The device at this address is not a CS4270 codec */
-		ret = -ENODEV;
-		goto error;
+		printk(KERN_ERR "cs4270: device at addr %X is not a CS4270\n",
+		       i2c_client->addr);
+		return -ENODEV;
 	}
 
 	printk(KERN_INFO "cs4270: found device at I2C address %X\n",
 		i2c_client->addr);
 	printk(KERN_INFO "cs4270: hardware revision %X\n", ret & 0xF);
 
+	/* Allocate enough space for the snd_soc_codec structure
+	   and our private data together. */
+	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
+	if (!cs4270) {
+		printk(KERN_ERR "cs4270: Could not allocate codec structure\n");
+		return -ENOMEM;
+	}
+	codec = &cs4270->codec;
+	socdev->codec = codec;
+
+	mutex_init(&codec->mutex);
+	INIT_LIST_HEAD(&codec->dapm_widgets);
+	INIT_LIST_HEAD(&codec->dapm_paths);
+
+	codec->name = "CS4270";
+	codec->owner = THIS_MODULE;
+	codec->dai = &cs4270_dai;
+	codec->num_dai = 1;
+	codec->private_data = cs4270;
 	codec->control_data = i2c_client;
 	codec->read = cs4270_read_reg_cache;
 	codec->write = cs4270_i2c_write;
+	codec->reg_cache = cs4270->reg_cache;
 	codec->reg_cache_size = CS4270_NUMREGS;
 
 	/* The I2C interface is set up, so pre-fill our register cache */
@@ -563,35 +595,72 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	ret = cs4270_fill_cache(codec);
 	if (ret < 0) {
 		printk(KERN_ERR "cs4270: failed to fill register cache\n");
-		goto error;
+		goto error_free_codec;
+	}
+
+	/* Register PCMs */
+
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "cs4270: failed to create PCMs\n");
+		goto error_free_codec;
 	}
 
 	/* Add the non-DAPM controls */
 
 	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl =
-		snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+		struct snd_kcontrol *kctrl;
+
+		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+		if (!kctrl) {
+			printk(KERN_ERR "cs4270: error creating control '%s'\n",
+			       cs4270_snd_controls[i].name);
+			ret = -ENOMEM;
+			goto error_free_pcms;
+		}
 
 		ret = snd_ctl_add(codec->card, kctrl);
-		if (ret < 0)
-			goto error;
+		if (ret < 0) {
+			printk(KERN_ERR "cs4270: error adding control '%s'\n",
+			       cs4270_snd_controls[i].name);
+			goto error_free_pcms;
+		}
 	}
 
-	i2c_set_clientdata(i2c_client, codec);
+	/* Initialize the SOC device */
+
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "cs4270: failed to register card\n");
+		goto error_free_pcms;;
+	}
+
+	i2c_set_clientdata(i2c_client, socdev);
 
 	return 0;
 
-error:
-	codec->control_data = NULL;
+error_free_pcms:
+	snd_soc_free_pcms(socdev);
 
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
-	codec->reg_cache_size = 0;
+error_free_codec:
+	kfree(cs4270);
 
 	return ret;
 }
 
-static const struct i2c_device_id cs4270_id[] = {
+static int cs4270_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct snd_soc_device *socdev = i2c_get_clientdata(i2c_client);
+	struct snd_soc_codec *codec = socdev->codec;
+	struct cs4270_private *cs4270 = codec->private_data;
+
+	snd_soc_free_pcms(socdev);
+	kfree(cs4270);
+
+	return 0;
+}
+
+static struct i2c_device_id cs4270_id[] = {
 	{"cs4270", 0},
 	{}
 };
@@ -604,27 +673,9 @@ static struct i2c_driver cs4270_i2c_driver = {
 	},
 	.id_table = cs4270_id,
 	.probe = cs4270_i2c_probe,
+	.remove = cs4270_i2c_remove,
 };
 
-struct snd_soc_dai cs4270_dai = {
-	.name = "CS4270",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = 0,
-		.formats = CS4270_FORMATS,
-	},
-	.capture = {
-		.stream_name = "Capture",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = 0,
-		.formats = CS4270_FORMATS,
-	},
-};
-EXPORT_SYMBOL_GPL(cs4270_dai);
-
 /*
  * ASoC probe function
  *
@@ -633,94 +684,15 @@ EXPORT_SYMBOL_GPL(cs4270_dai);
  */
 static int cs4270_probe(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	printk(KERN_INFO "CS4270 ALSA SoC Codec\n");
-
-	/* Allocate enough space for the snd_soc_codec structure
-	   and our private data together. */
-	codec = kzalloc(ALIGN(sizeof(struct snd_soc_codec), 4) +
-			sizeof(struct cs4270_private), GFP_KERNEL);
-	if (!codec) {
-		printk(KERN_ERR "cs4270: Could not allocate codec structure\n");
-		return -ENOMEM;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "CS4270";
-	codec->owner = THIS_MODULE;
-	codec->dai = &cs4270_dai;
-	codec->num_dai = 1;
-	codec->private_data = (void *) codec +
-		ALIGN(sizeof(struct snd_soc_codec), 4);
-
-	socdev->codec = codec;
-
-	/* Register PCMs */
-
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to create PCMs\n");
-		goto error_free_codec;
-	}
-
-	cs4270_socdev = socdev;
-
-	ret = i2c_add_driver(&cs4270_i2c_driver);
-	if (ret) {
-		printk(KERN_ERR "cs4270: failed to attach driver");
-		goto error_free_pcms;
-	}
-
-	/* Did we find a CS4270 on the I2C bus? */
-	if (!codec->control_data) {
-		printk(KERN_ERR "cs4270: failed to attach driver");
-		goto error_del_driver;
-	}
+	cs4270_socdev = platform_get_drvdata(pdev);;
 
-	/* Initialize codec ops */
-	cs4270_dai.ops.hw_params = cs4270_hw_params;
-	cs4270_dai.ops.set_sysclk = cs4270_set_dai_sysclk;
-	cs4270_dai.ops.set_fmt = cs4270_set_dai_fmt;
-	cs4270_dai.ops.digital_mute = cs4270_mute;
-
-	ret = snd_soc_init_card(socdev);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register card\n");
-		goto error_del_driver;
-	}
-
-	return 0;
-
-error_del_driver:
-	i2c_del_driver(&cs4270_i2c_driver);
-
-error_free_pcms:
-	snd_soc_free_pcms(socdev);
-
-error_free_codec:
-	kfree(socdev->codec);
-	socdev->codec = NULL;
-
-	return ret;
+	return i2c_add_driver(&cs4270_i2c_driver);
 }
 
 static int cs4270_remove(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-
 	i2c_del_driver(&cs4270_i2c_driver);
 
-	kfree(socdev->codec);
-	socdev->codec = NULL;
-
 	return 0;
 }
 
@@ -738,6 +710,8 @@ EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
 
 static int __init cs4270_init(void)
 {
+	printk(KERN_INFO "Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
+
 	return snd_soc_register_dai(&cs4270_dai);
 }
 module_init(cs4270_init);
-- 
1.5.5
