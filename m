From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:19 +0100
Message-ID: <E1ZVNhL-00078r-9I@finisterre>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DA72C265FCB
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:37 +0200 (CEST)
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
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

   ASoC: au1x: Convert to devm_snd_soc_register_platform

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

>From edd98a1a2d163cef6d91226bf42ca002ced6ff16 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 27 Aug 2015 09:09:29 +0800
Subject: [PATCH] ASoC: au1x: Convert to devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/dbdma2.c | 11 ++---------
 sound/soc/au1x/dma.c    | 11 ++---------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index dd94fea..5741c0a 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -344,14 +344,8 @@ static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmadata);
 
-	return snd_soc_register_platform(&pdev->dev, &au1xpsc_soc_platform);
-}
-
-static int au1xpsc_pcm_drvremove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &au1xpsc_soc_platform);
 }
 
 static struct platform_driver au1xpsc_pcm_driver = {
@@ -359,7 +353,6 @@ static struct platform_driver au1xpsc_pcm_driver = {
 		.name	= "au1xpsc-pcm",
 	},
 	.probe		= au1xpsc_pcm_drvprobe,
-	.remove		= au1xpsc_pcm_drvremove,
 };
 
 module_platform_driver(au1xpsc_pcm_driver);
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 24cc7f4..fcf5a9a 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -312,14 +312,8 @@ static int alchemy_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	return snd_soc_register_platform(&pdev->dev, &alchemy_pcm_soc_platform);
-}
-
-static int alchemy_pcm_drvremove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &alchemy_pcm_soc_platform);
 }
 
 static struct platform_driver alchemy_pcmdma_driver = {
@@ -327,7 +321,6 @@ static struct platform_driver alchemy_pcmdma_driver = {
 		.name	= "alchemy-pcm-dma",
 	},
 	.probe		= alchemy_pcm_drvprobe,
-	.remove		= alchemy_pcm_drvremove,
 };
 
 module_platform_driver(alchemy_pcmdma_driver);
-- 
2.5.0
