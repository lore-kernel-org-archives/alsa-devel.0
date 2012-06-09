From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/5] ASoC: wm8903: Make interrupt handler use
	regmap directly
Date: Sat,  9 Jun 2012 11:09:53 +0800
Message-ID: <1339211396-31711-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 06C5D103B6F
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 05:10:11 +0200 (CEST)
In-Reply-To: <1339211396-31711-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

There's no urgent need for the interrupt handler to use the ASoC I/O
functions and it'll support a further move in where we request the
interrupt so call the regmap APIs directly.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   48 ++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 7200088..8fe9b78 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1830,17 +1830,27 @@ EXPORT_SYMBOL_GPL(wm8903_mic_detect);
 
 static irqreturn_t wm8903_irq(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
-	int mic_report;
-	int int_pol;
-	int int_val = 0;
-	int mask = ~snd_soc_read(codec, WM8903_INTERRUPT_STATUS_1_MASK);
+	struct wm8903_priv *wm8903 = data;
+	int mic_report, ret;
+	unsigned int int_val, mask, int_pol;
+
+	ret = regmap_read(wm8903->regmap, WM8903_INTERRUPT_STATUS_1_MASK,
+			  &mask);
+	if (ret != 0) {
+		dev_err(wm8903->dev, "Failed to read IRQ mask: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	ret = regmap_read(wm8903->regmap, WM8903_INTERRUPT_STATUS_1, &int_val);
+	if (ret != 0) {
+		dev_err(wm8903->dev, "Failed to read IRQ status: %d\n", ret);
+		return IRQ_NONE;
+	}
 
-	int_val = snd_soc_read(codec, WM8903_INTERRUPT_STATUS_1) & mask;
+	int_val &= ~mask;
 
 	if (int_val & WM8903_WSEQ_BUSY_EINT) {
-		dev_warn(codec->dev, "Write sequencer done\n");
+		dev_warn(wm8903->dev, "Write sequencer done\n");
 	}
 
 	/*
@@ -1851,22 +1861,28 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 	 * the polarity register.
 	 */
 	mic_report = wm8903->mic_last_report;
-	int_pol = snd_soc_read(codec, WM8903_INTERRUPT_POLARITY_1);
+	ret = regmap_read(wm8903->regmap, WM8903_INTERRUPT_POLARITY_1,
+			  &int_pol);
+	if (ret != 0) {
+		dev_err(wm8903->dev, "Failed to read interrupt polarity: %d\n",
+			ret);
+		return IRQ_HANDLED;
+	}
 
 #ifndef CONFIG_SND_SOC_WM8903_MODULE
 	if (int_val & (WM8903_MICSHRT_EINT | WM8903_MICDET_EINT))
-		trace_snd_soc_jack_irq(dev_name(codec->dev));
+		trace_snd_soc_jack_irq(dev_name(wm8903->dev));
 #endif
 
 	if (int_val & WM8903_MICSHRT_EINT) {
-		dev_dbg(codec->dev, "Microphone short (pol=%x)\n", int_pol);
+		dev_dbg(wm8903->dev, "Microphone short (pol=%x)\n", int_pol);
 
 		mic_report ^= wm8903->mic_short;
 		int_pol ^= WM8903_MICSHRT_INV;
 	}
 
 	if (int_val & WM8903_MICDET_EINT) {
-		dev_dbg(codec->dev, "Microphone detect (pol=%x)\n", int_pol);
+		dev_dbg(wm8903->dev, "Microphone detect (pol=%x)\n", int_pol);
 
 		mic_report ^= wm8903->mic_det;
 		int_pol ^= WM8903_MICDET_INV;
@@ -1874,8 +1890,8 @@ static irqreturn_t wm8903_irq(int irq, void *data)
 		msleep(wm8903->mic_delay);
 	}
 
-	snd_soc_update_bits(codec, WM8903_INTERRUPT_POLARITY_1,
-			    WM8903_MICSHRT_INV | WM8903_MICDET_INV, int_pol);
+	regmap_update_bits(wm8903->regmap, WM8903_INTERRUPT_POLARITY_1,
+			   WM8903_MICSHRT_INV | WM8903_MICDET_INV, int_pol);
 
 	snd_soc_jack_report(wm8903->mic_jack, mic_report,
 			    wm8903->mic_short | wm8903->mic_det);
@@ -2108,7 +2124,7 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 		
 		ret = request_threaded_irq(wm8903->irq, NULL, wm8903_irq,
 					   trigger | IRQF_ONESHOT,
-					   "wm8903", codec);
+					   "wm8903", wm8903);
 		if (ret != 0) {
 			dev_err(codec->dev, "Failed to request IRQ: %d\n",
 				ret);
@@ -2164,7 +2180,7 @@ static int wm8903_remove(struct snd_soc_codec *codec)
 
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	if (wm8903->irq)
-		free_irq(wm8903->irq, codec);
+		free_irq(wm8903->irq, wm8903);
 
 	return 0;
 }
-- 
1.7.10
