From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: sun4i-spdif: Add quirks to the spdif
 driver" to the asoc tree
Date: Sat, 31 Dec 2016 19:19:04 +0000
Message-ID: <E1cNPBI-0003sA-Jq@debutante>
References: <20161220144914.30945-3-codekipper@gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBOMJUDBQKGQETDGUWEI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161220144914.30945-3-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-spdif: Add quirks to the spdif driver

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

>From 7762681a3ada5fca6017e75ea7f9cdac08fc50b9 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 20 Dec 2016 15:49:14 +0100
Subject: [PATCH] ASoC: sun4i-spdif: Add quirks to the spdif driver

It has been seen that some newer SoCs have a different TX FIFO
address and we already have the difference with the A31 requiring
a reset. Add a quirks structure so that these can be managed
easily.

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index 048de15d6937..fec62ee1fc72 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -403,9 +403,29 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	bool has_reset;
+};
+
+static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
+	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+};
+
+static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
+	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.has_reset	= true,
+};
+
 static const struct of_device_id sun4i_spdif_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-spdif", },
-	{ .compatible = "allwinner,sun6i-a31-spdif", },
+	{
+		.compatible = "allwinner,sun4i-a10-spdif",
+		.data = &sun4i_a10_spdif_quirks,
+	},
+	{
+		.compatible = "allwinner,sun6i-a31-spdif",
+		.data = &sun6i_a31_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -438,6 +458,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 {
 	struct sun4i_spdif_dev *host;
 	struct resource *res;
+	const struct sun4i_spdif_quirks *quirks;
 	int ret;
 	void __iomem *base;
 
@@ -459,6 +480,12 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	quirks = of_device_get_match_data(&pdev->dev);
+	if (quirks == NULL) {
+		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
+		return -ENODEV;
+	}
+
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
 
@@ -476,14 +503,13 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		goto err_disable_apb_clk;
 	}
 
-	host->dma_params_tx.addr = res->start + SUN4I_SPDIF_TXFIFO;
+	host->dma_params_tx.addr = res->start + quirks->reg_dac_txdata;
 	host->dma_params_tx.maxburst = 8;
 	host->dma_params_tx.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 
 	platform_set_drvdata(pdev, host);
 
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun6i-a31-spdif")) {
+	if (quirks->has_reset) {
 		host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
 		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-- 
2.11.0
