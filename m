From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 3/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:46:06 -0500
Message-ID: <1108514766.3772.31.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-A2HA9rKdAqU0xbnrNRZZ"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-A2HA9rKdAqU0xbnrNRZZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Add the callbacks & configuration info to support the multichannel
device.  Fix some assumptions that channels per PCM is always 1 or 2 in
the existing callbacks.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-A2HA9rKdAqU0xbnrNRZZ
Content-Disposition: attachment; filename=emupcm.c.patch
Content-Type: text/x-patch; name=emupcm.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.38
diff -u -r1.38 emupcm.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/emupcm.c	14 Feb 2005 13:37:23 -0000	1.38
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/emupcm.c	15 Feb 2005 23:51:23 -0000
@@ -82,11 +82,28 @@
 	}
 #endif
 	snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
+}	 
+
+static snd_pcm_uframes_t snd_emu10k1_efx_playback_pointer(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm = runtime->private_data;
+	unsigned int ptr;
+
+	if (!epcm->running)
+		return 0;
+	ptr = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+	ptr += runtime->buffer_size;
+	ptr -= epcm->ccca_start_addr;
+	ptr %= runtime->buffer_size;
+
+	return ptr;
 }
 
 static int snd_emu10k1_pcm_channel_alloc(emu10k1_pcm_t * epcm, int voices)
 {
-	int err;
+	int err, i;
 
 	if (epcm->voices[1] != NULL && voices < 2) {
 		snd_emu10k1_voice_free(epcm->emu, epcm->voices[1]);
@@ -102,23 +119,31 @@
 			epcm->voices[0] = NULL;
 		}
 	}
-	err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, voices > 1, &epcm->voices[0]);
+	err = snd_emu10k1_voice_alloc(epcm->emu,
+				      epcm->type == PLAYBACK_EMUVOICE ? EMU10K1_PCM : EMU10K1_EFX,
+				      voices,
+				      &epcm->voices[0]);
+	
 	if (err < 0)
 		return err;
 	epcm->voices[0]->epcm = epcm;
 	if (voices > 1) {
-		epcm->voices[1] = &epcm->emu->voices[epcm->voices[0]->number + 1];
-		epcm->voices[1]->epcm = epcm;
+		for (i = 1; i < voices; i++) {
+			epcm->voices[i] = &epcm->emu->voices[epcm->voices[0]->number + i];
+			epcm->voices[i]->epcm = epcm;
+		}
 	}
 	if (epcm->extra == NULL) {
-		err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, 0, &epcm->extra);
+		err = snd_emu10k1_voice_alloc(epcm->emu,
+					      epcm->type == PLAYBACK_EMUVOICE ? EMU10K1_PCM : EMU10K1_EFX,
+					      1,
+					      &epcm->extra);
 		if (err < 0) {
 			// printk("pcm_channel_alloc: failed extra: voices=%d, frame=%d\n", voices, frame);
-			snd_emu10k1_voice_free(epcm->emu, epcm->voices[0]);
-			epcm->voices[0] = NULL;
-			if (epcm->voices[1])
-				snd_emu10k1_voice_free(epcm->emu, epcm->voices[1]);
-			epcm->voices[1] = NULL;
+			for (i = 0; i < voices; i++) {
+				snd_emu10k1_voice_free(epcm->emu, epcm->voices[i]);
+				epcm->voices[i] = NULL;
+			}
 			return err;
 		}
 		epcm->extra->epcm = epcm;
@@ -234,7 +259,7 @@
 {
 	snd_pcm_substream_t *substream = evoice->epcm->substream;
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[substream->number];
+	emu10k1_pcm_mixer_t *mix;
 	unsigned int silent_page, tmp;
 	int voice, stereo, w_16;
 	unsigned char attn, send_amount[8];
@@ -243,6 +268,11 @@
 	unsigned int pitch_target;
 
 	voice = evoice->number;
+	if (evoice->epcm->type == PLAYBACK_EFX) 
+		mix = &emu->efx_pcm_mixer[voice - evoice->epcm->voices[0]->number];
+	else
+		mix = &emu->pcm_mixer[substream->number];
+
 	stereo = runtime->channels == 2;
 	w_16 = snd_pcm_format_width(runtime->format) == 16;
 
@@ -273,10 +303,11 @@
 		memcpy(send_amount, &mix->send_volume[tmp][0], 8);
 	}
 
