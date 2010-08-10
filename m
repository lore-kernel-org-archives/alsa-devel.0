From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 04/17] ASoC: multi-component - TI CODECs
Date: Wed, 11 Aug 2010 00:02:55 +0100
Message-ID: <1281481388-3000-5-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 9029F103852
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:34 +0200 (CEST)
Received: by wwd20 with SMTP id 20so3289390wwd.2
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:34 -0700 (PDT)
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
Cc: Ryan Mallon <ryan@bluewatersys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Move TI CODECs to multi-component

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o tlv320aic3x: no more "setup_data" from ASoC machine drivers, platform data
 must be set in one place only. Moved platform defs out into platorm header.

Some TLV320aic23 parts
Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Some TWl4030 and TLV320DAC33 parts
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/tlv320aic3x.h    |   43 +++++++-
 sound/soc/codecs/tlv320aic23.c |  182 ++++++++++--------------------
 sound/soc/codecs/tlv320aic23.h |    3 -
 sound/soc/codecs/tlv320aic26.c |  180 ++++++++++-------------------
 sound/soc/codecs/tlv320aic26.h |    3 -
 sound/soc/codecs/tlv320aic3x.c |  223 ++++++++++++------------------------
 sound/soc/codecs/tlv320aic3x.h |   43 -------
 sound/soc/codecs/tlv320dac33.c |  249 +++++++++++++---------------------------
 sound/soc/codecs/tlv320dac33.h |    3 -
 sound/soc/codecs/twl4030.c     |  231 ++++++++++++--------------------------
 sound/soc/codecs/twl4030.h     |   55 ---------
 sound/soc/codecs/twl6040.c     |  170 +++++++--------------------
 sound/soc/codecs/twl6040.h     |    3 -
 13 files changed, 431 insertions(+), 957 deletions(-)
 delete mode 100644 sound/soc/codecs/twl4030.h

diff --git a/include/sound/tlv320aic3x.h b/include/sound/tlv320aic3x.h
index b1a5f34..99e0308 100644
--- a/include/sound/tlv320aic3x.h
+++ b/include/sound/tlv320aic3x.h
@@ -10,8 +10,49 @@
 #ifndef __TLV320AIC3x_H__
 #define __TLV320AIC3x_H__
 
+/* GPIO API */
+enum {
+	AIC3X_GPIO1_FUNC_DISABLED		= 0,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX		= 2,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
+	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
+	AIC3X_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
+	AIC3X_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
+	AIC3X_GPIO1_FUNC_INPUT			= 8,
+	AIC3X_GPIO1_FUNC_OUTPUT			= 9,
+	AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
+	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
+	AIC3X_GPIO1_FUNC_BUTTON_IRQ		= 12,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
+	AIC3X_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
+	AIC3X_GPIO1_FUNC_ALL_IRQ		= 16
+};
+
+enum {
+	AIC3X_GPIO2_FUNC_DISABLED		= 0,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
+	AIC3X_GPIO2_FUNC_INPUT			= 3,
+	AIC3X_GPIO2_FUNC_OUTPUT			= 4,
+	AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
+	AIC3X_GPIO2_FUNC_AUDIO_BITCLK		= 8,
+	AIC3X_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
+	AIC3X_GPIO2_FUNC_ALL_IRQ		= 10,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
+	AIC3X_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
+	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
+	AIC3X_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
+	AIC3X_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
+};
+
+struct aic3x_setup_data {
+	unsigned int gpio_func[2];
+};
+
 struct aic3x_pdata {
 	int gpio_reset; /* < 0 if not used */
+	struct aic3x_setup_data *setup;
 };
 
