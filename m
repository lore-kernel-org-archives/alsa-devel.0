From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] compress: add support for gapless playback
Date: Mon, 11 Feb 2013 04:22:45 -0800
Message-ID: <1360585365-16891-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D90E42616DB
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 13:47:42 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

this adds new API for sound compress to support gapless playback.
As noted in Documentation change, we add API to send metadata of encoder and
padding delay to DSP. Also add API for indicating EOF and switching to
subsequent track

Also bump the compress API version

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
v2:
- Make it a patch, not RFC
- split metadata to key/value pairs, and send multiple keys
- add get_metadata api
- split partial_drain to next_data & partial_drain
- add stream states for transistion
- update documentation
---
 Documentation/sound/alsa/compress_offload.txt |   46 +++++++++
 include/sound/compress_driver.h               |    4 +
 include/uapi/sound/asound.h                   |    4 +-
 include/uapi/sound/compress_offload.h         |   36 +++++++-
 sound/core/compress_offload.c                 |  129 ++++++++++++++++++++++++-
 5 files changed, 215 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/alsa/compress_offload.txt b/Documentation/sound/alsa/compress_offload.txt
index 90e9b3a..0bcc551 100644
--- a/Documentation/sound/alsa/compress_offload.txt
+++ b/Documentation/sound/alsa/compress_offload.txt
@@ -145,6 +145,52 @@ Modifications include:
 - Addition of encoding options when required (derived from OpenMAX IL)
 - Addition of rateControlSupported (missing in OpenMAX AL)
 
+Gapless Playback
+================
+When playing thru an album, the decoders have the ability to skip the encoder
+delay and padding and directly move from one track content to another. The end
+user can perceive this as gapless playback as we dont have silence while
+switching from one track to another
+
+Also, there might be low-intensity noises due to encoding. Perfect gapless is
+difficult to reach with all types of compressed data, but works fine with most
+music content. The decoder needs to know the encoder delay and encoder padding.
+So we need to pass this to DSP. This metadata is extracted from ID3/MP4 headers
+and are not present by default in the bitstream, hence the need for a new
+interface to pass this information to the DSP. Also DSP and userspace needs to
+switch from one track to another and start using data for second track.
+
+The main additions are:
+
+- set_metadata
+This routine sets the encoder delay and encoder padding. This can be used by
+decoder to strip the silence. This needs to be set before the data in the track
+is written.
+
+- set_next_track
+This routine tells DSP that metadata and write operation sent after this would
+correspond to subsequent track
+
+- partial drain
+This is called when end of file is reached. The userspace can inform DSP that
+EOF is reached and now DSP can start skipping padding delay. Also next write
+data would belong to next track
+
+Sequence flow for gapless would be:
+- Open
+- Get caps / codec caps
+- Set params
+- Set metadata of the first track
+- Fill data of the first track
+- Trigger start
+- User-space finished sending all,
+- Indicaite next track data by sending set_next_track
+- Set metadata of the next track
+- then call partial_drain to flush most of buffer in DSP
+- Fill data of the next track
+- DSP switches to second track
+(note: order for partial_drain and write for next track can be reversed as well)
+
 Not supported:
 
 - Support for VoIP/circuit-switched calls is not the target of this
diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index f2912ab..95e955f 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -110,6 +110,10 @@ struct snd_compr_ops {
 			struct snd_compr_params *params);
 	int (*get_params)(struct snd_compr_stream *stream,
 			struct snd_codec *params);
+	int (*set_metadata)(struct snd_compr_stream *stream,
+			struct snd_compr_metadata *metadata);
+	int (*get_metadata)(struct snd_compr_stream *stream,
+			struct snd_compr_metadata *metadata);
 	int (*trigger)(struct snd_compr_stream *stream, int cmd);
 	int (*pointer)(struct snd_compr_stream *stream,
 			struct snd_compr_tstamp *tstamp);
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 1774a5c..88a6770 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -271,7 +271,9 @@ typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_PAUSED		((__force snd_pcm_state_t) 6) /* stream is paused */
 #define	SNDRV_PCM_STATE_SUSPENDED	((__force snd_pcm_state_t) 7) /* hardware is suspended */
 #define	SNDRV_PCM_STATE_DISCONNECTED	((__force snd_pcm_state_t) 8) /* hardware is disconnected */
