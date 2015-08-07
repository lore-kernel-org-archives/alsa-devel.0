From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 2/3] ASoC: fsl_sai: Add imx7d platform support
Date: Fri, 7 Aug 2015 14:23:52 +0800
Message-ID: <f269bace628dd8ebac7c1833b743d4d5e5d528db.1438928571.git.zidan.wang@freescale.com>
References: <35057b1d49085839cdd1c6514a6ed7b690c713e9.1438928571.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 by alsa0.perex.cz (Postfix) with ESMTP id AB3132615C0
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 08:22:31 +0200 (CEST)
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

i.MX7d SoC contains SAI module, so add imx7d platform support.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 5c737f1..390197e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -704,6 +704,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
 		sai->sai_on_imx = true;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx7d-sai"))
+		sai->sai_on_imx = true;
+
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -802,6 +805,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,vf610-sai", },
 	{ .compatible = "fsl,imx6sx-sai", },
+	{ .compatible = "fsl,imx7d-sai", },
 	{ /* sentinel */ }
 };
 
-- 
1.9.1
