From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai to
	snd_soc_pcm_stream
Date: Thu, 18 Mar 2010 19:08:59 +0100
Message-ID: <1268935739-2931-1-git-send-email-daniel@caiaq.de>
References: <1268933737.3773.36.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DB6E103874
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 19:09:14 +0100 (CET)
In-Reply-To: <1268933737.3773.36.camel@odin>
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
Cc: Michael Hirsch <m.hirsch@raumfeld.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This fixes a memory corruption when using ASoC devices are used in
full-duplex mode. Specifically for pxa-ssp code, where this pointer
is dynamically allocated for each direction and destroyed upon each
stream start.

All other platforms are fixed blindly, I couldn't even compile-test
them. Sorry for any breakage I may have caused.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Michael Hirsch <m.hirsch@raumfeld.com>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Reported-by: Michael Hirsch <m.hirsch@raumfeld.com>
---
 include/sound/soc-dai.h           |   18 +++++++++++++++++-
 include/sound/soc.h               |    1 +
 sound/soc/atmel/atmel-pcm.c       |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c   |    6 +++---
 sound/soc/davinci/davinci-i2s.c   |    3 ++-
 sound/soc/davinci/davinci-mcasp.c |    3 ++-
 sound/soc/davinci/davinci-pcm.c   |    4 +++-
 sound/soc/omap/omap-mcbsp.c       |    4 +++-
 sound/soc/omap/omap-pcm.c         |    4 +++-
 sound/soc/pxa/pxa-ssp.c           |   23 ++++++++++++-----------
 sound/soc/pxa/pxa2xx-pcm.c        |    4 +++-
 11 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 6cf76a4..377693a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -224,7 +224,6 @@ struct snd_soc_dai {
 	struct snd_soc_codec *codec;
 	unsigned int active;
 	unsigned char pop_wait:1;
-	void *dma_data;
 
 	/* DAI private data */
 	void *private_data;
@@ -235,4 +234,21 @@ struct snd_soc_dai {
 	struct list_head list;
 };
 
+static inline void *snd_soc_dai_get_dma_data(const struct snd_soc_dai *dai,
+					     const struct snd_pcm_substream *ss)
+{
+	return (ss->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		dai->playback.dma_data : dai->capture.dma_data;
+}
+
+static inline void snd_soc_dai_set_dma_data(struct snd_soc_dai *dai,
+					    const struct snd_pcm_substream *ss,
+					    void *data)
+{
+	if (ss->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dai->playback.dma_data = data;
+	else
+		dai->capture.dma_data = data;
+}
+
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index dbfec16..b8bac6a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -376,6 +376,7 @@ struct snd_soc_pcm_stream {
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	unsigned int active;		/* num of active users of the stream */
+	void *dma_data;			/* used by platform code */
 };
 
 /* SoC audio ops */
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index fdb2553..f6b3cc0 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -180,7 +180,7 @@ static int atmel_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	runtime->dma_bytes = params_buffer_bytes(params);
 
-	prtd->params = rtd->dai->cpu_dai->dma_data;
+	prtd->params = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 	prtd->params->dma_intr_handler = atmel_pcm_dma_irq;
 
 	prtd->dma_buffer = runtime->dma_addr;
diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index e588e63..0b59806 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -363,12 +363,12 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 	ssc_p->dma_params[dir] = dma_params;
 
 	/*
-	 * The cpu_dai->dma_data field is only used to communicate the
-	 * appropriate DMA parameters to the pcm driver hw_params()
+	 * The snd_soc_pcm_stream->dma_data field is only used to communicate
+	 * the appropriate DMA parameters to the pcm driver hw_params()
 	 * function.  It should not be used for other purposes
 	 * as it is common to all substreams.
 	 */
-	rtd->dai->cpu_dai->dma_data = dma_params;
+	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_params);
 
 	channels = params_channels(params);
 
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 6362ca0..4aad7ec 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -585,7 +585,8 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 
 	davinci_i2s_dai.private_data = dev;
-	davinci_i2s_dai.dma_data = dev->dma_params;
+	davinci_i2s_dai.capture.dma_data = dev->dma_params;
+	davinci_i2s_dai.playback.dma_data = dev->dma_params;
 	ret = snd_soc_register_dai(&davinci_i2s_dai);
 	if (ret != 0)
 		goto err_free_mem;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ab6518d..c056bfb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -917,7 +917,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	dma_data->channel = res->start;
 	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
-	davinci_mcasp_dai[pdata->op_mode].dma_data = dev->dma_params;
+	davinci_mcasp_dai[pdata->op_mode].capture.dma_data = dev->dma_params;
+	davinci_mcasp_dai[pdata->op_mode].playback.dma_data = dev->dma_params;
 	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
 	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 80c7fdf..2dc406f 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -649,8 +649,10 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_hardware *ppcm;
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params *pa;
 	struct davinci_pcm_dma_params *params;
+
+	pa = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 	if (!pa)
 		return -ENODEV;
 	params = &pa[substream->stream];
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2952fb0..e21a3e5 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -322,7 +322,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
 	omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
 							OMAP_DMA_DATA_TYPE_S16;
-	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream,
+		&omap_mcbsp_dai_dma_params[id][substream->stream]);
 
 	if (mcbsp_data->configured) {
 		/* McBSP already configured by another stream */
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 825db38..39538c0 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -100,9 +100,11 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct omap_runtime_data *prtd = runtime->private_data;
-	struct omap_pcm_dma_data *dma_data = rtd->dai->cpu_dai->dma_data;
+	struct omap_pcm_dma_data *dma_data;
 	int err = 0;
 
+	dma_data = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
 	if (!dma_data)
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 9e95e51..6959c51 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -121,10 +121,9 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		ssp_disable(ssp);
 	}
 
-	if (cpu_dai->dma_data) {
-		kfree(cpu_dai->dma_data);
-		cpu_dai->dma_data = NULL;
-	}
+	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
+	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
+
 	return ret;
 }
 
@@ -141,10 +140,8 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		clk_disable(ssp->clk);
 	}
 
-	if (cpu_dai->dma_data) {
-		kfree(cpu_dai->dma_data);
-		cpu_dai->dma_data = NULL;
-	}
+	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
+	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -569,19 +566,23 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	u32 sspsp;
 	int width = snd_pcm_format_physical_width(params_format(params));
 	int ttsa = ssp_read_reg(ssp, SSTSA) & 0xf;
+	struct pxa2xx_pcm_dma_params *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 
 	/* generate correct DMA params */
-	if (cpu_dai->dma_data)
-		kfree(cpu_dai->dma_data);
+	kfree(dma_data);
 
 	/* Network mode with one active slot (ttsa == 1) can be used
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	cpu_dai->dma_data = ssp_get_dma_params(ssp,
+	dma_data = ssp_get_dma_params(ssp,
 			((chn == 2) && (ttsa != 1)) || (width == 32),
 			substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 
+	snd_soc_dai_set_dma_data(dai, substream, dma_data);
+
 	/* we can only change the settings if the port is not in use */
 	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
 		return 0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index d38e395..adc7e6f 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -25,9 +25,11 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct pxa2xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct pxa2xx_pcm_dma_params *dma = rtd->dai->cpu_dai->dma_data;
+	struct pxa2xx_pcm_dma_params *dma;
 	int ret;
 
+	dma = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+
 	/* return if this is a bufferless transfer e.g.
 	 * codec <--> BT codec or GSM modem -- lg FIXME */
 	if (!dma)
-- 
1.6.6.2
