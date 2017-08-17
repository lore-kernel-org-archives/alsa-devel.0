From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 4/6] ASoC: kirkwood: make snd_pcm_hardware const
Date: Thu, 17 Aug 2017 15:46:10 +0530
Message-ID: <1502964972-22722-5-git-send-email-bhumirks@gmail.com>
References: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502964972-22722-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is either passed as the 2nd argument
to the function snd_soc_set_runtime_hwparams, which is const or used in
a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index dafd22e..cf23af1 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -27,7 +27,7 @@ static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 	return snd_soc_dai_get_drvdata(soc_runtime->cpu_dai);
 }
 
-static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
+static const struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.9.1
