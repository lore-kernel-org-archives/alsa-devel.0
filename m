From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix __iomem annotation for IDMA registers
Date: Sun, 27 Nov 2011 21:36:09 +0000
Message-ID: <1322429769-1045-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0571103807
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 22:36:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We always store the register address as __iomem but pass it around as a
plain void * which upsets sparse.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/i2s.c  |    2 +-
 sound/soc/samsung/idma.c |    2 +-
 sound/soc/samsung/idma.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index fb80f28..5de500c 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -881,7 +881,7 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 		writel(CON_RSTCLR, i2s->addr + I2SCON);
 
 	if (i2s->quirks & QUIRK_SEC_DAI)
-		idma_reg_addr_init((void *)i2s->addr,
+		idma_reg_addr_init(i2s->addr,
 					i2s->sec_dai->idma_playback.dma_addr);
 
 probe_exit:
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 6ca3d8c..baf97eb 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -403,7 +403,7 @@ static int idma_new(struct snd_soc_pcm_runtime *rtd)
 	return ret;
 }
 
-void idma_reg_addr_init(void *regs, dma_addr_t addr)
+void idma_reg_addr_init(void __iomem *regs, dma_addr_t addr)
 {
 	spin_lock_init(&idma.lock);
 	idma.regs = regs;
diff --git a/sound/soc/samsung/idma.h b/sound/soc/samsung/idma.h
index 4827321..8644946 100644
--- a/sound/soc/samsung/idma.h
+++ b/sound/soc/samsung/idma.h
@@ -14,7 +14,7 @@
 #ifndef __SND_SOC_SAMSUNG_IDMA_H_
 #define __SND_SOC_SAMSUNG_IDMA_H_
 
-extern void idma_reg_addr_init(void *regs, dma_addr_t addr);
+extern void idma_reg_addr_init(void __iomem *regs, dma_addr_t addr);
 
 /* dma_state */
 #define LPAM_DMA_STOP	0
-- 
1.7.7.3
