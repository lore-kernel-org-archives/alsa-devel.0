From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-pcm: Lower the dma coherent mask to
	32bits
Date: Thu, 5 Dec 2013 10:06:42 +0200
Message-ID: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B508261673
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 09:06:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux@arm.linux.org.uk, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The underlying API dma_coerce_mask_and_coherent() checks the requested bits
mask against the size of dma_addr_t which is 32bits on OMAP.
Because of the previously used 64bits mask audio was not probing after
commit c9bd5e6 (and 4dcfa6007).
32bits for the DMA_BIT_MASK looks to be the correct one to use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark,

This is the fix for OMAP audio for 3.13-rc2+. The dma coherent changes went in
between -rc1 and -rc2 which broke things because omap-pcm was using 64bits for
dma coherent mask.

Regards,
Peter

 sound/soc/omap/omap-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index b8fa986..01d59d0 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -202,7 +202,7 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct snd_pcm *pcm = rtd->pcm;
 	int ret;
 
-	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(64));
+	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
 
-- 
1.8.4.5
