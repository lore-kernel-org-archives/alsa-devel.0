From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH] ASoC: fsl_spdif: Add core clock control for
	DMA access
Date: Thu, 24 Apr 2014 18:52:24 +0800
Message-ID: <1398336744-4836-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 by alsa0.perex.cz (Postfix) with ESMTP id 447D2261B2D
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 12:50:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Regmap is able to enable/disable the core clock automatically each time
it's going to access the registers. But for DMA cases during playback or
recording, it's totally beyong control of regmap. So we have to open the
clock manually.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index daa6198..e2836b3 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -80,6 +80,7 @@ struct fsl_spdif_priv {
 	u8 rxclk_src;
 	struct clk *txclk[SPDIF_TXRATE_MAX];
 	struct clk *rxclk;
+	struct clk *coreclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 
@@ -423,10 +424,16 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 
 	/* Reset module and interrupts only for first initialization */
 	if (!cpu_dai->active) {
+		ret = clk_prepare_enable(spdif_priv->coreclk);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable core clock\n");
+			return ret;
+		}
+
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
-			return ret;
+			goto err;
 		}
 
 		/* Disable all the interrupts */
@@ -454,6 +461,11 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(regmap, REG_SPDIF_SCR, SCR_LOW_POWER, 0);
 
 	return 0;
+
+err:
+	clk_disable_unprepare(spdif_priv->coreclk);
+
+	return ret;
 }
 
 static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
@@ -484,6 +496,7 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
+		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
 
@@ -1134,6 +1147,13 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Get core clock for data register access via DMA */
+	spdif_priv->coreclk = devm_clk_get(&pdev->dev, "core");
+	if (IS_ERR(spdif_priv->coreclk)) {
+		dev_err(&pdev->dev, "no core clock in devicetree\n");
+		return PTR_ERR(spdif_priv->coreclk);
+	}
+
 	/* Select clock source for rx/tx clock */
 	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
 	if (IS_ERR(spdif_priv->rxclk)) {
-- 
1.8.4
