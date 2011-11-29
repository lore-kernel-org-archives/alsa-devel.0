From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Enhance default WM8958 microphone
	detection
Date: Tue, 29 Nov 2011 20:21:35 +0000
Message-ID: <1322598095-26645-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7BFA2454F
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 21:21:43 +0100 (CET)
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

Actively manage the detection rate for microphones with WM8958, providing
improved power consumption and maximising the benefit from the hardware
debounce.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |  120 ++++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/wm8994.h |    2 +
 2 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 207bccd..027bf68 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -53,6 +53,56 @@ static int wm8994_retune_mobile_base[] = {
 	WM8994_AIF2_EQ_GAINS_1,
 };
 
+static void wm8958_default_micdet(u16 status, void *data);
+
+static const struct {
+	int sysclk;
+	bool idle;
+	int start;
+	int rate;
+} wm8958_micd_rates[] = {
+	{ 32768,       true,  1, 4 },
+	{ 32768,       false, 1, 1 },
+	{ 44100 * 256, true,  7, 6 },
+	{ 44100 * 256, false, 7, 6 },
+};
+
+static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
+{
+	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	int best, i, sysclk, val;
+	bool idle;
+
+	if (wm8994->jack_cb != wm8958_default_micdet)
+		return;
+
+	idle = !wm8994->jack_mic;
+
+	sysclk = snd_soc_read(codec, WM8994_CLOCKING_1);
+	if (sysclk & WM8994_SYSCLK_SRC)
+		sysclk = wm8994->aifclk[1];
+	else
+		sysclk = wm8994->aifclk[0];
+
+	best = 0;
+	for (i = 0; i < ARRAY_SIZE(wm8958_micd_rates); i++) {
+		if (wm8958_micd_rates[i].idle != idle)
+			continue;
+		if (abs(wm8958_micd_rates[i].sysclk - sysclk) <
+		    abs(wm8958_micd_rates[best].sysclk - sysclk))
+			best = i;
+		else if (wm8958_micd_rates[best].idle != idle)
+			best = i;
+	}
+
+	val = wm8958_micd_rates[best].start << WM8958_MICD_BIAS_STARTTIME_SHIFT
+		| wm8958_micd_rates[best].rate << WM8958_MICD_RATE_SHIFT;
+
+	snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
+			    WM8958_MICD_BIAS_STARTTIME_MASK |
+			    WM8958_MICD_RATE_MASK, val);
+}
+
 static int wm8994_readable(struct snd_soc_codec *codec, unsigned int reg)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
@@ -221,8 +271,10 @@ static int configure_clock(struct snd_soc_codec *codec)
 	 */
 
 	/* If they're equal it doesn't matter which is used */
-	if (wm8994->aifclk[0] == wm8994->aifclk[1])
+	if (wm8994->aifclk[0] == wm8994->aifclk[1]) {
+		wm8958_micd_set_rate(codec);
 		return 0;
+	}
 
 	if (wm8994->aifclk[0] < wm8994->aifclk[1])
 		new = WM8994_SYSCLK_SRC;
@@ -236,6 +288,8 @@ static int configure_clock(struct snd_soc_codec *codec)
 
 	snd_soc_dapm_sync(&codec->dapm);
 
+	wm8958_micd_set_rate(codec);
+
 	return 0;
 }
 
@@ -2987,21 +3041,56 @@ static void wm8958_default_micdet(u16 status, void *data)
 {
 	struct snd_soc_codec *codec = data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	int report = 0;
 
 	/* If nothing present then clear our statuses */
-	if (!(status & WM8958_MICD_STS))
-		goto done;
+	if (!(status & WM8958_MICD_STS)) {
+		dev_dbg(codec->dev, "Detected open circuit\n");
+		wm8994->jack_mic = false;
+		wm8994->detecting = true;
+
+		wm8958_micd_set_rate(codec);
 
-	report = SND_JACK_MICROPHONE;
+		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
+				    SND_JACK_BTN_0 | SND_JACK_HEADSET);
+
+		return;
+	}
 
-	/* Everything else is buttons; just assign slots */
-	if (status & 0x1c)
-		report |= SND_JACK_BTN_0;
+	/* If the measurement is showing a high impedence we've got a
+	 * microphone.
+	 */
+	if (wm8994->detecting && (status & 0x600)) {
+		dev_dbg(codec->dev, "Detected microphone\n");
+
+		wm8994->detecting = false;
+		wm8994->jack_mic = true;
+
+		wm8958_micd_set_rate(codec);
+
+		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADSET,
+				    SND_JACK_HEADSET);
+	}
 
-done:
-	snd_soc_jack_report(wm8994->micdet[0].jack, report,
-			    SND_JACK_BTN_0 | SND_JACK_MICROPHONE);
+
+	if (wm8994->detecting && status & 0x4) {
+		dev_dbg(codec->dev, "Detected headphone\n");
+		wm8994->detecting = false;
+
+		wm8958_micd_set_rate(codec);
+
+		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADPHONE,
+				    SND_JACK_HEADSET);
+	}
+
+	/* Report short circuit as a button */
+	if (wm8994->jack_mic) {
+		if (status & 0x4)
+			snd_soc_jack_report(wm8994->micdet[0].jack,
+					    SND_JACK_BTN_0, SND_JACK_BTN_0);
+		else
+			snd_soc_jack_report(wm8994->micdet[0].jack,
+					    0, SND_JACK_BTN_0);
+	}
 }
 
 /**
@@ -3047,6 +3136,15 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		wm8994->jack_cb = cb;
 		wm8994->jack_cb_data = cb_data;
 
+		wm8994->detecting = true;
+		wm8994->jack_mic = false;
+
+		wm8958_micd_set_rate(codec);
+
+		/* Detect microphones and short circuits */
+		snd_soc_update_bits(codec, WM8958_MIC_DETECT_2,
+				    WM8958_MICD_LVL_SEL_MASK, 0x41);
+
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, WM8958_MICD_ENA);
 	} else {
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index f4f1355..1087425 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -126,6 +126,8 @@ struct wm8994_priv {
 	struct soc_enum enh_eq_enum;
 
 	struct wm8994_micdet micdet[2];
+	bool detecting;
+	bool jack_mic;
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-- 
1.7.7.3
