From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 46/53] ALSA: x86: Use the standard ELD bytes
	definitions
Date: Thu,  2 Feb 2017 18:03:00 +0100
Message-ID: <20170202170307.24484-48-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F2E19267594
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:17 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

We have some constants defined in drm/drm_edid.h, and clean up our own
definitions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     |  14 ++---
 sound/x86/intel_hdmi_audio.h     |   3 +-
 sound/x86/intel_hdmi_lpe_audio.h | 119 ---------------------------------------
 3 files changed, 9 insertions(+), 127 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 985b7e8d4eae..496d3e92b2a8 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -451,7 +451,7 @@ static int snd_intelhad_channel_allocation(struct snd_intelhad *intelhaddata,
 	 */
 
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (intelhaddata->eld.speaker_allocation_block & (1 << i))
+		if (intelhaddata->eld[DRM_ELD_SPEAKER] & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -496,8 +496,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 		return;
 	}
 
-	dev_dbg(intelhaddata->dev, "eld.speaker_allocation_block = %x\n",
-			intelhaddata->eld.speaker_allocation_block);
+	dev_dbg(intelhaddata->dev, "eld speaker = %x\n",
+		intelhaddata->eld[DRM_ELD_SPEAKER]);
 
 	/* WA: Fix the max channel supported to 8 */
 
@@ -508,14 +508,14 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	 */
 
 	/* if 0x2F < eld < 0x4F fall back to 0x2f, else fall back to 0x4F */
-	eld_high = intelhaddata->eld.speaker_allocation_block & eld_high_mask;
+	eld_high = intelhaddata->eld[DRM_ELD_SPEAKER] & eld_high_mask;
 	if ((eld_high & (eld_high-1)) && (eld_high > 0x1F)) {
 		/* eld_high & (eld_high-1): if more than 1 bit set */
 		/* 0x1F: 7 channels */
 		for (i = 1; i < 4; i++) {
 			high_msb = eld_high & (0x80 >> i);
 			if (high_msb) {
-				intelhaddata->eld.speaker_allocation_block &=
+				intelhaddata->eld[DRM_ELD_SPEAKER] &=
 					high_msb | 0xF;
 				break;
 			}
@@ -523,7 +523,7 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(eld_speaker_allocation_bits); i++) {
-		if (intelhaddata->eld.speaker_allocation_block & (1 << i))
+		if (intelhaddata->eld[DRM_ELD_SPEAKER] & (1 << i))
 			spk_mask |= eld_speaker_allocation_bits[i];
 	}
 
@@ -1743,7 +1743,7 @@ static void had_audio_wq(struct work_struct *work)
 			break;
 		}
 
-		memcpy(&ctx->eld, eld->eld_data, sizeof(ctx->eld));
+		memcpy(ctx->eld, eld->eld_data, sizeof(ctx->eld));
 
 		ctx->dp_output = pdata->dp_output;
 		ctx->tmds_clock_speed = pdata->tmds_clock_speed;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 2804e94a6710..4ccaa8b18566 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -37,6 +37,7 @@
 #include <sound/asoundef.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <drm/drm_edid.h>
 #include "intel_hdmi_lpe_audio.h"
 
 #define PCM_INDEX		0
@@ -107,7 +108,7 @@ struct snd_intelhad {
 	enum had_drv_status	drv_status;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
-	union otm_hdmi_eld_t	eld;
+	unsigned char	eld[HDMI_MAX_ELD_BYTES];
 	bool dp_output;
 	enum		intel_had_aud_buf_type curr_buf;
 	int		valid_buf_cnt;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 1e7e6db987c6..f9c184960b34 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -104,125 +104,6 @@
 #define MAX_CNT			0xFF
 #define HAD_SUSPEND_DELAY	1000
 
-#define OTM_HDMI_ELD_SIZE 128
-
-union otm_hdmi_eld_t {
-	unsigned char eld_data[OTM_HDMI_ELD_SIZE];
-	struct {
-		/* Byte[0] = ELD Version Number */
-		union {
-			unsigned char   byte0;
-			struct {
-				unsigned char reserved:3; /* Reserf */
-				unsigned char eld_ver:5; /* ELD Version Number */
-				/* 00000b - reserved
-				 * 00001b - first rev, obsoleted
-				 * 00010b - version 2, supporting CEA version
-				 *			861D or below
-				 * 00011b:11111b - reserved
-				 * for future
-				 */
-			};
-		};
-
-		/* Byte[1] = Vendor Version Field */
-		union {
-			unsigned char vendor_version;
-			struct {
-				unsigned char reserved1:3;
-				unsigned char veld_ver:5; /* Version number of the ELD
-						     * extension. This value is
-						     * provisioned and unique to
-						     * each vendor.
-						     */
-			};
-		};
-
-		/* Byte[2] = Baseline Length field */
-		unsigned char baseline_eld_length; /* Length of the Baseline structure
-					      *	divided by Four.
-					      */
-
-		/* Byte [3] = Reserved for future use */
-		unsigned char byte3;
-
-		/* Starting of the BaseLine EELD structure
-		 * Byte[4] = Monitor Name Length
-		 */
-		union {
-			unsigned char byte4;
-			struct {
-				unsigned char mnl:5;
-				unsigned char cea_edid_rev_id:3;
-			};
-		};
-
-		/* Byte[5] = Capabilities */
-		union {
-			unsigned char capabilities;
-			struct {
-				unsigned char hdcp:1; /* HDCP support */
-				unsigned char ai_support:1;   /* AI support */
-				unsigned char connection_type:2; /* Connection type
-							    * 00 - HDMI
-							    * 01 - DP
-							    * 10 -11  Reserved
-							    * for future
-							    * connection types
-							    */
-				unsigned char sadc:4; /* Indicates number of 3 bytes
-						 * Short Audio Descriptors.
-						 */
-			};
-		};
-
-		/* Byte[6] = Audio Synch Delay */
-		unsigned char audio_synch_delay; /* Amount of time reported by the
-					    * sink that the video trails audio
-					    * in milliseconds.
-					    */
-
-		/* Byte[7] = Speaker Allocation Block */
-		union {
-			unsigned char speaker_allocation_block;
-			struct {
-				unsigned char flr:1; /*Front Left and Right channels*/
-				unsigned char lfe:1; /*Low Frequency Effect channel*/
-				unsigned char fc:1;  /*Center transmission channel*/
-				unsigned char rlr:1; /*Rear Left and Right channels*/
-				unsigned char rc:1; /*Rear Center channel*/
-				unsigned char flrc:1; /*Front left and Right of Center
-						 *transmission channels
-						 */
-				unsigned char rlrc:1; /*Rear left and Right of Center
-						 *transmission channels
-						 */
-				unsigned char reserved3:1; /* Reserved */
-			};
-		};
-
-		/* Byte[8 - 15] - 8 Byte port identification value */
-		unsigned char port_id_value[8];
-
-		/* Byte[16 - 17] - 2 Byte Manufacturer ID */
-		unsigned char manufacturer_id[2];
-
-		/* Byte[18 - 19] - 2 Byte Product ID */
-		unsigned char product_id[2];
-
-		/* Byte [20-83] - 64 Bytes of BaseLine Data */
-		unsigned char mn_sand_sads[64]; /* This will include
-					   * - ASCII string of Monitor name
-					   * - List of 3 byte SADs
-					   * - Zero padding
-					   */
-
-		/* Vendor ELD Block should continue here!
-		 * No Vendor ELD block defined as of now.
-		 */
-	} __packed;
-};
-
 enum had_drv_status {
 	HAD_DRV_CONNECTED,
 	HAD_DRV_RUNNING,
-- 
2.11.0
