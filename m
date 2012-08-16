From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 3/3] ASoC: mid-x86 - add support for compressed
	streams
Date: Thu, 16 Aug 2012 17:10:42 +0530
Message-ID: <1345117242-26975-4-git-send-email-vinod.koul@linux.intel.com>
References: <1345117242-26975-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 62869266006
 for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2012 13:09:03 +0200 (CEST)
In-Reply-To: <1345117242-26975-1-git-send-email-vinod.koul@linux.intel.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Namarta Kohli <namartax.kohli@intel.com>, lrg@ti.com, Ramesh Babu K V <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Namarta Kohli <namartax.kohli@intel.com>
Signed-off-by: Ramesh Babu K V <ramesh.babu@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/mid-x86/mfld_machine.c |    9 ++
 sound/soc/mid-x86/sst_dsp.h      |  134 +++++++++++++++++++++++++
 sound/soc/mid-x86/sst_platform.c |  204 +++++++++++++++++++++++++++++++++++++-
 sound/soc/mid-x86/sst_platform.h |   26 +++++-
 4 files changed, 371 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/mid-x86/sst_dsp.h

diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
index 2937e54..2cc7782 100644
--- a/sound/soc/mid-x86/mfld_machine.c
+++ b/sound/soc/mid-x86/mfld_machine.c
@@ -318,6 +318,15 @@ static struct snd_soc_dai_link mfld_msic_dailink[] = {
 		.platform_name = "sst-platform",
 		.init = NULL,
 	},
+	{
+		.name = "Medfield Compress",
+		.stream_name = "Speaker",
+		.cpu_dai_name = "Compress-cpu-dai",
+		.codec_dai_name = "SN95031 Speaker",
+		.codec_name = "sn95031",
+		.platform_name = "sst-platform",
+		.init = NULL,
+	},
 };
 
 /* SoC card */
