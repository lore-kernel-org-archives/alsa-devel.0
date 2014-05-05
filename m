From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 4/8] ASoC: Intel: split the pcm and compress
	to different files
Date: Mon,  5 May 2014 22:19:21 +0530
Message-ID: <1399308565-14620-5-git-send-email-vinod.koul@intel.com>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B894C2619D7
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:02:53 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For managing them and adding support for more platforms

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/Makefile                     |   14 ++-
 sound/soc/intel/sst-mfld-platform-compress.c |  228 ++++++++++++++++++++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c      |  202 +----------------------
 sound/soc/intel/sst-mfld-platform.h          |    2 +
 4 files changed, 245 insertions(+), 201 deletions(-)
 create mode 100644 sound/soc/intel/sst-mfld-platform-compress.c

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 5d3fb6f..57242c4 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -2,7 +2,7 @@
 snd-soc-sst-dsp-objs := sst-dsp.o sst-firmware.o
 snd-soc-sst-acpi-objs := sst-acpi.o
 
-snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o
+snd-soc-sst-mfld-platform-objs := sst-mfld-platform-pcm.o sst-mfld-platform-compress.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
 obj-$(CONFIG_SND_SST_MFLD_PLATFORM) += snd-soc-sst-mfld-platform.o
@@ -26,3 +26,15 @@ snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+
+# SST Platform Driver
+PLATFORM_LIBS = platform-libs/controls_v2_dpcm.o
+
+snd-soc-sst-platform-objs := pcm.o compress.o $(PLATFORM_LIBS)
+obj-$(CONFIG_SND_SST_PLATFORM) += snd-soc-sst-platform.o
+
+# Relevant Machine driver
+obj-$(CONFIG_SND_SST_MACHINE) += board/
+
+# IPC driver
+obj-$(CONFIG_SND_INTEL_SST) += sst/
diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
new file mode 100644
index 0000000..16d79fb
--- /dev/null
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -0,0 +1,228 @@
+/*
+ *  sst_mfld_platform.c - Intel MID Platform driver
+ *
+ *  Copyright (C) 2010-2014 Intel Corp
+ *  Author: Vinod Koul <vinod.koul@intel.com>
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
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/compress_driver.h>
+#include "sst-mfld-platform.h"
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
+static int sst_platform_compr_set_metadata(struct snd_compr_stream *cstream,
+					struct snd_compr_metadata *metadata)
+{
+	struct sst_runtime_stream *stream  =
+		 cstream->runtime->private_data;
+
+	return stream->compr_ops->set_metadata(stream->id, metadata);
+}
+
+struct snd_compr_ops sst_platform_compr_ops = {
+
+	.open = sst_platform_compr_open,
+	.free = sst_platform_compr_free,
+	.set_params = sst_platform_compr_set_params,
+	.set_metadata = sst_platform_compr_set_metadata,
+	.trigger = sst_platform_compr_trigger,
+	.pointer = sst_platform_compr_pointer,
+	.ack = sst_platform_compr_ack,
+	.get_caps = sst_platform_compr_get_caps,
+	.get_codec_caps = sst_platform_compr_get_codec_caps,
+};
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 3600003..2beb959 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -29,8 +29,9 @@
 #include <sound/compress_driver.h>
 #include "sst-mfld-platform.h"
 
-static struct sst_device *sst;
+struct sst_device *sst;
 static DEFINE_MUTEX(sst_lock);
+extern struct snd_compr_ops sst_platform_compr_ops;
 
 int sst_register_dsp(struct sst_device *dev)
 {
@@ -465,205 +466,6 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return retval;
 }
 
-/* compress stream operations */
-static void sst_compr_fragment_elapsed(void *arg)
-{
-	struct snd_compr_stream *cstream = (struct snd_compr_stream *)arg;
-
-	pr_debug("fragment elapsed by driver\n");
-	if (cstream)
-		snd_compr_fragment_elapsed(cstream);
-}
-
-static int sst_platform_compr_open(struct snd_compr_stream *cstream)
-{
-
-	int ret_val = 0;
-	struct snd_compr_runtime *runtime = cstream->runtime;
-	struct sst_runtime_stream *stream;
-
-	stream = kzalloc(sizeof(*stream), GFP_KERNEL);
-	if (!stream)
-		return -ENOMEM;
-
-	spin_lock_init(&stream->status_lock);
-
-	/* get the sst ops */
-	if (!sst || !try_module_get(sst->dev->driver->owner)) {
-		pr_err("no device available to run\n");
-		ret_val = -ENODEV;
-		goto out_ops;
-	}
-	stream->compr_ops = sst->compr_ops;
-
-	stream->id = 0;
-	sst_set_stream_status(stream, SST_PLATFORM_INIT);
-	runtime->private_data = stream;
-	return 0;
-out_ops:
-	kfree(stream);
-	return ret_val;
-}
-
-static int sst_platform_compr_free(struct snd_compr_stream *cstream)
-{
-	struct sst_runtime_stream *stream;
-	int ret_val = 0, str_id;
-
-	stream = cstream->runtime->private_data;
-	/*need to check*/
-	str_id = stream->id;
-	if (str_id)
-		ret_val = stream->compr_ops->close(str_id);
-	module_put(sst->dev->driver->owner);
-	kfree(stream);
-	pr_debug("%s: %d\n", __func__, ret_val);
-	return 0;
-}
-
-static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
-					struct snd_compr_params *params)
-{
-	struct sst_runtime_stream *stream;
-	int retval;
-	struct snd_sst_params str_params;
-	struct sst_compress_cb cb;
-
-	stream = cstream->runtime->private_data;
-	/* construct fw structure for this*/
-	memset(&str_params, 0, sizeof(str_params));
-
-	str_params.ops = STREAM_OPS_PLAYBACK;
-	str_params.stream_type = SST_STREAM_TYPE_MUSIC;
-	str_params.device_type = SND_SST_DEVICE_COMPRESS;
-
-	switch (params->codec.id) {
-	case SND_AUDIOCODEC_MP3: {
-		str_params.codec = SST_CODEC_TYPE_MP3;
-		str_params.sparams.uc.mp3_params.codec = SST_CODEC_TYPE_MP3;
-		str_params.sparams.uc.mp3_params.num_chan = params->codec.ch_in;
-		str_params.sparams.uc.mp3_params.pcm_wd_sz = 16;
-		break;
-	}
-
-	case SND_AUDIOCODEC_AAC: {
-		str_params.codec = SST_CODEC_TYPE_AAC;
-		str_params.sparams.uc.aac_params.codec = SST_CODEC_TYPE_AAC;
-		str_params.sparams.uc.aac_params.num_chan = params->codec.ch_in;
-		str_params.sparams.uc.aac_params.pcm_wd_sz = 16;
-		if (params->codec.format == SND_AUDIOSTREAMFORMAT_MP4ADTS)
-			str_params.sparams.uc.aac_params.bs_format =
-							AAC_BIT_STREAM_ADTS;
-		else if (params->codec.format == SND_AUDIOSTREAMFORMAT_RAW)
-			str_params.sparams.uc.aac_params.bs_format =
-							AAC_BIT_STREAM_RAW;
-		else {
-			pr_err("Undefined format%d\n", params->codec.format);
-			return -EINVAL;
-		}
-		str_params.sparams.uc.aac_params.externalsr =
-						params->codec.sample_rate;
-		break;
-	}
-
-	default:
-		pr_err("codec not supported, id =%d\n", params->codec.id);
-		return -EINVAL;
-	}
-
-	str_params.aparams.ring_buf_info[0].addr  =
-					virt_to_phys(cstream->runtime->buffer);
-	str_params.aparams.ring_buf_info[0].size =
-					cstream->runtime->buffer_size;
-	str_params.aparams.sg_count = 1;
-	str_params.aparams.frag_size = cstream->runtime->fragment_size;
-
-	cb.param = cstream;
-	cb.compr_cb = sst_compr_fragment_elapsed;
-
-	retval = stream->compr_ops->open(&str_params, &cb);
-	if (retval < 0) {
-		pr_err("stream allocation failed %d\n", retval);
-		return retval;
-	}
-
-	stream->id = retval;
-	return 0;
-}
-
-static int sst_platform_compr_trigger(struct snd_compr_stream *cstream, int cmd)
-{
-	struct sst_runtime_stream *stream =
-		cstream->runtime->private_data;
-
-	return stream->compr_ops->control(cmd, stream->id);
-}
-
-static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
-					struct snd_compr_tstamp *tstamp)
-{
-	struct sst_runtime_stream *stream;
-
-	stream  = cstream->runtime->private_data;
-	stream->compr_ops->tstamp(stream->id, tstamp);
-	tstamp->byte_offset = tstamp->copied_total %
-				 (u32)cstream->runtime->buffer_size;
-	pr_debug("calc bytes offset/copied bytes as %d\n", tstamp->byte_offset);
-	return 0;
-}
-
-static int sst_platform_compr_ack(struct snd_compr_stream *cstream,
-					size_t bytes)
-{
-	struct sst_runtime_stream *stream;
-
-	stream  = cstream->runtime->private_data;
-	stream->compr_ops->ack(stream->id, (unsigned long)bytes);
-	stream->bytes_written += bytes;
-
-	return 0;
-}
-
-static int sst_platform_compr_get_caps(struct snd_compr_stream *cstream,
-					struct snd_compr_caps *caps)
-{
-	struct sst_runtime_stream *stream =
-		cstream->runtime->private_data;
-
-	return stream->compr_ops->get_caps(caps);
-}
-
-static int sst_platform_compr_get_codec_caps(struct snd_compr_stream *cstream,
-					struct snd_compr_codec_caps *codec)
-{
-	struct sst_runtime_stream *stream =
-		cstream->runtime->private_data;
-
-	return stream->compr_ops->get_codec_caps(codec);
-}
-
-static int sst_platform_compr_set_metadata(struct snd_compr_stream *cstream,
-					struct snd_compr_metadata *metadata)
-{
-	struct sst_runtime_stream *stream  =
-		 cstream->runtime->private_data;
-
-	return stream->compr_ops->set_metadata(stream->id, metadata);
-}
-
-static struct snd_compr_ops sst_platform_compr_ops = {
-
-	.open = sst_platform_compr_open,
-	.free = sst_platform_compr_free,
-	.set_params = sst_platform_compr_set_params,
-	.set_metadata = sst_platform_compr_set_metadata,
-	.trigger = sst_platform_compr_trigger,
-	.pointer = sst_platform_compr_pointer,
-	.ack = sst_platform_compr_ack,
-	.get_caps = sst_platform_compr_get_caps,
-	.get_codec_caps = sst_platform_compr_get_codec_caps,
-};
-
 static struct snd_soc_platform_driver sst_soc_platform_drv = {
 	.ops		= &sst_platform_ops,
 	.compr_ops	= &sst_platform_compr_ops,
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 1005f55..3ea4fee 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -23,6 +23,8 @@
 
 #include "sst-mfld-dsp.h"
 
+extern struct sst_device *sst;
+
 #define SST_MONO		1
 #define SST_STEREO		2
 #define SST_MAX_CAP		5
-- 
1.7.0.4
