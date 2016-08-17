From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_sai: Use 'np' variable
Date: Tue, 16 Aug 2016 21:00:54 -0300
Message-ID: <1471392054-17700-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
 [209.85.161.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B37265AFC
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 02:01:19 +0200 (CEST)
Received: by mail-yw0-f196.google.com with SMTP id u134so4276805ywg.3
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 17:01:19 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'np' variable is already assigned to 'pdev->dev.of_node', so use
it to improve readability.

No functional change.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2147994..9fadf7e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -801,8 +801,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai") ||
-	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai"))
+	if (of_device_is_compatible(np, "fsl,imx6sx-sai") ||
+	    of_device_is_compatible(np, "fsl,imx6ul-sai"))
 		sai->sai_on_imx = true;
 
 	sai->is_lsb_first = of_property_read_bool(np, "lsb-first");
@@ -883,7 +883,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	if (of_find_property(np, "fsl,sai-mclk-direction-output", NULL) &&
-	    of_device_is_compatible(pdev->dev.of_node, "fsl,imx6ul-sai")) {
+	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
 			dev_err(&pdev->dev, "cannot find iomuxc registers\n");
-- 
1.9.1