diff --git a/sound/soc/mid-x86/sst_dsp.h b/sound/soc/mid-x86/sst_dsp.h
new file mode 100644
index 0000000..0fce1de
--- /dev/null
+++ b/sound/soc/mid-x86/sst_dsp.h
@@ -0,0 +1,134 @@
+#ifndef __SST_DSP_H__
+#define __SST_DSP_H__
+/*
+ *  sst_dsp.h - Intel SST Driver for audio engine
+ *
+ *  Copyright (C) 2008-12 Intel Corporation
+ *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+enum sst_codec_types {
+	/*  AUDIO/MUSIC	CODEC Type Definitions */
+	SST_CODEC_TYPE_UNKNOWN = 0,
+	SST_CODEC_TYPE_PCM,	/* Pass through Audio codec */
+	SST_CODEC_TYPE_MP3,
+	SST_CODEC_TYPE_MP24,
+	SST_CODEC_TYPE_AAC,
+	SST_CODEC_TYPE_AACP,
+	SST_CODEC_TYPE_eAACP,
+};
+
+enum stream_type {
+	SST_STREAM_TYPE_NONE = 0,
+	SST_STREAM_TYPE_MUSIC = 1,
+};
+
+struct snd_pcm_params {
+	u16 codec;	/* codec type */
+	u8 num_chan;	/* 1=Mono, 2=Stereo */
+	u8 pcm_wd_sz;	/* 16/24 - bit*/
+	u32 reserved;	/* Bitrate in bits per second */
+	u32 sfreq;	/* Sampling rate in Hz */
+	u8 use_offload_path;
+	u8 reserved2;
+	u16 reserved3;
+	u8 channel_map[8];
+} __packed;
+
+/* MP3 Music Parameters Message */
+struct snd_mp3_params {
+	u16 codec;
+	u8  num_chan;	/* 1=Mono, 2=Stereo	*/
+	u8  pcm_wd_sz; /* 16/24 - bit*/
+	u8  crc_check; /* crc_check - disable (0) or enable (1) */
+	u8  reserved1; /* unused*/
+	u16 reserved2;	/* Unused */
+} __packed;
+
+#define AAC_BIT_STREAM_ADTS		0
+#define AAC_BIT_STREAM_ADIF		1
+#define AAC_BIT_STREAM_RAW		2
+
+/* AAC Music Parameters Message */
+struct snd_aac_params {
+	u16 codec;
+	u8 num_chan; /* 1=Mono, 2=Stereo*/
+	u8 pcm_wd_sz; /* 16/24 - bit*/
+	u8 bdownsample; /*SBR downsampling 0 - disable 1 -enabled AAC+ only */
+	u8 bs_format; /* input bit stream format adts=0, adif=1, raw=2 */
+	u16  reser2;
+	u32 externalsr; /*sampling rate of basic AAC raw bit stream*/
+	u8 sbr_signalling;/*disable/enable/set automode the SBR tool.AAC+*/
+	u8 reser1;
+	u16  reser3;
+} __packed;
+
+/* WMA Music Parameters Message */
+struct snd_wma_params {
+	u16 codec;
+	u8  num_chan;	/* 1=Mono, 2=Stereo */
+	u8  pcm_wd_sz;	/* 16/24 - bit*/
+	u32 brate;	/* Use the hard coded value. */
+	u32 sfreq;	/* Sampling freq eg. 8000, 441000, 48000 */
+	u32 channel_mask;  /* Channel Mask */
+	u16 format_tag;	/* Format Tag */
+	u16 block_align;	/* packet size */
+	u16 wma_encode_opt;/* Encoder option */
+	u8 op_align;	/* op align 0- 16 bit, 1- MSB, 2 LSB */
+	u8 reserved;	/* reserved */
+} __packed;
+
+/* Codec params struture */
+union  snd_sst_codec_params {
+	struct snd_pcm_params pcm_params;
+	struct snd_mp3_params mp3_params;
+	struct snd_aac_params aac_params;
+	struct snd_wma_params wma_params;
+} __packed;
+
+/* Address and size info of a frame buffer */
+struct sst_address_info {
+	u32 addr; /* Address at IA */
+	u32 size; /* Size of the buffer */
+};
+
+struct snd_sst_alloc_params_ext {
+	struct sst_address_info  ring_buf_info[8];
+	u8 sg_count;
+	u8 reserved;
+	u16 reserved2;
+	u32 frag_size;	/*Number of samples after which period elapsed
+				  message is sent valid only if path  = 0*/
+} __packed;
+
+struct snd_sst_stream_params {
+	union snd_sst_codec_params uc;
+} __packed;
+
+struct snd_sst_params {
+	u32 stream_id;
+	u8 codec;
+	u8 ops;
+	u8 stream_type;
+	u8 device_type;
+	struct snd_sst_stream_params sparams;
+	struct snd_sst_alloc_params_ext aparams;
+};
+
+#endif /* __SST_DSP_H__ */
diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index d34563b..a263cbe 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -1,7 +1,7 @@
 /*
  *  sst_platform.c - Intel MID Platform driver
  *
- *  Copyright (C) 2010 Intel Corp
+ *  Copyright (C) 2010-2012 Intel Corp
  *  Author: Vinod Koul <vinod.koul@intel.com>
  *  Author: Harsha Priya <priya.harsha@intel.com>
  *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -32,6 +32,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/compress_driver.h>
 #include "sst_platform.h"
 
 static struct sst_device *sst;
@@ -152,6 +153,16 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
+{
+	.name = "Compress-cpu-dai",
+	.compress_dai = 1,
+	.playback = {
+		.channels_min = SST_STEREO,
+		.channels_max = SST_STEREO,
+		.rates = SNDRV_PCM_RATE_44100|SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	},
+},
 };
 
 /* helper functions */
@@ -463,8 +474,199 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	}
 	return retval;
 }