-#endif
\ No newline at end of file
+#endif
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 0a4b0fe..e8652b1 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -240,7 +240,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 /* AIC23 driver data */
 struct aic23 {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	int mclk;
 	int requested_adc;
 	int requested_dac;
@@ -404,11 +405,10 @@ static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 iface_reg;
 	int ret;
-	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
+	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 	u32 sample_rate_adc = aic23->requested_adc;
 	u32 sample_rate_dac = aic23->requested_dac;
 	u32 sample_rate = params_rate(params);
@@ -452,8 +452,7 @@ static int tlv320aic23_pcm_prepare(struct snd_pcm_substream *substream,
 				   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* set active */
 	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0001);
@@ -465,9 +464,8 @@ static void tlv320aic23_shutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
+	struct snd_soc_codec *codec = rtd->codec;
+	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 
 	/* deactivate */
 	if (!codec->active) {
@@ -546,8 +544,7 @@ static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				      int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
+	struct aic23 *aic23 = snd_soc_dai_get_drvdata(codec_dai);
 	aic23->mclk = freq;
 	return 0;
 }
@@ -594,8 +591,8 @@ static struct snd_soc_dai_ops tlv320aic23_dai_ops = {
 	.set_sysclk	= tlv320aic23_set_dai_sysclk,
 };
 
-struct snd_soc_dai tlv320aic23_dai = {
-	.name = "tlv320aic23",
+static struct snd_soc_dai_driver tlv320aic23_dai = {
+	.name = "tlv320aic23-hifi",
 	.playback = {
 		     .stream_name = "Playback",
 		     .channels_min = 2,
@@ -610,23 +607,17 @@ struct snd_soc_dai tlv320aic23_dai = {
 		    .formats = AIC23_FORMATS,},
 	.ops = &tlv320aic23_dai_ops,
 };
-EXPORT_SYMBOL_GPL(tlv320aic23_dai);
 
-static int tlv320aic23_suspend(struct platform_device *pdev,
+static int tlv320aic23_suspend(struct snd_soc_codec *codec,
 			       pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int tlv320aic23_resume(struct platform_device *pdev)
+static int tlv320aic23_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	u16 reg;
 
 	/* Sync reg_cache with the hardware */
@@ -639,39 +630,19 @@ static int tlv320aic23_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the AIC23 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int tlv320aic23_init(struct snd_soc_device *socdev)
+static int tlv320aic23_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int ret = 0;
-	u16 reg;
+	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
+	int reg;
 
-	codec->name = "tlv320aic23";
-	codec->owner = THIS_MODULE;
-	codec->read = tlv320aic23_read_reg_cache;
-	codec->write = tlv320aic23_write;
-	codec->set_bias_level = tlv320aic23_set_bias_level;
-	codec->dai = &tlv320aic23_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(tlv320aic23_reg);
-	codec->reg_cache =
-	    kmemdup(tlv320aic23_reg, sizeof(tlv320aic23_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
+	codec->control_data = aic23->control_data;
+	codec->hw_write = (hw_write_t)i2c_master_send;
+	codec->hw_read = NULL;
 
 	/* Reset codec */
 	tlv320aic23_write(codec, TLV320AIC23_RESET, 0);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "tlv320aic23: failed to create pcms\n");
-		goto pcm_err;
-	}
-
 	/* power on device */
 	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -707,13 +678,27 @@ static int tlv320aic23_init(struct snd_soc_device *socdev)
 				ARRAY_SIZE(tlv320aic23_snd_controls));
 	tlv320aic23_add_widgets(codec);
 
-	return ret;
+	return 0;
+}
 
-pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
+static int tlv320aic23_remove(struct snd_soc_codec *codec)
+{
+	tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
-static struct snd_soc_device *tlv320aic23_socdev;
+
+static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
+	.reg_cache_size = ARRAY_SIZE(tlv320aic23_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = tlv320aic23_reg,
+	.probe = tlv320aic23_probe,
+	.remove = tlv320aic23_remove,
+	.suspend = tlv320aic23_suspend,
+	.resume = tlv320aic23_resume,
+	.read = tlv320aic23_read_reg_cache,
+	.write = tlv320aic23_write,
+	.set_bias_level = tlv320aic23_set_bias_level,
+};
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
@@ -723,31 +708,30 @@ static struct snd_soc_device *tlv320aic23_socdev;
 static int tlv320aic23_codec_probe(struct i2c_client *i2c,
 				   const struct i2c_device_id *i2c_id)
 {
-	struct snd_soc_device *socdev = tlv320aic23_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct aic23 *aic23;
 	int ret;
 
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -EINVAL;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	aic23 = kzalloc(sizeof(struct aic23), GFP_KERNEL);
+	if (aic23 == NULL)
+		return -ENOMEM;
 
-	ret = tlv320aic23_init(socdev);
-	if (ret < 0) {
-		printk(KERN_ERR "tlv320aic23: failed to initialise AIC23\n");
-		goto err;
-	}
-	return ret;
+	i2c_set_clientdata(i2c, aic23);
+	aic23->control_data = i2c;
+	aic23->control_type = SND_SOC_I2C;
 
-err:
-	kfree(codec);
-	kfree(i2c);
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_tlv320aic23, &tlv320aic23_dai, 1);
+	if (ret < 0)
+		kfree(aic23);
 	return ret;
 }
 static int __exit tlv320aic23_i2c_remove(struct i2c_client *i2c)
 {
-	put_device(&i2c->dev);
+	snd_soc_unregister_codec(&i2c->dev);
+	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
@@ -760,7 +744,7 @@ MODULE_DEVICE_TABLE(i2c, tlv320aic23_id);
 
 static struct i2c_driver tlv320aic23_i2c_driver = {
 	.driver = {
-		   .name = "tlv320aic23",
+		   .name = "tlv320aic23-codec",
 		   },
 	.probe = tlv320aic23_codec_probe,
 	.remove = __exit_p(tlv320aic23_i2c_remove),
@@ -769,71 +753,25 @@ static struct i2c_driver tlv320aic23_i2c_driver = {
 
 #endif
 
-static int tlv320aic23_probe(struct platform_device *pdev)
+static int __init tlv320aic23_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct aic23 *aic23;
-	int ret = 0;
-
-	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
-
-	aic23 = kzalloc(sizeof(struct aic23), GFP_KERNEL);
-	if (aic23 == NULL)
-		return -ENOMEM;
-	codec = &aic23->codec;
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	tlv320aic23_socdev = socdev;
+	int ret;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->hw_read = NULL;
 	ret = i2c_add_driver(&tlv320aic23_i2c_driver);
-	if (ret != 0)
-		printk(KERN_ERR "can't add i2c driver");
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register TLV320AIC23 I2C driver: %d\n",
+		       ret);
+	}
 #endif
 	return ret;
 }
+module_init(tlv320aic23_modinit);
 
-static int tlv320aic23_remove(struct platform_device *pdev)
+static void __exit tlv320aic23_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct aic23 *aic23 = container_of(codec, struct aic23, codec);
-
-	if (codec->control_data)
-		tlv320aic23_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&tlv320aic23_i2c_driver);
 #endif
-	kfree(codec->reg_cache);
-	kfree(aic23);
-
-	return 0;
-}
-struct snd_soc_codec_device soc_codec_dev_tlv320aic23 = {
-	.probe = tlv320aic23_probe,
-	.remove = tlv320aic23_remove,
-	.suspend = tlv320aic23_suspend,
-	.resume = tlv320aic23_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320aic23);
-
-static int __init tlv320aic23_modinit(void)
-{
-	return snd_soc_register_dai(&tlv320aic23_dai);
-}
-module_init(tlv320aic23_modinit);
-
-static void __exit tlv320aic23_exit(void)
-{
-	snd_soc_unregister_dai(&tlv320aic23_dai);
 }
 module_exit(tlv320aic23_exit);
 
diff --git a/sound/soc/codecs/tlv320aic23.h b/sound/soc/codecs/tlv320aic23.h
index 79d1faf..e804120 100644
--- a/sound/soc/codecs/tlv320aic23.h
+++ b/sound/soc/codecs/tlv320aic23.h
@@ -116,7 +116,4 @@
 #define TLV320AIC23_SIDETONE_12		0x080
 #define TLV320AIC23_SIDETONE_18		0x0c0
 
-extern struct snd_soc_dai tlv320aic23_dai;
-extern struct snd_soc_codec_device soc_codec_dev_tlv320aic23;
-
 #endif /* _TLV320AIC23_H */
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index f0e00fd..6b7d71e 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -19,7 +19,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/soc-of-simple.h>
 #include <sound/initval.h>
 
 #include "tlv320aic26.h"
@@ -130,8 +129,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
 	int fsref, divisor, wlen, pval, jval, dval, qval;
 	u16 reg;
@@ -278,8 +276,8 @@ static struct snd_soc_dai_ops aic26_dai_ops = {
 	.set_fmt	= aic26_set_fmt,
 };
 
-struct snd_soc_dai aic26_dai = {
-	.name = "tlv320aic26",
+static struct snd_soc_dai_driver aic26_dai = {
+	.name = "tlv320aic26-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -296,7 +294,6 @@ struct snd_soc_dai aic26_dai = {
 	},
 	.ops = &aic26_dai_ops,
 };
-EXPORT_SYMBOL_GPL(aic26_dai);
 
 /* ---------------------------------------------------------------------
  * ALSA controls
@@ -319,61 +316,6 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
 };
 
 /* ---------------------------------------------------------------------
- * SoC CODEC portion of driver: probe and release routines
- */
-static int aic26_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct aic26 *aic26;
-	int ret, err;
-
-	dev_info(&pdev->dev, "Probing AIC26 SoC CODEC driver\n");
-	dev_dbg(&pdev->dev, "socdev=%p\n", socdev);
-	dev_dbg(&pdev->dev, "codec_data=%p\n", socdev->codec_data);
-
-	/* Fetch the relevant aic26 private data here (it's already been
-	 * stored in the .codec pointer) */
-	aic26 = socdev->codec_data;
-	if (aic26 == NULL) {
-		dev_err(&pdev->dev, "aic26: missing codec pointer\n");
-		return -ENODEV;
-	}
-	codec = &aic26->codec;
-	socdev->card->codec = codec;
-
-	dev_dbg(&pdev->dev, "Registering PCMs, dev=%p, socdev->dev=%p\n",
-		&pdev->dev, socdev->dev);
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "aic26: failed to create pcms\n");
-		return -ENODEV;
-	}
-
-	/* register controls */
-	dev_dbg(&pdev->dev, "Registering controls\n");
-	err = snd_soc_add_controls(codec, aic26_snd_controls,
-			ARRAY_SIZE(aic26_snd_controls));
-	WARN_ON(err < 0);
-
-	return 0;
-}
-
-static int aic26_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	snd_soc_free_pcms(socdev);
-	return 0;
-}
-
-struct snd_soc_codec_device aic26_soc_codec_dev = {
-	.probe = aic26_probe,
-	.remove = aic26_remove,
-};
-EXPORT_SYMBOL_GPL(aic26_soc_codec_dev);
-
-/* ---------------------------------------------------------------------
  * SPI device portion of driver: sysfs files for debugging
  */
 
@@ -409,95 +351,95 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 
 /* ---------------------------------------------------------------------
- * SPI device portion of driver: probe and release routines and SPI
- * 				 driver registration.
+ * SoC CODEC portion of driver: probe and release routines
  */
