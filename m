From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-vcif: Use
	devm_snd_soc_register_component" to the asoc tree
Date: Mon, 17 Aug 2015 13:49:07 -0700
Message-ID: <E1ZRRL9-0001dm-EI@finisterre>
References: <20150815023155.GA27364@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id B2ED7260471
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 22:49:09 +0200 (CEST)
In-Reply-To: <20150815023155.GA27364@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-vcif: Use devm_snd_soc_register_component

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

>From 553de19a0e2f21809bc3864d40308864652521eb Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Sat, 15 Aug 2015 08:01:55 +0530
Subject: [PATCH] ASoC: davinci-vcif: Use devm_snd_soc_register_component

Use resource managed function devm_snd_soc_register_component for
component registration instead of snd_soc_register_component.

Also, remove davinci_vcif_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-vcif.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index fabd05f..c77d921 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -231,8 +231,9 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, davinci_vcif_dev);
 
-	ret = snd_soc_register_component(&pdev->dev, &davinci_vcif_component,
-					 &davinci_vcif_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &davinci_vcif_component,
+					      &davinci_vcif_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "could not register dai\n");
 		return ret;
@@ -241,23 +242,14 @@ static int davinci_vcif_probe(struct platform_device *pdev)
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
-		snd_soc_unregister_component(&pdev->dev);
 		return ret;
 	}
 
 	return 0;
 }
 
-static int davinci_vcif_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-
-	return 0;
-}
-
 static struct platform_driver davinci_vcif_driver = {
 	.probe		= davinci_vcif_probe,
-	.remove		= davinci_vcif_remove,
 	.driver		= {
 		.name	= "davinci-vcif",
 	},
-- 
2.5.0
