From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: Use dev_name() for registering
	the irq
Date: Mon, 29 Dec 2014 19:57:26 -0200
Message-ID: <1419890246-21985-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com
 [209.85.220.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 72509260568
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 22:57:39 +0100 (CET)
Received: by mail-vc0-f170.google.com with SMTP id hy4so5419719vcb.15
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 13:57:38 -0800 (PST)
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

The 'name' array is currently stored inside the fsl_esai private structure only
for registering the interrupt name.

This can be simplified by registering it with dev_name() instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_esai.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 1c08ab1..dbe9204 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -44,7 +44,6 @@
  * @sck_div: if using PSR/PM dividers for SCKx clock
  * @slave_mode: if fully using DAI slave mode
  * @synchronous: if using tx/rx synchronous mode
- * @name: driver name
  */
 struct fsl_esai {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -63,7 +62,6 @@ struct fsl_esai {
 	bool sck_div[2];
 	bool slave_mode;
 	bool synchronous;
-	char name[32];
 };
 
 static irqreturn_t esai_isr(int irq, void *devid)
@@ -739,7 +737,6 @@ static int fsl_esai_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	esai_priv->pdev = pdev;
-	strncpy(esai_priv->name, np->name, sizeof(esai_priv->name) - 1);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -779,7 +776,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, esai_isr, 0,
-			       esai_priv->name, esai_priv);
+			       dev_name(&pdev->dev), esai_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim irq %u\n", irq);
 		return ret;
-- 
1.9.1
