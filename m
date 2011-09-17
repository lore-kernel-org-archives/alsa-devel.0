From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Initial WM8996 headphone impedance
	measurement support
Date: Sat, 17 Sep 2011 14:14:50 +0100
Message-ID: <1316265291-3758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 013D5244A0
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 15:14:54 +0200 (CEST)
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

The WM8996 can measure the impedance of accessories connected to the
headphone output. Implement initial support for this, measuring the
left channel impedance when an accessory is detected and using this
to distinguish between a line load and a headphone load.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |  137 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 112 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8e9d7f7..a6168c5 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2350,12 +2350,94 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 
 	/* Enable interrupts and we're off */
 	snd_soc_update_bits(codec, WM8996_INTERRUPT_STATUS_2_MASK,
-			    WM8996_IM_MICD_EINT, 0);
+			    WM8996_IM_MICD_EINT | WM8996_HP_DONE_EINT, 0);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm8996_detect);
 
+static void wm8996_hpdet_irq(struct snd_soc_codec *codec)
+{
+	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	int val, reg, report;
+
+	/* Assume headphone in error conditions; we need to report
+	 * something or we stall our state machine.
+	 */
+	report = SND_JACK_HEADPHONE;
+
+	reg = snd_soc_read(codec, WM8996_HEADPHONE_DETECT_2);
+	if (reg < 0) {
+		dev_err(codec->dev, "Failed to read HPDET status\n");
+		goto out;
+	}
+
+	if (!(reg & WM8996_HP_DONE)) {
+		dev_err(codec->dev, "Got HPDET IRQ but HPDET is busy\n");
+		goto out;
+	}
+
+	val = reg & WM8996_HP_LVL_MASK;
+
+	dev_dbg(codec->dev, "HPDET measured %d ohms\n", val);
+
+	/* If we've got high enough impedence then report as line,
+	 * otherwise assume headphone.
+	 */
+	if (val >= 126)
+		report = SND_JACK_LINEOUT;
+	else
+		report = SND_JACK_HEADPHONE;
+
+out:
+	if (wm8996->jack_mic)
+		report |= SND_JACK_MICROPHONE;
+
+	snd_soc_jack_report(wm8996->jack, report,
+			    SND_JACK_LINEOUT | SND_JACK_HEADSET);
+
+	wm8996->detecting = false;
+
+	/* If the output isn't running re-clamp it */
+	if (!(snd_soc_read(codec, WM8996_POWER_MANAGEMENT_1) &
+	      (WM8996_HPOUT1L_ENA | WM8996_HPOUT1R_RMV_SHORT)))
+		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1,
+				    WM8996_HPOUT1L_RMV_SHORT |
+				    WM8996_HPOUT1R_RMV_SHORT, 0);
+
+	/* Go back to looking at the microphone */
+	snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_1,
+			    WM8996_JD_MODE_MASK, 0);
+	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1, WM8996_MICD_ENA,
+			    WM8996_MICD_ENA);
+
+	snd_soc_dapm_disable_pin(&codec->dapm, "Bandgap");
+	snd_soc_dapm_sync(&codec->dapm);
+}
+
+static void wm8996_hpdet_start(struct snd_soc_codec *codec)
+{
+	/* Unclamp the output, we can't measure while we're shorting it */
+	snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1,
+			    WM8996_HPOUT1L_RMV_SHORT |
+			    WM8996_HPOUT1R_RMV_SHORT,
+			    WM8996_HPOUT1L_RMV_SHORT |
+			    WM8996_HPOUT1R_RMV_SHORT);
+
+	/* We need bandgap for HPDET */
+	snd_soc_dapm_force_enable_pin(&codec->dapm, "Bandgap");
+	snd_soc_dapm_sync(&codec->dapm);
+
+	/* Go into headphone detect left mode */
+	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1, WM8996_MICD_ENA, 0);
+	snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_1,
+			    WM8996_JD_MODE_MASK, 1);
+
+	/* Trigger a measurement */
+	snd_soc_update_bits(codec, WM8996_HEADPHONE_DETECT_1,
+			    WM8996_HP_POLL, WM8996_HP_POLL);
+}
+
 static void wm8996_micd(struct snd_soc_codec *codec)
 {
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
@@ -2376,28 +2458,36 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 		wm8996->jack_mic = false;
 		wm8996->detecting = true;
 		snd_soc_jack_report(wm8996->jack, 0,
-				    SND_JACK_HEADSET | SND_JACK_BTN_0);
+				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
+				    SND_JACK_BTN_0);
+
 		snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
 				    WM8996_MICD_RATE_MASK,
 				    WM8996_MICD_RATE_MASK);
 		return;
 	}
 
-	/* If the measurement is very high we've got a microphone but
-	 * do a little debounce to account for mechanical issues.
+	/* If the measurement is very high we've got a microphone,
+	 * either we just detected one or if we already reported then
+	 * we've got a button release event.
 	 */
 	if (val & 0x400) {
-		dev_dbg(codec->dev, "Microphone detected\n");
-		snd_soc_jack_report(wm8996->jack, SND_JACK_HEADSET,
-				    SND_JACK_HEADSET | SND_JACK_BTN_0);
-		wm8996->jack_mic = true;
-		wm8996->detecting = false;
-
-		/* Increase poll rate to give better responsiveness
-		 * for buttons */
-		snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
-				    WM8996_MICD_RATE_MASK,
-				    5 << WM8996_MICD_RATE_SHIFT);
+		if (wm8996->detecting) {
+			dev_dbg(codec->dev, "Microphone detected\n");
+			wm8996->jack_mic = true;
+			wm8996_hpdet_start(codec);
+
+			/* Increase poll rate to give better responsiveness
+			 * for buttons */
+			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+					    WM8996_MICD_RATE_MASK,
+					    5 << WM8996_MICD_RATE_SHIFT);
+		} else {
+			dev_dbg(codec->dev, "Mic button up\n");
+			snd_soc_jack_report(wm8996->jack, 0, SND_JACK_BTN_0);
+		}
+
+		return;
 	}
 
 	/* If we detected a lower impedence during initial startup
@@ -2429,15 +2519,11 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 	if (val & 0x3fc) {
 		if (wm8996->jack_mic) {
 			dev_dbg(codec->dev, "Mic button detected\n");
-			snd_soc_jack_report(wm8996->jack,
-					    SND_JACK_HEADSET | SND_JACK_BTN_0,
-					    SND_JACK_HEADSET | SND_JACK_BTN_0);
-		} else {
-			dev_dbg(codec->dev, "Headphone detected\n");
-			snd_soc_jack_report(wm8996->jack,
-					    SND_JACK_HEADPHONE,
-					    SND_JACK_HEADSET |
+			snd_soc_jack_report(wm8996->jack, SND_JACK_BTN_0,
 					    SND_JACK_BTN_0);
+		} else if (wm8996->detecting) {
+			dev_dbg(codec->dev, "Headphone detected\n");
+			wm8996_hpdet_start(codec);
 
 			/* Increase the detection rate a bit for
 			 * responsiveness.
@@ -2445,8 +2531,6 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
 					    WM8996_MICD_RATE_MASK,
 					    7 << WM8996_MICD_RATE_SHIFT);
-
-			wm8996->detecting = false;
 		}
 	}
 }
@@ -2486,6 +2570,9 @@ static irqreturn_t wm8996_irq(int irq, void *data)
 	if (irq_val & WM8996_MICD_EINT)
 		wm8996_micd(codec);
 
+	if (irq_val & WM8996_HP_DONE_EINT)
+		wm8996_hpdet_irq(codec);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.7.6.3
