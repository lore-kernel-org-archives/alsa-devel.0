From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] ASoC: wm97xx: fix compilation corner case
Date: Sat, 14 Oct 2017 22:14:02 +0200
Message-ID: <20171014201409.9008-1-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Marek Vasut <marex@denx.de>, Chen-Yu Tsai <wens@csie.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When the old AC97 is not used, CONFIG_SND_SOC_AC97_BUS is not
defined. As a consequence, in the error path, snd_soc_free_ac97_codec()
is not defined and triggers a compilation error.

Fix it for wm9705 and wm9712, as wm9713 is correctly written.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/wm9705.c | 8 ++------
 sound/soc/codecs/wm9712.c | 7 ++-----
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 68c204e3599f..2c09f71fe433 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -321,7 +321,6 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9705_priv *wm9705 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
-	int ret;
 
 	if (wm9705->mfd_pdata) {
 		wm9705->ac97 = wm9705->mfd_pdata->ac97;
@@ -337,8 +336,8 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 
 		regmap = regmap_init_ac97(wm9705->ac97, &wm9705_regmap_config);
 		if (IS_ERR(regmap)) {
-			ret = PTR_ERR(regmap);
-			goto err_free_ac97_codec;
+			snd_soc_free_ac97_codec(wm9705->ac97);
+			return PTR_ERR(regmap);
 		}
 #endif
 	}
@@ -347,9 +346,6 @@ static int wm9705_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_init_regmap(codec, regmap);
 
 	return 0;
-err_free_ac97_codec:
-	snd_soc_free_ac97_codec(wm9705->ac97);
-	return ret;
 }
 
 static int wm9705_soc_remove(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 9db5c7783de5..4f6d1a442bc4 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -656,8 +656,8 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 
 		regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
 		if (IS_ERR(regmap)) {
-			ret = PTR_ERR(regmap);
-			goto err_free_ac97_codec;
+			snd_soc_free_ac97_codec(wm9712->ac97);
+			return PTR_ERR(regmap);
 		}
 #endif
 	}
@@ -668,9 +668,6 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, AC97_VIDEO, 0x3000, 0x3000);
 
 	return 0;
-err_free_ac97_codec:
-	snd_soc_free_ac97_codec(wm9712->ac97);
-	return ret;
 }
 
 static int wm9712_soc_remove(struct snd_soc_codec *codec)
-- 
2.11.0
