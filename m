From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] ASoC: au1x: use correct format specifier
Date: Wed, 13 Apr 2016 01:54:01 +0200
Message-ID: <1460505241-12900-1-git-send-email-xypron.glpk@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
List-Id: alsa-devel@alsa-project.org

Documentation/printk-formats.txt has
unsigned long: use %lu or %lx
size_t:        use %zu or %zx

runtime->dma_bytes is of type size_t.
runtime->min_align is of type unsigned long.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 sound/soc/au1x/dbdma2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 5741c0a..b5d1caa 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -206,8 +206,8 @@ static int au1xpsc_pcm_hw_params(struct snd_pcm_substream *substream,
 	stype = substream->stream;
 	pcd = to_dmadata(substream);
 
-	DBG("runtime->dma_area = 0x%08lx dma_addr_t = 0x%08lx dma_size = %d "
-	    "runtime->min_align %d\n",
+	DBG("runtime->dma_area = 0x%08lx dma_addr_t = 0x%08lx dma_size = %zu "
+	    "runtime->min_align %lu\n",
 		(unsigned long)runtime->dma_area,
 		(unsigned long)runtime->dma_addr, runtime->dma_bytes,
 		runtime->min_align);
-- 
2.1.4
