From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 48/53] ALSA: x86: Clean up unused defines and
	inclusions
Date: Thu,  2 Feb 2017 18:03:02 +0100
Message-ID: <20170202170307.24484-50-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B97267590
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
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

Many defines and constants are left unused.  Clean them up.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 10 ++++--
 sound/x86/intel_hdmi_audio.h     | 11 +------
 sound/x86/intel_hdmi_lpe_audio.h | 68 +++++++---------------------------------
 3 files changed, 20 insertions(+), 69 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index f825d514500e..82f48fbcd74b 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -21,19 +21,21 @@
  * ALSA driver for Intel HDMI audio
  */
 
+#include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
-#include <linux/acpi.h>
+#include <linux/pm_runtime.h>
 #include <asm/cacheflush.h>
-#include <sound/pcm.h>
 #include <sound/core.h>
+#include <sound/asoundef.h>
+#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 #include <sound/control.h>
-#include <sound/initval.h>
+#include <drm/drm_edid.h>
 #include <drm/intel_lpe_audio.h>
 #include "intel_hdmi_audio.h"
 
@@ -929,6 +931,8 @@ static int snd_intelhad_prog_n(u32 aud_samp_freq, u32 *n_param,
 	return 0;
 }
 
+#define MAX_CNT			0xFF
+
 static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 {
 	u32 hdmi_status = 0, i = 0;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 9dc0da474f05..dea51fcfc07f 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -30,20 +30,11 @@
 #ifndef _INTEL_HDMI_AUDIO_H_
 #define _INTEL_HDMI_AUDIO_H_
 
-#include <linux/types.h>
-#include <sound/initval.h>
-#include <linux/version.h>
-#include <linux/pm_runtime.h>
-#include <sound/asoundef.h>
-#include <sound/control.h>
-#include <sound/pcm.h>
-#include <drm/drm_edid.h>
 #include "intel_hdmi_lpe_audio.h"
 
 #define PCM_INDEX		0
 #define MAX_PB_STREAMS		1
 #define MAX_CAP_STREAMS		0
-#define HDMI_AUDIO_DRIVER	"hdmi-audio"
 
 #define HDMI_INFO_FRAME_WORD1	0x000a0184
 #define DP_INFO_FRAME_WORD1	0x00441b84
@@ -85,7 +76,7 @@ struct ring_buf_info {
 	u8	is_valid;
 };
 
-/**
+/*
  * struct snd_intelhad - intelhad driver structure
  *
  * @card: ptr to hold card details
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 0e8397970e4a..5a5adb7f0cde 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -23,20 +23,6 @@
 #ifndef __INTEL_HDMI_LPE_AUDIO_H
 #define __INTEL_HDMI_LPE_AUDIO_H
 
-#include <linux/types.h>
-#include <sound/initval.h>
-#include <linux/version.h>
-#include <linux/pm_runtime.h>
-#include <linux/platform_device.h>
-#include <sound/asoundef.h>
-#include <sound/control.h>
-#include <sound/pcm.h>
-
-#define AUD_CONFIG_VALID_BIT			(1<<9)
-#define AUD_CONFIG_DP_MODE			(1<<15)
-#define AUD_CONFIG_BLOCK_BIT			(1<<7)
-
-#define HMDI_LPE_AUDIO_DRIVER_NAME		"intel-hdmi-lpe-audio"
 #define HAD_MAX_DEVICES		1
 #define HAD_MIN_CHANNEL		2
 #define HAD_MAX_CHANNEL		8
@@ -96,14 +82,6 @@
 /* Naud Value */
 #define DP_NAUD_VAL					32768
 
-/* _AUD_CONFIG register MASK */
-#define AUD_CONFIG_MASK_UNDERRUN	0xC0000000
-#define AUD_CONFIG_MASK_SRDBG		0x00000002
-#define AUD_CONFIG_MASK_FUNCRST		0x00000001
-
-#define MAX_CNT			0xFF
-#define HAD_SUSPEND_DELAY	1000
-
 enum had_drv_status {
 	HAD_DRV_CONNECTED,
 	HAD_DRV_RUNNING,
@@ -120,17 +98,10 @@ enum intel_had_aud_buf_type {
 	HAD_BUF_TYPE_D = 3,
 };
 
-enum num_aud_ch {
-	CH_STEREO = 0,
-	CH_THREE_FOUR = 1,
-	CH_FIVE_SIX = 2,
-	CH_SEVEN_EIGHT = 3
-};
-
 /* HDMI Controller register offsets - audio domain common */
 /* Base address for below regs = 0x65000 */
 enum hdmi_ctrl_reg_offset_common {
-	AUDIO_HDMI_CONFIG_A	= 0x000,
+	AUDIO_HDMI_CONFIG_A = 0x000,
 	AUDIO_HDMI_CONFIG_B = 0x800,
 	AUDIO_HDMI_CONFIG_C = 0x900,
 };
@@ -220,6 +191,10 @@ union aud_cfg {
 	u32 regval;
 };
 
+#define AUD_CONFIG_BLOCK_BIT			(1 << 7)
+#define AUD_CONFIG_VALID_BIT			(1 << 9)
+#define AUD_CONFIG_DP_MODE			(1 << 15)
+
 /* Audio Channel Status 0 Attributes */
 union aud_ch_status_0 {
 	struct {
@@ -371,32 +346,13 @@ union aud_info_frame3 {
 	u32 regval;
 };
 
-#define HDMI_AUDIO_UNDERRUN     (1UL<<31)
-#define HDMI_AUDIO_BUFFER_DONE  (1UL<<29)
+/* AUD_HDMI_STATUS bits */
+#define HDMI_AUDIO_UNDERRUN		(1U << 31)
+#define HDMI_AUDIO_BUFFER_DONE		(1U << 29)
 
-
-#define PORT_ENABLE			(1 << 31)
-#define SDVO_AUDIO_ENABLE	(1 << 6)
-
-enum had_caps_list {
-	HAD_GET_ELD = 1,
-	HAD_GET_DISPLAY_RATE,
-	HAD_GET_DP_OUTPUT,
-	HAD_GET_LINK_RATE,
-	HAD_SET_ENABLE_AUDIO,
-	HAD_SET_DISABLE_AUDIO,
-	HAD_SET_ENABLE_AUDIO_INT,
-	HAD_SET_DISABLE_AUDIO_INT,
-};
-
-enum had_event_type {
-	HAD_EVENT_HOT_PLUG = 1,
-	HAD_EVENT_HOT_UNPLUG,
-	HAD_EVENT_MODE_CHANGING,
-	HAD_EVENT_AUDIO_BUFFER_DONE,
-	HAD_EVENT_AUDIO_BUFFER_UNDERRUN,
-	HAD_EVENT_QUERY_IS_AUDIO_BUSY,
-	HAD_EVENT_QUERY_IS_AUDIO_SUSPENDED,
-};
+/* AUD_HDMI_STATUS register mask */
+#define AUD_CONFIG_MASK_UNDERRUN	0xC0000000
+#define AUD_CONFIG_MASK_SRDBG		0x00000002
+#define AUD_CONFIG_MASK_FUNCRST		0x00000001
 
 #endif
-- 
2.11.0
