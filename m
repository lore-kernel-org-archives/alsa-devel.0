From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: atmel: Use IS_ENABLED()
Date: Mon, 15 May 2017 11:32:01 +0200
Message-ID: <20170515093201.20813-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 60F9A266587
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:32:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

Simplify the ifdef conditions with IS_ENABLED() macro.
No functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/atmel/atmel-pcm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 6eaf081cad50..4b27aed40a51 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -83,8 +83,7 @@ struct atmel_pcm_dma_params {
 #define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
 #define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
 
-#if defined(CONFIG_SND_ATMEL_SOC_PDC) || \
-	defined(CONFIG_SND_ATMEL_SOC_PDC_MODULE)
+#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_PDC)
 int atmel_pcm_pdc_platform_register(struct device *dev);
 void atmel_pcm_pdc_platform_unregister(struct device *dev);
 #else
@@ -97,8 +96,7 @@ static inline void atmel_pcm_pdc_platform_unregister(struct device *dev)
 }
 #endif
 
-#if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
-	defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
+#if IS_ENABLED(CONFIG_SND_ATMEL_SOC_DMA)
 int atmel_pcm_dma_platform_register(struct device *dev);
 void atmel_pcm_dma_platform_unregister(struct device *dev);
 #else
-- 
2.12.2
