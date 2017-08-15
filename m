From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 5/5] ASoC: spear: constify snd_soc_dai_ops structures
Date: Tue, 15 Aug 2017 17:10:12 +0200
Message-ID: <1502809812-13891-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502809812-13891-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These snd_soc_dai_ops structures are only stored in the ops field of
a snd_soc_dai_driver structure, which is const.  Thus, the
snd_soc_dai_ops structures can be const too.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/soc/spear/spdif_in.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index 01b28e5..78a6a36 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -151,7 +151,7 @@ static int spdif_in_trigger(struct snd_pcm_substream *substream, int cmd,
 	return ret;
 }
 
-static struct snd_soc_dai_ops spdif_in_dai_ops = {
+static const struct snd_soc_dai_ops spdif_in_dai_ops = {
 	.shutdown	= spdif_in_shutdown,
 	.trigger	= spdif_in_trigger,
 	.hw_params	= spdif_in_hw_params,
