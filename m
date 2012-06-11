From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: wm8904: Move register default setup
	into I2C probe()
Date: Mon, 11 Jun 2012 13:10:47 +0800
Message-ID: <1339391447-8721-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3E94104176
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 07:11:22 +0200 (CEST)
In-Reply-To: <1339391447-8721-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Get it done as early as possible, it's neater and minimises the time the
pins aren't configured as requested.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8904.c |  110 ++++++++++++++++++++++-----------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b178232..cc5fb43 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2055,7 +2055,7 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 {
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
-	int ret, i;
+	int ret;
 
 	codec->control_data = wm8904->regmap;
 
@@ -2077,60 +2077,6 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* Change some default settings - latch VU and enable ZC */
-	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_LEFT,
-			    WM8904_ADC_VU, WM8904_ADC_VU);
-	snd_soc_update_bits(codec, WM8904_ADC_DIGITAL_VOLUME_RIGHT,
-			    WM8904_ADC_VU, WM8904_ADC_VU);
-	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_VOLUME_LEFT,
-			    WM8904_DAC_VU, WM8904_DAC_VU);
-	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_VOLUME_RIGHT,
-			    WM8904_DAC_VU, WM8904_DAC_VU);
-	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT1_LEFT,
-			    WM8904_HPOUT_VU | WM8904_HPOUTLZC,
-			    WM8904_HPOUT_VU | WM8904_HPOUTLZC);
-	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT1_RIGHT,
-			    WM8904_HPOUT_VU | WM8904_HPOUTRZC,
-			    WM8904_HPOUT_VU | WM8904_HPOUTRZC);
-	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT2_LEFT,
-			    WM8904_LINEOUT_VU | WM8904_LINEOUTLZC,
-			    WM8904_LINEOUT_VU | WM8904_LINEOUTLZC);
-	snd_soc_update_bits(codec, WM8904_ANALOGUE_OUT2_RIGHT,
-			    WM8904_LINEOUT_VU | WM8904_LINEOUTRZC,
-			    WM8904_LINEOUT_VU | WM8904_LINEOUTRZC);
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_0,
-			    WM8904_SR_MODE, 0);
-
-	/* Apply configuration from the platform data. */
-	if (wm8904->pdata) {
-		for (i = 0; i < WM8904_GPIO_REGS; i++) {
-			if (!pdata->gpio_cfg[i])
-				continue;
-
-			regmap_update_bits(wm8904->regmap,
-					   WM8904_GPIO_CONTROL_1 + i,
-					   0xffff,
-					   pdata->gpio_cfg[i]);
-		}
-
-		/* Zero is the default value for these anyway */
-		for (i = 0; i < WM8904_MIC_REGS; i++)
-			regmap_update_bits(wm8904->regmap,
-					   WM8904_MIC_BIAS_CONTROL_0 + i,
-					   0xffff,
-					   pdata->mic_cfg[i]);
-	}
-
-	/* Set Class W by default - this will be managed by the Class
-	 * G widget at runtime where bypass paths are available.
-	 */
-	snd_soc_update_bits(codec, WM8904_CLASS_W_0,
-			    WM8904_CP_DYN_PWR, WM8904_CP_DYN_PWR);
-
-	/* Use normal bias source */
-	snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
-			    WM8904_POBCTRL, 0);
-
 	wm8904_handle_pdata(codec);
 
 	wm8904_add_widgets(codec);
@@ -2234,6 +2180,60 @@ static __devinit int wm8904_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
+	/* Change some default settings - latch VU and enable ZC */
+	regmap_update_bits(wm8904->regmap, WM8904_ADC_DIGITAL_VOLUME_LEFT,
+			   WM8904_ADC_VU, WM8904_ADC_VU);
+	regmap_update_bits(wm8904->regmap, WM8904_ADC_DIGITAL_VOLUME_RIGHT,
+			   WM8904_ADC_VU, WM8904_ADC_VU);
+	regmap_update_bits(wm8904->regmap, WM8904_DAC_DIGITAL_VOLUME_LEFT,
+			   WM8904_DAC_VU, WM8904_DAC_VU);
+	regmap_update_bits(wm8904->regmap, WM8904_DAC_DIGITAL_VOLUME_RIGHT,
+			   WM8904_DAC_VU, WM8904_DAC_VU);
+	regmap_update_bits(wm8904->regmap, WM8904_ANALOGUE_OUT1_LEFT,
+			   WM8904_HPOUT_VU | WM8904_HPOUTLZC,
+			   WM8904_HPOUT_VU | WM8904_HPOUTLZC);
+	regmap_update_bits(wm8904->regmap, WM8904_ANALOGUE_OUT1_RIGHT,
+			   WM8904_HPOUT_VU | WM8904_HPOUTRZC,
+			   WM8904_HPOUT_VU | WM8904_HPOUTRZC);
+	regmap_update_bits(wm8904->regmap, WM8904_ANALOGUE_OUT2_LEFT,
+			   WM8904_LINEOUT_VU | WM8904_LINEOUTLZC,
+			   WM8904_LINEOUT_VU | WM8904_LINEOUTLZC);
+	regmap_update_bits(wm8904->regmap, WM8904_ANALOGUE_OUT2_RIGHT,
+			   WM8904_LINEOUT_VU | WM8904_LINEOUTRZC,
+			   WM8904_LINEOUT_VU | WM8904_LINEOUTRZC);
+	regmap_update_bits(wm8904->regmap, WM8904_CLOCK_RATES_0,
+			   WM8904_SR_MODE, 0);
+
+	/* Apply configuration from the platform data. */
+	if (wm8904->pdata) {
+		for (i = 0; i < WM8904_GPIO_REGS; i++) {
+			if (!wm8904->pdata->gpio_cfg[i])
+				continue;
+
+			regmap_update_bits(wm8904->regmap,
+					   WM8904_GPIO_CONTROL_1 + i,
+					   0xffff,
+					   wm8904->pdata->gpio_cfg[i]);
+		}
+
+		/* Zero is the default value for these anyway */
+		for (i = 0; i < WM8904_MIC_REGS; i++)
+			regmap_update_bits(wm8904->regmap,
+					   WM8904_MIC_BIAS_CONTROL_0 + i,
+					   0xffff,
+					   wm8904->pdata->mic_cfg[i]);
+	}
+
+	/* Set Class W by default - this will be managed by the Class
+	 * G widget at runtime where bypass paths are available.
+	 */
+	regmap_update_bits(wm8904->regmap, WM8904_CLASS_W_0,
+			    WM8904_CP_DYN_PWR, WM8904_CP_DYN_PWR);
+
+	/* Use normal bias source */
+	regmap_update_bits(wm8904->regmap, WM8904_BIAS_CONTROL_0,
+			    WM8904_POBCTRL, 0);
+
 	/* Can leave the device powered off until we need it */
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
-- 
1.7.10