-static int aic26_spi_probe(struct spi_device *spi)
+static int aic26_probe(struct snd_soc_codec *codec)
 {
-	struct aic26 *aic26;
-	int ret, i, reg;
-
-	dev_dbg(&spi->dev, "probing tlv320aic26 spi device\n");
-
-	/* Allocate driver data */
-	aic26 = kzalloc(sizeof *aic26, GFP_KERNEL);
-	if (!aic26)
-		return -ENOMEM;
-
-	/* Initialize the driver data */
-	aic26->spi = spi;
-	dev_set_drvdata(&spi->dev, aic26);
+	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
+	int ret, err, i, reg;
 
-	/* Setup what we can in the codec structure so that the register
-	 * access functions will work as expected.  More will be filled
-	 * out when it is probed by the SoC CODEC part of this driver */
-	snd_soc_codec_set_drvdata(&aic26->codec, aic26);
-	aic26->codec.name = "aic26";
-	aic26->codec.owner = THIS_MODULE;
-	aic26->codec.dai = &aic26_dai;
-	aic26->codec.num_dai = 1;
-	aic26->codec.read = aic26_reg_read;
-	aic26->codec.write = aic26_reg_write;
-	aic26->master = 1;
-	mutex_init(&aic26->codec.mutex);
-	INIT_LIST_HEAD(&aic26->codec.dapm_widgets);
-	INIT_LIST_HEAD(&aic26->codec.dapm_paths);
-	aic26->codec.reg_cache_size = AIC26_NUM_REGS;
-	aic26->codec.reg_cache = aic26->reg_cache;
-
-	aic26_dai.dev = &spi->dev;
-	ret = snd_soc_register_dai(&aic26_dai);
-	if (ret != 0) {
-		dev_err(&spi->dev, "Failed to register DAI: %d\n", ret);
-		kfree(aic26);
-		return ret;
-	}
+	dev_info(codec->dev, "Probing AIC26 SoC CODEC driver\n");
 
 	/* Reset the codec to power on defaults */
-	aic26_reg_write(&aic26->codec, AIC26_REG_RESET, 0xBB00);
+	aic26_reg_write(codec, AIC26_REG_RESET, 0xBB00);
 
 	/* Power up CODEC */
-	aic26_reg_write(&aic26->codec, AIC26_REG_POWER_CTRL, 0);
+	aic26_reg_write(codec, AIC26_REG_POWER_CTRL, 0);
 
 	/* Audio Control 3 (master mode, fsref rate) */
-	reg = aic26_reg_read(&aic26->codec, AIC26_REG_AUDIO_CTRL3);
+	reg = aic26_reg_read(codec, AIC26_REG_AUDIO_CTRL3);
 	reg &= ~0xf800;
 	reg |= 0x0800; /* set master mode */
-	aic26_reg_write(&aic26->codec, AIC26_REG_AUDIO_CTRL3, reg);
+	aic26_reg_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
 
 	/* Fill register cache */
 	for (i = 0; i < ARRAY_SIZE(aic26->reg_cache); i++)
-		aic26_reg_read(&aic26->codec, i);
+		aic26_reg_read(codec, i);
 
 	/* Register the sysfs files for debugging */
 	/* Create SysFS files */
-	ret = device_create_file(&spi->dev, &dev_attr_keyclick);
+	ret = device_create_file(codec->dev, &dev_attr_keyclick);
 	if (ret)
-		dev_info(&spi->dev, "error creating sysfs files\n");
+		dev_info(codec->dev, "error creating sysfs files\n");
 
-#if defined(CONFIG_SND_SOC_OF_SIMPLE)
-	/* Tell the of_soc helper about this codec */
-	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
-				  spi->dev.archdata.of_node);
-#endif
+	/* register controls */
+	dev_dbg(codec->dev, "Registering controls\n");
+	err = snd_soc_add_controls(codec, aic26_snd_controls,
+			ARRAY_SIZE(aic26_snd_controls));
+	WARN_ON(err < 0);
 
-	dev_dbg(&spi->dev, "SPI device initialized\n");
 	return 0;
 }
 
