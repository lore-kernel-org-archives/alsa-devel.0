From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 2/2] ASoC: imx-pcm-dma: open function failed
	when snd_dmaengine_pcm_open fail
Date: Tue, 18 Sep 2012 17:20:06 +0800
Message-ID: <1347960006-23681-2-git-send-email-richard.zhao@freescale.com>
References: <1347960006-23681-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id DC989262610
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 11:20:47 +0200 (CEST)
In-Reply-To: <1347960006-23681-1-git-send-email-richard.zhao@freescale.com>
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

snd_imx_open should return error code returned by snd_dmaengine_pcm_open.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/fsl/imx-pcm-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index a23505a..9a15bc4 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -120,7 +120,7 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	ret = snd_dmaengine_pcm_open(substream, filter, dma_data);
 	if (ret) {
 		kfree(dma_data);
-		return 0;
+		return ret;
 	}
 
 	snd_dmaengine_pcm_set_data(substream, dma_data);
-- 
1.7.9.5
