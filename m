From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/1] ALSA: SOC: DMA: increment buffer pointer atomically
Date: Wed, 30 Nov 2016 17:22:21 +0900
Message-ID: <20161130082221.15399-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, apape@de.adit-jv.com, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Andreas Pape <apape@de.adit-jv.com>

Setting pointer and afterwards check for wrap around leads
to the possibility of returning the inconsistent pointer position.
This patch increments buffer pointer atomically to avoid this issue.

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/core/pcm_dmaengine.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 8eb58c7..6f6da11 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -139,12 +139,14 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
 static void dmaengine_pcm_dma_complete(void *arg)
 {
+	unsigned int new_pos;
 	struct snd_pcm_substream *substream = arg;
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
 
-	prtd->pos += snd_pcm_lib_period_bytes(substream);
-	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
-		prtd->pos = 0;
+	new_pos = prtd->pos + snd_pcm_lib_period_bytes(substream);
+	if (new_pos >= snd_pcm_lib_buffer_bytes(substream))
+		new_pos = 0;
+	prtd->pos = new_pos;
 
 	snd_pcm_period_elapsed(substream);
 }
-- 
2.9.3
