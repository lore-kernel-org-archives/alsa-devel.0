From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 01/17] ASoC: multi-component - AKM CODECs
Date: Wed, 11 Aug 2010 00:02:52 +0100
Message-ID: <1281481388-3000-2-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 46C6224448
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:26 +0200 (CEST)
Received: by wyb42 with SMTP id 42so11453003wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:25 -0700 (PDT)
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

Move AKM CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o ak4535: set_bias_level() has to perform mute IO directly rather than via
 ak4535 mute since struct codec no longer contains dai.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/ak4104.c |  149 ++++++++++------------------
 sound/soc/codecs/ak4104.h |    4 +-
 sound/soc/codecs/ak4535.c |  236 ++++++++++++---------------------------------
 sound/soc/codecs/ak4535.h |    8 --
 sound/soc/codecs/ak4642.c |  175 +++++++--------------------------
 sound/soc/codecs/ak4642.h |    4 +-
 sound/soc/codecs/ak4671.c |  141 ++++++---------------------
 sound/soc/codecs/ak4671.h |    3 -
 8 files changed, 185 insertions(+), 535 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 192aebd..c27f8f5 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -17,8 +17,6 @@
 #include <linux/spi/spi.h>
 #include <sound/asoundef.h>
 
-#include "ak4104.h"
-
 /* AK4104 registers addresses */
 #define AK4104_REG_CONTROL1		0x00
 #define AK4104_REG_RESERVED		0x01
@@ -45,11 +43,11 @@
 #define AK4104_TX_TXE			(1 << 0)
 #define AK4104_TX_V			(1 << 1)
 
