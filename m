From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_sai: Allow the SAI driver to turn on
	SAI_MCLK
Date: Tue,  3 May 2016 22:09:33 -0300
Message-ID: <1462324173-10976-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D2B482604D6
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 03:10:21 +0200 (CEST)
Received: by mail-yw0-f181.google.com with SMTP id o66so57040649ywc.3
 for <alsa-devel@alsa-project.org>; Tue, 03 May 2016 18:10:21 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, shawnguo@kernel.org, brain@jikos.cz
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

On mx6ul the General Purpose Register 1 (GPR1) contains the following
bits for enabling the output of the SAI MCLKs:
SAI1_MCLK_DIR, SAI2_MCLK_DIR, SAI3_MCLK_DIR

Introduce "gpr" and "fsl,sai-enable-mclk" optional properties to allow
the enablement of the SAI_MCLK outputs.

Tested on a imx6ul-evk board.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 .../devicetree/bindings/sound/fsl-sai.txt          |  8 +++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |  3 ++
 sound/soc/fsl/fsl_sai.c                            | 37 ++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 044e5d7..86755bb 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -48,6 +48,14 @@ Required properties:
 			  receive data by following their own bit clocks and
 			  frame sync clocks separately.
 
+Optional properties (for mx6ul):
+
+  - gpr			: The phandle to the General Purpose Register (GPR)
+			  node.
+
+  - fsl,sai-enable-mclk	: This is a boolean property. If present, indicates
+			  that SAI will output the SAI MCLK clock.
+
 Note:
 - If both fsl,sai-asynchronous and fsl,sai-synchronous-rx are absent, the
   default synchronous mode (sync Rx with Tx) will be used, which means both
diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
index 238c8db..401f97e 100644
--- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
+++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
@@ -447,5 +447,8 @@
 #define IMX6UL_GPR1_ENET2_CLK_OUTPUT		(0x1 << 18)
 #define IMX6UL_GPR1_ENET_CLK_DIR		(0x3 << 17)
 #define IMX6UL_GPR1_ENET_CLK_OUTPUT		(0x3 << 17)
+#define IMX6UL_GPR1_SAI1_MCLK_DIR		(0x1 << 19)
+#define IMX6UL_GPR1_SAI2_MCLK_DIR		(0x1 << 20)
+#define IMX6UL_GPR1_SAI3_MCLK_DIR		(0x1 << 21)
 
 #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 0754df7..311325e 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -21,6 +21,8 @@
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 
 #include "fsl_sai.h"
 #include "imx-pcm.h"
@@ -785,11 +787,14 @@ static const struct regmap_config fsl_sai_regmap_config = {
 static int fsl_sai_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *gpr_np = of_parse_phandle(np, "gpr", 0);
 	struct fsl_sai *sai;
+	struct regmap *gpr;
 	struct resource *res;
 	void __iomem *base;
 	char tmp[8];
 	int irq, ret, i;
+	u32 index;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
@@ -877,6 +882,38 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		fsl_sai_dai.symmetric_samplebits = 0;
 	}
 
+	if (of_find_property(np, "fsl,sai-enable-mclk", NULL)) {
+		ret = of_property_read_u32(np, "sai-index", &index);
+		if (ret) {
+			dev_err(&pdev->dev, "could not read sai-index\n");
+			return ret;
+		}
+
+		gpr = syscon_node_to_regmap(gpr_np);
+		if (IS_ERR(gpr)) {
+			dev_err(&pdev->dev, "could not find gpr node\n");
+			return PTR_ERR(gpr);
+		}
+
+		switch (index) {
+		case 1:
+			regmap_update_bits(gpr, IOMUXC_GPR1,
+					   IMX6UL_GPR1_SAI1_MCLK_DIR,
+					   IMX6UL_GPR1_SAI1_MCLK_DIR);
+			break;
+		case 2:
+			regmap_update_bits(gpr, IOMUXC_GPR1,
+					   IMX6UL_GPR1_SAI2_MCLK_DIR,
+					   IMX6UL_GPR1_SAI2_MCLK_DIR);
+			break;
+		case 3:
+			regmap_update_bits(gpr, IOMUXC_GPR1,
+					   IMX6UL_GPR1_SAI3_MCLK_DIR,
+					   IMX6UL_GPR1_SAI3_MCLK_DIR);
+			break;
+		}
+	}
+
 	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
 	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
 	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
-- 
1.9.1
