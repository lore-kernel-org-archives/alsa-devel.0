From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa2xx-i2s: Convert to
	devm_snd_soc_register_component" to the asoc tree
Date: Fri, 28 Aug 2015 18:45:22 +0100
Message-ID: <E1ZVNiM-0007BK-Ix@finisterre>
References: <1440730184.11149.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46AAD265FED
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:38 +0200 (CEST)
In-Reply-To: <1440730184.11149.1.camel@ingics.com>
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

   ASoC: pxa2xx-i2s: Convert to devm_snd_soc_register_component

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

>From 2cf32b7b338086e9b85bb9fdd8aa398e89d83e9e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 28 Aug 2015 10:49:44 +0800
Subject: [PATCH] ASoC: pxa2xx-i2s: Convert to devm_snd_soc_register_component

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/pxa2xx-i2s.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index e68290c..6b4e400 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -367,19 +367,12 @@ static const struct snd_soc_component_driver pxa_i2s_component = {
 
 static int pxa2xx_i2s_drv_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev, &pxa_i2s_component,
-					  &pxa_i2s_dai, 1);
-}
-
-static int pxa2xx_i2s_drv_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &pxa_i2s_component,
+					       &pxa_i2s_dai, 1);
 }
 
 static struct platform_driver pxa2xx_i2s_driver = {
 	.probe = pxa2xx_i2s_drv_probe,
-	.remove = pxa2xx_i2s_drv_remove,
 
 	.driver = {
 		.name = "pxa2xx-i2s",
-- 
2.5.0
