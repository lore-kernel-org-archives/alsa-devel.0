From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: dma-sh7760: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Sun, 30 Aug 2015 12:26:49 +0100
Message-ID: <E1ZW0l7-0008Er-7m@finisterre>
References: <1440904053.32046.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3680F260575
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 16:18:06 +0200 (CEST)
In-Reply-To: <1440904053.32046.1.camel@ingics.com>
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

   ASoC: sh: dma-sh7760: Convert to devm_snd_soc_register_platform

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

>From e8de871e19668257972b167aabd56bb5faae784c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 30 Aug 2015 11:07:33 +0800
Subject: [PATCH] ASoC: sh: dma-sh7760: Convert to
 devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/dma-sh7760.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index fd11404..8fad444 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -327,13 +327,7 @@ static struct snd_soc_platform_driver sh7760_soc_platform = {
 
 static int sh7760_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
-}
-
-static int sh7760_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
 }
 
 static struct platform_driver sh7760_pcm_driver = {
@@ -342,7 +336,6 @@ static struct platform_driver sh7760_pcm_driver = {
 	},
 
 	.probe = sh7760_soc_platform_probe,
-	.remove = sh7760_soc_platform_remove,
 };
 
 module_platform_driver(sh7760_pcm_driver);
-- 
2.5.0
