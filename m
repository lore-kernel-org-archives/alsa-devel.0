From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/3] ASoC: designware_i2s: Remove unnecessary
	dev_set_drvdata()
Date: Mon, 26 Aug 2013 09:25:15 -0300
Message-ID: <1377519915-23998-3-git-send-email-fabio.estevam@freescale.com>
References: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id B8264261ACB
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 14:27:41 +0200 (CEST)
In-Reply-To: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
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

Driver core clears the driver data to NULL after device_release or on probe
failure, so just remove it from here.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/dwc/designware_i2s.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 70eb37a..25c31f1 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -421,13 +421,11 @@ static int dw_i2s_probe(struct platform_device *pdev)
 					 dw_i2s_dai, 1);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "not able to register dai\n");
-		goto err_set_drvdata;
+		goto err_clk_disable;
 	}
 
 	return 0;
 
-err_set_drvdata:
-	dev_set_drvdata(&pdev->dev, NULL);
 err_clk_disable:
 	clk_disable(dev->clk);
 err_clk_put:
@@ -440,7 +438,6 @@ static int dw_i2s_remove(struct platform_device *pdev)
 	struct dw_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	clk_put(dev->clk);
 
-- 
1.8.1.2
