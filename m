From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_dma: remove dma_object path member"
	to the asoc tree
Date: Tue, 29 Aug 2017 20:29:44 +0100 (BST)
Message-ID: <20170829192944.48E884400E7@finisterre.ee.mobilebroadband>
References: <20170829123755.9496-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 527C8267026
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:29:51 +0200 (CEST)
In-Reply-To: <20170829123755.9496-1-robh@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_dma: remove dma_object path member

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b1dc00abcf18d27b36de500c150be88022c82270 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Aug 2017 07:37:55 -0500
Subject: [PATCH] ASoC: fsl_dma: remove dma_object path member

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
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.13.2
