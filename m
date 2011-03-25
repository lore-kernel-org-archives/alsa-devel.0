From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/3] ASoC: imx: set watermarks for mx2-dma
Date: Fri, 25 Mar 2011 16:51:44 +0100
Message-ID: <1301068306-11997-2-git-send-email-w.sang@pengutronix.de>
References: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7BE8410380B
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 16:52:01 +0100 (CET)
In-Reply-To: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, open list <linux-kernel@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

They got accidently removed by f0fba2a (ASoC: multi-component - ASoC
Multi-Component Support). Reintroduce them and get rid of the
superfluous defines because the fiq-driver has its own hardcoded values.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/soc/imx/imx-pcm-dma-mx2.c |    5 +++++
 sound/soc/imx/imx-ssi.h         |    3 ---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 671ef8d..b2ed764 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -303,6 +303,11 @@ static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
 
 static int __devinit imx_soc_platform_probe(struct platform_device *pdev)
 {
+	struct imx_ssi *ssi = platform_get_drvdata(pdev);
+
+	ssi->dma_params_tx.burstsize = 6;
+	ssi->dma_params_rx.burstsize = 4;
+
 	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
 }
 
diff --git a/sound/soc/imx/imx-ssi.h b/sound/soc/imx/imx-ssi.h
index a4406a1..dc8a875 100644
--- a/sound/soc/imx/imx-ssi.h
+++ b/sound/soc/imx/imx-ssi.h
@@ -234,7 +234,4 @@ void imx_pcm_free(struct snd_pcm *pcm);
  */
 #define IMX_SSI_DMABUF_SIZE	(64 * 1024)
 
-#define DMA_RXFIFO_BURST      0x4
-#define DMA_TXFIFO_BURST      0x6
-
 #endif /* _IMX_SSI_H */
-- 
1.7.2.5
