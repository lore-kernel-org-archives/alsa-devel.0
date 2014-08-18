From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/4] ASoC: fsl-esai: Convert to use regmap
	framework's endianness method.
Date: Mon, 18 Aug 2014 14:52:20 +0800
Message-ID: <1408344742-28701-3-git-send-email-Li.Xiubo@freescale.com>
References: <1408344742-28701-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 1809C2654B0
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 08:56:51 +0200 (CEST)
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
 sound/soc/fsl/fsl_esai.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index b2f6b3e..d05c18e 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -736,9 +736,6 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	esai_priv->pdev = pdev;
 	strcpy(esai_priv->name, np->name);
 
-	if (of_property_read_bool(np, "big-endian"))
-		fsl_esai_regmap_config.val_format_endian = REGMAP_ENDIAN_BIG;
-
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.5