+
+/* compress stream operations */
+static void sst_compr_fragment_elapsed(void *arg)
+{
+	struct snd_compr_stream *cstream = (struct snd_compr_stream *)arg;
+
+	pr_debug("fragment elapsed by driver\n");
+	if (cstream)
+		snd_compr_fragment_elapsed(cstream);
+}
+
+static int sst_platform_compr_open(struct snd_compr_stream *cstream)
+{
+
+	int ret_val = 0;
+	struct snd_compr_runtime *runtime = cstream->runtime;
+	struct sst_runtime_stream *stream;
+
+	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
+	if (!stream)
+		return -ENOMEM;
+
+	spin_lock_init(&stream->status_lock);
+
+	/* get the sst ops */
+	if (!sst || !try_module_get(sst->dev->driver->owner)) {
+		pr_err("no device available to run\n");
+		ret_val = -ENODEV;
+		goto out_ops;
+	}
+	stream->compr_ops = sst->compr_ops;
+
+	stream->id = 0;
+	sst_set_stream_status(stream, SST_PLATFORM_INIT);
+	runtime->private_data = stream;
+	return 0;
+out_ops:
+	kfree(stream);
+	return ret_val;
+}
+
+static int sst_platform_compr_free(struct snd_compr_stream *cstream)
+{
+	struct sst_runtime_stream *stream;
+	int ret_val = 0, str_id;
+
+	stream = cstream->runtime->private_data;
+	/*need to check*/
+	str_id = stream->id;
+	if (str_id)
+		ret_val = stream->compr_ops->close(str_id);
+	module_put(sst->dev->driver->owner);
+	kfree(stream);
+	pr_debug("%s: %d\n", __func__, ret_val);
+	return 0;
+}
+
+static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
+					struct snd_compr_params *params)
+{
+	struct sst_runtime_stream *stream;
+	int retval;
+	struct snd_sst_params str_params;
+	struct sst_compress_cb cb;
+
+	stream = cstream->runtime->private_data;
+	/* construct fw structure for this*/
+	memset(&str_params, 0, sizeof(str_params));
+
+	str_params.ops = STREAM_OPS_PLAYBACK;
+	str_params.stream_type = SST_STREAM_TYPE_MUSIC;
+	str_params.device_type = SND_SST_DEVICE_COMPRESS;
+
+	switch (params->codec.id) {
+	case SND_AUDIOCODEC_MP3: {
+		str_params.codec = SST_CODEC_TYPE_MP3;
+		str_params.sparams.uc.mp3_params.codec = SST_CODEC_TYPE_MP3;
+		str_params.sparams.uc.mp3_params.num_chan = params->codec.ch_in;
+		str_params.sparams.uc.mp3_params.pcm_wd_sz = 16;
+		break;
+	}
+
+	case SND_AUDIOCODEC_AAC: {
+		str_params.codec = SST_CODEC_TYPE_AAC;
+		str_params.sparams.uc.aac_params.codec = SST_CODEC_TYPE_AAC;
+		str_params.sparams.uc.aac_params.num_chan = params->codec.ch_in;
+		str_params.sparams.uc.aac_params.pcm_wd_sz = 16;
+		if (params->codec.format == SND_AUDIOSTREAMFORMAT_MP4ADTS)
+			str_params.sparams.uc.aac_params.bs_format =
+							AAC_BIT_STREAM_ADTS;
+		else if (params->codec.format == SND_AUDIOSTREAMFORMAT_RAW)
+			str_params.sparams.uc.aac_params.bs_format =
+							AAC_BIT_STREAM_RAW;
+		else {
+			pr_err("Undefined format%d\n", params->codec.format);
+			return -EINVAL;
+		}
+		str_params.sparams.uc.aac_params.externalsr =
+						params->codec.sample_rate;
+		break;
+	}
+
+	default:
+		pr_err("codec not supported, id =%d\n", params->codec.id);
+		return -EINVAL;
+	}
+
+	str_params.aparams.ring_buf_info[0].addr  =
+					virt_to_phys(cstream->runtime->buffer);
+	str_params.aparams.ring_buf_info[0].size =
+					cstream->runtime->buffer_size;
+	str_params.aparams.sg_count = 1;
+	str_params.aparams.frag_size = cstream->runtime->fragment_size;
+
+	cb.param = cstream;
+	cb.compr_cb = sst_compr_fragment_elapsed;
+
+	retval = stream->compr_ops->open(&str_params, &cb);
+	if (retval < 0) {
+		pr_err("stream allocation failed %d\n", retval);
+		return retval;
+	}
+
+	stream->id = retval;
+	return 0;
+}
+
+static int sst_platform_compr_trigger(struct snd_compr_stream *cstream, int cmd)
+{
+	struct sst_runtime_stream *stream =
+		cstream->runtime->private_data;
+
+	return stream->compr_ops->control(cmd, stream->id);
+}
+
+static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
+					struct snd_compr_tstamp *tstamp)
+{
+	struct sst_runtime_stream *stream;
+
+	stream  = cstream->runtime->private_data;
+	stream->compr_ops->tstamp(stream->id, tstamp);
+	tstamp->byte_offset = tstamp->copied_total %
+				 (u32)cstream->runtime->buffer_size;
+	pr_debug("calc bytes offset/copied bytes as %d\n", tstamp->byte_offset);
+	return 0;
+}
+
+static int sst_platform_compr_ack(struct snd_compr_stream *cstream,
+					size_t bytes)
+{
+	struct sst_runtime_stream *stream;
+
+	stream  = cstream->runtime->private_data;
+	stream->compr_ops->ack(stream->id, (unsigned long)bytes);
+	stream->bytes_written += bytes;
+
+	return 0;
+}
+
+static int sst_platform_compr_get_caps(struct snd_compr_stream *cstream,
+					struct snd_compr_caps *caps)
+{
+	struct sst_runtime_stream *stream =
+		cstream->runtime->private_data;
+
+	return stream->compr_ops->get_caps(caps);
+}
+
+static int sst_platform_compr_get_codec_caps(struct snd_compr_stream *cstream,
+					struct snd_compr_codec_caps *codec)
+{
+	struct sst_runtime_stream *stream =
+		cstream->runtime->private_data;
+
+	return stream->compr_ops->get_codec_caps(codec);
+}
+
+static struct snd_compr_ops sst_platform_compr_ops = {
+
+	.open = sst_platform_compr_open,
+	.free = sst_platform_compr_free,
+	.set_params = sst_platform_compr_set_params,
+	.trigger = sst_platform_compr_trigger,
+	.pointer = sst_platform_compr_pointer,
+	.ack = sst_platform_compr_ack,
+	.get_caps = sst_platform_compr_get_caps,
+	.get_codec_caps = sst_platform_compr_get_codec_caps,
+};
+
 static struct snd_soc_platform_driver sst_soc_platform_drv = {
 	.ops		= &sst_platform_ops,
+	.compr_ops	= &sst_platform_compr_ops,
 	.pcm_new	= sst_pcm_new,
 	.pcm_free	= sst_pcm_free,
 };
