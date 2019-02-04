From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ASoC: amd: Avoid passing NULL to memory
	allocators
Date: Mon,  4 Feb 2019 14:42:20 +0100
Message-ID: <20190204134222.9560-4-tiwai@suse.de>
References: <20190204134222.9560-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC63267516
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 14:42:27 +0100 (CET)
In-Reply-To: <20190204134222.9560-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

We should pass a proper non-NULL device object to memory allocators
although it was accepted in the past.  The card->dev points to the
most appropriate device object in such a case, so let's put it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 3d58338fa3cf..3e7d4099364c 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -369,7 +369,8 @@ static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
 	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 						     SNDRV_DMA_TYPE_DEV,
-						     NULL, MIN_BUFFER,
+						     rtd->pcm->card->dev,
+						     MIN_BUFFER,
 						     MAX_BUFFER);
 }
 
-- 
2.16.4
