From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/5] ASoC: codecs: zx_aud96p22: constify snd_soc_dai_ops structures
Date: Tue, 15 Aug 2017 17:10:11 +0200
Message-ID: <1502809812-13891-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: kernel-janitors-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/codecs/zx_aud96p22.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 36d0a70..51fad48 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -312,7 +312,7 @@ static int aud96p22_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static struct snd_soc_dai_ops aud96p22_dai_ops = {
+static const struct snd_soc_dai_ops aud96p22_dai_ops = {
 	.set_fmt = aud96p22_set_fmt,
 };
 

