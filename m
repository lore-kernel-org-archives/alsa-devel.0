From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: x86: Drop unused stream.running field
Date: Mon, 13 Feb 2017 15:39:17 +0100
Message-ID: <20170213143919.19543-3-tiwai@suse.de>
References: <20170213143919.19543-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E5A2B2666FB
 for <alsa-devel@alsa-project.org>; Mon, 13 Feb 2017 15:39:23 +0100 (CET)
In-Reply-To: <20170213143919.19543-1-tiwai@suse.de>
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
Cc: Ian W MORRISON <ianwmorrison@gmail.com>, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

The pcm_stream_info.running field is only set in the PCM trigger
callback but never referred, thus it can be safely removed.

Also, properly cover the spinlock in both the trigger START and STOP
to protect had_enable_audio() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 11 ++---------
 sound/x86/intel_hdmi_audio.h |  1 -
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 015d57cd9725..9889cdf3ccf4 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1168,6 +1168,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 
+	spin_lock(&intelhaddata->had_spinlock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -1180,8 +1181,6 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			break;
 		}
 
-		intelhaddata->stream_info.running = true;
-
 		/* Enable Audio */
 		had_ack_irqs(intelhaddata); /* FIXME: do we need this? */
 		had_enable_audio(intelhaddata, true);
@@ -1189,13 +1188,6 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-		spin_lock(&intelhaddata->had_spinlock);
-
-		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
-
-		intelhaddata->stream_info.running = false;
-		spin_unlock(&intelhaddata->had_spinlock);
 		/* Disable Audio */
 		had_enable_audio(intelhaddata, false);
 		intelhaddata->need_reset = true;
@@ -1204,6 +1196,7 @@ static int had_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		retval = -EINVAL;
 	}
+	spin_unlock(&intelhaddata->had_spinlock);
 	return retval;
 }
 
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 8b9e184fef44..d6ba90fd011d 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -83,7 +83,6 @@ struct channel_map_table {
 struct pcm_stream_info {
 	struct snd_pcm_substream *substream;
 	int substream_refcount;
-	bool running;
 };
 
 /*
-- 
2.11.1
