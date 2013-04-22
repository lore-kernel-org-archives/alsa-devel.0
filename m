From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: generic-dmaengine-pcm: use a more common
	dma name
Date: Mon, 22 Apr 2013 21:48:45 +0800
Message-ID: <1366638525-27625-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DCDA5261661
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 15:48:24 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The examples in Documentation/devicetree/bindings/dma/dma.txt recommends
the name for dma channel doing both RX and TX to be "rx-tx".  This
becomes a common pattern that has been adopted by platforms that
converts to generic DMA bindings.  Let's follow this common pattern in
generic-dmaengine-pcm.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5fd5ed4..98e1310 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -227,7 +227,7 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 		return;
 
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
-		pcm->chan[0] = of_dma_request_slave_channel(of_node, "tx_rx");
+		pcm->chan[0] = of_dma_request_slave_channel(of_node, "rx-tx");
 		pcm->chan[1] = pcm->chan[0];
 	} else {
 		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-- 
1.7.9.5
