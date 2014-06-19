From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] tinycompress: update headers for packed,
	aligned
Date: Thu, 19 Jun 2014 15:07:03 +0530
Message-ID: <1403170623-6288-2-git-send-email-vinod.koul@intel.com>
References: <1403170623-6288-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0359F261A9B
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 11:36:32 +0200 (CEST)
In-Reply-To: <1403170623-6288-1-git-send-email-vinod.koul@intel.com>
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

commit "6b24a8dd: ALSA: compress: fix the struct alignment to 4 bytes" updated
compress struct to force packed and aligned to 4 bytes. Update here a s well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/compress_offload.h |   15 ++++++++-------
 include/sound/compress_params.h  |   14 +++++++-------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/sound/compress_offload.h b/include/sound/compress_offload.h
index 6a8e97f..980f69f 100644
--- a/include/sound/compress_offload.h
+++ b/include/sound/compress_offload.h
@@ -22,16 +22,17 @@
 #include <sound/asound.h>
 #include <sound/compress_params.h>
 #define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 1, 2)
+
 struct snd_compressed_buffer {
  __u32 fragment_size;
  __u32 fragments;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_compr_params {
  struct snd_compressed_buffer buffer;
  struct snd_codec codec;
  __u8 no_wake_mode;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_compr_tstamp {
  __u32 byte_offset;
@@ -39,12 +40,12 @@ struct snd_compr_tstamp {
  __u32 pcm_frames;
  __u32 pcm_io_frames;
  __u32 sampling_rate;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_compr_avail {
  __u64 avail;
  struct snd_compr_tstamp tstamp;
-};
+}__attribute__((packed, aligned(4)));
 
 enum snd_compr_direction {
  SND_COMPRESS_PLAYBACK = 0,
@@ -60,13 +61,13 @@ struct snd_compr_caps {
  __u32 max_fragments;
  __u32 codecs[MAX_NUM_CODECS];
  __u32 reserved[11];
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_compr_codec_caps {
  __u32 codec;
  __u32 num_descriptors;
  struct snd_codec_desc descriptor[MAX_NUM_CODEC_DESCRIPTORS];
-};
+}__attribute__((packed, aligned(4)));
 
 enum {
 	SNDRV_COMPRESS_ENCODER_PADDING = 1,
@@ -76,7 +77,7 @@ enum {
 struct snd_compr_metadata {
 	 __u32 key;
 	 __u32 value[8];
-};
+}__attribute__((packed, aligned(4)));
 
 #define SNDRV_COMPRESS_IOCTL_VERSION _IOR('C', 0x00, int)
 #define SNDRV_COMPRESS_GET_CAPS _IOWR('C', 0x10, struct snd_compr_caps)
diff --git a/include/sound/compress_params.h b/include/sound/compress_params.h
index 378417a..9802292 100644
--- a/include/sound/compress_params.h
+++ b/include/sound/compress_params.h
@@ -182,23 +182,23 @@ struct snd_enc_vorbis {
  __u32 max_bit_rate;
  __u32 min_bit_rate;
  __u32 downmix;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_enc_real {
  __u32 quant_bits;
  __u32 start_region;
  __u32 num_regions;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_enc_flac {
  __u32 num;
  __u32 gain;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_enc_generic {
  __u32 bw;
  __s32 reserved[15];
-};
+}__attribute__((packed, aligned(4)));
 
 union snd_codec_options {
  struct snd_enc_wma wma;
@@ -206,7 +206,7 @@ union snd_codec_options {
  struct snd_enc_real real;
  struct snd_enc_flac flac;
  struct snd_enc_generic generic;
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_codec_desc {
  __u32 max_ch;
@@ -220,7 +220,7 @@ struct snd_codec_desc {
  __u32 formats;
  __u32 min_buffer;
  __u32 reserved[15];
-};
+}__attribute__((packed, aligned(4)));
 
 struct snd_codec {
  __u32 id;
@@ -236,6 +236,6 @@ struct snd_codec {
  __u32 align;
  union snd_codec_options options;
  __u32 reserved[3];
-};
+}__attribute__((packed, aligned(4)));
 
 #endif
-- 
1.7.0.4
