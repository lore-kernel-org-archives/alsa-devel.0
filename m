From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: ep93xx_pcm: Fix compile error
Date: Wed,  3 Apr 2013 11:00:00 +0200
Message-ID: <1364979607-15286-2-git-send-email-lars@metafoo.de>
References: <1364979607-15286-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-091.synserver.de (smtp-out-217.synserver.de
 [212.40.185.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E484265321
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 10:00:57 +0200 (CEST)
In-Reply-To: <1364979607-15286-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Commit 453807f3 ("ASoC: ep93xx: Use ep93xx_dma_params instead of
ep93xx_pcm_dma_params") introduced a small compile error by not updating the
name of the 'dma_port' field to 'port'. This patch fixes it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/cirrus/ep93xx-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-i2s.c b/sound/soc/cirrus/ep93xx-i2s.c
index 3f2ad9c..5c1102e 100644
--- a/sound/soc/cirrus/ep93xx-i2s.c
+++ b/sound/soc/cirrus/ep93xx-i2s.c
@@ -67,12 +67,12 @@ struct ep93xx_i2s_info {
 struct ep93xx_dma_data ep93xx_i2s_dma_data[] = {
 	[SNDRV_PCM_STREAM_PLAYBACK] = {
 		.name		= "i2s-pcm-out",
-		.dma_port	= EP93XX_DMA_I2S1,
+		.port		= EP93XX_DMA_I2S1,
 		.direction	= DMA_MEM_TO_DEV,
 	},
 	[SNDRV_PCM_STREAM_CAPTURE] = {
 		.name		= "i2s-pcm-in",
-		.dma_port	= EP93XX_DMA_I2S1,
+		.port		= EP93XX_DMA_I2S1,
 		.direction	= DMA_DEV_TO_MEM,
 	},
 };
-- 
1.8.0
