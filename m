From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Ensure lambda is zeroed for
	WM8994
Date: Mon, 27 May 2013 14:24:49 +0100
Message-ID: <1369661089-13891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 022B0260369
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 15:24:51 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 5f51127..f5eb644 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  * wm8994.c  --  WM8994 ALSA SoC Audio driver
  *
@@ -2078,6 +2079,7 @@ static int wm8994_get_fll_config(struct wm8994 *control, struct fll_div *fll,
 
 		/* Move down to proper range now rounding is done */
 		fll->k = K / 10;
+		fll->lambda = 0;
 
 		pr_debug("N=%x K=%x\n", fll->n, fll->k);
 		break;
@@ -3129,9 +3131,7 @@ static int wm8994_codec_suspend(struct snd_soc_codec *codec)
 static int wm8994_codec_resume(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	struct wm8994 *control = wm8994->wm8994;
 	int i, ret;
-	unsigned int val, mask;
 
 	for (i = 0; i < ARRAY_SIZE(wm8994->fll); i++) {
 		if (!wm8994->fll_suspend[i].out)
@@ -3986,7 +3986,7 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		case 0:
 		case 1:
 			wm8994->hubs.no_series_update = 1;
-			wm8994->hubs.no_runtime_dcs = true;
+			//wm8994->hubs.no_runtime_dcs = true;
 			break;
 		default:
 			break;
-- 
1.7.10.4
