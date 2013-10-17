From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: wm8962: Move interrupt initalisation to
	probe()
Date: Thu, 17 Oct 2013 14:56:56 +0100
Message-ID: <1382018216-30205-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F86A261A61
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2013 15:57:00 +0200 (CEST)
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

This is more idiomatic and fixes bugs in the error handling paths.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 11d80f3..54379ee 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3377,7 +3377,7 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	struct wm8962_pdata *pdata = &wm8962->pdata;
-	int i, trigger, irq_pol;
+	int i;
 	bool dmicclk, dmicdat;
 
 	wm8962->codec = codec;
@@ -3506,36 +3506,6 @@ static int wm8962_probe(struct snd_soc_codec *codec)
 	wm8962_init_beep(codec);
 	wm8962_init_gpio(codec);
 
-	if (wm8962->irq) {
-		if (pdata->irq_active_low) {
-			trigger = IRQF_TRIGGER_LOW;
-			irq_pol = WM8962_IRQ_POL;
-		} else {
-			trigger = IRQF_TRIGGER_HIGH;
-			irq_pol = 0;
-		}
-
-		snd_soc_update_bits(codec, WM8962_INTERRUPT_CONTROL,
-				    WM8962_IRQ_POL, irq_pol);
-
-		ret = request_threaded_irq(wm8962->irq, NULL, wm8962_irq,
-					   trigger | IRQF_ONESHOT,
-					   "wm8962", codec->dev);
-		if (ret != 0) {
-			dev_err(codec->dev, "Failed to request IRQ %d: %d\n",
-				wm8962->irq, ret);
-			wm8962->irq = 0;
-			/* Non-fatal */
-		} else {
-			/* Enable some IRQs by default */
-			snd_soc_update_bits(codec,
-					    WM8962_INTERRUPT_STATUS_2_MASK,
-					    WM8962_FLL_LOCK_EINT |
-					    WM8962_TEMP_SHUT_EINT |
-					    WM8962_FIFOS_ERR_EINT, 0);
-		}
-	}
-
 	return 0;
 }
 
@@ -3544,9 +3514,6 @@ static int wm8962_remove(struct snd_soc_codec *codec)
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int i;
 
-	if (wm8962->irq)
-		free_irq(wm8962->irq, codec);
-
 	cancel_delayed_work_sync(&wm8962->mic_work);
 
 	wm8962_free_gpio(codec);
@@ -3619,7 +3586,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	struct wm8962_pdata *pdata = dev_get_platdata(&i2c->dev);
 	struct wm8962_priv *wm8962;
 	unsigned int reg;
-	int ret, i;
+	int ret, i, irq_pol, trigger;
 
 	wm8962 = devm_kzalloc(&i2c->dev, sizeof(struct wm8962_priv),
 			      GFP_KERNEL);
@@ -3714,6 +3681,37 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 				ret);
 	}
 
+	if (wm8962->irq) {
+		if (pdata->irq_active_low) {
+			trigger = IRQF_TRIGGER_LOW;
+			irq_pol = WM8962_IRQ_POL;
+		} else {
+			trigger = IRQF_TRIGGER_HIGH;
+			irq_pol = 0;
+		}
+
+		regmap_update_bits(wm8962->regmap, WM8962_INTERRUPT_CONTROL,
+				   WM8962_IRQ_POL, irq_pol);
+
+		ret = devm_request_threaded_irq(&i2c->dev, wm8962->irq, NULL,
+						wm8962_irq,
+						trigger | IRQF_ONESHOT,
+						"wm8962", &i2c->dev);
+		if (ret != 0) {
+			dev_err(&i2c->dev, "Failed to request IRQ %d: %d\n",
+				wm8962->irq, ret);
+			wm8962->irq = 0;
+			/* Non-fatal */
+		} else {
+			/* Enable some IRQs by default */
+			regmap_update_bits(wm8962->regmap,
+					   WM8962_INTERRUPT_STATUS_2_MASK,
+					   WM8962_FLL_LOCK_EINT |
+					   WM8962_TEMP_SHUT_EINT |
+					   WM8962_FIFOS_ERR_EINT, 0);
+		}
+	}
+
 	pm_runtime_enable(&i2c->dev);
 	pm_request_idle(&i2c->dev);
 
-- 
1.8.4.rc3
