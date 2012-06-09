From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: wm8903: Move pin configuration into
	I2C probe() function
Date: Sat,  9 Jun 2012 11:09:52 +0800
Message-ID: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A7AD8103E82
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 05:10:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure that the device pins are configured as soon as possible by moving
the pin configration (including MICBIAS) into the I2C probe() function.
This had been done in the CODEC probe() function when we were relying on
the ASoC register I/O code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This series is untested but should deal with the WM8903 side of what I
was saying earlier.

 sound/soc/codecs/wm8903.c |   92 +++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index e76a66d..7200088 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1,7 +1,7 @@
 /*
  * wm8903.c  --  WM8903 ALSA SoC Audio driver
  *
- * Copyright 2008-11 Wolfson Microelectronics
+ * Copyright 2008-12 Wolfson Microelectronics
  * Copyright 2011-2012 NVIDIA, Inc.
  *
  * Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
@@ -2081,10 +2081,9 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 {
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	struct wm8903_platform_data *pdata = wm8903->pdata;
-	int ret, i;
+	int ret;
 	int trigger, irq_pol;
 	u16 val;
-	bool mic_gpio = false;
 
 	wm8903->codec = codec;
 	codec->control_data = wm8903->regmap;
@@ -2095,47 +2094,6 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* Set up GPIOs, detect if any are MIC detect outputs */
-	for (i = 0; i < ARRAY_SIZE(pdata->gpio_cfg); i++) {
-		if ((!pdata->gpio_cfg[i]) ||
-		    (pdata->gpio_cfg[i] > WM8903_GPIO_CONFIG_ZERO))
-			continue;
-
-		snd_soc_write(codec, WM8903_GPIO_CONTROL_1 + i,
-				pdata->gpio_cfg[i] & 0x7fff);
-
-		val = (pdata->gpio_cfg[i] & WM8903_GP1_FN_MASK)
-			>> WM8903_GP1_FN_SHIFT;
-
-		switch (val) {
-		case WM8903_GPn_FN_MICBIAS_CURRENT_DETECT:
-		case WM8903_GPn_FN_MICBIAS_SHORT_DETECT:
-			mic_gpio = true;
-			break;
-		default:
-			break;
-		}
-	}
-
-	/* Set up microphone detection */
-	snd_soc_write(codec, WM8903_MIC_BIAS_CONTROL_0,
-			pdata->micdet_cfg);
-
-	/* Microphone detection needs the WSEQ clock */
-	if (pdata->micdet_cfg)
-		snd_soc_update_bits(codec, WM8903_WRITE_SEQUENCER_0,
-				    WM8903_WSEQ_ENA, WM8903_WSEQ_ENA);
-
-	/* If microphone detection is enabled by pdata but
-	    * detected via IRQ then interrupts can be lost before
-	    * the machine driver has set up microphone detection
-	    * IRQs as the IRQs are clear on read.  The detection
-	    * will be enabled when the machine driver configures.
-	    */
-	WARN_ON(!mic_gpio && (pdata->micdet_cfg & WM8903_MICDET_ENA));
-
-	wm8903->mic_delay = pdata->micdet_delay;
-
 	if (wm8903->irq) {
 		if (pdata->irq_active_low) {
 			trigger = IRQF_TRIGGER_LOW;
@@ -2316,8 +2274,9 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 {
 	struct wm8903_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8903_priv *wm8903;
+	bool mic_gpio = false;
 	unsigned int val;
-	int ret;
+	int ret, i;
 
 	wm8903 = devm_kzalloc(&i2c->dev,  sizeof(struct wm8903_priv),
 			      GFP_KERNEL);
@@ -2361,6 +2320,8 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	pdata = wm8903->pdata;
+
 	ret = regmap_read(wm8903->regmap, WM8903_SW_RESET_AND_ID, &val);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "Failed to read chip ID: %d\n", ret);
@@ -2385,6 +2346,47 @@ static __devinit int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	wm8903_init_gpio(wm8903);
 
+	/* Set up GPIO pin state, detect if any are MIC detect outputs */
+	for (i = 0; i < ARRAY_SIZE(pdata->gpio_cfg); i++) {
+		if ((!pdata->gpio_cfg[i]) ||
+		    (pdata->gpio_cfg[i] > WM8903_GPIO_CONFIG_ZERO))
+			continue;
+
+		regmap_write(wm8903->regmap, WM8903_GPIO_CONTROL_1 + i,
+				pdata->gpio_cfg[i] & 0x7fff);
+
+		val = (pdata->gpio_cfg[i] & WM8903_GP1_FN_MASK)
+			>> WM8903_GP1_FN_SHIFT;
+
+		switch (val) {
+		case WM8903_GPn_FN_MICBIAS_CURRENT_DETECT:
+		case WM8903_GPn_FN_MICBIAS_SHORT_DETECT:
+			mic_gpio = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Set up microphone detection */
+	regmap_write(wm8903->regmap, WM8903_MIC_BIAS_CONTROL_0,
+		     pdata->micdet_cfg);
+
+	/* Microphone detection needs the WSEQ clock */
+	if (pdata->micdet_cfg)
+		regmap_update_bits(wm8903->regmap, WM8903_WRITE_SEQUENCER_0,
+				   WM8903_WSEQ_ENA, WM8903_WSEQ_ENA);
+
+	/* If microphone detection is enabled by pdata but
+	 * detected via IRQ then interrupts can be lost before
+	 * the machine driver has set up microphone detection
+	 * IRQs as the IRQs are clear on read.  The detection
+	 * will be enabled when the machine driver configures.
+	 */
+	WARN_ON(!mic_gpio && (pdata->micdet_cfg & WM8903_MICDET_ENA));
+
+	wm8903->mic_delay = pdata->micdet_delay;
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_wm8903, &wm8903_dai, 1);
 	if (ret != 0)
-- 
1.7.10
