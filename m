From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [ASoC]fsl_ssi: fix of_property_read_u32_array return value check
Date: Sun, 15 Feb 2015 23:11:43 +0100
Message-ID: <54E1199F.3000107@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

of_property_read_u32_array returns 0 on success, so the return value shouldn't be inverted twice,
first on assignment then in condition expression.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index d7365c5..134388f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1227,7 +1227,7 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
     ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
     ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
 
-    ret = !of_property_read_u32_array(np, "dmas", dmas, 4);
+    ret = of_property_read_u32_array(np, "dmas", dmas, 4);
     if (ssi_private->use_dma && !ret && dmas[2] == IMX_DMATYPE_SSI_DUAL) {
         ssi_private->use_dual_fifo = true;
         /* When using dual fifo mode, we need to keep watermark
