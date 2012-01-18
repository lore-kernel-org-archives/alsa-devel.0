From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 6/7] ASoC: SIU: prepare for conversion to simple DMA
Date: Wed, 18 Jan 2012 11:22:37 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201181117590.28782@axis700.grange>
References: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/siu_pcm.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index f8f6816..6390fec 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -330,12 +330,12 @@ static bool filter(struct dma_chan *chan, void *slave)
 {
 	struct sh_dmae_slave *param = slave;
 
-	pr_debug("%s: slave ID %d\n", __func__, param->slave_id);
+	pr_debug("%s: slave ID %d\n", __func__, param->simple_slave.slave_id);
 
 	if (unlikely(param->dma_dev != chan->device->dev))
 		return false;
 
-	chan->private = param;
+	chan->private = &param->simple_slave;
 	return true;
 }
 
@@ -360,12 +360,12 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		siu_stream = &port_info->playback;
 		param = &siu_stream->param;
-		param->slave_id = port ? pdata->dma_slave_tx_b :
+		param->simple_slave.slave_id = port ? pdata->dma_slave_tx_b :
 			pdata->dma_slave_tx_a;
 	} else {
 		siu_stream = &port_info->capture;
 		param = &siu_stream->param;
-		param->slave_id = port ? pdata->dma_slave_rx_b :
+		param->simple_slave.slave_id = port ? pdata->dma_slave_rx_b :
 			pdata->dma_slave_rx_a;
 	}
 
-- 
1.7.2.5
