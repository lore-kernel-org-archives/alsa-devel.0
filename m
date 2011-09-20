From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Flush Samsung DMA on free
Date: Tue, 20 Sep 2011 23:26:54 +0100
Message-ID: <1316557614-32044-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F56A103A6D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 00:27:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lrg@ti.com>, Boojin Kim <boojin.kim@samsung.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ever since it was written the Samsung DMA driver has had a TODO in the
hw_free() function wondering if we need to flush the DMA buffers. Up until
now the answer has been no but with the recent improvements Boojin has
done to the DMA infrastructure for the Samsung port the answer has changed
to yes for at least S3C6410 systems.

If we don't then when we next prepare() the channel the API will get
confused trying to run callbacks on the transfers hanging around from the
previous time the stream was open and oops.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Kukjin, this should probably get added to your branch assuming it's OK
for other CPUs.

 sound/soc/samsung/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index 851346f..2d622b6 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -198,10 +198,10 @@ static int dma_hw_free(struct snd_pcm_substream *substream)
 
 	pr_debug("Entered %s\n", __func__);
 
-	/* TODO - do we need to ensure DMA flushed */
 	snd_pcm_set_runtime_buffer(substream, NULL);
 
 	if (prtd->params) {
+		prtd->params->ops->flush(prtd->params->ch);
 		prtd->params->ops->release(prtd->params->ch,
 					prtd->params->client);
 		prtd->params = NULL;
-- 
1.7.6.3
