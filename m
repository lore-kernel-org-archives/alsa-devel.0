From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/20] ASoC: uniphier: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:18 +0100
Message-ID: <20190205194221.25924-18-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB5F267932
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:29 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/uniphier/aio-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index 4ec6b65bfb44..fa001d3c1a88 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -235,10 +235,11 @@ static int uniphier_aiodma_new(struct snd_soc_pcm_runtime *rtd)
 	if (ret)
 		return ret;
 
-	return snd_pcm_lib_preallocate_pages_for_all(pcm,
+	snd_pcm_lib_preallocate_pages_for_all(pcm,
 		SNDRV_DMA_TYPE_DEV, dev,
 		uniphier_aiodma_hw.buffer_bytes_max,
 		uniphier_aiodma_hw.buffer_bytes_max);
+	return 0;
 }
 
 static void uniphier_aiodma_free(struct snd_pcm *pcm)
-- 
2.16.4
