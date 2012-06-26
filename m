From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Don't suspend accessory detection
Date: Tue, 26 Jun 2012 11:07:40 +0100
Message-ID: <1340705260-24245-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B59DD245EE
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 12:07:44 +0200 (CEST)
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

Leave it up to the machine driver to disable accessory detection if
desired, the common pattern is to have accessory detection be a wake
source.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6474bae..a4aafdb 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2967,23 +2967,8 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 static int wm8994_codec_suspend(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = wm8994->wm8994;
 	int i, ret;
 
-	switch (control->type) {
-	case WM8994:
-		snd_soc_update_bits(codec, WM8994_MICBIAS, WM8994_MICD_ENA, 0);
-		break;
-	case WM1811:
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-				    WM1811_JACKDET_MODE_MASK, 0);
-		/* Fall through */
-	case WM8958:
-		snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
-				    WM8958_MICD_ENA, 0);
-		break;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		memcpy(&wm8994->fll_suspend[i], &wm8994->fll[i],
 		       sizeof(struct wm8994_fll_config));
@@ -3033,28 +3018,6 @@ static int wm8994_codec_resume(struct snd_soc_codec *codec)
 				 i + 1, ret);
 	}
 
-	switch (control->type) {
-	case WM8994:
-		if (wm8994->micdet[0].jack || wm8994->micdet[1].jack)
-			snd_soc_update_bits(codec, WM8994_MICBIAS,
-					    WM8994_MICD_ENA, WM8994_MICD_ENA);
-		break;
-	case WM1811:
-		if (wm8994->jackdet && wm8994->jack_cb) {
-			/* Restart from idle */
-			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
-					    WM1811_JACKDET_MODE_MASK,
-					    WM1811_JACKDET_MODE_JACK);
-			break;
-		}
-		break;
-	case WM8958:
-		if (wm8994->jack_cb)
-			snd_soc_update_bits(codec, WM8958_MIC_DETECT_1,
-					    WM8958_MICD_ENA, WM8958_MICD_ENA);
-		break;
-	}
-
 	return 0;
 }
 #else
-- 
1.7.10
