From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1 multichannel PCM - still not quite working
Date: Fri, 08 Oct 2004 16:32:06 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1097267526.1442.47.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-EBskVk+RPkpWuuyxWvsi"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--=-EBskVk+RPkpWuuyxWvsi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is my first attempt at adding multichannel PCM playback support to
the emu10k1.  It does not quite seem to work and I am not sure why. 
This has 16 non-interleaved channels.  Since the playback interrupt is
driven by the capture, we call snd_pcm_period_elapsed in the efx capture
interrupt handler.  Since playback and capture are synced, first 16
channels must be enabled for recording using the EFX voices mask
control.

I start JACK like so:

 jackd -v -R -d alsa -C hw:0,2 -P hw:0,3 -S -p 32

and it correctly opens 16 playback and 16 capture channels.  However,
the pointer callback and the interrupt handler only get called once; the
jackd watchdog thread kills jackd eventually.  Looks like only the first
period is handled, then it hangs.  I added some printks:

Oct  6 14:54:23 krustophenia kernel: in snd_emu10k1_efx_playback_prepare - start_addr 0x1000 end_addr 0x1800
Oct  6 14:54:23 krustophenia kernel: init voice - master 1 extra 0 start_addr 0x800 end_addr 0x840
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x840 end_addr 0x880
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x880 end_addr 0x8c0
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x8c0 end_addr 0x900
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x900 end_addr 0x940
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x940 end_addr 0x980
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x980 end_addr 0x9c0
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0x9c0 end_addr 0xa00
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xa00 end_addr 0xa40
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xa40 end_addr 0xa80
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xa80 end_addr 0xac0
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xac0 end_addr 0xb00
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xb00 end_addr 0xb40
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xb40 end_addr 0xb80
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xb80 end_addr 0xbc0
Oct  6 14:54:23 krustophenia kernel: init voice - master 0 extra 0 start_addr 0xbc0 end_addr 0xc00
Oct  6 14:54:23 krustophenia kernel: ptr = 0x83c, ccca_start_addr = 0x83c
Oct  6 14:54:23 krustophenia kernel: ptr = 0x0, buffer_size = 0x40, period_size = 0x20
Oct  6 14:54:23 krustophenia kernel: in capture efx irq handler, updating playback stream

The first "ptr" is the one read from the hardware in the pointer
callback, the second is the pointer we return.

The patch is attached.  It is definitely incomplete but AFAICS it should
work at this point.

Lee 

