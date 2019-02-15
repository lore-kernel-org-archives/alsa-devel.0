From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Prevent potential NULL platform data dereference" to the asoc tree
Date: Fri, 15 Feb 2019 18:41:41 +0000 (GMT)
Message-ID: <20190215184141.0B3A011286B7@debutante.sirena.org.uk>
References: <20190214155840.3764-1-s.nawrocki@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214155840.3764-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, sbkim73@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Prevent potential NULL platform data dereference

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

>From 6e434122d9041c48841709385e823eef3225663e Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 16:58:40 +0100
Subject: [PATCH] ASoC: samsung: i2s: Prevent potential NULL platform data
 dereference

When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
dereferenced without proper check. Fix this and shorten the error message
so we don't exceed 80 characters limit.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 03fff1c657be..02472f576e17 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1369,7 +1369,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
 	struct resource *res;
-	u32 regs_base, quirks = 0, idma_addr = 0;
+	u32 regs_base, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
 	int num_dais, ret;
@@ -1389,11 +1389,19 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	quirks = np ? i2s_dai_data->quirks : i2s_pdata->type.quirks;
-	num_dais = (quirks & QUIRK_SEC_DAI) ? 2 : 1;
+	if (np) {
+		priv->quirks = i2s_dai_data->quirks;
+	} else {
+		if (!i2s_pdata) {
+			dev_err(&pdev->dev, "Missing platform data\n");
+			return -EINVAL;
+		}
+		priv->quirks = i2s_pdata->type.quirks;
+	}
+
+	num_dais = (priv->quirks & QUIRK_SEC_DAI) ? 2 : 1;
 	priv->pdev = pdev;
 	priv->variant_regs = i2s_dai_data->i2s_variant_regs;
-	priv->quirks = quirks;
 
 	ret = i2s_alloc_dais(priv, i2s_dai_data, num_dais);
 	if (ret < 0)
@@ -1405,11 +1413,6 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->pcm_lock);
 
 	if (!np) {
-		if (i2s_pdata == NULL) {
-			dev_err(&pdev->dev, "Can't work without s3c_audio_pdata\n");
-			return -EINVAL;
-		}
-
 		pri_dai->dma_playback.filter_data = i2s_pdata->dma_playback;
 		pri_dai->dma_capture.filter_data = i2s_pdata->dma_capture;
 		pri_dai->filter = i2s_pdata->dma_filter;
@@ -1418,7 +1421,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	} else {
 		if (of_property_read_u32(np, "samsung,idma-addr",
 					 &idma_addr)) {
-			if (quirks & QUIRK_SUPPORTS_IDMA) {
+			if (priv->quirks & QUIRK_SUPPORTS_IDMA) {
 				dev_info(&pdev->dev, "idma address is not"\
 						"specified");
 			}
@@ -1451,7 +1454,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	pri_dai->dma_capture.addr_width = 4;
 	pri_dai->priv = priv;
 
-	if (quirks & QUIRK_PRI_6CHAN)
+	if (priv->quirks & QUIRK_PRI_6CHAN)
 		pri_dai->drv->playback.channels_max = 6;
 
 	ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
@@ -1459,7 +1462,7 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_clk;
 
-	if (quirks & QUIRK_SEC_DAI) {
+	if (priv->quirks & QUIRK_SEC_DAI) {
 		sec_dai = &priv->dai[SAMSUNG_I2S_ID_SECONDARY - 1];
 
 		sec_dai->dma_playback.addr = regs_base + I2STXDS;
-- 
2.20.1
