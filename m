From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: doc: Fix
	uapi/sound/compress_offload.h kerneldoc comments
Date: Wed, 29 Oct 2014 08:26:08 +0100
Message-ID: <1414567569-11722-3-git-send-email-tiwai@suse.de>
References: <1414567569-11722-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0DF22604B7
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 08:26:14 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0BCEDAD9F
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 07:26:14 +0000 (UTC)
In-Reply-To: <1414567569-11722-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

so that make htmldocs works properly.
Since kerneldoc can't handle noname enum properly, name enum
sndrv_compress_encoder.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/compress_offload.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 1964026b5e09..22ed8cb7800b 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -32,7 +32,7 @@
 
 #define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
 /**
- * struct snd_compressed_buffer: compressed buffer
+ * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
  * @fragments: number of such fragments
  */
@@ -42,7 +42,7 @@ struct snd_compressed_buffer {
 } __attribute__((packed, aligned(4)));
 
 /**
- * struct snd_compr_params: compressed stream params
+ * struct snd_compr_params - compressed stream params
  * @buffer: buffer description
  * @codec: codec parameters
  * @no_wake_mode: dont wake on fragment elapsed
@@ -54,7 +54,7 @@ struct snd_compr_params {
 } __attribute__((packed, aligned(4)));
 
 /**
- * struct snd_compr_tstamp: timestamp descriptor
+ * struct snd_compr_tstamp - timestamp descriptor
  * @byte_offset: Byte offset in ring buffer to DSP
  * @copied_total: Total number of bytes copied from/to ring buffer to/by DSP
  * @pcm_frames: Frames decoded or encoded by DSP. This field will evolve by
@@ -73,7 +73,7 @@ struct snd_compr_tstamp {
 } __attribute__((packed, aligned(4)));
 
 /**
- * struct snd_compr_avail: avail descriptor
+ * struct snd_compr_avail - avail descriptor
  * @avail: Number of bytes available in ring buffer for writing/reading
  * @tstamp: timestamp infomation
  */
@@ -88,7 +88,7 @@ enum snd_compr_direction {
 };
 
 /**
- * struct snd_compr_caps: caps descriptor
+ * struct snd_compr_caps - caps descriptor
  * @codecs: pointer to array of codecs
  * @direction: direction supported. Of type snd_compr_direction
  * @min_fragment_size: minimum fragment supported by DSP
@@ -110,7 +110,7 @@ struct snd_compr_caps {
 } __attribute__((packed, aligned(4)));
 
 /**
- * struct snd_compr_codec_caps: query capability of codec
+ * struct snd_compr_codec_caps - query capability of codec
  * @codec: codec for which capability is queried
  * @num_descriptors: number of codec descriptors
  * @descriptor: array of codec capability descriptor
@@ -122,18 +122,19 @@ struct snd_compr_codec_caps {
 } __attribute__((packed, aligned(4)));
 
 /**
+ * enum sndrv_compress_encoder
  * @SNDRV_COMPRESS_ENCODER_PADDING: no of samples appended by the encoder at the
  * end of the track
  * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the encoder at the
  * beginning of the track
  */
-enum {
+enum sndrv_compress_encoder {
 	SNDRV_COMPRESS_ENCODER_PADDING = 1,
 	SNDRV_COMPRESS_ENCODER_DELAY = 2,
 };
 
 /**
- * struct snd_compr_metadata: compressed stream metadata
+ * struct snd_compr_metadata - compressed stream metadata
  * @key: key id
  * @value: key value
  */
-- 
2.1.2
