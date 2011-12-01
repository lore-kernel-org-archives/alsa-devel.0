From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: Allow more WM8958/WM1811 button
	levels with default handler
Date: Thu,  1 Dec 2011 14:16:41 +0000
Message-ID: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76846103BFE
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:09 +0100 (CET)
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

The WM8958 and WM1811 support detecting a range of buttons. Allow the
user to provide platform data enabling more of these levels without
having to write a custom detection handler.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/wm8994/pdata.h |    3 ++
 sound/soc/codecs/wm8994.c        |   42 ++++++++++++++++++++++++++++++-------
 sound/soc/codecs/wm8994.h        |    1 +
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/wm8994/pdata.h b/include/linux/mfd/wm8994/pdata.h
index b00897a..d46c55a 100644
--- a/include/linux/mfd/wm8994/pdata.h
+++ b/include/linux/mfd/wm8994/pdata.h
@@ -168,6 +168,9 @@ struct wm8994_pdata {
 	/* WM8958 microphone bias configuration */
 	int micbias[2];
 
+	/* WM8958 microphone detection ranges */
+	u16 micd_lvl_sel;
+
 	/* Disable the internal pull downs on the LDOs if they are
 	 * always driven (eg, connected to an always on supply or
 	 * GPIO that always drives an output.  If they float power
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c00c478..68e85c6 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2944,6 +2944,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 {
 	struct snd_soc_codec *codec = data;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
+	int report;
 
 	dev_dbg(codec->dev, "MICDET %x\n", status);
 
@@ -2956,7 +2957,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 		wm8958_micd_set_rate(codec);
 
 		snd_soc_jack_report(wm8994->micdet[0].jack, 0,
-				    SND_JACK_BTN_0 | SND_JACK_HEADSET);
+				    wm8994->btn_mask | SND_JACK_HEADSET);
 
 		return;
 	}
@@ -2989,12 +2990,27 @@ static void wm8958_default_micdet(u16 status, void *data)
 
 	/* Report short circuit as a button */
 	if (wm8994->jack_mic) {
+		report = 0;
 		if (status & 0x4)
-			snd_soc_jack_report(wm8994->micdet[0].jack,
-					    SND_JACK_BTN_0, SND_JACK_BTN_0);
-		else
-			snd_soc_jack_report(wm8994->micdet[0].jack,
-					    0, SND_JACK_BTN_0);
+			report |= SND_JACK_BTN_0;
+
+		if (status & 0x8)
+			report |= SND_JACK_BTN_1;
+
+		if (status & 0x10)
+			report |= SND_JACK_BTN_2;
+
+		if (status & 0x20)
+			report |= SND_JACK_BTN_3;
+
+		if (status & 0x40)
+			report |= SND_JACK_BTN_4;
+
+		if (status & 0x80)
+			report |= SND_JACK_BTN_5;
+
+		snd_soc_jack_report(wm8994->micdet[0].jack, report,
+				    wm8994->btn_mask);
 	}
 }
 
@@ -3019,6 +3035,7 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
+	u16 micd_lvl_sel;
 
 	switch (control->type) {
 	case WM1811:
@@ -3046,9 +3063,18 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 
 		wm8958_micd_set_rate(codec);
 
-		/* Detect microphones and short circuits */
+		/* Detect microphones and short circuits by default */
+		if (wm8994->pdata->micd_lvl_sel)
+			micd_lvl_sel = wm8994->pdata->micd_lvl_sel;
+		else
+			micd_lvl_sel = 0x41;
+
+		wm8994->btn_mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+			SND_JACK_BTN_2 | SND_JACK_BTN_3 |
+			SND_JACK_BTN_4 | SND_JACK_BTN_5;
+
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_2,
-				    WM8958_MICD_LVL_SEL_MASK, 0x41);
+				    WM8958_MICD_LVL_SEL_MASK, micd_lvl_sel);
 
 		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
 				    WM8958_MICD_ENA, WM8958_MICD_ENA);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index e5e8329..8dc2c00 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -119,6 +119,7 @@ struct wm8994_priv {
 	struct wm8994_micdet micdet[2];
 	bool detecting;
 	bool jack_mic;
+	int btn_mask;
 
 	wm8958_micdet_cb jack_cb;
 	void *jack_cb_data;
-- 
1.7.7.3
