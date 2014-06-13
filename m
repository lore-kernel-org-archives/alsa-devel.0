From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/19] ASoC: Intel: mfld-pcm: modularize stream
	allocation code
Date: Fri, 13 Jun 2014 18:03:55 +0530
Message-ID: <1402662848-24534-7-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D92F2619F2
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:32:56 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Tis will be used to add table based support for pcm front ends in subsequent
patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |  102 +++++++++++++++++++++----------
 sound/soc/intel/sst-mfld-platform.h     |    2 +-
 2 files changed, 71 insertions(+), 33 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 80879e5..6e7bfb1 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -143,52 +143,90 @@ static inline int sst_get_stream_status(struct sst_runtime_stream *stream)
 	return state;
 }
 
+static void sst_fill_alloc_params(struct snd_pcm_substream *substream,
+				struct snd_sst_alloc_params_ext *alloc_param)
+{
+	unsigned int channels;
+	snd_pcm_uframes_t period_size;
+	ssize_t periodbytes;
+	ssize_t buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+	u32 buffer_addr = virt_to_phys(substream->dma_buffer.area);
+
+	channels = substream->runtime->channels;
+	period_size = substream->runtime->period_size;
+	periodbytes = samples_to_bytes(substream->runtime, period_size);
+	alloc_param->ring_buf_info[0].addr = buffer_addr;
+	alloc_param->ring_buf_info[0].size = buffer_bytes;
+	alloc_param->sg_count = 1;
+	alloc_param->reserved = 0;
+	alloc_param->frag_size = periodbytes * channels;
+
+}
 static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
-				struct sst_pcm_params *param)
+				struct snd_sst_stream_params *param)
 {
+	param->uc.pcm_params.num_chan = (u8) substream->runtime->channels;
+	param->uc.pcm_params.pcm_wd_sz = substream->runtime->sample_bits;
+	param->uc.pcm_params.sfreq = substream->runtime->rate;
 
-	param->num_chan = (u8) substream->runtime->channels;
-	param->pcm_wd_sz = substream->runtime->sample_bits;
-	param->reserved = 0;
-	param->sfreq = substream->runtime->rate;
-	param->ring_buffer_size = snd_pcm_lib_buffer_bytes(substream);
-	param->period_count = substream->runtime->period_size;
-	param->ring_buffer_addr = virt_to_phys(substream->dma_buffer.area);
-	pr_debug("period_cnt = %d\n", param->period_count);
-	pr_debug("sfreq= %d, wd_sz = %d\n", param->sfreq, param->pcm_wd_sz);
+	/* PCM stream via ALSA interface */
+	param->uc.pcm_params.use_offload_path = 0;
+	param->uc.pcm_params.reserved2 = 0;
+	memset(param->uc.pcm_params.channel_map, 0, sizeof(u8));
+
+}
+int sst_fill_stream_params(void *substream,
+	struct snd_sst_params *str_params, bool is_compress)
+{
+	struct snd_pcm_substream *pstream = NULL;
+	struct snd_compr_stream *cstream = NULL;
+
+	if (is_compress == true)
+		cstream = (struct snd_compr_stream *)substream;
+	else
+		pstream = (struct snd_pcm_substream *)substream;
+
+	str_params->stream_type = SST_STREAM_TYPE_MUSIC;
+
+	/* For pcm streams */
+	if (pstream)
+		str_params->ops = (u8)pstream->stream;
+	if (cstream)
+		str_params->ops = (u8)cstream->direction;
+
+	return 0;
 }
 
-static int sst_platform_alloc_stream(struct snd_pcm_substream *substream)
+static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
+		struct snd_soc_platform *platform)
 {
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
-	struct sst_pcm_params param = {0};
-	struct sst_stream_params str_params = {0};
-	int ret_val;
+	struct snd_sst_stream_params param = {{{0,},},};
+	struct snd_sst_params str_params = {0};
+	struct snd_sst_alloc_params_ext alloc_params = {0};
+	int ret_val = 0;
 
 	/* set codec params and inform SST driver the same */
 	sst_fill_pcm_params(substream, &param);
+	sst_fill_alloc_params(substream, &alloc_params);
 	substream->runtime->dma_area = substream->dma_buffer.area;
 	str_params.sparams = param;
-	str_params.codec =  param.codec;
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		str_params.ops = STREAM_OPS_PLAYBACK;
-		str_params.device_type = substream->pcm->device + 1;
-		pr_debug("Playbck stream,Device %d\n",
-					substream->pcm->device);
-	} else {
-		str_params.ops = STREAM_OPS_CAPTURE;
-		str_params.device_type = SND_SST_DEVICE_CAPTURE;
-		pr_debug("Capture stream,Device %d\n",
-					substream->pcm->device);
-	}
-	ret_val = stream->ops->open(&str_params);
-	pr_debug("SST_SND_PLAY/CAPTURE ret_val = %x\n", ret_val);
+	str_params.aparams = alloc_params;
+	str_params.codec = SST_CODEC_TYPE_PCM;
+
+	/* fill the device type and stream id to pass to SST driver */
+	ret_val = sst_fill_stream_params(substream, &str_params, false);
 	if (ret_val < 0)
 		return ret_val;
 
-	stream->stream_info.str_id = ret_val;
-	pr_debug("str id :  %d\n", stream->stream_info.str_id);
+	stream->stream_info.str_id = str_params.stream_id;
+
+	ret_val = stream->ops->open(&str_params);
+	if (ret_val <= 0)
+		return ret_val;
+
+
 	return ret_val;
 }
 
@@ -300,8 +338,8 @@ static int sst_media_prepare(struct snd_pcm_substream *substream,
 		return ret_val;
 	}
 
-	ret_val = sst_platform_alloc_stream(substream);
-	if (ret_val < 0)
+	ret_val = sst_platform_alloc_stream(substream, dai->platform);
+	if (ret_val <= 0)
 		return ret_val;
 	snprintf(substream->pcm->id, sizeof(substream->pcm->id),
 			"%d", stream->stream_info.str_id);
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 33a0a27..aa5ddbb 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -125,7 +125,7 @@ struct compress_sst_ops {
 };
 
 struct sst_ops {
-	int (*open) (struct sst_stream_params *str_param);
+	int (*open) (struct snd_sst_params *str_param);
 	int (*device_control) (int cmd, void *arg);
 	int (*close) (unsigned int str_id);
 };
-- 
1.7.0.4
