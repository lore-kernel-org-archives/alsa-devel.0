From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: spdif: Convert to use
	devm_snd_dmaengine_pcm_register" to the asoc tree
Date: Mon, 19 Oct 2015 20:43:17 +0100
Message-ID: <E1ZoGKz-0002BL-Tx@debutante>
References: <1444703830.3259.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1417265D68
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 21:43:26 +0200 (CEST)
In-Reply-To: <1444703830.3259.1.camel@ingics.com>
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

   ASoC: rockchip: spdif: Convert to use devm_snd_dmaengine_pcm_register

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

>From 2057020db384cb971cfd51296426f447e6d66b64 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 13 Oct 2015 10:37:10 +0800
Subject: [PATCH] ASoC: rockchip: spdif: Convert to use
 devm_snd_dmaengine_pcm_register

Use resource managed API then we can remove snd_dmaengine_pcm_unregister()
and snd_soc_unregister_component() calls in .probe error path and .remove.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_spdif.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 9d5c470cee82..a38a3029062c 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -355,16 +355,14 @@ static int rk_spdif_probe(struct platform_device *pdev)
 		goto err_pm_runtime;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		goto err_pcm_register;
+		goto err_pm_runtime;
 	}
 
 	return 0;
 
-err_pcm_register:
-	snd_dmaengine_pcm_unregister(&pdev->dev);
 err_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 
@@ -381,8 +379,6 @@ static int rk_spdif_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spdif->mclk);
 	clk_disable_unprepare(spdif->hclk);
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
2.6.1
