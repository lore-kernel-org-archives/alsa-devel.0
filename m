From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3] ASoC: fsl_dma: remove dma_object path member
Date: Tue, 29 Aug 2017 07:37:55 -0500
Message-ID: <20170829123755.9496-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 9373C266C6D
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 14:37:59 +0200 (CEST)
Received: by mail-oi0-f68.google.com with SMTP id w10so2898822oie.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 05:37:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

dma_object.path is unused, so rather than fix it to work with DT
full_name changes, just remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
---
v3:
- Update subject: s/sound/ASoC/
v2:
- Move printf specifier change to correct patch

 sound/soc/fsl/fsl_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index c17359648915..0c11f434a374 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -63,7 +63,6 @@ struct dma_object {
 	struct ccsr_dma_channel __iomem *channel;
 	unsigned int irq;
 	bool assigned;
-	char path[1];
 };
 
 /*
@@ -903,13 +902,12 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
+	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
 	if (!dma) {
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
 
-	strcpy(dma->path, np->full_name);
 	dma->dai.ops = &fsl_dma_ops;
 	dma->dai.pcm_new = fsl_dma_new;
 	dma->dai.pcm_free = fsl_dma_free_dma_buffers;
-- 
2.11.0
