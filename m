From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: i2s: Prevent potential NULL platform data
 dereference
Date: Thu, 14 Feb 2019 16:58:40 +0100
Message-ID: <20190214155840.3764-1-s.nawrocki@samsung.com>
References: <CGME20190214155852epcas1p30dd461a0c14cadd70b487e908978ce3a@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

When np is NULL i2s_pdata could also be NULL but i2s_pdata is now being
dereferenced without proper check. Fix this and shorten the error message
so we don't exceed 80 characters limit.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
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
2.17.1
