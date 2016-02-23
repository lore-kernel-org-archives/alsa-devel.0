From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 2/2] ASoC: max9867: fix type of variable containing error codes
Date: Tue, 23 Feb 2016 07:45:14 +0100
Message-ID: <1456209914-13375-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, anish kumar <yesanishhere@gmail.com>, Axel Lin <axel.lin@ingics.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
	AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

value variable can contain error values and is compared with zero.
Its type must be signed.

The problem has been detected using coccinelle script
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 sound/soc/codecs/max9867.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index ab7a94d..4fb6fc7 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -180,7 +180,8 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
-	unsigned int ni_h, ni_l, value;
+	unsigned int ni_h, ni_l;
+	int value;
 
 	value = get_ni_value(max9867->sysclk, params_rate(params));
 	if (value < 0)
-- 
1.9.1
