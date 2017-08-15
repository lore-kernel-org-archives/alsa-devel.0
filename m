From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/5] ASoC: blackfin: constify snd_soc_dai_ops structures
Date: Tue, 15 Aug 2017 17:10:08 +0200
Message-ID: <1502809812-13891-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/blackfin/bf6xx-i2s.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/blackfin/bf6xx-i2s.c b/sound/soc/blackfin/bf6xx-i2s.c
index bd3b4d4..819cff1 100644
--- a/sound/soc/blackfin/bf6xx-i2s.c
+++ b/sound/soc/blackfin/bf6xx-i2s.c
@@ -164,7 +164,7 @@ static int bfin_i2s_resume(struct snd_soc_dai *dai)
 #define BFIN_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops bfin_i2s_dai_ops = {
+static const struct snd_soc_dai_ops bfin_i2s_dai_ops = {
 	.hw_params	= bfin_i2s_hw_params,
 	.set_fmt	= bfin_i2s_set_dai_fmt,
 };
