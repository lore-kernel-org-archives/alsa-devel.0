From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 15/16] ASoC: multi-component - Wolfson AudioPlus
	CODECs
Date: Fri, 25 Jun 2010 18:53:02 +0100
Message-ID: <1277488383-31287-16-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F234C103A22
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:39 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so187440wwb.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:39 -0700 (PDT)
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

Move Wolfson AudioPlus CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8350.c |  231 +++++++++++++++++----------------------------
 sound/soc/codecs/wm8350.h |    4 +-
 sound/soc/codecs/wm8400.c |  181 ++++++++++-------------------------
 sound/soc/codecs/wm8400.h |    4 +-
 4 files changed, 141 insertions(+), 279 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 0221ca7..ffb6568 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1321,20 +1321,14 @@ static int wm8350_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm8350_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8350_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm8350_resume(struct platform_device *pdev)
+static int wm8350_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
@@ -1489,24 +1483,75 @@ int wm8350_mic_jack_detect(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(wm8350_mic_jack_detect);
 
-static struct snd_soc_codec *wm8350_codec;
+#define WM8350_RATES (SNDRV_PCM_RATE_8000_96000)
+
+#define WM8350_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S20_3LE |\
+			SNDRV_PCM_FMTBIT_S24_LE)
 
-static int wm8350_probe(struct platform_device *pdev)
+static struct snd_soc_dai_ops wm8350_dai_ops = {
+	 .hw_params	= wm8350_pcm_hw_params,
+	 .digital_mute	= wm8350_mute,
+	 .trigger	= wm8350_pcm_trigger,
+	 .set_fmt	= wm8350_set_dai_fmt,
+	 .set_sysclk	= wm8350_set_dai_sysclk,
+	 .set_pll	= wm8350_set_fll,
+	 .set_clkdiv	= wm8350_set_clkdiv,
+};
+
+struct snd_soc_dai_driver wm8350_dai = {
+	.name = "WM8350",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = WM8350_RATES,
+		.formats = WM8350_FORMATS,
+	},
+	.capture = {
+		 .stream_name = "Capture",
+		 .channels_min = 1,
+		 .channels_max = 2,
+		 .rates = WM8350_RATES,
+		 .formats = WM8350_FORMATS,
+	 },
+	.ops = &wm8350_dai_ops,
+};
+EXPORT_SYMBOL_GPL(wm8350_dai);
+
+static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct wm8350 *wm8350;
+	struct wm8350 *wm8350 = dev_get_platdata(codec->dev);
 	struct wm8350_data *priv;
-	int ret;
 	struct wm8350_output *out1;
 	struct wm8350_output *out2;
+	int ret, i;
+
+	if (wm8350->codec.platform_data == NULL) {
+		dev_err(codec->dev, "No audio platform data supplied\n");
+		return -EINVAL;
+	}
+
+	priv = kzalloc(sizeof(struct wm8350_data), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+	snd_soc_codec_set_drvdata(codec, priv);
+
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		priv->supplies[i].supply = supply_names[i];
+
+	ret = regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
+				 priv->supplies);
+	if (ret != 0)
+		goto err_priv;
 
-	BUG_ON(!wm8350_codec);
+	wm8350->codec.codec = codec;
+	codec->control_data = wm8350;
 
-	socdev->card->codec = wm8350_codec;
-	codec = socdev->card->codec;
-	wm8350 = codec->control_data;
-	priv = snd_soc_codec_get_drvdata(codec);
+	/* Put the codec into reset if it wasn't already */
+	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
+
+	INIT_DELAYED_WORK(&codec->delayed_work, wm8350_pga_work);
 
 	/* Enable the codec */
 	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
@@ -1557,11 +1602,6 @@ static int wm8350_probe(struct platform_device *pdev)
 	wm8350_register_irq(wm8350, WM8350_IRQ_CODEC_MICD,
 			    wm8350_mic_handler, 0, "Microphone detect", priv);
 
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		return ret;
-	}
 
 	snd_soc_add_controls(codec, wm8350_snd_controls,
 				ARRAY_SIZE(wm8350_snd_controls));
@@ -1570,14 +1610,16 @@ static int wm8350_probe(struct platform_device *pdev)
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
+
+err_priv:
+	kfree(priv);
+	return ret;
 }
 
-static int wm8350_remove(struct platform_device *pdev)
+static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct wm8350 *wm8350 = codec->control_data;
 	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct wm8350 *wm8350 = dev_get_platdata(codec->dev);
 	int ret;
 
 	wm8350_clear_bits(wm8350, WM8350_JACK_DETECT,
@@ -1607,134 +1649,33 @@ static int wm8350_remove(struct platform_device *pdev)
 
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
+	regulator_bulk_free(ARRAY_SIZE(priv->supplies), priv->supplies);
+	kfree(priv);
 	return 0;
 }
 
