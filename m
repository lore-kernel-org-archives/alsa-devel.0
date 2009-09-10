From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] RFC: ASoC: Davinci: Fix data_type divide by
	zero
Date: Wed,  9 Sep 2009 18:57:10 -0700
Message-ID: <1252547830-16585-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-04.inet.qwest.net (mpls-qmqp-04.inet.qwest.net
	[63.231.195.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A8332456B
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 03:57:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: khilman@deeprootsystems.com, davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

This is a proposed fix for the data_type divide
by 0 error.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
This applies on top of my last patchset to Kevin's temp/asoc branch

 sound/soc/davinci/davinci-i2s.c   |   18 +++++++-----------
 sound/soc/davinci/davinci-mcasp.h |    7 ++++++-
 sound/soc/davinci/davinci-pcm.c   |   14 ++++++--------
 3 files changed, 19 insertions(+), 20 deletions(-)




diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 5f61016..252c3ea 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -123,13 +123,18 @@ static struct davinci_pcm_dma_params davinci_i2s_pcm_in = {
 };
 
 struct davinci_mcbsp_dev {
+	/*
+	 * dma_params must be first because rtd->dai->cpu_dai->private_data
+	 * is cast to an array of struct davinci_pcm_dma_params ** in
+	 * davinci_pcm_open.
+	 */
+	struct davinci_pcm_dma_params	*dma_params[2];
 	void __iomem			*base;
 #define MOD_DSP_A	0
 #define MOD_DSP_B	1
 	int				mode;
 	u32				pcr;
 	struct clk			*clk;
-	struct davinci_pcm_dma_params	*dma_params[2];
 	/*
 	 * Combining both channels into 1 element will at least double the
 	 * amount of time between servicing the dma channel, increase
@@ -255,14 +260,6 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
 	toggle_clock(dev, playback);
 }
 
-static int davinci_i2s_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *cpu_dai)
-{
-	struct davinci_mcbsp_dev *dev = cpu_dai->private_data;
-	cpu_dai->dma_data = dev->dma_params[substream->stream];
-	return 0;
-}
-
 #define DEFAULT_BITPERSAMPLE	16
 
 static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
@@ -393,7 +390,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct davinci_pcm_dma_params *dma_params = dai->dma_data;
 	struct davinci_mcbsp_dev *dev = dai->private_data;
 	struct snd_soc_dai *codec_dai = dev->codec_dai;
 	struct snd_interval *i = NULL;
@@ -407,6 +403,7 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	int right_first = 0;
 	int convert_mono_stereo = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ? 1 : 0;
+	struct davinci_pcm_dma_params *dma_params = dev->dma_params[substream->stream];
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 	bits_per_sample = snd_interval_value(i);
@@ -529,7 +526,6 @@ static void davinci_i2s_shutdown(struct snd_pcm_substream *substream,
 #define DAVINCI_I2S_RATES	SNDRV_PCM_RATE_8000_96000
 
 static struct snd_soc_dai_ops davinci_i2s_dai_ops = {
-	.startup 	= davinci_i2s_startup,
 	.shutdown	= davinci_i2s_shutdown,
 	.prepare	= davinci_i2s_prepare,
 	.trigger	= davinci_i2s_trigger,
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index 554354c..c6ea04d 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -39,10 +39,15 @@ enum {
 };
 
 struct davinci_audio_dev {
+	/*
+	 * dma_params must be first because rtd->dai->cpu_dai->private_data
+	 * is cast to an array of struct davinci_pcm_dma_params ** in
+	 * davinci_pcm_open.
+	 */
+	struct davinci_pcm_dma_params *dma_params[2];
 	void __iomem *base;
 	int sample_rate;
 	struct clk *clk;
-	struct davinci_pcm_dma_params *dma_params[2];
 	unsigned int codec_fmt;
 
 	/* McASP specific data */
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 2729a80..0bd3b2e 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -265,8 +265,7 @@ static int ping_pong_dma_setup(struct snd_pcm_substream *substream)
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	struct snd_dma_buffer *iram_dma =
 		(struct snd_dma_buffer *)substream->dma_buffer.private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params *dma_data = prtd->params;
 	unsigned int data_type = dma_data->data_type;
 	unsigned int acnt = dma_data->acnt;
 	unsigned int convert_mono_stereo = dma_data->convert_mono_stereo;
@@ -482,15 +481,12 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 {
 	struct snd_dma_buffer *iram_dma;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params *dma_data = prtd->params;
 	int link;
 
 	if (!dma_data)
 		return -ENODEV;
 
-	prtd->params = dma_data;
-
 	/* Request asp master DMA channel */
 	link = prtd->asp_channel = edma_alloc_channel(dma_data->channel,
 			davinci_pcm_dma_irq, substream, EVENTQ_0);
@@ -660,7 +656,8 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 static int davinci_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
+	struct davinci_pcm_dma_params **pa = rtd->dai->cpu_dai->private_data;
+	struct davinci_pcm_dma_params *dma_params = pa[substream->stream];
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd;
 	struct snd_pcm_hardware *ppcm;
@@ -668,7 +665,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 
 	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 			&pcm_hardware_playback : &pcm_hardware_capture;
-	allocate_sram(substream, dma_data->sram_size, ppcm);
+	allocate_sram(substream, dma_params->sram_size, ppcm);
 	snd_soc_set_runtime_hwparams(substream, ppcm);
 	/* ensure that buffer size is a multiple of period size */
 	ret = snd_pcm_hw_constraint_integer(runtime,
@@ -681,6 +678,7 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 
 	spin_lock_init(&prtd->lock);
+	prtd->params = dma_params;
 	prtd->asp_channel = -1;
 	prtd->asp_link[0] = prtd->asp_link[1] = -1;
 	prtd->ram_channel = -1;
-- 
1.5.6.3
