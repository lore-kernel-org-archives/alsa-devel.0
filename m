From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 12/13] ASoC: fsl: imx-audmux: Let device core
	handle pinctrl
Date: Mon, 6 May 2013 15:06:00 -0300
Message-ID: <1367863561-11534-12-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 539D7261B0F
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 20:06:49 +0200 (CEST)
In-Reply-To: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: shawn.guo@linaro.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, festevam@gmail.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for handling pinctrl.

So remove devm_pinctrl_get_select_default() from the driver. 

Cc: Mark Brown <broonie@kernel.org>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 3f333e5..22967c6 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/pinctrl/consumer.h>
 
 #include "imx-audmux.h"
 
@@ -247,7 +246,6 @@ EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 static int imx_audmux_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	struct pinctrl *pinctrl;
 	const struct of_device_id *of_id =
 			of_match_device(imx_audmux_dt_ids, &pdev->dev);
 
@@ -256,12 +254,6 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	if (IS_ERR(audmux_base))
 		return PTR_ERR(audmux_base);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		dev_err(&pdev->dev, "setup pinctrl failed!");
-		return PTR_ERR(pinctrl);
-	}
-
 	audmux_clk = clk_get(&pdev->dev, "audmux");
 	if (IS_ERR(audmux_clk)) {
 		dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
-- 
1.7.9.5
