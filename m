From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 09/12] ASoC: rk3036: constify snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 15:38:32 -0500
Message-ID: <4868cb10531b54c7eee312bf235125d0eb4dbf95.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1499974826.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/inno_rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
index b918ba5..edf42d2 100644
--- a/sound/soc/codecs/inno_rk3036.c
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -310,7 +310,7 @@ static int rk3036_codec_dai_hw_params(struct snd_pcm_substream *substream,
 			   SNDRV_PCM_FMTBIT_S24_LE  | \
 			   SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops rk3036_codec_dai_ops = {
+static const struct snd_soc_dai_ops rk3036_codec_dai_ops = {
 	.set_fmt	= rk3036_codec_dai_set_fmt,
 	.hw_params	= rk3036_codec_dai_hw_params,
 };
-- 
2.5.0
