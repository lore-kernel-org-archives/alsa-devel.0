From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Fri, 25 Jun 2010 18:52:51 +0100
Message-ID: <1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 13D00103867
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:23 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166806wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:23 -0700 (PDT)
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

Move TI CODECs to multi-component

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o tlv320aic3x: no more "setup_data" from ASoC machine drivers, platform data
 must be set in one place only. Moved platform defs out into platorm header.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 include/sound/tlv320aic3x.h    |   43 ++++++-
 sound/soc/codecs/tlv320aic23.c |  178 ++++++++----------------
 sound/soc/codecs/tlv320aic23.h |    4 +-
 sound/soc/codecs/tlv320aic26.c |  177 ++++++++---------------
 sound/soc/codecs/tlv320aic26.h |    4 +-
 sound/soc/codecs/tlv320aic3x.c |  276 +++++++++++++-----------------------
 sound/soc/codecs/tlv320aic3x.h |   44 +------
 sound/soc/codecs/tlv320dac33.c |  304 +++++++++++++++-------------------------
 sound/soc/codecs/tlv320dac33.h |    4 +-
 sound/soc/codecs/twl4030.c     |  193 +++++++-------------------
 sound/soc/codecs/twl4030.h     |    4 +-
 sound/soc/codecs/twl6040.c     |  170 ++++++----------------
 sound/soc/codecs/twl6040.h     |    4 +-
 13 files changed, 486 insertions(+), 919 deletions(-)

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
index b0bae35..fbc95c5 100644
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
@@ -591,7 +588,7 @@ static struct snd_soc_dai_ops tlv320aic23_dai_ops = {
 	.set_sysclk	= tlv320aic23_set_dai_sysclk,
 };
 
