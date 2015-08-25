From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap-mcbsp: Convert to use
	devm_ioremap_resource" to the asoc tree
Date: Tue, 25 Aug 2015 10:36:29 +0100
Message-ID: <E1ZUAeb-0006Eg-4N@debutante>
References: <1440406145.27868.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 34E2B260435
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 11:36:39 +0200 (CEST)
In-Reply-To: <1440406145.27868.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap-mcbsp: Convert to use devm_ioremap_resource

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

>From 5aec892a6ebe5a3e2a006d969b5fab59e6c79f63 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 24 Aug 2015 16:49:05 +0800
Subject: [PATCH] ASoC: omap-mcbsp: Convert to use devm_ioremap_resource

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/mcbsp.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 68a125205375..c7563e230c7d 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -965,25 +965,15 @@ int omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->free = true;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
-	if (!res) {
+	if (!res)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res) {
-			dev_err(mcbsp->dev, "invalid memory resource\n");
-			return -ENOMEM;
-		}
-	}
-	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
-				     dev_name(&pdev->dev))) {
-		dev_err(mcbsp->dev, "memory region already claimed\n");
-		return -ENODEV;
-	}
+
+	mcbsp->io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mcbsp->io_base))
+		return PTR_ERR(mcbsp->io_base);
 
 	mcbsp->phys_base = res->start;
 	mcbsp->reg_cache_size = resource_size(res);
-	mcbsp->io_base = devm_ioremap(&pdev->dev, res->start,
-				      resource_size(res));
-	if (!mcbsp->io_base)
-		return -ENOMEM;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
 	if (!res)
-- 
2.5.0
