From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra: Revert part of "ASoC: tegra:
	Convert to managed resources"" to the asoc tree
Date: Tue, 18 Aug 2015 09:55:44 -0700
Message-ID: <E1ZRkAq-0004HC-4z@finisterre>
References: <20150818115645.GA3345@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p2012.superclick.com (unknown [216.4.250.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 606142619D7
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 18:55:48 +0200 (CEST)
In-Reply-To: <20150818115645.GA3345@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra: Revert part of "ASoC: tegra: Convert to managed resources"

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

>From 1d15f21dc8030c4511964819b89b50e39d5a7013 Mon Sep 17 00:00:00 2001
From: Vaishali Thakkar <vthakkar1994@gmail.com>
Date: Tue, 18 Aug 2015 17:26:45 +0530
Subject: [PATCH] ASoC: tegra: Revert part of "ASoC: tegra: Convert to managed
 resources"

Revert the problematic part of commit 470805eb9f31 ("ASoC: tegra:
Convert to managed resources"). Before this commit, PM cleanup was
performed after the component was unregistered. But returning
directly will skip PM cleanup. So, to be on safe side it is better
to use snd_soc_register_component instead of
devm_snd_soc_register_component.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra20_spdif.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index a814da0..66237bc 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -329,9 +329,8 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &tegra20_spdif_component,
-					      &tegra20_spdif_dai, 1);
+	ret = snd_soc_register_component(&pdev->dev, &tegra20_spdif_component,
+					 &tegra20_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
@@ -341,11 +340,13 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	ret = tegra_pcm_platform_register(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM: %d\n", ret);
-		return ret;
+		goto err_unregister_component;
 	}
 
 	return 0;
 
+err_unregister_component:
+	snd_soc_unregister_component(&pdev->dev);
 err_suspend:
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra20_spdif_runtime_suspend(&pdev->dev);
@@ -364,6 +365,7 @@ static int tegra20_spdif_platform_remove(struct platform_device *pdev)
 		tegra20_spdif_runtime_suspend(&pdev->dev);
 
 	tegra_pcm_platform_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
2.5.0
