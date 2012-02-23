From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/4] ASoC: imx: initialize dma_params burstsize
	just in imx-ssi
Date: Thu, 23 Feb 2012 14:47:23 +0800
Message-ID: <1329979644-31046-3-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7983C10402F
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:34:11 +0100 (CET)
Received: by mail-pz0-f51.google.com with SMTP id y9so1003556dad.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 22:34:11 -0800 (PST)
In-Reply-To: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

It's not necessary for imx-pcm-dma-mx2 to access imx_ssi.dma_params
for burstsize initialization.  Instead, it can just be done in imx-ssi
probe function once.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    5 -----
 sound/soc/imx/imx-ssi.c         |    2 +-
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index f974e61..1737141 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -271,11 +271,6 @@ static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 
 static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
-	struct imx_ssi *ssi = platform_get_drvdata(pdev);
-
-	ssi->dma_params_tx.burstsize = 6;
-	ssi->dma_params_rx.burstsize = 4;
-
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
 
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index dbf43f5..25c6231 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -668,7 +668,7 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	ssi->dma_params_rx.dma_addr = res->start + SSI_SRX0;
 	ssi->dma_params_tx.dma_addr = res->start + SSI_STX0;
 
-	ssi->dma_params_tx.burstsize = 4;
+	ssi->dma_params_tx.burstsize = 6;
 	ssi->dma_params_rx.burstsize = 4;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx0");
-- 
1.7.5.4
