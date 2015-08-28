From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:13 +0100
Message-ID: <E1ZVNhF-00077O-PS@finisterre>
References: <1440638026.18698.6.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B3A3D2660C7
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:11 +0200 (CEST)
In-Reply-To: <1440638026.18698.6.camel@ingics.com>
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

   ASoC: pxa: Convert to devm_snd_soc_register_platform

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

>From 637c4497bbf0c9a4e00d6be2731bd560bf609f6b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 27 Aug 2015 09:13:46 +0800
Subject: [PATCH] ASoC: pxa: Convert to devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/mmp-pcm.c    | 9 +--------
 sound/soc/pxa/pxa2xx-pcm.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 1eb45dc..51e790d 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -232,13 +232,7 @@ static int mmp_pcm_probe(struct platform_device *pdev)
 		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].period_bytes_max =
 						pdata->period_max_capture;
 	}
-	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
-}
-
-static int mmp_pcm_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
 }
 
 static struct platform_driver mmp_pcm_driver = {
@@ -247,7 +241,6 @@ static struct platform_driver mmp_pcm_driver = {
 	},
 
 	.probe = mmp_pcm_probe,
-	.remove = mmp_pcm_remove,
 };
 
 module_platform_driver(mmp_pcm_driver);
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index a51c9da..831ee37 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -124,13 +124,7 @@ static struct snd_soc_platform_driver pxa2xx_soc_platform = {
 
 static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
-}
-
-static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
 }
 
 #ifdef CONFIG_OF
@@ -147,7 +141,6 @@ static struct platform_driver pxa_pcm_driver = {
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-	.remove = pxa2xx_soc_platform_remove,
 };
 
 module_platform_driver(pxa_pcm_driver);
-- 
2.5.0
