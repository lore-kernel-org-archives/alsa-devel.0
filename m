From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/21] ASoC: Convert WM8350 to devm_kzalloc()
Date: Sat,  3 Dec 2011 21:33:13 +0000
Message-ID: <1322948009-27658-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64B73243D4
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:38 +0100 (CET)
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
 sound/soc/codecs/wm8350.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 3f1ed5f..6f73ad4 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1553,7 +1553,8 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 		return -EINVAL;
 	}
 
-	priv = kzalloc(sizeof(struct wm8350_data), GFP_KERNEL);
+	priv = devm_kzalloc(codec->dev, sizeof(struct wm8350_data),
+			    GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, priv);
@@ -1564,7 +1565,7 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	ret = regulator_bulk_get(wm8350->dev, ARRAY_SIZE(priv->supplies),
 				 priv->supplies);
 	if (ret != 0)
-		goto err_priv;
+		return ret;
 
 	wm8350->codec.codec = codec;
 	codec->control_data = wm8350;
@@ -1640,10 +1641,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
-
-err_priv:
-	kfree(priv);
-	return ret;
 }
 
 static int  wm8350_codec_remove(struct snd_soc_codec *codec)
@@ -1676,7 +1673,7 @@ static int  wm8350_codec_remove(struct snd_soc_codec *codec)
 	wm8350_clear_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
 	regulator_bulk_free(ARRAY_SIZE(priv->supplies), priv->supplies);
-	kfree(priv);
+
 	return 0;
 }
 
-- 
1.7.7.3