-#define DRV_NAME "ak4104"
+#define DRV_NAME "ak4104-codec"
 
 struct ak4104_private {
-	struct snd_soc_codec codec;
-	u8 reg_cache[AK4104_NUM_REGS];
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
 static int ak4104_fill_cache(struct snd_soc_codec *codec)
@@ -58,7 +56,7 @@ static int ak4104_fill_cache(struct snd_soc_codec *codec)
 	u8 *reg_cache = codec->reg_cache;
 	struct spi_device *spi = codec->control_data;
 
-	for (i = 0; i < codec->reg_cache_size; i++) {
+	for (i = 0; i < codec->driver->reg_cache_size; i++) {
 		int ret = spi_w8r8(spi, i | AK4104_READ);
 		if (ret < 0) {
 			dev_err(&spi->dev, "SPI write failure\n");
@@ -76,7 +74,7 @@ static unsigned int ak4104_read_reg_cache(struct snd_soc_codec *codec,
 {
 	u8 *reg_cache = codec->reg_cache;
 
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -EINVAL;
 
 	return reg_cache[reg];
@@ -88,7 +86,7 @@ static int ak4104_spi_write(struct snd_soc_codec *codec, unsigned int reg,
 	u8 *cache = codec->reg_cache;
 	struct spi_device *spi = codec->control_data;
 
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -EINVAL;
 
 	/* only write to the hardware if value has changed */
@@ -145,8 +143,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	int val = 0;
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
@@ -178,8 +175,8 @@ static struct snd_soc_dai_ops ak4101_dai_ops = {
 	.set_fmt = ak4104_set_dai_fmt,
 };
 
-struct snd_soc_dai ak4104_dai = {
-	.name = DRV_NAME,
+static struct snd_soc_dai_driver ak4104_dai = {
+	.name = "ak4104-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -192,45 +189,17 @@ struct snd_soc_dai ak4104_dai = {
 	.ops = &ak4101_dai_ops,
 };
 
-static struct snd_soc_codec *ak4104_codec;
-
-static int ak4104_spi_probe(struct spi_device *spi)
+static int ak4104_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec;
-	struct ak4104_private *ak4104;
+	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
 	int ret, val;
 
-	spi->bits_per_word = 8;
-	spi->mode = SPI_MODE_0;
-	ret = spi_setup(spi);
-	if (ret < 0)
-		return ret;
-
-	ak4104 = kzalloc(sizeof(struct ak4104_private), GFP_KERNEL);
-	if (!ak4104) {
-		dev_err(&spi->dev, "could not allocate codec\n");
-		return -ENOMEM;
-	}
-
-	codec = &ak4104->codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->dev = &spi->dev;
-	codec->name = DRV_NAME;
-	codec->owner = THIS_MODULE;
-	codec->dai = &ak4104_dai;
-	codec->num_dai = 1;
-	snd_soc_codec_set_drvdata(codec, ak4104);
-	codec->control_data = spi;
-	codec->reg_cache = ak4104->reg_cache;
-	codec->reg_cache_size = AK4104_NUM_REGS;
+	codec->control_data = ak4104->control_data;
 
 	/* read all regs and fill the cache */
 	ret = ak4104_fill_cache(codec);
 	if (ret < 0) {
-		dev_err(&spi->dev, "failed to fill register cache\n");
+		dev_err(codec->dev, "failed to fill register cache\n");
 		return ret;
 	}
 
@@ -238,93 +207,81 @@ static int ak4104_spi_probe(struct spi_device *spi)
 	 * should contain 0x5b. Not a good way to verify the presence of
 	 * the device, but there is no hardware ID register. */
 	if (ak4104_read_reg_cache(codec, AK4104_REG_RESERVED) !=
-					 AK4104_RESERVED_VAL) {
-		ret = -ENODEV;
-		goto error_free_codec;
-	}
+					 AK4104_RESERVED_VAL)
+		return -ENODEV;
 
 	/* set power-up and non-reset bits */
 	val = ak4104_read_reg_cache(codec, AK4104_REG_CONTROL1);
 	val |= AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN;
 	ret = ak4104_spi_write(codec, AK4104_REG_CONTROL1, val);
 	if (ret < 0)
-		goto error_free_codec;
+		return ret;
 
 	/* enable transmitter */
 	val = ak4104_read_reg_cache(codec, AK4104_REG_TX);
 	val |= AK4104_TX_TXE;
 	ret = ak4104_spi_write(codec, AK4104_REG_TX, val);
 	if (ret < 0)
-		goto error_free_codec;
-
-	ak4104_codec = codec;
-	ret = snd_soc_register_dai(&ak4104_dai);
-	if (ret < 0) {
-		dev_err(&spi->dev, "failed to register DAI\n");
-		goto error_free_codec;
-	}
+		return ret;
 
-	spi_set_drvdata(spi, ak4104);
-	dev_info(&spi->dev, "SPI device initialized\n");
+	dev_info(codec->dev, "SPI device initialized\n");
 	return 0;
-
-error_free_codec:
-	kfree(ak4104);
-	ak4104_dai.dev = NULL;
-	return ret;
 }
 
-static int __devexit ak4104_spi_remove(struct spi_device *spi)
+static int ak4104_remove(struct snd_soc_codec *codec)
 {
-	int ret, val;
-	struct ak4104_private *ak4104 = spi_get_drvdata(spi);
+	int val, ret;
 
-	val = ak4104_read_reg_cache(&ak4104->codec, AK4104_REG_CONTROL1);
+	val = ak4104_read_reg_cache(codec, AK4104_REG_CONTROL1);
 	if (val < 0)
 		return val;
 
 	/* clear power-up and non-reset bits */
 	val &= ~(AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
-	ret = ak4104_spi_write(&ak4104->codec, AK4104_REG_CONTROL1, val);
-	if (ret < 0)
-		return ret;
+	ret = ak4104_spi_write(codec, AK4104_REG_CONTROL1, val);
 
-	ak4104_codec = NULL;
-	kfree(ak4104);
-	return 0;
+	return ret;
 }
 
-static int ak4104_probe(struct platform_device *pdev)
+static struct snd_soc_codec_driver soc_codec_device_ak4104 = {
+	.probe =	ak4104_probe,
+	.remove =	ak4104_remove,
+	.reg_cache_size = AK4104_NUM_REGS,
+	.reg_word_size = sizeof(u16),
+};
+
+static int ak4104_spi_probe(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = ak4104_codec;
+	struct ak4104_private *ak4104;
 	int ret;
 
-	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
-	socdev->card->codec = codec;
-
-	/* Register PCMs */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	ret = spi_setup(spi);
+	if (ret < 0)
 		return ret;
-	}
 
-	return 0;
+	ak4104 = kzalloc(sizeof(struct ak4104_private), GFP_KERNEL);
+	if (ak4104 == NULL)
+		return -ENOMEM;
+
+	ak4104->control_data = spi;
+	ak4104->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, ak4104);
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&soc_codec_device_ak4104, &ak4104_dai, 1);
+	if (ret < 0)
+		kfree(ak4104);
+	return ret;
 }
 
-static int ak4104_remove(struct platform_device *pdev)
+static int __devexit ak4104_spi_remove(struct spi_device *spi)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	snd_soc_free_pcms(socdev);
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
 	return 0;
-};
-
-struct snd_soc_codec_device soc_codec_device_ak4104 = {
-	.probe = 	ak4104_probe,
-	.remove = 	ak4104_remove
-};
-EXPORT_SYMBOL_GPL(soc_codec_device_ak4104);
+}
 
 static struct spi_driver ak4104_spi_driver = {
 	.driver  = {
diff --git a/sound/soc/codecs/ak4104.h b/sound/soc/codecs/ak4104.h
index eb88fe7..51e8922 100644
--- a/sound/soc/codecs/ak4104.h
+++ b/sound/soc/codecs/ak4104.h
@@ -1,7 +1,7 @@
 #ifndef _AK4104_H
 #define _AK4104_H
 
-extern struct snd_soc_dai ak4104_dai;
-extern struct snd_soc_codec_device soc_codec_device_ak4104;
+extern struct snd_soc_dai_driver ak4104_dai;
+extern struct snd_soc_codec_driver soc_codec_device_ak4104;
 
 #endif
diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index d425367..cd88c8f 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -31,11 +31,11 @@
 
 #define AK4535_VERSION "0.3"
 
-struct snd_soc_codec_device soc_codec_dev_ak4535;
-
 /* codec private data */
 struct ak4535_priv {
 	unsigned int sysclk;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
 /*
@@ -313,8 +313,7 @@ static int ak4535_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
 	u8 mode2 = ak4535_read_reg_cache(codec, AK4535_MODE2) & ~(0x3 << 5);
 	int rate = params_rate(params), fs = 256;
@@ -378,14 +377,16 @@ static int ak4535_mute(struct snd_soc_dai *dai, int mute)
 static int ak4535_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
-	u16 i;
+	u16 i, mute_reg;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		ak4535_mute(codec->dai, 0);
+		mute_reg = ak4535_read_reg_cache(codec, AK4535_DAC) & 0xffdf;
+		ak4535_write(codec, AK4535_DAC, mute_reg);
 		break;
 	case SND_SOC_BIAS_PREPARE:
-		ak4535_mute(codec->dai, 1);
+		mute_reg = ak4535_read_reg_cache(codec, AK4535_DAC) & 0xffdf;
+		ak4535_write(codec, AK4535_DAC, mute_reg | 0x20);
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		i = ak4535_read_reg_cache(codec, AK4535_PM1);
@@ -413,8 +414,8 @@ static struct snd_soc_dai_ops ak4535_dai_ops = {
 	.set_sysclk	= ak4535_set_dai_sysclk,
 };
 
-struct snd_soc_dai ak4535_dai = {
-	.name = "AK4535",
+static struct snd_soc_dai_driver ak4535_dai = {
+	.name = "ak4535-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -429,54 +430,27 @@ struct snd_soc_dai ak4535_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.ops = &ak4535_dai_ops,
 };
-EXPORT_SYMBOL_GPL(ak4535_dai);
 
-static int ak4535_suspend(struct platform_device *pdev, pm_message_t state)
+static int ak4535_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int ak4535_resume(struct platform_device *pdev)
+static int ak4535_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	ak4535_sync(codec);
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
-/*
- * initialise the AK4535 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int ak4535_init(struct snd_soc_device *socdev)
+static int ak4535_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret = 0;
+	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
 
-	codec->name = "AK4535";
-	codec->owner = THIS_MODULE;
-	codec->read = ak4535_read_reg_cache;
-	codec->write = ak4535_write;
-	codec->set_bias_level = ak4535_set_bias_level;
-	codec->dai = &ak4535_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(ak4535_reg);
-	codec->reg_cache = kmemdup(ak4535_reg, sizeof(ak4535_reg), GFP_KERNEL);
-
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	printk(KERN_INFO "AK4535 Audio Codec %s", AK4535_VERSION);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "ak4535: failed to create pcms\n");
-		goto pcm_err;
-	}
+	codec->control_data = ak4535->control_data;
 
 	/* power on device */
 	ak4535_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -485,39 +459,55 @@ static int ak4535_init(struct snd_soc_device *socdev)
 				ARRAY_SIZE(ak4535_snd_controls));
 	ak4535_add_widgets(codec);
 
-	return ret;
-
-pcm_err:
-	kfree(codec->reg_cache);
+	return 0;
+}
 
-	return ret;
+/* power down chip */
+static int ak4535_remove(struct snd_soc_codec *codec)
+{
+	ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-static struct snd_soc_device *ak4535_socdev;
+static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
+	.probe =	ak4535_probe,
+	.remove =	ak4535_remove,
+	.suspend =	ak4535_suspend,
+	.resume =	ak4535_resume,
+	.read = ak4535_read_reg_cache,
+	.write = ak4535_write,
+	.set_bias_level = ak4535_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(ak4535_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = ak4535_reg,
+};
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-
-static int ak4535_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int ak4535_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = ak4535_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct ak4535_priv *ak4535;
 	int ret;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	ak4535 = kzalloc(sizeof(struct ak4535_priv), GFP_KERNEL);
+	if (ak4535 == NULL)
+		return -ENOMEM;
 
-	ret = ak4535_init(socdev);
-	if (ret < 0)
-		printk(KERN_ERR "failed to initialise AK4535\n");
+	i2c_set_clientdata(i2c, ak4535);
+	ak4535->control_data = i2c;
+	ak4535->control_type = SND_SOC_I2C;
 
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_ak4535, &ak4535_dai, 1);
+	if (ret < 0)
+		kfree(ak4535);
 	return ret;
 }
 
-static int ak4535_i2c_remove(struct i2c_client *client)
+static __devexit int ak4535_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -529,138 +519,34 @@ MODULE_DEVICE_TABLE(i2c, ak4535_i2c_id);
 
 static struct i2c_driver ak4535_i2c_driver = {
 	.driver = {
-		.name = "AK4535 I2C Codec",
+		.name = "ak4535-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    ak4535_i2c_probe,
-	.remove =   ak4535_i2c_remove,
+	.remove =   __devexit_p(ak4535_i2c_remove),
 	.id_table = ak4535_i2c_id,
 };
-
-static int ak4535_add_i2c_device(struct platform_device *pdev,
-				 const struct ak4535_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&ak4535_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "ak4535", I2C_NAME_SIZE);
-
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-			setup->i2c_bus);
-		goto err_driver;
-	}
-
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-			(unsigned int)info.addr);
-		goto err_driver;
-	}
-
-	return 0;
-
-err_driver:
-	i2c_del_driver(&ak4535_i2c_driver);
-	return -ENODEV;
-}
 #endif
 
