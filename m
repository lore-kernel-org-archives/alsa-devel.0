From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: pcxhr: Kill the rest snd_print*()
Date: Tue, 28 Oct 2014 17:45:14 +0100
Message-ID: <1414514715-569-3-git-send-email-tiwai@suse.de>
References: <1414514715-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA426261AB0
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 17:45:17 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6FE9DACEA
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 16:45:17 +0000 (UTC)
In-Reply-To: <1414514715-569-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Use the standard dev_*() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/pcxhr/pcxhr.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 7c33c973dbd5..a60293015267 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -501,10 +501,10 @@ int pcxhr_get_external_clock(struct pcxhr_mgr *mgr,
 /*
  *  start or stop playback/capture substream
  */
-static int pcxhr_set_stream_state(struct pcxhr_stream *stream)
+static int pcxhr_set_stream_state(struct snd_pcxhr *chip,
+				  struct pcxhr_stream *stream)
 {
 	int err;
-	struct snd_pcxhr *chip;
 	struct pcxhr_rmh rmh;
 	int stream_mask, start;
 
@@ -512,8 +512,8 @@ static int pcxhr_set_stream_state(struct pcxhr_stream *stream)
 		start = 1;
 	else {
 		if (stream->status != PCXHR_STREAM_STATUS_SCHEDULE_STOP) {
-			snd_printk(KERN_ERR "ERROR pcxhr_set_stream_state "
-				   "CANNOT be stopped\n");
+			dev_err(chip->card->dev,
+				"pcxhr_set_stream_state CANNOT be stopped\n");
 			return -EINVAL;
 		}
 		start = 0;
@@ -560,6 +560,7 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 	struct pcxhr_rmh rmh;
 	unsigned int header;
 
+	chip = snd_pcm_substream_chip(stream->substream);
 	switch (stream->format) {
 	case SNDRV_PCM_FORMAT_U8:
 		header = HEADER_FMT_BASE_LIN;
@@ -582,11 +583,10 @@ static int pcxhr_set_format(struct pcxhr_stream *stream)
 		header = HEADER_FMT_BASE_FLOAT | HEADER_FMT_INTEL;
 		break;
 	default:
-		snd_printk(KERN_ERR
-			   "error pcxhr_set_format() : unknown format\n");
+		dev_err(chip->card->dev,
+			"error pcxhr_set_format() : unknown format\n");
 		return -EINVAL;
 	}
-	chip = snd_pcm_substream_chip(stream->substream);
 
 	sample_rate = chip->mgr->sample_rate;
 	if (sample_rate <= 32000 && sample_rate !=0) {
@@ -643,11 +643,11 @@ static int pcxhr_update_r_buffer(struct pcxhr_stream *stream)
 	is_capture = (subs->stream == SNDRV_PCM_STREAM_CAPTURE);
 	stream_num = is_capture ? 0 : subs->number;
 
-	snd_printdd("pcxhr_update_r_buffer(pcm%c%d) : "
-		    "addr(%p) bytes(%zx) subs(%d)\n",
-		    is_capture ? 'c' : 'p',
-		    chip->chip_idx, (void *)(long)subs->runtime->dma_addr,
-		    subs->runtime->dma_bytes, subs->number);
+	dev_dbg(chip->card->dev,
+		"pcxhr_update_r_buffer(pcm%c%d) : addr(%p) bytes(%zx) subs(%d)\n",
+		is_capture ? 'c' : 'p',
+		chip->chip_idx, (void *)(long)subs->runtime->dma_addr,
+		subs->runtime->dma_bytes, subs->number);
 
 	pcxhr_init_rmh(&rmh, CMD_UPDATE_R_BUFFERS);
 	pcxhr_set_pipe_cmd_params(&rmh, is_capture, stream->pipe->first_audio,
@@ -687,7 +687,7 @@ static int pcxhr_pipe_sample_count(struct pcxhr_stream *stream,
 		*sample_count = ((snd_pcm_uframes_t)rmh.stat[0]) << 24;
 		*sample_count += (snd_pcm_uframes_t)rmh.stat[1];
 	}
-	snd_printdd("PIPE_SAMPLE_COUNT = %lx\n", *sample_count);
+	dev_dbg(chip->card->dev, "PIPE_SAMPLE_COUNT = %lx\n", *sample_count);
 	return err;
 }
 #endif
@@ -779,12 +779,12 @@ static void pcxhr_start_linked_stream(struct pcxhr_mgr *mgr)
 		for (j = 0; j < chip->nb_streams_capt; j++) {
 			stream = &chip->capture_stream[j];
 			if (pcxhr_stream_scheduled_get_pipe(stream, &pipe))
-				err = pcxhr_set_stream_state(stream);
+				err = pcxhr_set_stream_state(chip, stream);
 		}
 		for (j = 0; j < chip->nb_streams_play; j++) {
 			stream = &chip->playback_stream[j];
 			if (pcxhr_stream_scheduled_get_pipe(stream, &pipe))
-				err = pcxhr_set_stream_state(stream);
+				err = pcxhr_set_stream_state(chip, stream);
 		}
 	}
 
@@ -839,12 +839,12 @@ static int pcxhr_trigger(struct snd_pcm_substream *subs, int cmd)
 {
 	struct pcxhr_stream *stream;
 	struct snd_pcm_substream *s;
+	struct snd_pcxhr *chip = snd_pcm_substream_chip(subs);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_printdd("SNDRV_PCM_TRIGGER_START\n");
+		dev_dbg(chip->card->dev, "SNDRV_PCM_TRIGGER_START\n");
 		if (snd_pcm_stream_linked(subs)) {
-			struct snd_pcxhr *chip = snd_pcm_substream_chip(subs);
 			snd_pcm_group_for_each_entry(s, subs) {
 				if (snd_pcm_substream_chip(s) != chip)
 					continue;
@@ -856,7 +856,7 @@ static int pcxhr_trigger(struct snd_pcm_substream *subs, int cmd)
 			pcxhr_start_linked_stream(chip->mgr);
 		} else {
 			stream = subs->runtime->private_data;
-			snd_printdd("Only one Substream %c %d\n",
+			dev_dbg(chip->card->dev, "Only one Substream %c %d\n",
 				    stream->pipe->is_capture ? 'C' : 'P',
 				    stream->pipe->first_audio);
 			if (pcxhr_set_format(stream))
@@ -865,17 +865,17 @@ static int pcxhr_trigger(struct snd_pcm_substream *subs, int cmd)
 				return -EINVAL;
 
 			stream->status = PCXHR_STREAM_STATUS_SCHEDULE_RUN;
-			if (pcxhr_set_stream_state(stream))
+			if (pcxhr_set_stream_state(chip, stream))
 				return -EINVAL;
 			stream->status = PCXHR_STREAM_STATUS_RUNNING;
 		}
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_printdd("SNDRV_PCM_TRIGGER_STOP\n");
+		dev_dbg(chip->card->dev, "SNDRV_PCM_TRIGGER_STOP\n");
 		snd_pcm_group_for_each_entry(s, subs) {
 			stream = s->runtime->private_data;
 			stream->status = PCXHR_STREAM_STATUS_SCHEDULE_STOP;
-			if (pcxhr_set_stream_state(stream))
+			if (pcxhr_set_stream_state(chip, stream))
 				return -EINVAL;
 			snd_pcm_trigger_done(s, subs);
 		}
-- 
2.1.2