-#define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_DISCONNECTED
+#define SNDRV_PCM_STATE_NEXT_TRACK	((__force snd_pcm_state_t) 9) /* stream will move to next track */
+#define SNDRV_PCM_STATE_PARTIAL_DRAIN	((__force snd_pcm_state_t) 10) /* stream is draining partially */
+#define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_PARTIAL_DRAIN
 
 enum {
 	SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 05341a4..1d63993 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -30,7 +30,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 0)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 1)
 /**
  * struct snd_compressed_buffer: compressed buffer
  * @fragment_size: size of buffer fragment in bytes
@@ -121,6 +121,32 @@ struct snd_compr_codec_caps {
 	struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
 };
 
+enum {
+	SNDRV_COMPRESS_ENCODER_PADDING = 1,
+	SNDRV_COMPRESS_ENCODER_DELAY = 2,
+};
+
+/**
+ * struct snd_compr_keyvalue: compressed stream key/value pairs
+ * @key: key id
+ * @value: key value
+ */
+
+struct snd_compr_keyvalue {
+	 __u32 key;
+	 __u32 value;
+};
+
+/**
+ * struct snd_compr_metadata: compressed stream metadata
+ * @count: number of keys
+ * @keys: pointer to count keys
+ */
+struct snd_compr_metadata {
+	__u32 count;
+	struct snd_compr_keyvalue *keys;
+};
+
 /**
  * compress path ioctl definitions
  * SNDRV_COMPRESS_GET_CAPS: Query capability of DSP
@@ -145,6 +171,10 @@ struct snd_compr_codec_caps {
 						struct snd_compr_codec_caps)
 #define SNDRV_COMPRESS_SET_PARAMS	_IOW('C', 0x12, struct snd_compr_params)
 #define SNDRV_COMPRESS_GET_PARAMS	_IOR('C', 0x13, struct snd_codec)
+#define SNDRV_COMPRESS_SET_METADATA	_IOW('C', 0x14,\
+						 struct snd_compr_metadata)
+#define SNDRV_COMPRESS_GET_METADATA	_IOW('C', 0x15,\
+						 struct snd_compr_metadata)
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
@@ -152,10 +182,14 @@ struct snd_compr_codec_caps {
 #define SNDRV_COMPRESS_START		_IO('C', 0x32)
 #define SNDRV_COMPRESS_STOP		_IO('C', 0x33)
 #define SNDRV_COMPRESS_DRAIN		_IO('C', 0x34)
+#define SNDRV_COMPRESS_NEXT_TRACK	_IO('C', 0x35)
+#define SNDRV_COMPRESS_PARTIAL_DRAIN	_IO('C', 0x36)
 /*
  * TODO
  * 1. add mmap support
  *
  */
 #define SND_COMPR_TRIGGER_DRAIN 7 /*FIXME move this to pcm.h */
+#define SND_COMPR_TRIGGER_NEXT_TRACK 8
+#define SND_COMPR_TRIGGER_PARTIAL_DRAIN 9
 #endif
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index ad11dc9..4928209 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -262,9 +262,14 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 
 	stream = &data->stream;
 	mutex_lock(&stream->device->lock);
-	/* write is allowed when stream is running or has been steup */
+	/* write is allowed when stream is running or has been steup
+	 * also stream cna be written when next_track info has been setup
+	 * or its has partially drained
+	 */
 	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
-			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
+			stream->runtime->state != SNDRV_PCM_STATE_RUNNING &&
+			stream->runtime->state != SNDRV_PCM_STATE_NEXT_TRACK &&
+			stream->runtime->state != SNDRV_PCM_STATE_PARTIAL_DRAIN) {
 		mutex_unlock(&stream->device->lock);
 		return -EBADFD;
 	}
@@ -288,6 +293,9 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
 		pr_debug("stream prepared, Houston we are good to go\n");
 	}
+	if (stream->runtime->state == SNDRV_PCM_STATE_NEXT_TRACK ||
+			stream->runtime->state == SNDRV_PCM_STATE_PARTIAL_DRAIN)
+		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
 
 	mutex_unlock(&stream->device->lock);
 	return retval;
@@ -514,6 +522,78 @@ out:
 	return retval;
 }
 