--=-EBskVk+RPkpWuuyxWvsi
Content-Disposition: attachment; filename=emu10k1-multichannel-pcm.patch
Content-Type: text/x-patch; name=emu10k1-multichannel-pcm.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.46
diff -u -r1.46 emu10k1.h
--- alsa-kernel/include/emu10k1.h	6 Sep 2004 15:05:18 -0000	1.46
+++ alsa-kernel/include/emu10k1.h	8 Oct 2004 20:16:35 -0000
@@ -781,6 +781,7 @@
 typedef struct _snd_emu10k1_pcm emu10k1_pcm_t;
 
 typedef enum {
+	EMU10K1_EFX,
 	EMU10K1_PCM,
 	EMU10K1_SYNTH,
 	EMU10K1_MIDI
@@ -792,6 +793,7 @@
 	int use: 1,
 	    pcm: 1,
 	    synth: 1,
+	    efx: 1,
 	    midi: 1;
 	void (*interrupt)(emu10k1_t *emu, emu10k1_voice_t *pvoice);
 
@@ -800,6 +802,7 @@
 
 typedef enum {
 	PLAYBACK_EMUVOICE,
+	PLAYBACK_EFX,
 	CAPTURE_AC97ADC,
 	CAPTURE_AC97MIC,
 	CAPTURE_EFX
@@ -809,7 +812,7 @@
 	emu10k1_t *emu;
 	snd_emu10k1_pcm_type_t type;
 	snd_pcm_substream_t *substream;
-	emu10k1_voice_t *voices[2];
+	emu10k1_voice_t *voices[16];
 	emu10k1_voice_t *extra;
 	unsigned short running;
 	unsigned short first_ptr;
@@ -999,6 +1002,7 @@
 	snd_pcm_substream_t *pcm_capture_substream;
 	snd_pcm_substream_t *pcm_capture_mic_substream;
 	snd_pcm_substream_t *pcm_capture_efx_substream;
+	snd_pcm_substream_t *pcm_playback_efx_substream;
 
 	emu10k1_midi_t midi;
 	emu10k1_midi_t midi2; /* for audigy */
@@ -1017,6 +1021,7 @@
 int snd_emu10k1_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_mic(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_efx(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
+int snd_emu10k1_pcm_multi(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_fx8010_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_mixer(emu10k1_t * emu);
 int snd_emu10k1_fx8010_new(emu10k1_t *emu, int device, snd_hwdep_t ** rhwdep);
Index: alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.27
diff -u -r1.27 emu10k1.c
--- alsa-kernel/pci/emu10k1/emu10k1.c	2 Jul 2004 13:22:12 -0000	1.27
+++ alsa-kernel/pci/emu10k1/emu10k1.c	8 Oct 2004 20:16:35 -0000
@@ -121,6 +121,10 @@
 		snd_card_free(card);
 		return err;
 	}		
+	if ((err = snd_emu10k1_pcm_multi(emu, 3, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}		
 	if ((err = snd_emu10k1_mixer(emu)) < 0) {
 		snd_card_free(card);
 		return err;
Index: alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.32
diff -u -r1.32 emupcm.c
--- alsa-kernel/pci/emu10k1/emupcm.c	16 Sep 2004 10:36:44 -0000	1.32
+++ alsa-kernel/pci/emu10k1/emupcm.c	8 Oct 2004 20:16:36 -0000
@@ -82,35 +82,50 @@
 	}
 #endif
 	snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
+	if (emu->pcm_playback_efx_substream != NULL) {
+	    snd_pcm_period_elapsed(emu->pcm_playback_efx_substream);
+	    printk("in capture efx irq handler, updating playback stream\n");
+	}
 }
 
 static int snd_emu10k1_pcm_channel_alloc(emu10k1_pcm_t * epcm, int voices)
 {
-	int err;
+	int err, i;
 
+	printk("pcm_channel_alloc: voices=%d\n", voices);
 	if (epcm->voices[1] != NULL && voices < 2) {
 		snd_emu10k1_voice_free(epcm->emu, epcm->voices[1]);
 		epcm->voices[1] = NULL;
 	}
 	if (voices == 1 && epcm->voices[0] != NULL)
-		return 0;		/* already allocated */
+		return 0;		/* mono, already allocated */
 	if (voices == 2 && epcm->voices[0] != NULL && epcm->voices[1] != NULL)
-		return 0;
+		return 0;		/* stereo, already allocated */
 	if (voices > 1) {
 		if (epcm->voices[0] != NULL && epcm->voices[1] == NULL) {
 			snd_emu10k1_voice_free(epcm->emu, epcm->voices[0]);
 			epcm->voices[0] = NULL;
 		}
 	}
-	err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, voices > 1, &epcm->voices[0]);
+	if (epcm->type == PLAYBACK_EMUVOICE) {
+	    err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, voices, &epcm->voices[0]);
+	} else if (epcm->type == PLAYBACK_EFX) {
+	    err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_EFX, voices, &epcm->voices[0]);
+	} else {
+	    err = 0;
+	}
+	
+	
 	if (err < 0)
 		return err;
 	epcm->voices[0]->epcm = epcm;
 	if (voices > 1) {
-		epcm->voices[1] = &epcm->emu->voices[epcm->voices[0]->number + 1];
-		epcm->voices[1]->epcm = epcm;
+		for (i = 1; i < voices; i++) {
+		    epcm->voices[i] = &epcm->emu->voices[epcm->voices[0]->number + i];
+		    epcm->voices[i]->epcm = epcm;
+		}
 	}
-	if (epcm->extra == NULL) {
+	if (epcm->extra == NULL && epcm->type != PLAYBACK_EFX) {
 		err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, 0, &epcm->extra);
 		if (err < 0) {
 			// printk("pcm_channel_alloc: failed extra: voices=%d, frame=%d\n", voices, frame);
@@ -232,6 +247,7 @@
 				       unsigned int start_addr,
 				       unsigned int end_addr)
 {
+	//printk("init voice - master %d extra %d start_addr 0x%x end_addr 0x%x\n", master, extra, start_addr,end_addr);
 	snd_pcm_substream_t *substream = evoice->epcm->substream;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[substream->number];
@@ -309,6 +325,7 @@
 	} else
 		snd_emu10k1_ptr_write(emu, FXRT, voice,
 				      snd_emu10k1_compose_send_routing(send_routing));
+	printk("init voice - master %d extra %d start_addr 0x%x end_addr 0x%x\n", master, extra, start_addr,end_addr);
 	// Stop CA
 	// Assumption that PT is already 0 so no harm overwriting
 	snd_emu10k1_ptr_write(emu, PTRX, voice, (send_amount[0] << 8) | send_amount[1]);
@@ -355,8 +372,10 @@
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int err;
 
+	/* allocate voices */
 	if ((err = snd_emu10k1_pcm_channel_alloc(epcm, params_channels(hw_params))) < 0)
 		return err;
+	/* allocate the DMA buffer */
 	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
 		return err;
 	if (err > 0) {	/* change */
@@ -403,6 +422,30 @@
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
+	for (i=0; i< 16; i++) {
+	    if (epcm->voices[i]) {
+		snd_emu10k1_voice_free(epcm->emu, epcm->voices[i]);
+		epcm->voices[i] = NULL;
+	    }
+	}
+	if (epcm->memblk) {
+		snd_emu10k1_free_pages(emu, epcm->memblk);
+		epcm->memblk = NULL;
+		epcm->start_addr = 0;
+	}
+	snd_pcm_lib_free_pages(substream);
+	return 0;
+}
 static int snd_emu10k1_playback_prepare(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -426,6 +469,35 @@
 	return 0;
 }
 
+static int snd_emu10k1_efx_playback_prepare(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm = runtime->private_data;
+	unsigned int start_addr, end_addr;
+	unsigned int channel_size;
+	int i;
+
+	start_addr = epcm->start_addr;
+	end_addr = epcm->start_addr + snd_pcm_lib_buffer_bytes(substream);
+	printk("in snd_emu10k1_efx_playback_prepare - start_addr 0x%x end_addr 0x%x\n", start_addr,end_addr);
+
+	/*
+	 * now we need to divide the buffer into 16 chunks and initialize 
+	 * 16 voices to make the noninterleaved 16 channel stream
+	 */
+	channel_size = ( end_addr - start_addr ) / 16;
+	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
+	    			   start_addr, start_addr+channel_size);
+	start_addr += channel_size;
+	for (i = 1; i < 16; i++) {
+	    snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[i],
+	    			   start_addr, start_addr+channel_size);
+	    start_addr += channel_size;
+	}
+	return 0;
+}
+
 static int snd_emu10k1_capture_hw_params(snd_pcm_substream_t * substream,
 					 snd_pcm_hw_params_t * hw_params)
 {
@@ -598,6 +670,45 @@
 	return result;
 }
 
+static int snd_emu10k1_efx_playback_trigger(snd_pcm_substream_t * substream,
+				        int cmd)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1_pcm_t *epcm = runtime->private_data;
+	int i = 0;
+	int result = 0;
+
+	// printk("trigger - emu10k1 = 0x%x, cmd = %i, pointer = %i\n", (int)emu, cmd, substream->ops->pointer(substream));
+	spin_lock(&emu->reg_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		for (i = 0; i < 16; i++) {	
+		    snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i]);
+		}
+		/* follow thru */
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 1, 0);
+		for (i = 1; i < 16; i++) {	
+		    snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 0, 0);
+		}
+		epcm->running = 1;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		epcm->running = 0;
+		for (i = 0; i < 16; i++) {	
+		    snd_emu10k1_playback_stop_voice(emu, epcm->voices[i]);
+		}
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+	spin_unlock(&emu->reg_lock);
+	return result;
+}
+
 static int snd_emu10k1_capture_trigger(snd_pcm_substream_t * substream,
 				       int cmd)
 {
@@ -685,6 +796,32 @@
 	return ptr;
 }
 
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
+	printk("ptr = 0x%x, ccca_start_addr = 0x%x\n", ptr, epcm->ccca_start_addr);
+	ptr += runtime->buffer_size;
+	ptr -= epcm->ccca_start_addr;
+	ptr %= runtime->buffer_size;
+	/*if (ptr < epcm->ccca_start_addr)
+		ptr += runtime->buffer_size - epcm->ccca_start_addr;
+	else {
+		ptr -= epcm->ccca_start_addr;
+		if (ptr >= (runtime->buffer_size))
+			ptr -= runtime->buffer_size;
+	}
+	*/
+	printk("ptr = 0x%x, buffer_size = 0x%x, period_size = 0x%x\n", ptr, (unsigned int)runtime->buffer_size, (unsigned int)runtime->period_size);
+	return ptr;
+}
+
 static snd_pcm_uframes_t snd_emu10k1_capture_pointer(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -725,6 +862,25 @@
 	.fifo_size =		0,
 };
 
