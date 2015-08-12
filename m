From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Wed, 12 Aug 2015 11:22:30 +0800
Message-ID: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0112.outbound.protection.outlook.com [65.55.169.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 39D0A2605E8
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:20:44 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

add wm8960 support for fsl-asoc-card

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  2 ++
 sound/soc/fsl/fsl-asoc-card.c                      | 37 ++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index a96774c..fa0a10d 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -59,6 +59,8 @@ Optional properties:
   - audio-asrc		: The phandle of ASRC. It can be absent if there's no
 			  need to add ASRC support via DPCM.
 
+  - gpr			: The gpr handle
+
 Example:
 sound-cs42888 {
 	compatible = "fsl,imx-audio-cs42888";
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index de43887..c058e68 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -16,6 +16,7 @@
 #include <linux/of_platform.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <linux/mfd/syscon.h>
 
 #include "fsl_esai.h"
 #include "fsl_sai.h"
@@ -23,6 +24,7 @@
 
 #include "../codecs/sgtl5000.h"
 #include "../codecs/wm8962.h"
+#include "../codecs/wm8960.h"
 
 #define RX 0
 #define TX 1
@@ -90,6 +92,7 @@ struct fsl_asoc_card_priv {
 	u32 asrc_format;
 	u32 dai_fmt;
 	char name[32];
+	struct regmap *gpr;
 };
 
 /**
@@ -400,7 +403,7 @@ static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 
 static int fsl_asoc_card_probe(struct platform_device *pdev)
 {
-	struct device_node *cpu_np, *codec_np, *asrc_np;
+	struct device_node *cpu_np, *codec_np, *asrc_np, *gpr_np;
 	struct device_node *np = pdev->dev.of_node;
 	struct platform_device *asrc_pdev = NULL;
 	struct platform_device *cpu_pdev;
@@ -443,6 +446,22 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	if (asrc_np)
 		asrc_pdev = of_find_device_by_node(asrc_np);
 
+	gpr_np = of_parse_phandle(np, "gpr", 0);
+	if (gpr_np) {
+		priv->gpr = syscon_node_to_regmap(gpr_np);
+		if (IS_ERR(priv->gpr)) {
+			ret = PTR_ERR(priv->gpr);
+			dev_err(&pdev->dev, "failed to get gpr regmap\n");
+			goto fail;
+		}
+		/*
+		 * for imx6ul we should set SAI2_MCLK_DIR to enable
+		 * codec MCLK
+		 */
+		if (of_device_is_compatible(np, "fsl,imx6ul-evk-wm8960"))
+			regmap_update_bits(priv->gpr, 4, 1 << 20, 1 << 20);
+	}
+
 	/* Get the MCLK rate only, and leave it controlled by CODEC drivers */
 	codec_clk = clk_get(&codec_dev->dev, NULL);
 	if (!IS_ERR(codec_clk)) {
@@ -475,6 +494,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
 		priv->codec_priv.pll_id = WM8962_FLL;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8960")) {
+		priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
+		priv->codec_priv.fll_id = WM8960_SYSCLK_AUTO;
+		priv->codec_priv.pll_id = WM8960_SYSCLK_AUTO;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		return -EINVAL;
@@ -521,7 +545,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	/* Normal DAI Link */
 	priv->dai_link[0].cpu_of_node = cpu_np;
 	priv->dai_link[0].codec_of_node = codec_np;
-	priv->dai_link[0].codec_dai_name = codec_dev->name;
+	if (strstr(codec_dev->name, "wm8960"))
+		priv->dai_link[0].codec_dai_name = "wm8960-hifi";
+	else
+		priv->dai_link[0].codec_dai_name = codec_dev->name;
 	priv->dai_link[0].platform_of_node = cpu_np;
 	priv->dai_link[0].dai_fmt = priv->dai_fmt;
 	priv->card.num_links = 1;
@@ -530,7 +557,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		/* DPCM DAI Links only if ASRC exsits */
 		priv->dai_link[1].cpu_of_node = asrc_np;
 		priv->dai_link[1].platform_of_node = asrc_np;
-		priv->dai_link[2].codec_dai_name = codec_dev->name;
+		if (strstr(codec_dev->name, "wm8960"))
+			priv->dai_link[2].codec_dai_name = "wm8960-hifi";
+		else
+			priv->dai_link[2].codec_dai_name = codec_dev->name;
 		priv->dai_link[2].codec_of_node = codec_np;
 		priv->dai_link[2].cpu_of_node = cpu_np;
 		priv->dai_link[2].dai_fmt = priv->dai_fmt;
@@ -578,6 +608,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
+	{ .compatible = "fsl,imx-audio-wm8960", },
 	{}
 };
 
-- 
1.9.1
