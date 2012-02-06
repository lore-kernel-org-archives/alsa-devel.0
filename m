From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Bring WM8994 accessory detection
	up to date
Date: Mon,  6 Feb 2012 18:53:08 +0000
Message-ID: <1328554388-12245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C018E103EEC
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 19:53:12 +0100 (CET)
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

Make the mechanism used for WM8994 more like that for WM1811 and WM8958:
provide the logic to distinguish between headphone and headset and hard
code the reporting of sensible SND_JACK values. Should integration with
other detection mechanisms be required we can add appropriate callbacks
(though some integrations should be able to use the subsystem ones).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   82 +++++++++++++++++++++++++++++++++-----------
 sound/soc/codecs/wm8994.h |    5 +--
 2 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 7df3159..298c5ae 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2927,8 +2927,6 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
  * @codec:   WM8994 codec
  * @jack:    jack to report detection events on
  * @micbias: microphone bias to detect on
- * @det:     value to report for presence detection
- * @shrt:    value to report for short detection
  *
  * Enable microphone detection via IRQ on the WM8994.  If GPIOs are
  * being used to bring out signals to the processor then only platform
@@ -2939,43 +2937,63 @@ static void wm8994_handle_pdata(struct wm8994_priv *wm8994)
  * and micbias2_lvl platform data members.
  */
 int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
-		      int micbias, int det, int shrt)
+		      int micbias)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994_micdet *micdet;
 	struct wm8994 *control = wm8994->wm8994;
-	int reg;
+	int reg, ret;
 
-	if (control->type != WM8994)
+	if (control->type != WM8994) {
+		dev_warn(codec->dev, "Not a WM8994\n");
 		return -EINVAL;
+	}
 
 	switch (micbias) {
 	case 1:
 		micdet = &wm8994->micdet[0];
+		if (jack)
+			ret = snd_soc_dapm_force_enable_pin(&codec->dapm,
+							    "MICBIAS1");
+		else
+			ret = snd_soc_dapm_disable_pin(&codec->dapm,
+						       "MICBIAS1");
 		break;
 	case 2:
 		micdet = &wm8994->micdet[1];
+		if (jack)
+			ret = snd_soc_dapm_force_enable_pin(&codec->dapm,
+							    "MICBIAS1");
+		else
+			ret = snd_soc_dapm_disable_pin(&codec->dapm,
+						       "MICBIAS1");
 		break;
 	default:
+		dev_warn(codec->dev, "Invalid MICBIAS %d\n", micbias);
 		return -EINVAL;
-	}	
+	}
 
-	dev_dbg(codec->dev, "Configuring microphone detection on %d: %x %x\n",
-		micbias, det, shrt);
+	if (ret != 0)
+		dev_warn(codec->dev, "Failed to configure MICBIAS%d: %d\n",
+			 micbias, ret);
+
+	dev_dbg(codec->dev, "Configuring microphone detection on %d %p\n",
+		micbias, jack);
 
 	/* Store the configuration */
 	micdet->jack = jack;
-	micdet->det = det;
-	micdet->shrt = shrt;
+	micdet->detecting = true;
 
 	/* If either of the jacks is set up then enable detection */
 	if (wm8994->micdet[0].jack || wm8994->micdet[1].jack)
 		reg = WM8994_MICD_ENA;
-	else 
+	else
 		reg = 0;
 
 	snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, reg);
 
+	snd_soc_dapm_sync(&codec->dapm);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm8994_mic_detect);
@@ -3001,20 +3019,42 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 	dev_dbg(codec->dev, "Microphone status: %x\n", reg);
 
 	report = 0;
-	if (reg & WM8994_MIC1_DET_STS)
-		report |= priv->micdet[0].det;
-	if (reg & WM8994_MIC1_SHRT_STS)
-		report |= priv->micdet[0].shrt;
+	if (reg & WM8994_MIC1_DET_STS) {
+		if (priv->micdet[0].detecting)
+			report = SND_JACK_HEADSET;
+	}
+	if (reg & WM8994_MIC1_SHRT_STS) {
+		if (priv->micdet[0].detecting)
+			report = SND_JACK_HEADPHONE;
+		else
+			report |= SND_JACK_BTN_0;
+	}
+	if (report)
+		priv->micdet[0].detecting = false;
+	else
+		priv->micdet[0].detecting = true;
+
 	snd_soc_jack_report(priv->micdet[0].jack, report,
-			    priv->micdet[0].det | priv->micdet[0].shrt);
+			    SND_JACK_HEADSET | SND_JACK_BTN_0);
 
 	report = 0;
-	if (reg & WM8994_MIC2_DET_STS)
-		report |= priv->micdet[1].det;
-	if (reg & WM8994_MIC2_SHRT_STS)
-		report |= priv->micdet[1].shrt;
+	if (reg & WM8994_MIC2_DET_STS) {
+		if (priv->micdet[1].detecting)
+			report = SND_JACK_HEADSET;
+	}
+	if (reg & WM8994_MIC2_SHRT_STS) {
+		if (priv->micdet[1].detecting)
+			report = SND_JACK_HEADPHONE;
+		else
+			report |= SND_JACK_BTN_0;
+	}
+	if (report)
+		priv->micdet[1].detecting = false;
+	else
+		priv->micdet[1].detecting = true;
+
 	snd_soc_jack_report(priv->micdet[1].jack, report,
-			    priv->micdet[1].det | priv->micdet[1].shrt);
+			    SND_JACK_HEADSET | SND_JACK_BTN_0);
 
 	return IRQ_HANDLED;
 }
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index c3a4247..f996d14 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -35,7 +35,7 @@
 typedef void (*wm8958_micdet_cb)(u16 status, void *data);
 
 int wm8994_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
-		      int micbias, int det, int shrt);
+		      int micbias);
 int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		      wm8958_micdet_cb cb, void *cb_data);
 
@@ -46,8 +46,7 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec);
 
 struct wm8994_micdet {
 	struct snd_soc_jack *jack;
-	int det;
-	int shrt;
+	bool detecting;
 };
 
 /* codec private data */
-- 
1.7.9.rc1
