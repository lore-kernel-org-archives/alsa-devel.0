From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH v2] ASoC: fsl_spdif: Fix clock source for rxclk
	rate measurement
Date: Mon, 28 Apr 2014 23:07:51 +0800
Message-ID: <1398697671-4635-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 820462610CA
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 17:06:21 +0200 (CEST)
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

Changelog
v2:
 * Use fixed name for sysclk fetching.

 sound/soc/fsl/fsl_spdif.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e2836b3..e7be6b3 100644
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
@@ -1147,6 +1148,13 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Get system clock for rx clock rate calculation */
+	spdif_priv->sysclk = devm_clk_get(&pdev->dev, "rxtx5");
+	if (IS_ERR(spdif_priv->sysclk)) {
+		dev_err(&pdev->dev, "no sys clock (rxtx5) in devicetree\n");
+		return PTR_ERR(spdif_priv->sysclk);
+	}
+
 	/* Get core clock for data register access via DMA */
 	spdif_priv->coreclk = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(spdif_priv->coreclk)) {
-- 
1.8.4
