From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: imx-ssi: Check the return value from
	clk_prepare_enable()
Date: Wed,  4 Dec 2013 20:27:44 -0200
Message-ID: <1386196064-6199-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f47.google.com (mail-yh0-f47.google.com
 [209.85.213.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 33828264FB0
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 23:27:56 +0100 (CET)
Received: by mail-yh0-f47.google.com with SMTP id 29so12060539yhl.34
 for <alsa-devel@alsa-project.org>; Wed, 04 Dec 2013 14:27:55 -0800 (PST)
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

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-ssi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 6336757..df552fa 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -535,7 +535,9 @@ static int imx_ssi_probe(struct platform_device *pdev)
 			ret);
 		goto failed_clk;
 	}
-	clk_prepare_enable(ssi->clk);
+	ret = clk_prepare_enable(ssi->clk);
+	if (ret)
+		goto failed_clk;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssi->base = devm_ioremap_resource(&pdev->dev, res);
-- 
1.8.1.2
