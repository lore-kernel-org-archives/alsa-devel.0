From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 15/24] sound/pci: coding style fixes: mixart
Date: Tue, 9 Sep 2008 05:56:39 +0400
Message-ID: <20080909015639.GR6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 256FA103821
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:56:46 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1536522fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:56:46 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/mixart/mixart.c       |  148 +++++++++++++++++++-------------------
 sound/pci/mixart/mixart_core.c  |  100 +++++++++++++-------------
 sound/pci/mixart/mixart_hwdep.c |  128 +++++++++++++++++-----------------
 sound/pci/mixart/mixart_hwdep.h |   28 ++++----
 sound/pci/mixart/mixart_mixer.c |   56 +++++++-------
 5 files changed, 230 insertions(+), 230 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 2d0dce6..9db4225 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -80,10 +80,10 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 	switch(pipe->status) {
 	case PIPE_RUNNING:
 	case PIPE_CLOCK_SET:
-		if(start) return 0; /* already started */
+		if (start) return 0; /* already started */
 		break;
 	case PIPE_STOPPED:
-		if(!start) return 0; /* already stopped */
+		if (!start) return 0; /* already stopped */
 		break;
 	default:
 		snd_printk(KERN_ERR "error mixart_set_pipe_state called with wrong pipe->status!\n");
@@ -100,7 +100,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 	request.size = sizeof(system_msg_uid);
 
 	err = snd_mixart_send_msg_wait_notif(mgr, &request, system_msg_uid);
-	if(err) {
+	if (err) {
 		snd_printk(KERN_ERR "error : MSG_SYSTEM_WAIT_SYNCHRO_CMD was not notified !\n");
 		return err;
 	}
@@ -111,7 +111,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 	group_state.pipe_count = 1;
 	group_state.pipe_uid[0] = pipe->group_uid;
 
-	if(start)
+	if (start)
 		request.message_id = MSG_STREAM_START_STREAM_GRP_PACKET;
 	else
 		request.message_id = MSG_STREAM_STOP_STREAM_GRP_PACKET;
@@ -126,7 +126,7 @@ static int mixart_set_pipe_state(struct mixart_mgr *mgr,
 		return -EINVAL;
 	}
 
-	if(start) {
+	if (start) {
 		u32 stat;
 
 		group_state.pipe_count = 0; /* in case of start same command once again with pipe_count=0 */
@@ -171,10 +171,10 @@ static int mixart_set_clock(struct mixart_mgr *mgr,
 	case PIPE_CLOCK_SET:
 		break;
 	case PIPE_RUNNING:
-		if(rate != 0)
+		if (rate != 0)
 			break;
 	default:
-		if(rate == 0)
+		if (rate == 0)
 			return 0; /* nothing to do */
 		else {
 			snd_printk(KERN_ERR "error mixart_set_clock(%d) called with wrong pipe->status !\n", rate);
@@ -202,7 +202,7 @@ static int mixart_set_clock(struct mixart_mgr *mgr,
 		return -EINVAL;
 	}
 
-	if(rate)  pipe->status = PIPE_CLOCK_SET;
+	if (rate)  pipe->status = PIPE_CLOCK_SET;
 	else      pipe->status = PIPE_RUNNING;
 
 	return 0;
@@ -220,7 +220,7 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 	struct mixart_pipe *pipe;
 	struct mixart_msg request;
 
-	if(capture) {
+	if (capture) {
 		if (pcm_number == MIXART_PCM_ANALOG) {
 			pipe = &(chip->pipe_in_ana);  /* analog inputs */
 		} else {
@@ -239,12 +239,12 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 	}
 
 	/* a new stream is opened and there are already all streams in use */
-	if( (monitoring == 0) && (pipe->references >= stream_count) ) {
+	if ((monitoring == 0) && (pipe->references >= stream_count)) {
 		return NULL;
 	}
 
 	/* pipe is not yet defined */
-	if( pipe->status == PIPE_UNDEFINED ) {
+	if (pipe->status == PIPE_UNDEFINED) {
 		int err, i;
 		struct {
 			struct mixart_streaming_group_req sgroup_req;
@@ -268,11 +268,11 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 		buf->sgroup_req.latency = 256;
 		buf->sgroup_req.connector = pipe->uid_left_connector;  /* the left connector */
 
-		for (i=0; i<stream_count; i++) {
+		for (i = 0; i < stream_count; i++) {
 			int j;
 			struct mixart_flowinfo *flowinfo;
 			struct mixart_bufferinfo *bufferinfo;
-			
+
 			/* we don't yet know the format, so config 16 bit pcm audio for instance */
 			buf->sgroup_req.stream_info[i].size_max_byte_frame = 1024;
 			buf->sgroup_req.stream_info[i].size_max_sample_frame = 256;
@@ -280,7 +280,7 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 
 			/* find the right bufferinfo_array */
 			j = (chip->chip_idx * MIXART_MAX_STREAM_PER_CARD) + (pcm_number * (MIXART_PLAYBACK_STREAMS + MIXART_CAPTURE_STREAMS)) + i;
-			if(capture) j += MIXART_PLAYBACK_STREAMS; /* in the array capture is behind playback */
+			if (capture) j += MIXART_PLAYBACK_STREAMS; /* in the array capture is behind playback */
 
 			buf->sgroup_req.flow_entry[i] = j;
 
@@ -294,13 +294,13 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 
 			/* construct the identifier of the stream buffer received in the interrupts ! */
 			bufferinfo[j].buffer_id = (chip->chip_idx << MIXART_NOTIFY_CARD_OFFSET) + (pcm_number << MIXART_NOTIFY_PCM_OFFSET ) + i;
-			if(capture) {
+			if (capture) {
 				bufferinfo[j].buffer_id |= MIXART_NOTIFY_CAPT_MASK;
 			}
 		}
 
 		err = snd_mixart_send_msg(chip->mgr, &request, sizeof(buf->sgroup_resp), &buf->sgroup_resp);
-		if((err < 0) || (buf->sgroup_resp.status != 0)) {
+		if ((err < 0) || (buf->sgroup_resp.status != 0)) {
 			snd_printk(KERN_ERR "error MSG_STREAM_ADD_**PUT_GROUP err=%x stat=%x !\n", err, buf->sgroup_resp.status);
 			kfree(buf);
 			return NULL;
@@ -314,7 +314,7 @@ snd_mixart_add_ref_pipe(struct snd_mixart *chip, int pcm_number, int capture,
 		kfree(buf);
 	}
 
-	if(monitoring)	pipe->monitoring = 1;
+	if (monitoring)	pipe->monitoring = 1;
 	else		pipe->references++;
 
 	return pipe;
@@ -326,28 +326,28 @@ int snd_mixart_kill_ref_pipe(struct mixart_mgr *mgr,
 {
 	int err = 0;
 
-	if(pipe->status == PIPE_UNDEFINED)
+	if (pipe->status == PIPE_UNDEFINED)
 		return 0;
 
-	if(monitoring)
+	if (monitoring)
 		pipe->monitoring = 0;
 	else
 		pipe->references--;
 
-	if((pipe->references <= 0) && (pipe->monitoring == 0)) {
+	if ((pipe->references <= 0) && (pipe->monitoring == 0)) {
 
 		struct mixart_msg request;
 		struct mixart_delete_group_resp delete_resp;
 
 		/* release the clock */
 		err = mixart_set_clock( mgr, pipe, 0);
-		if( err < 0 ) {
+		if (err < 0) {
 			snd_printk(KERN_ERR "mixart_set_clock(0) return error!\n");
 		}
 
 		/* stop the pipe */
 		err = mixart_set_pipe_state(mgr, pipe, 0);
-		if( err < 0 ) {
+		if (err < 0) {
 			snd_printk(KERN_ERR "error stopping pipe!\n");
 		}
 
@@ -376,7 +376,7 @@ static int mixart_set_stream_state(struct mixart_stream *stream, int start)
 	struct mixart_stream_state_req stream_state_req;
 	struct mixart_msg request;
 
-	if(!stream->substream)
+	if (!stream->substream)
 		return -EINVAL;
 
 	memset(&stream_state_req, 0, sizeof(stream_state_req));
@@ -416,7 +416,7 @@ static int snd_mixart_trigger(struct snd_pcm_substream *subs, int cmd)
 		snd_printdd("SNDRV_PCM_TRIGGER_START\n");
 
 		/* START_STREAM */
-		if( mixart_set_stream_state(stream, 1) )
+		if (mixart_set_stream_state(stream, 1))
 			return -EINVAL;
 
 		stream->status = MIXART_STREAM_STATUS_RUNNING;
@@ -425,7 +425,7 @@ static int snd_mixart_trigger(struct snd_pcm_substream *subs, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 
 		/* STOP_STREAM */
-		if( mixart_set_stream_state(stream, 0) )
+		if (mixart_set_stream_state(stream, 0))
 			return -EINVAL;
 
 		stream->status = MIXART_STREAM_STATUS_OPEN;
@@ -479,12 +479,12 @@ static int snd_mixart_prepare(struct snd_pcm_substream *subs)
 
 	/* only the first stream can choose the sample rate */
 	/* the further opened streams will be limited to its frequency (see open) */
-	if(chip->mgr->ref_count_rate == 1)
+	if (chip->mgr->ref_count_rate == 1)
 		chip->mgr->sample_rate = subs->runtime->rate;
 
 	/* set the clock only once (first stream) on the same pipe */
-	if(stream->pipe->references == 1) {
-		if( mixart_set_clock(chip->mgr, stream->pipe, subs->runtime->rate) )
+	if (stream->pipe->references == 1) {
+		if (mixart_set_clock(chip->mgr, stream->pipe, subs->runtime->rate))
 			return -EINVAL;
 	}
 
@@ -508,7 +508,7 @@ static int mixart_set_format(struct mixart_stream *stream, snd_pcm_format_t form
 	stream_param.number_of_channel = stream->channels;
 
 	stream_param.sampling_freq = chip->mgr->sample_rate;
-	if(stream_param.sampling_freq == 0)
+	if (stream_param.sampling_freq == 0)
 		stream_param.sampling_freq = 44100; /* if frequency not yet defined, use some default */
 
 	switch(format){
@@ -564,7 +564,7 @@ static int mixart_set_format(struct mixart_stream *stream, snd_pcm_format_t form
 	request.size = sizeof(stream_param);
 
 	err = snd_mixart_send_msg(chip->mgr, &request, sizeof(resp), &resp);
-	if((err < 0) || resp.error_code) {
+	if ((err < 0) || resp.error_code) {
 		snd_printk(KERN_ERR "MSG_STREAM_SET_INPUT_STAGE_PARAM err=%x; resp=%x\n", err, resp.error_code);
 		return -EINVAL;
 	}
@@ -594,9 +594,9 @@ static int snd_mixart_hw_params(struct snd_pcm_substream *subs,
 	mutex_lock(&mgr->setup_mutex);
 
 	/* update the stream levels */
-	if( stream->pcm_number <= MIXART_PCM_DIGITAL ) {
+	if (stream->pcm_number <= MIXART_PCM_DIGITAL) {
 		int is_aes = stream->pcm_number > MIXART_PCM_ANALOG;
-		if( subs->stream == SNDRV_PCM_STREAM_PLAYBACK )
+		if (subs->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			mixart_update_playback_stream_level(chip, is_aes, subs->number);
 		else
 			mixart_update_capture_stream_level( chip, is_aes);
@@ -606,7 +606,7 @@ static int snd_mixart_hw_params(struct snd_pcm_substream *subs,
 
 	/* set the format to the board */
 	err = mixart_set_format(stream, format);
-	if(err < 0) {
+	if (err < 0) {
 		return err;
 	}
 
@@ -616,10 +616,10 @@ static int snd_mixart_hw_params(struct snd_pcm_substream *subs,
 	if (err > 0) {
 		struct mixart_bufferinfo *bufferinfo;
 		int i = (chip->chip_idx * MIXART_MAX_STREAM_PER_CARD) + (stream->pcm_number * (MIXART_PLAYBACK_STREAMS+MIXART_CAPTURE_STREAMS)) + subs->number;
-		if( subs->stream == SNDRV_PCM_STREAM_CAPTURE ) {
+		if (subs->stream == SNDRV_PCM_STREAM_CAPTURE) {
 			i += MIXART_PLAYBACK_STREAMS; /* in array capture is behind playback */
 		}
-		
+
 		bufferinfo = (struct mixart_bufferinfo *)chip->mgr->bufferinfo.area;
 		bufferinfo[i].buffer_address = subs->runtime->dma_addr;
 		bufferinfo[i].available_length = subs->runtime->dma_bytes;
@@ -704,7 +704,7 @@ static int snd_mixart_playback_open(struct snd_pcm_substream *subs)
 
 	mutex_lock(&mgr->setup_mutex);
 
-	if ( pcm == chip->pcm ) {
+	if (pcm == chip->pcm) {
 		pcm_number = MIXART_PCM_ANALOG;
 		runtime->hw = snd_mixart_analog_caps;
 	} else {
@@ -734,7 +734,7 @@ static int snd_mixart_playback_open(struct snd_pcm_substream *subs)
 
 	/* start the pipe if necessary */
 	err = mixart_set_pipe_state(chip->mgr, pipe, 1);
-	if( err < 0 ) {
+	if (err < 0) {
 		snd_printk(KERN_ERR "error starting pipe!\n");
 		snd_mixart_kill_ref_pipe(chip->mgr, pipe, 0);
 		err = -EINVAL;
@@ -753,13 +753,13 @@ static int snd_mixart_playback_open(struct snd_pcm_substream *subs)
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 64);
 
 	/* if a sample rate is already used, another stream cannot change */
-	if(mgr->ref_count_rate++) {
-		if(mgr->sample_rate) {
+	if (mgr->ref_count_rate++) {
+		if (mgr->sample_rate) {
 			runtime->hw.rate_min = runtime->hw.rate_max = mgr->sample_rate;
 		}
 	}
 
- _exit_open:
+_exit_open:
 	mutex_unlock(&mgr->setup_mutex);
 
 	return err;
@@ -779,7 +779,7 @@ static int snd_mixart_capture_open(struct snd_pcm_substream *subs)
 
 	mutex_lock(&mgr->setup_mutex);
 
-	if ( pcm == chip->pcm ) {
+	if (pcm == chip->pcm) {
 		pcm_number = MIXART_PCM_ANALOG;
 		runtime->hw = snd_mixart_analog_caps;
 	} else {
@@ -812,7 +812,7 @@ static int snd_mixart_capture_open(struct snd_pcm_substream *subs)
 
 	/* start the pipe if necessary */
 	err = mixart_set_pipe_state(chip->mgr, pipe, 1);
-	if( err < 0 ) {
+	if (err < 0) {
 		snd_printk(KERN_ERR "error starting pipe!\n");
 		snd_mixart_kill_ref_pipe(chip->mgr, pipe, 0);
 		err = -EINVAL;
@@ -831,13 +831,13 @@ static int snd_mixart_capture_open(struct snd_pcm_substream *subs)
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 64);
 
 	/* if a sample rate is already used, another stream cannot change */
-	if(mgr->ref_count_rate++) {
-		if(mgr->sample_rate) {
+	if (mgr->ref_count_rate++) {
+		if (mgr->sample_rate) {
 			runtime->hw.rate_min = runtime->hw.rate_max = mgr->sample_rate;
 		}
 	}
 
- _exit_open:
+_exit_open:
 	mutex_unlock(&mgr->setup_mutex);
 
 	return err;
@@ -856,7 +856,7 @@ static int snd_mixart_close(struct snd_pcm_substream *subs)
 	snd_printdd("snd_mixart_close C%d/P%d/Sub%d\n", chip->chip_idx, stream->pcm_number, subs->number);
 
 	/* sample rate released */
-	if(--mgr->ref_count_rate == 0) {
+	if (--mgr->ref_count_rate == 0) {
 		mgr->sample_rate = 0;
 	}
 
@@ -1011,7 +1011,7 @@ static int __devinit snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *
 	};
 
 	mgr->chip[idx] = chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
+	if (!chip) {
 		snd_printk(KERN_ERR "cannot allocate chip\n");
 		return -ENOMEM;
 	}
@@ -1038,7 +1038,7 @@ int snd_mixart_create_pcm(struct snd_mixart* chip)
 	if (err < 0)
 		return err;
 
-	if(chip->mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
+	if (chip->mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
 
 		err = snd_mixart_pcm_digital(chip);
 		if (err < 0)
@@ -1068,7 +1068,7 @@ static int snd_mixart_free(struct mixart_mgr *mgr)
 		free_irq(mgr->irq, mgr);
 
 	/* reset board if some firmware was loaded */
-	if(mgr->dsp_loaded) {
+	if (mgr->dsp_loaded) {
 		snd_mixart_reset_board(mgr);
 		snd_printdd("reset miXart !\n");
 	}
@@ -1081,12 +1081,12 @@ static int snd_mixart_free(struct mixart_mgr *mgr)
 	pci_release_regions(mgr->pci);
 
 	/* free flowarray */
-	if(mgr->flowinfo.area) {
+	if (mgr->flowinfo.area) {
 		snd_dma_free_pages(&mgr->flowinfo);
 		mgr->flowinfo.area = NULL;
 	}
 	/* free bufferarray */
-	if(mgr->bufferinfo.area) {
+	if (mgr->bufferinfo.area) {
 		snd_dma_free_pages(&mgr->bufferinfo);
 		mgr->bufferinfo.area = NULL;
 	}
@@ -1120,7 +1120,7 @@ static long long snd_mixart_BA0_llseek(struct snd_info_entry *entry,
 	default:
 		return -EINVAL;
 	}
-	if(file->f_pos > MIXART_BA0_SIZE)
+	if (file->f_pos > MIXART_BA0_SIZE)
 		file->f_pos = MIXART_BA0_SIZE;
 	return file->f_pos;
 }
@@ -1146,7 +1146,7 @@ static long long snd_mixart_BA1_llseek(struct snd_info_entry *entry,
 	default:
 		return -EINVAL;
 	}
-	if(file->f_pos > MIXART_BA1_SIZE)
+	if (file->f_pos > MIXART_BA1_SIZE)
 		file->f_pos = MIXART_BA1_SIZE;
 	return file->f_pos;
 }
@@ -1161,11 +1161,11 @@ static long snd_mixart_BA0_read(struct snd_info_entry *entry, void *file_private
 	struct mixart_mgr *mgr = entry->private_data;
 
 	count = count & ~3; /* make sure the read size is a multiple of 4 bytes */
-	if(count <= 0)
+	if (count <= 0)
 		return 0;
-	if(pos + count > MIXART_BA0_SIZE)
+	if (pos + count > MIXART_BA0_SIZE)
 		count = (long)(MIXART_BA0_SIZE - pos);
-	if(copy_to_user_fromio(buf, MIXART_MEM( mgr, pos ), count))
+	if (copy_to_user_fromio(buf, MIXART_MEM( mgr, pos ), count))
 		return -EFAULT;
 	return count;
 }
@@ -1180,11 +1180,11 @@ static long snd_mixart_BA1_read(struct snd_info_entry *entry, void *file_private
 	struct mixart_mgr *mgr = entry->private_data;
 
 	count = count & ~3; /* make sure the read size is a multiple of 4 bytes */
-	if(count <= 0)
+	if (count <= 0)
 		return 0;
-	if(pos + count > MIXART_BA1_SIZE)
+	if (pos + count > MIXART_BA1_SIZE)
 		count = (long)(MIXART_BA1_SIZE - pos);
-	if(copy_to_user_fromio(buf, MIXART_REG( mgr, pos ), count))
+	if (copy_to_user_fromio(buf, MIXART_REG( mgr, pos ), count))
 		return -EFAULT;
 	return count;
 }
@@ -1200,25 +1200,25 @@ static struct snd_info_entry_ops snd_mixart_proc_ops_BA1 = {
 };
 
 
-static void snd_mixart_proc_read(struct snd_info_entry *entry, 
+static void snd_mixart_proc_read(struct snd_info_entry *entry,
                                  struct snd_info_buffer *buffer)
 {
-	struct snd_mixart *chip = entry->private_data;        
-	u32 ref; 
+	struct snd_mixart *chip = entry->private_data;
+	u32 ref;
 
 	snd_iprintf(buffer, "Digigram miXart (alsa card %d)\n\n", chip->chip_idx);
 
 	/* stats available when embedded OS is running */
 	if (chip->mgr->dsp_loaded & ( 1 << MIXART_MOTHERBOARD_ELF_INDEX)) {
 		snd_iprintf(buffer, "- hardware -\n");
-		switch (chip->mgr->board_type ) {
+		switch (chip->mgr->board_type) {
 		case MIXART_DAUGHTER_TYPE_NONE     : snd_iprintf(buffer, "\tmiXart8 (no daughter board)\n\n"); break;
 		case MIXART_DAUGHTER_TYPE_AES      : snd_iprintf(buffer, "\tmiXart8 AES/EBU\n\n"); break;
 		case MIXART_DAUGHTER_TYPE_COBRANET : snd_iprintf(buffer, "\tmiXart8 Cobranet\n\n"); break;
 		default:                             snd_iprintf(buffer, "\tUNKNOWN!\n\n"); break;
 		}
 
-		snd_iprintf(buffer, "- system load -\n");	 
+		snd_iprintf(buffer, "- system load -\n");
 
 		/* get perf reference */
 
@@ -1241,18 +1241,18 @@ static void __devinit snd_mixart_proc_init(struct snd_mixart *chip)
 	struct snd_info_entry *entry;
 
 	/* text interface to read perf and temp meters */
-	if (! snd_card_proc_new(chip->card, "board_info", &entry)) {
+	if (!snd_card_proc_new(chip->card, "board_info", &entry)) {
 		entry->private_data = chip;
 		entry->c.text.read = snd_mixart_proc_read;
 	}
 
-	if (! snd_card_proc_new(chip->card, "mixart_BA0", &entry)) {
+	if (!snd_card_proc_new(chip->card, "mixart_BA0", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
-		entry->private_data = chip->mgr;	
+		entry->private_data = chip->mgr;
 		entry->c.ops = &snd_mixart_proc_ops_BA0;
 		entry->size = MIXART_BA0_SIZE;
 	}
-	if (! snd_card_proc_new(chip->card, "mixart_BA1", &entry)) {
+	if (!snd_card_proc_new(chip->card, "mixart_BA1", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = chip->mgr;
 		entry->c.ops = &snd_mixart_proc_ops_BA1;
@@ -1278,7 +1278,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 	 */
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	if (! enable[dev]) {
+	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
 	}
@@ -1298,7 +1298,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 	/*
 	 */
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-	if (! mgr) {
+	if (!mgr) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
@@ -1367,7 +1367,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 		snprintf(tmpid, sizeof(tmpid), "%s-%d", id[dev] ? id[dev] : "MIXART", i);
 		card = snd_card_new(idx, tmpid, THIS_MODULE, 0);
 
-		if (! card) {
+		if (!card) {
 			snd_printk(KERN_ERR "cannot allocate the card %d\n", i);
 			snd_mixart_free(mgr);
 			return -ENOMEM;
@@ -1382,7 +1382,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 			return err;
 		}
 
-		if(i==0) {
+		if (i==0) {
 			/* init proc interface only for chip0 */
 			snd_mixart_proc_init(mgr->chip[i]);
 		}
@@ -1398,7 +1398,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 
 	/* create array of streaminfo */
 	size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
-			    sizeof(struct mixart_flowinfo)) );
+			    sizeof(struct mixart_flowinfo)));
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				size, &mgr->flowinfo) < 0) {
 		snd_mixart_free(mgr);
@@ -1409,7 +1409,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 
 	/* create array of bufferinfo */
 	size = PAGE_ALIGN( (MIXART_MAX_STREAM_PER_CARD * MIXART_MAX_CARDS *
-			    sizeof(struct mixart_bufferinfo)) );
+			    sizeof(struct mixart_bufferinfo)));
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				size, &mgr->bufferinfo) < 0) {
 		snd_mixart_free(mgr);
diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index b9a06c2..26b5f46 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -23,7 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include "mixart.h"
 #include "mixart_hwdep.h"
@@ -65,7 +65,7 @@ static int retrieve_msg_frame(struct mixart_mgr *mgr, u32 *msg_frame)
 
 	/* increment the tail index */
 	tailptr += 4;
-	if( tailptr >= (MSG_OUTBOUND_POST_STACK+MSG_BOUND_STACK_SIZE) )
+	if (tailptr >= (MSG_OUTBOUND_POST_STACK+MSG_BOUND_STACK_SIZE))
 		tailptr = MSG_OUTBOUND_POST_STACK;
 	writel_be(tailptr, MIXART_MEM(mgr, MSG_OUTBOUND_POST_TAIL));
 
@@ -73,7 +73,7 @@ static int retrieve_msg_frame(struct mixart_mgr *mgr, u32 *msg_frame)
 }
 
 static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
-		   u32 msg_frame_address )
+		   u32 msg_frame_address)
 {
 	unsigned long flags;
 	u32  headptr;
@@ -92,7 +92,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	resp->uid.object_id =  readl_be(MIXART_MEM(mgr, msg_frame_address + 8));   /* uidDest */
 	resp->uid.desc      =  readl_be(MIXART_MEM(mgr, msg_frame_address + 12));  /* */
 
-	if( (size < MSG_DESCRIPTOR_SIZE) || (resp->size < (size - MSG_DESCRIPTOR_SIZE))) {
+	if ((size < MSG_DESCRIPTOR_SIZE) || (resp->size < (size - MSG_DESCRIPTOR_SIZE))) {
 		err = -EINVAL;
 		snd_printk(KERN_ERR "problem with response size = %d\n", size);
 		goto _clean_exit;
@@ -105,7 +105,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	/* swap if necessary */
 #ifndef __BIG_ENDIAN
 	size /= 4; /* u32 size */
-	for(i=0; i < size; i++) {
+	for (i = 0; i < size; i++) {
 		((u32*)resp->data)[i] = be32_to_cpu(((u32*)resp->data)[i]);
 	}
 #endif
@@ -115,7 +115,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 	 */
 	headptr = readl_be(MIXART_MEM(mgr, MSG_OUTBOUND_FREE_HEAD));
 
-	if( (headptr < MSG_OUTBOUND_FREE_STACK) || ( headptr >= (MSG_OUTBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))) {
+	if ((headptr < MSG_OUTBOUND_FREE_STACK) || ( headptr >= (MSG_OUTBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))) {
 		err = -EINVAL;
 		goto _clean_exit;
 	}
@@ -125,12 +125,12 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
 
 	/* increment the outbound free head */
 	headptr += 4;
-	if( headptr >= (MSG_OUTBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE) )
+	if (headptr >= (MSG_OUTBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))
 		headptr = MSG_OUTBOUND_FREE_STACK;
 
 	writel_be(headptr, MIXART_MEM(mgr, MSG_OUTBOUND_FREE_HEAD));
 
- _clean_exit:
+_clean_exit:
 	spin_unlock_irqrestore(&mgr->msg_lock, flags);
 
 	return err;
@@ -141,7 +141,7 @@ static int get_msg(struct mixart_mgr *mgr, struct mixart_msg *resp,
  * send a message to miXart. return: the msg_frame used for this message
  */
 /* call with mgr->msg_lock held! */
-static int send_msg( struct mixart_mgr *mgr,
+static int send_msg(struct mixart_mgr *mgr,
 		     struct mixart_msg *msg,
 		     int max_answersize,
 		     int mark_pending,
@@ -165,7 +165,7 @@ static int send_msg( struct mixart_mgr *mgr,
 		return -EBUSY;
 	}
 
-	if( (tailptr < MSG_INBOUND_FREE_STACK) || (tailptr >= (MSG_INBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))) {
+	if ((tailptr < MSG_INBOUND_FREE_STACK) || (tailptr >= (MSG_INBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))) {
 		return -EINVAL;
 	}
 
@@ -174,7 +174,7 @@ static int send_msg( struct mixart_mgr *mgr,
 
 	/* increment the inbound free tail */
 	tailptr += 4;
-	if( tailptr >= (MSG_INBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE) )
+	if (tailptr >= (MSG_INBOUND_FREE_STACK+MSG_BOUND_STACK_SIZE))
 		tailptr = MSG_INBOUND_FREE_STACK;
 
 	writel_be(tailptr, MIXART_MEM(mgr, MSG_INBOUND_FREE_TAIL));
@@ -182,24 +182,24 @@ static int send_msg( struct mixart_mgr *mgr,
 	/* TODO : use memcpy_toio() with intermediate buffer to copy the message */
 
 	/* copy message descriptor to card memory */
-	writel_be( msg->size + MSG_DESCRIPTOR_SIZE,      MIXART_MEM(mgr, msg_frame_address) );      /* size of descriptor + request */
-	writel_be( msg->message_id ,                     MIXART_MEM(mgr, msg_frame_address + 4) );  /* dwMessageID */
-	writel_be( msg->uid.object_id,                   MIXART_MEM(mgr, msg_frame_address + 8) );  /* uidDest */
-	writel_be( msg->uid.desc,                        MIXART_MEM(mgr, msg_frame_address + 12) ); /* */
-	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 16) ); /* SizeHeader */
-	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 20) ); /* OffsetDLL_T16 */
-	writel_be( msg->size,                            MIXART_MEM(mgr, msg_frame_address + 24) ); /* SizeDLL_T16 */
-	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 28) ); /* OffsetDLL_DRV */
-	writel_be( 0,                                    MIXART_MEM(mgr, msg_frame_address + 32) ); /* SizeDLL_DRV */
-	writel_be( MSG_DESCRIPTOR_SIZE + max_answersize, MIXART_MEM(mgr, msg_frame_address + 36) ); /* dwExpectedAnswerSize */
+	writel_be( msg->size + MSG_DESCRIPTOR_SIZE,      MIXART_MEM(mgr, msg_frame_address));      /* size of descriptor + request */
+	writel_be( msg->message_id ,                     MIXART_MEM(mgr, msg_frame_address + 4));  /* dwMessageID */
+	writel_be( msg->uid.object_id,                   MIXART_MEM(mgr, msg_frame_address + 8));  /* uidDest */
+	writel_be( msg->uid.desc,                        MIXART_MEM(mgr, msg_frame_address + 12)); /* */
+	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 16)); /* SizeHeader */
+	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 20)); /* OffsetDLL_T16 */
+	writel_be( msg->size,                            MIXART_MEM(mgr, msg_frame_address + 24)); /* SizeDLL_T16 */
+	writel_be( MSG_DESCRIPTOR_SIZE,                  MIXART_MEM(mgr, msg_frame_address + 28)); /* OffsetDLL_DRV */
+	writel_be( 0,                                    MIXART_MEM(mgr, msg_frame_address + 32)); /* SizeDLL_DRV */
+	writel_be( MSG_DESCRIPTOR_SIZE + max_answersize, MIXART_MEM(mgr, msg_frame_address + 36)); /* dwExpectedAnswerSize */
 
 	/* copy message data to card memory */
-	for( i=0; i < msg->size; i+=4 ) {
-		writel_be( *(u32*)(msg->data + i), MIXART_MEM(mgr, MSG_HEADER_SIZE + msg_frame_address + i)  );
+	for (i = 0; i < msg->size; i += 4) {
+		writel_be( *(u32*)(msg->data + i), MIXART_MEM(mgr, MSG_HEADER_SIZE + msg_frame_address + i) );
 	}
 
-	if( mark_pending ) {
-		if( *msg_event ) {
+	if (mark_pending) {
+		if (*msg_event) {
 			/* the pending event is the notification we wait for ! */
 			mgr->pending_event = *msg_event;
 		}
@@ -218,7 +218,7 @@ static int send_msg( struct mixart_mgr *mgr,
 	/* post the frame */
 	headptr = readl_be(MIXART_MEM(mgr, MSG_INBOUND_POST_HEAD));
 
-	if( (headptr < MSG_INBOUND_POST_STACK) || (headptr >= (MSG_INBOUND_POST_STACK+MSG_BOUND_STACK_SIZE))) {
+	if ((headptr < MSG_INBOUND_POST_STACK) || (headptr >= (MSG_INBOUND_POST_STACK+MSG_BOUND_STACK_SIZE))) {
 		return -EINVAL;
 	}
 
@@ -226,7 +226,7 @@ static int send_msg( struct mixart_mgr *mgr,
 
 	/* increment the inbound post head */
 	headptr += 4;
-	if( headptr >= (MSG_INBOUND_POST_STACK+MSG_BOUND_STACK_SIZE) )
+	if (headptr >= (MSG_INBOUND_POST_STACK+MSG_BOUND_STACK_SIZE))
 		headptr = MSG_INBOUND_POST_STACK;
 
 	writel_be(headptr, MIXART_MEM(mgr, MSG_INBOUND_POST_HEAD));
@@ -262,7 +262,7 @@ int snd_mixart_send_msg(struct mixart_mgr *mgr, struct mixart_msg *request, int
 	timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
 	remove_wait_queue(&mgr->msg_sleep, &wait);
 
-	if (! timeout) {
+	if (!timeout) {
 		/* error - no ack */
 		mutex_unlock(&mgr->msg_mutex);
 		snd_printk(KERN_ERR "error: no reponse on msg %x\n", msg_frame);
@@ -277,7 +277,7 @@ int snd_mixart_send_msg(struct mixart_mgr *mgr, struct mixart_msg *request, int
 
 	err = get_msg(mgr, &resp, msg_frame);
 
-	if( request->message_id != resp.message_id )
+	if (request->message_id != resp.message_id)
 		snd_printk(KERN_ERR "REPONSE ERROR!\n");
 
 	mutex_unlock(&mgr->msg_mutex);
@@ -306,7 +306,7 @@ int snd_mixart_send_msg_wait_notif(struct mixart_mgr *mgr,
 	spin_lock_irq(&mgr->msg_lock);
 	/* send the message */
 	err = send_msg(mgr, request, MSG_DEFAULT_SIZE, 1, &notif_event);  /* send and mark the notification event pending */
-	if(err) {
+	if (err) {
 		spin_unlock_irq(&mgr->msg_lock);
 		mutex_unlock(&mgr->msg_mutex);
 		return err;
@@ -318,7 +318,7 @@ int snd_mixart_send_msg_wait_notif(struct mixart_mgr *mgr,
 	timeout = schedule_timeout(MSG_TIMEOUT_JIFFIES);
 	remove_wait_queue(&mgr->msg_sleep, &wait);
 
-	if (! timeout) {
+	if (!timeout) {
 		/* error - no ack */
 		mutex_unlock(&mgr->msg_mutex);
 		snd_printk(KERN_ERR "error: notification %x not received\n", notif_event);
@@ -354,7 +354,7 @@ static u32 mixart_msg_data[MSG_DEFAULT_SIZE / 4];
 
 void snd_mixart_msg_tasklet(unsigned long arg)
 {
-	struct mixart_mgr *mgr = ( struct mixart_mgr*)(arg);
+	struct mixart_mgr *mgr = (struct mixart_mgr*)(arg);
 	struct mixart_msg resp;
 	u32 msg, addr, type;
 	int err;
@@ -377,7 +377,7 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 			resp.data = mixart_msg_data;
 			resp.size = sizeof(mixart_msg_data);
 			err = get_msg(mgr, &resp, addr);
-			if( err < 0 ) {
+			if (err < 0) {
 				snd_printk(KERN_ERR "tasklet: error(%d) reading mf %x\n", err, msg);
 				break;
 			}
@@ -387,7 +387,7 @@ void snd_mixart_msg_tasklet(unsigned long arg)
 			case MSG_STREAM_START_OUTPUT_STAGE_PACKET:
 			case MSG_STREAM_STOP_INPUT_STAGE_PACKET:
 			case MSG_STREAM_STOP_OUTPUT_STAGE_PACKET:
-				if(mixart_msg_data[0])
+				if (mixart_msg_data[0])
 					snd_printk(KERN_ERR "tasklet : error MSG_STREAM_ST***_***PUT_STAGE_PACKET status=%x\n", mixart_msg_data[0]);
 				break;
 			default:
@@ -425,7 +425,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 	spin_lock(&mgr->lock);
 
 	it_reg = readl_le(MIXART_REG(mgr, MIXART_PCI_OMISR_OFFSET));
-	if( !(it_reg & MIXART_OIDI) ) {
+	if (!(it_reg & MIXART_OIDI)) {
 		/* this device did not cause the interrupt */
 		spin_unlock(&mgr->lock);
 		return IRQ_NONE;
@@ -439,7 +439,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 	writel(it_reg, MIXART_REG(mgr, MIXART_PCI_ODBR_OFFSET));
 
 	/* clear interrupt */
-	writel_le( MIXART_OIDI, MIXART_REG(mgr, MIXART_PCI_OMISR_OFFSET) );
+	writel_le( MIXART_OIDI, MIXART_REG(mgr, MIXART_PCI_OMISR_OFFSET));
 
 	/* process interrupt */
 	while (retrieve_msg_frame(mgr, &msg)) {
@@ -450,17 +450,17 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 			resp.data = mixart_msg_data;
 			resp.size = sizeof(mixart_msg_data);
 			err = get_msg(mgr, &resp, msg & ~MSG_TYPE_MASK);
-			if( err < 0 ) {
+			if (err < 0) {
 				snd_printk(KERN_ERR "interrupt: error(%d) reading mf %x\n", err, msg);
 				break;
 			}
 
-			if(resp.message_id == MSG_SERVICES_TIMER_NOTIFY) {
+			if (resp.message_id == MSG_SERVICES_TIMER_NOTIFY) {
 				int i;
 				struct mixart_timer_notify *notify;
 				notify = (struct mixart_timer_notify *)mixart_msg_data;
 
-				for(i=0; i<notify->stream_count; i++) {
+				for (i = 0; i < notify->stream_count; i++) {
 
 					u32 buffer_id = notify->streams[i].buffer_id;
 					unsigned int chip_number =  (buffer_id & MIXART_NOTIFY_CARD_MASK) >> MIXART_NOTIFY_CARD_OFFSET; /* card0 to 3 */
@@ -503,9 +503,9 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 								stream->abs_period_elapsed = new_elapse_pos;
 							}
 						}
-						stream->buf_period_frag = (u32)( sample_count - stream->abs_period_elapsed );
+						stream->buf_period_frag = (u32)(sample_count - stream->abs_period_elapsed);
 
-						if(elapsed) {
+						if (elapsed) {
 							spin_unlock(&mgr->lock);
 							snd_pcm_period_elapsed(stream->substream);
 							spin_lock(&mgr->lock);
@@ -514,12 +514,12 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 				}
 				break;
 			}
-			if(resp.message_id == MSG_SERVICES_REPORT_TRACES) {
-				if(resp.size > 1) {
+			if (resp.message_id == MSG_SERVICES_REPORT_TRACES) {
+				if (resp.size > 1) {
 #ifndef __BIG_ENDIAN
 					/* Traces are text: the swapped msg_data has to be swapped back ! */
 					int i;
-					for(i=0; i<(resp.size/4); i++) {
+					for (i = 0; i < (resp.size/4); i++) {
 						(mixart_msg_data)[i] = cpu_to_be32((mixart_msg_data)[i]);
 					}
 #endif
@@ -533,7 +533,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 			break;
 
 		case MSG_TYPE_NOTIFY:
-			if(msg & MSG_CANCEL_NOTIFY_MASK) {
+			if (msg & MSG_CANCEL_NOTIFY_MASK) {
 				msg &= ~MSG_CANCEL_NOTIFY_MASK;
 				snd_printk(KERN_ERR "canceled notification %x !\n", msg);
 			}
@@ -541,7 +541,7 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 		case MSG_TYPE_ANSWER:
 			/* answer or notification to a message we are waiting for*/
 			spin_lock(&mgr->msg_lock);
-			if( (msg & ~MSG_TYPE_MASK) == mgr->pending_event ) {
+			if ((msg & ~MSG_TYPE_MASK) == mgr->pending_event) {
 				wake_up(&mgr->msg_sleep);
 				mgr->pending_event = 0;
 			}
@@ -573,11 +573,11 @@ irqreturn_t snd_mixart_interrupt(int irq, void *dev_id)
 
 void snd_mixart_init_mailbox(struct mixart_mgr *mgr)
 {
-	writel( 0, MIXART_MEM( mgr, MSG_HOST_RSC_PROTECTION ) );
-	writel( 0, MIXART_MEM( mgr, MSG_AGENT_RSC_PROTECTION ) );
+	writel( 0, MIXART_MEM( mgr, MSG_HOST_RSC_PROTECTION ));
+	writel( 0, MIXART_MEM( mgr, MSG_AGENT_RSC_PROTECTION ));
 
 	/* allow outbound messagebox to generate interrupts */
-	if(mgr->irq >= 0) {
+	if (mgr->irq >= 0) {
 		writel_le( MIXART_ALLOW_OUTBOUND_DOORBELL, MIXART_REG( mgr, MIXART_PCI_OMIMR_OFFSET));
 	}
 	return;
@@ -593,6 +593,6 @@ void snd_mixart_exit_mailbox(struct mixart_mgr *mgr)
 void snd_mixart_reset_board(struct mixart_mgr *mgr)
 {
 	/* reset miXart */
-	writel_be( 1, MIXART_REG(mgr, MIXART_BA1_BRUTAL_RESET_OFFSET) );
+	writel_be( 1, MIXART_REG(mgr, MIXART_BA1_BRUTAL_RESET_OFFSET));
 	return;
 }
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 3782b52..18639aa 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -24,7 +24,7 @@
 #include <linux/pci.h>
 #include <linux/firmware.h>
 #include <linux/vmalloc.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include "mixart.h"
 #include "mixart_mixer.h"
@@ -53,20 +53,20 @@ static int mixart_wait_nice_for_register_value(struct mixart_mgr *mgr,
 		cond_resched();
 
 		read = readl_be( MIXART_MEM( mgr, offset ));
-		if(is_egal) {
-			if(read == value) return 0;
+		if (is_egal) {
+			if (read == value) return 0;
 		}
 		else { /* wait for different value */
-			if(read != value) return 0;
+			if (read != value) return 0;
 		}
-	} while ( time_after_eq(end_time, jiffies) );
+	} while ( time_after_eq(end_time, jiffies));
 
 	return -EBUSY;
 }
 
 
 /*
-  structures needed to upload elf code packets 
+  structures needed to upload elf code packets
  */
 struct snd_mixart_elf32_ehdr {
 	u8      e_ident[16];
@@ -96,27 +96,27 @@ struct snd_mixart_elf32_phdr {
 	u32     p_align;
 };
 
-static int mixart_load_elf(struct mixart_mgr *mgr, const struct firmware *dsp )
+static int mixart_load_elf(struct mixart_mgr *mgr, const struct firmware *dsp)
 {
 	char                    elf32_magic_number[4] = {0x7f,'E','L','F'};
 	struct snd_mixart_elf32_ehdr *elf_header;
 	int                     i;
 
 	elf_header = (struct snd_mixart_elf32_ehdr *)dsp->data;
-	for( i=0; i<4; i++ )
-		if ( elf32_magic_number[i] != elf_header->e_ident[i] )
+	for (i = 0; i < 4; i++)
+		if (elf32_magic_number[i] != elf_header->e_ident[i])
 			return -EINVAL;
 
-	if( elf_header->e_phoff != 0 ) {
+	if (elf_header->e_phoff != 0) {
 		struct snd_mixart_elf32_phdr     elf_programheader;
 
-		for( i=0; i < be16_to_cpu(elf_header->e_phnum); i++ ) {
+		for (i = 0; i < be16_to_cpu(elf_header->e_phnum); i++) {
 			u32 pos = be32_to_cpu(elf_header->e_phoff) + (u32)(i * be16_to_cpu(elf_header->e_phentsize));
 
-			memcpy( &elf_programheader, dsp->data + pos, sizeof(elf_programheader) );
+			memcpy( &elf_programheader, dsp->data + pos, sizeof(elf_programheader));
 
-			if(elf_programheader.p_type != 0) {
-				if( elf_programheader.p_filesz != 0 ) {
+			if (elf_programheader.p_type != 0) {
+				if (elf_programheader.p_filesz != 0) {
 					memcpy_toio( MIXART_MEM( mgr, be32_to_cpu(elf_programheader.p_vaddr)),
 						     dsp->data + be32_to_cpu( elf_programheader.p_offset ),
 						     be32_to_cpu( elf_programheader.p_filesz ));
@@ -147,7 +147,7 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 	connector = kmalloc(sizeof(*connector), GFP_KERNEL);
 	audio_info_req = kmalloc(sizeof(*audio_info_req), GFP_KERNEL);
 	audio_info = kmalloc(sizeof(*audio_info), GFP_KERNEL);
-	if (! connector || ! audio_info_req || ! audio_info) {
+	if (!connector || !audio_info_req || !audio_info) {
 		err = -ENOMEM;
 		goto __error;
 	}
@@ -162,21 +162,21 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 	request.size = 0;
 
 	err = snd_mixart_send_msg(mgr, &request, sizeof(*connector), connector);
-	if((err < 0) || (connector->error_code) || (connector->uid_count > MIXART_MAX_PHYS_CONNECTORS)) {
+	if ((err < 0) || (connector->error_code) || (connector->uid_count > MIXART_MAX_PHYS_CONNECTORS)) {
 		snd_printk(KERN_ERR "error MSG_SYSTEM_ENUM_PLAY_CONNECTOR\n");
 		err = -EINVAL;
 		goto __error;
 	}
 
-	for(k=0; k < connector->uid_count; k++) {
+	for (k=0; k < connector->uid_count; k++) {
 		struct mixart_pipe *pipe;
 
-		if(k < MIXART_FIRST_DIG_AUDIO_ID) {
+		if (k < MIXART_FIRST_DIG_AUDIO_ID) {
 			pipe = &mgr->chip[k/2]->pipe_out_ana;
 		} else {
 			pipe = &mgr->chip[(k-MIXART_FIRST_DIG_AUDIO_ID)/2]->pipe_out_dig;
 		}
-		if(k & 1) {
+		if (k & 1) {
 			pipe->uid_right_connector = connector->uid[k];   /* odd */
 		} else {
 			pipe->uid_left_connector = connector->uid[k];    /* even */
@@ -191,7 +191,7 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 		request.size = sizeof(*audio_info_req);
 
 		err = snd_mixart_send_msg(mgr, &request, sizeof(*audio_info), audio_info);
-		if( err < 0 ) {
+		if (err < 0) {
 			snd_printk(KERN_ERR "error MSG_CONNECTOR_GET_AUDIO_INFO\n");
 			goto __error;
 		}
@@ -204,21 +204,21 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 	request.size = 0;
 
 	err = snd_mixart_send_msg(mgr, &request, sizeof(*connector), connector);
-	if((err < 0) || (connector->error_code) || (connector->uid_count > MIXART_MAX_PHYS_CONNECTORS)) {
+	if ((err < 0) || (connector->error_code) || (connector->uid_count > MIXART_MAX_PHYS_CONNECTORS)) {
 		snd_printk(KERN_ERR "error MSG_SYSTEM_ENUM_RECORD_CONNECTOR\n");
 		err = -EINVAL;
 		goto __error;
 	}
 
-	for(k=0; k < connector->uid_count; k++) {
+	for (k=0; k < connector->uid_count; k++) {
 		struct mixart_pipe *pipe;
 
-		if(k < MIXART_FIRST_DIG_AUDIO_ID) {
+		if (k < MIXART_FIRST_DIG_AUDIO_ID) {
 			pipe = &mgr->chip[k/2]->pipe_in_ana;
 		} else {
 			pipe = &mgr->chip[(k-MIXART_FIRST_DIG_AUDIO_ID)/2]->pipe_in_dig;
 		}
-		if(k & 1) {
+		if (k & 1) {
 			pipe->uid_right_connector = connector->uid[k];   /* odd */
 		} else {
 			pipe->uid_left_connector = connector->uid[k];    /* even */
@@ -233,7 +233,7 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 		request.size = sizeof(*audio_info_req);
 
 		err = snd_mixart_send_msg(mgr, &request, sizeof(*audio_info), audio_info);
-		if( err < 0 ) {
+		if (err < 0) {
 			snd_printk(KERN_ERR "error MSG_CONNECTOR_GET_AUDIO_INFO\n");
 			goto __error;
 		}
@@ -241,7 +241,7 @@ static int mixart_enum_connectors(struct mixart_mgr *mgr)
 	}
 	err = 0;
 
- __error:
+__error:
 	kfree(connector);
 	kfree(audio_info_req);
 	kfree(audio_info);
@@ -269,7 +269,7 @@ static int mixart_enum_physio(struct mixart_mgr *mgr)
 
 	err = snd_mixart_send_msg(mgr, &request, sizeof(console_mgr), &console_mgr);
 
-	if( (err < 0) || (console_mgr.error_code != 0) ) {
+	if ((err < 0) || (console_mgr.error_code != 0)) {
 		snd_printk(KERN_DEBUG "error MSG_CONSOLE_GET_CLOCK_UID : err=%x\n", console_mgr.error_code);
 		return -EINVAL;
 	}
@@ -283,8 +283,8 @@ static int mixart_enum_physio(struct mixart_mgr *mgr)
 	request.size = sizeof(console_mgr.uid);
 
 	err = snd_mixart_send_msg(mgr, &request, sizeof(phys_io), &phys_io);
-	if( (err < 0) || ( phys_io.error_code != 0 ) ) {
-		snd_printk(KERN_ERR "error MSG_SYSTEM_ENUM_PHYSICAL_IO err(%x) error_code(%x)\n", err, phys_io.error_code );
+	if ((err < 0) || ( phys_io.error_code != 0 )) {
+		snd_printk(KERN_ERR "error MSG_SYSTEM_ENUM_PHYSICAL_IO err(%x) error_code(%x)\n", err, phys_io.error_code);
 		return -EINVAL;
 	}
 
@@ -292,9 +292,9 @@ static int mixart_enum_physio(struct mixart_mgr *mgr)
 	if (phys_io.nb_uid < MIXART_MAX_CARDS * 2)
 		return -EINVAL;
 
-	for(k=0; k<mgr->num_cards; k++) {
+	for (k=0; k<mgr->num_cards; k++) {
 		mgr->chip[k]->uid_in_analog_physio = phys_io.uid[k];
-		mgr->chip[k]->uid_out_analog_physio = phys_io.uid[phys_io.nb_uid/2 + k]; 
+		mgr->chip[k]->uid_out_analog_physio = phys_io.uid[phys_io.nb_uid/2 + k];
 	}
 
 	return 0;
@@ -307,9 +307,9 @@ static int mixart_first_init(struct mixart_mgr *mgr)
 	int err;
 	struct mixart_msg request;
 
-	if((err = mixart_enum_connectors(mgr)) < 0) return err;
+	if ((err = mixart_enum_connectors(mgr)) < 0) return err;
 
-	if((err = mixart_enum_physio(mgr)) < 0) return err;
+	if ((err = mixart_enum_physio(mgr)) < 0) return err;
 
 	/* send a synchro command to card (necessary to do this before first MSG_STREAM_START_STREAM_GRP_PACKET) */
 	/* though why not here */
@@ -319,7 +319,7 @@ static int mixart_first_init(struct mixart_mgr *mgr)
 	request.size = 0;
 	/* this command has no data. response is a 32 bit status */
 	err = snd_mixart_send_msg(mgr, &request, sizeof(k), &k);
-	if( (err < 0) || (k != 0) ) {
+	if ((err < 0) || (k != 0)) {
 		snd_printk(KERN_ERR "error MSG_SYSTEM_SEND_SYNCHRO_CMD\n");
 		return err == 0 ? -EINVAL : err;
 	}
@@ -345,22 +345,22 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 	status_daught = readl_be( MIXART_MEM( mgr,MIXART_PSEUDOREG_DXLX_STATUS_OFFSET ));
 
 	/* motherboard xilinx status 5 will say that the board is performing a reset */
-	if( status_xilinx == 5 ) {
-		snd_printk( KERN_ERR "miXart is resetting !\n");
+	if (status_xilinx == 5) {
+		snd_printk(KERN_ERR "miXart is resetting !\n");
 		return -EAGAIN; /* try again later */
 	}
 
 	switch (index)   {
 	case MIXART_MOTHERBOARD_XLX_INDEX:
 
-		/* xilinx already loaded ? */ 
-		if( status_xilinx == 4 ) {
-			snd_printk( KERN_DEBUG "xilinx is already loaded !\n");
+		/* xilinx already loaded ? */
+		if (status_xilinx == 4) {
+			snd_printk(KERN_DEBUG "xilinx is already loaded !\n");
 			return 0;
 		}
 		/* the status should be 0 == "idle" */
-		if( status_xilinx != 0 ) {
-			snd_printk( KERN_ERR "xilinx load error ! status = %d\n", status_xilinx);
+		if (status_xilinx != 0) {
+			snd_printk(KERN_ERR "xilinx load error ! status = %d\n", status_xilinx);
 			return -EIO; /* modprob -r may help ? */
 		}
 
@@ -380,7 +380,7 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 
 		/* copy xilinx code */
 		memcpy_toio(  MIXART_MEM( mgr, MIXART_MOTHERBOARD_XLX_BASE_ADDRESS),  dsp->data,  dsp->size);
-    
+
 		/* set xilinx status to copy finished */
 		writel_be( 2, MIXART_MEM( mgr, MIXART_PSEUDOREG_MXLX_STATUS_OFFSET ));
 
@@ -389,33 +389,33 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 
 	case MIXART_MOTHERBOARD_ELF_INDEX:
 
-		if( status_elf == 4 ) {
-			snd_printk( KERN_DEBUG "elf file already loaded !\n");
+		if (status_elf == 4) {
+			snd_printk(KERN_DEBUG "elf file already loaded !\n");
 			return 0;
 		}
 
 		/* the status should be 0 == "idle" */
-		if( status_elf != 0 ) {
-			snd_printk( KERN_ERR "elf load error ! status = %d\n", status_elf);
+		if (status_elf != 0) {
+			snd_printk(KERN_ERR "elf load error ! status = %d\n", status_elf);
 			return -EIO; /* modprob -r may help ? */
 		}
 
 		/* wait for xilinx status == 4 */
 		err = mixart_wait_nice_for_register_value( mgr, MIXART_PSEUDOREG_MXLX_STATUS_OFFSET, 1, 4, 500); /* 5sec */
 		if (err < 0) {
-			snd_printk( KERN_ERR "xilinx was not loaded or could not be started\n");
+			snd_printk(KERN_ERR "xilinx was not loaded or could not be started\n");
 			return err;
 		}
 
 		/* init some data on the card */
-		writel_be( 0, MIXART_MEM( mgr, MIXART_PSEUDOREG_BOARDNUMBER ) ); /* set miXart boardnumber to 0 */
-		writel_be( 0, MIXART_MEM( mgr, MIXART_FLOWTABLE_PTR ) );         /* reset pointer to flow table on miXart */
+		writel_be( 0, MIXART_MEM( mgr, MIXART_PSEUDOREG_BOARDNUMBER )); /* set miXart boardnumber to 0 */
+		writel_be( 0, MIXART_MEM( mgr, MIXART_FLOWTABLE_PTR ));         /* reset pointer to flow table on miXart */
 
 		/* set elf status to copying */
 		writel_be( 1, MIXART_MEM( mgr, MIXART_PSEUDOREG_ELF_STATUS_OFFSET ));
 
 		/* process the copying of the elf packets */
-		err = mixart_load_elf( mgr, dsp );
+		err = mixart_load_elf( mgr, dsp);
 		if (err < 0) return err;
 
 		/* set elf status to copy finished */
@@ -424,12 +424,12 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 		/* wait for elf status == 4 */
 		err = mixart_wait_nice_for_register_value( mgr, MIXART_PSEUDOREG_ELF_STATUS_OFFSET, 1, 4, 300); /* 3sec */
 		if (err < 0) {
-			snd_printk( KERN_ERR "elf could not be started\n");
+			snd_printk(KERN_ERR "elf could not be started\n");
 			return err;
 		}
 
 		/* miXart waits at this point on the pointer to the flow table */
-		writel_be( (u32)mgr->flowinfo.addr, MIXART_MEM( mgr, MIXART_FLOWTABLE_PTR ) ); /* give pointer of flow table to miXart */
+		writel_be( (u32)mgr->flowinfo.addr, MIXART_MEM( mgr, MIXART_FLOWTABLE_PTR )); /* give pointer of flow table to miXart */
 
 		return 0;  /* return, another xilinx file has to be loaded before */
 
@@ -437,15 +437,15 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 	default:
 
 		/* elf and xilinx should be loaded */
-		if( (status_elf != 4) || (status_xilinx != 4) ) {
-			printk( KERN_ERR "xilinx or elf not successfully loaded\n");
+		if ((status_elf != 4) || (status_xilinx != 4)) {
+			printk(KERN_ERR "xilinx or elf not successfully loaded\n");
 			return -EIO; /* modprob -r may help ? */
 		}
 
 		/* wait for daughter detection != 0 */
 		err = mixart_wait_nice_for_register_value( mgr, MIXART_PSEUDOREG_DBRD_PRESENCE_OFFSET, 0, 0, 30); /* 300msec */
 		if (err < 0) {
-			snd_printk( KERN_ERR "error starting elf file\n");
+			snd_printk(KERN_ERR "error starting elf file\n");
 			return err;
 		}
 
@@ -455,16 +455,16 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 		if (mgr->board_type == MIXART_DAUGHTER_TYPE_NONE)
 			break;  /* no daughter board; the file does not have to be loaded, continue after the switch */
 
-		/* only if aesebu daughter board presence (elf code must run)  */ 
-		if (mgr->board_type != MIXART_DAUGHTER_TYPE_AES )
+		/* only if aesebu daughter board presence (elf code must run)  */
+		if (mgr->board_type != MIXART_DAUGHTER_TYPE_AES)
 			return -EINVAL;
 
 		/* daughter should be idle */
-		if( status_daught != 0 ) {
-			printk( KERN_ERR "daughter load error ! status = %d\n", status_daught);
+		if (status_daught != 0) {
+			printk(KERN_ERR "daughter load error ! status = %d\n", status_daught);
 			return -EIO; /* modprob -r may help ? */
 		}
- 
+
 		/* check daughterboard xilinx validity */
 		if (((u32*)(dsp->data))[0] == 0xffffffff)
 			return -EINVAL;
@@ -480,7 +480,7 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 		/* wait for status == 2 */
 		err = mixart_wait_nice_for_register_value( mgr, MIXART_PSEUDOREG_DXLX_STATUS_OFFSET, 1, 2, 30); /* 300msec */
 		if (err < 0) {
-			snd_printk( KERN_ERR "daughter board load error\n");
+			snd_printk(KERN_ERR "daughter board load error\n");
 			return err;
 		}
 
@@ -502,7 +502,7 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
         /* wait for daughter status == 3 */
         err = mixart_wait_nice_for_register_value( mgr, MIXART_PSEUDOREG_DXLX_STATUS_OFFSET, 1, 3, 300); /* 3sec */
         if (err < 0) {
-		snd_printk( KERN_ERR "daughter board could not be initialised\n");
+		snd_printk(KERN_ERR "daughter board could not be initialised\n");
 		return err;
 	}
 
@@ -512,7 +512,7 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
 	/* first communication with embedded */
 	err = mixart_first_init(mgr);
         if (err < 0) {
-		snd_printk( KERN_ERR "miXart could not be set up\n");
+		snd_printk(KERN_ERR "miXart could not be set up\n");
 		return err;
 	}
 
@@ -615,7 +615,7 @@ static int mixart_hwdep_dsp_load(struct snd_hwdep *hw,
 
 	fw.size = dsp->length;
 	fw.data = vmalloc(dsp->length);
-	if (! fw.data) {
+	if (!fw.data) {
 		snd_printk(KERN_ERR "miXart: cannot allocate image size %d\n",
 			   (int)dsp->length);
 		return -ENOMEM;
diff --git a/sound/pci/mixart/mixart_hwdep.h b/sound/pci/mixart/mixart_hwdep.h
index a46f508..ce1f109 100644
--- a/sound/pci/mixart/mixart_hwdep.h
+++ b/sound/pci/mixart/mixart_hwdep.h
@@ -36,12 +36,12 @@
 
 
 /* Daughter board Type */
-#define DAUGHTER_TYPE_MASK     0x0F 
-#define DAUGHTER_VER_MASK      0xF0 
+#define DAUGHTER_TYPE_MASK     0x0F
+#define DAUGHTER_VER_MASK      0xF0
 #define DAUGHTER_TYPEVER_MASK  (DAUGHTER_TYPE_MASK|DAUGHTER_VER_MASK)
- 
-#define MIXART_DAUGHTER_TYPE_NONE     0x00 
-#define MIXART_DAUGHTER_TYPE_COBRANET 0x08 
+
+#define MIXART_DAUGHTER_TYPE_NONE     0x00
+#define MIXART_DAUGHTER_TYPE_COBRANET 0x08
 #define MIXART_DAUGHTER_TYPE_AES      0x0E
 
 
@@ -63,28 +63,28 @@
 #define  MIXART_PSEUDOREG_PERF_INTERR_LOAD_OFFSET  MIXART_PSEUDOREG+0x74     /* interrupt handling  load */
 
 /* motherboard xilinx loader info */
-#define  MIXART_PSEUDOREG_MXLX_BASE_ADDR_OFFSET    MIXART_PSEUDOREG+0x9C     /* 0x00600000 */ 
-#define  MIXART_PSEUDOREG_MXLX_SIZE_OFFSET         MIXART_PSEUDOREG+0xA0     /* xilinx size in bytes */ 
-#define  MIXART_PSEUDOREG_MXLX_STATUS_OFFSET       MIXART_PSEUDOREG+0xA4     /* status = EMBEBBED_STAT_XXX */ 
+#define  MIXART_PSEUDOREG_MXLX_BASE_ADDR_OFFSET    MIXART_PSEUDOREG+0x9C     /* 0x00600000 */
+#define  MIXART_PSEUDOREG_MXLX_SIZE_OFFSET         MIXART_PSEUDOREG+0xA0     /* xilinx size in bytes */
+#define  MIXART_PSEUDOREG_MXLX_STATUS_OFFSET       MIXART_PSEUDOREG+0xA4     /* status = EMBEBBED_STAT_XXX */
 
 /* elf loader info */
-#define  MIXART_PSEUDOREG_ELF_STATUS_OFFSET        MIXART_PSEUDOREG+0xB0     /* status = EMBEBBED_STAT_XXX */ 
+#define  MIXART_PSEUDOREG_ELF_STATUS_OFFSET        MIXART_PSEUDOREG+0xB0     /* status = EMBEBBED_STAT_XXX */
 
-/* 
+/*
 *  after the elf code is loaded, and the flowtable info was passed to it,
 *  the driver polls on this address, until it shows 1 (presence) or 2 (absence)
 *  once it is non-zero, the daughter board type may be read
 */
-#define  MIXART_PSEUDOREG_DBRD_PRESENCE_OFFSET     MIXART_PSEUDOREG+0x990   
+#define  MIXART_PSEUDOREG_DBRD_PRESENCE_OFFSET     MIXART_PSEUDOREG+0x990
 
 /* Global info structure */
 #define  MIXART_PSEUDOREG_DBRD_TYPE_OFFSET         MIXART_PSEUDOREG+0x994    /* Type and version of daughterboard  */
 
 
 /* daughterboard xilinx loader info */
-#define  MIXART_PSEUDOREG_DXLX_BASE_ADDR_OFFSET    MIXART_PSEUDOREG+0x998    /* get the address here where to write the file */ 
-#define  MIXART_PSEUDOREG_DXLX_SIZE_OFFSET         MIXART_PSEUDOREG+0x99C    /* xilinx size in bytes */ 
-#define  MIXART_PSEUDOREG_DXLX_STATUS_OFFSET       MIXART_PSEUDOREG+0x9A0    /* status = EMBEBBED_STAT_XXX */ 
+#define  MIXART_PSEUDOREG_DXLX_BASE_ADDR_OFFSET    MIXART_PSEUDOREG+0x998    /* get the address here where to write the file */
+#define  MIXART_PSEUDOREG_DXLX_SIZE_OFFSET         MIXART_PSEUDOREG+0x99C    /* xilinx size in bytes */
+#define  MIXART_PSEUDOREG_DXLX_STATUS_OFFSET       MIXART_PSEUDOREG+0x9A0    /* status = EMBEBBED_STAT_XXX */
 
 /*  */
 #define  MIXART_FLOWTABLE_PTR                      0x3000                    /* pointer to flow table */
diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 3ba6174..388c257 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -310,25 +310,25 @@ static int mixart_update_analog_audio_level(struct snd_mixart* chip, int is_capt
 	memset(&io_level, 0, sizeof(io_level));
 	io_level.channel = -1; /* left and right */
 
-	for(i=0; i<2; i++) {
-		if(is_capture) {
+	for (i = 0; i < 2; i++) {
+		if (is_capture) {
 			io_level.level[i].analog_level = mixart_analog_level[chip->analog_capture_volume[i]];
 		} else {
-			if(chip->analog_playback_active[i])
+			if (chip->analog_playback_active[i])
 				io_level.level[i].analog_level = mixart_analog_level[chip->analog_playback_volume[i]];
 			else
 				io_level.level[i].analog_level = mixart_analog_level[MIXART_ANALOG_PLAYBACK_LEVEL_MIN];
 		}
 	}
 
-	if(is_capture)	request.uid = chip->uid_in_analog_physio;
+	if (is_capture)	request.uid = chip->uid_in_analog_physio;
 	else		request.uid = chip->uid_out_analog_physio;
 	request.message_id = MSG_PHYSICALIO_SET_LEVEL;
 	request.data = &io_level;
 	request.size = sizeof(io_level);
 
 	err = snd_mixart_send_msg(chip->mgr, &request, sizeof(resp), &resp);
-	if((err<0) || (resp.error_code)) {
+	if ((err<0) || (resp.error_code)) {
 		snd_printk(KERN_DEBUG "error MSG_PHYSICALIO_SET_LEVEL card(%d) is_capture(%d) error_code(%x)\n", chip->chip_idx, is_capture, resp.error_code);
 		return -EINVAL;
 	}
@@ -342,7 +342,7 @@ static int mixart_analog_vol_info(struct snd_kcontrol *kcontrol, struct snd_ctl_
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
-	if(kcontrol->private_value == 0) {	/* playback */
+	if (kcontrol->private_value == 0) {	/* playback */
 		uinfo->value.integer.min = MIXART_ANALOG_PLAYBACK_LEVEL_MIN;  /* -96 dB */
 		uinfo->value.integer.max = MIXART_ANALOG_PLAYBACK_LEVEL_MAX;  /* 0 dB */
 	} else {				/* capture */
@@ -356,7 +356,7 @@ static int mixart_analog_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 {
 	struct snd_mixart *chip = snd_kcontrol_chip(kcontrol);
 	mutex_lock(&chip->mgr->mixer_mutex);
-	if(kcontrol->private_value == 0) {	/* playback */
+	if (kcontrol->private_value == 0) {	/* playback */
 		ucontrol->value.integer.value[0] = chip->analog_playback_volume[0];
 		ucontrol->value.integer.value[1] = chip->analog_playback_volume[1];
 	} else {				/* capture */
@@ -731,7 +731,7 @@ int mixart_update_playback_stream_level(struct snd_mixart* chip, int is_aes, int
 	set_level.nb_of_stream = 1;
 	set_level.stream_level.desc.stream_idx = idx;
 
-	if(is_aes) {
+	if (is_aes) {
 		pipe = &chip->pipe_out_dig;	/* AES playback */
 		idx += MIXART_PLAYBACK_STREAMS;
 	} else {
@@ -739,13 +739,13 @@ int mixart_update_playback_stream_level(struct snd_mixart* chip, int is_aes, int
 	}
 
 	/* only when pipe exists ! */
-	if(pipe->status == PIPE_UNDEFINED)
+	if (pipe->status == PIPE_UNDEFINED)
 		return 0;
 
 	set_level.stream_level.desc.uid_pipe = pipe->group_uid;
 
-	for(i=0; i<2; i++) {
-		if(chip->digital_playback_active[idx][i])
+	for (i = 0; i < 2; i++) {
+		if (chip->digital_playback_active[idx][i])
 			volume[i] = chip->digital_playback_volume[idx][i];
 		else
 			volume[i] = MIXART_DIGITAL_LEVEL_MIN;
@@ -761,7 +761,7 @@ int mixart_update_playback_stream_level(struct snd_mixart* chip, int is_aes, int
 	request.size = sizeof(set_level);
 
 	err = snd_mixart_send_msg(chip->mgr, &request, sizeof(status), &status);
-	if((err<0) || status) {
+	if ((err<0) || status) {
 		snd_printk(KERN_DEBUG "error MSG_STREAM_SET_OUT_STREAM_LEVEL card(%d) status(%x)\n", chip->chip_idx, status);
 		return -EINVAL;
 	}
@@ -776,7 +776,7 @@ int mixart_update_capture_stream_level(struct snd_mixart* chip, int is_aes)
 	struct mixart_set_in_audio_level_req set_level;
 	u32 status;
 
-	if(is_aes) {
+	if (is_aes) {
 		idx = 1;
 		pipe = &chip->pipe_in_dig;
 	} else {
@@ -785,7 +785,7 @@ int mixart_update_capture_stream_level(struct snd_mixart* chip, int is_aes)
 	}
 
 	/* only when pipe exists ! */
-	if(pipe->status == PIPE_UNDEFINED)
+	if (pipe->status == PIPE_UNDEFINED)
 		return 0;
 
 	memset(&set_level, 0, sizeof(set_level));
@@ -793,7 +793,7 @@ int mixart_update_capture_stream_level(struct snd_mixart* chip, int is_aes)
 	set_level.level[0].connector = pipe->uid_left_connector;
 	set_level.level[1].connector = pipe->uid_right_connector;
 
-	for(i=0; i<2; i++) {
+	for (i = 0; i < 2; i++) {
 		set_level.level[i].valid_mask1 = MIXART_AUDIO_LEVEL_DIGITAL_MASK;
 		set_level.level[i].digital_level = mixart_digital_level[chip->digital_capture_volume[idx][i]];
 	}
@@ -804,7 +804,7 @@ int mixart_update_capture_stream_level(struct snd_mixart* chip, int is_aes)
 	request.size = sizeof(set_level);
 
 	err = snd_mixart_send_msg(chip->mgr, &request, sizeof(status), &status);
-	if((err<0) || status) {
+	if ((err<0) || status) {
 		snd_printk(KERN_DEBUG "error MSG_STREAM_SET_IN_AUDIO_LEVEL card(%d) status(%x)\n", chip->chip_idx, status);
 		return -EINVAL;
 	}
@@ -833,12 +833,12 @@ static int mixart_pcm_vol_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 	int is_capture = kcontrol->private_value & MIXART_VOL_REC_MASK;
 	int is_aes = kcontrol->private_value & MIXART_VOL_AES_MASK;
 	mutex_lock(&chip->mgr->mixer_mutex);
-	if(is_capture) {
-		if(is_aes)	stored_volume = chip->digital_capture_volume[1];	/* AES capture */
+	if (is_capture) {
+		if (is_aes)	stored_volume = chip->digital_capture_volume[1];	/* AES capture */
 		else		stored_volume = chip->digital_capture_volume[0];	/* analog capture */
 	} else {
 		snd_BUG_ON(idx >= MIXART_PLAYBACK_STREAMS);
-		if(is_aes)	stored_volume = chip->digital_playback_volume[MIXART_PLAYBACK_STREAMS + idx]; /* AES playback */
+		if (is_aes)	stored_volume = chip->digital_playback_volume[MIXART_PLAYBACK_STREAMS + idx]; /* AES playback */
 		else		stored_volume = chip->digital_playback_volume[idx];	/* analog playback */
 	}
 	ucontrol->value.integer.value[0] = stored_volume[0];
@@ -911,7 +911,7 @@ static int mixart_pcm_sw_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_
 	int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id); /* index */
 	snd_BUG_ON(idx >= MIXART_PLAYBACK_STREAMS);
 	mutex_lock(&chip->mgr->mixer_mutex);
-	if(kcontrol->private_value & MIXART_VOL_AES_MASK)	/* AES playback */
+	if (kcontrol->private_value & MIXART_VOL_AES_MASK)	/* AES playback */
 		idx += MIXART_PLAYBACK_STREAMS;
 	ucontrol->value.integer.value[0] = chip->digital_playback_active[idx][0];
 	ucontrol->value.integer.value[1] = chip->digital_playback_active[idx][1];
@@ -961,10 +961,10 @@ static int mixart_update_monitoring(struct snd_mixart* chip, int channel)
 	struct mixart_set_out_audio_level audio_level;
 	u32 resp;
 
-	if(chip->pipe_out_ana.status == PIPE_UNDEFINED)
+	if (chip->pipe_out_ana.status == PIPE_UNDEFINED)
 		return -EINVAL; /* no pipe defined */
 
-	if(!channel)	request.uid = chip->pipe_out_ana.uid_left_connector;
+	if (!channel)	request.uid = chip->pipe_out_ana.uid_left_connector;
 	else		request.uid = chip->pipe_out_ana.uid_right_connector;
 	request.message_id = MSG_CONNECTOR_SET_OUT_AUDIO_LEVEL;
 	request.data = &audio_level;
@@ -976,7 +976,7 @@ static int mixart_update_monitoring(struct snd_mixart* chip, int channel)
 	audio_level.monitor_mute1 = !chip->monitoring_active[channel!=0];
 
 	err = snd_mixart_send_msg(chip->mgr, &request, sizeof(resp), &resp);
-	if((err<0) || resp) {
+	if ((err<0) || resp) {
 		snd_printk(KERN_DEBUG "error MSG_CONNECTOR_SET_OUT_AUDIO_LEVEL card(%d) resp(%x)\n", chip->chip_idx, resp);
 		return -EINVAL;
 	}
@@ -1097,7 +1097,7 @@ static void mixart_reset_audio_levels(struct snd_mixart *chip)
 	/* analog volumes can be set even if there is no pipe */
 	mixart_update_analog_audio_level(chip, 0);
 	/* analog levels for capture only on the first two chips */
-	if(chip->chip_idx < 2) {
+	if (chip->chip_idx < 2) {
 		mixart_update_analog_audio_level(chip, 1);
 	}
 	return;
@@ -1111,7 +1111,7 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 
 	mutex_init(&mgr->mixer_mutex); /* can be in another place */
 
-	for(i=0; i<mgr->num_cards; i++) {
+	for (i = 0; i < mgr->num_cards; i++) {
 		struct snd_kcontrol_new temp;
 		chip = mgr->chip[i];
 
@@ -1126,7 +1126,7 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 			return err;
 
 		/* analog input level control only on first two chips !*/
-		if(i<2) {
+		if (i<2) {
 			temp = mixart_control_analog_level;
 			temp.name = "Master Capture Volume";
 			temp.private_value = 1; /* capture */
@@ -1147,7 +1147,7 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
 			return err;
 
-		if(mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
+		if (mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
 			temp.name = "AES Playback Volume";
 			temp.count = MIXART_PLAYBACK_STREAMS;
 			temp.private_value = MIXART_VOL_AES_MASK; /* playback AES/EBU */
@@ -1166,7 +1166,7 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
 			return err;
 
-		if(mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
+		if (mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
 			temp.name = "AES Playback Switch";
 			temp.private_value = MIXART_VOL_AES_MASK; /* playback AES/EBU */
 			if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
