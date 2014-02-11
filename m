From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v2 2/2] ASoC: fsl-esai: big-endian support
Date: Tue, 11 Feb 2014 15:42:49 +0800
Message-ID: <1392104569-27792-2-git-send-email-Li.Xiubo@freescale.com>
References: <1392104569-27792-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392104569-27792-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, Guangyu.Chen@freescale.com
Cc: perex@perex.cz, tiwai@suse.de, shawn.guo@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For most platforms, the CPU and ESAI device is in the same endianess
mode. While for the LS1 platform, the CPU is in LE mode and the ESAI
is in BE mode.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---

Fix some issues from Nicolin Chen's comments.


 Documentation/devicetree/bindings/sound/fsl,esai.txt | 5 +++++
 sound/soc/fsl/fsl_esai.c                             | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index d7b99fa..aeb8c4a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -34,6 +34,10 @@ Required properties:
     that ESAI would work in the synchronous mode, which means all the settings
     for Receiving would be duplicated from Transmition related registers.
 
+  - big-endian : If this property is absent, the native endian mode will
+    be in use as default, or the big endian mode will be in use for all the
+    device registers.
+
 Example:
 
 esai: esai@02024000 {
@@ -46,5 +50,6 @@ esai: esai@02024000 {
 	dma-names = "rx", "tx";
 	fsl,fifo-depth = <128>;
 	fsl,esai-synchronous;
+	big-endian;
 	status = "disabled";
 };
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c84026c..80667fe 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -661,7 +661,7 @@ static bool fsl_esai_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const struct regmap_config fsl_esai_regmap_config = {
+static struct regmap_config fsl_esai_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -687,6 +687,9 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	esai_priv->pdev = pdev;
 	strcpy(esai_priv->name, np->name);
 
+	if (of_property_read_bool(np, "big-endian"))
+		fsl_esai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
+
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.4
