From: Anda-Alexandra Dorneanu <andadrn@gmail.com>
Subject: [PATCH] ASoC: kirkwood: Add a blank line after declarations
Date: Sat, 25 Feb 2017 12:56:43 +0200
Message-ID: <1488020203-14025-1-git-send-email-andadrn@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, andadrn <andadrn@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: andadrn <andadrn@gmail.com>

This was reported by checkpatch.pl

Signed-off-by: Anda-Alexandra Dorneanu <andadrn@gmail.com>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index dafd22e..0af5d46 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -24,6 +24,7 @@
 static struct kirkwood_dma_data *kirkwood_priv(struct snd_pcm_substream *subs)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = subs->private_data;
+
 	return snd_soc_dai_get_drvdata(soc_runtime->cpu_dai);
 }
 
@@ -91,6 +92,7 @@ static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
 	/* try to find matching cs for current dma address */
 	for (i = 0; i < dram->num_cs; i++) {
 		const struct mbus_dram_window *cs = dram->cs + i;
+
 		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
 			writel(cs->base & 0xffff0000,
 				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
-- 
1.9.1
