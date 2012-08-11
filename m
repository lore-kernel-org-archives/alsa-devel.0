From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2.1-CA0132 HDA Codec 2/2] Add DSP loader code
	to CA0132 codec
Date: Fri, 10 Aug 2012 23:17:52 -0700
Message-ID: <1344665872-15537-2-git-send-email-ian_minett@creativelabs.com>
References: <s5h7gt9hmpe.wl%tiwai@suse.de>
 <1344665872-15537-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1344665872-15537-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Draft patch to add new DSP loader code, with calls to load_dsp_xxxx() functions.
 

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 825f5b4..45dce9c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1952,22 +1952,13 @@ struct dma_engine {
 	unsigned short m_converter_format;
 	void         *m_buffer_addr;
 	unsigned int m_buffer_size;
-	unsigned int m_req_size;
-	struct snd_pcm_substream *substream;
 };
 
 enum dma_state {
-	DMA_STATE_RESET = 0,
-	DMA_STATE_STOP  = 1,
-	DMA_STATE_RUN   = 2
+	DMA_STATE_STOP  = 0,
+	DMA_STATE_RUN   = 1
 };
 
-#define azx_pcm_open(a)       (a->ops->open(a))
-#define azx_pcm_close(a)      (a->ops->close(a))
-#define azx_pcm_prepare(a)    (a->ops->prepare(a))
-#define azx_pcm_trigger(a, b) (a->ops->trigger(a, b))
-#define azx_pcm_hw_free(a)    (a->ops->hw_free(a))
-
 static int dma_convert_to_hda_format(
 		struct hda_stream_format *stream_format,
 		unsigned short *hda_format)
@@ -1986,113 +1977,6 @@ static int dma_convert_to_hda_format(
 	return 0;
 }
 
-static int dma_init(
-		struct hda_codec *codec,
-		struct dma_engine **pp_dma,
-		struct hda_stream_format *stream_format,
-		unsigned short *format,
-		unsigned int req_size)
-{
-	struct dma_engine *dma;
-	struct snd_pcm_substream *substream;
-	struct snd_pcm *pcm;
-	struct snd_pcm_runtime *runtime;
-	unsigned int bits;
-	snd_pcm_uframes_t frames;
-
-	*pp_dma = NULL;
-	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
-	memset((void *)dma, 0, sizeof(*dma));
-
-	dma_convert_to_hda_format(stream_format, format);
-	dma->m_converter_format = *format;
-
-	dma->substream = NULL;
-	pcm = codec->pcm_info->pcm;
-	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
-				substream; substream = substream->next) {
-		if (codec->pcm_info->pcm_type == HDA_PCM_TYPE_SPDIF)
-			continue;
-
-		if (!SUBSTREAM_BUSY(substream)) {
-			dma->substream = substream;
-			break;
-		}
-	}
-
-	if (NULL == dma->substream) {
-		kfree(dma);
-		return -1;
-	}
-
-	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
-	memset((void *)runtime, 0, sizeof(*runtime));
-	dma->substream->runtime = runtime;
-	dma->substream->private_data = pcm->private_data;
-
-	azx_pcm_open(dma->substream);
-	req_size = req_size * 2;
-	snd_pcm_lib_malloc_pages(dma->substream, req_size);
-
-	runtime->rate = stream_format->sample_rate;
-	runtime->channels = stream_format->number_channels;
-	runtime->format = SNDRV_PCM_FORMAT_S32_LE;
-	runtime->no_period_wakeup = 1;
-
-	bits = snd_pcm_format_physical_width(runtime->format);
-	runtime->sample_bits = bits;
-	bits *= runtime->channels;
-	runtime->frame_bits = bits;
-	frames = 1;
-	while (bits % 8 != 0) {
-		bits *= 2;
-		frames *= 2;
-	}
-	runtime->byte_align = bits / 8;
-	runtime->min_align = frames;
-	runtime->buffer_size = bytes_to_frames(runtime, req_size);
-	runtime->period_size = runtime->buffer_size;
-	dma->m_req_size = req_size;
-	dma->codec = codec;
-
-	*pp_dma = dma;
-	CA0132_LOG("dma_init: succeeded.\n");
-	return 0;
-}
-
-static int dma_prepare(struct dma_engine *dma)
-{
-	struct snd_pcm_runtime *runtime;
-	int err;
-
-	CA0132_LOG("dma_prepare: begin\n");
-	runtime = dma->substream->runtime;
-
-	err = azx_pcm_prepare(dma->substream);
-	if (err < 0)
-		return -1;
-
-	dma->m_buffer_size = snd_pcm_lib_buffer_bytes(dma->substream);
-	dma->m_buffer_addr = runtime->dma_area;
-
-	return 0;
-}
-
-static int dma_reset(struct dma_engine *dma)
-{
-	struct snd_pcm_runtime *runtime = dma->substream->runtime;
-
-	CA0132_LOG("dma_reset: begin\n");
-	azx_pcm_hw_free(dma->substream);
-	snd_pcm_lib_malloc_pages(dma->substream, dma->m_req_size);
-
-	azx_pcm_prepare(dma->substream);
-	dma->m_buffer_size = snd_pcm_lib_buffer_bytes(dma->substream);
-	dma->m_buffer_addr = runtime->dma_area;
-
-	return 0;
-}
-
 static int dma_set_state(struct dma_engine *dma, enum dma_state state)
 {
 	int cmd;
@@ -2100,9 +1984,6 @@ static int dma_set_state(struct dma_engine *dma, enum dma_state state)
 	CA0132_LOG("dma_set_state state=%d\n", state);
 
 	switch (state) {
-	case DMA_STATE_RESET:
-		dma_reset(dma);
-		return 0;
 	case DMA_STATE_STOP:
 		cmd = SNDRV_PCM_TRIGGER_STOP;
 		break;
@@ -2113,9 +1994,7 @@ static int dma_set_state(struct dma_engine *dma, enum dma_state state)
 		return 0;
 	}
 
-	azx_pcm_trigger(dma->substream, cmd);
-
-	return 0;
+	return load_dsp_trigger(dma->codec->bus, cmd);
 }
 
 static unsigned int dma_get_buffer_size(struct dma_engine *dma)
