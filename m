From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: move dma_data from snd_soc_dai to
	snd_soc_pcm_stream
Date: Thu,  1 Apr 2010 19:18:07 +0200
Message-ID: <1270142287-23050-1-git-send-email-daniel@caiaq.de>
References: <20100320161428.GA1125@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 99BC81038B3
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 19:18:22 +0200 (CEST)
In-Reply-To: <20100320161428.GA1125@opensource.wolfsonmicro.com>
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

[Note that this is a backported version for 2.6.32.
 Upstream commit is fd23b7dee]

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Sven Neumann <s.neumann@raumfeld.com>
Cc: Michael Hirsch <m.hirsch@raumfeld.com>
Reported-by: Sven Neumann <s.neumann@raumfeld.com>
Reported-by: Michael Hirsch <m.hirsch@raumfeld.com>
---
 include/sound/soc-dai.h           |   18 +++++++++++++++-
 include/sound/soc.h               |    1 +
 sound/soc/atmel/atmel-pcm.c       |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c   |    6 ++--
 sound/soc/davinci/davinci-i2s.c   |    2 +
 sound/soc/davinci/davinci-mcasp.c |    2 +
 sound/soc/davinci/davinci-pcm.c   |   10 ++++++--
 sound/soc/omap/omap-mcbsp.c       |    4 ++-
 sound/soc/omap/omap-pcm.c         |    4 ++-
 sound/soc/pxa/pxa-ssp.c           |   23 +++++++++++----------
 sound/soc/pxa/pxa2xx-ac97.c       |   17 +++++++++++----
 sound/soc/pxa/pxa2xx-i2s.c        |    7 ++++-
 sound/soc/pxa/pxa2xx-pcm.c        |    4 ++-
 sound/soc/s3c24xx/s3c-i2s-v2.c    |   13 +++++++----
 sound/soc/s3c24xx/s3c24xx-i2s.c   |   19 +++++++++--------
 sound/soc/s6000/s6000-i2s.c       |    3 +-
 sound/soc/s6000/s6000-pcm.c       |   40 ++++++++++++++++++++++++++----------
 17 files changed, 120 insertions(+), 55 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 97ca9af..df6dbd5 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -209,7 +209,6 @@ struct snd_soc_dai {
 	struct snd_soc_codec *codec;
 	unsigned int active;
 	unsigned char pop_wait:1;
-	void *dma_data;
 
 	/* DAI private data */
 	void *private_data;
@@ -220,4 +219,21 @@ struct snd_soc_dai {
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
index 475cb7e..5962acc 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -353,6 +353,7 @@ struct snd_soc_pcm_stream {
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
index 4ae7070..1852b9f 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -547,6 +547,8 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
 
 	davinci_i2s_dai.private_data = dev;
+	davinci_i2s_dai.capture.dma_data = dev->dma_params;
+	davinci_i2s_dai.playback.dma_data = dev->dma_params;
 	ret = snd_soc_register_dai(&davinci_i2s_dai);
 	if (ret != 0)
 		goto err_free_mem;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5d1f98a..132a4eb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -907,6 +907,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	dma_data->channel = res->start;
 	davinci_mcasp_dai[pdata->op_mode].private_data = dev;
+	davinci_mcasp_dai[pdata->op_mode].capture.dma_data = dev->dma_params;
+	davinci_mcasp_dai[pdata->op_mode].playback.dma_data = dev->dma_params;
 	davinci_mcasp_dai[pdata->op_mode].dev = &pdev->dev;
 	ret = snd_soc_register_dai(&davinci_mcasp_dai[pdata->op_mode]);
 
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index c73a915..caa85f7 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -238,11 +238,15 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	struct davinci_runtime_data *prtd;
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *pa = rtd->dai->cpu_dai->private_data;
-	struct davinci_pcm_dma_params *params = &pa[substream->stream];
-	if (!params)
+	struct davinci_pcm_dma_params *pa;
+	struct davinci_pcm_dma_params *params;
+
+	pa = snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
+	if (!pa)
 		return -ENODEV;
 
+	params = &pa[substream->stream];
+
 	snd_soc_set_runtime_hwparams(substream, &davinci_pcm_hardware);
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3341f49..efd5e6f 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -285,7 +285,9 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	omap_mcbsp_dai_dma_params[id][substream->stream].dma_req = dma;
 	omap_mcbsp_dai_dma_params[id][substream->stream].port_addr = port;
 	omap_mcbsp_dai_dma_params[id][substream->stream].sync_mode = sync_mode;
-	cpu_dai->dma_data = &omap_mcbsp_dai_dma_params[id][substream->stream];
+
+	snd_soc_dai_set_dma_data(cpu_dai, substream,
+		&omap_mcbsp_dai_dma_params[id][substream->stream]);
 
 	if (mcbsp_data->configured) {
 		/* McBSP already configured by another stream */
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6a829ee..448f3cc 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -99,9 +99,11 @@ static int omap_pcm_hw_params(struct snd_pcm_substream *substream,
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
index d11a6d7..cdffb3a 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -103,10 +103,9 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		ssp_disable(&priv->dev);
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
 
@@ -122,10 +121,8 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		clk_disable(priv->dev.ssp->clk);
 	}
 
-	if (cpu_dai->dma_data) {
-		kfree(cpu_dai->dma_data);
-		cpu_dai->dma_data = NULL;
-	}
+	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
+	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
 }
 
 #ifdef CONFIG_PM
@@ -536,19 +533,23 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
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
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 9bc4aa3..5dbf81d 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -337,14 +337,17 @@ static int s3c2412_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -392,8 +395,8 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	int capture = (substream->stream == SNDRV_PCM_STREAM_CAPTURE);
 	unsigned long irqs;
 	int ret = 0;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->channel;
+	struct s3c_dma_params *dma_data =
+		snd_soc_dai_get_dma_data(rtd->dai->cpu_dai, substream);
 
 	pr_debug("Entered %s\n", __func__);
 
@@ -429,7 +432,7 @@ static int s3c2412_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		 * of the auto reload mechanism of S3C24XX.
 		 * This call won't bother S3C64XX.
 		 */
-		s3c2410_dma_ctrl(channel, S3C2410_DMAOP_STARTED);
+		s3c2410_dma_ctrl(dma_data->channel, S3C2410_DMAOP_STARTED);
 
 		break;
 
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 40e2c47..d2ab0b7 100644
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
-		((struct s3c24xx_pcm_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->dma_size = 1;
+		dma_data->dma_size = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		iismod |= S3C2410_IISMOD_16BIT;
-		((struct s3c24xx_pcm_dma_params *)
-		  rtd->dai->cpu_dai->dma_data)->dma_size = 2;
+		dma_data->dma_size = 2;
 		break;
 	default:
 		return -EINVAL;
@@ -280,8 +281,8 @@ static int s3c24xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	int ret = 0;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int channel = ((struct s3c24xx_pcm_dma_params *)
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
index 83b8028..b14a02d 100644
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
1.7.0.3
