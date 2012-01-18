From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Make WM5100 interrupt path use
	regmap directly
Date: Wed, 18 Jan 2012 18:49:40 +0000
Message-ID: <1326912581-24621-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7828A103BB7
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 19:49:44 +0100 (CET)
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

This will allow us to move the interrupt allocation out of the ASoC part
of the driver and simplifies the locking by removing any reliance in the
bulk of the interrupt path on the big CODEC lock.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5100.c |  187 ++++++++++++++++++++++++++-------------------
 1 files changed, 107 insertions(+), 80 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index b22b425..02a759d 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -51,6 +51,7 @@ struct wm5100_fll {
 
 /* codec private data */
 struct wm5100_priv {
+	struct device *dev;
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
@@ -891,48 +892,48 @@ static int wm5100_dbvdd_ev(struct snd_soc_dapm_widget *w,
 	}
 }
 
-static void wm5100_log_status3(struct snd_soc_codec *codec, int val)
+static void wm5100_log_status3(struct wm5100_priv *wm5100, int val)
 {
 	if (val & WM5100_SPK_SHUTDOWN_WARN_EINT)
-		dev_crit(codec->dev, "Speaker shutdown warning\n");
+		dev_crit(wm5100->dev, "Speaker shutdown warning\n");
 	if (val & WM5100_SPK_SHUTDOWN_EINT)
-		dev_crit(codec->dev, "Speaker shutdown\n");
+		dev_crit(wm5100->dev, "Speaker shutdown\n");
 	if (val & WM5100_CLKGEN_ERR_EINT)
-		dev_crit(codec->dev, "SYSCLK underclocked\n");
+		dev_crit(wm5100->dev, "SYSCLK underclocked\n");
 	if (val & WM5100_CLKGEN_ERR_ASYNC_EINT)
-		dev_crit(codec->dev, "ASYNCCLK underclocked\n");
+		dev_crit(wm5100->dev, "ASYNCCLK underclocked\n");
 }
 
-static void wm5100_log_status4(struct snd_soc_codec *codec, int val)
+static void wm5100_log_status4(struct wm5100_priv *wm5100, int val)
 {
 	if (val & WM5100_AIF3_ERR_EINT)
-		dev_err(codec->dev, "AIF3 configuration error\n");
+		dev_err(wm5100->dev, "AIF3 configuration error\n");
 	if (val & WM5100_AIF2_ERR_EINT)
-		dev_err(codec->dev, "AIF2 configuration error\n");
+		dev_err(wm5100->dev, "AIF2 configuration error\n");
 	if (val & WM5100_AIF1_ERR_EINT)
-		dev_err(codec->dev, "AIF1 configuration error\n");
+		dev_err(wm5100->dev, "AIF1 configuration error\n");
 	if (val & WM5100_CTRLIF_ERR_EINT)
-		dev_err(codec->dev, "Control interface error\n");
+		dev_err(wm5100->dev, "Control interface error\n");
 	if (val & WM5100_ISRC2_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "ISRC2 underclocked\n");
+		dev_err(wm5100->dev, "ISRC2 underclocked\n");
 	if (val & WM5100_ISRC1_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "ISRC1 underclocked\n");
+		dev_err(wm5100->dev, "ISRC1 underclocked\n");
 	if (val & WM5100_FX_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "FX underclocked\n");
+		dev_err(wm5100->dev, "FX underclocked\n");
 	if (val & WM5100_AIF3_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "AIF3 underclocked\n");
+		dev_err(wm5100->dev, "AIF3 underclocked\n");
 	if (val & WM5100_AIF2_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "AIF2 underclocked\n");
+		dev_err(wm5100->dev, "AIF2 underclocked\n");
 	if (val & WM5100_AIF1_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "AIF1 underclocked\n");
+		dev_err(wm5100->dev, "AIF1 underclocked\n");
 	if (val & WM5100_ASRC_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "ASRC underclocked\n");
+		dev_err(wm5100->dev, "ASRC underclocked\n");
 	if (val & WM5100_DAC_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "DAC underclocked\n");
+		dev_err(wm5100->dev, "DAC underclocked\n");
 	if (val & WM5100_ADC_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "ADC underclocked\n");
+		dev_err(wm5100->dev, "ADC underclocked\n");
 	if (val & WM5100_MIXER_UNDERCLOCKED_EINT)
-		dev_err(codec->dev, "Mixer underclocked\n");
+		dev_err(wm5100->dev, "Mixer underclocked\n");
 }
 
 static int wm5100_post_ev(struct snd_soc_dapm_widget *w,
@@ -940,16 +941,17 @@ static int wm5100_post_ev(struct snd_soc_dapm_widget *w,
 			  int event)
 {
 	struct snd_soc_codec *codec = w->codec;
+	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
 	ret = snd_soc_read(codec, WM5100_INTERRUPT_RAW_STATUS_3);
 	ret &= WM5100_SPK_SHUTDOWN_WARN_STS |
 		WM5100_SPK_SHUTDOWN_STS | WM5100_CLKGEN_ERR_STS |
 		WM5100_CLKGEN_ERR_ASYNC_STS;
-	wm5100_log_status3(codec, ret);
+	wm5100_log_status3(wm5100, ret);
 
 	ret = snd_soc_read(codec, WM5100_INTERRUPT_RAW_STATUS_4);
-	wm5100_log_status4(codec, ret);
+	wm5100_log_status4(wm5100, ret);
 
 	return 0;
 }
@@ -2200,55 +2202,59 @@ static int wm5100_dig_vu[] = {
 	WM5100_DAC_DIGITAL_VOLUME_6R,
 };
 
-static void wm5100_set_detect_mode(struct snd_soc_codec *codec, int the_mode)
+static void wm5100_set_detect_mode(struct wm5100_priv *wm5100, int the_mode)
 {
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
 	struct wm5100_jack_mode *mode = &wm5100->pdata.jack_modes[the_mode];
 
 	BUG_ON(the_mode >= ARRAY_SIZE(wm5100->pdata.jack_modes));
 
 	gpio_set_value_cansleep(wm5100->pdata.hp_pol, mode->hp_pol);
-	snd_soc_update_bits(codec, WM5100_ACCESSORY_DETECT_MODE_1,
-			    WM5100_ACCDET_BIAS_SRC_MASK |
-			    WM5100_ACCDET_SRC,
-			    (mode->bias << WM5100_ACCDET_BIAS_SRC_SHIFT) |
-			    mode->micd_src << WM5100_ACCDET_SRC_SHIFT);
-	snd_soc_update_bits(codec, WM5100_MISC_CONTROL,
-			    WM5100_HPCOM_SRC,
-			    mode->micd_src << WM5100_HPCOM_SRC_SHIFT);
+	regmap_update_bits(wm5100->regmap, WM5100_ACCESSORY_DETECT_MODE_1,
+			   WM5100_ACCDET_BIAS_SRC_MASK |
+			   WM5100_ACCDET_SRC,
+			   (mode->bias << WM5100_ACCDET_BIAS_SRC_SHIFT) |
+			   mode->micd_src << WM5100_ACCDET_SRC_SHIFT);
+	regmap_update_bits(wm5100->regmap, WM5100_MISC_CONTROL,
+			   WM5100_HPCOM_SRC,
+			   mode->micd_src << WM5100_HPCOM_SRC_SHIFT);
 
 	wm5100->jack_mode = the_mode;
 
-	dev_dbg(codec->dev, "Set microphone polarity to %d\n",
+	dev_dbg(wm5100->dev, "Set microphone polarity to %d\n",
 		wm5100->jack_mode);
 }
 
-static void wm5100_micd_irq(struct snd_soc_codec *codec)
+static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 {
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
-	int val;
+	unsigned int val;
+	int ret;
 
-	val = snd_soc_read(codec, WM5100_MIC_DETECT_3);
+	ret = regmap_read(wm5100->regmap, WM5100_MIC_DETECT_3, &val);
+	if (ret != 0) {
+		dev_err(wm5100->dev, "Failed to read micropone status: %d\n",
+			ret);
+		return;
+	}
 
-	dev_dbg(codec->dev, "Microphone event: %x\n", val);
+	dev_dbg(wm5100->dev, "Microphone event: %x\n", val);
 
 	if (!(val & WM5100_ACCDET_VALID)) {
-		dev_warn(codec->dev, "Microphone detection state invalid\n");
+		dev_warn(wm5100->dev, "Microphone detection state invalid\n");
 		return;
 	}
 
 	/* No accessory, reset everything and report removal */
 	if (!(val & WM5100_ACCDET_STS)) {
-		dev_dbg(codec->dev, "Jack removal detected\n");
+		dev_dbg(wm5100->dev, "Jack removal detected\n");
 		wm5100->jack_mic = false;
 		wm5100->jack_detecting = true;
 		snd_soc_jack_report(wm5100->jack, 0,
 				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
 				    SND_JACK_BTN_0);
 
-		snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
-				    WM5100_ACCDET_RATE_MASK,
-				    WM5100_ACCDET_RATE_MASK);
+		regmap_update_bits(wm5100->regmap, WM5100_MIC_DETECT_1,
+				   WM5100_ACCDET_RATE_MASK,
+				   WM5100_ACCDET_RATE_MASK);
 		return;
 	}
 
@@ -2258,7 +2264,7 @@ static void wm5100_micd_irq(struct snd_soc_codec *codec)
 	 */
 	if (val & 0x400) {
 		if (wm5100->jack_detecting) {
-			dev_dbg(codec->dev, "Microphone detected\n");
+			dev_dbg(wm5100->dev, "Microphone detected\n");
 			wm5100->jack_mic = true;
 			snd_soc_jack_report(wm5100->jack,
 					    SND_JACK_HEADSET,
@@ -2266,11 +2272,11 @@ static void wm5100_micd_irq(struct snd_soc_codec *codec)
 
 			/* Increase poll rate to give better responsiveness
 			 * for buttons */
-			snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
-					    WM5100_ACCDET_RATE_MASK,
-					    5 << WM5100_ACCDET_RATE_SHIFT);
+			regmap_update_bits(wm5100->regmap, WM5100_MIC_DETECT_1,
+					   WM5100_ACCDET_RATE_MASK,
+					   5 << WM5100_ACCDET_RATE_SHIFT);
 		} else {
-			dev_dbg(codec->dev, "Mic button up\n");
+			dev_dbg(wm5100->dev, "Mic button up\n");
 			snd_soc_jack_report(wm5100->jack, 0, SND_JACK_BTN_0);
 		}
 
@@ -2283,7 +2289,7 @@ static void wm5100_micd_irq(struct snd_soc_codec *codec)
 	 * plain headphones.
 	 */
 	if (wm5100->jack_detecting && (val & 0x3f8)) {
-		wm5100_set_detect_mode(codec, !wm5100->jack_mode);
+		wm5100_set_detect_mode(wm5100, !wm5100->jack_mode);
 
 		return;
 	}
@@ -2293,20 +2299,20 @@ static void wm5100_micd_irq(struct snd_soc_codec *codec)
 	 */
 	if (val & 0x3fc) {
 		if (wm5100->jack_mic) {
-			dev_dbg(codec->dev, "Mic button detected\n");
+			dev_dbg(wm5100->dev, "Mic button detected\n");
 			snd_soc_jack_report(wm5100->jack, SND_JACK_BTN_0,
 					    SND_JACK_BTN_0);
 		} else if (wm5100->jack_detecting) {
-			dev_dbg(codec->dev, "Headphone detected\n");
+			dev_dbg(wm5100->dev, "Headphone detected\n");
 			snd_soc_jack_report(wm5100->jack, SND_JACK_HEADPHONE,
 					    SND_JACK_HEADPHONE);
 
 			/* Increase the detection rate a bit for
 			 * responsiveness.
 			 */
-			snd_soc_update_bits(codec, WM5100_MIC_DETECT_1,
-					    WM5100_ACCDET_RATE_MASK,
-					    7 << WM5100_ACCDET_RATE_SHIFT);
+			regmap_update_bits(wm5100->regmap, WM5100_MIC_DETECT_1,
+					   WM5100_ACCDET_RATE_MASK,
+					   7 << WM5100_ACCDET_RATE_SHIFT);
 		}
 	}
 }
@@ -2319,7 +2325,7 @@ int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 		wm5100->jack = jack;
 		wm5100->jack_detecting = true;
 
-		wm5100_set_detect_mode(codec, 0);
+		wm5100_set_detect_mode(wm5100, 0);
 
 		/* Slowest detection rate, gives debounce for initial
 		 * detection */
@@ -2358,52 +2364,70 @@ int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 
 static irqreturn_t wm5100_irq(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct wm5100_priv *wm5100 = snd_soc_codec_get_drvdata(codec);
+	struct wm5100_priv *wm5100 = data;
 	irqreturn_t status = IRQ_NONE;
-	int irq_val;
+	unsigned int irq_val, mask_val;
+	int ret;
 
-	irq_val = snd_soc_read(codec, WM5100_INTERRUPT_STATUS_3);
-	if (irq_val < 0) {
-		dev_err(codec->dev, "Failed to read IRQ status 3: %d\n",
-			irq_val);
+	ret = regmap_read(wm5100->regmap, WM5100_INTERRUPT_STATUS_3, &irq_val);
+	if (ret < 0) {
+		dev_err(wm5100->dev, "Failed to read IRQ status 3: %d\n",
+			ret);
 		irq_val = 0;
 	}
-	irq_val &= ~snd_soc_read(codec, WM5100_INTERRUPT_STATUS_3_MASK);
 
-	snd_soc_write(codec, WM5100_INTERRUPT_STATUS_3, irq_val);
+	ret = regmap_read(wm5100->regmap, WM5100_INTERRUPT_STATUS_3_MASK,
+			  &mask_val);
+	if (ret < 0) {
+		dev_err(wm5100->dev, "Failed to read IRQ mask 3: %d\n",
+			ret);
+		mask_val = 0xffff;
+	}
+
+	irq_val &= ~mask_val;
+
+	regmap_write(wm5100->regmap, WM5100_INTERRUPT_STATUS_3, irq_val);
 
 	if (irq_val)
 		status = IRQ_HANDLED;
 
-	wm5100_log_status3(codec, irq_val);
+	wm5100_log_status3(wm5100, irq_val);
 
 	if (irq_val & WM5100_FLL1_LOCK_EINT) {
-		dev_dbg(codec->dev, "FLL1 locked\n");
+		dev_dbg(wm5100->dev, "FLL1 locked\n");
 		complete(&wm5100->fll[0].lock);
 	}
 	if (irq_val & WM5100_FLL2_LOCK_EINT) {
-		dev_dbg(codec->dev, "FLL2 locked\n");
+		dev_dbg(wm5100->dev, "FLL2 locked\n");
 		complete(&wm5100->fll[1].lock);
 	}
 
 	if (irq_val & WM5100_ACCDET_EINT)
-		wm5100_micd_irq(codec);
+		wm5100_micd_irq(wm5100);
 
-	irq_val = snd_soc_read(codec, WM5100_INTERRUPT_STATUS_4);
-	if (irq_val < 0) {
-		dev_err(codec->dev, "Failed to read IRQ status 4: %d\n",
-			irq_val);
+	ret = regmap_read(wm5100->regmap, WM5100_INTERRUPT_STATUS_4, &irq_val);
+	if (ret < 0) {
+		dev_err(wm5100->dev, "Failed to read IRQ status 4: %d\n",
+			ret);
 		irq_val = 0;
 	}
-	irq_val &= ~snd_soc_read(codec, WM5100_INTERRUPT_STATUS_4_MASK);
+
+	ret = regmap_read(wm5100->regmap, WM5100_INTERRUPT_STATUS_4_MASK,
+			  &mask_val);
+	if (ret < 0) {
+		dev_err(wm5100->dev, "Failed to read IRQ mask 4: %d\n",
+			ret);
+		mask_val = 0xffff;
+	}
+
+	irq_val &= ~mask_val;
 
 	if (irq_val)
 		status = IRQ_HANDLED;
 
-	snd_soc_write(codec, WM5100_INTERRUPT_STATUS_4, irq_val);
+	regmap_write(wm5100->regmap, WM5100_INTERRUPT_STATUS_4, irq_val);
 
-	wm5100_log_status4(codec, irq_val);
+	wm5100_log_status4(wm5100, irq_val);
 
 	return status;
 }
@@ -2612,11 +2636,12 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
-						   wm5100_edge_irq,
-						   irq_flags, "wm5100", codec);
+						   wm5100_edge_irq, irq_flags,
+						   "wm5100", wm5100);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm5100_irq,
-						   irq_flags, "wm5100", codec);
+						   irq_flags, "wm5100",
+						   wm5100);
 
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
@@ -2679,7 +2704,7 @@ static int wm5100_probe(struct snd_soc_codec *codec)
 
 err_gpio:
 	if (i2c->irq)
-		free_irq(i2c->irq, codec);
+		free_irq(i2c->irq, wm5100);
 
 	for (i = 0; i < ARRAY_SIZE(wm5100->adsp1); i++)
 		wm_adsp1_exit(wm5100->adsp1[i]);
@@ -2698,7 +2723,7 @@ static int wm5100_remove(struct snd_soc_codec *codec)
 	}
 
 	if (i2c->irq)
-		free_irq(i2c->irq, codec);
+		free_irq(i2c->irq, wm5100);
 
 	for (i = 0; i < ARRAY_SIZE(wm5100->adsp1); i++)
 		wm_adsp1_exit(wm5100->adsp1[i]);
@@ -2758,6 +2783,8 @@ static __devinit int wm5100_i2c_probe(struct i2c_client *i2c,
 	if (wm5100 == NULL)
 		return -ENOMEM;
 
+	wm5100->dev = &i2c->dev;
+
 	wm5100->regmap = regmap_init_i2c(i2c, &wm5100_regmap);
 	if (IS_ERR(wm5100->regmap)) {
 		ret = PTR_ERR(wm5100->regmap);
-- 
1.7.7.3
