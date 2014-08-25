From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 4/4] ASoC: fsl-sai: Convert to use regmap framework's endianness method.
Date: Mon, 25 Aug 2014 11:31:02 +0800
Message-ID: <1408937462-18727-5-git-send-email-Li.Xiubo@freescale.com>
References: <1408937462-18727-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408937462-18727-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, nicoleotsuka@gmail.com, timur@tabi.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: galak@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++----
 sound/soc/fsl/fsl_sai.c                             | 6 +-----
 sound/soc/fsl/fsl_sai.h                             | 1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index dc9f9c3..06a405e 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -18,9 +18,8 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See ../pinctrl/pinctrl-bindings.txt for details of the property values.
-- big-endian-regs: If this property is absent, the little endian mode will
-  be in use as default, or the big endian mode will be in use for all the
-  device registers.
+- big-endian: Boolean property, required if all the FTM_PWM registers
+  are big-endian rather than little-endian.
 - big-endian-data: If this property is absent, the little endian mode will
   be in use as default, or the big endian mode will be in use for all the
   fifo data.
@@ -53,6 +52,6 @@ sai2: sai@40031000 {
 	      dma-names = "tx", "rx";
 	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
 		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
-	      big-endian-regs;
+	      big-endian;
 	      big-endian-data;
 };
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 60fe7c7..a6eb784 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -544,7 +544,7 @@ static bool fsl_sai_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config fsl_sai_regmap_config = {
+static const struct regmap_config fsl_sai_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
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
