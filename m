From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8962: Move register initialisation to
	I2C probe()
Date: Thu, 17 Oct 2013 15:07:16 +0100
Message-ID: <1382018836-7448-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 359412654D5
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 16:07:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This is more idiomatic and is required for robust operation since we must
ensure that the clocking configuration is valid as rapidly as possible.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 150 +++++++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 54379ee..2bf9ee7 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3242,7 +3242,7 @@ static void wm8962_free_beep(struct snd_soc_codec *codec)
 }
 #endif
 
-static void wm8962_set_gpio_mode(struct snd_soc_codec *codec, int gpio)
+static void wm8962_set_gpio_mode(struct wm8962_priv *wm8962, int gpio)
 {
 	int mask = 0;
 	int val = 0;
@@ -3263,8 +3263,8 @@ static void wm8962_set_gpio_mode(struct snd_soc_codec *codec, int gpio)
 	}
 
 	if (mask)
-		snd_soc_update_bits(codec, WM8962_ANALOGUE_CLOCKING1,
-				    mask, val);
+		regmap_update_bits(wm8962->regmap, WM8962_ANALOGUE_CLOCKING1,
+				   mask, val);
 }
 
 #ifdef CONFIG_GPIOLIB
@@ -3276,7 +3276,6 @@ static inline struct wm8962_priv *gpio_to_wm8962(struct gpio_chip *chip)
 static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct wm8962_priv *wm8962 = gpio_to_wm8962(chip);