-struct snd_soc_dai tlv320aic23_dai = {
+struct snd_soc_dai_driver tlv320aic23_dai = {
 	.name = "tlv320aic23",
 	.playback = {
 		     .stream_name = "Playback",
@@ -609,22 +606,17 @@ struct snd_soc_dai tlv320aic23_dai = {
 };
 EXPORT_SYMBOL_GPL(tlv320aic23_dai);
 
-static int tlv320aic23_suspend(struct platform_device *pdev,
+static int tlv320aic23_suspend(struct snd_soc_codec *codec,
 			       pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	tlv320aic23_write(codec, TLV320AIC23_ACTIVE, 0x0);
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
@@ -638,39 +630,17 @@ static int tlv320aic23_resume(struct platform_device *pdev)
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
 
@@ -706,13 +676,30 @@ static int tlv320aic23_init(struct snd_soc_device *socdev)
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
+struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
+	.name = "tlv320aic23",
+	.owner = THIS_MODULE,
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
+EXPORT_SYMBOL_GPL(soc_codec_dev_tlv320aic23);
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
@@ -722,31 +709,30 @@ static struct snd_soc_device *tlv320aic23_socdev;
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
+	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_tlv320aic23, &tlv320aic23_dai, 1);
+	if (ret < 0)
+		kfree(aic23);
 	return ret;
 }
 static int __exit tlv320aic23_i2c_remove(struct i2c_client *i2c)
 {
-	put_device(&i2c->dev);
+	snd_soc_unregister_codec(&i2c->dev, i2c->addr);
+	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
@@ -768,71 +754,25 @@ static struct i2c_driver tlv320aic23_i2c_driver = {
 
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
index 79d1faf..84ce2b3 100644
--- a/sound/soc/codecs/tlv320aic23.h
+++ b/sound/soc/codecs/tlv320aic23.h
@@ -116,7 +116,7 @@
 #define TLV320AIC23_SIDETONE_12		0x080
 #define TLV320AIC23_SIDETONE_18		0x0c0
 
-extern struct snd_soc_dai tlv320aic23_dai;
-extern struct snd_soc_codec_device soc_codec_dev_tlv320aic23;
+extern struct snd_soc_dai_driver tlv320aic23_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_tlv320aic23;
 
 #endif /* _TLV320AIC23_H */
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index f0e00fd..0852b16 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -130,8 +130,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
 	int fsref, divisor, wlen, pval, jval, dval, qval;
 	u16 reg;
@@ -278,7 +277,7 @@ static struct snd_soc_dai_ops aic26_dai_ops = {
 	.set_fmt	= aic26_set_fmt,
 };
 
-struct snd_soc_dai aic26_dai = {
+struct snd_soc_dai_driver aic26_dai = {
 	.name = "tlv320aic26",
 	.playback = {
 		.stream_name = "Playback",
@@ -319,61 +318,6 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
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
 
@@ -409,89 +353,92 @@ static ssize_t aic26_keyclick_set(struct device *dev,
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
+struct snd_soc_codec_driver aic26_soc_codec_dev = {
+	.name = "aic26",
+	.owner = THIS_MODULE,
+	.probe = aic26_probe,
+	.read = aic26_reg_read,
+	.write = aic26_reg_write,
+	.reg_cache_size = AIC26_NUM_REGS,
+	.reg_word_size = sizeof(u16),
+};
+EXPORT_SYMBOL_GPL(aic26_soc_codec_dev);
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
+
+	dev_dbg(&spi->dev, "probing tlv320aic26 spi device\n");
+
+	/* Allocate driver data */
+	aic26 = kzalloc(sizeof *aic26, GFP_KERNEL);
+	if (!aic26)
+		return -ENOMEM;
+
+	/* Initialize the driver data */
+	aic26->spi = spi;
+	dev_set_drvdata(&spi->dev, aic26);
+	aic26->master = 1;
+
+	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
+			&aic26_soc_codec_dev, &aic26_dai, 1);
+	if (ret < 0)
+		kfree(aic26);
+	return ret;
 
-	snd_soc_unregister_dai(&aic26_dai);
-	kfree(aic26);
+	dev_dbg(&spi->dev, "SPI device initialized\n");
+	return 0;
+}
 
+static int aic26_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
+	kfree(spi_get_drvdata(spi));
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic26.h b/sound/soc/codecs/tlv320aic26.h
index 786ba16..cdfee4c 100644
--- a/sound/soc/codecs/tlv320aic26.h
+++ b/sound/soc/codecs/tlv320aic26.h
@@ -90,7 +90,7 @@ enum aic26_wlen {
 	AIC26_WLEN_32	= 3 << 10,
 };
 
-extern struct snd_soc_dai aic26_dai;
-extern struct snd_soc_codec_device aic26_soc_codec_dev;
+extern struct snd_soc_dai_driver aic26_dai;
+extern struct snd_soc_codec_driver aic26_soc_codec_dev;
 
 #endif /* _TLV320AIC16_H_ */
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 71a6990..d2ed13e 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -63,8 +63,9 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 
 /* codec private data */
 struct aic3x_priv {
-	struct snd_soc_codec codec;
 	struct regulator_bulk_data supplies[AIC3X_NUM_SUPPLIES];
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	unsigned int sysclk;
 	int master;
 	int gpio_reset;
@@ -773,8 +774,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
 	u8 data, j, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
@@ -1101,7 +1101,7 @@ static struct snd_soc_dai_ops aic3x_dai_ops = {
 	.set_fmt	= aic3x_set_dai_fmt,
 };
 
-struct snd_soc_dai aic3x_dai = {
+struct snd_soc_dai_driver aic3x_dai = {
 	.name = "tlv320aic3x",
 	.playback = {
 		.stream_name = "Playback",
@@ -1119,20 +1119,15 @@ struct snd_soc_dai aic3x_dai = {
 };
 EXPORT_SYMBOL_GPL(aic3x_dai);
 
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
 
@@ -1245,42 +1224,77 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct snd_soc_codec *aic3x_codec;
-
-static int aic3x_register(struct snd_soc_codec *codec)
+static int aic3x_probe(struct snd_soc_codec *codec)
 {
-	int ret;
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	struct aic3x_pdata *pdata = codec->dev->platform_data;
+	struct aic3x_setup_data *setup = pdata->setup;
+	int ret = 0, i;
+
+	codec->hw_write = (hw_write_t) i2c_master_send;
+	codec->control_data = aic3x->control_data;
 
-	ret = aic3x_init(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to initialise device\n");
-		return ret;
+	aic3x->gpio_reset = -1;
+	if (pdata && pdata->gpio_reset >= 0) {
+		ret = gpio_request(pdata->gpio_reset, "tlv320aic3x reset");
+		if (ret != 0)
+			return ret;
+		aic3x->gpio_reset = pdata->gpio_reset;
+		gpio_direction_output(aic3x->gpio_reset, 0);
 	}
 
-	aic3x_codec = codec;
+	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
+		aic3x->supplies[i].supply = aic3x_supply_names[i];
 
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register codec\n");
-		return ret;
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
+				 aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err_get;
 	}
 
-	ret = snd_soc_register_dai(&aic3x_dai);
-	if (ret) {
-		dev_err(codec->dev, "Failed to register dai\n");
-		snd_soc_unregister_codec(codec);
-		return ret;
+	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
+				    aic3x->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_enable;
 	}
 
-	return 0;
+	if (aic3x->gpio_reset >= 0) {
+		udelay(1);
+		gpio_set_value(aic3x->gpio_reset, 1);
+	}
+
+	if (setup) {
+		/* setup GPIO functions */
+		aic3x_write(codec, AIC3X_GPIO1_REG,
+			    (setup->gpio_func[0] & 0xf) << 4);
+		aic3x_write(codec, AIC3X_GPIO2_REG,
+			    (setup->gpio_func[1] & 0xf) << 4);
+	}
+
+	aic3x_init(codec);
+
+	snd_soc_add_controls(codec, aic3x_snd_controls,
+			     ARRAY_SIZE(aic3x_snd_controls));
+
+	aic3x_add_widgets(codec);
+
+	return ret;
+
+err_enable:
+	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
+err_get:
+	if (aic3x->gpio_reset >= 0)
+		gpio_free(aic3x->gpio_reset);
+	return ret;
 }
 
-static int aic3x_unregister(struct aic3x_priv *aic3x)
+static int aic3x_remove(struct snd_soc_codec *codec)
 {
-	aic3x_set_bias_level(&aic3x->codec, SND_SOC_BIAS_OFF);
+	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_unregister_dai(&aic3x_dai);
-	snd_soc_unregister_codec(&aic3x->codec);
+	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	if (aic3x->gpio_reset >= 0) {
 		gpio_set_value(aic3x->gpio_reset, 0);
@@ -1289,12 +1303,25 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 	regulator_bulk_disable(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 
-	kfree(aic3x);
-	aic3x_codec = NULL;
-
 	return 0;
 }
 
+struct snd_soc_codec_driver soc_codec_dev_aic3x = {
+	.name = "tlv320aic3x",
+	.owner = THIS_MODULE,
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
+EXPORT_SYMBOL_GPL(soc_codec_dev_aic3x);
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * AIC3X 2 wire address can be up to 4 devices with device addresses
@@ -1308,10 +1335,8 @@ static int aic3x_unregister(struct aic3x_priv *aic3x)
 static int aic3x_i2c_probe(struct i2c_client *i2c,
 			   const struct i2c_device_id *id)
 {
-	struct snd_soc_codec *codec;
 	struct aic3x_priv *aic3x;
-	struct aic3x_pdata *pdata = i2c->dev.platform_data;
-	int ret, i;
+	int ret;
 
 	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
 	if (aic3x == NULL) {
@@ -1319,62 +1344,22 @@ static int aic3x_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 	}
 
-	codec = &aic3x->codec;
-	codec->dev = &i2c->dev;
-	snd_soc_codec_set_drvdata(codec, aic3x);
-	codec->control_data = i2c;
-	codec->hw_write = (hw_write_t) i2c_master_send;
-
+	aic3x->control_data = i2c;
 	i2c_set_clientdata(i2c, aic3x);
 
-	aic3x->gpio_reset = -1;
-	if (pdata && pdata->gpio_reset >= 0) {
-		ret = gpio_request(pdata->gpio_reset, "tlv320aic3x reset");
-		if (ret != 0)
-			goto err_gpio;
-		aic3x->gpio_reset = pdata->gpio_reset;
-		gpio_direction_output(aic3x->gpio_reset, 0);
-	}
-
-	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
-		aic3x->supplies[i].supply = aic3x_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(aic3x->supplies),
-				 aic3x->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err_get;
-	}
-
-	ret = regulator_bulk_enable(ARRAY_SIZE(aic3x->supplies),
-				    aic3x->supplies);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_enable;
-	}
-
-	if (aic3x->gpio_reset >= 0) {
-		udelay(1);
-		gpio_set_value(aic3x->gpio_reset, 1);
-	}
+	ret = snd_soc_register_codec(&i2c->dev, i2c->addr,
+			&soc_codec_dev_aic3x, &aic3x_dai, 1);
+	if (ret < 0)
+		kfree(aic3x);
 
-	return aic3x_register(codec);
-
-err_enable:
-	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
-err_get:
-	if (aic3x->gpio_reset >= 0)
-		gpio_free(aic3x->gpio_reset);
-err_gpio:
-	kfree(aic3x);
 	return ret;
 }
 
 static int aic3x_i2c_remove(struct i2c_client *client)
 {
-	struct aic3x_priv *aic3x = i2c_get_clientdata(client);
-
-	return aic3x_unregister(aic3x);
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
+	return 0;
 }
 
 static const struct i2c_device_id aic3x_i2c_id[] = {
@@ -1409,90 +1394,27 @@ static inline void aic3x_i2c_exit(void)
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
index 9af1c88..183a5d4 100644
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
 
@@ -281,11 +245,7 @@ void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
 int aic3x_headset_detected(struct snd_soc_codec *codec);
 int aic3x_button_pressed(struct snd_soc_codec *codec);
 
-struct aic3x_setup_data {
-	unsigned int gpio_func[2];
-};
-
-extern struct snd_soc_dai aic3x_dai;
-extern struct snd_soc_codec_device soc_codec_dev_aic3x;
+extern struct snd_soc_dai_driver aic3x_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_aic3x;
 
 #endif /* _AIC3X_H */
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 2fa946c..9c1a414 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -65,8 +65,6 @@
 static void dac33_calculate_times(struct snd_pcm_substream *substream);
 static int dac33_prepare_chip(struct snd_pcm_substream *substream);
 
-static struct snd_soc_codec *tlv320dac33_codec;
-
 enum dac33_state {
 	DAC33_IDLE = 0,
 	DAC33_PREFILL,
@@ -123,6 +121,8 @@ struct tlv320dac33_priv {
 	unsigned int uthr;
 
 	enum dac33_state state;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 };
 
 static const u8 dac33_reg[DAC33_CACHEREGNUM] = {
@@ -779,8 +779,7 @@ static int dac33_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	/* Stream started, save the substream pointer */
@@ -793,8 +792,7 @@ static void dac33_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	dac33->substream = NULL;
@@ -805,8 +803,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Check parameters for validity */
 	switch (params_rate(params)) {
@@ -844,8 +841,7 @@ static int dac33_hw_params(struct snd_pcm_substream *substream,
 static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int oscset, ratioset, pwr_ctrl, reg_tmp;
 	u8 aictrl_a, aictrl_b, fifoctrl_a;
@@ -1037,8 +1033,7 @@ static int dac33_prepare_chip(struct snd_pcm_substream *substream)
 static void dac33_calculate_times(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned int nsample_limit;
 
@@ -1103,8 +1098,7 @@ static int dac33_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
@@ -1137,8 +1131,7 @@ static snd_pcm_sframes_t dac33_dai_delay(
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	unsigned long long t0, t1, t_now;
 	unsigned int time_delta, uthr;
@@ -1363,26 +1356,73 @@ static int dac33_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int dac33_soc_probe(struct platform_device *pdev)
+static int dac33_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct tlv320dac33_priv *dac33;
-	int ret = 0;
+	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, i;
+
+	codec->control_data = dac33->control_data;
+	codec->hw_write = (hw_write_t) i2c_master_send;
+
+	/* Check if the reset GPIO number is valid and request it */
+	if (dac33->power_gpio >= 0) {
+		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"Failed to request reset GPIO (%d)\n",
+				dac33->power_gpio);
+			return ret;
+		}
+		gpio_direction_output(dac33->power_gpio, 0);
+	} else {
+		dac33->chip_power = 1;
+	}
+
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
+				ret = -ENOMEM;
+				goto error_wq;
+			}
+
+			INIT_WORK(&dac33->work, dac33_work);
+		}
+	}
 
-	BUG_ON(!tlv320dac33_codec);
+	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
+		dac33->supplies[i].supply = dac33_supply_names[i];
 
-	codec = tlv320dac33_codec;
-	socdev->card->codec = codec;
-	dac33 = snd_soc_codec_get_drvdata(codec);
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(dac33->supplies),
+				 dac33->supplies);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms\n");
-		goto pcm_err;
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
+		goto err_get;
 	}
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(dac33->supplies),
+				    dac33->supplies);
+	if (ret != 0) {
+		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
+		goto err_enable;
+	}
+
+	/* Power up the codec */
+	dac33_hard_power(codec, 1);
+
 	snd_soc_add_controls(codec, dac33_snd_controls,
 			     ARRAY_SIZE(dac33_snd_controls));
 	/* Only add the nSample controls, if we have valid IRQ number */
@@ -1394,45 +1434,63 @@ static int dac33_soc_probe(struct platform_device *pdev)
 
 	return 0;
 
-pcm_err:
-	dac33_hard_power(codec, 0);
+err_enable:
+	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+err_get:
+	if (dac33->irq >= 0) {
+		free_irq(dac33->irq, &dac33->codec);
+		destroy_workqueue(dac33->dac33_wq);
+	}
+error_wq:
+	if (dac33->power_gpio >= 0)
+		gpio_free(dac33->power_gpio);
+
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
+	if (unlikely(dac33->chip_power))
+		dac33_hard_power(&dac33->codec, 0);
 
+	if (dac33->power_gpio >= 0)
+		gpio_free(dac33->power_gpio);
+	if (dac33->irq >= 0)
+		free_irq(dac33->irq, &dac33->codec);
+
+	regulator_bulk_disable(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
+	destroy_workqueue(dac33->dac33_wq);
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
+struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
+	.name = "tlv320dac33",
+	.owner = THIS_MODULE,
+	.read = dac33_read_reg_cache,
+	.write = dac33_write_locked,
+	.set_bias_level = dac33_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(dac33_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_default = dac33_reg,
 	.probe = dac33_soc_probe,
 	.remove = dac33_soc_remove,
 	.suspend = dac33_soc_suspend,
@@ -1454,7 +1512,7 @@ static struct snd_soc_dai_ops dac33_dai_ops = {
 	.set_fmt	= dac33_set_dai_fmt,
 };
 
-struct snd_soc_dai dac33_dai = {
+struct snd_soc_dai_driver dac33_dai = {
 	.name = "tlv320dac33",
 	.playback = {
 		.stream_name = "Playback",
@@ -1471,8 +1529,7 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 {
 	struct tlv320dac33_platform_data *pdata;
 	struct tlv320dac33_priv *dac33;
-	struct snd_soc_codec *codec;
-	int ret, i;
+	int ret;
 
 	if (client->dev.platform_data == NULL) {
 		dev_err(&client->dev, "Platform data not set\n");
@@ -1484,34 +1541,8 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	if (dac33 == NULL)
 		return -ENOMEM;
 
-	codec = &dac33->codec;
-	snd_soc_codec_set_drvdata(codec, dac33);
-	codec->control_data = client;
-
-	mutex_init(&codec->mutex);
+	dac33->control_data = client;
 	mutex_init(&dac33->mutex);
-	spin_lock_init(&dac33->lock);
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
-
 	i2c_set_clientdata(client, dac33);
 
 	dac33->power_gpio = pdata->power_gpio;
@@ -1526,126 +1557,17 @@ static int __devinit dac33_i2c_probe(struct i2c_client *client,
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-	tlv320dac33_codec = codec;
-
-	codec->dev = &client->dev;
-	dac33_dai.dev = codec->dev;
-
-	/* Check if the reset GPIO number is valid and request it */
-	if (dac33->power_gpio >= 0) {
-		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"Failed to request reset GPIO (%d)\n",
-				dac33->power_gpio);
-			snd_soc_unregister_dai(&dac33_dai);
-			snd_soc_unregister_codec(codec);
-			goto error_gpio;
-		}
-		gpio_direction_output(dac33->power_gpio, 0);
-	}
-
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
-	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
-		dac33->supplies[i].supply = dac33_supply_names[i];
-
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(dac33->supplies),
-				 dac33->supplies);
-
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
-		goto err_get;
-	}
-
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
-
-	return ret;
-
-error_codec:
-	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-err_get:
-	if (dac33->irq >= 0) {
-		free_irq(dac33->irq, &dac33->codec);
-		destroy_workqueue(dac33->dac33_wq);
-	}
-error_wq:
-	if (dac33->power_gpio >= 0)
-		gpio_free(dac33->power_gpio);
-error_gpio:
-	kfree(codec->reg_cache);
-error_reg:
-	tlv320dac33_codec = NULL;
-	kfree(dac33);
-
+	ret = snd_soc_register_codec(&client->dev, client->addr,
+			&soc_codec_dev_tlv320dac33, &dac33_dai, 1);
+	if (ret < 0)
+		kfree(dac33);
 	return ret;
 }
 
 static int __devexit dac33_i2c_remove(struct i2c_client *client)
 {
-	struct tlv320dac33_priv *dac33;
-
-	dac33 = i2c_get_clientdata(client);
-
-	if (unlikely(dac33->chip_power))
-		dac33_hard_power(&dac33->codec, 0);
-
-	if (dac33->power_gpio >= 0)
-		gpio_free(dac33->power_gpio);
-	if (dac33->irq >= 0)
-		free_irq(dac33->irq, &dac33->codec);
-
-	regulator_bulk_free(ARRAY_SIZE(dac33->supplies), dac33->supplies);
-
-	destroy_workqueue(dac33->dac33_wq);
-	snd_soc_unregister_dai(&dac33_dai);
-	snd_soc_unregister_codec(&dac33->codec);
-	kfree(dac33->codec.reg_cache);
-	kfree(dac33);
-	tlv320dac33_codec = NULL;
-
+	snd_soc_unregister_codec(&client->dev, client->addr);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320dac33.h b/sound/soc/codecs/tlv320dac33.h
index eb8ae07..7498c10 100644
--- a/sound/soc/codecs/tlv320dac33.h
+++ b/sound/soc/codecs/tlv320dac33.h
@@ -261,7 +261,7 @@
 #define TLV320DAC33_MCLK		0
 #define TLV320DAC33_SLEEPCLK		1
 
-extern struct snd_soc_dai dac33_dai;
-extern struct snd_soc_codec_device soc_codec_dev_tlv320dac33;
+extern struct snd_soc_dai_driver dac33_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_tlv320dac33;
 
 #endif /* __TLV320DAC33_H */
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8d36bfa..803f5bb 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -274,11 +274,9 @@ static inline void twl4030_reset_registers(struct snd_soc_codec *codec)
 
 }
 
-static void twl4030_init_chip(struct platform_device *pdev)
+static void twl4030_init_chip(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct twl4030_setup_data *setup = socdev->codec_data;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_setup_data *setup = dev_get_platdata(codec->dev);
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 reg, byte;
 	int i = 0;
@@ -613,7 +611,7 @@ static int micpath_event(struct snd_soc_dapm_widget *w,
 static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
 		struct snd_kcontrol *kcontrol, int event)		\
 {									\
-	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec); \
+	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(w->codec);	\
 									\
 	switch (event) {						\
 	case SND_SOC_DAPM_POST_PMU:					\
@@ -742,9 +740,7 @@ static int aif_event(struct snd_soc_dapm_widget *w,
 
 static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 {
-	struct snd_soc_device *socdev = codec->socdev;
-	struct twl4030_setup_data *setup = socdev->codec_data;
-
+	struct twl4030_codec_audio_data *setup = codec->dev->platform_data;
 	unsigned char hs_gain, hs_pop;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	/* Base values for ramp delay calculation: 2^19 - 2^26 */
@@ -1712,8 +1708,7 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream) {
@@ -1743,8 +1738,7 @@ static void twl4030_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->master_substream == substream)
@@ -1769,8 +1763,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode, old_mode, format, old_format;
 
@@ -2004,8 +1997,7 @@ static int twl4030_voice_startup(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 mode;
 
@@ -2038,8 +2030,7 @@ static void twl4030_voice_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	/* Enable voice digital filters */
 	twl4030_voice_enable(codec, substream->stream, 0);
@@ -2049,8 +2040,7 @@ static int twl4030_voice_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 old_mode, mode;
 
@@ -2180,7 +2170,7 @@ static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
-static struct snd_soc_dai_ops twl4030_dai_ops = {
+struct snd_soc_dai_ops twl4030_dai_ops = {
 	.startup	= twl4030_startup,
 	.shutdown	= twl4030_shutdown,
 	.hw_params	= twl4030_hw_params,
@@ -2198,7 +2188,7 @@ static struct snd_soc_dai_ops twl4030_dai_voice_ops = {
 	.set_tristate	= twl4030_voice_set_tristate,
 };
 
-struct snd_soc_dai twl4030_dai[] = {
+struct snd_soc_dai_driver twl4030_dai[] = {
 {
 	.name = "twl4030",
 	.playback = {
@@ -2234,152 +2224,81 @@ struct snd_soc_dai twl4030_dai[] = {
 };
 EXPORT_SYMBOL_GPL(twl4030_dai);
 
-static int twl4030_soc_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 
+static int twl4030_soc_suspend(struct snd_soc_codec *codec,
+		pm_message_t state)
+{
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
-{
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
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		return ret;
-	}
-
-	snd_soc_add_controls(codec, twl4030_snd_controls,
-				ARRAY_SIZE(twl4030_snd_controls));
-	twl4030_add_widgets(codec);
-
-	return 0;
-}
-
-static int twl4030_soc_remove(struct platform_device *pdev)
+static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	/* Reset registers to their chip default before leaving */
-	twl4030_reset_registers(codec);
-	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-static int __devinit twl4030_codec_probe(struct platform_device *pdev)
-{
-	struct twl4030_codec_audio_data *pdata = pdev->dev.platform_data;
-	struct snd_soc_codec *codec;
+	struct twl4030_codec_audio_data *pdata = codec->dev->platform_data;
 	struct twl4030_priv *twl4030;
-	int ret;
 
 	if (!pdata) {
-		dev_err(&pdev->dev, "platform_data is missing\n");
+		dev_err(codec->dev, "platform_data is missing\n");
 		return -EINVAL;
 	}
 
 	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
 	if (twl4030 == NULL) {
-		dev_err(&pdev->dev, "Can not allocate memroy\n");
+		dev_err(codec->dev, "Can not allocate memroy\n");
 		return -ENOMEM;
 	}
 
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
+	dev_set_drvdata(codec->dev, twl4030);
 
 	/* Set the defaults, and power up the codec */
 	twl4030->sysclk = twl4030_codec_get_mclk() / 1000;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto error_codec;
-	}
+	twl4030_init_chip(codec);
 
-	ret = snd_soc_register_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		snd_soc_unregister_codec(codec);
-		goto error_codec;
-	}
+	snd_soc_add_controls(codec, twl4030_snd_controls,
+				ARRAY_SIZE(twl4030_snd_controls));
+	twl4030_add_widgets(codec);
+	return 0;
+}
 
+static int twl4030_soc_remove(struct snd_soc_codec *codec)
+{
+	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
+}
 
-error_codec:
-	twl4030_codec_enable(codec, 0);
-	kfree(codec->reg_cache);
-error_cache:
-	kfree(twl4030);
-	return ret;
+struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
+	.name = "TWL4030",
+	.owner = THIS_MODULE,
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
+EXPORT_SYMBOL_GPL(soc_codec_dev_twl4030);
+
+static int __devinit twl4030_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id, &soc_codec_dev_twl4030,
+			twl4030_dai, ARRAY_SIZE(twl4030_dai));
 }
 
 static int __devexit twl4030_codec_remove(struct platform_device *pdev)
 {
-	struct twl4030_priv *twl4030 = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_dais(&twl4030_dai[0], ARRAY_SIZE(twl4030_dai));
-	snd_soc_unregister_codec(&twl4030->codec);
-	kfree(twl4030->codec.reg_cache);
-	kfree(twl4030);
-
-	twl4030_codec = NULL;
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
@@ -2406,14 +2325,6 @@ static void __exit twl4030_exit(void)
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
index 788e3d1..42a2014 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -36,8 +36,8 @@
 #define TWL4030_DAI_HIFI		0
 #define TWL4030_DAI_VOICE		1
 
-extern struct snd_soc_dai twl4030_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_twl4030;
+extern struct snd_soc_dai_driver twl4030_dai[2];
+extern struct snd_soc_codec_driver soc_codec_dev_twl4030;
 
 struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 85dd4fb..e65ad82 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -45,7 +45,8 @@
 
 /* codec private data */
 struct twl6040_data {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	int audpwron;
 	int naudint;
 	int codec_powered;
@@ -770,8 +771,7 @@ static int twl6040_startup(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	if (!priv->sysclk) {
@@ -803,8 +803,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	u8 lppllctl;
 	int rate;
@@ -839,8 +838,7 @@ static int twl6040_trigger(struct snd_pcm_substream *substream,
 			int cmd, struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	switch (cmd) {
@@ -978,7 +976,7 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 	.set_sysclk	= twl6040_set_dai_sysclk,
 };
 
-struct snd_soc_dai twl6040_dai = {
+struct snd_soc_dai_driver twl6040_dai = {
 	.name = "twl6040",
 	.playback = {
 		.stream_name = "Playback",
@@ -999,21 +997,15 @@ struct snd_soc_dai twl6040_dai = {
 EXPORT_SYMBOL_GPL(twl6040_dai);
 
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
@@ -1023,68 +1015,9 @@ static int twl6040_resume(struct platform_device *pdev)
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
@@ -1092,6 +1025,7 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 	priv = kzalloc(sizeof(struct twl6040_data), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
+	snd_soc_codec_set_drvdata(codec, priv);
 
 	if (twl_codec) {
 		audpwron = twl_codec->audpwron_gpio;
@@ -1104,29 +1038,6 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
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
@@ -1169,23 +1080,12 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
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
@@ -1193,30 +1093,54 @@ gpio2_err:
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
 
+struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
+	.name = "twl6040",
+	.owner = THIS_MODULE,
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
+EXPORT_SYMBOL_GPL(soc_codec_dev_twl6040);
+
+static int __devinit twl6040_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_twl6040, &twl6040_dai, 1);
+}
+
+static int __devexit twl6040_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index c472070..8c55db8 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -135,7 +135,7 @@
 #define TWL6040_HPPLL_ID		1
 #define TWL6040_LPPLL_ID		2
 
-extern struct snd_soc_dai twl6040_dai;
-extern struct snd_soc_codec_device soc_codec_dev_twl6040;
+extern struct snd_soc_dai_driver twl6040_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_twl6040;
 
 #endif /* End of __TWL6040_H__ */
-- 
1.7.0.4
