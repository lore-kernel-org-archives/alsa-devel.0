From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: txx9: Convert to
	devm_snd_soc_register_platform" to the asoc tree
Date: Fri, 28 Aug 2015 18:44:11 +0100
Message-ID: <E1ZVNhD-00076v-QN@finisterre>
References: <1440638090.18698.7.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6F8F2605D9
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 19:44:25 +0200 (CEST)
In-Reply-To: <1440638090.18698.7.camel@ingics.com>
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

   ASoC: txx9: Convert to devm_snd_soc_register_platform

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

>From 95e3c2305b79e9c0e5f2cb0090efca397249b51f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 27 Aug 2015 09:14:50 +0800
Subject: [PATCH] ASoC: txx9: Convert to devm_snd_soc_register_platform

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/txx9/txx9aclc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 88eacfd..a8f705b 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -411,13 +411,8 @@ static struct snd_soc_platform_driver txx9aclc_soc_platform = {
 
 static int txx9aclc_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &txx9aclc_soc_platform);
-}
-
-static int txx9aclc_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &txx9aclc_soc_platform);
 }
 
 static struct platform_driver txx9aclc_pcm_driver = {
@@ -426,7 +421,6 @@ static struct platform_driver txx9aclc_pcm_driver = {
 	},
 
 	.probe = txx9aclc_soc_platform_probe,
-	.remove = txx9aclc_soc_platform_remove,
 };
 
 module_platform_driver(txx9aclc_pcm_driver);
-- 
2.5.0
