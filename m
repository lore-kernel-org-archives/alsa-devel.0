From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/21] ASoC: Convert WM8400 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:14 +0000
Message-ID: <1322948009-27658-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BAD44243DE
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:39 +0100 (CET)
In-Reply-To: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8400.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index a1173eb..1add977 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1383,7 +1383,8 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	int ret;
 	u16 reg;
 
-	priv = kzalloc(sizeof(struct wm8400_priv), GFP_KERNEL);
+	priv = devm_kzalloc(codec->dev, sizeof(struct wm8400_priv),
+			    GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
@@ -1395,7 +1396,7 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to get regulators: %d\n", ret);
-	        goto err;
+		return ret;
 	}
 
 	INIT_WORK(&priv->work, wm8400_probe_deferred);
@@ -1426,14 +1427,11 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 
 err_regulator:
 	regulator_bulk_free(ARRAY_SIZE(power), power);
-err:
-	kfree(priv);
 	return ret;
 }
 
 static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 {
-	struct wm8400_priv *priv = snd_soc_codec_get_drvdata(codec);
 	u16 reg;
 
 	reg = wm8400_read(codec, WM8400_POWER_MANAGEMENT_1);
@@ -1441,7 +1439,6 @@ static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 		     reg & (~WM8400_CODEC_ENA));
 
 	regulator_bulk_free(ARRAY_SIZE(power), power);
-	kfree(priv);
 
 	return 0;
 }
-- 
1.7.7.3
