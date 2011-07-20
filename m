From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [REPOST][PATCH v4 3/4] ASoC: SAMSUNG: Modify I2S
	driver to support idma
Date: Wed, 20 Jul 2011 17:07:12 +0900
Message-ID: <1311149233-24343-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id C0315103888
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 10:18:01 +0200 (CEST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, jassisinghbrar@gmail.com, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Previously, I2S driver only can support system dma.
In this patch, i2s driver can support internal dma too.
IDMA h/w configuration is initialized on idma.c

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
As Mark brown request, I repost i2s v4 patch

 sound/soc/samsung/i2s.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 1568eea..c086b78 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -21,6 +21,7 @@
 #include <plat/audio.h>
 
 #include "dma.h"
+#include "idma.h"
 #include "i2s.h"
 #include "i2s-regs.h"
 
@@ -60,6 +61,7 @@ struct i2s_dai {
 	/* DMA parameters */
 	struct s3c_dma_params dma_playback;
 	struct s3c_dma_params dma_capture;
+	struct s3c_dma_params idma_playback;
 	u32	quirks;
 	u32	suspend_i2smod;
 	u32	suspend_i2scon;
@@ -877,6 +879,10 @@ static int samsung_i2s_dai_probe(struct snd_soc_dai *dai)
 	if (i2s->quirks & QUIRK_NEED_RSTCLR)
 		writel(CON_RSTCLR, i2s->addr + I2SCON);
 
+	if (i2s->quirks & QUIRK_SEC_DAI)
+		idma_reg_addr_init((void *)i2s->addr,
+					i2s->sec_dai->idma_playback.dma_addr);
+
 probe_exit:
 	/* Reset any constraint on RFS and BFS */
 	i2s->rfs = 0;
@@ -1077,6 +1083,7 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 		sec_dai->dma_playback.dma_size = 4;
 		sec_dai->base = regs_base;
 		sec_dai->quirks = quirks;
+		sec_dai->idma_playback.dma_addr = i2s_cfg->idma_addr;
 		sec_dai->pri_dai = pri_dai;
 		pri_dai->sec_dai = sec_dai;
 	}
-- 
1.7.1
