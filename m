From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] ASoC: fsl: imx-pcm-fiq: use correct format specifier
Date: Tue, 12 Apr 2016 22:51:03 +0200
Message-ID: <1460494263-14805-1-git-send-email-xypron.glpk@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-Id: alsa-devel@alsa-project.org

Documentation/printk-formats.txt has
size_t: use %zu or %zx

runtime->dma_bytes is of type size_t.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index e63cd5e..dac6688 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -220,7 +220,7 @@ static int snd_imx_pcm_mmap(struct snd_pcm_substream *substream,
 	ret = dma_mmap_wc(substream->pcm->card->dev, vma, runtime->dma_area,
 			  runtime->dma_addr, runtime->dma_bytes);
 
-	pr_debug("%s: ret: %d %p %pad 0x%08x\n", __func__, ret,
+	pr_debug("%s: ret: %d %p %pad 0x%08zx\n", __func__, ret,
 			runtime->dma_area,
 			&runtime->dma_addr,
 			runtime->dma_bytes);
-- 
2.1.4
