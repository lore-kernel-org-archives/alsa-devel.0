From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 3/3] ASoC: fsl_sai: Add imx6ul platform support
Date: Fri, 7 Aug 2015 14:23:53 +0800
Message-ID: <065a754c8d3eae30ef492bd81fcfdc96df5475b8.1438928571.git.zidan.wang@freescale.com>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DBE62615F7
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 08:22:33 +0200 (CEST)
In-Reply-To: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

i.MX6ul SoC contains SAI module, so add imx6ul platform support.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 390197e..229a517 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -701,10 +701,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
-		sai->sai_on_imx = true;
-
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
+	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai") ||
+	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
 		sai->sai_on_imx = true;
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
@@ -805,6 +804,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
+	{ .compatible = "fsl,imx6ul-sai", },
 	{ .compatible = "fsl,imx7d-sai", },
 	{ /* sentinel */ }
 };
-- 
1.9.1
