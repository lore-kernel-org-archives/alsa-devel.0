From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl_spdif: Fix clock source for
	rxclk rate measurement
Date: Fri, 25 Apr 2014 19:58:19 +0800
Message-ID: <cbeb07fbdadd7bf72f74224d5ad12c9706376c95.1398427055.git.Guangyu.Chen@freescale.com>
References: <cover.1398427055.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 by alsa0.perex.cz (Postfix) with ESMTP id ED7E8261A34
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:56:43 +0200 (CEST)
In-Reply-To: <cover.1398427055.git.Guangyu.Chen@freescale.com>
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

The rxclk rate actually uses sysclk, ipg clock for example, as its
reference clock to calculate it. But the driver currently doesn't
pass a correct clock source. So fix it.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 12 +++++++++++-
 sound/soc/fsl/fsl_spdif.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e2836b3..4ce4ffa 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -81,6 +81,7 @@ struct fsl_spdif_priv {
 	struct clk *txclk[SPDIF_TXRATE_MAX];
 	struct clk *rxclk;
 	struct clk *coreclk;
+	struct clk *sysclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 
@@ -767,7 +768,7 @@ static int spdif_get_rxclk_rate(struct fsl_spdif_priv *spdif_priv,
 	clksrc = (phaseconf >> SRPC_CLKSRC_SEL_OFFSET) & 0xf;
 	if (srpc_dpll_locked[clksrc] && (phaseconf & SRPC_DPLL_LOCKED)) {
 		/* Get bus clock from system */
-		busclk_freq = clk_get_rate(spdif_priv->rxclk);
+		busclk_freq = clk_get_rate(spdif_priv->sysclk);
 	}
 
 	/* FreqMeas_CLK = (BUS_CLK * FreqMeas) / 2 ^ 10 / GAINSEL / 128 */
@@ -1100,6 +1101,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *regs;
 	int irq, ret, i;
+	char tmp[16];
 
 	if (!np)
 		return -ENODEV;
@@ -1147,6 +1149,14 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Get system clock for rx clock rate calculation */
+	sprintf(tmp, "rxtx%d", SPDIF_CLK_SRC_SYSCLK);
+	spdif_priv->sysclk = devm_clk_get(&pdev->dev, tmp);
+	if (IS_ERR(spdif_priv->sysclk)) {
+		dev_err(&pdev->dev, "no sys clock (%s) in devicetree\n", tmp);
+		return PTR_ERR(spdif_priv->sysclk);
+	}
+
 	/* Get core clock for data register access via DMA */
 	spdif_priv->coreclk = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(spdif_priv->coreclk)) {
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 605a10b..f9241e7 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -157,6 +157,8 @@ enum spdif_gainsel {
 #define STC_TXCLK_DIV(x)		((((x) - 1) << STC_TXCLK_DIV_OFFSET) & STC_TXCLK_DIV_MASK)
 #define STC_TXCLK_SRC_MAX		8
 
+#define SPDIF_CLK_SRC_SYSCLK		5
+
 /* SPDIF tx rate */
 enum spdif_txrate {
 	SPDIF_TXRATE_32000 = 0,
-- 
1.8.4
