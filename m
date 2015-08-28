From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nuc900: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:15 +0100
Message-ID: <E1ZVNhH-00077s-En@finisterre>
References: <1440637937.18698.4.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 413472660F6
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:18 +0200 (CEST)
In-Reply-To: <1440637937.18698.4.camel@ingics.com>
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

   ASoC: nuc900: Convert to devm_snd_soc_register_platform

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

>From d5f1117ff60d1e314b15e3a85b7705db3421d7d4 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 27 Aug 2015 09:12:17 +0800
Subject: [PATCH] ASoC: nuc900: Convert to devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/nuc900/nuc900-pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index 5ae5ca1..e093261 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -308,13 +308,7 @@ static struct snd_soc_platform_driver nuc900_soc_platform = {
 
 static int nuc900_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
-}
-
-static int nuc900_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &nuc900_soc_platform);
 }
 
 static struct platform_driver nuc900_pcm_driver = {
@@ -323,7 +317,6 @@ static struct platform_driver nuc900_pcm_driver = {
 	},
 
 	.probe = nuc900_soc_platform_probe,
-	.remove = nuc900_soc_platform_remove,
 };
 
 module_platform_driver(nuc900_pcm_driver);
-- 
2.5.0
