From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Use devm_ioremap_resource()
Date: Fri, 10 Apr 2015 07:12:29 -0300
Message-ID: <1428660749-9637-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f44.google.com (mail-vn0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CE39E260606
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 12:12:48 +0200 (CEST)
Received: by vnbf129 with SMTP id f129so4397334vnb.9
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 03:12:47 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Using platform_get_resource() and devm_ioremap_resource() can make the
code a bit simpler. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 143cc16..e8bb8ee 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1288,7 +1288,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	const char *p, *sprop;
 	const uint32_t *iprop;
-	struct resource res;
+	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
 
@@ -1335,19 +1335,11 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 	ssi_private->cpu_dai_drv.name = dev_name(&pdev->dev);
 
-	/* Get the addresses and IRQ */
-	ret = of_address_to_resource(np, 0, &res);
-	if (ret) {
-		dev_err(&pdev->dev, "could not determine device resources\n");
-		return ret;
-	}
-	ssi_private->ssi_phys = res.start;
-
-	iomem = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
-	if (!iomem) {
-		dev_err(&pdev->dev, "could not map device resources\n");
-		return -ENOMEM;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iomem = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(iomem))
+		return PTR_ERR(iomem);
+	ssi_private->ssi_phys = res->start;
 
 	ret = of_property_match_string(np, "clock-names", "ipg");
 	if (ret < 0) {
-- 
1.9.1