+static int
+snd_compr_copy_metadata(struct snd_compr_metadata **arg, unsigned long user)
+{
+	struct snd_compr_metadata _mdata, *mdata;
+	int len;
+
+	if (copy_from_user(&_mdata, (void __user *)user,
+				sizeof(_mdata)))
+		return -EFAULT;
+
+	len = sizeof(_mdata.count) + _mdata.count * sizeof(*_mdata.keys);
+
+	mdata = kmalloc(len, GFP_KERNEL);
+	if (!mdata)
+		return -ENOMEM;
+
+	if (copy_from_user(mdata, (void __user *)arg, len)) {
+		kfree(mdata);
+		return -EFAULT;
+	}
+	*arg = mdata;
+	return len;
+}
+
+static int
+snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
+{
+	struct snd_compr_metadata *mdata;
+	int retval;
+
+	if (!stream->ops->set_metadata)
+		return -ENXIO;
+	/*
+	* we should allow parameter change only when stream has been
+	* opened not in other cases
+	*/
+	retval = snd_compr_copy_metadata(&mdata, arg);
+	if (retval <= 0)
+		return retval;
+
+	retval = stream->ops->set_metadata(stream, mdata);
+
+	kfree(mdata);
+	return retval;
+}
+
+static int
+snd_compr_get_metadata(struct snd_compr_stream *stream, unsigned long arg)
+{
+	struct snd_compr_metadata *mdata;
+	int retval, len;
+
+	if (!stream->ops->get_metadata)
+		return -ENXIO;
+
+	len = snd_compr_copy_metadata(&mdata, arg);
+	if (len <= 0)
+		return len;
+	retval = stream->ops->get_metadata(stream, mdata);
+	if (retval != 0)
+		goto out;
+
+	if (copy_to_user((void __user *)arg, mdata, len)) {
+		retval = -EFAULT;
+		goto out;
+	}
+
+out:
+	kfree(mdata);
+	return retval;
+}
+
 static inline int
 snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
 {
@@ -594,6 +674,38 @@ static int snd_compr_drain(struct snd_compr_stream *stream)
 	return retval;
 }
 
+static int snd_compr_partial_drain(struct snd_compr_stream *stream)
+{
+	int retval;
+
+	/* we can partially drain streams, only when next track info has been
+	 * passed to the dsp
+	 */
+	if (stream->runtime->state != SNDRV_PCM_STATE_NEXT_TRACK)
+		return -EPERM;
+
+	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_PARTIAL_DRAIN);
+	if (retval != 0)
+		return retval;
+	stream->runtime->state = SNDRV_PCM_STATE_PARTIAL_DRAIN;
+	return 0;
+}
+
+static int snd_compr_next_track(struct snd_compr_stream *stream)
+{
+	int retval;
+
+	/* only a running stream can transition to next track */
+	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
+		return -EPERM;
+
+	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_NEXT_TRACK);
+	if (retval != 0)
+		return retval;
+	stream->runtime->state = SNDRV_PCM_STATE_NEXT_TRACK;
+	return 0;
+}
+
 static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 {
 	struct snd_compr_file *data = f->private_data;
@@ -623,6 +735,12 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
 		retval = snd_compr_get_params(stream, arg);
 		break;
+	case _IOC_NR(SNDRV_COMPRESS_SET_METADATA):
+		retval = snd_compr_set_metadata(stream, arg);
+		break;
+	case _IOC_NR(SNDRV_COMPRESS_GET_METADATA):
+		retval = snd_compr_get_metadata(stream, arg);
+		break;
 	case _IOC_NR(SNDRV_COMPRESS_TSTAMP):
 		retval = snd_compr_tstamp(stream, arg);
 		break;
@@ -644,6 +762,13 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
 		retval = snd_compr_drain(stream);
 		break;
+	case _IOC_NR(SNDRV_COMPRESS_PARTIAL_DRAIN):
+		retval = snd_compr_partial_drain(stream);
+		break;
+	case _IOC_NR(SNDRV_COMPRESS_NEXT_TRACK):
+		retval = snd_compr_next_track(stream);
+		break;
+
 	}
 	mutex_unlock(&stream->device->lock);
 	return retval;
-- 
1.7.0.4
