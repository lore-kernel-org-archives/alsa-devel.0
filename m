From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/53] ALSA: x86: Replace indirect query_ops
	with direct calls
Date: Thu,  2 Feb 2017 18:02:19 +0100
Message-ID: <20170202170307.24484-7-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 848F6266861
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:15 +0100 (CET)
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

Like the previous patch, this replaces the indirect query_ops calls
via direct function calls.  They are only get_caps and set_caps, so
fairly straightforward at this time.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 10 +++-------
 sound/x86/intel_hdmi_audio.h     |  2 --
 sound/x86/intel_hdmi_lpe_audio.c | 26 +++++++-------------------
 sound/x86/intel_hdmi_lpe_audio.h | 16 ++++++----------
 4 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index d101a27e4a27..a4c2f3f8d669 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -179,8 +179,7 @@ int had_get_caps(enum had_caps_list query, void *caps)
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = intelhaddata->query_ops.hdmi_audio_get_caps(query,
-				caps);
+		retval = mid_hdmi_audio_get_caps(query, caps);
 
 	return retval;
 }
@@ -192,8 +191,7 @@ int had_set_caps(enum had_caps_list set_element, void *caps)
 
 	retval = had_get_hwstate(intelhaddata);
 	if (!retval)
-		retval = intelhaddata->query_ops.hdmi_audio_set_caps(
-				set_element, caps);
+		retval = mid_hdmi_audio_set_caps(set_element, caps);
 
 	return retval;
 }
@@ -1616,9 +1614,7 @@ int hdmi_audio_probe(void *deviceptr)
 
 	/* registering with display driver to get access to display APIs */
 
-	retval = mid_hdmi_audio_setup(
-			ops_cb.intel_had_event_call_back,
-			&(intelhaddata->query_ops));
+	retval = mid_hdmi_audio_setup(ops_cb.intel_had_event_call_back);
 	if (retval) {
 		pr_err("querying display driver APIs failed %#x\n", retval);
 		goto free_hadstream;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 5ba06042f669..e7c7432c5078 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -107,7 +107,6 @@ struct had_callback_ops {
  * @card: ptr to hold card details
  * @card_index: sound card index
  * @card_id: detected sound card id
- * @query_ops: caps call backs for get/set operations
  * @drv_status: driver status
  * @buf_info: ring buffer info
  * @stream_info: stream information
@@ -127,7 +126,6 @@ struct snd_intelhad {
 	struct snd_card	*card;
 	int		card_index;
 	char		*card_id;
-	struct hdmi_audio_query_set_ops	query_ops;
 	enum had_drv_status	drv_status;
 	struct		ring_buf_info buf_info[HAD_NUM_OF_RING_BUFS];
 	struct		pcm_stream_info stream_info;
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index a7a07bfe52ed..1747ff259903 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -239,12 +239,12 @@ int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask)
 	return 0;
 }
 
-/**
+/*
  * used to return the HDMI audio capabilities.
  * e.g. resolution, frame rate.
  */
-static int hdmi_audio_get_caps(enum had_caps_list get_element,
-			void *capabilities)
+int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
+			    void *capabilities)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 	int ret = 0;
@@ -281,12 +281,12 @@ static int hdmi_audio_get_caps(enum had_caps_list get_element,
 	return ret;
 }
 
-/**
+/*
  * used to set the HDMI audio capabilities.
  * e.g. Audio INT.
  */
-int hdmi_audio_set_caps(enum had_caps_list set_element,
-			void *capabilties)
+int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
+			    void *capabilties)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 
@@ -313,14 +313,7 @@ int hdmi_audio_set_caps(enum had_caps_list set_element,
 	return 0;
 }
 
-static struct hdmi_audio_query_set_ops hdmi_audio_get_set_ops = {
-	.hdmi_audio_get_caps = hdmi_audio_get_caps,
-	.hdmi_audio_set_caps = hdmi_audio_set_caps,
-};
-
-int mid_hdmi_audio_setup(
-		had_event_call_back audio_callbacks,
-		struct hdmi_audio_query_set_ops *query_ops)
+int mid_hdmi_audio_setup(had_event_call_back audio_callbacks)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
 
@@ -328,11 +321,6 @@ int mid_hdmi_audio_setup(
 
 	dev_dbg(&hlpe_pdev->dev, "%s: called\n",  __func__);
 
-	query_ops->hdmi_audio_get_caps =
-		hdmi_audio_get_set_ops.hdmi_audio_get_caps;
-	query_ops->hdmi_audio_set_caps =
-		hdmi_audio_get_set_ops.hdmi_audio_set_caps;
-
 	ctx->had_event_callbacks = audio_callbacks;
 
 	return 0;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index ea90cf919948..5e925b728302 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -641,13 +641,6 @@ enum had_event_type {
 typedef int (*had_event_call_back) (enum had_event_type event_type,
 		void *ctxt_info);
 
-struct hdmi_audio_query_set_ops {
-	int (*hdmi_audio_get_caps)(enum had_caps_list query_element,
-			void *capabilties);
-	int (*hdmi_audio_set_caps)(enum had_caps_list set_element,
-			void *capabilties);
-};
-
 struct hdmi_audio_event {
 	int type;
 };
@@ -663,9 +656,7 @@ bool mid_hdmi_audio_is_busy(void *dev);
 bool mid_hdmi_audio_suspend(void *dev);
 void mid_hdmi_audio_resume(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
-int mid_hdmi_audio_setup(
-	had_event_call_back audio_callbacks,
-	struct hdmi_audio_query_set_ops *query_ops);
+int mid_hdmi_audio_setup(had_event_call_back audio_callbacks);
 int mid_hdmi_audio_register(
 	struct snd_intel_had_interface *driver,
 	void *had_data);
@@ -674,4 +665,9 @@ int mid_hdmi_audio_read(u32 reg, u32 *val);
 int mid_hdmi_audio_write(u32 reg, u32 val);
 int mid_hdmi_audio_rmw(u32 reg, u32 val, u32 mask);
 
+int mid_hdmi_audio_get_caps(enum had_caps_list get_element,
+			    void *capabilities);
+int mid_hdmi_audio_set_caps(enum had_caps_list set_element,
+			    void *capabilties);
+
 #endif
-- 
2.11.0