-#define WM8350_RATES (SNDRV_PCM_RATE_8000_96000)
-
-#define WM8350_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
-			SNDRV_PCM_FMTBIT_S20_3LE |\
-			SNDRV_PCM_FMTBIT_S24_LE)
-
-static struct snd_soc_dai_ops wm8350_dai_ops = {
-	 .hw_params	= wm8350_pcm_hw_params,
-	 .digital_mute	= wm8350_mute,
-	 .trigger	= wm8350_pcm_trigger,
-	 .set_fmt	= wm8350_set_dai_fmt,
-	 .set_sysclk	= wm8350_set_dai_sysclk,
-	 .set_pll	= wm8350_set_fll,
-	 .set_clkdiv	= wm8350_set_clkdiv,
-};
-
-struct snd_soc_dai wm8350_dai = {
+struct snd_soc_codec_driver soc_codec_dev_wm8350 = {
 	.name = "WM8350",
-	.playback = {
-		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
-		.rates = WM8350_RATES,
-		.formats = WM8350_FORMATS,
-	},
-	.capture = {
-		 .stream_name = "Capture",
-		 .channels_min = 1,
-		 .channels_max = 2,
-		 .rates = WM8350_RATES,
-		 .formats = WM8350_FORMATS,
-	 },
-	.ops = &wm8350_dai_ops,
-};
-EXPORT_SYMBOL_GPL(wm8350_dai);
-
-struct snd_soc_codec_device soc_codec_dev_wm8350 = {
-	.probe = 	wm8350_probe,
-	.remove = 	wm8350_remove,
+	.owner = THIS_MODULE,
+	.probe = 	wm8350_codec_probe,
+	.remove = 	wm8350_codec_remove,
 	.suspend = 	wm8350_suspend,
 	.resume =	wm8350_resume,
+	.read = wm8350_codec_read,
+	.write = wm8350_codec_write,
+	.set_bias_level = wm8350_set_bias_level,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm8350);
 
-static __devinit int wm8350_codec_probe(struct platform_device *pdev)
+static int __devinit wm8350_probe(struct platform_device *pdev)
 {
-	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
-	struct wm8350_data *priv;
-	struct snd_soc_codec *codec;
-	int ret, i;
-
-	if (wm8350->codec.platform_data == NULL) {
-		dev_err(&pdev->dev, "No audio platform data supplied\n");
-		return -EINVAL;
-	}
-
-	priv = kzalloc(sizeof(struct wm8350_data), GFP_KERNEL);
-	if (priv == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
-		priv->supplies[i].supply = supply_names[i];
-
-	ret = regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
-				 priv->supplies);
-	if (ret != 0)
-		goto err_priv;
-
-	codec = &priv->codec;
-	wm8350->codec.codec = codec;
-
-	wm8350_dai.dev = &pdev->dev;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	codec->dev = &pdev->dev;
-	codec->name = "WM8350";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8350_codec_read;
-	codec->write = wm8350_codec_write;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8350_set_bias_level;
-	codec->dai = &wm8350_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8350_MAX_REGISTER;
-	snd_soc_codec_set_drvdata(codec, priv);
-	codec->control_data = wm8350;
-
-	/* Put the codec into reset if it wasn't already */
-	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
-
-	INIT_DELAYED_WORK(&codec->delayed_work, wm8350_pga_work);
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0)
-		goto err_supply;
-
-	wm8350_codec = codec;
-
-	ret = snd_soc_register_dai(&wm8350_dai);
-	if (ret != 0)
-		goto err_codec;
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err_supply:
-	regulator_bulk_free(ARRAY_SIZE(priv->supplies), priv->supplies);
-err_priv:
-	kfree(priv);
-	wm8350_codec = NULL;
-	return ret;
+	return snd_soc_register_codec(&pdev->dev, pdev->id, &soc_codec_dev_wm8350,
+			&wm8350_dai, 1);
 }
 
-static int __devexit wm8350_codec_remove(struct platform_device *pdev)
+static int __devexit wm8350_remove(struct platform_device *pdev)
 {
-	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = wm8350->codec.codec;
-	struct wm8350_data *priv = snd_soc_codec_get_drvdata(codec);
-
-	snd_soc_unregister_dai(&wm8350_dai);
-	snd_soc_unregister_codec(codec);
-	regulator_bulk_free(ARRAY_SIZE(priv->supplies), priv->supplies);
-	kfree(priv);
-	wm8350_codec = NULL;
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
@@ -1743,8 +1684,8 @@ static struct platform_driver wm8350_codec_driver = {
 		   .name = "wm8350-codec",
 		   .owner = THIS_MODULE,
 		   },
-	.probe = wm8350_codec_probe,
-	.remove = __devexit_p(wm8350_codec_remove),
+	.probe = wm8350_probe,
+	.remove = __devexit_p(wm8350_remove),
 };
 
 static __init int wm8350_init(void)
