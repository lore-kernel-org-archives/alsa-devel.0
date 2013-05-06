From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 13/13] ASoC: mxs: mxs-saif: Let device core
	handle pinctrl
Date: Mon, 6 May 2013 15:06:01 -0300
Message-ID: <1367863561-11534-13-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A679260824
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
 sound/soc/mxs/mxs-saif.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 3a2aa1d..12723b0 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/fsl/mxs-dma.h>
-#include <linux/pinctrl/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -661,7 +660,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
-	struct pinctrl *pinctrl;
 	int ret = 0;
 	struct device_node *master;
 
@@ -701,12 +699,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 
 	mxs_saif[saif->id] = saif;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		return ret;
-	}
-
 	saif->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
-- 
1.7.9.5
