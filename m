From: Tushar Behera <tushar.b@samsung.com>
Subject: [PATCH 2/2] ASoC: max98090: Remove redundant max98090_handle_pdata()
Date: Fri,  4 Jul 2014 14:42:17 +0530
Message-ID: <1404465137-14295-2-git-send-email-tushar.b@samsung.com>
References: <1404465137-14295-1-git-send-email-tushar.b@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404465137-14295-1-git-send-email-tushar.b@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com, trblinux@gmail.com
List-Id: alsa-devel@alsa-project.org

max98090_handle_pdata() is not doing anything other than printing
a message if pdata is not valid. This can be removed.

Signed-off-by: Tushar Behera <tushar.b@samsung.com>
---
 sound/soc/codecs/max98090.c |   13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1ed06d9..b2b3286 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2200,17 +2200,6 @@ static struct snd_soc_dai_driver max98090_dai[] = {
 }
 };
 
-static void max98090_handle_pdata(struct snd_soc_codec *codec)
-{
-	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
-	struct max98090_pdata *pdata = max98090->pdata;
-
-	if (!pdata) {
-		dev_err(codec->dev, "No platform data\n");
-		return;
-	}
-}
-
 static int max98090_probe(struct snd_soc_codec *codec)
 {
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
@@ -2310,8 +2299,6 @@ static int max98090_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, M98090_REG_MIC_BIAS_VOLTAGE,
 		M98090_MBVSEL_MASK, M98090_MBVSEL_2V8);
 
-	max98090_handle_pdata(codec);
-
 	max98090_add_widgets(codec);
 
 err_access:
-- 
1.7.9.5
