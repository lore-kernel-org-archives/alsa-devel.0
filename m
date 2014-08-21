From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 10/11] ASoC: mfld-compress: Use dedicated function
	instead of ioctl
Date: Thu, 21 Aug 2014 18:20:49 +0530
Message-ID: <1408625450-32315-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 551A42658DE
 for <alsa-devel@alsa-project.org>; Thu, 21 Aug 2014 15:13:12 +0200 (CEST)
In-Reply-To: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Also pass sst device as an argument to function pointer prototypes of
compr_ops. This will be used to derive sst driver context.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-compress.c | 38 +++++++++++++++++++++-------
 sound/soc/intel/sst-mfld-platform.h          | 27 ++++++++++++--------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 29c059ca19e8..59467775c9b8 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -86,7 +86,7 @@ static int sst_platform_compr_free(struct snd_compr_stream *cstream)
 	/*need to check*/
 	str_id = stream->id;
 	if (str_id)
-		ret_val = stream->compr_ops->close(str_id);
+		ret_val = stream->compr_ops->close(sst->dev, str_id);
 	module_put(sst->dev->driver->owner);
 	kfree(stream);
 	pr_debug("%s: %d\n", __func__, ret_val);
@@ -158,7 +158,7 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 	cb.drain_cb_param = cstream;
 	cb.drain_notify = sst_drain_notify;
 
-	retval = stream->compr_ops->open(&str_params, &cb);
+	retval = stream->compr_ops->open(sst->dev, &str_params, &cb);
 	if (retval < 0) {
 		pr_err("stream allocation failed %d\n", retval);
 		return retval;
@@ -170,10 +170,30 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 
 static int sst_platform_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 {
-	struct sst_runtime_stream *stream =
-		cstream->runtime->private_data;
-
-	return stream->compr_ops->control(cmd, stream->id);
+	struct sst_runtime_stream *stream = cstream->runtime->private_data;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (stream->compr_ops->stream_start)
+			return stream->compr_ops->stream_start(sst->dev, stream->id);
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (stream->compr_ops->stream_drop)
+			return stream->compr_ops->stream_drop(sst->dev, stream->id);
+	case SND_COMPR_TRIGGER_DRAIN:
+		if (stream->compr_ops->stream_drain)
+			return stream->compr_ops->stream_drain(sst->dev, stream->id);
+	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
+		if (stream->compr_ops->stream_partial_drain)
+			return stream->compr_ops->stream_partial_drain(sst->dev, stream->id);
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (stream->compr_ops->stream_pause)
+			return stream->compr_ops->stream_pause(sst->dev, stream->id);
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (stream->compr_ops->stream_pause_release)
+			return stream->compr_ops->stream_pause_release(sst->dev, stream->id);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
@@ -182,7 +202,7 @@ static int sst_platform_compr_pointer(struct snd_compr_stream *cstream,
 	struct sst_runtime_stream *stream;
 
 	stream  = cstream->runtime->private_data;
-	stream->compr_ops->tstamp(stream->id, tstamp);
+	stream->compr_ops->tstamp(sst->dev, stream->id, tstamp);
 	tstamp->byte_offset = tstamp->copied_total %
 				 (u32)cstream->runtime->buffer_size;
 	pr_debug("calc bytes offset/copied bytes as %d\n", tstamp->byte_offset);
@@ -195,7 +215,7 @@ static int sst_platform_compr_ack(struct snd_compr_stream *cstream,
 	struct sst_runtime_stream *stream;
 
 	stream  = cstream->runtime->private_data;
-	stream->compr_ops->ack(stream->id, (unsigned long)bytes);
+	stream->compr_ops->ack(sst->dev, stream->id, (unsigned long)bytes);
 	stream->bytes_written += bytes;
 
 	return 0;
@@ -225,7 +245,7 @@ static int sst_platform_compr_set_metadata(struct snd_compr_stream *cstream,
 	struct sst_runtime_stream *stream  =
 		 cstream->runtime->private_data;
 
-	return stream->compr_ops->set_metadata(stream->id, metadata);
+	return stream->compr_ops->set_metadata(sst->dev, stream->id, metadata);
 }
 
 struct snd_compr_ops sst_platform_compr_ops = {
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index 09ecf44f33fb..6b4501ac477d 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -99,17 +99,24 @@ struct sst_compress_cb {
 
 struct compress_sst_ops {
 	const char *name;
-	int (*open) (struct snd_sst_params *str_params,
-			struct sst_compress_cb *cb);
-	int (*control) (unsigned int cmd, unsigned int str_id);
-	int (*tstamp) (unsigned int str_id, struct snd_compr_tstamp *tstamp);
-	int (*ack) (unsigned int str_id, unsigned long bytes);
-	int (*close) (unsigned int str_id);
-	int (*get_caps) (struct snd_compr_caps *caps);
-	int (*get_codec_caps) (struct snd_compr_codec_caps *codec);
-	int (*set_metadata) (unsigned int str_id,
+	int (*open)(struct device *dev,
+		struct snd_sst_params *str_params, struct sst_compress_cb *cb);
+	int (*stream_start)(struct device *dev, unsigned int str_id);
+	int (*stream_drop)(struct device *dev, unsigned int str_id);
+	int (*stream_drain)(struct device *dev, unsigned int str_id);
+	int (*stream_partial_drain)(struct device *dev,	unsigned int str_id);
+	int (*stream_pause)(struct device *dev, unsigned int str_id);
+	int (*stream_pause_release)(struct device *dev,	unsigned int str_id);
+
+	int (*tstamp)(struct device *dev, unsigned int str_id,
+			struct snd_compr_tstamp *tstamp);
+	int (*ack)(struct device *dev, unsigned int str_id,
+			unsigned long bytes);
+	int (*close)(struct device *dev, unsigned int str_id);
+	int (*get_caps)(struct snd_compr_caps *caps);
+	int (*get_codec_caps)(struct snd_compr_codec_caps *codec);
+	int (*set_metadata)(struct device *dev,	unsigned int str_id,
 			struct snd_compr_metadata *mdata);
-
 };
 
 struct sst_ops {
-- 
1.9.0
