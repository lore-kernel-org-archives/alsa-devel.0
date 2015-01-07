From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl_dma: Remove 'path' field from
	dma_object struct
Date: Wed,  7 Jan 2015 15:21:51 -0200
Message-ID: <1420651312-21671-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 31CCF26501B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 18:22:15 +0100 (CET)
Received: by mail-vc0-f182.google.com with SMTP id hq12so626743vcb.41
 for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2015 09:22:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The 'path' field has not a real purpose, so let's get rid of it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Buit tested only.

 sound/soc/fsl/fsl_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 93d7e56..026da0a 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -63,7 +63,6 @@ struct dma_object {
 	struct ccsr_dma_channel __iomem *channel;
 	unsigned int irq;
 	bool assigned;
-	char path[1];
 };
 
 /*
@@ -910,7 +909,6 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	strcpy(dma->path, np->full_name);
 	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
-- 
1.9.1
