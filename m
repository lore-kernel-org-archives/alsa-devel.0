From: Christian Engelmayer <cengelma@gmx.at>
Subject: [PATCH] ASoC: wm8985: Remove unused pointer in wm8985_remove()
Date: Fri, 13 Jun 2014 19:19:28 +0200
Message-ID: <1402679968-5925-1-git-send-email-cengelma@gmx.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Xiubo Li <Li.Xiubo@freescale.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Christian Engelmayer <cengelma@gmx.at>
List-Id: alsa-devel@alsa-project.org

Commit a0b148b4 (ASoC: wm8985: Use devm_regulator_bulk_get()) removed the last
user of pointer wm8985 to struct wm8985_priv. Thus remove it. Detected by
Coverity CID 1222150.

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
Compile tested. Applies against branch for-next in tree
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
---
 sound/soc/codecs/wm8985.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 0f5780c..cbbdfbb 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -980,9 +980,6 @@ static int wm8985_resume(struct snd_soc_codec *codec)
 
 static int wm8985_remove(struct snd_soc_codec *codec)
 {
-	struct wm8985_priv *wm8985;
-
-	wm8985 = snd_soc_codec_get_drvdata(codec);
 	wm8985_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
-- 
1.9.1
