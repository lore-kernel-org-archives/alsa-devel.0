From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 2.6.30] ASoC: fix message display in CS4270
	codec driver
Date: Mon,  2 Feb 2009 15:08:29 -0600
Message-ID: <1233608909-9934-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 50A292414D
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 22:08:33 +0100 (CET)
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

Replace printk calls with dev_xxx calls.  Set the 'dev' field of the codec
and codec_dai structures so that these calls work.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/cs4270.c |   66 ++++++++++++++++++++++++++------------------
 1 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 7962874..2c79a24 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -212,7 +212,7 @@ static int cs4270_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	rates &= ~SNDRV_PCM_RATE_KNOT;
 
 	if (!rates) {
-		printk(KERN_ERR "cs4270: could not find a valid sample rate\n");
+		dev_err(codec->dev, "could not find a valid sample rate\n");
 		return -EINVAL;
 	}
 
@@ -253,7 +253,7 @@ static int cs4270_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		cs4270->mode = format & SND_SOC_DAIFMT_FORMAT_MASK;
 		break;
 	default:
-		printk(KERN_ERR "cs4270: invalid DAI format\n");
+		dev_err(codec->dev, "invalid dai format\n");
 		ret = -EINVAL;
 	}
 
@@ -284,7 +284,7 @@ static int cs4270_fill_cache(struct snd_soc_codec *codec)
 		CS4270_FIRSTREG | 0x80, CS4270_NUMREGS, cache);
 
 	if (length != CS4270_NUMREGS) {
-		printk(KERN_ERR "cs4270: I2C read failure, addr=0x%x\n",
+		dev_err(codec->dev, "i2c read failure, addr=0x%x\n",
 		       i2c_client->addr);
 		return -EIO;
 	}
@@ -340,7 +340,7 @@ static int cs4270_i2c_write(struct snd_soc_codec *codec, unsigned int reg,
 	if (cache[reg - CS4270_FIRSTREG] != value) {
 		struct i2c_client *client = codec->control_data;
 		if (i2c_smbus_write_byte_data(client, reg, value)) {
-			printk(KERN_ERR "cs4270: I2C write failed\n");
+			dev_err(codec->dev, "i2c write failed\n");
 			return -EIO;
 		}
 
@@ -391,7 +391,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	if (i == NUM_MCLK_RATIOS) {
 		/* We did not find a matching ratio */
-		printk(KERN_ERR "cs4270: could not find matching ratio\n");
+		dev_err(codec->dev, "could not find matching ratio\n");
 		return -EINVAL;
 	}
 
@@ -401,7 +401,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 			    CS4270_PWRCTL_PDN_ADC | CS4270_PWRCTL_PDN_DAC |
 			    CS4270_PWRCTL_PDN);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -413,7 +413,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_write(codec, CS4270_MODE, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -430,13 +430,13 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 		reg |= CS4270_FORMAT_DAC_LJ | CS4270_FORMAT_ADC_LJ;
 		break;
 	default:
-		printk(KERN_ERR "cs4270: unknown format\n");
+		dev_err(codec->dev, "unknown dai format\n");
 		return -EINVAL;
 	}
 
 	ret = snd_soc_write(codec, CS4270_FORMAT, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -447,7 +447,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	reg &= ~CS4270_MUTE_AUTO;
 	ret = snd_soc_write(codec, CS4270_MUTE, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -460,7 +460,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 	reg &= ~(CS4270_TRANS_SOFT | CS4270_TRANS_ZERO);
 	ret = cs4270_i2c_write(codec, CS4270_TRANS, reg);
 	if (ret < 0) {
-		printk(KERN_ERR "I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -468,7 +468,7 @@ static int cs4270_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_write(codec, CS4270_PWRCTL, 0);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: I2C write failed\n");
+		dev_err(codec->dev, "i2c write failed\n");
 		return ret;
 	}
 
@@ -570,7 +570,7 @@ static int cs4270_probe(struct platform_device *pdev)
 	/* Register PCMs */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to create PCMs\n");
+		dev_err(codec->dev, "failed to create pcms\n");
 		return ret;
 	}
 
@@ -580,7 +580,7 @@ static int cs4270_probe(struct platform_device *pdev)
 
 		kctrl = snd_soc_cnew(&cs4270_snd_controls[i], codec, NULL);
 		if (!kctrl) {
-			printk(KERN_ERR "cs4270: error creating control '%s'\n",
+			dev_err(codec->dev, "error creating control '%s'\n",
 			       cs4270_snd_controls[i].name);
 			ret = -ENOMEM;
 			goto error_free_pcms;
@@ -588,7 +588,7 @@ static int cs4270_probe(struct platform_device *pdev)
 
 		ret = snd_ctl_add(codec->card, kctrl);
 		if (ret < 0) {
-			printk(KERN_ERR "cs4270: error adding control '%s'\n",
+			dev_err(codec->dev, "error adding control '%s'\n",
 			       cs4270_snd_controls[i].name);
 			goto error_free_pcms;
 		}
@@ -597,7 +597,7 @@ static int cs4270_probe(struct platform_device *pdev)
 	/* And finally, register the socdev */
 	ret = snd_soc_init_card(socdev);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register card\n");
+		dev_err(codec->dev, "failed to register card\n");
 		goto error_free_pcms;
 	}
 
@@ -643,9 +643,9 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 	 * comment for cs4270_codec.
 	 */
 	if (cs4270_codec) {
-		printk(KERN_ERR "cs4270: ignoring CS4270 at addr %X\n",
+		dev_err(&i2c_client->dev, "ignoring CS4270 at addr %X\n",
 		       i2c_client->addr);
-		printk(KERN_ERR "cs4270: only one CS4270 per board allowed\n");
+		dev_err(&i2c_client->dev, "only one per board allowed\n");
 		/* Should we return something other than ENODEV here? */
 		return -ENODEV;
 	}
@@ -654,35 +654,35 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 	ret = i2c_smbus_read_byte_data(i2c_client, CS4270_CHIPID);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to read I2C at addr %X\n",
+		dev_err(&i2c_client->dev, "failed to read i2c at addr %X\n",
 		       i2c_client->addr);
 		return ret;
 	}
 	/* The top four bits of the chip ID should be 1100. */
 	if ((ret & 0xF0) != 0xC0) {
-		printk(KERN_ERR "cs4270: device at addr %X is not a CS4270\n",
+		dev_err(&i2c_client->dev, "device at addr %X is not a CS4270\n",
 		       i2c_client->addr);
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "cs4270: found device at I2C address %X\n",
+	dev_info(&i2c_client->dev, "found device at i2c address %X\n",
 		i2c_client->addr);
-	printk(KERN_INFO "cs4270: hardware revision %X\n", ret & 0xF);
+	dev_info(&i2c_client->dev, "hardware revision %X\n", ret & 0xF);
 
 	/* Allocate enough space for the snd_soc_codec structure
 	   and our private data together. */
 	cs4270 = kzalloc(sizeof(struct cs4270_private), GFP_KERNEL);
 	if (!cs4270) {
-		printk(KERN_ERR "cs4270: Could not allocate codec structure\n");
+		dev_err(&i2c_client->dev, "could not allocate codec\n");
 		return -ENOMEM;
 	}
 	codec = &cs4270->codec;
-	cs4270_codec = codec;
 
 	mutex_init(&codec->mutex);
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
+	codec->dev = &i2c_client->dev;
 	codec->name = "CS4270";
 	codec->owner = THIS_MODULE;
 	codec->dai = &cs4270_dai;
@@ -698,17 +698,25 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 	ret = cs4270_fill_cache(codec);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to fill register cache\n");
+		dev_err(&i2c_client->dev, "failed to fill register cache\n");
 		goto error_free_codec;
 	}
 
+	/* Initialize the DAI. Normally, we'd prefer to have a kmalloc'd DAI
+	 * structure for each CS4270 device, but the machine driver needs to
+	 * have a pointer to the DAI structure, so for now it must be a global
+	 * variable.
+	 */
+	cs4270_dai.dev = &i2c_client->dev;
+
 	/* Register the DAI.  If all the other ASoC driver have already
 	 * registered, then this will call our probe function, so
 	 * cs4270_codec needs to be ready.
 	 */
+	cs4270_codec = codec;
 	ret = snd_soc_register_dai(&cs4270_dai);
 	if (ret < 0) {
-		printk(KERN_ERR "cs4270: failed to register DAIe\n");
+		dev_err(&i2c_client->dev, "failed to register DAIe\n");
 		goto error_free_codec;
 	}
 
@@ -718,6 +726,8 @@ static int cs4270_i2c_probe(struct i2c_client *i2c_client,
 
 error_free_codec:
 	kfree(cs4270);
+	cs4270_codec = NULL;
+	cs4270_dai.dev = NULL;
 
 	return ret;
 }
@@ -733,6 +743,8 @@ static int cs4270_i2c_remove(struct i2c_client *i2c_client)
 	struct cs4270_private *cs4270 = i2c_get_clientdata(i2c_client);
 
 	kfree(cs4270);
+	cs4270_codec = NULL;
+	cs4270_dai.dev = NULL;
 
 	return 0;
 }
@@ -776,7 +788,7 @@ EXPORT_SYMBOL_GPL(soc_codec_device_cs4270);
 
 static int __init cs4270_init(void)
 {
-	printk(KERN_INFO "Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
+	pr_info("Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
 
 	return i2c_add_driver(&cs4270_i2c_driver);
 }
-- 
1.5.5