-	struct snd_soc_codec *codec = wm8962->codec;
 
 	/* The WM8962 GPIOs aren't linearly numbered.  For simplicity
 	 * we export linear numbers and error out if the unsupported
@@ -3292,7 +3291,7 @@ static int wm8962_gpio_request(struct gpio_chip *chip, unsigned offset)
 		return -EINVAL;
 	}
 
-	wm8962_set_gpio_mode(codec, offset + 1);
+	wm8962_set_gpio_mode(wm8962, offset + 1);
 
 	return 0;
 }
@@ -3376,7 +3375,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 {
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	struct wm8962_pdata *pdata = &wm8962->pdata;
 	int i;
 	bool dmicclk, dmicdat;
 
@@ -3409,75 +3407,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	/* SYSCLK defaults to on; make sure it is off so we can safely
-	 * write to registers if the device is declocked.
-	 */
-	snd_soc_update_bits(codec, WM8962_CLOCKING2, WM8962_SYSCLK_ENA, 0);
-
-	/* Ensure we have soft control over all registers */
-	snd_soc_update_bits(codec, WM8962_CLOCKING2,
-			    WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);
-
-	/* Ensure that the oscillator and PLLs are disabled */
-	snd_soc_update_bits(codec, WM8962_PLL2,
-			    WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
-			    0);
-
-	/* Apply static configuration for GPIOs */
-	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
-		if (pdata->gpio_init[i]) {
-			wm8962_set_gpio_mode(codec, i + 1);
-			snd_soc_write(codec, 0x200 + i,
-					pdata->gpio_init[i] & 0xffff);
-		}
-
-
-	/* Put the speakers into mono mode? */
-	if (pdata->spk_mono)
-		snd_soc_update_bits(codec, WM8962_CLASS_D_CONTROL_2,
-				WM8962_SPK_MONO_MASK, WM8962_SPK_MONO);
-
-	/* Micbias setup, detection enable and detection
-	 * threasholds. */
-	if (pdata->mic_cfg)
-		snd_soc_update_bits(codec, WM8962_ADDITIONAL_CONTROL_4,
-				    WM8962_MICDET_ENA |
-				    WM8962_MICDET_THR_MASK |
-				    WM8962_MICSHORT_THR_MASK |
-				    WM8962_MICBIAS_LVL,
-				    pdata->mic_cfg);
-
-	/* Latch volume update bits */
-	snd_soc_update_bits(codec, WM8962_LEFT_INPUT_VOLUME,
-			    WM8962_IN_VU, WM8962_IN_VU);
-	snd_soc_update_bits(codec, WM8962_RIGHT_INPUT_VOLUME,
-			    WM8962_IN_VU, WM8962_IN_VU);
-	snd_soc_update_bits(codec, WM8962_LEFT_ADC_VOLUME,
-			    WM8962_ADC_VU, WM8962_ADC_VU);
-	snd_soc_update_bits(codec, WM8962_RIGHT_ADC_VOLUME,
-			    WM8962_ADC_VU, WM8962_ADC_VU);
-	snd_soc_update_bits(codec, WM8962_LEFT_DAC_VOLUME,
-			    WM8962_DAC_VU, WM8962_DAC_VU);
-	snd_soc_update_bits(codec, WM8962_RIGHT_DAC_VOLUME,
-			    WM8962_DAC_VU, WM8962_DAC_VU);
-	snd_soc_update_bits(codec, WM8962_SPKOUTL_VOLUME,
-			    WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
-	snd_soc_update_bits(codec, WM8962_SPKOUTR_VOLUME,
-			    WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
-	snd_soc_update_bits(codec, WM8962_HPOUTL_VOLUME,
-			    WM8962_HPOUT_VU, WM8962_HPOUT_VU);
-	snd_soc_update_bits(codec, WM8962_HPOUTR_VOLUME,
-			    WM8962_HPOUT_VU, WM8962_HPOUT_VU);
-
-	/* Stereo control for EQ */
-	snd_soc_update_bits(codec, WM8962_EQ1, WM8962_EQ_SHARED_COEFF, 0);
-
-	/* Don't debouce interrupts so we don't need SYSCLK */
-	snd_soc_update_bits(codec, WM8962_IRQ_DEBOUNCE,
-			    WM8962_FLL_LOCK_DB | WM8962_PLL3_LOCK_DB |
-			    WM8962_PLL2_LOCK_DB | WM8962_TEMP_SHUT_DB,
-			    0);
-
 	wm8962_add_widgets(codec);
 
 	/* Save boards having to disable DMIC when not in use */
@@ -3671,6 +3600,77 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
+	/* SYSCLK defaults to on; make sure it is off so we can safely
+	 * write to registers if the device is declocked.
+	 */
+	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
+			   WM8962_SYSCLK_ENA, 0);
+
+	/* Ensure we have soft control over all registers */
+	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
+			   WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);
+
+	/* Ensure that the oscillator and PLLs are disabled */
+	regmap_update_bits(wm8962->regmap, WM8962_PLL2,
+			   WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
+			   0);
+
+	/* Apply static configuration for GPIOs */
+	for (i = 0; i < ARRAY_SIZE(pdata->gpio_init); i++)
+		if (pdata->gpio_init[i]) {
+			wm8962_set_gpio_mode(wm8962, i + 1);
+			regmap_write(wm8962->regmap, 0x200 + i,
+				     pdata->gpio_init[i] & 0xffff);
+		}
+
+
+	/* Put the speakers into mono mode? */
+	if (pdata->spk_mono)
+		regmap_update_bits(wm8962->regmap, WM8962_CLASS_D_CONTROL_2,
+				   WM8962_SPK_MONO_MASK, WM8962_SPK_MONO);
+
+	/* Micbias setup, detection enable and detection
+	 * threasholds. */
+	if (pdata->mic_cfg)
+		regmap_update_bits(wm8962->regmap, WM8962_ADDITIONAL_CONTROL_4,
+				   WM8962_MICDET_ENA |
+				   WM8962_MICDET_THR_MASK |
+				   WM8962_MICSHORT_THR_MASK |
+				   WM8962_MICBIAS_LVL,
+				   pdata->mic_cfg);
+
+	/* Latch volume update bits */
+	regmap_update_bits(wm8962->regmap, WM8962_LEFT_INPUT_VOLUME,
+			   WM8962_IN_VU, WM8962_IN_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_RIGHT_INPUT_VOLUME,
+			   WM8962_IN_VU, WM8962_IN_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_LEFT_ADC_VOLUME,
+			   WM8962_ADC_VU, WM8962_ADC_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_RIGHT_ADC_VOLUME,
+			   WM8962_ADC_VU, WM8962_ADC_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_LEFT_DAC_VOLUME,
+			   WM8962_DAC_VU, WM8962_DAC_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_RIGHT_DAC_VOLUME,
+			   WM8962_DAC_VU, WM8962_DAC_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_SPKOUTL_VOLUME,
+			   WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_SPKOUTR_VOLUME,
+			   WM8962_SPKOUT_VU, WM8962_SPKOUT_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_HPOUTL_VOLUME,
+			   WM8962_HPOUT_VU, WM8962_HPOUT_VU);
+	regmap_update_bits(wm8962->regmap, WM8962_HPOUTR_VOLUME,
+			   WM8962_HPOUT_VU, WM8962_HPOUT_VU);
+
+	/* Stereo control for EQ */
+	regmap_update_bits(wm8962->regmap, WM8962_EQ1,
+			   WM8962_EQ_SHARED_COEFF, 0);
+
+	/* Don't debouce interrupts so we don't need SYSCLK */
+	regmap_update_bits(wm8962->regmap, WM8962_IRQ_DEBOUNCE,
+			   WM8962_FLL_LOCK_DB | WM8962_PLL3_LOCK_DB |
+			   WM8962_PLL2_LOCK_DB | WM8962_TEMP_SHUT_DB,
+			   0);
+
 	if (wm8962->pdata.in4_dc_measure) {
 		ret = regmap_register_patch(wm8962->regmap,
 					    wm8962_dc_measure,
-- 
1.8.4.rc3