+	unsigned int ccis = stereo ? 28 : 30;
+	if (w_16)
+		ccis *= 2;
+	
 	if (master) {
-		unsigned int ccis = stereo ? 28 : 30;
-		if (w_16)
-			ccis *= 2;
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
 		if (extra) {
 			start_addr += ccis;
@@ -310,7 +341,12 @@
 	snd_emu10k1_ptr_write(emu, DSL, voice, end_addr | (send_amount[3] << 24));
 	snd_emu10k1_ptr_write(emu, PSST, voice, start_addr | (send_amount[2] << 24));
 	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
-	snd_emu10k1_ptr_write(emu, CCCA, voice, evoice->epcm->ccca_start_addr |
+	if (extra)
+		snd_emu10k1_ptr_write(emu, CCCA, voice, start_addr |
+			      emu10k1_select_interprom(pitch_target) |
+			      (w_16 ? 0 : CCCA_8BITSELECT));
+	else
+		snd_emu10k1_ptr_write(emu, CCCA, voice, (start_addr + ccis) |
 			      emu10k1_select_interprom(pitch_target) |
 			      (w_16 ? 0 : CCCA_8BITSELECT));
 	// Clear filter delay memory
@@ -398,6 +434,35 @@
 	return 0;
 }
 
+static int snd_emu10k1_efx_playback_hw_free(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm;
+	int i;
+
+	if (runtime->private_data == NULL)
+		return 0;
+	epcm = runtime->private_data;
+	if (epcm->extra) {
+		snd_emu10k1_voice_free(epcm->emu, epcm->extra);
+		epcm->extra = NULL;
+	}
+	for (i=0; i < NUM_EFX_PLAYBACK; i++) {
+		if (epcm->voices[i]) {
+			snd_emu10k1_voice_free(epcm->emu, epcm->voices[i]);
+			epcm->voices[i] = NULL;
+		}
+	}
+	if (epcm->memblk) {
+		snd_emu10k1_free_pages(emu, epcm->memblk);
+		epcm->memblk = NULL;
+		epcm->start_addr = 0;
+	}
+	snd_pcm_lib_free_pages(substream);
+	return 0;
+}
+
 static int snd_emu10k1_playback_prepare(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -421,6 +486,59 @@
 	return 0;
 }
 
+static int snd_emu10k1_efx_playback_prepare(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm = runtime->private_data;
+	unsigned int start_addr, end_addr;
+
+	start_addr = epcm->start_addr;
+	end_addr = epcm->start_addr + snd_pcm_lib_buffer_bytes(substream);
+
+	/*
+	 * the kX driver leaves some space between voices
+	 */
+	unsigned int channel_size;
+	int i;
+	channel_size = ( end_addr - start_addr ) / NUM_EFX_PLAYBACK;
+
+	snd_emu10k1_pcm_init_voice(emu, 1, 1, epcm->extra,
+				   start_addr, start_addr + (channel_size / 2));
+
+	/* only difference with the master voice is we use it for the pointer */
+	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
+				   start_addr, start_addr + channel_size);
+
+	start_addr += channel_size;
+	for (i = 1; i < NUM_EFX_PLAYBACK; i++) {
+		snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[i],
+					   start_addr, start_addr+channel_size);
+		start_addr += channel_size;
+	}
+
+	return 0;
+}
+
+static snd_pcm_hardware_t snd_emu10k1_efx_playback =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_NONINTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		NUM_EFX_PLAYBACK,
+	.channels_max =		NUM_EFX_PLAYBACK,
+	.buffer_bytes_max =	(64*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(64*1024),
+	.periods_min =		2,
+	.periods_max =		2,
+	.fifo_size =		0,
+};
+
 static int snd_emu10k1_capture_hw_params(snd_pcm_substream_t * substream,
 					 snd_pcm_hw_params_t * hw_params)
 {
@@ -439,6 +557,7 @@
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int idx;
 
+	/* zeroing the buffer size will stop capture */
 	snd_emu10k1_ptr_write(emu, epcm->capture_bs_reg, 0, 0);
 	switch (epcm->type) {
 	case CAPTURE_AC97ADC:
@@ -488,7 +607,7 @@
 	runtime = evoice->epcm->substream->runtime;
 	voice = evoice->number;
 	sample = snd_pcm_format_width(runtime->format) == 16 ? 0 : 0x80808080;
-	if (runtime->channels > 1) {
+	if (runtime->channels == 2) {
 		ccis = 28;
 		cs = 4;
 	} else {
@@ -499,10 +618,11 @@
 		ccis *= 2;
 	for (i = 0; i < cs; i++)
 		snd_emu10k1_ptr_write(emu, CD0 + i, voice, sample);
+		
 	// reset cache
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, 0);
 	snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice, cra);
-	if (runtime->channels > 1) {
+	if (runtime->channels == 2) {
 		snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice + 1, 0);
 		snd_emu10k1_ptr_write(emu, CCR_READADDRESS, voice + 1, cra);
 	}
@@ -523,7 +643,10 @@
 	substream = evoice->epcm->substream;
 	runtime = substream->runtime;
 	voice = evoice->number;
-	mix = &emu->pcm_mixer[substream->number];
+
+	mix = evoice->epcm->type == PLAYBACK_EFX
+		? &emu->efx_pcm_mixer[voice - evoice->epcm->voices[0]->number]
+		: &emu->pcm_mixer[substream->number];
 
 	attn = extra ? 0 : 0x00ff;
 	tmp = runtime->channels == 2 ? (master ? 1 : 2) : 0;
@@ -549,7 +672,7 @@
 	pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
 	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
 	snd_emu10k1_ptr_write(emu, PTRX_PITCHTARGET, voice, pitch_target);
-	if (master)
+	if (master || evoice->epcm->type == PLAYBACK_EFX)
 		snd_emu10k1_ptr_write(emu, CPF_CURRENTPITCH, voice, pitch_target);
 	snd_emu10k1_ptr_write(emu, IP, voice, pitch);
 	if (extra)
@@ -579,7 +702,6 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int result = 0;
-
 	// printk("trigger - emu10k1 = 0x%x, cmd = %i, pointer = %i\n", (int)emu, cmd, substream->ops->pointer(substream));
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
@@ -619,10 +741,10 @@
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int result = 0;
 
-	// printk("trigger - emu10k1 = %p, cmd = %i, pointer = %i\n", emu, cmd, substream->ops->pointer(substream));
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		// hmm this should cause full and half full interrupt to be raised?  
 		outl(epcm->capture_ipr, emu->port + IPR);
 		snd_emu10k1_intr_enable(emu, epcm->capture_inte);
 		// printk("adccr = 0x%x, adcbs = 0x%x\n", epcm->adccr, epcm->adcbs);
@@ -698,6 +820,56 @@
 	return ptr;
 }
 
+
+static int snd_emu10k1_efx_playback_trigger(snd_pcm_substream_t * substream,
+				        int cmd)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm = runtime->private_data;
+	int i = 0;
+	int result = 0;
+
+	spin_lock(&emu->reg_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		// prepare voices
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+			snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i]);
+		}
+		snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);
+
+		/* follow thru */
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 0, 0);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1);
+		for (i = 1; i < NUM_EFX_PLAYBACK; i++) {	
+			snd_emu10k1_playback_prepare_voice(emu, epcm->voices[i], 0, 0);
+		}
+		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[0], 0, 0);
+		snd_emu10k1_playback_trigger_voice(emu, epcm->extra, 1, 1);
+		for (i = 1; i < NUM_EFX_PLAYBACK; i++) {	
+			snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 0, 0);
+		}
+		epcm->running = 1;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		epcm->running = 0;
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+			snd_emu10k1_playback_stop_voice(emu, epcm->voices[i]);
+		}
+		snd_emu10k1_playback_stop_voice(emu, epcm->extra);
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+	spin_unlock(&emu->reg_lock);
+	return result;
+}
+
+
 static snd_pcm_uframes_t snd_emu10k1_capture_pointer(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -786,6 +958,13 @@
 	snd_emu10k1_pcm_mixer_notify1(emu, emu->ctl_attn, idx, activate);
 }
 