@@ -2128,15 +2007,6 @@ static unsigned int *dma_get_buffer_addr(struct dma_engine *dma)
 	return dma->m_buffer_addr;
 }
 
-static int dma_free_buffer(struct dma_engine *dma)
-{
-	azx_pcm_hw_free(dma->substream);
-	azx_pcm_close(dma->substream);
-	kfree(dma->substream->runtime);
-	dma->substream->runtime = NULL;
-	return 0;
-}
-
 static int dma_xfer(struct dma_engine *dma,
 		const unsigned int *data,
 		unsigned int count)
@@ -2160,13 +2030,6 @@ static unsigned int dma_get_stream_id(struct dma_engine *dma)
 	return spec->dsp_stream_id;
 }
 
-static int dma_exit(struct dma_engine *dma)
-{
-	CA0132_LOG("dma_exit\n");
-	kfree(dma);
-	return 0;
-}
-
 /*
  * CA0132 chip DSP image segment stuffs
  */
@@ -2384,7 +2247,6 @@ static int dspxfr_one_seg(struct hda_codec *codec,
 			}
 			CA0132_DSP_LOG("+++++ DMA complete");
 			dma_set_state(dma_engine, DMA_STATE_STOP);
-			dma_set_state(dma_engine, DMA_STATE_RESET);
 		}
 
 		CTASSERT(run_size_words <= words_to_write);
@@ -2413,17 +2275,29 @@ static int dspxfr_image(struct hda_codec *codec,
 	struct dma_engine *dma_engine;
 	unsigned int dma_chan;
 	unsigned int port_map_mask;
-	unsigned int buf_size;
 
 	CTASSERT(fls_data != NULL);
 	if (fls_data == NULL)
 		return -1;
 
-	buf_size = ovly ? DSP_DMA_WRITE_BUFLEN_OVLY : DSP_DMA_WRITE_BUFLEN_INIT;
-	status = dma_init(codec, &dma_engine, format, &hda_format, buf_size);
-
-	if (FAILED(status))
-		return -1;
+	dma_engine = kzalloc(sizeof(*dma_engine), GFP_KERNEL);
+	if (!dma_engine) {
+		status = -ENOMEM;
+		goto exit;
+	}
+	memset((void*)dma_engine, 0, sizeof(*dma_engine));
+	
+	dma_engine->codec = codec;
+	dma_convert_to_hda_format(format, &hda_format);
+	dma_engine->m_converter_format = hda_format;
+	dma_engine->m_buffer_size =
+	      ovly ? DSP_DMA_WRITE_BUFLEN_OVLY : DSP_DMA_WRITE_BUFLEN_INIT;
+	dma_engine->m_buffer_addr = kzalloc(dma_engine->m_buffer_size,
+					    GFP_KERNEL);
+	if (!dma_engine->m_buffer_addr) {
+		status = -ENOMEM;
+		goto exit;
+	}
 
 	dma_chan = 0;
 	do {
@@ -2434,7 +2308,10 @@ static int dspxfr_image(struct hda_codec *codec,
 			break;
 		}
 
-		status = dma_prepare(dma_engine);
+		status = load_dsp_prepare(codec->bus, 
+					 dma_engine->m_converter_format,
+					 dma_engine->m_buffer_addr,
+					 dma_engine->m_buffer_size);
 		if (FAILED(status))
 			break;
 
@@ -2495,15 +2372,9 @@ static int dspxfr_image(struct hda_codec *codec,
 	if (ovly && (dma_chan != INVALID_DMA_CHANNEL))
 		status = dspio_free_dma_chan(codec, dma_chan);
 
-	status = dma_set_state(dma_engine, DMA_STATE_RESET);
-	if (FAILED(status))
-		status = FAIL_MSG(status, "dma set state Reset fail");
-
-	status = dma_free_buffer(dma_engine);
-	if (FAILED(status))
-		status = FAIL_MSG(status, "dma free buffer fail");
-
-	dma_exit(dma_engine);
+exit:
+	kfree(dma_engine->m_buffer_addr);
+	kfree(dma_engine);
 
 	return status;
 }
-- 
1.7.4.1
