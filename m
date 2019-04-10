From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-audmix: fix object reference leaks
	in probe" to the asoc tree
Date: Wed, 10 Apr 2019 13:26:35 +0100 (BST)
Message-ID: <20190410122635.E45F41128ED2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89CFCF80765
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 14:26:38 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: imx-audmix: fix object reference leaks in probe

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

>From 10802048d94891cf3220872707269b7ef41737c8 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:38 +0000
Subject: [PATCH] ASoC: imx-audmix: fix object reference leaks in probe

Release the reference to the underlying device taken
by of_find_device_by_node() call.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index 7983bd339c01..9aaf3e5b45b9 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -171,6 +171,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			np->full_name);
 		return -EINVAL;
 	}
+	put_device(&audmix_pdev->dev);
 
 	num_dai = of_count_phandle_with_args(audmix_np, "dais", NULL);
 	if (num_dai != FSL_AUDMIX_MAX_DAIS) {
@@ -216,6 +217,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to find SAI platform device\n");
 			return -EINVAL;
 		}
+		put_device(&cpu_pdev->dev);
 
 		dai_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
 					  fe_name_pref, args.np->full_name + 1);
@@ -280,6 +282,8 @@ static int imx_audmix_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to find SAI platform device\n");
 		return -EINVAL;
 	}
+	put_device(&cpu_pdev->dev);
+
 	priv->cpu_mclk = devm_clk_get(&cpu_pdev->dev, "mclk1");
 	if (IS_ERR(priv->cpu_mclk)) {
 		ret = PTR_ERR(priv->cpu_mclk);
-- 
2.20.1