-static int aic26_spi_remove(struct spi_device *spi)
+static struct snd_soc_codec_driver aic26_soc_codec_dev = {
+	.probe = aic26_probe,
+	.read = aic26_reg_read,
+	.write = aic26_reg_write,
+	.reg_cache_size = AIC26_NUM_REGS,
+	.reg_word_size = sizeof(u16),
+};
+
+/* ---------------------------------------------------------------------
+ * SPI device portion of driver: probe and release routines and SPI
+ * 				 driver registration.
+ */
+static int aic26_spi_probe(struct spi_device *spi)
 {
-	struct aic26 *aic26 = dev_get_drvdata(&spi->dev);
+	struct aic26 *aic26;
+	int ret;
 
-	snd_soc_unregister_dai(&aic26_dai);
-	kfree(aic26);
+	dev_dbg(&spi->dev, "probing tlv320aic26 spi device\n");
+
+	/* Allocate driver data */
+	aic26 = kzalloc(sizeof *aic26, GFP_KERNEL);
+	if (!aic26)
+		return -ENOMEM;
 
+	/* Initialize the driver data */
+	aic26->spi = spi;
+	dev_set_drvdata(&spi->dev, aic26);
+	aic26->master = 1;
+
+	ret = snd_soc_register_codec(&spi->dev,
+			&aic26_soc_codec_dev, &aic26_dai, 1);
+	if (ret < 0)
+		kfree(aic26);
+	return ret;
+
+	dev_dbg(&spi->dev, "SPI device initialized\n");
+	return 0;
+}
+
+static int aic26_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
 static struct spi_driver aic26_spi = {
 	.driver = {
-		.name = "tlv320aic26",
+		.name = "tlv320aic26-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe = aic26_spi_probe,
diff --git a/sound/soc/codecs/tlv320aic26.h b/sound/soc/codecs/tlv320aic26.h
index 786ba16..62b1f22 100644
--- a/sound/soc/codecs/tlv320aic26.h
+++ b/sound/soc/codecs/tlv320aic26.h
@@ -90,7 +90,4 @@ enum aic26_wlen {
 	AIC26_WLEN_32	= 3 << 10,
 };
 
-extern struct snd_soc_dai aic26_dai;
-extern struct snd_soc_codec_device aic26_soc_codec_dev;
-
 #endif /* _TLV320AIC16_H_ */
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 71a6990..43fd9c1 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -63,8 +63,10 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct aic3x_priv {
-	struct snd_soc_codec codec;
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
+	enum snd_soc_control_type control_type;
+	struct aic3x_setup_data *setup;
+	void *control_data;
 	unsigned int sysclk;
 	int master;
 	int gpio_reset;
@@ -773,8 +775,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
 	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
@@ -1101,8 +1102,8 @@ static struct snd_soc_dai_ops aic3x_dai_ops = {
 	.set_fmt	= aic3x_set_dai_fmt,
 };
 
-struct snd_soc_dai aic3x_dai = {
-	.name = "tlv320aic3x",
+static struct snd_soc_dai_driver aic3x_dai = {
+	.name = "tlv320aic3x-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -1117,22 +1118,16 @@ struct snd_soc_dai aic3x_dai = {
 		.formats = AIC3X_FORMATS,},
 	.ops = &aic3x_dai_ops,
 };
-EXPORT_SYMBOL_GPL(aic3x_dai);
 
-static int aic3x_suspend(struct platform_device *pdev, pm_message_t state)
+static int aic3x_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int aic3x_resume(struct platform_device *pdev)
+static int aic3x_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u8 *cache = codec->reg_cache;
@@ -1157,22 +1152,6 @@ static int aic3x_init(struct snd_soc_codec *codec)
 {
 	int reg;
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "tlv320aic3x";
-	codec->owner = THIS_MODULE;
-	codec->read = aic3x_read_reg_cache;
-	codec->write = aic3x_write;
-	codec->set_bias_level = aic3x_set_bias_level;
-	codec->dai = &aic3x_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(aic3x_reg);
-	codec->reg_cache = kmemdup(aic3x_reg, sizeof(aic3x_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
-
 	aic3x_write(codec, AIC3X_PAGE_SELECT, PAGE0_SELECT);
 	aic3x_write(codec, AIC3X_RESET, SOFT_RESET);
 
@@ -1245,56 +1224,50 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec *aic3x_codec;
-
-static int aic3x_register(struct snd_soc_codec *codec)
+static int aic3x_probe(struct snd_soc_codec *codec)
 {
-	int ret;
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+
+	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->control_data = aic3x->control_data;
 
-	ret = aic3x_init(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to initialise device\n");
-		return ret;
+	if (aic3x->setup) {
+		/* setup GPIO functions */
+		aic3x_write(codec, AIC3X_GPIO1_REG,
+			    (aic3x->setup->gpio_func[0] & 0xf) << 4);
+		aic3x_write(codec, AIC3X_GPIO2_REG,
+			    (aic3x->setup->gpio_func[1] & 0xf) << 4);
 	}
 
-	aic3x_codec = codec;
+	aic3x_init(codec);
 
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register codec\n");
-		return ret;
-	}
+	snd_soc_add_controls(codec, aic3x_snd_controls,
+			     ARRAY_SIZE(aic3x_snd_controls));
 
-	ret = snd_soc_register_dai(&aic3x_dai);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register dai\n");
-		snd_soc_unregister_codec(codec);
-		return ret;
-	}
+	aic3x_add_widgets(codec);
 
 	return 0;
 }
 
-static int aic3x_unregister(struct aic3x_priv *aic3x)
+static int aic3x_remove(struct snd_soc_codec *codec)
 {
-	aic3x_set_bias_level(&aic3x->codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_unregister_dai(&aic3x_dai);
-	snd_soc_unregister_codec(&aic3x->codec);
-
-	if (aic3x->gpio_reset >= 0) {
-		gpio_set_value(aic3x->gpio_reset, 0);
-		gpio_free(aic3x->gpio_reset);
-	}
-	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-
-	kfree(aic3x);
-	aic3x_codec = NULL;
-
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
+	.read = aic3x_read_reg_cache,
+	.write = aic3x_write,
+	.set_bias_level = aic3x_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(aic3x_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = aic3x_reg,
+	.probe = aic3x_probe,
+	.remove = aic3x_remove,
+	.suspend = aic3x_suspend,
+	.resume = aic3x_resume,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * AIC3X 2 wire address can be up to 4 devices with device addresses
@@ -1308,9 +1281,9 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 static int aic3x_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec;
-	struct aic3x_priv *aic3x;
 	struct aic3x_pdata *pdata = i2c->dev.platform_data;
+	struct aic3x_setup_data *setup = pdata->setup;
+	struct aic3x_priv *aic3x;
 	int ret, i;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
@@ -1319,12 +1292,8 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
-	codec = &aic3x->codec;
-	codec->dev = &i2c->dev;
-	snd_soc_codec_set_drvdata(codec, aic3x);
-	codec->control_data = i2c;
-	codec->hw_write = (hw_write_t) i2c_master_send;
-
+	aic3x->control_data = i2c;
+	aic3x->setup = setup;
 	i2c_set_clientdata(i2c, aic3x);
 
 	aic3x->gpio_reset = -1;
@@ -1339,17 +1308,17 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
+	ret = regulator_bulk_get(&i2c->dev, ARRAY_SIZE(aic3x->supplies),
 				 aic3x->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to request supplies: %d\n", ret);
 		goto err_get;
 	}
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
 				    aic3x->supplies);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to enable supplies: %d\n", ret);
 		goto err_enable;
 	}
 
@@ -1358,7 +1327,11 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		gpio_set_value(aic3x->gpio_reset, 1);
 	}
 
-	return aic3x_register(codec);
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_aic3x, &aic3x_dai, 1);
+	if (ret < 0)
+		goto err_enable;
+	return ret;
 
 err_enable:
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
@@ -1374,7 +1347,16 @@ static int aic3x_i2c_remove(struct i2c_client *client)
 {
 	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
 
-	return aic3x_unregister(aic3x);
+	if (aic3x->gpio_reset >= 0) {
+		gpio_set_value(aic3x->gpio_reset, 0);
+		gpio_free(aic3x->gpio_reset);
+	}
+	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
+	return 0;
 }
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
@@ -1387,7 +1369,7 @@ MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
 /* machine i2c codec control layer */
 static struct i2c_driver aic3x_i2c_driver = {
 	.driver = {
-		.name = "aic3x I2C Codec",
+		.name = "tlv320aic3x-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe	= aic3x_i2c_probe,
@@ -1409,90 +1391,27 @@ static inline void aic3x_i2c_exit(void)
 {
 	i2c_del_driver(&aic3x_i2c_driver);
 }
-#else
-static inline void aic3x_i2c_init(void) { }
-static inline void aic3x_i2c_exit(void) { }
 #endif
 
-static int aic3x_probe(struct platform_device *pdev)
+static int __init aic3x_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct aic3x_setup_data *setup;
-	struct snd_soc_codec *codec;
 	int ret = 0;
-
-	codec = aic3x_codec;
-	if (!codec) {
-		dev_err(&pdev->dev, "Codec not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = codec;
-	setup = socdev->codec_data;
-
-	if (setup) {
-		/* setup GPIO functions */
-		aic3x_write(codec, AIC3X_GPIO1_REG,
-			    (setup->gpio_func[0] & 0xf) << 4);
-		aic3x_write(codec, AIC3X_GPIO2_REG,
-			    (setup->gpio_func[1] & 0xf) << 4);
-	}
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "aic3x: failed to create pcms\n");
-		goto pcm_err;
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	ret = i2c_add_driver(&aic3x_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register TLV320AIC3x I2C driver: %d\n",
+		       ret);
 	}
-
-	snd_soc_add_controls(codec, aic3x_snd_controls,
-			     ARRAY_SIZE(aic3x_snd_controls));
-
-	aic3x_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	kfree(codec->reg_cache);
+#endif
 	return ret;
 }
-
-static int aic3x_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	/* power down chip */
-	if (codec->control_data)
-		aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	kfree(codec->reg_cache);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_aic3x = {
-	.probe = aic3x_probe,
-	.remove = aic3x_remove,
-	.suspend = aic3x_suspend,
-	.resume = aic3x_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_aic3x);
-
-static int __init aic3x_modinit(void)
-{
-	aic3x_i2c_init();
-
-	return 0;
-}
 module_init(aic3x_modinit);
 
 static void __exit aic3x_exit(void)
 {
-	aic3x_i2c_exit();
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	i2c_del_driver(&aic3x_i2c_driver);
+#endif
 }
 module_exit(aic3x_exit);
 
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 9af1c88..f6e3d9b 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -199,42 +199,6 @@
 /* Default input volume */
 #define DEFAULT_GAIN    0x20
 
-/* GPIO API */
-enum {
-	AIC3X_GPIO1_FUNC_DISABLED		= 0,
-	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK_ADC	= 1,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX		= 2,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV2		= 3,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV4		= 4,
-	AIC3X_GPIO1_FUNC_CLOCK_MUX_DIV8		= 5,
-	AIC3X_GPIO1_FUNC_SHORT_CIRCUIT_IRQ	= 6,
-	AIC3X_GPIO1_FUNC_AGC_NOISE_IRQ		= 7,
-	AIC3X_GPIO1_FUNC_INPUT			= 8,
-	AIC3X_GPIO1_FUNC_OUTPUT			= 9,
-	AIC3X_GPIO1_FUNC_DIGITAL_MIC_MODCLK	= 10,
-	AIC3X_GPIO1_FUNC_AUDIO_WORDCLK		= 11,
-	AIC3X_GPIO1_FUNC_BUTTON_IRQ		= 12,
-	AIC3X_GPIO1_FUNC_HEADSET_DETECT_IRQ	= 13,
-	AIC3X_GPIO1_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ	= 14,
-	AIC3X_GPIO1_FUNC_ALL_IRQ		= 16
-};
-
-enum {
-	AIC3X_GPIO2_FUNC_DISABLED		= 0,
-	AIC3X_GPIO2_FUNC_HEADSET_DETECT_IRQ	= 2,
-	AIC3X_GPIO2_FUNC_INPUT			= 3,
-	AIC3X_GPIO2_FUNC_OUTPUT			= 4,
-	AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT	= 5,
-	AIC3X_GPIO2_FUNC_AUDIO_BITCLK		= 8,
-	AIC3X_GPIO2_FUNC_HEADSET_DETECT_OR_BUTTON_IRQ = 9,
-	AIC3X_GPIO2_FUNC_ALL_IRQ		= 10,
-	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_OR_AGC_IRQ = 11,
-	AIC3X_GPIO2_FUNC_HEADSET_OR_BUTTON_PRESS_OR_SHORT_CIRCUIT_IRQ = 12,
-	AIC3X_GPIO2_FUNC_SHORT_CIRCUIT_IRQ	= 13,
-	AIC3X_GPIO2_FUNC_AGC_NOISE_IRQ		= 14,
-	AIC3X_GPIO2_FUNC_BUTTON_PRESS_IRQ	= 15
-};
-
 void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
 int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
 
@@ -281,11 +245,4 @@ void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
 int aic3x_headset_detected(struct snd_soc_codec *codec);
 int aic3x_button_pressed(struct snd_soc_codec *codec);
 
-struct aic3x_setup_data {
-	unsigned int gpio_func[2];
-};
-
-extern struct snd_soc_dai aic3x_dai;
-extern struct snd_soc_codec_device soc_codec_dev_aic3x;
-
 #endif /* _AIC3X_H */
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 8651b01..a3c5b52 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -66,8 +66,6 @@
 static void dac33_calculate_times(struct snd_pcm_substream *substream);
 static int dac33_prepare_chip(struct snd_pcm_substream *substream);
 
-static struct snd_soc_codec *tlv320dac33_codec;
-
 enum dac33_state {
 	DAC33_IDLE = 0,
 	DAC33_PREFILL,
@@ -93,7 +91,7 @@ struct tlv320dac33_priv {
 	struct mutex mutex;
 	struct workqueue_struct *dac33_wq;
 	struct work_struct work;
-	struct snd_soc_codec codec;
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
 	struct snd_pcm_substream *substream;
 	int power_gpio;
@@ -128,6 +126,8 @@ struct tlv320dac33_priv {
 	unsigned int uthr;
 
 	enum dac33_state state;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
 static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
@@ -650,9 +650,7 @@ static int dac33_set_bias_level(struct snd_soc_codec *codec,
 
 static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec;
-
-	codec = &dac33->codec;
+	struct snd_soc_codec *codec = dac33->codec;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -695,9 +693,7 @@ static inline void dac33_prefill_handler(struct tlv320dac33_priv *dac33)
 
 static inline void dac33_playback_handler(struct tlv320dac33_priv *dac33)
 {
-	struct snd_soc_codec *codec;
-
-	codec = &dac33->codec;
+	struct snd_soc_codec *codec = dac33->codec;
 
 	switch (dac33->fifo_mode) {
 	case DAC33_FIFO_MODE1:
@@ -726,7 +722,7 @@ static void dac33_work(struct work_struct *work)
 	u8 reg;
 
 	dac33 = container_of(work, struct tlv320dac33_priv, work);
-	codec = &dac33->codec;
+	codec = dac33->codec;
 
 	mutex_lock(&dac33->mutex);
 	switch (dac33->state) {
@@ -787,8 +783,7 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	/* Stream started, save the substream pointer */
@@ -801,8 +796,7 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33->substream = NULL;
@@ -817,8 +811,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Check parameters for validity */
 	switch (params_rate(params)) {
@@ -856,8 +849,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
 	u8 aictrl_a, aictrl_b, fifoctrl_a;
@@ -1049,8 +1041,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 static void dac33_calculate_times(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int period_size = substream->runtime->period_size;
 	unsigned int rate = substream->runtime->rate;
@@ -1129,8 +1120,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
@@ -1163,8 +1153,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned long long t0, t1, t_now;
 	unsigned int time_delta, uthr;
@@ -1389,24 +1378,47 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int dac33_soc_probe(struct platform_device *pdev)
+static int dac33_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct tlv320dac33_priv *dac33;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	BUG_ON(!tlv320dac33_codec);
+	codec->control_data = dac33->control_data;
+	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->idle_bias_off = 1;
+	dac33->codec = codec;
 
-	codec = tlv320dac33_codec;
-	socdev->card->codec = codec;
-	dac33 = snd_soc_codec_get_drvdata(codec);
+	/* Read the tlv320dac33 ID registers */
+	ret = dac33_hard_power(codec, 1);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
+		goto err_power;
+	}
+	dac33_read_id(codec);
+	dac33_hard_power(codec, 0);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
-		goto pcm_err;
+	/* Check if the IRQ number is valid and request it */
+	if (dac33->irq >= 0) {
+		ret = request_irq(dac33->irq, dac33_interrupt_handler,
+				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
+				  codec->name, codec);
+		if (ret < 0) {
+			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",
+						dac33->irq, ret);
+			dac33->irq = -1;
+		}
+		if (dac33->irq != -1) {
+			/* Setup work queue */
+			dac33->dac33_wq =
+				create_singlethread_workqueue("tlv320dac33");
+			if (dac33->dac33_wq == NULL) {
+				free_irq(dac33->irq, codec);
+				return -ENOMEM;
+			}
+
+			INIT_WORK(&dac33->work, dac33_work);
+		}
 	}
 
 	snd_soc_add_controls(codec, dac33_snd_controls,
@@ -1420,56 +1432,51 @@ static int dac33_soc_probe(struct platform_device *pdev)
 			snd_soc_add_controls(codec, dac33_fifo_snd_controls,
 					ARRAY_SIZE(dac33_fifo_snd_controls));
 	}
-
 	dac33_add_widgets(codec);
 
-	return 0;
-
-pcm_err:
-	dac33_hard_power(codec, 0);
+err_power:
 	return ret;
 }
 
-static int dac33_soc_remove(struct platform_device *pdev)
+static int dac33_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
+	if (dac33->irq >= 0) {
+		free_irq(dac33->irq, dac33->codec);
+		destroy_workqueue(dac33->dac33_wq);
+	}
 	return 0;
 }
 
-static int dac33_soc_suspend(struct platform_device *pdev, pm_message_t state)
+static int dac33_soc_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int dac33_soc_resume(struct platform_device *pdev)
+static int dac33_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_tlv320dac33 = {
+static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
+	.read = dac33_read_reg_cache,
+	.write = dac33_write_locked,
+	.set_bias_level = dac33_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(dac33_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = dac33_reg,
 	.probe = dac33_soc_probe,
 	.remove = dac33_soc_remove,
 	.suspend = dac33_soc_suspend,
 	.resume = dac33_soc_resume,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320dac33);
 
 #define DAC33_RATES	(SNDRV_PCM_RATE_44100 | \
 			 SNDRV_PCM_RATE_48000)
@@ -1485,8 +1492,8 @@ static struct snd_soc_dai_ops dac33_dai_ops = {
 	.set_fmt	= dac33_set_dai_fmt,
 };
 
-struct snd_soc_dai dac33_dai = {
-	.name = "tlv320dac33",
+static struct snd_soc_dai_driver dac33_dai = {
+	.name = "tlv320dac33-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -1495,14 +1502,12 @@ struct snd_soc_dai dac33_dai = {
 		.formats = DAC33_FORMATS,},
 	.ops = &dac33_dai_ops,
 };
-EXPORT_SYMBOL_GPL(dac33_dai);
 
 static int __devinit dac33_i2c_probe(struct i2c_client *client,
 				     const struct i2c_device_id *id)
 {
 	struct tlv320dac33_platform_data *pdata;
 	struct tlv320dac33_priv *dac33;
-	struct snd_soc_codec *codec;
 	int ret, i;
 
 	if (client->dev.platform_data == NULL) {
@@ -1515,33 +1520,9 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	codec = &dac33->codec;
-	snd_soc_codec_set_drvdata(codec, dac33);
-	codec->control_data = client;
-
-	mutex_init(&codec->mutex);
+	dac33->control_data = client;
 	mutex_init(&dac33->mutex);
 	spin_lock_init(&dac33->lock);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "tlv320dac33";
-	codec->owner = THIS_MODULE;
-	codec->read = dac33_read_reg_cache;
-	codec->write = dac33_write_locked;
-	codec->hw_write = (hw_write_t) i2c_master_send;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = dac33_set_bias_level;
-	codec->idle_bias_off = 1;
-	codec->dai = &dac33_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(dac33_reg);
-	codec->reg_cache = kmemdup(dac33_reg, ARRAY_SIZE(dac33_reg),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto error_reg;
-	}
 
 	i2c_set_clientdata(client, dac33);
 
@@ -1561,125 +1542,59 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-	tlv320dac33_codec = codec;
-
-	codec->dev = &client->dev;
-	dac33_dai.dev = codec->dev;
-
 	/* Check if the reset GPIO number is valid and request it */
 	if (dac33->power_gpio >= 0) {
 		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
 		if (ret < 0) {
-			dev_err(codec->dev,
+			dev_err(&client->dev,
 				"Failed to request reset GPIO (%d)\n",
 				dac33->power_gpio);
-			snd_soc_unregister_dai(&dac33_dai);
-			snd_soc_unregister_codec(codec);
-			goto error_gpio;
+			goto err_gpio;
 		}
 		gpio_direction_output(dac33->power_gpio, 0);
 	}
 
-	/* Check if the IRQ number is valid and request it */
-	if (dac33->irq >= 0) {
-		ret = request_irq(dac33->irq, dac33_interrupt_handler,
-				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
-				  codec->name, codec);
-		if (ret < 0) {
-			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",
-						dac33->irq, ret);
-			dac33->irq = -1;
-		}
-		if (dac33->irq != -1) {
-			/* Setup work queue */
-			dac33->dac33_wq =
-				create_singlethread_workqueue("tlv320dac33");
-			if (dac33->dac33_wq == NULL) {
-				free_irq(dac33->irq, &dac33->codec);
-				ret = -ENOMEM;
-				goto error_wq;
-			}
-
-			INIT_WORK(&dac33->work, dac33_work);
-		}
-	}
-
 	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
 		dac33->supplies[i].supply = dac33_supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(dac33->supplies),
+	ret = regulator_bulk_get(&client->dev, ARRAY_SIZE(dac33->supplies),
 				 dac33->supplies);
 
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		dev_err(&client->dev, "Failed to request supplies: %d\n", ret);
 		goto err_get;
 	}
 
-	/* Read the tlv320dac33 ID registers */
-	ret = dac33_hard_power(codec, 1);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to power up codec: %d\n", ret);
-		goto error_codec;
-	}
-	dac33_read_id(codec);
-	dac33_hard_power(codec, 0);
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto error_codec;
-	}
-
-	ret = snd_soc_register_dai(&dac33_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		goto error_codec;
-	}
+	ret = snd_soc_register_codec(&client->dev,
+			&soc_codec_dev_tlv320dac33, &dac33_dai, 1);
+	if (ret < 0)
+		goto err_register;
 
 	return ret;
-
-error_codec:
+err_register:
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 err_get:
-	if (dac33->irq >= 0) {
-		free_irq(dac33->irq, &dac33->codec);
-		destroy_workqueue(dac33->dac33_wq);
-	}
-error_wq:
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
-error_gpio:
-	kfree(codec->reg_cache);
-error_reg:
-	tlv320dac33_codec = NULL;
+err_gpio:
 	kfree(dac33);
-
 	return ret;
 }
 
 static int __devexit dac33_i2c_remove(struct i2c_client *client)
 {
-	struct tlv320dac33_priv *dac33;
-
-	dac33 = i2c_get_clientdata(client);
+	struct tlv320dac33_priv *dac33 = i2c_get_clientdata(client);
 
 	if (unlikely(dac33->chip_power))
-		dac33_hard_power(&dac33->codec, 0);
+		dac33_hard_power(dac33->codec, 0);
 
 	if (dac33->power_gpio >= 0)
 		gpio_free(dac33->power_gpio);
-	if (dac33->irq >= 0)
-		free_irq(dac33->irq, &dac33->codec);
 
 	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
 
-	destroy_workqueue(dac33->dac33_wq);
-	snd_soc_unregister_dai(&dac33_dai);
-	snd_soc_unregister_codec(&dac33->codec);
-	kfree(dac33->codec.reg_cache);
+	snd_soc_unregister_codec(&client->dev);
 	kfree(dac33);
-	tlv320dac33_codec = NULL;
 
 	return 0;
 }
@@ -1694,7 +1609,7 @@ static const struct i2c_device_id tlv320dac33_i2c_id[] = {
 
 static struct i2c_driver tlv320dac33_i2c_driver = {
 	.driver = {
-		.name = "tlv320dac33",
+		.name = "tlv320dac33-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe		= dac33_i2c_probe,
diff --git a/sound/soc/codecs/tlv320dac33.h b/sound/soc/codecs/tlv320dac33.h
index eb8ae07..7c318b5 100644
--- a/sound/soc/codecs/tlv320dac33.h
+++ b/sound/soc/codecs/tlv320dac33.h
@@ -261,7 +261,4 @@
 #define TLV320DAC33_MCLK		0
 #define TLV320DAC33_SLEEPCLK		1
 
-extern struct snd_soc_dai dac33_dai;
-extern struct snd_soc_codec_device soc_codec_dev_tlv320dac33;
-
 #endif /* __TLV320DAC33_H */
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 7b618bb..898430f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -36,7 +36,16 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include "twl4030.h"
+/* Register descriptions are here */
+#include <linux/mfd/twl4030-codec.h>
+
+/* Shadow register used by the audio driver */
+#define TWL4030_REG_SW_SHADOW		0x4A
+#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
+
+/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
+#define TWL4030_HFL_EN			0x01
+#define TWL4030_HFR_EN			0x02
 
 /*
  * twl4030 register cache & default register settings
@@ -277,21 +286,19 @@ static inline void twl4030_reset_registers(struct snd_soc_codec *codec)
 
 }
 
-static void twl4030_init_chip(struct platform_device *pdev)
+static void twl4030_init_chip(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct twl4030_setup_data *setup = socdev->codec_data;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_codec_audio_data *pdata = dev_get_platdata(codec->dev);
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 reg, byte;
 	int i = 0;
 
 	/* Check defaults, if instructed before anything else */
-	if (setup && setup->check_defaults)
+	if (pdata && pdata->check_defaults)
 		twl4030_check_defaults(codec);
 
 	/* Reset registers, if no setup data or if instructed to do so */
-	if (!setup || (setup && setup->reset_registers))
+	if (!pdata || (pdata && pdata->reset_registers))
 		twl4030_reset_registers(codec);
 
 	/* Refresh APLL_CTL register from HW */
@@ -312,20 +319,14 @@ static void twl4030_init_chip(struct platform_device *pdev)
 	twl4030_write(codec, TWL4030_REG_ARXR2_APGA_CTL, 0x32);
 
 	/* Machine dependent setup */
-	if (!setup)
+	if (!pdata)
 		return;
 
-	twl4030->digimic_delay = setup->digimic_delay;
-
-	/* Configuration for headset ramp delay from setup data */
-	if (setup->sysclk != twl4030->sysclk)
-		dev_warn(codec->dev,
-				"Mismatch in APLL mclk: %u (configured: %u)\n",
-				setup->sysclk, twl4030->sysclk);
+	twl4030->digimic_delay = pdata->digimic_delay;
 
 	reg = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
 	reg &= ~TWL4030_RAMP_DELAY;
-	reg |= (setup->ramp_delay_value << 2);
+	reg |= (pdata->ramp_delay_value << 2);
 	twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, reg);
 
 	/* initiate offset cancellation */
@@ -333,7 +334,7 @@ static void twl4030_init_chip(struct platform_device *pdev)
 
 	reg = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
 	reg &= ~TWL4030_OFFSET_CNCL_SEL;
-	reg |= setup->offset_cncl_path;
+	reg |= pdata->offset_cncl_path;
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
 		reg | TWL4030_CNCL_OFFSET_START);
 
@@ -718,9 +719,7 @@ static int aif_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
-	struct snd_soc_device *socdev = codec->socdev;
-	struct twl4030_setup_data *setup = socdev->codec_data;
-
+	struct twl4030_codec_audio_data *pdata = codec->dev->platform_data;
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -732,9 +731,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 
 	/* Enable external mute control, this dramatically reduces
 	 * the pop-noise */
-	if (setup && setup->hs_extmute) {
-		if (setup->set_hs_extmute) {
-			setup->set_hs_extmute(1);
+	if (pdata && pdata->hs_extmute) {
+		if (pdata->set_hs_extmute) {
+			pdata->set_hs_extmute(1);
 		} else {
 			hs_pop |= TWL4030_EXTMUTE;
 			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
@@ -772,9 +771,9 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 	}
 
 	/* Disable external mute */
-	if (setup && setup->hs_extmute) {
-		if (setup->set_hs_extmute) {
-			setup->set_hs_extmute(0);
+	if (pdata && pdata->hs_extmute) {
+		if (pdata->set_hs_extmute) {
+			pdata->set_hs_extmute(0);
 		} else {
 			hs_pop &= ~TWL4030_EXTMUTE;
 			twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
@@ -1707,8 +1706,7 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream) {
@@ -1738,8 +1736,7 @@ static void twl4030_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream == substream)
@@ -1764,8 +1761,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode, old_mode, format, old_format;
 
@@ -1999,8 +1995,7 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode;
 
@@ -2033,8 +2028,7 @@ static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Enable voice digital filters */
 	twl4030_voice_enable(codec, substream->stream, 0);
@@ -2044,8 +2038,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_mode, mode;
 
@@ -2175,7 +2168,7 @@ static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
-static struct snd_soc_dai_ops twl4030_dai_ops = {
+static struct snd_soc_dai_ops twl4030_dai_hifi_ops = {
 	.startup	= twl4030_startup,
 	.shutdown	= twl4030_shutdown,
 	.hw_params	= twl4030_hw_params,
@@ -2193,9 +2186,9 @@ static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
 	.set_tristate	= twl4030_voice_set_tristate,
 };
 
-struct snd_soc_dai twl4030_dai[] = {
+static struct snd_soc_dai_driver twl4030_dai[] = {
 {
-	.name = "twl4030",
+	.name = "twl4030-hifi",
 	.playback = {
 		.stream_name = "HiFi Playback",
 		.channels_min = 2,
@@ -2208,10 +2201,10 @@ struct snd_soc_dai twl4030_dai[] = {
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
 		.formats = TWL4030_FORMATS,},
-	.ops = &twl4030_dai_ops,
+	.ops = &twl4030_dai_hifi_ops,
 },
 {
-	.name = "twl4030 Voice",
+	.name = "twl4030-voice",
 	.playback = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
@@ -2227,164 +2220,90 @@ struct snd_soc_dai twl4030_dai[] = {
 	.ops = &twl4030_dai_voice_ops,
 },
 };
-EXPORT_SYMBOL_GPL(twl4030_dai);
 
-static int twl4030_soc_suspend(struct platform_device *pdev, pm_message_t state)
+static int twl4030_soc_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	return 0;
 }
 
-static int twl4030_soc_resume(struct platform_device *pdev)
+static int twl4030_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	return 0;
 }
 
-static struct snd_soc_codec *twl4030_codec;
-
-static int twl4030_soc_probe(struct platform_device *pdev)
+static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	BUG_ON(!twl4030_codec);
-
-	codec = twl4030_codec;
-	socdev->card->codec = codec;
-
-	twl4030_init_chip(pdev);
+	struct twl4030_priv *twl4030;
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		return ret;
+	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
+	if (twl4030 == NULL) {
+		printk("Can not allocate memroy\n");
+		return -ENOMEM;
 	}
+	snd_soc_codec_set_drvdata(codec, twl4030);
+	/* Set the defaults, and power up the codec */
+	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
+	codec->bias_level = SND_SOC_BIAS_OFF;
+	codec->idle_bias_off = 1;
+
+	twl4030_init_chip(codec);
 
 	snd_soc_add_controls(codec, twl4030_snd_controls,
 				ARRAY_SIZE(twl4030_snd_controls));
 	twl4030_add_widgets(codec);
-
 	return 0;
 }
 
-static int twl4030_soc_remove(struct platform_device *pdev)
+static int twl4030_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	/* Reset registers to their chip default before leaving */
-	twl4030_reset_registers(codec);
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
 	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
+	.probe = twl4030_soc_probe,
+	.remove = twl4030_soc_remove,
+	.suspend = twl4030_soc_suspend,
+	.resume = twl4030_soc_resume,
+	.read = twl4030_read_reg_cache,
+	.write = twl4030_write,
+	.set_bias_level = twl4030_set_bias_level,
+	.reg_cache_size = sizeof(twl4030_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = twl4030_reg,
+};
+
 static int __devinit twl4030_codec_probe(struct platform_device *pdev)
 {
 	struct twl4030_codec_audio_data *pdata = pdev->dev.platform_data;
-	struct snd_soc_codec *codec;
-	struct twl4030_priv *twl4030;
-	int ret;
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "platform_data is missing\n");
 		return -EINVAL;
 	}
 
-	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
-	if (twl4030 == NULL) {
-		dev_err(&pdev->dev, "Can not allocate memroy\n");
-		return -ENOMEM;
-	}
-
-	codec = &twl4030->codec;
-	snd_soc_codec_set_drvdata(codec, twl4030);
-	codec->dev = &pdev->dev;
-	twl4030_dai[0].dev = &pdev->dev;
-	twl4030_dai[1].dev = &pdev->dev;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "twl4030";
-	codec->owner = THIS_MODULE;
-	codec->read = twl4030_read_reg_cache;
-	codec->write = twl4030_write;
-	codec->set_bias_level = twl4030_set_bias_level;
-	codec->idle_bias_off = 1;
-	codec->dai = twl4030_dai;
-	codec->num_dai = ARRAY_SIZE(twl4030_dai);
-	codec->reg_cache_size = sizeof(twl4030_reg);
-	codec->reg_cache = kmemdup(twl4030_reg, sizeof(twl4030_reg),
-					GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto error_cache;
-	}
-
-	platform_set_drvdata(pdev, twl4030);
-	twl4030_codec = codec;
-
-	/* Set the defaults, and power up the codec */
-	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto error_codec;
-	}
-
-	ret = snd_soc_register_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		goto error_codec;
-	}
-
-	return 0;
-
-error_codec:
-	twl4030_codec_enable(codec, 0);
-	kfree(codec->reg_cache);
-error_cache:
-	kfree(twl4030);
-	return ret;
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_twl4030,
+			twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
 
 static int __devexit twl4030_codec_remove(struct platform_device *pdev)
 {
-	struct twl4030_priv *twl4030 = platform_get_drvdata(pdev);
+	struct twl4030_priv *twl4030 = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
-	snd_soc_unregister_codec(&twl4030->codec);
-	kfree(twl4030->codec.reg_cache);
+	snd_soc_unregister_codec(&pdev->dev);
 	kfree(twl4030);
-
-	twl4030_codec = NULL;
 	return 0;
 }
 
-MODULE_ALIAS("platform:twl4030_codec_audio");
+MODULE_ALIAS("platform:twl4030-codec");
 
 static struct platform_driver twl4030_codec_driver = {
 	.probe		= twl4030_codec_probe,
 	.remove		= __devexit_p(twl4030_codec_remove),
 	.driver		= {
-		.name	= "twl4030_codec_audio",
+		.name	= "twl4030-codec",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -2401,14 +2320,6 @@ static void __exit twl4030_exit(void)
 }
 module_exit(twl4030_exit);
 
-struct snd_soc_codec_device soc_codec_dev_twl4030 = {
-	.probe = twl4030_soc_probe,
-	.remove = twl4030_soc_remove,
-	.suspend = twl4030_soc_suspend,
-	.resume = twl4030_soc_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_twl4030);
-
 MODULE_DESCRIPTION("ASoC TWL4030 codec driver");
 MODULE_AUTHOR("Steve Sakoman");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
deleted file mode 100644
index 6c57430..0000000
--- a/sound/soc/codecs/twl4030.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * ALSA SoC TWL4030 codec driver
- *
- * Author: Steve Sakoman <steve@sakoman.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-#ifndef __TWL4030_AUDIO_H__
-#define __TWL4030_AUDIO_H__
-
-/* Register descriptions are here */
-#include <linux/mfd/twl4030-codec.h>
-
-/* Shadow register used by the audio driver */
-#define TWL4030_REG_SW_SHADOW		0x4A
-#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
-
-/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
-#define TWL4030_HFL_EN			0x01
-#define TWL4030_HFR_EN			0x02
-
-#define TWL4030_DAI_HIFI		0
-#define TWL4030_DAI_VOICE		1
-
-extern struct snd_soc_dai twl4030_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_twl4030;
-
-struct twl4030_setup_data {
-	unsigned int ramp_delay_value;
-	unsigned int digimic_delay; /* in ms */
-	unsigned int sysclk;
-	unsigned int offset_cncl_path;
-	unsigned int check_defaults:1;
-	unsigned int reset_registers:1;
-	unsigned int hs_extmute:1;
-	void (*set_hs_extmute)(int mute);
-};
-
-#endif	/* End of __TWL4030_AUDIO_H__ */
-
-
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 64a807f..10f6e52 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -45,7 +45,6 @@
 
 /* codec private data */
 struct twl6040_data {
-	struct snd_soc_codec codec;
 	int audpwron;
 	int naudint;
 	int codec_powered;
@@ -770,8 +769,7 @@ static int twl6040_startup(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	if (!priv->sysclk) {
@@ -803,8 +801,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	u8 lppllctl;
 	int rate;
@@ -839,8 +836,7 @@ static int twl6040_trigger(struct snd_pcm_substream *substream,
 			int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	switch (cmd) {
@@ -978,8 +974,8 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 	.set_sysclk	= twl6040_set_dai_sysclk,
 };
 
-struct snd_soc_dai twl6040_dai = {
-	.name = "twl6040",
+static struct snd_soc_dai_driver twl6040_dai = {
+	.name = "twl6040-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -996,24 +992,17 @@ struct snd_soc_dai twl6040_dai = {
 	},
 	.ops = &twl6040_dai_ops,
 };
-EXPORT_SYMBOL_GPL(twl6040_dai);
 
 #ifdef CONFIG_PM
-static int twl6040_suspend(struct platform_device *pdev, pm_message_t state)
+static int twl6040_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int twl6040_resume(struct platform_device *pdev)
+static int twl6040_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1023,68 +1012,9 @@ static int twl6040_resume(struct platform_device *pdev)
 #define twl6040_resume NULL
 #endif
 
-static struct snd_soc_codec *twl6040_codec;
-
-static int twl6040_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret = 0;
-
-	BUG_ON(!twl6040_codec);
-
-	codec = twl6040_codec;
-	socdev->card->codec = codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		return ret;
-	}
-
-	snd_soc_add_controls(codec, twl6040_snd_controls,
-				ARRAY_SIZE(twl6040_snd_controls));
-	twl6040_add_widgets(codec);
-
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register card\n");
-		goto card_err;
-	}
-
-	return ret;
-
-card_err:
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-	return ret;
-}
-
-static int twl6040_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_twl6040 = {
-	.probe = twl6040_probe,
-	.remove = twl6040_remove,
-	.suspend = twl6040_suspend,
-	.resume = twl6040_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_twl6040);
-
-static int __devinit twl6040_codec_probe(struct platform_device *pdev)
+static int twl6040_probe(struct snd_soc_codec *codec)
 {
-	struct twl4030_codec_data *twl_codec = pdev->dev.platform_data;
-	struct snd_soc_codec *codec;
+	struct twl4030_codec_data *twl_codec = codec->dev->platform_data;
 	struct twl6040_data *priv;
 	int audpwron, naudint;
 	int ret = 0;
@@ -1092,6 +1022,7 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
+	snd_soc_codec_set_drvdata(codec, priv);
 
 	if (twl_codec) {
 		audpwron = twl_codec->audpwron_gpio;
@@ -1104,29 +1035,6 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 	priv->audpwron = audpwron;
 	priv->naudint = naudint;
 
-	codec = &priv->codec;
-	codec->dev = &pdev->dev;
-	twl6040_dai.dev = &pdev->dev;
-
-	codec->name = "twl6040";
-	codec->owner = THIS_MODULE;
-	codec->read = twl6040_read_reg_cache;
-	codec->write = twl6040_write;
-	codec->set_bias_level = twl6040_set_bias_level;
-	snd_soc_codec_set_drvdata(codec, priv);
-	codec->dai = &twl6040_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = ARRAY_SIZE(twl6040_reg);
-	codec->reg_cache = kmemdup(twl6040_reg, sizeof(twl6040_reg),
-					GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto cache_err;
-	}
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
 	init_completion(&priv->ready);
 
 	if (gpio_is_valid(audpwron)) {
@@ -1169,23 +1077,12 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 	if (ret)
 		goto irq_err;
 
-	ret = snd_soc_register_codec(codec);
-	if (ret)
-		goto reg_err;
-
-	twl6040_codec = codec;
-
-	ret = snd_soc_register_dai(&twl6040_dai);
-	if (ret)
-		goto dai_err;
+	snd_soc_add_controls(codec, twl6040_snd_controls,
+				ARRAY_SIZE(twl6040_snd_controls));
+	twl6040_add_widgets(codec);
 
 	return 0;
 
-dai_err:
-	snd_soc_unregister_codec(codec);
-	twl6040_codec = NULL;
-reg_err:
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 irq_err:
 	if (naudint)
 		free_irq(naudint, codec);
@@ -1193,36 +1090,57 @@ gpio2_err:
 	if (gpio_is_valid(audpwron))
 		gpio_free(audpwron);
 gpio1_err:
-	kfree(codec->reg_cache);
-cache_err:
 	kfree(priv);
 	return ret;
 }
 
-static int __devexit twl6040_codec_remove(struct platform_device *pdev)
+static int twl6040_remove(struct snd_soc_codec *codec)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(twl6040_codec);
+	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int audpwron = priv->audpwron;
 	int naudint = priv->naudint;
 
+	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
+
 	if (gpio_is_valid(audpwron))
 		gpio_free(audpwron);
 
 	if (naudint)
-		free_irq(naudint, twl6040_codec);
+		free_irq(naudint, codec);
 
-	snd_soc_unregister_dai(&twl6040_dai);
-	snd_soc_unregister_codec(twl6040_codec);
+	kfree(priv);
 
-	kfree(twl6040_codec);
-	twl6040_codec = NULL;
+	return 0;
+}
 
+static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
+	.probe = twl6040_probe,
+	.remove = twl6040_remove,
+	.suspend = twl6040_suspend,
+	.resume = twl6040_resume,
+	.read = twl6040_read_reg_cache,
+	.write = twl6040_write,
+	.set_bias_level = twl6040_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(twl6040_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = twl6040_reg,
+};
+
+static int __devinit twl6040_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_twl6040, &twl6040_dai, 1);
+}
+
+static int __devexit twl6040_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
 static struct platform_driver twl6040_codec_driver = {
 	.driver = {
-		.name = "twl6040_codec",
+		.name = "twl6040-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe = twl6040_codec_probe,
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index c472070..f7c77fa 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -135,7 +135,4 @@
 #define TWL6040_HPPLL_ID		1
 #define TWL6040_LPPLL_ID		2
 
-extern struct snd_soc_dai twl6040_dai;
-extern struct snd_soc_codec_device soc_codec_dev_twl6040;
-
 #endif /* End of __TWL6040_H__ */
-- 
1.7.0.4
