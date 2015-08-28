From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: blackfin: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:17 +0100
Message-ID: <E1ZVNhJ-00078N-D1@finisterre>
References: <1440637873.18698.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3199266005
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:45:38 +0200 (CEST)
In-Reply-To: <1440637873.18698.3.camel@ingics.com>
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

   ASoC: blackfin: Convert to devm_snd_soc_register_platform

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

>From c4d2ab0d59f53a1534e6817b5dbd28719f667c39 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 27 Aug 2015 09:11:13 +0800
Subject: [PATCH] ASoC: blackfin: Convert to devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 10 ++--------
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 238913e..02ad260 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -450,13 +450,8 @@ static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 
 static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
-}
-
-static int bf5xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &bf5xx_ac97_soc_platform);
 }
 
 static struct platform_driver bf5xx_pcm_driver = {
@@ -465,7 +460,6 @@ static struct platform_driver bf5xx_pcm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bf5xx_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index d95477a..6cba211d 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -342,13 +342,8 @@ static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 
 static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
-}
-
-static int bfin_i2s_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &bf5xx_i2s_soc_platform);
 }
 
 static struct platform_driver bfin_i2s_pcm_driver = {
@@ -357,7 +352,6 @@ static struct platform_driver bfin_i2s_pcm_driver = {
 	},
 
 	.probe = bfin_i2s_soc_platform_probe,
-	.remove = bfin_i2s_soc_platform_remove,
 };
 
 module_platform_driver(bfin_i2s_pcm_driver);
-- 
2.5.0
