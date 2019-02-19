From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Fix secondary platform
	device unregistration" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:07 +0000 (GMT)
Message-ID: <20190219155007.9D11A11284AE@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56088F80781
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Fix secondary platform device unregistration

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

>From 022c4156697b9ae30a00f5cd7cee08ed61554e86 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 19 Feb 2019 16:19:40 +0100
Subject: [PATCH] ASoC: samsung: i2s: Fix secondary platform device
 unregistration

This fixes unregistration of the secondary platform device so all
resources are properly released.  Additionally the removal sequence
is corrected so it is in reverse order comparing to probe sequence.
The test against NULL priv->pdev_sec is removed as it is not necessary.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 02472f576e17..cd92bb6e1da1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 
 static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
 {
-	if (priv->pdev_sec) {
-		platform_device_del(priv->pdev_sec);
-		priv->pdev_sec = NULL;
-	}
+	platform_device_unregister(priv->pdev_sec);
+	priv->pdev_sec = NULL;
 }
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
@@ -1487,14 +1486,14 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 						sec_dai->filter, "tx-sec", NULL,
 						&pdev->dev);
 		if (ret < 0)
-			goto err_disable_clk;
+			goto err_del_sec;
 
 	}
 
 	if (i2s_pdata && i2s_pdata->cfg_gpio && i2s_pdata->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to configure gpio\n");
 		ret = -EINVAL;
-		goto err_disable_clk;
+		goto err_del_sec;
 	}
 
 	dev_set_drvdata(&pdev->dev, priv);
@@ -1503,7 +1502,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 					&samsung_i2s_component,
 					priv->dai_drv, num_dais);
 	if (ret < 0)
-		goto err_disable_clk;
+		goto err_del_sec;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1518,9 +1517,10 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 err_disable_pm:
 	pm_runtime_disable(&pdev->dev);
+err_del_sec:
+	i2s_delete_secondary_device(priv);
 err_disable_clk:
 	clk_disable_unprepare(priv->clk);
-	i2s_delete_secondary_device(priv);
 	return ret;
 }
 
@@ -1536,9 +1536,10 @@ static int samsung_i2s_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	i2s_unregister_clock_provider(priv);
+	i2s_delete_secondary_device(priv);
 	clk_disable_unprepare(priv->clk);
+
 	pm_runtime_put_noidle(&pdev->dev);
-	i2s_delete_secondary_device(priv);
 
 	return 0;
 }
-- 
2.20.1
