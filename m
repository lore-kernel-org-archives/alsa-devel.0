From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mxs-saif: Do not store the irq number in
	the private structure
Date: Tue, 30 Dec 2014 12:11:36 -0200
Message-ID: <1419948696-18529-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A5F6626063E
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 15:11:56 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id le20so5625846vcb.24
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 06:11:55 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The irq number is only used inside the probe function, so there is really no
need to store it in the private structure.

Use a local 'irq' variable to hold the the irq number instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/mxs/mxs-saif.c | 10 +++++-----
 sound/soc/mxs/mxs-saif.h |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index d986508..c866ade 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -710,7 +710,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *iores;
 	struct mxs_saif *saif;
-	int ret = 0;
+	int irq, ret = 0;
 	struct device_node *master;
 
 	if (!np)
@@ -763,16 +763,16 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	if (IS_ERR(saif->base))
 		return PTR_ERR(saif->base);
 
-	saif->irq = platform_get_irq(pdev, 0);
-	if (saif->irq < 0) {
-		ret = saif->irq;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
 			ret);
 		return ret;
 	}
 
 	saif->dev = &pdev->dev;
-	ret = devm_request_irq(&pdev->dev, saif->irq, mxs_saif_irq, 0,
+	ret = devm_request_irq(&pdev->dev, irq, mxs_saif_irq, 0,
 			       dev_name(&pdev->dev), saif);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq\n");
diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
index fbaf7ba..9a4c0b2 100644
--- a/sound/soc/mxs/mxs-saif.h
+++ b/sound/soc/mxs/mxs-saif.h
@@ -116,7 +116,6 @@ struct mxs_saif {
 	unsigned int mclk;
 	unsigned int mclk_in_use;
 	void __iomem *base;
-	int irq;
 	unsigned int id;
 	unsigned int master_id;
 	unsigned int cur_rate;
-- 
1.9.1
