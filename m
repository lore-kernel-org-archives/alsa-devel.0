From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/11] soc - pxa2xx-pcm - Fix checkpatch
	warnings
Date: Wed, 23 Apr 2008 13:08:02 +0100
Message-ID: <1208952485-20385-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60ECB244DA
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:08 +0200 (CEST)
In-Reply-To: <1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-pcm.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index daeaa4c..01ad7bf 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -64,8 +64,8 @@ static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id)
 	if (dcsr & DCSR_ENDINTR) {
 		snd_pcm_period_elapsed(substream);
 	} else {
-		printk( KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
-			prtd->params->name, dma_ch, dcsr );
+		printk(KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
+			prtd->params->name, dma_ch, dcsr);
 	}
 }
 
@@ -84,8 +84,8 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
-	 if (!dma)
-	 	return 0;
+	if (!dma)
+		return 0;
 
 	/* this may get called several times by oss emulation
 	 * with different params */
@@ -363,7 +363,6 @@ struct snd_soc_platform pxa2xx_soc_platform = {
 	.pcm_new	= pxa2xx_pcm_new,
 	.pcm_free	= pxa2xx_pcm_free_dma_buffers,
 };
-
 EXPORT_SYMBOL_GPL(pxa2xx_soc_platform);
 
 MODULE_AUTHOR("Nicolas Pitre");
-- 
1.5.5.1
