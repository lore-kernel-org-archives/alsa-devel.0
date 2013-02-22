From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompress: add gapless meta data APIs
Date: Fri, 22 Feb 2013 15:22:40 +0530
Message-ID: <1361526760-20468-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id E8D7D2616C2
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 10:53:18 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Based on newly introduced kernel API, we add gapless metatdata to the library.
Since kernel can recieve only key/value pairs for metadata we add a structure for
gapless_metdata and handle this in library

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 compress.c                          |   71 +++++++++++++++++++++++++++++++++++
 include/sound/compress_offload.h    |   18 ++++++++-
 include/tinycompress/tinycompress.h |   37 ++++++++++++++++++
 include/tinycompress/version.h      |    4 +-
 4 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/compress.c b/compress.c
index d44d5fe..5b600c3 100644
--- a/compress.c
+++ b/compress.c
@@ -85,6 +85,8 @@ struct compress {
 	char error[COMPR_ERR_MAX];
 	struct compr_config *config;
 	unsigned int running:1;
+	unsigned int gapless_metadata;
+	unsigned int next_track;
 };
 
 static int oops(struct compress *compress, int e, const char *fmt, ...)
@@ -121,6 +123,17 @@ int is_compress_ready(struct compress *compress)
 	return (compress->fd > 0) ? 1 : 0;
 }
 
+static int get_compress_version(struct compress *compress)
+{
+	int version = 0;
+
+	if (ioctl(compress->fd, SNDRV_COMPRESS_IOCTL_VERSION, &version)) {
+		oops(compress, errno, "cant read version");
+		return -1;
+	}
+	return version;
+}
+
 static bool _is_codec_supported(struct compress *compress, struct compr_config *config)
 {
 	struct snd_compr_caps caps;
@@ -212,6 +225,8 @@ struct compress *compress_open(unsigned int card, unsigned int device,
 		return &bad_compress;
 	}
 
+	compress->next_track = 0;
+	compress->gapless_metadata = 0;
 	compress->config = calloc(1, sizeof(*config));
 	if (!compress->config)
 		goto input_fail;
@@ -401,6 +416,62 @@ int compress_drain(struct compress *compress)
 	return 0;
 }
 
