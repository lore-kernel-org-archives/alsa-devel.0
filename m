From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Push WM5100 interrupt request into
	I2C probe
Date: Wed, 18 Jan 2012 18:49:41 +0000
Message-ID: <1326912581-24621-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1326912581-24621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB50A103BBA
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 19:49:44 +0100 (CET)
In-Reply-To: <1326912581-24621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is more what the device model wants us to do and will allow use by
non-audio functions before the audio part of the device has come up.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  128 ++++++++++++++++++++++-----------------------
 1 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 02a759d..869e4f4 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2599,7 +2599,7 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 {
 	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	int ret, i, irq_flags;
+	int ret, i;
 
 	wm5100->codec = codec;
 	codec->control_data = wm5100->regmap;
@@ -2626,61 +2626,10 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 
 	/* TODO: check if we're symmetric */
 
-	if (i2c->irq) {
-		if (wm5100->pdata.irq_flags)
-			irq_flags = wm5100->pdata.irq_flags;
-		else
-			irq_flags = IRQF_TRIGGER_LOW;
-
-		irq_flags |= IRQF_ONESHOT;
-
-		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
-			ret = request_threaded_irq(i2c->irq, NULL,
-						   wm5100_edge_irq, irq_flags,
-						   "wm5100", wm5100);
-		else
-			ret = request_threaded_irq(i2c->irq, NULL, wm5100_irq,
-						   irq_flags, "wm5100",
-						   wm5100);
-
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
-				i2c->irq, ret);
-		} else {
-			/* Enable default interrupts */
-			snd_soc_update_bits(codec,
-					    WM5100_INTERRUPT_STATUS_3_MASK,
-					    WM5100_IM_SPK_SHUTDOWN_WARN_EINT |
-					    WM5100_IM_SPK_SHUTDOWN_EINT |
-					    WM5100_IM_ASRC2_LOCK_EINT |
-					    WM5100_IM_ASRC1_LOCK_EINT |
-					    WM5100_IM_FLL2_LOCK_EINT |
-					    WM5100_IM_FLL1_LOCK_EINT |
-					    WM5100_CLKGEN_ERR_EINT |
-					    WM5100_CLKGEN_ERR_ASYNC_EINT, 0);
-
-			snd_soc_update_bits(codec,
-					    WM5100_INTERRUPT_STATUS_4_MASK,
-					    WM5100_AIF3_ERR_EINT |
-					    WM5100_AIF2_ERR_EINT |
-					    WM5100_AIF1_ERR_EINT |
-					    WM5100_CTRLIF_ERR_EINT |
-					    WM5100_ISRC2_UNDERCLOCKED_EINT |
-					    WM5100_ISRC1_UNDERCLOCKED_EINT |
-					    WM5100_FX_UNDERCLOCKED_EINT |
-					    WM5100_AIF3_UNDERCLOCKED_EINT |
-					    WM5100_AIF2_UNDERCLOCKED_EINT |
-					    WM5100_AIF1_UNDERCLOCKED_EINT |
-					    WM5100_ASRC_UNDERCLOCKED_EINT |
-					    WM5100_DAC_UNDERCLOCKED_EINT |
-					    WM5100_ADC_UNDERCLOCKED_EINT |
-					    WM5100_MIXER_UNDERCLOCKED_EINT, 0);
-		}
-	} else {
+	if (i2c->irq)
 		snd_soc_dapm_new_controls(&codec->dapm,
 					  wm5100_dapm_widgets_noirq,
 					  ARRAY_SIZE(wm5100_dapm_widgets_noirq));
-	}
 
 	if (wm5100->pdata.hp_pol) {
 		ret = gpio_request_one(wm5100->pdata.hp_pol,
@@ -2703,9 +2652,6 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 	return 0;
 
 err_gpio:
-	if (i2c->irq)
-		free_irq(i2c->irq, wm5100);
-
 	for (i = 0; i < ARRAY_SIZE(wm5100->adsp1); i++)
 		wm_adsp1_exit(wm5100->adsp1[i]);
 
@@ -2715,16 +2661,12 @@ err_gpio:
 static int wm5100_remove(struct snd_soc_codec *codec)
 {
 	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	int i;
 
 	if (wm5100->pdata.hp_pol) {
 		gpio_free(wm5100->pdata.hp_pol);
 	}
 
-	if (i2c->irq)
-		free_irq(i2c->irq, wm5100);
-
 	for (i = 0; i < ARRAY_SIZE(wm5100->adsp1); i++)
 		wm_adsp1_exit(wm5100->adsp1[i]);
 
@@ -2776,7 +2718,7 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	struct wm5100_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm5100_priv *wm5100;
 	unsigned int reg;
-	int ret, i;
+	int ret, i, irq_flags;
 
 	wm5100 = devm_kzalloc(&i2c->dev, sizeof(struct wm5100_priv),
 			      GFP_KERNEL);
@@ -2913,6 +2855,58 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 				    WM5100_IN1_DMIC_SUP_SHIFT));
 	}
 
