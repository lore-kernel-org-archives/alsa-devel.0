From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: x86: Avoid unconditional call of
	snd_pcm_period_elapsed()
Date: Tue,  7 Feb 2017 17:38:00 +0100
Message-ID: <20170207163800.4039-3-tiwai@suse.de>
References: <20170207163800.4039-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DD57266649
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 17:38:02 +0100 (CET)
In-Reply-To: <20170207163800.4039-1-tiwai@suse.de>
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

At the interrupt handler, we usually call snd_pcm_period_elapsed() to
inform the PCM core to proceed the hwptr.  However, the hwptr update
might have been already processed by the explicit call of PCM pointer
callback via another thread.  If both happen concurrently, the call of
snd_pcm_period_elapsed() might be wrong.

Here is the fix for this slightly possible race: had_process_ringbuf()
returns the number of processed BDs, and the irq handler calls
snd_pcm_period_elapsed() only when it's not zero.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 15147fec1a7e..a0c9a4e0c95d 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -899,10 +899,13 @@ static void had_advance_ringbuf(struct snd_pcm_substream *substream,
 }
 
 /* process the current BD(s);
- * returns the current PCM buffer byte position, or -EPIPE for underrun.
+ * returns the number of processed BDs, zero if no BD was processed,
+ * or -EPIPE for underrun.
+ * When @pos_ret is non-NULL, the current PCM buffer byte position is stored.
  */
 static int had_process_ringbuf(struct snd_pcm_substream *substream,
-			       struct snd_intelhad *intelhaddata)
+			       struct snd_intelhad *intelhaddata,
+			       int *pos_ret)
 {
 	int len, processed;
 	unsigned long flags;
@@ -917,7 +920,7 @@ static int had_process_ringbuf(struct snd_pcm_substream *substream,
 		if (len < 0 || len > intelhaddata->period_bytes) {
 			dev_dbg(intelhaddata->dev, "Invalid buf length %d\n",
 				len);
-			len = -EPIPE;
+			processed = -EPIPE;
 			goto out;
 		}
 
@@ -926,23 +929,27 @@ static int had_process_ringbuf(struct snd_pcm_substream *substream,
 
 		/* len=0 => already empty, check the next buffer */
 		if (++processed >= intelhaddata->num_bds) {
-			len = -EPIPE; /* all empty? - report underrun */
+			processed = -EPIPE; /* all empty? - report underrun */
 			goto out;
 		}
 		had_advance_ringbuf(substream, intelhaddata);
 	}
 
-	len = intelhaddata->period_bytes - len;
-	len += intelhaddata->period_bytes * intelhaddata->pcmbuf_head;
+	if (pos_ret) {
+		len = intelhaddata->period_bytes - len;
+		len += intelhaddata->period_bytes * intelhaddata->pcmbuf_head;
+		*pos_ret = len;
+	}
  out:
 	spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
-	return len;
+	return processed;
 }
 
 /* called from irq handler */
 static void had_process_buffer_done(struct snd_intelhad *intelhaddata)
 {
 	struct snd_pcm_substream *substream;
+	int processed;
 
 	if (!intelhaddata->connected)
 		return; /* disconnected? - bail out */
@@ -952,9 +959,10 @@ static void had_process_buffer_done(struct snd_intelhad *intelhaddata)
 		return; /* no stream? - bail out */
 
 	/* process or stop the stream */
-	if (had_process_ringbuf(substream, intelhaddata) < 0)
+	processed = had_process_ringbuf(substream, intelhaddata, NULL);
+	if (processed < 0)
 		snd_pcm_stop_xrun(substream);
-	else
+	else if (processed > 0)
 		snd_pcm_period_elapsed(substream);
 
 	had_substream_put(intelhaddata);
@@ -1254,8 +1262,7 @@ static snd_pcm_uframes_t had_pcm_pointer(struct snd_pcm_substream *substream)
 	if (!intelhaddata->connected)
 		return SNDRV_PCM_POS_XRUN;
 
-	len = had_process_ringbuf(substream, intelhaddata);
-	if (len < 0)
+	if (had_process_ringbuf(substream, intelhaddata, &len) < 0)
 		return SNDRV_PCM_POS_XRUN;
 	return bytes_to_frames(substream->runtime, len);
 }
-- 
2.11.0
