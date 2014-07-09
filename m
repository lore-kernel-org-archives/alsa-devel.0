From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 7/7] ASoC: Intel: sst - add compressed ops
	handling
Date: Wed,  9 Jul 2014 14:57:55 +0530
Message-ID: <1404898076-1882-8-git-send-email-vinod.koul@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D9DBB264F06
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 11:30:28 +0200 (CEST)
In-Reply-To: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch add low level IPC handling for compressed stream operations

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |  276 +++++++++++++++++++++++++++++++
 1 files changed, 276 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 1ad3083..c3d025d 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -282,6 +282,269 @@ static int sst_open_pcm_stream(struct snd_sst_params *str_param)
 	return retval;
 }
 
+static int sst_cdev_open(struct snd_sst_params *str_params,
+		struct sst_compress_cb *cb)
+{
+	int str_id, retval;
+	struct stream_info *stream;
+
+	pr_debug("%s: doing rtpm_get\n", __func__);
+
+	retval = intel_sst_check_device();
+	if (retval)
+		return retval;
+
+	str_id = sst_get_stream(str_params);
+	if (str_id > 0) {
+		pr_debug("stream allocated in sst_cdev_open %d\n", str_id);
+		stream = &sst_drv_ctx->streams[str_id];
+		stream->compr_cb = cb->compr_cb;
+		stream->compr_cb_param = cb->param;
+		stream->drain_notify = cb->drain_notify;
+		stream->drain_cb_param = cb->drain_cb_param;
+	} else {
+		pr_err("stream encountered error during alloc %d\n", str_id);
+		str_id = -EINVAL;
+		sst_pm_runtime_put(sst_drv_ctx);
+	}
+	return str_id;
+}
+
+static int sst_cdev_close(unsigned int str_id)
+{
+	int retval;
+	struct stream_info *stream;
+
+	pr_debug("%s: Entry\n", __func__);
+	stream = get_stream_info(str_id);
+	if (!stream) {
+		pr_err("stream info is NULL for str %d!!!\n", str_id);
+		return -EINVAL;
+	}
+
+	if (stream->status == STREAM_RESET) {
+		/* silently fail here as we have cleaned the stream */
+		pr_debug("stream in reset state...\n");
+		stream->status = STREAM_UN_INIT;
+
+		retval = 0;
+		goto put;
+	}
+
+	retval = sst_free_stream(str_id);
+put:
+	stream->compr_cb_param = NULL;
+	stream->compr_cb = NULL;
+
+	/* The free_stream will return a error if there is no stream to free,
+	(i.e. the alloc failure case). And in this case the open does a put in
+	the error scenario, so skip in this case.
+		In the close we need to handle put in the success scenario and
+	the timeout error(EBUSY) scenario. */
+	if (!retval || (retval == -EBUSY))
+		sst_pm_runtime_put(sst_drv_ctx);
+	else
+		pr_err("%s: free stream returned err %d\n", __func__, retval);
+
+	pr_debug("%s: End\n", __func__);
+	return retval;
+
+}
+
+static int sst_cdev_ack(unsigned int str_id, unsigned long bytes)
+{
+	struct stream_info *stream;
+	struct snd_sst_tstamp fw_tstamp = {0,};
+	int offset;
+	void __iomem *addr;
+
+	pr_debug("sst:  ackfor %d\n", str_id);
+	stream = get_stream_info(str_id);
+	if (!stream)
+		return -EINVAL;
+
+	/* update bytes sent */
+	stream->cumm_bytes += bytes;
+	pr_debug("bytes copied %d inc by %ld\n", stream->cumm_bytes, bytes);
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(sst_drv_ctx->mailbox + sst_drv_ctx->tstamp)
+		+(str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+
+	fw_tstamp.bytes_copied = stream->cumm_bytes;
+	pr_debug("bytes sent to fw %llu inc by %ld\n", fw_tstamp.bytes_copied,
+							 bytes);
+
+	addr =  ((void *)(sst_drv_ctx->mailbox + sst_drv_ctx->tstamp)) +
+			(str_id * sizeof(fw_tstamp));
+	offset =  offsetof(struct snd_sst_tstamp, bytes_copied);
+	sst_shim_write(addr, offset, fw_tstamp.bytes_copied);
+	return 0;
+
+}
+
+static int sst_cdev_set_metadata(unsigned int str_id,
+				struct snd_compr_metadata *metadata)
+{
+	int retval = 0, pvt_id, len;
+	struct ipc_post *msg = NULL;
+	struct stream_info *str_info;
+	struct ipc_dsp_hdr dsp_hdr;
+
+	pr_debug("set metadata for stream %d\n", str_id);
+
+	str_info = get_stream_info(str_id);
+	if (!str_info)
+		return -EINVAL;
+
+	if (sst_create_ipc_msg(&msg, 1))
+		return -ENOMEM;
+
+	pvt_id = sst_assign_pvt_id(sst_drv_ctx);
+	pr_debug("pvt id = %d\n", pvt_id);
+	pr_debug("pipe id = %d\n", str_info->pipe_id);
+	sst_fill_header_mrfld(&msg->mrfld_header,
+		IPC_CMD, str_info->task_id, 1, pvt_id);
+
+	len = sizeof(*metadata) + sizeof(dsp_hdr);
+	msg->mrfld_header.p.header_low_payload = len;
+	sst_fill_header_dsp(&dsp_hdr, IPC_IA_SET_STREAM_PARAMS_MRFLD,
+			str_info->pipe_id, sizeof(*metadata));
+	memcpy(msg->mailbox_data, &dsp_hdr, sizeof(dsp_hdr));
+	memcpy(msg->mailbox_data + sizeof(dsp_hdr),
+			metadata, sizeof(*metadata));
+
+	sst_drv_ctx->ops->sync_post_message(msg);
+	return retval;
+}
+
+static int sst_cdev_control(unsigned int cmd, unsigned int str_id)
+{
+	pr_debug("recieved cmd %d on stream %d\n", cmd, str_id);
+
+	if (sst_drv_ctx->sst_state != SST_FW_RUNNING)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		return sst_pause_stream(str_id);
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		return sst_resume_stream(str_id);
+	case SNDRV_PCM_TRIGGER_START: {
+		struct stream_info *str_info;
+
+		str_info = get_stream_info(str_id);
+		if (!str_info)
+			return -EINVAL;
+		str_info->prev = str_info->status;
+		str_info->status = STREAM_RUNNING;
+		return sst_start_stream(str_id);
+	}
+	case SNDRV_PCM_TRIGGER_STOP:
+		return sst_drop_stream(str_id);
+	case SND_COMPR_TRIGGER_DRAIN:
+		return sst_drain_stream(str_id, false);
+	case SND_COMPR_TRIGGER_NEXT_TRACK:
+		return sst_next_track();
+	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
+		return sst_drain_stream(str_id, true);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sst_cdev_tstamp(unsigned int str_id, struct snd_compr_tstamp *tstamp)
+{
+	struct snd_sst_tstamp fw_tstamp = {0,};
+	struct stream_info *stream;
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(sst_drv_ctx->mailbox + sst_drv_ctx->tstamp)
+		+(str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+
+	stream = get_stream_info(str_id);
+	if (!stream)
+		return -EINVAL;
+	pr_debug("rb_counter %llu in bytes\n", fw_tstamp.ring_buffer_counter);
+
+	tstamp->copied_total = fw_tstamp.ring_buffer_counter;
+	tstamp->pcm_frames = fw_tstamp.frames_decoded;
+	tstamp->pcm_io_frames = div_u64(fw_tstamp.hardware_counter,
+			(u64)((stream->num_ch) * SST_GET_BYTES_PER_SAMPLE(24)));
+	tstamp->sampling_rate = fw_tstamp.sampling_frequency;
+	pr_debug("PCM  = %u\n", tstamp->pcm_io_frames);
+	pr_debug("Pointer Query on strid = %d  copied_total %d, decodec %d\n",
+		str_id, tstamp->copied_total, tstamp->pcm_frames);
+	pr_debug("rendered %d\n", tstamp->pcm_io_frames);
+	return 0;
+}
+
+static int sst_cdev_caps(struct snd_compr_caps *caps)
+{
+	caps->num_codecs = NUM_CODEC;
+	caps->min_fragment_size = MIN_FRAGMENT_SIZE;  /* 50KB */
+	caps->max_fragment_size = MAX_FRAGMENT_SIZE;  /* 1024KB */
+	caps->min_fragments = MIN_FRAGMENT;
+	caps->max_fragments = MAX_FRAGMENT;
+	caps->codecs[0] = SND_AUDIOCODEC_MP3;
+	caps->codecs[1] = SND_AUDIOCODEC_AAC;
+	return 0;
+}
+
+static int sst_cdev_codec_caps(struct snd_compr_codec_caps *codec)
+{
+
+	if (codec->codec == SND_AUDIOCODEC_MP3) {
+		codec->num_descriptors = 2;
+		codec->descriptor[0].max_ch = 2;
+		codec->descriptor[0].sample_rates[0] = 48000;
+		codec->descriptor[0].sample_rates[1] = 44100;
+		codec->descriptor[0].sample_rates[2] = 32000;
+		codec->descriptor[0].sample_rates[3] = 16000;
+		codec->descriptor[0].sample_rates[4] = 8000;
+		codec->descriptor[0].num_sample_rates = 5;
+		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
+		codec->descriptor[0].bit_rate[1] = 192;
+		codec->descriptor[0].num_bitrates = 2;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
+		codec->descriptor[0].formats = 0;
+	} else if (codec->codec == SND_AUDIOCODEC_AAC) {
+		codec->num_descriptors = 2;
+		codec->descriptor[1].max_ch = 2;
+		codec->descriptor[0].sample_rates[0] = 48000;
+		codec->descriptor[0].sample_rates[1] = 44100;
+		codec->descriptor[0].sample_rates[2] = 32000;
+		codec->descriptor[0].sample_rates[3] = 16000;
+		codec->descriptor[0].sample_rates[4] = 8000;
+		codec->descriptor[0].num_sample_rates = 5;
+		codec->descriptor[1].bit_rate[0] = 320; /* 320kbps */
+		codec->descriptor[1].bit_rate[1] = 192;
+		codec->descriptor[1].num_bitrates = 2;
+		codec->descriptor[1].profiles = 0;
+		codec->descriptor[1].modes = 0;
+		codec->descriptor[1].formats =
+			(SND_AUDIOSTREAMFORMAT_MP4ADTS |
+				SND_AUDIOSTREAMFORMAT_RAW);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void sst_cdev_fragment_elapsed(int str_id)
+{
+	struct stream_info *stream;
+
+	pr_debug("fragment elapsed from firmware for str_id %d\n", str_id);
+	stream = &sst_drv_ctx->streams[str_id];
+	if (stream->compr_cb)
+		stream->compr_cb(stream->compr_cb_param);
+}
+
 /*
  * sst_close_pcm_stream - Close PCM interface
  *
@@ -514,10 +777,23 @@ static struct sst_ops pcm_ops = {
 	.close = sst_close_pcm_stream,
 };
 
+static struct compress_sst_ops compr_ops = {
+	.open = sst_cdev_open,
+	.close = sst_cdev_close,
+	.control = sst_cdev_control,
+	.tstamp = sst_cdev_tstamp,
+	.ack = sst_cdev_ack,
+	.get_caps = sst_cdev_caps,
+	.get_codec_caps = sst_cdev_codec_caps,
+	.set_metadata = sst_cdev_set_metadata,
+};
+
+
 static struct sst_device sst_dsp_device = {
 	.name = "Intel(R) SST LPE",
 	.dev = NULL,
 	.ops = &pcm_ops,
+	.compr_ops = &compr_ops,
 };
 
 /*
-- 
1.7.0.4