+	if (i2c->irq) {
+		if (wm5100->pdata.irq_flags)
+			irq_flags = wm5100->pdata.irq_flags;
+		else
+			irq_flags = IRQF_TRIGGER_LOW;
+
+		irq_flags |= IRQF_ONESHOT;
+
+		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
+			ret = request_threaded_irq(i2c->irq, NULL,
+						   wm5100_edge_irq, irq_flags,
+						   "wm5100", wm5100);
+		else
+			ret = request_threaded_irq(i2c->irq, NULL, wm5100_irq,
+						   irq_flags, "wm5100",
+						   wm5100);
+
+		if (ret != 0) {
+			dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
+				i2c->irq, ret);
+		} else {
+			/* Enable default interrupts */
+			regmap_update_bits(wm5100->regmap,
+					   WM5100_INTERRUPT_STATUS_3_MASK,
+					   WM5100_IM_SPK_SHUTDOWN_WARN_EINT |
+					   WM5100_IM_SPK_SHUTDOWN_EINT |
+					   WM5100_IM_ASRC2_LOCK_EINT |
+					   WM5100_IM_ASRC1_LOCK_EINT |
+					   WM5100_IM_FLL2_LOCK_EINT |
+					   WM5100_IM_FLL1_LOCK_EINT |
+					   WM5100_CLKGEN_ERR_EINT |
+					   WM5100_CLKGEN_ERR_ASYNC_EINT, 0);
+
+			regmap_update_bits(wm5100->regmap,
+					   WM5100_INTERRUPT_STATUS_4_MASK,
+					   WM5100_AIF3_ERR_EINT |
+					   WM5100_AIF2_ERR_EINT |
+					   WM5100_AIF1_ERR_EINT |
+					   WM5100_CTRLIF_ERR_EINT |
+					   WM5100_ISRC2_UNDERCLOCKED_EINT |
+					   WM5100_ISRC1_UNDERCLOCKED_EINT |
+					   WM5100_FX_UNDERCLOCKED_EINT |
+					   WM5100_AIF3_UNDERCLOCKED_EINT |
+					   WM5100_AIF2_UNDERCLOCKED_EINT |
+					   WM5100_AIF1_UNDERCLOCKED_EINT |
+					   WM5100_ASRC_UNDERCLOCKED_EINT |
+					   WM5100_DAC_UNDERCLOCKED_EINT |
+					   WM5100_ADC_UNDERCLOCKED_EINT |
+					   WM5100_MIXER_UNDERCLOCKED_EINT, 0);
+		}
+	}
+
 	ret = snd_soc_register_codec(&i2c->dev,
 				     &soc_codec_dev_wm5100, wm5100_dai,
 				     ARRAY_SIZE(wm5100_dai));
@@ -2924,6 +2918,8 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	return ret;
 
 err_reset:
+	if (i2c->irq)
+		free_irq(i2c->irq, wm5100);
 	wm5100_free_gpio(i2c);
 	if (wm5100->pdata.reset) {
 		gpio_set_value_cansleep(wm5100->pdata.reset, 0);
@@ -2952,12 +2948,14 @@ err:
 	return ret;
 }
 
-static __devexit int wm5100_i2c_remove(struct i2c_client *client)
+static __devexit int wm5100_i2c_remove(struct i2c_client *i2c)
 {
-	struct wm5100_priv *wm5100 = i2c_get_clientdata(client);
+	struct wm5100_priv *wm5100 = i2c_get_clientdata(i2c);
 
-	snd_soc_unregister_codec(&client->dev);
-	wm5100_free_gpio(client);
+	snd_soc_unregister_codec(&i2c->dev);
+	if (i2c->irq)
+		free_irq(i2c->irq, wm5100);
+	wm5100_free_gpio(i2c);
 	if (wm5100->pdata.reset) {
 		gpio_set_value_cansleep(wm5100->pdata.reset, 0);
 		gpio_free(wm5100->pdata.reset);
-- 
1.7.7.3
