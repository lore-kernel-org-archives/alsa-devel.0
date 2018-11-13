From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Remove redundant check for
	mcbsp->pdata" to the asoc tree
Date: Tue, 13 Nov 2018 18:30:17 +0000 (GMT)
Message-ID: <20181113183017.B26C4440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6782677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:30:24 +0100 (CET)
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
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Remove redundant check for mcbsp->pdata

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 465d85b3976a15c9e0e205ff50be64efa11b7af3 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 8 Nov 2018 09:29:59 +0200
Subject: [PATCH] ASoC: omap-mcbsp: Remove redundant check for mcbsp->pdata

The driver will not probe if the pdata is not provided or created.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Tested-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap-mcbsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e48fad11a0cc..8cab1151d3bb 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -324,7 +324,7 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 	mcbsp->reg_cache = reg_cache;
 	spin_unlock(&mcbsp->lock);
 
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->request)
 		mcbsp->pdata->ops->request(mcbsp->id - 1);
 
 	/*
@@ -361,7 +361,7 @@ static int omap_mcbsp_request(struct omap_mcbsp *mcbsp)
 err_free_irq:
 	free_irq(mcbsp->tx_irq, (void *)mcbsp);
 err_clk_disable:
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
@@ -382,7 +382,7 @@ static void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 {
 	void *reg_cache;
 
-	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
+	if(mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(mcbsp->id - 1);
 
 	/* Disable wakeup behavior */
-- 
2.19.1
