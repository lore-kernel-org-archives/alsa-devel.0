From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCHv2 4/5] ASoC: fsl-sai: Convert to use regmap framework's endianness method.
Date: Tue, 19 Aug 2014 12:14:52 +0800
Message-ID: <1408421693-9929-5-git-send-email-Li.Xiubo@freescale.com>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408421693-9929-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 7 +++----
 sound/soc/fsl/fsl_sai.c                             | 6 +-----
 sound/soc/fsl/fsl_sai.h                             | 1 -
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index dc9f9c3..aed1f21 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -18,9 +18,8 @@ Required properties:
 - pinctrl-names: Must contain a "default" entry.
 - pinctrl-NNN: One property must exist for each entry in pinctrl-names.
   See ../pinctrl/pinctrl-bindings.txt for details of the property values.
-- big-endian-regs: If this property is absent, the little endian mode will
-  be in use as default, or the big endian mode will be in use for all the
-  device registers.
+- big-endian: Boolean property, required if all the SAI device registers
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