diff --git a/sound/soc/mid-x86/sst_platform.h b/sound/soc/mid-x86/sst_platform.h
index f04f4f7..d61c5d5 100644
--- a/sound/soc/mid-x86/sst_platform.h
+++ b/sound/soc/mid-x86/sst_platform.h
@@ -27,6 +27,8 @@
 #ifndef __SST_PLATFORMDRV_H__
 #define __SST_PLATFORMDRV_H__
 
+#include "sst_dsp.h"
+
 #define SST_MONO		1
 #define SST_STEREO		2
 #define SST_MAX_CAP		5
@@ -42,7 +44,6 @@
 #define SST_MIN_PERIODS		2
 #define SST_MAX_PERIODS		(1024*2)
 #define SST_FIFO_SIZE		0
-#define SST_CODEC_TYPE_PCM	1
 
 struct pcm_stream_info {
 	int str_id;
@@ -83,6 +84,7 @@ enum sst_audio_device_type {
 	SND_SST_DEVICE_VIBRA,
 	SND_SST_DEVICE_HAPTIC,
 	SND_SST_DEVICE_CAPTURE,
+	SND_SST_DEVICE_COMPRESS,
 };
 
 /* PCM Parameters */
@@ -107,6 +109,24 @@ struct sst_stream_params {
 	struct sst_pcm_params sparams;
 };
 
+struct sst_compress_cb {
+	void *param;
+	void (*compr_cb)(void *param);
+};
+
+struct compress_sst_ops {
+	const char *name;
+	int (*open) (struct snd_sst_params *str_params,
+			struct sst_compress_cb *cb);
+	int (*control) (unsigned int cmd, unsigned int str_id);
+	int (*tstamp) (unsigned int str_id, struct snd_compr_tstamp *tstamp);
+	int (*ack) (unsigned int str_id, unsigned long bytes);
+	int (*close) (unsigned int str_id);
+	int (*get_caps) (struct snd_compr_caps *caps);
+	int (*get_codec_caps) (struct snd_compr_codec_caps *codec);
+
+};
+
 struct sst_ops {
 	int (*open) (struct sst_stream_params *str_param);
 	int (*device_control) (int cmd, void *arg);
@@ -115,8 +135,11 @@ struct sst_ops {
 
 struct sst_runtime_stream {
 	int     stream_status;
+	unsigned int id;
+	size_t bytes_written;
 	struct pcm_stream_info stream_info;
 	struct sst_ops *ops;
+	struct compress_sst_ops *compr_ops;
 	spinlock_t	status_lock;
 };
 
@@ -124,6 +147,7 @@ struct sst_device {
 	char *name;
 	struct device *dev;
 	struct sst_ops *ops;
+	struct compress_sst_ops *compr_ops;
 };
 
 int sst_register_dsp(struct sst_device *sst);
-- 
1.7.0.4
