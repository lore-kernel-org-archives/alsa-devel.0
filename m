From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 3/4] ASoC: fsl-sai: Convert to use regmap
	framework's endianness method.
Date: Mon, 18 Aug 2014 14:52:21 +0800
Message-ID: <1408344742-28701-4-git-send-email-Li.Xiubo@freescale.com>
References: <1408344742-28701-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC76265473
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 08:56:52 +0200 (CEST)
In-Reply-To: <1408344742-28701-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.de, alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, timur@tabi.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
 sound/soc/fsl/fsl_sai.c                             | 4 ----
 sound/soc/fsl/fsl_sai.h                             | 1 -
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index dc9f9c3..cf7875c 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -18,9 +18,9 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See ../pinctrl/pinctrl-bindings.txt for details of the property values.
-- big-endian-regs: If this property is absent, the little endian mode will
-  be in use as default, or the big endian mode will be in use for all the
-  device registers.
+- big-endian: If this property is absent, the little endian mode will be in
+  use as default, or the big endian mode will be in use for all the device
+  registers.
 - big-endian-data: If this property is absent, the little endian mode will
   be in use as default, or the big endian mode will be in use for all the
   fifo data.
@@ -53,6 +53,6 @@ sai2: sai@40031000 {
 	      dma-names = "tx", "rx";
 	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
 		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
-	      big-endian-regs;
+	      big-endian;
 	      big-endian-data;
 };
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 60fe7c7..82741f4 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -573,10 +573,6 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx6sx-sai"))
 		sai->sai_on_imx = true;
 
-	sai->big_endian_regs = of_property_read_bool(np, "big-endian-regs");
-	if (sai->big_endian_regs)
-		fsl_sai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-
 	sai->big_endian_data = of_property_read_bool(np, "big-endian-data");
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b3d8864..2cded44 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -132,7 +132,6 @@ struct fsl_sai {
 	struct clk *bus_clk;
 	struct clk *mclk_clk[FSL_SAI_MCLK_MAX];
 
-	bool big_endian_regs;
 	bool big_endian_data;
 	bool is_dsp_mode;
 	bool sai_on_imx;
-- 
1.8.5