diff --git a/sound/soc/codecs/wm8350.h b/sound/soc/codecs/wm8350.h
index 9ed0467..6dafc20 100644
--- a/sound/soc/codecs/wm8350.h
+++ b/sound/soc/codecs/wm8350.h
@@ -15,8 +15,8 @@
 #include <sound/soc.h>
 #include <linux/mfd/wm8350/audio.h>
 
-extern struct snd_soc_dai wm8350_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8350;
+extern struct snd_soc_dai_driver wm8350_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8350;
 
 enum wm8350_jack {
 	WM8350_JDL = 1,
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 8f29406..95f7055 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -65,7 +65,7 @@ static struct regulator_bulk_data power[] = {
 
 /* codec private data */
 struct wm8400_priv {
-	struct snd_soc_codec codec;
+	struct snd_soc_codec *codec;
 	struct wm8400 *wm8400;
 	u16 fake_register;
 	unsigned int sysclk;
@@ -1163,8 +1163,7 @@ static int wm8400_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 audio1 = wm8400_read(codec, WM8400_AUDIO_INTERFACE_1);
 
 	audio1 &= ~WM8400_AIF_WL_MASK;
@@ -1332,10 +1331,9 @@ static struct snd_soc_dai_ops wm8400_dai_ops = {
  * 1. ADC/DAC on Primary Interface
  * 2. ADC on Primary Interface/DAC on secondary
  */
-struct snd_soc_dai wm8400_dai = {
+struct snd_soc_dai_driver wm8400_dai = {
 /* ADC/DAC on primary */
 	.name = "WM8400 ADC/DAC Primary",
-	.id = 1,
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -1354,145 +1352,52 @@ struct snd_soc_dai wm8400_dai = {
 };
 EXPORT_SYMBOL_GPL(wm8400_dai);
 
-static int wm8400_suspend(struct platform_device *pdev, pm_message_t state)
+static int wm8400_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8400_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-static int wm8400_resume(struct platform_device *pdev)
+static int wm8400_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm8400_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
 
-static struct snd_soc_codec *wm8400_codec;
-
-static int wm8400_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (!wm8400_codec) {
-		dev_err(&pdev->dev, "wm8400 not yet discovered\n");
-		return -ENODEV;
-	}
-	codec = wm8400_codec;
-
-	socdev->card->codec = codec;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		goto pcm_err;
-	}
-
-	wm8400_add_controls(codec);
-	wm8400_add_widgets(codec);
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int wm8400_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_wm8400 = {
-	.probe =	wm8400_probe,
-	.remove =	wm8400_remove,
-	.suspend =	wm8400_suspend,
-	.resume =	wm8400_resume,
-};
-
 static void wm8400_probe_deferred(struct work_struct *work)
 {
 	struct wm8400_priv *priv = container_of(work, struct wm8400_priv,
 						work);
-	struct snd_soc_codec *codec = &priv->codec;
-	int ret;
+	struct snd_soc_codec *codec = priv->codec;
 
 	/* charge output caps */
 	wm8400_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	/* We're done, tell the subsystem. */
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(priv->wm8400->dev,
-			"Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&wm8400_dai);
-	if (ret != 0) {
-		dev_err(priv->wm8400->dev,
-			"Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-	return;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	wm8400_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
 
-static int wm8400_codec_probe(struct platform_device *dev)
+static int wm8400_codec_probe(struct snd_soc_codec *codec)
 {
+	struct wm8400 *wm8400 = dev_get_platdata(codec->dev);
 	struct wm8400_priv *priv;
 	int ret;
 	u16 reg;
-	struct snd_soc_codec *codec;
 
 	priv = kzalloc(sizeof(struct wm8400_priv), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	codec = &priv->codec;
 	snd_soc_codec_set_drvdata(codec, priv);
-	codec->control_data = dev_get_drvdata(&dev->dev);
-	priv->wm8400 = dev_get_drvdata(&dev->dev);
+	codec->control_data = priv->wm8400 = wm8400;
+	priv->codec = codec;
 
-	ret = regulator_bulk_get(priv->wm8400->dev,
+	ret = regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
-		dev_err(&dev->dev, "Failed to get regulators: %d\n", ret);
+		dev_err(codec->dev, "Failed to get regulators: %d\n", ret);
 	        goto err;
 	}
 
-	codec->dev = &dev->dev;
-	wm8400_dai.dev = &dev->dev;
-
-	codec->name = "WM8400";
-	codec->owner = THIS_MODULE;
-	codec->read = wm8400_read;
-	codec->write = wm8400_write;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = wm8400_set_bias_level;
-	codec->dai = &wm8400_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = WM8400_REGISTER_COUNT;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
 	INIT_WORK(&priv->work, wm8400_probe_deferred);
 
 	wm8400_codec_reset(codec);
@@ -1511,65 +1416,81 @@ static int wm8400_codec_probe(struct platform_device *dev)
 	wm8400_write(codec, WM8400_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	wm8400_write(codec, WM8400_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	wm8400_codec = codec;
-
 	if (!schedule_work(&priv->work)) {
 		ret = -EINVAL;
 		goto err_regulator;
 	}
-
+	wm8400_add_controls(codec);
+	wm8400_add_widgets(codec);
 	return 0;
 
 err_regulator:
-	wm8400_codec = NULL;
 	regulator_bulk_free(ARRAY_SIZE(power), power);
 err:
 	kfree(priv);
 	return ret;
 }
 
-static int __exit wm8400_codec_remove(struct platform_device *dev)
+static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 {
-	struct wm8400_priv *priv = snd_soc_codec_get_drvdata(wm8400_codec);
+	struct wm8400_priv *priv = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
 
-	snd_soc_unregister_dai(&wm8400_dai);
-	snd_soc_unregister_codec(wm8400_codec);
-
-	reg = wm8400_read(wm8400_codec, WM8400_POWER_MANAGEMENT_1);
-	wm8400_write(wm8400_codec, WM8400_POWER_MANAGEMENT_1,
+	reg = wm8400_read(codec, WM8400_POWER_MANAGEMENT_1);
+	wm8400_write(codec, WM8400_POWER_MANAGEMENT_1,
 		     reg & (~WM8400_CODEC_ENA));
 
 	regulator_bulk_free(ARRAY_SIZE(power), power);
 	kfree(priv);
 
-	wm8400_codec = NULL;
+	return 0;
+}
+
+struct snd_soc_codec_driver soc_codec_dev_wm8400 = {
+	.name = "wm8400",
+	.owner = THIS_MODULE,
+	.probe = 	wm8400_codec_probe,
+	.remove = 	wm8400_codec_remove,
+	.suspend = 	wm8400_suspend,
+	.resume =	wm8400_resume,
+	.read = wm8400_read,
+	.write = wm8400_write,
+	.set_bias_level = wm8400_set_bias_level,
+};
+EXPORT_SYMBOL_GPL(soc_codec_dev_wm8400);
+
+static int __devinit wm8400_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id, &soc_codec_dev_wm8400,
+			&wm8400_dai, 1);
+}
 
+static int __devexit wm8400_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
 static struct platform_driver wm8400_codec_driver = {
 	.driver = {
-		.name = "wm8400-codec",
-		.owner = THIS_MODULE,
-	},
-	.probe = wm8400_codec_probe,
-	.remove	= __exit_p(wm8400_codec_remove),
+		   .name = "wm8400-codec",
+		   .owner = THIS_MODULE,
+		   },
+	.probe = wm8400_probe,
+	.remove = __devexit_p(wm8400_remove),
 };
 
-static int __init wm8400_codec_init(void)
+static __init int wm8400_init(void)
 {
 	return platform_driver_register(&wm8400_codec_driver);
 }
-module_init(wm8400_codec_init);
+module_init(wm8400_init);
 
-static void __exit wm8400_codec_exit(void)
+static __exit void wm8400_exit(void)
 {
 	platform_driver_unregister(&wm8400_codec_driver);
 }
-module_exit(wm8400_codec_exit);
-
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm8400);
+module_exit(wm8400_exit);
 
 MODULE_DESCRIPTION("ASoC WM8400 driver");
 MODULE_AUTHOR("Mark Brown");
diff --git a/sound/soc/codecs/wm8400.h b/sound/soc/codecs/wm8400.h
index 79c5934..a75a3ee 100644
--- a/sound/soc/codecs/wm8400.h
+++ b/sound/soc/codecs/wm8400.h
@@ -56,7 +56,7 @@
 #define WM8400_BCLK_DIV_44                      (0xE << 1)
 #define WM8400_BCLK_DIV_48                      (0xF << 1)
 
-extern struct snd_soc_dai wm8400_dai;
-extern struct snd_soc_codec_device soc_codec_dev_wm8400;
+extern struct snd_soc_dai_driver wm8400_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_wm8400;
 
 #endif
-- 
1.7.0.4
