From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: ssi: Convert to
	devm_snd_soc_register_component" to the asoc tree
Date: Fri, 28 Aug 2015 18:45:10 +0100
Message-ID: <E1ZVNiA-0007Aq-6r@finisterre>
References: <1440730253.11149.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5016265FAE
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:34 +0200 (CEST)
In-Reply-To: <1440730253.11149.2.camel@ingics.com>
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

   ASoC: sh: ssi: Convert to devm_snd_soc_register_component

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

>From 92eca20bbeaa4ec1908bad8aeefcaa2d98e302ff Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 28 Aug 2015 10:50:53 +0800
Subject: [PATCH] ASoC: sh: ssi: Convert to devm_snd_soc_register_component

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/ssi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index ab13146..89ed1b1 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -385,14 +385,9 @@ static const struct snd_soc_component_driver sh4_ssi_component = {
 
 static int sh4_soc_dai_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_component(&pdev->dev, &sh4_ssi_component,
-					  sh4_ssi_dai, ARRAY_SIZE(sh4_ssi_dai));
-}
-
-static int sh4_soc_dai_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_component(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_component(&pdev->dev, &sh4_ssi_component,
+					       sh4_ssi_dai,
+					       ARRAY_SIZE(sh4_ssi_dai));
 }
 
 static struct platform_driver sh4_ssi_driver = {
@@ -401,7 +396,6 @@ static struct platform_driver sh4_ssi_driver = {
 	},
 
 	.probe = sh4_soc_dai_probe,
-	.remove = sh4_soc_dai_remove,
 };
 
 module_platform_driver(sh4_ssi_driver);
-- 
2.5.0
