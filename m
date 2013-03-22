From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/14] ASoC: omap-pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Fri, 22 Mar 2013 14:12:03 +0100
Message-ID: <1363957934-20059-4-git-send-email-lars@metafoo.de>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
 [212.40.185.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C05C26652A
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 14:10:31 +0100 (CET)
In-Reply-To: <1363957934-20059-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastien Guiriec <s-guiriec@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

If a PCM driver using the dmaengine PCM helper functions doesn't need to do
anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
directly for as the pcm_close callback and there is no need to wrap it in a
custom function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Sebastien Guiriec <s-guiriec@ti.com>
---
 sound/soc/omap/omap-pcm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c722c2e..c6f477c 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -185,12 +185,6 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 				      &dma_data->dma_req);
 }
 
-static int omap_pcm_close(struct snd_pcm_substream *substream)
-{
-	snd_dmaengine_pcm_close(substream);
-	return 0;
-}
-
 static int omap_pcm_mmap(struct snd_pcm_substream *substream,
 	struct vm_area_struct *vma)
 {
@@ -204,7 +198,7 @@ static int omap_pcm_mmap(struct snd_pcm_substream *substream,
 
 static struct snd_pcm_ops omap_pcm_ops = {
 	.open		= omap_pcm_open,
-	.close		= omap_pcm_close,
+	.close		= snd_dmaengine_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= omap_pcm_hw_params,
 	.hw_free	= omap_pcm_hw_free,
-- 
1.8.0
