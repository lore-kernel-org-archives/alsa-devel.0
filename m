From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SPEAr: Convert to use
	devm_ioremap_resource" to the asoc tree
Date: Tue, 25 Aug 2015 10:36:28 +0100
Message-ID: <E1ZUAea-0006EB-7C@debutante>
References: <1440406350.27868.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 043D42602F1
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 11:36:36 +0200 (CEST)
In-Reply-To: <1440406350.27868.5.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SPEAr: Convert to use devm_ioremap_resource

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

>From 552ef80389ec2567566be1ccc0dd79f08ba32cce Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 24 Aug 2015 16:52:30 +0800
Subject: [PATCH] ASoC: SPEAr: Convert to use devm_ioremap_resource

Use devm_ioremap_resource() instead of open code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/spear/spdif_in.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
index a4028601da01..977a078eb92f 100644
--- a/sound/soc/spear/spdif_in.c
+++ b/sound/soc/spear/spdif_in.c
@@ -203,35 +203,25 @@ static int spdif_in_probe(struct platform_device *pdev)
 	struct spdif_in_dev *host;
 	struct spear_spdif_platform_data *pdata;
 	struct resource *res, *res_fifo;
+	void __iomem *io_base;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
+	io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	res_fifo = platform_get_resource(pdev, IORESOURCE_IO, 0);
 	if (!res_fifo)
 		return -EINVAL;
 
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				resource_size(res), pdev->name)) {
-		dev_warn(&pdev->dev, "Failed to get memory resourse\n");
-		return -ENOENT;
-	}
-
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
 	if (!host) {
 		dev_warn(&pdev->dev, "kzalloc fail\n");
 		return -ENOMEM;
 	}
 
-	host->io_base = devm_ioremap(&pdev->dev, res->start,
-				resource_size(res));
-	if (!host->io_base) {
-		dev_warn(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
-	}
-
+	host->io_base = io_base;
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0)
 		return -EINVAL;
-- 
2.5.0
