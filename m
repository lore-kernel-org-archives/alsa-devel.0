From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 1/3] sound/soc/mxs/mxs-saif.c: keep pointer
 to resource so it can be freed
Date: Tue, 18 Oct 2011 15:18:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1110181517320.17200@ask.diku.dk>
References: <1318909555-12933-1-git-send-email-julia@diku.dk>
	<65EE16ACC360FA4D99C96DC085B3F7722AB64D@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id 089EC10384D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 15:18:08 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722AB64D@039-SN1MPN1-003.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Add a new variable for storing resources accessed subsequent to the one
accessed using request_mem_region, so the one accessed using
request_mem_region can be released if needed.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
expression E, E1;
identifier f;
statement S1,S2,S3;
@@

if (E == NULL)
{
  ... when != if (E == NULL || ...) S1 else S2
      when != E = E1
*E->f
  ... when any
  return ...;
}
else S3
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
Not even compile tested.

 sound/soc/mxs/mxs-saif.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 401944c..76dc74d 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -617,7 +617,7 @@ static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
 
 static int mxs_saif_probe(struct platform_device *pdev)
 {
-	struct resource *res;
+	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
 	struct mxs_saif_platform_data *pdata;
 	int ret = 0;
@@ -655,35 +655,36 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		goto failed_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
+	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!iores) {
 		ret = -ENODEV;
 		dev_err(&pdev->dev, "failed to get io resource: %d\n",
 			ret);
 		goto failed_get_resource;
 	}
 
-	if (!request_mem_region(res->start, resource_size(res), "mxs-saif")) {
+	if (!request_mem_region(iores->start, resource_size(iores),
+				"mxs-saif")) {
 		dev_err(&pdev->dev, "request_mem_region failed\n");
 		ret = -EBUSY;
 		goto failed_get_resource;
 	}
 
-	saif->base = ioremap(res->start, resource_size(res));
+	saif->base = ioremap(iores->start, resource_size(iores));
 	if (!saif->base) {
 		dev_err(&pdev->dev, "ioremap failed\n");
 		ret = -ENODEV;
 		goto failed_ioremap;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (!res) {
+	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!dmares) {
 		ret = -ENODEV;
 		dev_err(&pdev->dev, "failed to get dma resource: %d\n",
 			ret);
 		goto failed_ioremap;
 	}
-	saif->dma_param.chan_num = res->start;
+	saif->dma_param.chan_num = dmares->start;
 
 	saif->irq = platform_get_irq(pdev, 0);
 	if (saif->irq < 0) {
@@ -742,7 +743,7 @@ failed_get_irq2:
 failed_get_irq1:
 	iounmap(saif->base);
 failed_ioremap:
-	release_mem_region(res->start, resource_size(res));
+	release_mem_region(iores->start, resource_size(iores));
 failed_get_resource:
 	clk_put(saif->clk);
 failed_clk:
