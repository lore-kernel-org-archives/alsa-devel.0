From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: sst - add compressed ops
	handling
Date: Thu, 30 Oct 2014 16:20:59 +0530
Message-ID: <1414666259-4450-5-git-send-email-vinod.koul@intel.com>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 674C1265191
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:31:54 +0100 (CET)
In-Reply-To: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch add low level IPC handling for compressed stream operations

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |  285 +++++++++++++++++++++++++++++++
 1 files changed, 285 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 4187057..5f75ef3 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -172,6 +172,273 @@ static int sst_open_pcm_stream(struct device *dev,
 	return retval;
 }
 
+static int sst_cdev_open(struct device *dev,
+		struct snd_sst_params *str_params, struct sst_compress_cb *cb)
+{
+	int str_id, retval;
+	struct stream_info *stream;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	retval = pm_runtime_get_sync(ctx->dev);
+	if (retval < 0)
+		return retval;
+
+	str_id = sst_get_stream(ctx, str_params);
+	if (str_id > 0) {
+		dev_dbg(dev, "stream allocated in sst_cdev_open %d\n", str_id);
+		stream = &ctx->streams[str_id];
+		stream->compr_cb = cb->compr_cb;
+		stream->compr_cb_param = cb->param;
+		stream->drain_notify = cb->drain_notify;
+		stream->drain_cb_param = cb->drain_cb_param;
+	} else {
+		dev_err(dev, "stream encountered error during alloc %d\n", str_id);
+		str_id = -EINVAL;
+		sst_pm_runtime_put(ctx);
+	}
+	return str_id;
+}
+
+static int sst_cdev_close(struct device *dev, unsigned int str_id)
+{
+	int retval;
+	struct stream_info *stream;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	stream = get_stream_info(ctx, str_id);
+	if (!stream) {
+		dev_err(dev, "stream info is NULL for str %d!!!\n", str_id);
+		return -EINVAL;
+	}
+
+	if (stream->status == STREAM_RESET) {
+		dev_dbg(dev, "stream in reset state...\n");
+		stream->status = STREAM_UN_INIT;
+
+		retval = 0;
+		goto put;
+	}
+
+	retval = sst_free_stream(ctx, str_id);
+put:
+	stream->compr_cb_param = NULL;
+	stream->compr_cb = NULL;
+
+	if (retval)
+		dev_err(dev, "free stream returned err %d\n", retval);
+
+	dev_dbg(dev, "End\n");
+	return retval;
+
+}
+
+static int sst_cdev_ack(struct device *dev, unsigned int str_id,
+		unsigned long bytes)
+{
+	struct stream_info *stream;
+	struct snd_sst_tstamp fw_tstamp = {0,};
+	int offset;
+	void __iomem *addr;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	stream = get_stream_info(ctx, str_id);
+	if (!stream)
+		return -EINVAL;
+
+	/* update bytes sent */
+	stream->cumm_bytes += bytes;
+	dev_dbg(dev, "bytes copied %d inc by %ld\n", stream->cumm_bytes, bytes);
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(ctx->mailbox + ctx->tstamp)
+		+(str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+
+	fw_tstamp.bytes_copied = stream->cumm_bytes;
+	dev_dbg(dev, "bytes sent to fw %llu inc by %ld\n",
+			fw_tstamp.bytes_copied, bytes);
+
+	addr =  ((void *)(ctx->mailbox + ctx->tstamp)) +
+			(str_id * sizeof(fw_tstamp));
+	offset =  offsetof(struct snd_sst_tstamp, bytes_copied);
+	sst_shim_write(addr, offset, fw_tstamp.bytes_copied);
+	return 0;
+}
+
+static int sst_cdev_set_metadata(struct device *dev,
+		unsigned int str_id, struct snd_compr_metadata *metadata)
+{
+	int retval = 0;
+	struct stream_info *str_info;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "set metadata for stream %d\n", str_id);
+
+	str_info = get_stream_info(ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+
+	dev_dbg(dev, "pipe id = %d\n", str_info->pipe_id);
+	retval = sst_prepare_and_post_msg(ctx, str_info->task_id, IPC_CMD,
+			IPC_IA_SET_STREAM_PARAMS_MRFLD, str_info->pipe_id,
+			sizeof(*metadata), metadata, NULL,
+			true, true, true, false);
+
+	return retval;
+}
+
+static int sst_cdev_stream_pause(struct device *dev, unsigned int str_id)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	return sst_pause_stream(ctx, str_id);
+}
+
+static int sst_cdev_stream_pause_release(struct device *dev,
+		unsigned int str_id)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	return sst_resume_stream(ctx, str_id);
+}
+
+static int sst_cdev_stream_start(struct device *dev, unsigned int str_id)
+{
+	struct stream_info *str_info;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	str_info = get_stream_info(ctx, str_id);
+	if (!str_info)
+		return -EINVAL;
+	str_info->prev = str_info->status;
+	str_info->status = STREAM_RUNNING;
+	return sst_start_stream(ctx, str_id);
+}
+
+static int sst_cdev_stream_drop(struct device *dev, unsigned int str_id)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	return sst_drop_stream(ctx, str_id);
+}
+
+static int sst_cdev_stream_drain(struct device *dev, unsigned int str_id)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	return sst_drain_stream(ctx, str_id, false);
+}
+
+static int sst_cdev_stream_partial_drain(struct device *dev,
+		unsigned int str_id)
+{
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	return sst_drain_stream(ctx, str_id, true);
+}
+
+static int sst_cdev_tstamp(struct device *dev, unsigned int str_id,
+		struct snd_compr_tstamp *tstamp)
+{
+	struct snd_sst_tstamp fw_tstamp = {0,};
+	struct stream_info *stream;
+	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
+
+	memcpy_fromio(&fw_tstamp,
+		((void *)(ctx->mailbox + ctx->tstamp)
+		+(str_id * sizeof(fw_tstamp))),
+		sizeof(fw_tstamp));
+
+	stream = get_stream_info(ctx, str_id);
+	if (!stream)
+		return -EINVAL;
+	dev_dbg(dev, "rb_counter %llu in bytes\n", fw_tstamp.ring_buffer_counter);
+
+	tstamp->copied_total = fw_tstamp.ring_buffer_counter;
+	tstamp->pcm_frames = fw_tstamp.frames_decoded;
+	tstamp->pcm_io_frames = div_u64(fw_tstamp.hardware_counter,
+			(u64)((stream->num_ch) * SST_GET_BYTES_PER_SAMPLE(24)));
+	tstamp->sampling_rate = fw_tstamp.sampling_frequency;
+
+	dev_dbg(dev, "PCM  = %u\n", tstamp->pcm_io_frames);
+	dev_dbg(dev, "Ptr Query on strid = %d  copied_total %d, decodec %d\n",
+		str_id, tstamp->copied_total, tstamp->pcm_frames);
+	dev_dbg(dev, "rendered %d\n", tstamp->pcm_io_frames);
+
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
+static struct snd_compr_codec_caps caps_mp3 = {
+	.num_descriptors = 1,
+	.descriptor[0].max_ch = 2,
+	.descriptor[0].sample_rates[0] = 48000,
+	.descriptor[0].sample_rates[1] = 44100,
+	.descriptor[0].sample_rates[2] = 32000,
+	.descriptor[0].sample_rates[3] = 16000,
+	.descriptor[0].sample_rates[4] = 8000,
+	.descriptor[0].num_sample_rates = 5,
+	.descriptor[0].bit_rate[0] = 320,
+	.descriptor[0].bit_rate[1] = 192,
+	.descriptor[0].num_bitrates = 2,
+	.descriptor[0].profiles = 0,
+	.descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO,
+	.descriptor[0].formats = 0,
+};
+
+static struct snd_compr_codec_caps caps_aac = {
+	.num_descriptors = 2,
+	.descriptor[1].max_ch = 2,
+	.descriptor[0].sample_rates[0] = 48000,
+	.descriptor[0].sample_rates[1] = 44100,
+	.descriptor[0].sample_rates[2] = 32000,
+	.descriptor[0].sample_rates[3] = 16000,
+	.descriptor[0].sample_rates[4] = 8000,
+	.descriptor[0].num_sample_rates = 5,
+	.descriptor[1].bit_rate[0] = 320,
+	.descriptor[1].bit_rate[1] = 192,
+	.descriptor[1].num_bitrates = 2,
+	.descriptor[1].profiles = 0,
+	.descriptor[1].modes = 0,
+	.descriptor[1].formats =
+			(SND_AUDIOSTREAMFORMAT_MP4ADTS |
+				SND_AUDIOSTREAMFORMAT_RAW),
+};
+
+static int sst_cdev_codec_caps(struct snd_compr_codec_caps *codec)
+{
+	if (codec->codec == SND_AUDIOCODEC_MP3)
+		*codec = caps_mp3;
+	else if (codec->codec == SND_AUDIOCODEC_AAC)
+		*codec = caps_aac;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+void sst_cdev_fragment_elapsed(struct intel_sst_drv *ctx, int str_id)
+{
+	struct stream_info *stream;
+
+	dev_dbg(ctx->dev, "fragment elapsed from firmware for str_id %d\n",
+			str_id);
+	stream = &ctx->streams[str_id];
+	if (stream->compr_cb)
+		stream->compr_cb(stream->compr_cb_param);
+}
+
 /*
  * sst_close_pcm_stream - Close PCM interface
  *
@@ -372,10 +639,28 @@ static struct sst_ops pcm_ops = {
 	.power = sst_power_control,
 };
 
+static struct compress_sst_ops compr_ops = {
+	.open = sst_cdev_open,
+	.close = sst_cdev_close,
+	.stream_pause = sst_cdev_stream_pause,
+	.stream_pause_release = sst_cdev_stream_pause_release,
+	.stream_start = sst_cdev_stream_start,
+	.stream_drop = sst_cdev_stream_drop,
+	.stream_drain = sst_cdev_stream_drain,
+	.stream_partial_drain = sst_cdev_stream_partial_drain,
+	.tstamp = sst_cdev_tstamp,
+	.ack = sst_cdev_ack,
+	.get_caps = sst_cdev_caps,
+	.get_codec_caps = sst_cdev_codec_caps,
+	.set_metadata = sst_cdev_set_metadata,
+	.power = sst_power_control,
+};
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
