From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/3] ASoC: ep93xx-i2s: Remove unnecessary
	dev_set_drvdata()
Date: Mon, 26 Aug 2013 09:25:14 -0300
Message-ID: <1377519915-23998-2-git-send-email-fabio.estevam@freescale.com>
References: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 32709261AC9
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
 sound/soc/cirrus/ep93xx-i2s.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index f23f331..a57643d 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -408,7 +408,6 @@ static int ep93xx_i2s_probe(struct platform_device *pdev)
 	return 0;
 
 fail_put_lrclk:
-	dev_set_drvdata(&pdev->dev, NULL);
 	clk_put(info->lrclk);
 fail_put_sclk:
 	clk_put(info->sclk);
@@ -423,7 +422,6 @@ static int ep93xx_i2s_remove(struct platform_device *pdev)
 	struct ep93xx_i2s_info *info = dev_get_drvdata(&pdev->dev);
 
 	snd_soc_unregister_component(&pdev->dev);
-	dev_set_drvdata(&pdev->dev, NULL);
 	clk_put(info->lrclk);
 	clk_put(info->sclk);
 	clk_put(info->mclk);
-- 
1.8.1.2
