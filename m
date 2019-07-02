From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cirrus: ep93xx-i2s.c: use
	devm_snd_soc_register_component()" to the asoc tree
Date: Tue,  2 Jul 2019 14:04:42 +0100 (BST)
Message-ID: <20190702130442.55039440046@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27601F800D1
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2019 15:04:43 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cirrus: ep93xx-i2s.c: use devm_snd_soc_register_component()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From cb9002a186329b35f32f74021551aecbfe9a696c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Jun 2019 13:09:00 +0900
Subject: [PATCH] ASoC: cirrus: ep93xx-i2s.c: use
 devm_snd_soc_register_component()

We have devm_xxx version of snd_soc_register_component,
let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/cirrus/ep93xx-i2s.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 6ca899ba9484..0b4355e95f84 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -473,19 +473,17 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, info);
 
-	err = snd_soc_register_component(&pdev->dev, &ep93xx_i2s_component,
+	err = devm_snd_soc_register_component(&pdev->dev, &ep93xx_i2s_component,
 					 &ep93xx_i2s_dai, 1);
 	if (err)
 		goto fail_put_lrclk;
 
 	err = devm_ep93xx_pcm_platform_register(&pdev->dev);
 	if (err)
-		goto fail_unregister;
+		goto fail_put_lrclk;
 
 	return 0;
 
-fail_unregister:
-	snd_soc_unregister_component(&pdev->dev);
 fail_put_lrclk:
 	clk_put(info->lrclk);
 fail_put_sclk:
@@ -500,7 +498,6 @@ static int ep93xx_i2s_remove(struct platform_device *pdev)
 {
 	struct ep93xx_i2s_info *info = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
 	clk_put(info->lrclk);
 	clk_put(info->sclk);
 	clk_put(info->mclk);
-- 
2.20.1
