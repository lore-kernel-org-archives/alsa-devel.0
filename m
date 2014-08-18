From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] ASoC: fsl-asrc: Convert to use regmap framework's endianness method.
Date: Mon, 18 Aug 2014 16:56:55 +0800
Message-ID: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---

This is depended on the following regmap framework patches, which have
just been merged into linux-next tree:

https://lkml.org/lkml/2014/7/15/6
https://lkml.org/lkml/2014/7/15/5
https://lkml.org/lkml/2014/7/15/7






 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 10 +++++++---
 sound/soc/fsl/fsl_asrc.c                             |  6 +-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index b93362a..791f372 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -26,9 +26,12 @@ Required properties:
 	"ipg"		  Peripheral clock to driver module.
 	"asrck_<0-f>"	  Clock sources for input and output clock.
 
-   - big-endian		: If this property is absent, the little endian mode
-			  will be in use as default. Otherwise, the big endian
-			  mode will be in use for all the device registers.
+   - big-endian		: If this property is absent, the native endian mode
+			  (same with CPU) will be in use as default. Otherwise,
+			  the big endian mode will be in use for all the device
+			  registers.
+			  See Documentation/devicetree/bindings/regmap/regmap.txt
+			  for more detail.
 
    - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
 
@@ -56,5 +59,6 @@ asrc: asrc@02034000 {
 		"txa", "txb", "txc";
 	fsl,asrc-rate  = <48000>;
 	fsl,asrc-width = <16>;
+	big-endian;
 	status = "okay";
 };
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 8221104..3b14531 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -684,7 +684,7 @@ static bool fsl_asrc_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config fsl_asrc_regmap_config = {
+static const struct regmap_config fsl_asrc_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -802,10 +802,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	asrc_priv->paddr = res->start;
 
-	/* Register regmap and let it prepare core clock */
-	if (of_property_read_bool(np, "big-endian"))
-		fsl_asrc_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-
 	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
 						      &fsl_asrc_regmap_config);
 	if (IS_ERR(asrc_priv->regmap)) {
-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
