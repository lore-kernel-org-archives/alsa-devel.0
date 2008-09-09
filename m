From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 17/24] sound/pci: coding style fixes: pcxhr
Date: Tue, 9 Sep 2008 05:59:07 +0400
Message-ID: <20080909015907.GT6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 2648B103812
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:59:12 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1537010fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:59:12 -0700 (PDT)
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

 sound/pci/pcxhr/pcxhr.c       |   44 ++++++++++++++++++++--------------------
 sound/pci/pcxhr/pcxhr_core.c  |   22 ++++++++++----------
 sound/pci/pcxhr/pcxhr_hwdep.c |   16 +++++++-------
 sound/pci/pcxhr/pcxhr_mixer.c |   16 +++++++-------
 4 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index 0e06c6c..bebf866 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -197,7 +197,7 @@ static int pcxhr_get_clock_reg(struct pcxhr_mgr *mgr, unsigned int rate,
 			if (err < 0) {
 				snd_printk(KERN_ERR
 					   "error CMD_ACCESS_IO_WRITE for PLL register : %x!\n",
-					   err );
+					   err);
 				return err;
 			}
 		}
@@ -603,12 +603,12 @@ static void pcxhr_trigger_tasklet(unsigned long arg)
 
 	/* put the streams into the running state now (increment pointer by interrupt) */
 	spin_lock_irqsave(&mgr->lock, flags);
