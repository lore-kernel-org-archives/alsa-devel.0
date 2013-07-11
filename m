From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/6] ASoC: omap-pcm: Request the DMA channel by
	name when dma_name is set for the dai
Date: Thu, 11 Jul 2013 12:18:46 +0200
Message-ID: <1373537930-10467-3-git-send-email-peter.ujfalusi@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 746112657B0
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:18:56 +0200 (CEST)
In-Reply-To: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

When booting with DT the platform_get_resource_byname() is not available to
get the DMA resource. In this case the DAI drivers will configure the dma_name
and omap-pcm can use this name to request the DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c28e042..00168ab 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -113,14 +113,24 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_dmaengine_dai_dma_data *dma_data;
+	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_open_request_chan(substream,
-						   omap_dma_filter_fn,
-						   dma_data->filter_data);
+	if (dma_data->dma_name) {
+		struct dma_chan *chan;
+
+		chan = dma_request_slave_channel(rtd->cpu_dai->dev,
+						 dma_data->dma_name);
+		ret = snd_dmaengine_pcm_open(substream, chan);
+	} else {
+		ret = snd_dmaengine_pcm_open_request_chan(substream,
+							  omap_dma_filter_fn,
+							  dma_data->filter_data);
+	}
+	return ret;
 }
 
 static int omap_pcm_mmap(struct snd_pcm_substream *substream,
-- 
1.8.2.1
