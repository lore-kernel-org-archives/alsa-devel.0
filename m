From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai to
	snd_soc_pcm_stream
Date: Sat, 20 Mar 2010 16:39:20 +0100
Message-ID: <1269099560-29711-1-git-send-email-daniel@caiaq.de>
References: <20100320153022.GA32428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E2573244BE
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 16:39:47 +0100 (CET)
In-Reply-To: <20100320153022.GA32428@opensource.wolfsonmicro.com>
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

This fixes a memory corruption when ASoC devices are used in
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

This is a backported version for 2.6.34.

 include/sound/soc-dai.h           |   18 +++++++++++++++-
 include/sound/soc.h               |    1 +
 sound/soc/atmel/atmel-pcm.c       |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c   |    6 ++--
 sound/soc/davinci/davinci-i2s.c   |    3 +-
 sound/soc/davinci/davinci-mcasp.c |    3 +-
 sound/soc/davinci/davinci-pcm.c   |    4 ++-
 sound/soc/imx/imx-pcm-dma-mx2.c   |    8 +++++-
 sound/soc/imx/imx-ssi.c           |    7 ++++-
 sound/soc/omap/omap-mcbsp.c       |    4 ++-
 sound/soc/omap/omap-mcpdm.c       |    3 +-
 sound/soc/omap/omap-pcm.c         |    4 ++-
 sound/soc/pxa/pxa-ssp.c           |   23 +++++++++++----------
 sound/soc/pxa/pxa2xx-ac97.c       |   17 +++++++++++----
 sound/soc/pxa/pxa2xx-i2s.c        |    7 ++++-
 sound/soc/pxa/pxa2xx-pcm.c        |    4 ++-
 sound/soc/s3c24xx/s3c-ac97.c      |   21 +++++++++++--------
 sound/soc/s3c24xx/s3c-dma.c       |    4 ++-
 sound/soc/s3c24xx/s3c-i2s-v2.c    |   13 +++++++----
 sound/soc/s3c24xx/s3c-pcm.c       |    7 ++++-
 sound/soc/s3c24xx/s3c24xx-i2s.c   |   19 +++++++++--------
 sound/soc/s6000/s6000-i2s.c       |    3 +-
 sound/soc/s6000/s6000-pcm.c       |   40 ++++++++++++++++++++++++++----------
 23 files changed, 149 insertions(+), 72 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 061f16d..0a0b019 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -219,7 +219,6 @@ struct snd_soc_dai {
 	struct snd_soc_codec *codec;
 	unsigned int active;
 	unsigned char pop_wait:1;
-	void *dma_data;
 
 	/* DAI private data */
 	void *private_data;
@@ -230,4 +229,21 @@ struct snd_soc_dai {
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
index 5d234a8..a57fbfc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -375,6 +375,7 @@ struct snd_soc_pcm_stream {
 	unsigned int channels_min;	/* min channels */
 	unsigned int channels_max;	/* max channels */
 	unsigned int active:1;		/* stream is in use */
+	void *dma_data;			/* used by platform code */
 };
 
 /* SoC audio ops */
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 9ef6b96..3e6628c 100644
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
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 19452e4..c78c000 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -83,11 +83,13 @@ static void snd_imx_dma_err_callback(int channel, void *data, int err)
 static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
+	struct imx_pcm_dma_params *dma_params;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int ret;
 
+	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
+
 	iprtd->dma = imx_dma_request_by_prio(DRV_NAME, DMA_PRIO_HIGH);
 	if (iprtd->dma < 0) {
 		pr_err("Failed to claim the audio DMA\n");
@@ -192,10 +194,12 @@ static int snd_imx_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct imx_pcm_dma_params *dma_params = rtd->dai->cpu_dai->dma_data;
+	struct imx_pcm_dma_params *dma_params;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	int err;
 
+	dma_params = snd_soc_get_dma_data(rtd->dai->cpu_dai, substream);
+
 	iprtd->substream = substream;
 	iprtd->buf = (unsigned int *)substream->dma_buffer.area;
 	iprtd->period_cnt = 0;
diff --git a/sound/soc/imx/imx-ssi.c b/sound/soc/imx/imx-ssi.c
index 56f46a7..28e55c7 100644
--- a/sound/soc/imx/imx-ssi.c
+++ b/sound/soc/imx/imx-ssi.c
@@ -234,17 +234,20 @@ static int imx_ssi_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct imx_ssi *ssi = cpu_dai->private_data;
+	struct imx_pcm_dma_params *dma_data;
 	u32 reg, sccr;
 
 	/* Tx/Rx config */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		reg = SSI_STCCR;
-		cpu_dai->dma_data = &ssi->dma_params_tx;
+		dma_data = &ssi->dma_params_tx;
 	} else {
 		reg = SSI_SRCCR;
-		cpu_dai->dma_data = &ssi->dma_params_rx;
+		dma_data = &ssi->dma_params_rx;
 	}
 
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
+
 	sccr = readl(ssi->base + reg) & ~SSI_STCCR_WL_MASK;
 
 	/* DAI data (word) size */
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index e814a95..8ad9dc9 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -297,7 +297,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
 	omap_mcbsp_dai_dma_params[id][substream->stream].data_type =
 							OMAP_DMA_DATA_TYPE_S16;
-	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream,
+		&omap_mcbsp_dai_dma_params[id][substream->stream]);
 
 	if (mcbsp_data->configured) {
 		/* McBSP already configured by another stream */
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 25f19e4..b7f4f7e 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -150,7 +150,8 @@ static int omap_mcpdm_dai_hw_params(struct snd_pcm_substream *substream,
 	int stream = substream->stream;
 	int channels, err, link_mask = 0;
 
-	cpu_dai->dma_data = &omap_mcpdm_dai_dma_params[stream];
+	snd_soc_dai_set_dma_data(cpu_dai, substream,
+				 &omap_mcpdm_dai_dma_params[stream]);
 
 	channels = params_channels(params);
 	switch (channels) {
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
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index e9ae7b3..d314115 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -122,11 +122,14 @@ static int pxa2xx_ac97_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct pxa2xx_pcm_dma_params *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_out;
+		dma_data = &pxa2xx_ac97_pcm_stereo_out;
 	else
-		cpu_dai->dma_data = &pxa2xx_ac97_pcm_stereo_in;
+		dma_data = &pxa2xx_ac97_pcm_stereo_in;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	return 0;
 }
@@ -137,11 +140,14 @@ static int pxa2xx_ac97_hw_aux_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct pxa2xx_pcm_dma_params *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
+		dma_data = &pxa2xx_ac97_pcm_aux_mono_out;
 	else
-		cpu_dai->dma_data = &pxa2xx_ac97_pcm_aux_mono_in;
+		dma_data = &pxa2xx_ac97_pcm_aux_mono_in;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	return 0;
 }
@@ -156,7 +162,8 @@ static int pxa2xx_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 	else
-		cpu_dai->dma_data = &pxa2xx_ac97_pcm_mic_mono_in;
+		snd_soc_dai_set_dma_data(cpu_dai, substream,
+					 &pxa2xx_ac97_pcm_mic_mono_in);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 6b8f655..c1a5275 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -164,6 +164,7 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct pxa2xx_pcm_dma_params *dma_data;
 
 	BUG_ON(IS_ERR(clk_i2s));
 	clk_enable(clk_i2s);
@@ -171,9 +172,11 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	pxa_i2s_wait();
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_out;
+		dma_data = &pxa2xx_i2s_pcm_stereo_out;
 	else
-		cpu_dai->dma_data = &pxa2xx_i2s_pcm_stereo_in;
+		dma_data = &pxa2xx_i2s_pcm_stereo_in;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	/* is port used by another stream */
 	if (!(SACR0 & SACR0_ENB)) {
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
diff --git a/sound/soc/s3c24xx/s3c-ac97.c b/sound/soc/s3c24xx/s3c-ac97.c
index ee8ed9d..ecf4fd0 100644
--- a/sound/soc/s3c24xx/s3c-ac97.c
+++ b/sound/soc/s3c24xx/s3c-ac97.c
@@ -224,11 +224,14 @@ static int s3c_ac97_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct s3c_dma_params *dma_data;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_dai->dma_data = &s3c_ac97_pcm_out;
+		dma_data = &s3c_ac97_pcm_out;
 	else
-		cpu_dai->dma_data = &s3c_ac97_pcm_in;
+		dma_data = &s3c_ac97_pcm_in;
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream, dma_data);
 
 	return 0;
 }
@@ -238,8 +241,8 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->channel;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -265,7 +268,7 @@ static int s3c_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
 
 	return 0;
 }