-	for ( i =0; i < mgr->num_cards; i++) {
+	for (i =0; i < mgr->num_cards; i++) {
 		struct pcxhr_stream *stream;
 		chip = mgr->chip[i];
-		for(j = 0; j < chip->nb_streams_capt; j++) {
+		for (j = 0; j < chip->nb_streams_capt; j++) {
 			stream = &chip->capture_stream[j];
-			if(stream->status == PCXHR_STREAM_STATUS_STARTED)
+			if (stream->status == PCXHR_STREAM_STATUS_STARTED)
 				stream->status = PCXHR_STREAM_STATUS_RUNNING;
 		}
 		for (j = 0; j < chip->nb_streams_play; j++) {
@@ -723,7 +723,7 @@ static int pcxhr_prepare(struct snd_pcm_substream *subs)
 		    subs->runtime->buffer_size);
 
 	/*
-	if(subs->runtime->period_size <= PCXHR_GRANULARITY) {
+	if (subs->runtime->period_size <= PCXHR_GRANULARITY) {
 		snd_printk(KERN_ERR "pcxhr_prepare : error period_size too small (%x)\n",
 			   (unsigned int)subs->runtime->period_size);
 		return -EINVAL;
@@ -735,11 +735,11 @@ static int pcxhr_prepare(struct snd_pcm_substream *subs)
 	do {
 		/* if the stream was stopped before, format and buffer were reset */
 		/*
-		if(stream->status == PCXHR_STREAM_STATUS_STOPPED) {
+		if (stream->status == PCXHR_STREAM_STATUS_STOPPED) {
 			err = pcxhr_set_format(stream);
-			if(err) break;
+			if (err) break;
 			err = pcxhr_update_r_buffer(stream);
-			if(err) break;
+			if (err) break;
 		}
 		*/
 
@@ -790,7 +790,7 @@ static int pcxhr_hw_params(struct snd_pcm_substream *subs,
 	/* set the format to the board */
 	/*
 	err = pcxhr_set_format(stream);
-	if(err) {
+	if (err) {
 		mutex_unlock(&mgr->setup_mutex);
 		return err;
 	}
@@ -853,7 +853,7 @@ static int pcxhr_open(struct snd_pcm_substream *subs)
 	/* copy the struct snd_pcm_hardware struct */
 	runtime->hw = pcxhr_caps;
 
-	if( subs->stream == SNDRV_PCM_STREAM_PLAYBACK ) {
+	if (subs->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		snd_printdd("pcxhr_open playback chip%d subs%d\n",
 			    chip->chip_idx, subs->number);
 		stream = &chip->playback_stream[subs->number];
@@ -1025,7 +1025,7 @@ static int __devinit pcxhr_create(struct pcxhr_mgr *mgr, struct snd_card *card,
 	};
 
 	mgr->chip[idx] = chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (! chip) {
+	if (!chip) {
 		snd_printk(KERN_ERR "cannot allocate chip\n");
 		return -ENOMEM;
 	}
@@ -1078,7 +1078,7 @@ static void pcxhr_proc_info(struct snd_info_entry *entry, struct snd_info_buffer
 
 		/* calc cpu load of the dsp */
 		pcxhr_init_rmh(&rmh, CMD_GET_DSP_RESOURCES);
-		if( ! pcxhr_send_msg(mgr, &rmh) ) {
+		if (!pcxhr_send_msg(mgr, &rmh)) {
 			int cur = rmh.stat[0];
 			int ref = rmh.stat[1];
 			if (ref > 0) {
@@ -1108,7 +1108,7 @@ static void pcxhr_proc_info(struct snd_info_entry *entry, struct snd_info_buffer
 		rmh.stat_len = PCXHR_SIZE_MAX_STATUS;
 		rmh.dsp_stat = 0;
 		rmh.cmd_idx = CMD_LAST_INDEX;
-		if( ! pcxhr_send_msg(mgr, &rmh) ) {
+		if (!pcxhr_send_msg(mgr, &rmh)) {
 			int i;
 			for (i = 0; i < rmh.stat_len; i++)
 				snd_iprintf(buffer, "debug[%02d] = %06x\n", i,  rmh.stat[i]);
@@ -1147,9 +1147,9 @@ static void __devinit pcxhr_proc_init(struct snd_pcxhr *chip)
 {
 	struct snd_info_entry *entry;
 
-	if (! snd_card_proc_new(chip->card, "info", &entry))
+	if (!snd_card_proc_new(chip->card, "info", &entry))
 		snd_info_set_text_ops(entry, chip, pcxhr_proc_info);
-	if (! snd_card_proc_new(chip->card, "sync", &entry))
+	if (!snd_card_proc_new(chip->card, "sync", &entry))
 		snd_info_set_text_ops(entry, chip, pcxhr_proc_sync);
 }
 /* end of proc interface */
@@ -1167,7 +1167,7 @@ static int pcxhr_free(struct pcxhr_mgr *mgr)
 	}
 
 	/* reset board if some firmware was loaded */
-	if(mgr->dsp_loaded) {
+	if (mgr->dsp_loaded) {
 		pcxhr_reset_board(mgr);
 		snd_printdd("reset pcxhr !\n");
 	}
@@ -1205,7 +1205,7 @@ static int __devinit pcxhr_probe(struct pci_dev *pci, const struct pci_device_id
 
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
-	if (! enable[dev]) {
+	if (!enable[dev]) {
 		dev++;
 		return -ENOENT;
 	}
@@ -1224,7 +1224,7 @@ static int __devinit pcxhr_probe(struct pci_dev *pci, const struct pci_device_id
 
 	/* alloc card manager */
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
-	if (! mgr) {
+	if (!mgr) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
@@ -1271,15 +1271,15 @@ static int __devinit pcxhr_probe(struct pci_dev *pci, const struct pci_device_id
 	/* init taslket */
 	tasklet_init(&mgr->msg_taskq, pcxhr_msg_tasklet, (unsigned long) mgr);
 	tasklet_init(&mgr->trigger_taskq, pcxhr_trigger_tasklet, (unsigned long) mgr);
-	mgr->prmh = kmalloc(sizeof(*mgr->prmh) + 
+	mgr->prmh = kmalloc(sizeof(*mgr->prmh) +
 			    sizeof(u32) * (PCXHR_SIZE_MAX_LONG_STATUS - PCXHR_SIZE_MAX_STATUS),
 			    GFP_KERNEL);
-	if (! mgr->prmh) {
+	if (!mgr->prmh) {
 		pcxhr_free(mgr);
 		return -ENOMEM;
 	}
 
-	for (i=0; i < PCXHR_MAX_CARDS; i++) {
+	for (i = 0; i < PCXHR_MAX_CARDS; i++) {
 		struct snd_card *card;
 		char tmpid[16];
 		int idx;
@@ -1296,7 +1296,7 @@ static int __devinit pcxhr_probe(struct pci_dev *pci, const struct pci_device_id
 		snprintf(tmpid, sizeof(tmpid), "%s-%d", id[dev] ? id[dev] : card_name, i);
 		card = snd_card_new(idx, tmpid, THIS_MODULE, 0);
 
-		if (! card) {
+		if (!card) {
 			snd_printk(KERN_ERR "cannot allocate the card %d\n", i);
 			pcxhr_free(mgr);
 			return -ENOMEM;
diff --git a/sound/pci/pcxhr/pcxhr_core.c b/sound/pci/pcxhr/pcxhr_core.c
index 7143259..16575f4 100644
--- a/sound/pci/pcxhr/pcxhr_core.c
+++ b/sound/pci/pcxhr/pcxhr_core.c
@@ -23,7 +23,7 @@
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include "pcxhr.h"
 #include "pcxhr_mixer.h"
@@ -246,9 +246,9 @@ void pcxhr_reset_dsp(struct pcxhr_mgr *mgr)
 
 	/* let's reset the DSP */
 	PCXHR_OUTPB(mgr, PCXHR_DSP_RESET, 0);
-	msleep( PCXHR_WAIT_DEFAULT ); /* wait 2 msec */
+	msleep(PCXHR_WAIT_DEFAULT); /* wait 2 msec */
 	PCXHR_OUTPB(mgr, PCXHR_DSP_RESET, 3);
-	msleep( PCXHR_WAIT_DEFAULT ); /* wait 2 msec */
+	msleep(PCXHR_WAIT_DEFAULT); /* wait 2 msec */
 
 	/* reset mailbox */
 	PCXHR_OUTPL(mgr, PCXHR_PLX_MBOX0, 0);
@@ -275,7 +275,7 @@ int pcxhr_load_xilinx_binary(struct pcxhr_mgr *mgr, const struct firmware *xilin
 	chipsc = PCXHR_INPL(mgr, PCXHR_PLX_CHIPSC);
 	/* REV01 cards do not support the PCXHR_CHIPSC_GPI_USERI bit anymore */
 	/* this bit will always be 1; no possibility to test presence of first xilinx */
-	if(second) {
+	if (second) {
 		if ((chipsc & PCXHR_CHIPSC_GPI_USERI) == 0) {
 			snd_printk(KERN_ERR "error loading first xilinx\n");
 			return -EINVAL;
@@ -283,7 +283,7 @@ int pcxhr_load_xilinx_binary(struct pcxhr_mgr *mgr, const struct firmware *xilin
 		/* activate second xilinx */
 		chipsc |= PCXHR_CHIPSC_RESET_XILINX;
 		PCXHR_OUTPL(mgr, PCXHR_PLX_CHIPSC, chipsc);
-		msleep( PCXHR_WAIT_DEFAULT ); /* wait 2 msec */
+		msleep(PCXHR_WAIT_DEFAULT); /* wait 2 msec */
 	}
 	image = xilinx->data;
 	for (i = 0; i < xilinx->size; i++, image++) {
@@ -304,7 +304,7 @@ int pcxhr_load_xilinx_binary(struct pcxhr_mgr *mgr, const struct firmware *xilin
 	chipsc &= ~(PCXHR_CHIPSC_DATA_CLK | PCXHR_CHIPSC_DATA_IN);
 	PCXHR_OUTPL(mgr, PCXHR_PLX_CHIPSC, chipsc);
 	/* wait 2 msec (time to boot the xilinx before any access) */
-	msleep( PCXHR_WAIT_DEFAULT );
+	msleep(PCXHR_WAIT_DEFAULT);
 	return 0;
 }
 
@@ -627,7 +627,7 @@ static int pcxhr_send_msg_nolock(struct pcxhr_mgr *mgr, struct pcxhr_rmh *rmh)
 		PCXHR_OUTPB(mgr, PCXHR_DSP_TXM, (data>>8)&0xFF);
 		PCXHR_OUTPB(mgr, PCXHR_DSP_TXL, (data&0xFF));
 
-		for (i=1; i < rmh->cmd_len; i++) {
+		for (i = 1; i < rmh->cmd_len; i++) {
 			/* send other words */
 			data = rmh->cmd[i];
 #ifdef CONFIG_SND_DEBUG_VERBOSE
@@ -706,7 +706,7 @@ void pcxhr_set_pipe_cmd_params(struct pcxhr_rmh *rmh, int capture,
 		snd_BUG_ON(param2 > MASK_FIRST_FIELD);
 		rmh->cmd[0] |= param2;
 	}
-	if(param3) {
+	if (param3) {
 		snd_BUG_ON(param3 > MASK_DSP_WORD);
 		rmh->cmd[1] = param3;
 		rmh->cmd_len = 2;
@@ -841,7 +841,7 @@ static int pcxhr_toggle_pipes(struct pcxhr_mgr *mgr, int audio_mask)
 	pcxhr_init_rmh(&rmh, CMD_SEND_IRQA);
 	err = pcxhr_send_msg(mgr, &rmh);
 	if (err) {
-		snd_printk(KERN_ERR "error pipe start (CMD_SEND_IRQA) err=%x!\n", err );
+		snd_printk(KERN_ERR "error pipe start (CMD_SEND_IRQA) err=%x!\n", err);
 		return err;
 	}
 	return 0;
@@ -1154,7 +1154,7 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 	spin_lock(&mgr->lock);
 
 	reg = PCXHR_INPL(mgr, PCXHR_PLX_IRQCS);
-	if (! (reg & PCXHR_IRQCS_ACTIVE_PCIDB)) {
+	if (!(reg & PCXHR_IRQCS_ACTIVE_PCIDB)) {
 		spin_unlock(&mgr->lock);
 		return IRQ_NONE;	/* this device did not cause the interrupt */
 	}
@@ -1211,7 +1211,7 @@ irqreturn_t pcxhr_interrupt(int irq, void *dev_id)
 		 */
 		/* better resynchronize all streams next interrupt : */
 		mgr->dsp_time_last = PCXHR_DSP_TIME_INVALID;
-		
+
 		mgr->src_it_dsp = reg;
 		tasklet_hi_schedule(&mgr->msg_taskq);
 	}
diff --git a/sound/pci/pcxhr/pcxhr_hwdep.c b/sound/pci/pcxhr/pcxhr_hwdep.c
index 96640d9..9d04175 100644
--- a/sound/pci/pcxhr/pcxhr_hwdep.c
+++ b/sound/pci/pcxhr/pcxhr_hwdep.c
@@ -24,7 +24,7 @@
 #include <linux/vmalloc.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include "pcxhr.h"
@@ -104,7 +104,7 @@ static int pcxhr_init_board(struct pcxhr_mgr *mgr)
 		mgr->board_has_analog = 1;	/* analog addon board available */
 	else
 		/* analog addon board not available -> no support for instance */
-		return -EINVAL;	
+		return -EINVAL;
 
 	/* unmute inputs */
 	err = pcxhr_write_io_num_reg_cont(mgr, REG_CONT_UNMUTE_INPUTS,
@@ -144,7 +144,7 @@ void pcxhr_reset_board(struct pcxhr_mgr *mgr)
 /*
  *  allocate a playback/capture pipe (pcmp0/pcmc0)
  */
-static int pcxhr_dsp_allocate_pipe( struct pcxhr_mgr *mgr, struct pcxhr_pipe *pipe,
+static int pcxhr_dsp_allocate_pipe(struct pcxhr_mgr *mgr, struct pcxhr_pipe *pipe,
 				    int is_capture, int pin)
 {
 	int stream_count, audio_count;
@@ -166,10 +166,10 @@ static int pcxhr_dsp_allocate_pipe( struct pcxhr_mgr *mgr, struct pcxhr_pipe *pi
 	pipe->first_audio = pin;
 	/* define pipe (P_PCM_ONLY_MASK (0x020000) is not necessary) */
 	pcxhr_init_rmh(&rmh, CMD_RES_PIPE);
-	pcxhr_set_pipe_cmd_params(&rmh, is_capture, pin, audio_count, stream_count); 
+	pcxhr_set_pipe_cmd_params(&rmh, is_capture, pin, audio_count, stream_count);
 	err = pcxhr_send_msg(mgr, &rmh);
 	if (err < 0) {
-		snd_printk(KERN_ERR "error pipe allocation (CMD_RES_PIPE) err=%x!\n", err );
+		snd_printk(KERN_ERR "error pipe allocation (CMD_RES_PIPE) err=%x!\n", err);
 		return err;
 	}
 	pipe->status = PCXHR_PIPE_DEFINED;
@@ -181,7 +181,7 @@ static int pcxhr_dsp_allocate_pipe( struct pcxhr_mgr *mgr, struct pcxhr_pipe *pi
  *  free playback/capture pipe (pcmp0/pcmc0)
  */
 #if 0
-static int pcxhr_dsp_free_pipe( struct pcxhr_mgr *mgr, struct pcxhr_pipe *pipe)
+static int pcxhr_dsp_free_pipe(struct pcxhr_mgr *mgr, struct pcxhr_pipe *pipe)
 {
 	struct pcxhr_rmh rmh;
 	int capture_mask = 0;
@@ -223,7 +223,7 @@ static int pcxhr_config_pipes(struct pcxhr_mgr *mgr)
 			err = pcxhr_dsp_allocate_pipe( mgr, pipe, 0, i*2);
 			if (err)
 				return err;
-			for(j = 0; j < chip->nb_streams_play; j++)
+			for (j = 0; j < chip->nb_streams_play; j++)
 				chip->playback_stream[j].pipe = pipe;
 		}
 		for (j = 0; j < chip->nb_streams_capt; j++) {
@@ -392,7 +392,7 @@ static int pcxhr_hwdep_dsp_load(struct snd_hwdep *hw,
 
 	fw.size = dsp->length;
 	fw.data = vmalloc(fw.size);
-	if (! fw.data) {
+	if (!fw.data) {
 		snd_printk(KERN_ERR "pcxhr: cannot allocate dsp image (%lu bytes)\n",
 			   (unsigned long)fw.size);
 		return -ENOMEM;
diff --git a/sound/pci/pcxhr/pcxhr_mixer.c b/sound/pci/pcxhr/pcxhr_mixer.c
index aabc7bc..fd7e60c 100644
--- a/sound/pci/pcxhr/pcxhr_mixer.c
+++ b/sound/pci/pcxhr/pcxhr_mixer.c
@@ -173,7 +173,7 @@ static int pcxhr_audio_sw_put(struct snd_kcontrol *kcontrol,
 	struct snd_pcxhr *chip = snd_kcontrol_chip(kcontrol);
 	int i, changed = 0;
 	mutex_lock(&chip->mgr->mixer_mutex);
-	for(i = 0; i < 2; i++) {
+	for (i = 0; i < 2; i++) {
 		if (chip->analog_playback_active[i] !=
 		    ucontrol->value.integer.value[i]) {
 			chip->analog_playback_active[i] =
@@ -284,7 +284,7 @@ static int pcxhr_update_audio_pipe_level(struct snd_pcxhr* chip, int capture, in
 	rmh.cmd_len = 3;
 
 	err = pcxhr_send_msg(chip->mgr, &rmh);
-	if(err<0) {
+	if (err<0) {
 		snd_printk(KERN_DEBUG "error update_audio_level card(%d) err(%x)\n",
 			   chip->chip_idx, err);
 		return -EINVAL;
@@ -445,7 +445,7 @@ static int pcxhr_monitor_vol_put(struct snd_kcontrol *kcontrol,
 		    ucontrol->value.integer.value[i]) {
 			chip->monitoring_volume[i] =
 				!!ucontrol->value.integer.value[i];
-			if(chip->monitoring_active[i])
+			if (chip->monitoring_active[i])
 				/* update monitoring volume and mute */
 				/* do only when monitoring is unmuted */
 				pcxhr_update_audio_pipe_level(chip, 0, i);
@@ -566,7 +566,7 @@ static int pcxhr_set_audio_source(struct snd_pcxhr* chip)
 	rmh.cmd[1] = codec;
 	rmh.cmd[2] = (CS8420_DATA_FLOW_CTL & CHIP_SIG_AND_MAP_SPI) | (use_src ? 0x41 : 0x54);
 	err = pcxhr_send_msg(chip->mgr, &rmh);
-	if(err)
+	if (err)
 		return err;
 	rmh.cmd[2] = (CS8420_CLOCK_SRC_CTL & CHIP_SIG_AND_MAP_SPI) | (use_src ? 0x41 : 0x49);
 	err = pcxhr_send_msg(chip->mgr, &rmh);
@@ -722,7 +722,7 @@ static int pcxhr_clock_rate_get(struct snd_kcontrol *kcontrol,
 	int i, err, rate;
 
 	mutex_lock(&mgr->mixer_mutex);
-	for(i = 0; i < 3 + mgr->capture_chips; i++) {
+	for (i = 0; i < 3 + mgr->capture_chips; i++) {
 		if (i == PCXHR_CLOCK_TYPE_INTERNAL)
 			rate = mgr->sample_rate_real;
 		else {
@@ -802,7 +802,7 @@ static int pcxhr_iec958_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_v
 	int i, err;
 
 	mutex_lock(&chip->mgr->mixer_mutex);
-	for(i = 0; i < 5; i++) {
+	for (i = 0; i < 5; i++) {
 		if (kcontrol->private_value == 0)	/* playback */
 			aes_bits = chip->aes_bits[i];
 		else {				/* capture */
@@ -835,7 +835,7 @@ static int pcxhr_iec958_update_byte(struct snd_pcxhr *chip, int aes_idx, unsigne
 	for (i = 0; i < 8; i++) {
 		if ((old_bits & 0x01) != (new_bits & 0x01)) {
 			cmd = chip->chip_idx & 0x03;		/* chip index 0..3 */
-			if(chip->chip_idx > 3)
+			if (chip->chip_idx > 3)
 				/* new bit used if chip_idx>3 (PCX1222HR) */
 				cmd |= 1 << 22;
 			cmd |= ((aes_idx << 3) + i) << 2;	/* add bit offset */
@@ -971,7 +971,7 @@ int pcxhr_create_mixer(struct pcxhr_mgr *mgr)
 					       snd_ctl_new1(&pcxhr_control_output_switch,
 							    chip))) < 0)
 				return err;
-			
+
 			temp = snd_pcxhr_pcm_vol;
 			temp.name = "PCM Playback Volume";
 			temp.count = PCXHR_PLAYBACK_STREAMS;
