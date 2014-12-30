From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl_spdif: Use dev_name() for
	registering the irq
Date: Mon, 29 Dec 2014 23:52:35 -0200
Message-ID: <1419904356-6865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 6965326058F
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 02:52:54 +0100 (CET)
Received: by mail-vc0-f174.google.com with SMTP id id10so5490051vcb.19
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:52:53 -0800 (PST)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The 'name' array is currently stored inside the fsl_spdif_priv private structure
only for registering the interrupt name.

This can be simplified by registering it with dev_name() instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index af042942..73da1f0 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -90,7 +90,6 @@ struct spdif_mixer_control {
  * @sysclk: system clock for rx clock rate measurement
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
- * @name: driver name
  */
 struct fsl_spdif_priv {
 	struct spdif_mixer_control fsl_spdif_control;
@@ -109,12 +108,8 @@ struct fsl_spdif_priv {
 	struct clk *sysclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-
-	/* The name space will be allocated dynamically */
-	char name[0];
 };
 
-
 /* DPLL locked and lock loss interrupt handler */
 static void spdif_irq_dpll_lock(struct fsl_spdif_priv *spdif_priv)
 {
@@ -1169,19 +1164,15 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENODEV;
 
-	spdif_priv = devm_kzalloc(&pdev->dev,
-			sizeof(struct fsl_spdif_priv) + strlen(np->name) + 1,
-			GFP_KERNEL);
+	spdif_priv = devm_kzalloc(&pdev->dev, sizeof(*spdif_priv), GFP_KERNEL);
 	if (!spdif_priv)
 		return -ENOMEM;
 
-	strcpy(spdif_priv->name, np->name);
-
 	spdif_priv->pdev = pdev;
 
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
-	spdif_priv->cpu_dai_drv.name = spdif_priv->name;
+	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1203,7 +1194,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
-			spdif_priv->name, spdif_priv);
+			       dev_name(&pdev->dev), spdif_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "could not claim irq %u\n", irq);
 		return ret;
-- 
1.9.1
