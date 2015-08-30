From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: psc-i2s: Convert to use
	devm_ioremap_resource" to the asoc tree
Date: Sun, 30 Aug 2015 12:26:48 +0100
Message-ID: <E1ZW0l6-0008EO-0n@finisterre>
References: <1440904189.32046.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06371260499
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 16:17:34 +0200 (CEST)
In-Reply-To: <1440904189.32046.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Manuel Lauss <manuel.lauss@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: au1x: psc-i2s: Convert to use devm_ioremap_resource

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

>From fd63542fc5492b86158dbd53ce5de764f171b1b6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 30 Aug 2015 11:09:49 +0800
Subject: [PATCH] ASoC: au1x: psc-i2s: Convert to use devm_ioremap_resource

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/psc-i2s.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index e742ef6..38e853a 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -305,19 +305,9 @@ static int au1xpsc_i2s_drvprobe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -ENODEV;
-
-	ret = -EBUSY;
-	if (!devm_request_mem_region(&pdev->dev, iores->start,
-				     resource_size(iores),
-				     pdev->name))
-		return -EBUSY;
-
-	wd->mmio = devm_ioremap(&pdev->dev, iores->start,
-				resource_size(iores));
-	if (!wd->mmio)
-		return -EBUSY;
+	wd->mmio = devm_ioremap_resource(&pdev->dev, iores);
+	if (IS_ERR(wd->mmio))
+		return PTR_ERR(wd->mmio);
 
 	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!dmares)
-- 
2.5.0