+static snd_pcm_hardware_t snd_emu10k1_efx_playback =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_NONINTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		16,
+	.channels_max =		16,
+	.buffer_bytes_max =	(32*128*1024),
+	.period_bytes_min =	(64*16),
+	.period_bytes_max =	(16*128*1024),
+	.periods_min =		2,
+	.periods_max =		2,
+	.fifo_size =		0,
+};
+
 /*
  *  Capture support device description
  */
@@ -818,6 +974,26 @@
 	return 0;
 }
 
+static int snd_emu10k1_efx_playback_open(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	emu10k1_pcm_t *epcm;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
+	if (epcm == NULL)
+		return -ENOMEM;
+	epcm->emu = emu;
+	epcm->type = PLAYBACK_EFX;
+	epcm->substream = substream;
+	emu->pcm_playback_efx_substream = substream;
+	runtime->private_data = epcm;
+	runtime->private_free = snd_emu10k1_pcm_free_substream;
+	runtime->hw = snd_emu10k1_efx_playback;
+
+	return 0;
+}
+
 static int snd_emu10k1_playback_close(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -828,6 +1004,19 @@
 	return 0;
 }
 
+static int snd_emu10k1_efx_playback_close(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	/*
+	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[substream->number];
+
+	mix->epcm = NULL;
+	snd_emu10k1_pcm_mixer_notify(emu, substream->number, 0); */
+    
+	emu->pcm_playback_efx_substream = NULL;
+	return 0;
+}
+
 static int snd_emu10k1_capture_open(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -964,6 +1153,20 @@
 	.page =			snd_pcm_sgbuf_ops_page,
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
+
 static snd_pcm_ops_t snd_emu10k1_capture_ops = {
 	.open =			snd_emu10k1_capture_open,
 	.close =		snd_emu10k1_capture_close,
@@ -1366,6 +1569,7 @@
 	.ack =			snd_emu10k1_fx8010_playback_transfer,
 };
 
+
 static void snd_emu10k1_pcm_efx_free(snd_pcm_t *pcm)
 {
 	emu10k1_t *emu = pcm->private_data;
@@ -1404,3 +1608,35 @@
 
 	return 0;
 }
+
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
Index: alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.5
diff -u -r1.5 voice.c
--- alsa-kernel/pci/emu10k1/voice.c	12 Aug 2002 08:43:47 -0000	1.5
+++ alsa-kernel/pci/emu10k1/voice.c	8 Oct 2004 20:16:36 -0000
@@ -30,13 +30,26 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int pair, emu10k1_voice_t **rvoice)
+static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int number, emu10k1_voice_t **rvoice)
 {
 	emu10k1_voice_t *voice, *voice2;
-	int idx;
-
 	*rvoice = NULL;
-	for (idx = 0; idx < 64; idx += pair ? 2 : 1) {
+	int idx,pair;
+	pair = ( number == 2 ) ? 1 : 0;
+	if (type == EMU10K1_EFX) { /* multichannel pcm */
+	    for (idx = 0; idx < 16; idx++) {
+		voice = &emu->voices[idx];
+		printk("voice alloc - %i, %i of %i\n", voice->number, idx, number);
+		if (voice->use) /* error, nothing else should touch the 1st 16 voices */
+		    return -ENOMEM;
+		voice->use = 1;
+		voice->efx = 1;
+	    }
+	    *rvoice = &emu->voices[0];
+	    return 0;
+	}
+		
+	for (idx = 16; idx < 64; idx += pair ? 2 : 1) {
 		voice = &emu->voices[idx];
 		voice2 = pair ? &emu->voices[idx+1] : NULL;
 		if (voice->use || (voice2 && voice2->use))
@@ -56,8 +69,10 @@
 		case EMU10K1_MIDI:
 			voice->midi = 1;
 			break;
+		case EMU10K1_EFX:
+			break;
 		}
-		// printk("voice alloc - %i, pair = %i\n", voice->number, pair);
+		printk("voice alloc - %i, number = %i\n", voice->number, number);
 		*rvoice = voice;
 		return 0;
 	}
@@ -70,12 +85,12 @@
 	int result;
 
 	snd_assert(rvoice != NULL, return -EINVAL);
-	snd_assert(!pair || type == EMU10K1_PCM, return -EINVAL);
+	snd_assert(!pair || type == EMU10K1_PCM || type==EMU10K1_EFX, return -EINVAL);
 
 	spin_lock_irqsave(&emu->voice_lock, flags);
 	for (;;) {
 		result = voice_alloc(emu, type, pair, rvoice);
-		if (result == 0 || type != EMU10K1_PCM)
+		if (result == 0 || type == EMU10K1_SYNTH || type == EMU10K1_MIDI)
 			break;
 
 		/* free a voice from synth */
@@ -84,7 +99,7 @@
 			if (result >= 0) {
 				emu10k1_voice_t *pvoice = &emu->voices[result];
 				pvoice->interrupt = NULL;
-				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 				pvoice->epcm = NULL;
 			}
 		}
@@ -103,7 +118,7 @@
 	snd_assert(pvoice != NULL, return -EINVAL);
 	spin_lock_irqsave(&emu->voice_lock, flags);
 	pvoice->interrupt = NULL;
-	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 	pvoice->epcm = NULL;
 	snd_emu10k1_voice_init(emu, pvoice->number);
 	spin_unlock_irqrestore(&emu->voice_lock, flags);

--=-EBskVk+RPkpWuuyxWvsi--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
