From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: fsl: fsl_spdif: No need to check the
	return value of platform_get_resource()
Date: Mon, 4 Nov 2013 09:51:20 -0200
Message-ID: <1383565880-19692-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E9322619F7
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 12:51:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When using devm_ioremap_resource(), we do not need to check the return value of
platform_get_resource(), so just remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 76c742a..55193a5 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1107,11 +1107,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "could not determine device resources\n");
-		return -ENXIO;
-	}
-
 	regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
-- 
1.8.1.2