+static void snd_emu10k1_pcm_efx_mixer_notify(emu10k1_t *emu, int idx, int activate)
+{
+	snd_emu10k1_pcm_mixer_notify1(emu, emu->ctl_efx_send_routing, idx, activate);
+	snd_emu10k1_pcm_mixer_notify1(emu, emu->ctl_efx_send_volume, idx, activate);
+	snd_emu10k1_pcm_mixer_notify1(emu, emu->ctl_efx_attn, idx, activate);
+}
+
 static void snd_emu10k1_pcm_free_substream(snd_pcm_runtime_t *runtime)
 {
 	emu10k1_pcm_t *epcm = runtime->private_data;
@@ -793,6 +972,53 @@
 	kfree(epcm);
 }
 
+static int snd_emu10k1_efx_playback_close(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	emu10k1_pcm_mixer_t *mix;
+	int i;
+
+	for (i=0; i < NUM_EFX_PLAYBACK; i++) {
+		mix = &emu->efx_pcm_mixer[i];
+		mix->epcm = NULL;
+		snd_emu10k1_pcm_efx_mixer_notify(emu, i, 0);
+	}
+	return 0;
+}
+
+static int snd_emu10k1_efx_playback_open(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	emu10k1_pcm_t *epcm;
+	emu10k1_pcm_mixer_t *mix;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	int i;
+
+	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	if (epcm == NULL)
+		return -ENOMEM;
+	epcm->emu = emu;
+	epcm->type = PLAYBACK_EFX;
+	epcm->substream = substream;
+	
+	emu->pcm_playback_efx_substream = substream;
+
+	runtime->private_data = epcm;
+	runtime->private_free = snd_emu10k1_pcm_free_substream;
+	runtime->hw = snd_emu10k1_efx_playback;
+	
+	for (i=0; i < NUM_EFX_PLAYBACK; i++) {
+		mix = &emu->efx_pcm_mixer[i];
+		mix->send_routing[0][0] = i;
+		memset(&mix->send_volume, 0, sizeof(mix->send_volume));
+		mix->send_volume[0][0] = 255;
+		mix->attn[0] = 0xffff;
+		mix->epcm = epcm;
+		snd_emu10k1_pcm_efx_mixer_notify(emu, i, 1);
+	}
+	return 0;
+}
+
 static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -987,6 +1213,19 @@
 	.pointer =		snd_emu10k1_capture_pointer,
 };
 
