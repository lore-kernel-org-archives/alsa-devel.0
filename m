From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_audmix: cache pdev->dev pointer" to
	the asoc tree
Date: Mon, 15 Apr 2019 09:53:30 +0100 (BST)
Message-ID: <20190415085330.496361127A40@debutante.sirena.org.uk>
References: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DB50F8971F
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2019 10:53:44 +0200 (CEST)
In-Reply-To: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Viorel Suman <viorel.suman@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Takashi Iwai <tiwai@suse.com>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_audmix: cache pdev->dev pointer

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From ecf6715042cf0f738763fe34d1636b707961a58a Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Wed, 10 Apr 2019 11:06:39 +0000
Subject: [PATCH] ASoC: fsl_audmix: cache pdev->dev pointer

There should be no trouble to understand dev = pdev->dev.
This can save some space to have more print info or save
some wrapped lines.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index dc802d5c4ccd..3897a54a11fe 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -456,6 +456,7 @@ MODULE_DEVICE_TABLE(of, fsl_audmix_ids);
 
 static int fsl_audmix_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct fsl_audmix *priv;
 	struct resource *res;
 	const char *mdrv;
@@ -463,52 +464,50 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 	void __iomem *regs;
 	int ret;
 
-	of_id = of_match_device(fsl_audmix_ids, &pdev->dev);
+	of_id = of_match_device(fsl_audmix_ids, dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 
 	mdrv = of_id->data;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	/* Get the addresses */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&pdev->dev, res);
+	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "ipg", regs,
+	priv->regmap = devm_regmap_init_mmio_clk(dev, "ipg", regs,
 						 &fsl_audmix_regmap_config);
 	if (IS_ERR(priv->regmap)) {
-		dev_err(&pdev->dev, "failed to init regmap\n");
+		dev_err(dev, "failed to init regmap\n");
 		return PTR_ERR(priv->regmap);
 	}
 
-	priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	priv->ipg_clk = devm_clk_get(dev, "ipg");
 	if (IS_ERR(priv->ipg_clk)) {
-		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		dev_err(dev, "failed to get ipg clock\n");
 		return PTR_ERR(priv->ipg_clk);
 	}
 
 	platform_set_drvdata(pdev, priv);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_audmix_component,
+	ret = devm_snd_soc_register_component(dev, &fsl_audmix_component,
 					      fsl_audmix_dai,
 					      ARRAY_SIZE(fsl_audmix_dai));
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+		dev_err(dev, "failed to register ASoC DAI\n");
 		return ret;
 	}
 
-	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
-						   0);
+	priv->pdev = platform_device_register_data(dev, mdrv, 0, NULL, 0);
 	if (IS_ERR(priv->pdev)) {
 		ret = PTR_ERR(priv->pdev);
-		dev_err(&pdev->dev, "failed to register platform %s: %d\n",
-			mdrv, ret);
+		dev_err(dev, "failed to register platform %s: %d\n", mdrv, ret);
 	}
 
 	return ret;
-- 
2.20.1