-static int ak4535_probe(struct platform_device *pdev)
+static int __init ak4535_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct ak4535_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct ak4535_priv *ak4535;
-	int ret;
-
-	printk(KERN_INFO "AK4535 Audio Codec %s", AK4535_VERSION);
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	ak4535 = kzalloc(sizeof(struct ak4535_priv), GFP_KERNEL);
-	if (ak4535 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	snd_soc_codec_set_drvdata(codec, ak4535);
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	ak4535_socdev = socdev;
-	ret = -ENODEV;
-
+	int ret = 0;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = ak4535_add_i2c_device(pdev, setup);
-	}
-#endif
-
+	ret = i2c_add_driver(&ak4535_i2c_driver);
 	if (ret != 0) {
-		kfree(snd_soc_codec_get_drvdata(codec));
-		kfree(codec);
+		printk(KERN_ERR "Failed to register AK4535 I2C driver: %d\n",
+		       ret);
 	}
+#endif
 	return ret;
 }
+module_init(ak4535_modinit);
 
-/* power down chip */
-static int ak4535_remove(struct platform_device *pdev)
+static void __exit ak4535_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		ak4535_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (codec->control_data)
-		i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&ak4535_i2c_driver);
 #endif
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_ak4535 = {
-	.probe = 	ak4535_probe,
-	.remove = 	ak4535_remove,
-	.suspend = 	ak4535_suspend,
-	.resume =	ak4535_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_ak4535);
-
-static int __init ak4535_modinit(void)
-{
-	return snd_soc_register_dai(&ak4535_dai);
-}
-module_init(ak4535_modinit);
-
-static void __exit ak4535_exit(void)
-{
-	snd_soc_unregister_dai(&ak4535_dai);
 }
 module_exit(ak4535_exit);
 
