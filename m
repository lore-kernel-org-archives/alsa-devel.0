From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 3/5] ASoC: fsl: create function
	imx_pcm_fiq_exit()
Date: Thu, 25 Apr 2013 11:18:48 +0800
Message-ID: <1366859930-1232-4-git-send-email-shawn.guo@linaro.org>
References: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D8BA9265CE6
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 05:19:09 +0200 (CEST)
In-Reply-To: <1366859930-1232-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Create function imx_pcm_fiq_exit() to be paired with imx_pcm_fiq_init()
just like the pair of imx_pcm_dma_init() and imx_pcm_dma_exit().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/imx-pcm-fiq.c |    5 +++++
 sound/soc/fsl/imx-pcm.c     |    2 +-
 sound/soc/fsl/imx-pcm.h     |    5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 670b96b..710c069 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -314,3 +314,8 @@ failed_register:
 
 	return ret;
 }
+
+void imx_pcm_fiq_exit(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+}
diff --git a/sound/soc/fsl/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
index c498964..16a956b 100644
--- a/sound/soc/fsl/imx-pcm.c
+++ b/sound/soc/fsl/imx-pcm.c
@@ -115,7 +115,7 @@ static int imx_pcm_probe(struct platform_device *pdev)
 static int imx_pcm_remove(struct platform_device *pdev)
 {
 	if (strcmp(pdev->id_entry->name, "imx-fiq-pcm-audio") == 0)
-		snd_soc_unregister_platform(&pdev->dev);
+		imx_pcm_fiq_exit(pdev);
 	else
 		imx_pcm_dma_exit(pdev);
 
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index b7fa0d7..073bf38 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -53,11 +53,16 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
 
 #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
 int imx_pcm_fiq_init(struct platform_device *pdev);
+void imx_pcm_fiq_exit(struct platform_device *pdev);
 #else
 static inline int imx_pcm_fiq_init(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
+
+static inline void imx_pcm_fiq_exit(struct platform_device *pdev)
+{
+}
 #endif
 
 #endif /* _IMX_PCM_H */
-- 
1.7.9.5
