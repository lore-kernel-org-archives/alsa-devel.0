From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/5] ASoC: fsl-spdif: Convert to use regmap framework's endianness method.
Date: Tue, 19 Aug 2014 12:12:42 +0800
Message-ID: <1408421564-9863-4-git-send-email-Li.Xiubo@freescale.com>
References: <1408421564-9863-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408421564-9863-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 sound/soc/fsl/fsl_spdif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 70acfe4..ae4e408 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1040,7 +1040,7 @@ static bool fsl_spdif_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config fsl_spdif_regmap_config = {
+static const struct regmap_config fsl_spdif_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1184,9 +1184,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
 	spdif_priv->cpu_dai_drv.name = spdif_priv->name;
 
-	if (of_property_read_bool(np, "big-endian"))
-		fsl_spdif_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
