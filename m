From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 23/53] ALSA: x86: Drop unused hdmi_audio_query()
Date: Thu,  2 Feb 2017 18:02:37 +0100
Message-ID: <20170202170307.24484-25-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 972512675A6
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

It's used nowhere.  Kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.h    |  1 -
 sound/x86/intel_hdmi_audio_if.c | 54 -----------------------------------------
 2 files changed, 55 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 98a004499f3c..8415f93e40dc 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -146,7 +146,6 @@ struct snd_intelhad {
 
 int had_event_handler(enum had_event_type event_type, void *data);
 
-int hdmi_audio_query(void *drv_data, struct hdmi_audio_event event);
 int hdmi_audio_suspend(void *drv_data);
 int hdmi_audio_resume(void *drv_data);
 int hdmi_audio_mode_change(struct snd_pcm_substream *substream);
diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index caf982e55ec6..57acefaf930e 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -34,60 +34,6 @@
 #include "intel_hdmi_lpe_audio.h"
 
 /**
- * hdmi_audio_query - hdmi audio query function
- *
- *@haddata: pointer to HAD private data
- *@event: audio event for which this method is invoked
- *
- * This function is called by client driver to query the
- * hdmi audio.
- */
-int hdmi_audio_query(void *haddata, struct hdmi_audio_event event)
-{
-	struct snd_pcm_substream *substream = NULL;
-	struct had_stream_data *had_stream;
-	unsigned long flag_irqs;
-	struct snd_intelhad *intelhaddata = (struct snd_intelhad *)haddata;
-
-	if (intelhaddata->stream_info.had_substream)
-		substream = intelhaddata->stream_info.had_substream;
-	had_stream = &intelhaddata->stream_data;
-	switch (event.type) {
-	case HAD_EVENT_QUERY_IS_AUDIO_BUSY:
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-
-		if ((had_stream->stream_type == HAD_RUNNING_STREAM) ||
-			substream) {
-			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
-						flag_irqs);
-			pr_debug("Audio stream active\n");
-			return -EBUSY;
-		}
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	break;
-
-	case HAD_EVENT_QUERY_IS_AUDIO_SUSPENDED:
-		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
-		if (intelhaddata->drv_status == HAD_DRV_SUSPENDED) {
-			spin_unlock_irqrestore(&intelhaddata->had_spinlock,
-						flag_irqs);
-			pr_debug("Audio is suspended\n");
-			return 1;
-		}
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-	break;
-
-	default:
-		pr_debug("error un-handled event !!\n");
-		return -EINVAL;
-	break;
-
-	}
-
-	return 0;
-}
-
-/**
  * hdmi_audio_suspend - power management suspend function
  *
  *@haddata: pointer to HAD private data
-- 
2.11.0
