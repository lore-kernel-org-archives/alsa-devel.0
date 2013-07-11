From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/4] ASoC: omap-pcm: Request the DMA channel
	differently when DT is involved
Date: Thu, 11 Jul 2013 14:35:43 +0200
Message-ID: <1373546146-30271-2-git-send-email-peter.ujfalusi@ti.com>
References: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EB0826581A
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 14:35:51 +0200 (CEST)
In-Reply-To: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
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
get the DMA resource. In this case the DAI drivers will set the filter_data to
the name of the DMA and omap-pcm can use this to request the DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-pcm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index c28e042..a11405d 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -113,14 +113,25 @@ static int omap_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_dmaengine_dai_dma_data *dma_data;
+	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &omap_pcm_hardware);
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
-	return snd_dmaengine_pcm_open_request_chan(substream,
-						   omap_dma_filter_fn,
-						   dma_data->filter_data);
+	/* DT boot: filter_data is the DMA name */
+	if (rtd->cpu_dai->dev->of_node) {
+		struct dma_chan *chan;
+
+		chan = dma_request_slave_channel(rtd->cpu_dai->dev,
+						 dma_data->filter_data);
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
