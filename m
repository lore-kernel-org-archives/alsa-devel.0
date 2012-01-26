From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm5100: Handle failures to determine
	accessory polarity
Date: Thu, 26 Jan 2012 19:16:01 +0000
Message-ID: <1327605362-27065-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1327605362-27065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85B4710391F
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 20:16:05 +0100 (CET)
In-Reply-To: <1327605362-27065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm5100.c |   38 +++++++++++++++++++++++++-------------
 1 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 1ed4421..0521b40 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -71,6 +71,7 @@ struct wm5100_priv {
 	bool jack_detecting;
 	bool jack_mic;
 	int jack_mode;
+	int jack_flips;
 
 	struct wm5100_fll fll[2];
 
@@ -2039,6 +2040,19 @@ static void wm5100_set_detect_mode(struct wm5100_priv *wm5100, int the_mode)
 		wm5100->jack_mode);
 }
 
+static void wm5100_report_headphone(struct wm5100_priv *wm5100)
+{
+	dev_dbg(wm5100->dev, "Headphone detected\n");
+	wm5100->jack_detecting = false;
+	snd_soc_jack_report(wm5100->jack, SND_JACK_HEADPHONE,
+			    SND_JACK_HEADPHONE);
+
+	/* Increase the detection rate a bit for responsiveness. */
+	regmap_update_bits(wm5100->regmap, WM5100_MIC_DETECT_1,
+			   WM5100_ACCDET_RATE_MASK,
+			   7 << WM5100_ACCDET_RATE_SHIFT);
+}
+
 static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 {
 	unsigned int val;
@@ -2063,6 +2077,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 		dev_dbg(wm5100->dev, "Jack removal detected\n");
 		wm5100->jack_mic = false;
 		wm5100->jack_detecting = true;
+		wm5100->jack_flips = 0;
 		snd_soc_jack_report(wm5100->jack, 0,
 				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
 				    SND_JACK_BTN_0);
@@ -2102,10 +2117,16 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 	/* If we detected a lower impedence during initial startup
 	 * then we probably have the wrong polarity, flip it.  Don't
 	 * do this for the lowest impedences to speed up detection of
-	 * plain headphones.
+	 * plain headphones and give up if neither polarity looks
+	 * sensible.
 	 */
 	if (wm5100->jack_detecting && (val & 0x3f8)) {
-		wm5100_set_detect_mode(wm5100, !wm5100->jack_mode);
+		wm5100->jack_flips++;
+
+		if (wm5100->jack_flips > 1)
+			wm5100_report_headphone(wm5100);
+		else
+			wm5100_set_detect_mode(wm5100, !wm5100->jack_mode);
 
 		return;
 	}
@@ -2119,17 +2140,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 			snd_soc_jack_report(wm5100->jack, SND_JACK_BTN_0,
 					    SND_JACK_BTN_0);
 		} else if (wm5100->jack_detecting) {
-			dev_dbg(wm5100->dev, "Headphone detected\n");
-			wm5100->jack_detecting = false;
-			snd_soc_jack_report(wm5100->jack, SND_JACK_HEADPHONE,
-					    SND_JACK_HEADPHONE);
-
-			/* Increase the detection rate a bit for
-			 * responsiveness.
-			 */
-			regmap_update_bits(wm5100->regmap, WM5100_MIC_DETECT_1,
-					   WM5100_ACCDET_RATE_MASK,
-					   7 << WM5100_ACCDET_RATE_SHIFT);
+			wm5100_report_headphone(wm5100);
 		}
 	}
 }
@@ -2141,6 +2152,7 @@ int wm5100_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	if (jack) {
 		wm5100->jack = jack;
 		wm5100->jack_detecting = true;
+		wm5100->jack_flips = 0;
 
 		wm5100_set_detect_mode(wm5100, 0);
 
-- 
1.7.9.rc1
