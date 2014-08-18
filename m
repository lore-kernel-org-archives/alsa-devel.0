From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/4] ASoC: fsl-spdif: Convert to use regmap
	framework's endianness method.
Date: Mon, 18 Aug 2014 14:52:19 +0800
Message-ID: <1408344742-28701-2-git-send-email-Li.Xiubo@freescale.com>
References: <1408344742-28701-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ED592654C9
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 08:56:48 +0200 (CEST)
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
 sound/soc/fsl/fsl_spdif.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 70acfe4..90d6352 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
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
