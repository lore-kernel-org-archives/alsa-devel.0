From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] tinycompress: update the header to kernel
	API v0.1.2
Date: Mon, 16 Dec 2013 20:44:58 +0530
Message-ID: <1387206900-9441-2-git-send-email-vinod.koul@intel.com>
References: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BAEFC261685
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 17:14:19 +0100 (CET)
In-Reply-To: <1387206900-9441-1-git-send-email-vinod.koul@intel.com>
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

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/compress_offload.h |   23 ++++++++++++++---------
 include/sound/compress_params.h  |    9 +++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/sound/compress_offload.h b/include/sound/compress_offload.h
index 17377df..6a8e97f 100644
--- a/include/sound/compress_offload.h
+++ b/include/sound/compress_offload.h
@@ -7,17 +7,21 @@
  ***   structures, and macros generated from the original header, and thus,
  ***   contains no copyrightable information.
  ***
+ ***   To edit the content of this header, modify the corresponding
+ ***   source file (e.g. under external/kernel-headers/original/) then
+ ***   run bionic/libc/kernel/tools/update_all.py
+ ***
+ ***   Any manual change here will be lost the next time this script will
+ ***   be run. You've been warned!
+ ***
  ****************************************************************************
  ****************************************************************************/
 #ifndef __COMPRESS_OFFLOAD_H
 #define __COMPRESS_OFFLOAD_H
-
 #include <linux/types.h>
 #include <sound/asound.h>
-//#include <sound/compress_params.h>
-
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 1)
-
+#include <sound/compress_params.h>
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
 struct snd_compressed_buffer {
  __u32 fragment_size;
  __u32 fragments;
@@ -32,8 +36,8 @@ struct snd_compr_params {
 struct snd_compr_tstamp {
  __u32 byte_offset;
  __u32 copied_total;
- snd_pcm_uframes_t pcm_frames;
- snd_pcm_uframes_t pcm_io_frames;
+ __u32 pcm_frames;
+ __u32 pcm_io_frames;
  __u32 sampling_rate;
 };
 
@@ -90,6 +94,7 @@ struct snd_compr_metadata {
 #define SNDRV_COMPRESS_DRAIN _IO('C', 0x34)
 #define SNDRV_COMPRESS_NEXT_TRACK _IO('C', 0x35)
 #define SNDRV_COMPRESS_PARTIAL_DRAIN _IO('C', 0x36)
-#define SND_COMPR_TRIGGER_DRAIN 7  
-#define SND_COMPR_TRIGGER_PARTIAL_DRAIN 8
+#define SND_COMPR_TRIGGER_DRAIN 7
+#define SND_COMPR_TRIGGER_NEXT_TRACK 8
+#define SND_COMPR_TRIGGER_PARTIAL_DRAIN 9
 #endif
diff --git a/include/sound/compress_params.h b/include/sound/compress_params.h
index bc977c5..deda425 100644
--- a/include/sound/compress_params.h
+++ b/include/sound/compress_params.h
@@ -7,11 +7,19 @@
  ***   structures, and macros generated from the original header, and thus,
  ***   contains no copyrightable information.
  ***
+ ***   To edit the content of this header, modify the corresponding
+ ***   source file (e.g. under external/kernel-headers/original/) then
+ ***   run bionic/libc/kernel/tools/update_all.py
+ ***
+ ***   Any manual change here will be lost the next time this script will
+ ***   be run. You've been warned!
+ ***
  ****************************************************************************
  ****************************************************************************/
 #ifndef __SND_COMPRESS_PARAMS_H
 #define __SND_COMPRESS_PARAMS_H
 
+#include <linux/types.h>
 #define MAX_NUM_CODECS 32
 #define MAX_NUM_CODEC_DESCRIPTORS 32
 #define MAX_NUM_BITRATES 32
@@ -30,6 +38,7 @@
 #define SND_AUDIOCODEC_G723_1 ((__u32) 0x0000000C)
 #define SND_AUDIOCODEC_G729 ((__u32) 0x0000000D)
 
+#define SND_AUDIOCODEC_MAX SND_AUDIOCODEC_G729
 #define SND_AUDIOPROFILE_PCM ((__u32) 0x00000001)
 
 #define SND_AUDIOCHANMODE_MP3_MONO ((__u32) 0x00000001)
-- 
1.7.0.4
