From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: fix initialization order of the
	CS4270 codec driver
Date: Thu, 29 Jan 2009 14:28:37 -0600
Message-ID: <1233260917-525-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 045D51037FE
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 21:28:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ASoC codec drivers typically serve two masters: the I2C bus and ASoC itself.
When a codec driver registers with ASoC, a probe function is called.  Most
codec drivers call ASoC first, and then register with the I2C bus in the ASoC
probe function.

However, in order to support multiple codecs on one board, it's easier if the
codec driver is probed via the I2C bus first.  This is because the call to
i2c_add_driver() can result in the I2C probe function being called multiple
times - once for each codec.  In the current design, the driver registers
once with ASoC, and in the ASoC probe function, it calls i2c_add_driver().
The results in the I2C probe function being called multiple times before the
driver can register with ASoC again.

The new design has the driver call i2c_add_driver() first.  In the I2C probe
function, the driver registers with ASoC.  This allows the ASoC probe function
to be called once per I2C device.

Also add code to check if the I2C probe function is called more than once,
since that is not supported with the current ASoC design.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |  177 +++++++++++++++++++++++++--------------------
 1 files changed, 97 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 21253b4..adc1150 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -490,21 +490,17 @@ static const struct snd_kcontrol_new cs4270_snd_controls[] = {
 };
 
 /*
- * Global variable to store socdev for i2c probe function.
+ * Global variable to store codec for the ASoC probe function.
  *
  * If struct i2c_driver had a private_data field, we wouldn't need to use
- * cs4270_socdec.  This is the only way to pass the socdev structure to
- * cs4270_i2c_probe().
- *
- * The real solution to cs4270_socdev is to create a mechanism
- * that maps I2C addresses to snd_soc_device structures.  Perhaps the
- * creation of the snd_soc_device object should be moved out of
- * cs4270_probe() and into cs4270_i2c_probe(), but that would make this
- * driver dependent on I2C.  The CS4270 supports "stand-alone" mode, whereby
- * the chip is *not* connected to the I2C bus, but is instead configured via
- * input pins.
+ * cs4270_codec.  This is the only way to pass the codec structure from
+ * cs4270_i2c_probe() to cs4270_probe().  Unfortunately, there is no good
+ * way to synchronize these two functions.  cs4270_i2c_probe() can be called
+ * multiple times before cs4270_probe() is called even once.  So for now, we
+ * also only allow cs4270_i2c_probe() to be run once.  That means that we do
+ * not support more than one cs4270 device in the system, at least for now.
  */
-static struct snd_soc_device *cs4270_socdev;
+static struct snd_soc_codec *cs4270_codec;
 
 struct snd_soc_dai cs4270_dai = {
 	.name = "cs4270",
@@ -532,6 +528,70 @@ struct snd_soc_dai cs4270_dai = {
 EXPORT_SYMBOL_GPL(cs4270_dai);
 
 /*
+ * ASoC probe function
+ */
+static int cs4270_probe(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	unsigned int i;
+	int ret;
+
+	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
+	socdev->card->codec = codec;
+
+	/* Register PCMs */
+	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	if (ret < 0) {
+		printk(KERN_ERR "cs4270: failed to create PCMs\n");
+		return ret;
+	}
+
+	/* Add the non-DAPM controls */
+	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
+		struct snd_kcontrol *kctrl;
+
+		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
+		if (!kctrl) {
+			printk(KERN_ERR "cs4270: error creating control '%s'\n",
+			       cs4270_snd_controls[i].name);
+			ret = -ENOMEM;
+			goto error_free_pcms;
+		}
+
+		ret = snd_ctl_add(codec->card, kctrl);
+		if (ret < 0) {
+			printk(KERN_ERR "cs4270: error adding control '%s'\n",
+			       cs4270_snd_controls[i].name);
+			goto error_free_pcms;
+		}
+	}
+
+	/* And finally, register the socdev */
+	ret = snd_soc_init_card(socdev);
+	if (ret < 0) {
+		printk(KERN_ERR "cs4270: failed to register card\n");
+		goto error_free_pcms;
+	}
+
+	return 0;
+
+error_free_pcms:
+	snd_soc_free_pcms(socdev);
+
+	return ret;
+}
+
+static int cs4270_remove(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+
+	snd_soc_free_pcms(socdev);
+
+	return 0;
+};
+
+/*
  * Initialize the I2C interface of the CS4270
  *
  * This function is called for whenever the I2C subsystem finds a device
@@ -543,17 +603,27 @@ EXPORT_SYMBOL_GPL(cs4270_dai);
 static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = cs4270_socdev;
 	struct snd_soc_codec *codec;
 	struct cs4270_private *cs4270;
-	int i;
-	int ret = 0;
+	int ret;
+
+	/* For now, we only support one cs4270 device in the system.  See the
+	 * comment for cs4270_codec.
+	 */
+	if (cs4270_codec) {
+		printk(KERN_ERR "cs4270: ignoring CS4270 at addr %X\n",
+		       i2c_client->addr);
+		printk(KERN_ERR "cs4270: only one CS4270 per board allowed\n");
+		/* Should we return something other than ENODEV here? */
+		return -ENODEV;
+	}
 
 	/* Verify that we have a CS4270 */
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to read I2C\n");
+		printk(KERN_ERR "cs4270: failed to read I2C at addr %X\n",
+		       i2c_client->addr);
 		return ret;
 	}
 	/* The top four bits of the chip ID should be 1100. */
