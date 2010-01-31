From: Joe Perches <joe@perches.com>
Subject: [PATCH 10/10] sound/soc/blackfin: Fix continuation line formats
Date: Sun, 31 Jan 2010 12:02:12 -0800
Message-ID: <aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
References: <cover.1264967493.git.joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754243Ab0AaUCs@vger.kernel.org>
In-Reply-To: <cover.1264967493.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

String constants that are continued on subsequent lines with \
are not good.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |    8 ++------
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |    3 +--
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |    3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index cf0dfb7..67cbfe7 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -349,9 +349,7 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 			sport_handle->tx_dma_buf = dma_alloc_coherent(NULL, \
 				size, &sport_handle->tx_dma_phy, GFP_KERNEL);
 			if (!sport_handle->tx_dma_buf) {
-				pr_err("Failed to allocate memory for tx dma \
-					buf - Please increase uncached DMA \
-					memory region\n");
+				pr_err("Failed to allocate memory for tx dma buf - Please increase uncached DMA memory region\n");
 				return -ENOMEM;
 			} else
 				memset(sport_handle->tx_dma_buf, 0, size);
@@ -362,9 +360,7 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 			sport_handle->rx_dma_buf = dma_alloc_coherent(NULL, \
 				size, &sport_handle->rx_dma_phy, GFP_KERNEL);
 			if (!sport_handle->rx_dma_buf) {
-				pr_err("Failed to allocate memory for rx dma \
-					buf - Please increase uncached DMA \
-					memory region\n");
+				pr_err("Failed to allocate memory for rx dma buf - Please increase uncached DMA memory region\n");
 				return -ENOMEM;
 			} else
 				memset(sport_handle->rx_dma_buf, 0, size);
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 62fbb84..c6c6a4a 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -207,8 +207,7 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->area = dma_alloc_coherent(pcm->card->dev, size,
 			&buf->addr, GFP_KERNEL);
 	if (!buf->area) {
-		pr_err("Failed to allocate dma memory \
-			Please increase uncached DMA memory region\n");
+		pr_err("Failed to allocate dma memory - Please increase uncached DMA memory region\n");
 		return -ENOMEM;
 	}
 	buf->bytes = size;
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index a8c73cb..5e03bb2 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -244,8 +244,7 @@ static int bf5xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	buf->area = dma_alloc_coherent(pcm->card->dev, size * 4,
 		&buf->addr, GFP_KERNEL);
 	if (!buf->area) {
-		pr_err("Failed to allocate dma memory \
-			Please increase uncached DMA memory region\n");
+		pr_err("Failed to allocate dma memory - Please increase uncached DMA memory region\n");
 		return -ENOMEM;
 	}
 	buf->bytes = size;
-- 
1.6.6.rc0.57.gad7a
