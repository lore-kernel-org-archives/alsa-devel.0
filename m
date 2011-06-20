From: Sangbeom Kim <sbkim73@samsung.com>
Subject: [PATCH V3 3/4] ASoC: SAMSUNG: Modify I2S driver to
	support idma
Date: Mon, 20 Jun 2011 16:36:20 +0900
Message-ID: <1308555381-4419-3-git-send-email-sbkim73@samsung.com>
References: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AF09103843
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:46:24 +0200 (CEST)
In-Reply-To: <1308555381-4419-1-git-send-email-sbkim73@samsung.com>
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

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/i2s.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 1568eea..8b29c78 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -21,6 +21,7 @@
 #include <plat/audio.h>
 
 #include "dma.h"
+#include "idma.h"
 #include "i2s.h"
 #include "i2s-regs.h"
 
@@ -544,9 +545,12 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct i2s_dai *i2s = to_info(dai);
 	u32 mod = readl(i2s->addr + I2SMOD);
+	u32 ahb = 0;
 
 	if (!is_secondary(i2s))
 		mod &= ~(MOD_DC2_EN | MOD_DC1_EN);
+	else
+		ahb = readl(i2s->addr + I2SAHB);
 
 	switch (params_channels(params)) {
 	case 6:
@@ -600,6 +604,13 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 				params_format(params));
 		return -EINVAL;
 	}
+
+	if (is_secondary(i2s)) {
+		ahb |= (AHB_DMARLD | AHB_INTMASK);
+		mod |= MOD_TXS_IDMA;
+		writel(ahb, i2s->addr + I2SAHB);
+	}
+
 	writel(mod, i2s->addr + I2SMOD);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -1068,6 +1079,8 @@ static __devinit int samsung_i2s_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto err2;
 		}
+		idma_reg_addr_init((void *)ioremap(regs_base, 0x100),
+					i2s_cfg->idma_addr);
 		sec_dai->dma_playback.dma_addr = regs_base + I2STXDS;
 		sec_dai->dma_playback.client =
 			(struct s3c2410_dma_client *)&sec_dai->dma_playback;
-- 
1.7.1
