From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6] ASoC: Rename WM8994 detecting flag to
	mic_detecting
Date: Thu,  1 Dec 2011 14:16:42 +0000
Message-ID: <1322749006-371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F1871039C0
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 15:17:09 +0100 (CET)
In-Reply-To: <1322749006-371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

More specific and avoids confusion with a following change.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   12 ++++++------
 sound/soc/codecs/wm8994.h |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 68e85c6..c138937 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2952,7 +2952,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 	if (!(status & WM8958_MICD_STS)) {
 		dev_dbg(codec->dev, "Detected open circuit\n");
 		wm8994->jack_mic = false;
-		wm8994->detecting = true;
+		wm8994->mic_detecting = true;
 
 		wm8958_micd_set_rate(codec);
 
@@ -2965,10 +2965,10 @@ static void wm8958_default_micdet(u16 status, void *data)
 	/* If the measurement is showing a high impedence we've got a
 	 * microphone.
 	 */
-	if (wm8994->detecting && (status & 0x600)) {
+	if (wm8994->mic_detecting && (status & 0x600)) {
 		dev_dbg(codec->dev, "Detected microphone\n");
 
-		wm8994->detecting = false;
+		wm8994->mic_detecting = false;
 		wm8994->jack_mic = true;
 
 		wm8958_micd_set_rate(codec);
@@ -2978,9 +2978,9 @@ static void wm8958_default_micdet(u16 status, void *data)
 	}
 
 
-	if (wm8994->detecting && status & 0x4) {
+	if (wm8994->mic_detecting && status & 0x4) {
 		dev_dbg(codec->dev, "Detected headphone\n");
-		wm8994->detecting = false;
+		wm8994->mic_detecting = false;
 
 		wm8958_micd_set_rate(codec);
 
@@ -3058,7 +3058,7 @@ int wm8958_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 		wm8994->jack_cb = cb;
 		wm8994->jack_cb_data = cb_data;
 
-		wm8994->detecting = true;
+		wm8994->mic_detecting = true;
 		wm8994->jack_mic = false;
 
 		wm8958_micd_set_rate(codec);
diff --git a/sound/soc/codecs/wm8994.h b/sound/soc/codecs/wm8994.h
index 8dc2c00..0678f4d 100644
--- a/sound/soc/codecs/wm8994.h
+++ b/sound/soc/codecs/wm8994.h
@@ -117,7 +117,7 @@ struct wm8994_priv {
 	struct soc_enum enh_eq_enum;
 
 	struct wm8994_micdet micdet[2];
-	bool detecting;
+	bool mic_detecting;
 	bool jack_mic;
 	int btn_mask;
 
-- 
1.7.7.3
