From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: fsl_asrc: Use dev_name() for
	registering the irq
Date: Mon, 29 Dec 2014 23:52:36 -0200
Message-ID: <1419904356-6865-2-git-send-email-festevam@gmail.com>
References: <1419904356-6865-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 21D50260592
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 02:52:56 +0100 (CET)
Received: by mail-vc0-f180.google.com with SMTP id im6so5505792vcb.11
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 17:52:55 -0800 (PST)
In-Reply-To: <1419904356-6865-1-git-send-email-festevam@gmail.com>
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

The 'name' array is currently stored inside the fsl_asrc private structure only
for registering the interrupt name.

This can be simplified by registering it with dev_name() instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_asrc.c | 3 +--
 sound/soc/fsl/fsl_asrc.h | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 026a801..5326ca7 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -818,7 +818,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	asrc_priv->pdev = pdev;
-	strncpy(asrc_priv->name, np->name, sizeof(asrc_priv->name) - 1);
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -842,7 +841,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
-			       asrc_priv->name, asrc_priv);
+			       dev_name(&pdev->dev), asrc_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to claim irq %u: %d\n", irq, ret);
 		return ret;
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index a3f211f..4aed63c 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -433,7 +433,6 @@ struct fsl_asrc_pair {
  * @channel_avail: non-occupied channel numbers
  * @asrc_rate: default sample rate for ASoC Back-Ends
  * @asrc_width: default sample width for ASoC Back-Ends
- * @name: driver name
  */
 struct fsl_asrc {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
@@ -452,8 +451,6 @@ struct fsl_asrc {
 
 	int asrc_rate;
 	int asrc_width;
-
-	char name[32];
 };
 
 extern struct snd_soc_platform_driver fsl_asrc_platform;
-- 
1.9.1
