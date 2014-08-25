From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv3 1/4] ASoC: fsl-asrc: Convert to use regmap framework's endianness method.
Date: Mon, 25 Aug 2014 11:30:59 +0800
Message-ID: <1408937462-18727-2-git-send-email-Li.Xiubo@freescale.com>
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
 sound/soc/fsl/fsl_asrc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

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
