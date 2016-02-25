From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ASoC: max9867: signedness bug in max9867_dai_hw_params()
Date: Thu, 25 Feb 2016 10:48:10 +0300
Message-ID: <20160225074810.GB7333@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"value" needs to be signed for the error handling to work.

Fixes: 805d132dcbbd ('ASoC: Add max9867 codec driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
