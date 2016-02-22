From: Tim Sheridan <tim.sheridan@imgtec.com>
Subject: [PATCH] ALSA: compress: Add DSP private metadata
	interface
Date: Mon, 22 Feb 2016 17:54:31 +0000
Message-ID: <1456163671-40987-1-git-send-email-tim.sheridan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E95BF260673
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 18:54:38 +0100 (CET)
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
Cc: pierre-louis.bossart@linux.intel.com, Tim Sheridan <tim.sheridan@imgtec.com>
List-Id: alsa-devel@alsa-project.org

Provides an area to communicate with a DSP to implement support for
weird and wonderful features of DSP hardware that aren't supported in
the compress offload API.

Signed-off-by: Tim Sheridan <tim.sheridan@imgtec.com>
---
 include/uapi/sound/compress_offload.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index e00d8cb..65ac445 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -30,7 +30,7 @@
 #include <sound/compress_params.h>
 
 
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 3)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
@@ -150,6 +150,8 @@ struct snd_compr_metadata {
  * SNDRV_COMPRESS_SET_PARAMS: Set codec and stream parameters
  * Note: only codec params can be changed runtime and stream params cant be
  * SNDRV_COMPRESS_GET_PARAMS: Query codec params
+ * SNDRV_COMPRESS_SET_DSP_PRIV: Set private DSP metadata
+ * SNDRV_COMPRESS_GET_DSP_PRIV: Get private DSP metadata
  * SNDRV_COMPRESS_TSTAMP: get the current timestamp value
  * SNDRV_COMPRESS_AVAIL: get the current buffer avail value.
  * This also queries the tstamp properties
@@ -171,6 +173,8 @@ struct snd_compr_metadata {
 						 struct snd_compr_metadata)
 #define SNDRV_COMPRESS_GET_METADATA	_IOWR('C', 0x15,\
 						 struct snd_compr_metadata)
+#define SNDRV_COMPRESS_SET_DSP_PRIV	_IOW('C', 0x16, struct snd_compr_metadata)
+#define SNDRV_COMPRESS_GET_DSP_PRIV	_IOWR('C', 0x17, struct snd_compr_metadata)
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
-- 
1.7.1
