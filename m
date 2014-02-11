From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 1/2] ASoC: fsl-spdif: big-endian support
Date: Tue, 11 Feb 2014 15:42:48 +0800
Message-ID: <1392104569-27792-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, Guangyu.Chen@freescale.com
Cc: perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For most platforms, the CPU and SPDIF device is in the same endianess
mode. While for the LS1 platform, the CPU is in LE mode and the SPDIF
is in BE mode.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---

Fix some issues from Nicolin Chen's comments.


 Documentation/devicetree/bindings/sound/fsl,spdif.txt | 5 +++++
 sound/soc/fsl/fsl_spdif.c                             | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index f2ae335..3e9e82c8 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -29,6 +29,10 @@ Required properties:
 			can also be referred to TxClk_Source
 			bit of register SPDIF_STC.
 
+   - big-endian : If this property is absent, the native endian mode will
+   be in use as default, or the big endian mode will be in use for all the
+   device registers.
+
 Example:
 
 spdif: spdif@02004000 {
@@ -50,5 +54,6 @@ spdif: spdif@02004000 {
 		"rxtx5", "rxtx6",
 		"rxtx7";
 
+	big-endian;
 	status = "okay";
 };
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8f36f49..6452ca8 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -985,7 +985,7 @@ static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct regmap_config fsl_spdif_regmap_config = {
+static struct regmap_config fsl_spdif_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1105,6 +1105,9 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
 	spdif_priv->cpu_dai_drv.name = spdif_priv->name;
 
+	if (of_property_read_bool(np, "big-endian"))
+		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
+
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.4
