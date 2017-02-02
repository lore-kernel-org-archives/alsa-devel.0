From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 42/53] ALSA: x86: Drop unused fields from
	pcm_stream_info
Date: Thu,  2 Feb 2017 18:02:56 +0100
Message-ID: <20170202170307.24484-44-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A22626759E
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

The struct pcm_stream_info contains a few unused or useless fields.
str_id is always zero, buffer_ptr is volatile, never read, and sfreq
is nowhere referred.  Kill them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 19 +------------------
 sound/x86/intel_hdmi_audio.h |  3 ---
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 88e9a91f28a0..907e420cd90d 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1019,8 +1019,6 @@ static int snd_intelhad_close(struct snd_pcm_substream *substream)
 	intelhaddata = snd_pcm_substream_chip(substream);
 
 	intelhaddata->stream_info.buffer_rendered = 0;
-	intelhaddata->stream_info.buffer_ptr = 0;
-	intelhaddata->stream_info.str_id = 0;
 	intelhaddata->stream_info.had_substream = NULL;
 
 	/* Check if following drv_status modification is required - VA */
@@ -1132,7 +1130,6 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		spin_lock(&intelhaddata->had_spinlock);
-		intelhaddata->stream_info.str_id = 0;
 		intelhaddata->curr_buf = 0;
 
 		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
@@ -1188,19 +1185,8 @@ static int snd_intelhad_pcm_prepare(struct snd_pcm_substream *substream)
 	dev_dbg(intelhaddata->dev, "rate=%d\n", runtime->rate);
 	dev_dbg(intelhaddata->dev, "channels=%d\n", runtime->channels);
 
-	if (intelhaddata->stream_info.str_id) {
-		dev_dbg(intelhaddata->dev,
-			"_prepare is called for existing str_id#%d\n",
-					intelhaddata->stream_info.str_id);
-		retval = snd_intelhad_pcm_trigger(substream,
-						SNDRV_PCM_TRIGGER_STOP);
-		return retval;
-	}
-
 	intelhaddata->stream_info.had_substream = substream;
-	intelhaddata->stream_info.buffer_ptr = 0;
 	intelhaddata->stream_info.buffer_rendered = 0;
-	intelhaddata->stream_info.sfreq = substream->runtime->rate;
 
 	/* Get N value in KHz */
 	disp_samp_freq = intelhaddata->tmds_clock_speed;
@@ -1292,10 +1278,7 @@ static snd_pcm_uframes_t snd_intelhad_pcm_pointer(
 			intelhaddata->stream_info.ring_buf_size,
 			&(bytes_rendered));
 
-	intelhaddata->stream_info.buffer_ptr = bytes_to_frames(
-						substream->runtime,
-						bytes_rendered + t);
-	return intelhaddata->stream_info.buffer_ptr;
+	return bytes_to_frames(substream->runtime, bytes_rendered + t);
 }
 
 /*
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index 3bd2bb60f1f1..7bd273ec3275 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -72,12 +72,9 @@
 #define AUD_CONFIG_CH_MASK	0x70
 
 struct pcm_stream_info {
-	int		str_id;
 	struct snd_pcm_substream	*had_substream;
-	u32		buffer_ptr;
 	u64		buffer_rendered;
 	u32		ring_buf_size;
-	int		sfreq;
 };
 
 struct ring_buf_info {
-- 
2.11.0
