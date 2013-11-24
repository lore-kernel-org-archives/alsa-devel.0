From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/6] ASoC: atmel: Use
	devm_snd_dmaengine_pcm_register()
Date: Sun, 24 Nov 2013 14:20:58 +0100
Message-ID: <1385299262-24304-2-git-send-email-lars@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE6B261700
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:20:39 +0100 (CET)
In-Reply-To: <1385299262-24304-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Makes the code shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/atmel-pcm-dma.c | 8 +-------
 sound/soc/atmel/atmel-pcm.h     | 4 ----
 sound/soc/atmel/atmel_ssc_dai.c | 4 +---
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index 06082e5..7dbc0e9 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -129,17 +129,11 @@ static const struct snd_dmaengine_pcm_config atmel_dmaengine_pcm_config = {
 
 int atmel_pcm_dma_platform_register(struct device *dev)
 {
-	return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
+	return devm_snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
 			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
 }
 EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
 
-void atmel_pcm_dma_platform_unregister(struct device *dev)
-{
-	snd_dmaengine_pcm_unregister(dev);
-}
-EXPORT_SYMBOL(atmel_pcm_dma_platform_unregister);
-
 MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
 MODULE_DESCRIPTION("Atmel DMA based PCM module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 12ae814..bb71069 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -105,15 +105,11 @@ static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
 #if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
 	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
 int atmel_pcm_dma_platform_register(struct device *dev);
-void atmel_pcm_dma_platform_unregister(struct device *dev);
 #else
 static inline int atmel_pcm_dma_platform_register(struct device *dev)
 {
 	return 0;
 }
-static inline void atmel_pcm_dma_platform_unregister(struct device *dev)
-{
-}
 #endif
 
 #endif /* _ATMEL_PCM_H */
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 8697ced..13aaa7d 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -792,9 +792,7 @@ static void asoc_ssc_exit(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct ssc_device *ssc = platform_get_drvdata(pdev);
 
-	if (ssc->pdata->use_dma)
-		atmel_pcm_dma_platform_unregister(dev);
-	else
+	if (!ssc->pdata->use_dma)
 		atmel_pcm_pdc_platform_unregister(dev);
 
 	snd_soc_unregister_component(dev);
-- 
1.8.0
