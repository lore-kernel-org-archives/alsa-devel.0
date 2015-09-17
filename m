From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed by
	spdif device
Date: Thu, 17 Sep 2015 14:09:24 +0800
Message-ID: <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 46B6126510F
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 08:09:38 +0200 (CEST)
In-Reply-To: <cover.1442469788.git.shengjiu.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

spdif need to enable the spba clock, when sdma is using share peripheral
script. If don't enable it, may cause the read/write wrong data from/to
registers.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 sound/soc/fsl/fsl_spdif.c                             | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index b5ee32e..9113dc0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -27,6 +27,8 @@ Required properties:
 			  Transceiver Clock Diagram" of SoC reference manual.
 			  It can also be referred to TxClk_Source bit of
 			  register SPDIF_STC.
+	"dma"		  The spba clock is needed when sdma share peripheral
+			  script is used.
 
    - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index ab729f2..2f4cb37 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -106,6 +106,7 @@ struct fsl_spdif_priv {
 	struct clk *rxclk;
 	struct clk *coreclk;
 	struct clk *sysclk;
+	struct clk *dmaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 };
@@ -466,6 +467,12 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 			return ret;
 		}
 
+		ret = clk_prepare_enable(spdif_priv->dmaclk);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to enable dma clock\n");
+			return ret;
+		}
+
 		ret = spdif_softreset(spdif_priv);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to soft reset\n");
@@ -540,6 +547,7 @@ static void fsl_spdif_shutdown(struct snd_pcm_substream *substream,
 		spdif_intr_status_clear(spdif_priv);
 		regmap_update_bits(regmap, REG_SPDIF_SCR,
 				SCR_LOW_POWER, SCR_LOW_POWER);
+		clk_disable_unprepare(spdif_priv->dmaclk);
 		clk_disable_unprepare(spdif_priv->coreclk);
 	}
 }
@@ -1221,6 +1229,13 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return PTR_ERR(spdif_priv->coreclk);
 	}
 
+	/* Get dma clock for dma script operation */
+	spdif_priv->dmaclk = devm_clk_get(&pdev->dev, "dma");
+	if (IS_ERR(spdif_priv->dmaclk)) {
+		dev_err(&pdev->dev, "no dma clock in devicetree\n");
+		return PTR_ERR(spdif_priv->dmaclk);
+	}
+
 	/* Select clock source for rx/tx clock */
 	spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
 	if (IS_ERR(spdif_priv->rxclk)) {
-- 
1.9.1
