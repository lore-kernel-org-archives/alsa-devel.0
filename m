From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm8996: Handle failures to determine
	accessory polarity
Date: Thu, 26 Jan 2012 19:16:00 +0000
Message-ID: <1327605362-27065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83FCB10390F
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 20:16:05 +0100 (CET)
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

If we get an indeterminate impedance with both headset polarities then
give up and report the accessory as a headphone rather than continually
retrying.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |   38 ++++++++++++++++++++++++++------------
 1 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index fc4f8fc..ab1fb0c 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -89,6 +89,7 @@ struct wm8996_priv {
 	struct snd_soc_jack *jack;
 	bool detecting;
 	bool jack_mic;
+	int jack_flips;
 	wm8996_polarity_fn polarity_cb;
 
 #ifdef CONFIG_GPIOLIB
@@ -2427,6 +2428,7 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	wm8996->jack = jack;
 	wm8996->detecting = true;
 	wm8996->polarity_cb = polarity_cb;
+	wm8996->jack_flips = 0;
 
 	if (wm8996->polarity_cb)
 		wm8996->polarity_cb(codec, 0);
@@ -2542,6 +2544,19 @@ static void wm8996_hpdet_start(struct snd_soc_codec *codec)
 			    WM8996_HP_POLL, WM8996_HP_POLL);
 }
 
+static void wm8996_report_headphone(struct snd_soc_codec *codec)
+{
+	dev_dbg(codec->dev, "Headphone detected\n");
+	wm8996_hpdet_start(codec);
+
+	/* Increase the detection rate a bit for responsiveness. */
+	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+			    WM8996_MICD_RATE_MASK |
+			    WM8996_MICD_BIAS_STARTTIME_MASK,
+			    7 << WM8996_MICD_RATE_SHIFT |
+			    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
+}
+
 static void wm8996_micd(struct snd_soc_codec *codec)
 {
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
@@ -2561,6 +2576,7 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 		dev_dbg(codec->dev, "Jack removal detected\n");
 		wm8996->jack_mic = false;
 		wm8996->detecting = true;
+		wm8996->jack_flips = 0;
 		snd_soc_jack_report(wm8996->jack, 0,
 				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
 				    SND_JACK_BTN_0);
@@ -2601,9 +2617,17 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 	/* If we detected a lower impedence during initial startup
 	 * then we probably have the wrong polarity, flip it.  Don't
 	 * do this for the lowest impedences to speed up detection of
-	 * plain headphones.
+	 * plain headphones.  If both polarities report a low
+	 * impedence then give up and report headphones.
 	 */
 	if (wm8996->detecting && (val & 0x3f0)) {
+		wm8996->jack_flips++;
+
+		if (wm8996->jack_flips > 1) {
+			wm8996_report_headphone(codec);
+			return;
+		}
+
 		reg = snd_soc_read(codec, WM8996_ACCESSORY_DETECT_MODE_2);
 		reg ^= WM8996_HPOUT1FB_SRC | WM8996_MICD_SRC |
 			WM8996_MICD_BIAS_SRC;
@@ -2630,17 +2654,7 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 			snd_soc_jack_report(wm8996->jack, SND_JACK_BTN_0,
 					    SND_JACK_BTN_0);
 		} else if (wm8996->detecting) {
-			dev_dbg(codec->dev, "Headphone detected\n");
-			wm8996_hpdet_start(codec);
-
-			/* Increase the detection rate a bit for
-			 * responsiveness.
-			 */
-			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
-					    WM8996_MICD_RATE_MASK |
-					    WM8996_MICD_BIAS_STARTTIME_MASK,
-					    7 << WM8996_MICD_RATE_SHIFT |
-					    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
+			wm8996_report_headphone(codec);
 		}
 	}
 }
-- 
1.7.9.rc1
