From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] ASoC: wm8955: Use devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 22:27:06 -0300
Message-ID: <1398389226-18569-4-git-send-email-festevam@gmail.com>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com
 [209.85.160.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 14ED026532E
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 03:27:31 +0200 (CEST)
Received: by mail-yk0-f169.google.com with SMTP id 142so2792804ykq.14
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 18:27:31 -0700 (PDT)
In-Reply-To: <1398389226-18569-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
do not need to call regulator_bulk_free() in the error and remove paths.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/wm8955.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index 7e443c4..2a35108 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -898,7 +898,7 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < ARRAY_SIZE(wm8955->supplies); i++)
 		wm8955->supplies[i].supply = wm8955_supply_names[i];
 
-	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8955->supplies),
+	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8955->supplies),
 				 wm8955->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
@@ -909,7 +909,7 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 				    wm8955->supplies);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
-		goto err_get;
+		return ret;
 	}
 
 	ret = wm8955_reset(codec);
@@ -961,17 +961,12 @@ static int wm8955_probe(struct snd_soc_codec *codec)
 
 err_enable:
 	regulator_bulk_disable(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
-err_get:
-	regulator_bulk_free(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
 	return ret;
 }
 
 static int wm8955_remove(struct snd_soc_codec *codec)
 {
-	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
-
 	wm8955_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	regulator_bulk_free(ARRAY_SIZE(wm8955->supplies), wm8955->supplies);
 	return 0;
 }
 
-- 
1.8.3.2