diff --git a/sound/soc/codecs/ak4535.h b/sound/soc/codecs/ak4535.h
index c7a5870..0431e5f 100644
--- a/sound/soc/codecs/ak4535.h
+++ b/sound/soc/codecs/ak4535.h
@@ -36,12 +36,4 @@
 
 #define AK4535_CACHEREGNUM 	0x10
 
-struct ak4535_setup_data {
-	int            i2c_bus;
-	unsigned short i2c_address;
-};
-
-extern struct snd_soc_dai ak4535_dai;
-extern struct snd_soc_codec_device soc_codec_dev_ak4535;
-
 #endif
diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 3d7dc55..31b35e9 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -30,8 +30,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include "ak4642.h"
-
 #define AK4642_VERSION "0.0.1"
 
 #define PW_MGMT1	0x00
@@ -102,7 +100,6 @@
 #define FS3		(1 << 5)
 #define FS_MASK		(FS0 | FS1 | FS2 | FS3)
 
-struct snd_soc_codec_device soc_codec_dev_ak4642;
 
 /*
  * Playback Volume (table 39)
@@ -123,11 +120,11 @@ static const struct snd_kcontrol_new ak4642_snd_controls[] = {
 
 /* codec private data */
 struct ak4642_priv {
-	struct snd_soc_codec codec;
+	unsigned int sysclk;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
-static struct snd_soc_codec *ak4642_codec;
-
 /*
  * ak4642 register cache
  */
@@ -393,8 +390,8 @@ static struct snd_soc_dai_ops ak4642_dai_ops = {
 	.hw_params	= ak4642_dai_hw_params,
 };
 
-struct snd_soc_dai ak4642_dai = {
-	.name = "AK4642",
+static struct snd_soc_dai_driver ak4642_dai = {
+	.name = "ak4642-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -410,112 +407,63 @@ struct snd_soc_dai ak4642_dai = {
 	.ops = &ak4642_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(ak4642_dai);
 
-static int ak4642_resume(struct platform_device *pdev)
+static int ak4642_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	ak4642_sync(codec);
 	return 0;
 }
 
-/*
- * initialise the AK4642 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int ak4642_init(struct ak4642_priv *ak4642)
+
+static int ak4642_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = &ak4642->codec;
-	int ret = 0;
+	struct ak4642_priv *ak4642 = snd_soc_codec_get_drvdata(codec);
 
-	if (ak4642_codec) {
-		dev_err(codec->dev, "Another ak4642 is registered\n");
-		return -EINVAL;
-	}
+	dev_info(codec->dev, "AK4642 Audio Codec %s", AK4642_VERSION);
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, ak4642);
-	codec->name		= "AK4642";
-	codec->owner		= THIS_MODULE;
-	codec->read		= ak4642_read_reg_cache;
-	codec->write		= ak4642_write;
-	codec->dai		= &ak4642_dai;
-	codec->num_dai		= 1;
 	codec->hw_write		= (hw_write_t)i2c_master_send;
-	codec->reg_cache_size	= ARRAY_SIZE(ak4642_reg);
-	codec->reg_cache	= kmemdup(ak4642_reg,
-					  sizeof(ak4642_reg), GFP_KERNEL);
-
-	if (!codec->reg_cache)
-		return -ENOMEM;
-
-	ak4642_dai.dev = codec->dev;
-	ak4642_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto reg_cache_err;
-	}
+	codec->control_data = ak4642->control_data;
 
-	ret = snd_soc_register_dai(&ak4642_dai);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		goto reg_cache_err;
-	}
-
-	return ret;
-
-reg_cache_err:
-	kfree(codec->reg_cache);
-	codec->reg_cache = NULL;
 
-	return ret;
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
+	.probe =	ak4642_probe,
+	.resume =	ak4642_resume,
+	.read		= ak4642_read_reg_cache,
+	.write		= ak4642_write,
+	.reg_cache_size	= ARRAY_SIZE(ak4642_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default	= ak4642_reg,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-static int ak4642_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static __devinit int ak4642_i2c_probe(struct i2c_client *i2c,
+				      const struct i2c_device_id *id)
 {
 	struct ak4642_priv *ak4642;
-	struct snd_soc_codec *codec;
 	int ret;
 
 	ak4642 = kzalloc(sizeof(struct ak4642_priv), GFP_KERNEL);
-	if (!ak4642)
+	if (ak4642 == NULL)
 		return -ENOMEM;
 
-	codec = &ak4642->codec;
-	codec->dev = &i2c->dev;
-
 	i2c_set_clientdata(i2c, ak4642);
-	codec->control_data = i2c;
+	ak4642->control_data = i2c;
+	ak4642->control_type = SND_SOC_I2C;
 
-	ret = ak4642_init(ak4642);
-	if (ret < 0) {
-		printk(KERN_ERR "failed to initialise AK4642\n");
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_ak4642, &ak4642_dai, 1);
+	if (ret < 0)
 		kfree(ak4642);
-	}
-
 	return ret;
 }
 
-static int ak4642_i2c_remove(struct i2c_client *client)
+static __devexit int ak4642_i2c_remove(struct i2c_client *client)
 {
-	struct ak4642_priv *ak4642 = i2c_get_clientdata(client);
-
-	snd_soc_unregister_dai(&ak4642_dai);
-	snd_soc_unregister_codec(&ak4642->codec);
-	kfree(ak4642->codec.reg_cache);
-	kfree(ak4642);
-	ak4642_codec = NULL;
-
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -528,64 +476,15 @@ MODULE_DEVICE_TABLE(i2c, ak4642_i2c_id);
 
 static struct i2c_driver ak4642_i2c_driver = {
 	.driver = {
-		.name = "AK4642 I2C Codec",
+		.name = "ak4642-codec",
 		.owner = THIS_MODULE,
 	},
-	.probe		= ak4642_i2c_probe,
-	.remove		= ak4642_i2c_remove,
-	.id_table	= ak4642_i2c_id,
+	.probe =    ak4642_i2c_probe,
+	.remove =   __devexit_p(ak4642_i2c_remove),
+	.id_table = ak4642_i2c_id,
 };
-
 #endif
 
-static int ak4642_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	int ret;
-
-	if (!ak4642_codec) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = ak4642_codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "ak4642: failed to create pcms\n");
-		goto pcm_err;
-	}
-
-	snd_soc_add_controls(ak4642_codec, ak4642_snd_controls,
-			     ARRAY_SIZE(ak4642_snd_controls));
-
-	dev_info(&pdev->dev, "AK4642 Audio Codec %s", AK4642_VERSION);
-	return ret;
-
-pcm_err:
-	return ret;
-
-}
-
-/* power down chip */
-static int ak4642_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_ak4642 = {
-	.probe =	ak4642_probe,
-	.remove =	ak4642_remove,
-	.resume =	ak4642_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_ak4642);
-
 static int __init ak4642_modinit(void)
 {
 	int ret = 0;
diff --git a/sound/soc/codecs/ak4642.h b/sound/soc/codecs/ak4642.h
index e476833..d5a9e43 100644
--- a/sound/soc/codecs/ak4642.h
+++ b/sound/soc/codecs/ak4642.h
@@ -14,7 +14,7 @@
 #ifndef _AK4642_H
 #define _AK4642_H
 
-extern struct snd_soc_dai ak4642_dai;
-extern struct snd_soc_codec_device soc_codec_dev_ak4642;
+extern struct snd_soc_dai_driver ak4642_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_ak4642;
 
 #endif
diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 8756693..239f056 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -23,11 +23,11 @@
 
 #include "ak4671.h"
 
-static struct snd_soc_codec *ak4671_codec;
 
 /* codec private data */
 struct ak4671_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u8 reg_cache[AK4671_CACHEREGNUM];
 };
 
@@ -619,8 +619,8 @@ static struct snd_soc_dai_ops ak4671_dai_ops = {
 	.set_fmt	= ak4671_set_dai_fmt,
 };
 
-struct snd_soc_dai ak4671_dai = {
-	.name = "AK4671",
+static struct snd_soc_dai_driver ak4671_dai = {
+	.name = "ak4671-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -635,27 +635,19 @@ struct snd_soc_dai ak4671_dai = {
 		.formats = AK4671_FORMATS,},
 	.ops = &ak4671_dai_ops,
 };
-EXPORT_SYMBOL_GPL(ak4671_dai);
 
-static int ak4671_probe(struct platform_device *pdev)
+static int ak4671_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	if (ak4671_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
+	struct ak4671_priv *ak4671 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	socdev->card->codec = ak4671_codec;
-	codec = ak4671_codec;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->bias_level = SND_SOC_BIAS_OFF;
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4671->control_type);
 	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		return ret;
 	}
 
 	snd_soc_add_controls(codec, ak4671_snd_controls,
@@ -665,121 +657,48 @@ static int ak4671_probe(struct platform_device *pdev)
 	ak4671_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return ret;
-
-pcm_err:
-	return ret;
 }
 
-static int ak4671_remove(struct platform_device *pdev)
+static int ak4671_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	ak4671_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_ak4671 = {
+static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.probe = ak4671_probe,
 	.remove = ak4671_remove,
+	.set_bias_level = ak4671_set_bias_level,
+	.reg_cache_size = AK4671_CACHEREGNUM,
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = ak4671_reg,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_ak4671);
-
-static int ak4671_register(struct ak4671_priv *ak4671,
-		enum snd_soc_control_type control)
-{
-	int ret;
-	struct snd_soc_codec *codec = &ak4671->codec;
-
-	if (ak4671_codec) {
-		dev_err(codec->dev, "Another AK4671 is registered\n");
-		ret = -EINVAL;
-		goto err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec,  ak4671);
-	codec->name = "AK4671";
-	codec->owner = THIS_MODULE;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = ak4671_set_bias_level;
-	codec->dai = &ak4671_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = AK4671_CACHEREGNUM;
-	codec->reg_cache = &ak4671->reg_cache;
-
-	memcpy(codec->reg_cache, ak4671_reg, sizeof(ak4671_reg));
-
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, control);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		goto err;
-	}
-
-	ak4671_dai.dev = codec->dev;
-	ak4671_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&ak4671_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	kfree(ak4671);
-	return ret;
-}
-
-static void ak4671_unregister(struct ak4671_priv *ak4671)
-{
-	ak4671_set_bias_level(&ak4671->codec, SND_SOC_BIAS_OFF);
-	snd_soc_unregister_dai(&ak4671_dai);
-	snd_soc_unregister_codec(&ak4671->codec);
-	kfree(ak4671);
-	ak4671_codec = NULL;
-}
 
 static int __devinit ak4671_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct ak4671_priv *ak4671;
