From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/53] ALSA: x86: Drop unused
	mid_hdmi_audio_is_busy()
Date: Thu,  2 Feb 2017 18:02:26 +0100
Message-ID: <20170202170307.24484-14-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BAD2426689C
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 23 -----------------------
 sound/x86/intel_hdmi_lpe_audio.h |  1 -
 2 files changed, 24 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index f5249b0a4ce4..452128a941cb 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -83,29 +83,6 @@ static struct hdmi_lpe_audio_ctx *get_hdmi_context(void)
 	return ctx;
 }
 
-/*
- * return whether HDMI audio device is busy.
- */
-bool mid_hdmi_audio_is_busy(void *ddev)
-{
-	struct hdmi_lpe_audio_ctx *ctx;
-	int hdmi_audio_busy = 0;
-	struct hdmi_audio_event hdmi_audio_event;
-
-	dev_dbg(&hlpe_pdev->dev, "%s: Enter",  __func__);
-
-	ctx = platform_get_drvdata(hlpe_pdev);
-
-	if (hlpe_state == hdmi_connector_status_disconnected) {
-		/* HDMI is not connected, assuming audio device is idle. */
-		return false;
-	}
-
-	hdmi_audio_event.type = HAD_EVENT_QUERY_IS_AUDIO_BUSY;
-	hdmi_audio_busy = hdmi_audio_query(ctx->had, hdmi_audio_event);
-	return hdmi_audio_busy != 0;
-}
-
 void mid_hdmi_audio_signal_event(enum had_event_type event)
 {
 	struct hdmi_lpe_audio_ctx *ctx;
diff --git a/sound/x86/intel_hdmi_lpe_audio.h b/sound/x86/intel_hdmi_lpe_audio.h
index 511bdc30dca1..a1c3aa0fbc57 100644
--- a/sound/x86/intel_hdmi_lpe_audio.h
+++ b/sound/x86/intel_hdmi_lpe_audio.h
@@ -642,7 +642,6 @@ struct hdmi_audio_event {
 	int type;
 };
 
-bool mid_hdmi_audio_is_busy(void *dev);
 void mid_hdmi_audio_signal_event(enum had_event_type event);
 
 int mid_hdmi_audio_read(u32 reg, u32 *val);
-- 
2.11.0