@@ -280,7 +283,7 @@ static int s3c_ac97_hw_mic_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 	else
-		cpu_dai->dma_data = &s3c_ac97_mic_in;
+		snd_soc_dai_set_dma_data(cpu_dai, substream, &s3c_ac97_mic_in);
 
 	return 0;
 }
@@ -290,8 +293,8 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 {
 	u32 ac_glbctrl;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->channel;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	ac_glbctrl = readl(s3c_ac97.regs + S3C_AC97_GLBCTRL);
 	ac_glbctrl &= ~S3C_AC97_GLBCTRL_MICINTM_MASK;
@@ -311,7 +314,7 @@ static int s3c_ac97_mic_trigger(struct snd_pcm_substream *substream,
 
 	writel(ac_glbctrl, s3c_ac97.regs + S3C_AC97_GLBCTRL);
 
-	s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+	s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
 
 	return 0;
 }
diff --git a/sound/soc/s3c24xx/s3c-dma.c b/sound/soc/s3c24xx/s3c-dma.c
index 7725e26..1b61c23 100644
--- a/sound/soc/s3c24xx/s3c-dma.c
+++ b/sound/soc/s3c24xx/s3c-dma.c
@@ -145,10 +145,12 @@ static int s3c_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s3c24xx_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct s3c_dma_params *dma = rtd->dai->cpu_dai->dma_data;
 	unsigned long totbytes = params_buffer_bytes(params);
+	struct s3c_dma_params *dma =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 	int ret = 0;
 
+
 	pr_debug("Entered %s\n", __func__);
 
 	/* return if this is a bufferless transfer e.g.
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index e994d83..8851594 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -339,14 +339,17 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai_link *dai = rtd->dai;
 	struct s3c_i2sv2_info *i2s = to_info(dai->cpu_dai);
+	struct s3c_dma_params *dma_data;
 	u32 iismod;
 
 	pr_debug("Entered %s\n", __func__);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dai->cpu_dai->dma_data = i2s->dma_playback;
+		dma_data = i2s->dma_playback;
 	else
-		dai->cpu_dai->dma_data = i2s->dma_capture;
+		dma_data = i2s->dma_capture;
+
+	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
 
 	/* Working copies of register */
 	iismod = readl(i2s->regs + S3C2412_IISMOD);
@@ -394,8 +397,8 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
 	int ret = 0;
-	int channel = ((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->channel;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -431,7 +434,7 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		 * of the auto reload mechanism of S3C24XX.
 		 * This call won't bother S3C64XX.
 		 */
-		s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
 
 		break;
 
diff --git a/sound/soc/s3c24xx/s3c-pcm.c b/sound/soc/s3c24xx/s3c-pcm.c
index a98f40c..326f0a9 100644
--- a/sound/soc/s3c24xx/s3c-pcm.c
+++ b/sound/soc/s3c24xx/s3c-pcm.c
@@ -178,6 +178,7 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai_link *dai = rtd->dai;
 	struct s3c_pcm_info *pcm = to_info(dai->cpu_dai);
+	struct s3c_dma_params *dma_data;
 	void __iomem *regs = pcm->regs;
 	struct clk *clk;
 	int sclk_div, sync_div;
@@ -187,9 +188,11 @@ static int s3c_pcm_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(pcm->dev, "Entered %s\n", __func__);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dai->cpu_dai->dma_data = pcm->dma_playback;
+		dma_data = pcm->dma_playback;
 	else
-		dai->cpu_dai->dma_data = pcm->dma_capture;
+		dma_data = pcm->dma_capture;
+
+	snd_soc_dai_set_dma_data(dai->cpu_dai, substream, dma_data);
 
 	/* Strictly check for sample size */
 	switch (params_format(params)) {
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 0bc5950..c3ac890 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -242,14 +242,17 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct s3c_dma_params *dma_data;
 	u32 iismod;
 
 	pr_debug("Entered %s\n", __func__);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		rtd->dai->cpu_dai->dma_data = &s3c24xx_i2s_pcm_stereo_out;
+		dma_data = &s3c24xx_i2s_pcm_stereo_out;
 	else
-		rtd->dai->cpu_dai->dma_data = &s3c24xx_i2s_pcm_stereo_in;
+		dma_data = &s3c24xx_i2s_pcm_stereo_in;
+
+	snd_soc_dai_set_dma_data(rtd->dai->cpu_dai, substream, dma_data);
 
 	/* Working copies of register */
 	iismod = readl(s3c24xx_i2s.regs + S3C2410_IISMOD);
@@ -258,13 +261,11 @@ static int s3c24xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		iismod &= ~S3C2410_IISMOD_16BIT;
-		((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
+		dma_data->dma_size = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		iismod |= S3C2410_IISMOD_16BIT;
-		((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
+		dma_data->dma_size = 2;
 		break;
 	default:
 		return -EINVAL;
@@ -280,8 +281,8 @@ static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->channel;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -300,7 +301,7 @@ static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		else
 			s3c24xx_snd_txctrl(1);
 
-		s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
diff --git a/sound/soc/s6000/s6000-i2s.c b/sound/soc/s6000/s6000-i2s.c
index c5cda18..fa23854 100644
--- a/sound/soc/s6000/s6000-i2s.c
+++ b/sound/soc/s6000/s6000-i2s.c
@@ -518,7 +518,8 @@ static int __devinit s6000_i2s_probe(struct platform_device *pdev)
 
 	s6000_i2s_dai.dev = &pdev->dev;
 	s6000_i2s_dai.private_data = dev;
-	s6000_i2s_dai.dma_data = &dev->dma_params;
+	s6000_i2s_dai.capture.dma_data = &dev->dma_params;
+	s6000_i2s_dai.playback.dma_data = &dev->dma_params;
 
 	dev->sifbase = sifmem->start;
 	dev->scbbase = mmio;
diff --git a/sound/soc/s6000/s6000-pcm.c b/sound/soc/s6000/s6000-pcm.c
index 1d61109..9c7f7f0 100644
--- a/sound/soc/s6000/s6000-pcm.c
+++ b/sound/soc/s6000/s6000-pcm.c
@@ -58,13 +58,15 @@ static void s6000_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s6000_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	int channel;
 	unsigned int period_size;
 	unsigned int dma_offset;
 	dma_addr_t dma_pos;
 	dma_addr_t src, dst;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	period_size = snd_pcm_lib_period_bytes(substream);
 	dma_offset = prtd->period * period_size;
 	dma_pos = runtime->dma_addr + dma_offset;
@@ -101,7 +103,8 @@ static irqreturn_t s6000_pcm_irq(int irq, void *data)
 {
 	struct snd_pcm *pcm = data;
 	struct snd_soc_pcm_runtime *runtime = pcm->private_data;
-	struct s6000_pcm_dma_params *params = runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *params =
+		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
 	struct s6000_runtime_data *prtd;
 	unsigned int has_xrun;
 	int i, ret = IRQ_NONE;
@@ -172,11 +175,13 @@ static int s6000_pcm_start(struct snd_pcm_substream *substream)
 {
 	struct s6000_runtime_data *prtd = substream->runtime->private_data;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	unsigned long flags;
 	int srcinc;
 	u32 dma;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	spin_lock_irqsave(&prtd->lock, flags);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -212,10 +217,12 @@ static int s6000_pcm_stop(struct snd_pcm_substream *substream)
 {
 	struct s6000_runtime_data *prtd = substream->runtime->private_data;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	unsigned long flags;
 	u32 channel;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		channel = par->dma_out;
 	else
@@ -236,9 +243,11 @@ static int s6000_pcm_stop(struct snd_pcm_substream *substream)
 static int s6000_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	int ret;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	ret = par->trigger(substream, cmd, 0);
 	if (ret < 0)
 		return ret;
@@ -275,13 +284,15 @@ static int s6000_pcm_prepare(struct snd_pcm_substream *substream)
 static snd_pcm_uframes_t s6000_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s6000_runtime_data *prtd = runtime->private_data;
 	unsigned long flags;
 	unsigned int offset;
 	dma_addr_t count;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	spin_lock_irqsave(&prtd->lock, flags);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -305,11 +316,12 @@ static snd_pcm_uframes_t s6000_pcm_pointer(struct snd_pcm_substream *substream)
 static int s6000_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct s6000_runtime_data *prtd;
 	int ret;
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
 	snd_soc_set_runtime_hwparams(substream, &s6000_pcm_hardware);
 
 	ret = snd_pcm_hw_constraint_step(runtime, 0,
@@ -364,7 +376,7 @@ static int s6000_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par;
 	int ret;
 	ret = snd_pcm_lib_malloc_pages(substream,
 				       params_buffer_bytes(hw_params));
@@ -373,6 +385,8 @@ static int s6000_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	par = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	if (par->same_rate) {
 		spin_lock(&par->lock);
 		if (par->rate == -1 ||
@@ -392,7 +406,8 @@ static int s6000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int s6000_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct s6000_pcm_dma_params *par = soc_runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *par =
+		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
 
 	spin_lock(&par->lock);
 	par->in_use &= ~(1 << substream->stream);
@@ -417,7 +432,8 @@ static struct snd_pcm_ops s6000_pcm_ops = {
 static void s6000_pcm_free(struct snd_pcm *pcm)
 {
 	struct snd_soc_pcm_runtime *runtime = pcm->private_data;
-	struct s6000_pcm_dma_params *params = runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *params =
+		snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
 
 	free_irq(params->irq, pcm);
 	snd_pcm_lib_preallocate_free_for_all(pcm);
@@ -429,9 +445,11 @@ static int s6000_pcm_new(struct snd_card *card,
 			 struct snd_soc_dai *dai, struct snd_pcm *pcm)
 {
 	struct snd_soc_pcm_runtime *runtime = pcm->private_data;
-	struct s6000_pcm_dma_params *params = runtime->dai->cpu_dai->dma_data;
+	struct s6000_pcm_dma_params *params;
 	int res;
 
+	params = snd_soc_dai_get_dma_data(soc_runtime->dai->cpu_dai, substream);
+
 	if (!card->dev->dma_mask)
 		card->dev->dma_mask = &s6000_pcm_dmamask;
 	if (!card->dev->coherent_dma_mask)
-- 
1.7.0