-	struct snd_soc_codec *codec;
+	int ret;
 
 	ak4671 = kzalloc(sizeof(struct ak4671_priv), GFP_KERNEL);
 	if (ak4671 == NULL)
 		return -ENOMEM;
 
-	codec = &ak4671->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(client, ak4671);
-	codec->control_data = client;
-
-	codec->dev = &client->dev;
+	ak4671->control_data = client;
+	ak4671->control_type = SND_SOC_I2C;
 
-	return ak4671_register(ak4671, SND_SOC_I2C);
+	ret = snd_soc_register_codec(&client->dev,
+			&soc_codec_dev_ak4671, &ak4671_dai, 1);
+	if (ret < 0)
+		kfree(ak4671);
+	return ret;
 }
 
 static __devexit int ak4671_i2c_remove(struct i2c_client *client)
 {
-	struct ak4671_priv *ak4671 = i2c_get_clientdata(client);
-
-	ak4671_unregister(ak4671);
-
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -791,7 +710,7 @@ MODULE_DEVICE_TABLE(i2c, ak4671_i2c_id);
 
 static struct i2c_driver ak4671_i2c_driver = {
 	.driver = {
-		.name = "ak4671",
+		.name = "ak4671-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe = ak4671_i2c_probe,
diff --git a/sound/soc/codecs/ak4671.h b/sound/soc/codecs/ak4671.h
index e2fad96..61cb7ab 100644
--- a/sound/soc/codecs/ak4671.h
+++ b/sound/soc/codecs/ak4671.h
@@ -150,7 +150,4 @@
 /* AK4671_LOUT2_POWER_MANAGEMENT (0x10) Fields */
 #define AK4671_MUTEN				0x04
 
-extern struct snd_soc_dai ak4671_dai;
-extern struct snd_soc_codec_device soc_codec_dev_ak4671;
-
 #endif
-- 
1.7.0.4