+int compress_partial_drain(struct compress *compress)
+{
+	if (!is_compress_running(compress))
+		return oops(compress, -ENODEV, "device not ready");
+
+	if (!compress->next_track)
+		return oops(compress, -EPERM, "next track not signalled");
+	if (ioctl(compress->fd, SNDRV_COMPRESS_PARTIAL_DRAIN))
+		return oops(compress, errno, "cannot drain the stream\n");
+	compress->next_track = 0;
+	return 0;
+}
+
+int compress_next_track(struct compress *compress)
+{
+	if (!is_compress_running(compress))
+		return oops(compress, -ENODEV, "device not ready");
+
+	if (!compress->gapless_metadata)
+		return oops(compress, -EPERM, "metadata not set");
+	if (ioctl(compress->fd, SNDRV_COMPRESS_NEXT_TRACK))
+		return oops(compress, errno, "cannot set next track\n");
+	compress->next_track = 1;
+	compress->gapless_metadata = 0;
+	return 0;
+}
+
+int compress_set_gapless_metadata(struct compress *compress,
+	struct compr_gapless_mdata *mdata)
+{
+	struct snd_compr_metadata metadata;
+	int version;
+
+	if (!is_compress_ready(compress))
+		return oops(compress, -ENODEV, "device not ready");
+
+	version = get_compress_version(compress);
+	if (version <= 0)
+		return -1;
+
+	if (version < SNDRV_PROTOCOL_VERSION(0, 1, 1))
+		return oops(compress, -ENXIO, "gapless apis not supported in kernel");
+
+	metadata.key = SNDRV_COMPRESS_ENCODER_PADDING;
+	metadata.value[0] = mdata->encoder_padding;
+	if (ioctl(compress->fd, SNDRV_COMPRESS_SET_METADATA, &metadata))
+		return oops(compress, errno, "can't set metadata for stream\n");
+
+	metadata.key = SNDRV_COMPRESS_ENCODER_DELAY;
+	metadata.value[0] = mdata->encoder_delay;
+	if (ioctl(compress->fd, SNDRV_COMPRESS_SET_METADATA, &metadata))
+		return oops(compress, errno, "can't set metadata for stream\n");
+	compress->gapless_metadata = 1;
+	return 0;
+}
+
 bool is_codec_supported(unsigned int card, unsigned int device,
 		unsigned int flags, struct snd_codec *codec)
 {
diff --git a/include/sound/compress_offload.h b/include/sound/compress_offload.h
index bbb09bc..17377df 100644
--- a/include/sound/compress_offload.h
+++ b/include/sound/compress_offload.h
@@ -16,7 +16,7 @@
 #include <sound/asound.h>
 //#include <sound/compress_params.h>
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 0)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 1)
 
 struct snd_compressed_buffer {
  __u32 fragment_size;
@@ -64,11 +64,23 @@ struct snd_compr_codec_caps {
  struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
 };
 
+enum {
+	SNDRV_COMPRESS_ENCODER_PADDING = 1,
+	SNDRV_COMPRESS_ENCODER_DELAY = 2,
+};
+
+struct snd_compr_metadata {
+	 __u32 key;
+	 __u32 value[8];
+};
+
 #define SNDRV_COMPRESS_IOCTL_VERSION _IOR('C', 0x00, int)
 #define SNDRV_COMPRESS_GET_CAPS _IOWR('C', 0x10, struct snd_compr_caps)
 #define SNDRV_COMPRESS_GET_CODEC_CAPS _IOWR('C', 0x11,  struct snd_compr_codec_caps)
 #define SNDRV_COMPRESS_SET_PARAMS _IOW('C', 0x12, struct snd_compr_params)
 #define SNDRV_COMPRESS_GET_PARAMS _IOR('C', 0x13, struct snd_codec)
+#define SNDRV_COMPRESS_SET_METADATA _IOW('C', 0x14,  struct snd_compr_metadata)
+#define SNDRV_COMPRESS_GET_METADATA _IOWR('C', 0x15,  struct snd_compr_metadata)
 #define SNDRV_COMPRESS_TSTAMP _IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL _IOR('C', 0x21, struct snd_compr_avail)
 #define SNDRV_COMPRESS_PAUSE _IO('C', 0x30)
@@ -76,6 +88,8 @@ struct snd_compr_codec_caps {
 #define SNDRV_COMPRESS_START _IO('C', 0x32)
 #define SNDRV_COMPRESS_STOP _IO('C', 0x33)
 #define SNDRV_COMPRESS_DRAIN _IO('C', 0x34)
-
+#define SNDRV_COMPRESS_NEXT_TRACK _IO('C', 0x35)
+#define SNDRV_COMPRESS_PARTIAL_DRAIN _IO('C', 0x36)
 #define SND_COMPR_TRIGGER_DRAIN 7  
+#define SND_COMPR_TRIGGER_PARTIAL_DRAIN 8
 #endif
diff --git a/include/tinycompress/tinycompress.h b/include/tinycompress/tinycompress.h
index 13dea3e..e129817 100644
--- a/include/tinycompress/tinycompress.h
+++ b/include/tinycompress/tinycompress.h
@@ -69,6 +69,11 @@ struct compr_config {
 	struct snd_codec *codec;
 };
 
+struct compr_gapless_mdata {
+	__u32 encoder_delay;
+	__u32 encoder_padding;
+};
+
 #define COMPRESS_OUT        0x00000000
 #define COMPRESS_IN         0x10000000
 
@@ -165,6 +170,38 @@ int compress_resume(struct compress *compress);
 int compress_drain(struct compress *compress);
 
 /*
+ * compress_next_track: set the next track for stream
+ *
+ * return 0 on success, negative on error
+ *
+ * @compress: compress stream to be transistioned to next track
+ */
+int compress_next_track(struct compress *compress);
+
+/*
+ * compress_partial_drain: drain will return after the last frame is decoded
+ * by DSP and will play the , All the data written into compressed
+ * ring buffer is decoded
+ *
+ * return 0 on success, negative on error
+ *
+ * @compress: compress stream to be drain
+ */
+int compress_partial_drain(struct compress *compress);
+
+/*
+ * compress_set_gapless_metadata: set gapless metadata of a compress strem
+ *
+ * return 0 on success, negative on error
+ *
+ * @compress: compress stream for which metadata has to set
+ * @mdata: metadata encoder delay and  padding
+ */
+
+int compress_set_gapless_metadata(struct compress *compress,
+			struct compr_gapless_mdata *mdata);
+
+/*
  * is_codec_supported:check if the given codec is supported
  * returns true when supported, false if not
  *
diff --git a/include/tinycompress/version.h b/include/tinycompress/version.h
index 89f0f4e..db191d6 100644
--- a/include/tinycompress/version.h
+++ b/include/tinycompress/version.h
@@ -56,7 +56,7 @@
 
 #define TINYCOMPRESS_LIB_MAJOR		0 /* major number of library version */
 #define TINYCOMPRESS_LIB_MINOR		0 /* minor number of library version */
-#define TINYCOMPRESS_LIB_SUBMINOR	1 /* subminor number of library version */
+#define TINYCOMPRESS_LIB_SUBMINOR	2 /* subminor number of library version */
 
 /** library version */
 #define TINYCOMPRESS_LIB_VERSION \
@@ -65,6 +65,6 @@
 		  TINYCOMPRESS_LIB_SUBMINOR)
 
 /** library version (string) */
-#define TINYCOMPRESS_LIB_VERSION_STR	"0.0.1"
+#define TINYCOMPRESS_LIB_VERSION_STR	"0.0.2"
 
 #endif
-- 
1.7.0.4
