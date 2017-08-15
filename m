From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Freescale: Delete an error message for
	a failed memory allocation in three functions" to the asoc tree
Date: Tue, 15 Aug 2017 18:15:30 +0100
Message-ID: <E1dhfRC-0003fo-Ms@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DCED26749A
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 19:15:33 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Elfring <elfring@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Freescale: Delete an error message for a failed memory allocation in three functions

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

>From 443be77e4b09d98c28196dca7132a1191ecf742b Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 11 Aug 2017 15:10:43 +0200
Subject: [PATCH] ASoC: Freescale: Delete an error message for a failed memory
 allocation in three functions

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc_dma.c | 4 +---
 sound/soc/fsl/fsl_dma.c      | 1 -
 sound/soc/fsl/fsl_ssi.c      | 4 +---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 282d841840b1..2baf19608bd0 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -279,10 +279,8 @@ static int fsl_asrc_dma_startup(struct snd_pcm_substream *substream)
 	struct fsl_asrc_pair *pair;
 
 	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
-	if (!pair) {
-		dev_err(dev, "failed to allocate pair\n");
+	if (!pair)
 		return -ENOMEM;
-	}
 
 	pair->asrc_priv = asrc_priv;
 
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 979ed1b3ecc4..c17359648915 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -905,7 +905,6 @@ static int fsl_soc_dma_probe(struct platform_device *pdev)
 
 	dma = kzalloc(sizeof(*dma) + strlen(np->full_name), GFP_KERNEL);
 	if (!dma) {
-		dev_err(&pdev->dev, "could not allocate dma object\n");
 		of_node_put(ssi_np);
 		return -ENOMEM;
 	}
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 173cb8496641..64598d1183f8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1432,10 +1432,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi_private = devm_kzalloc(&pdev->dev, sizeof(*ssi_private),
 			GFP_KERNEL);
-	if (!ssi_private) {
-		dev_err(&pdev->dev, "could not allocate DAI object\n");
+	if (!ssi_private)
 		return -ENOMEM;
-	}
 
 	ssi_private->soc = of_id->data;
 	ssi_private->dev = &pdev->dev;
-- 
2.13.3
