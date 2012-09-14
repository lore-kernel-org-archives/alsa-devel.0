From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 3/5] ASoC: fsl: remove unnecessary call to
	dma_unmap_single
Date: Fri, 14 Sep 2012 16:14:36 -0500
Message-ID: <1347657278-25295-3-git-send-email-timur@freescale.com>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D7C6A264F03
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 23:14:56 +0200 (CEST)
In-Reply-To: <1347657278-25295-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove a call to dma_unmap_single() from the PowerPC ASoC DMA driver.  The
buffer is allocated and not actually mapped, so the unmap call doesn't
make sense.  It was probably left over from some early version of the driver.

This bug was unnoticed for so long because the DMA mapping functions normally
don't do anything on PowerPC.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/fsl/fsl_dma.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 96bb92d..6feb265 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -823,12 +823,6 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 		if (dma_private->irq)
 			free_irq(dma_private->irq, dma_private);
 
-		if (dma_private->ld_buf_phys) {
-			dma_unmap_single(dev, dma_private->ld_buf_phys,
-					 sizeof(dma_private->link),
-					 DMA_TO_DEVICE);
-		}
-
 		/* Deallocate the fsl_dma_private structure */
 		dma_free_coherent(dev, sizeof(struct fsl_dma_private),
 				  dma_private, dma_private->ld_buf_phys);
-- 
1.7.3.4