+/* EFX playback */
+static snd_pcm_ops_t snd_emu10k1_efx_playback_ops = {
+	.open =			snd_emu10k1_efx_playback_open,
+	.close =		snd_emu10k1_efx_playback_close,
+	.ioctl =		snd_pcm_lib_ioctl,
+	.hw_params =		snd_emu10k1_playback_hw_params,
+	.hw_free =		snd_emu10k1_efx_playback_hw_free,
+	.prepare =		snd_emu10k1_efx_playback_prepare,
+	.trigger =		snd_emu10k1_efx_playback_trigger,
+	.pointer =		snd_emu10k1_efx_playback_pointer,
+	.page =			snd_pcm_sgbuf_ops_page,
+};
+
 static void snd_emu10k1_pcm_free(snd_pcm_t *pcm)
 {
 	emu10k1_t *emu = pcm->private_data;
@@ -1030,6 +1269,39 @@
 	return 0;
 }
 
+int __devinit snd_emu10k1_pcm_multi(emu10k1_t * emu, int device, snd_pcm_t ** rpcm)
+{
+	snd_pcm_t *pcm;
+	snd_pcm_substream_t *substream;
+	int err;
+
+	if (rpcm)
+		*rpcm = NULL;
+
+	if ((err = snd_pcm_new(emu->card, "emu10k1", device, 1, 0, &pcm)) < 0)
+		return err;
+
+	pcm->private_data = emu;
+	pcm->private_free = snd_emu10k1_pcm_free;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1_efx_playback_ops);
+
+	pcm->info_flags = 0;
+	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
+	strcpy(pcm->name, "EMU10K1 multichannel EFX");
+	emu->pcm = pcm;
+
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; substream; substream = substream->next)
+		if ((err = snd_pcm_lib_preallocate_pages(substream, SNDRV_DMA_TYPE_DEV_SG, snd_dma_pci_data(emu->pci), 64*1024, 64*1024)) < 0)
+			return err;
+
+	if (rpcm)
+		*rpcm = pcm;
+
+	return 0;
+}
+
+
 static snd_pcm_ops_t snd_emu10k1_capture_mic_ops = {
 	.open =			snd_emu10k1_capture_mic_open,
 	.close =		snd_emu10k1_capture_mic_close,

--=-A2HA9rKdAqU0xbnrNRZZ--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