@@ -575,7 +645,7 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		return -ENOMEM;
 	}
 	codec = &cs4270->codec;
-	socdev->card->codec = codec;
+	cs4270_codec = codec;
 
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
@@ -600,50 +670,20 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 		goto error_free_codec;
 	}
 
-	/* Register PCMs */
-
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	/* Register the DAI.  If all the other ASoC driver have already
+	 * registered, then this will call our probe function, so
+	 * cs4270_codec needs to be ready.
+	 */
+	ret = snd_soc_register_dai(&cs4270_dai);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to create PCMs\n");
+		printk(KERN_ERR "cs4270: failed to register DAIe\n");
 		goto error_free_codec;
 	}
 
-	/* Add the non-DAPM controls */
-
-	for (i = 0; i < ARRAY_SIZE(cs4270_snd_controls); i++) {
-		struct snd_kcontrol *kctrl;
-
-		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
-		if (!kctrl) {
-			printk(KERN_ERR "cs4270: error creating control '%s'\n",
-			       cs4270_snd_controls[i].name);
-			ret = -ENOMEM;
-			goto error_free_pcms;
-		}
-
-		ret = snd_ctl_add(codec->card, kctrl);
-		if (ret < 0) {
-			printk(KERN_ERR "cs4270: error adding control '%s'\n",
-			       cs4270_snd_controls[i].name);
-			goto error_free_pcms;
-		}
-	}
-
-	/* Initialize the SOC device */
-
-	ret = snd_soc_init_card(socdev);
-	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register card\n");
-		goto error_free_pcms;;
-	}
-
-	i2c_set_clientdata(i2c_client, socdev);
+	i2c_set_clientdata(i2c_client, cs4270);
 
 	return 0;
 
-error_free_pcms:
-	snd_soc_free_pcms(socdev);
-
 error_free_codec:
 	kfree(cs4270);
 
@@ -652,11 +692,8 @@ error_free_codec:
 
 static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 {
-	struct snd_soc_device *socdev = i2c_get_clientdata(i2c_client);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct cs4270_private *cs4270 = codec->private_data;
+	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
 
-	snd_soc_free_pcms(socdev);
 	kfree(cs4270);
 
 	return 0;
@@ -679,26 +716,6 @@ static struct i2c_driver cs4270_i2c_driver = {
 };
 
 /*
- * ASoC probe function
- *
- * This function is called when the machine driver calls
- * platform_device_add().
- */
-static int cs4270_probe(struct platform_device *pdev)
-{
-	cs4270_socdev = platform_get_drvdata(pdev);;
-
-	return i2c_add_driver(&cs4270_i2c_driver);
-}
-
-static int cs4270_remove(struct platform_device *pdev)
-{
-	i2c_del_driver(&cs4270_i2c_driver);
-
-	return 0;
-}
-
-/*
  * ASoC codec device structure
  *
  * Assign this variable to the codec_dev field of the machine driver's
@@ -714,13 +731,13 @@ static int __init cs4270_init(void)
 {
 	printk(KERN_INFO "Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
 
-	return snd_soc_register_dai(&cs4270_dai);
+	return i2c_add_driver(&cs4270_i2c_driver);
 }
 module_init(cs4270_init);
 
 static void __exit cs4270_exit(void)
 {
-	snd_soc_unregister_dai(&cs4270_dai);
+	i2c_del_driver(&cs4270_i2c_driver);
 }
 module_exit(cs4270_exit);
 
-- 
1.5.5
