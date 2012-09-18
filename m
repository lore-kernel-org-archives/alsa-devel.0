From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 1/2] ASoC: imx-pcm-dma: check kzalloc return
	value in function snd_imx_open
Date: Tue, 18 Sep 2012 17:20:05 +0800
Message-ID: <1347960006-23681-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 by alsa0.perex.cz (Postfix) with ESMTP id 8645C2625E1
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 11:19:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, shawn.guo@linaro.org, Richard Zhao <richard.zhao@freescale.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

It fixed smatch warning:
sound/soc/fsl/imx-pcm-dma.c:112 snd_imx_open() error: potential null dereference 'dma_data'.  (kzalloc returns null)

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/fsl/imx-pcm-dma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 48f9d88..a23505a 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -109,6 +109,9 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
+		return -ENOMEM;
+
 	dma_data->peripheral_type = dma_params->shared_peripheral ?
 					IMX_DMATYPE_SSI_SP : IMX_DMATYPE_SSI;
 	dma_data->priority = DMA_PRIO_HIGH;
-- 
1.7.9.5
