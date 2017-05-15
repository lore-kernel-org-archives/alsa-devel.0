From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ASoC: simple-card: fix mic jack initialization
Date: Mon, 15 May 2017 14:00:31 -0700
Message-ID: <20170515210031.9983-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: kuninori.morimoto.gx@renesas.com, nikita.yoush@cogentembedded.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

Initialize asoc_simple_card_init_mic with the correct struct
asoc_simple_jack.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Fixes: 9eac361877b3 ("ASoC: simple-card: add new asoc_simple_jack and use it")
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2c9dedab5184..bc136d2bd7cd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -202,7 +202,7 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->hp_jack, PREFIX);
+	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
 	if (ret < 0)
 		return ret;
 
-- 
2.13.0
