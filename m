From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH/RFC] emu10k1 multichannel PCM
Date: Sat, 13 Nov 2004 23:18:44 -0500
Message-ID: <1100405924.16103.23.camel@krustophenia.net>
References: <1100300857.19038.14.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100300857.19038.14.camel@krustophenia.net>
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
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-11-12 at 18:07 -0500, Lee Revell wrote:
> This patch is still missing a few things, like dynamic voice allocation
> and correctly setting the send routing, but it does work with JACK, and
> should not interfere with the operation of the other devices.   I tested
> it like so:

Here is a patch that adds the mixer controls for this device.  This
includes the previous patches (add multichannel support and add register
dump to /proc)  Unfortunately this adds 16 x 3 mixer controls... people
complain enough about the emu10k1 mixer already, so this might not be
well received in some circles.  I am not sure what to do about this.
The kX mixer probably has hundreds of controls, but they are arranged in
a tree structure.

With these patches the emu10k1 driver should have the same functionality
as kX ASIO.  This will require some DSP loader support, not implemented
yet, to connect physical inputs to the capture channels selected with
EFX voices mask.

For now this requires using EFX voices mask to enable exactly 16
channels for capture.  The kX driver uses outputs 16-31, this is the
recommended usage here as well.  Since these channels do not correspond
to any physical outs, this way you only record what you explicitly
connect to one of those outputs in the DSP.

Also, I updated the patch to apply with -p1 (sorry) and the missing
Signed-Off-By.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.50
diff -u -r1.50 emu10k1.h
--- alsa/alsa-kernel/include/emu10k1.h	10 Nov 2004 09:49:11 -0000	1.50
+++ alsa/alsa-kernel/include/emu10k1.h	14 Nov 2004 04:17:00 -0000
@@ -51,6 +51,7 @@
 #define NUM_MIDI        16
 #define NUM_G           64              /* use all channels */
 #define NUM_FXSENDS     4
+#define NUM_EFX_PLAYBACK    16
 
 #define EMU10K1_DMA_MASK	0x7fffffffUL	/* 31bit */
 #define AUDIGY_DMA_MASK		0xffffffffUL	/* 32bit */
@@ -782,6 +783,7 @@
 typedef struct _snd_emu10k1_pcm emu10k1_pcm_t;
 
 typedef enum {
+	EMU10K1_EFX,
 	EMU10K1_PCM,
 	EMU10K1_SYNTH,
 	EMU10K1_MIDI
@@ -792,6 +794,7 @@
 	int number;
 	int use: 1,
 	    pcm: 1,
+	    efx: 1,
 	    synth: 1,
 	    midi: 1;
 	void (*interrupt)(emu10k1_t *emu, emu10k1_voice_t *pvoice);
@@ -801,6 +804,7 @@
 
 typedef enum {
 	PLAYBACK_EMUVOICE,
+	PLAYBACK_EFX,
 	CAPTURE_AC97ADC,
 	CAPTURE_AC97MIC,
 	CAPTURE_EFX
@@ -810,7 +814,7 @@
 	emu10k1_t *emu;
 	snd_emu10k1_pcm_type_t type;
 	snd_pcm_substream_t *substream;
-	emu10k1_voice_t *voices[2];
+	emu10k1_voice_t *voices[16];
 	emu10k1_voice_t *extra;
 	unsigned short running;
 	unsigned short first_ptr;
@@ -985,6 +989,7 @@
 
 	emu10k1_voice_t voices[64];
 	emu10k1_pcm_mixer_t pcm_mixer[32];
+	emu10k1_pcm_mixer_t efx_pcm_mixer[16];
 	snd_kcontrol_t *ctl_send_routing;
 	snd_kcontrol_t *ctl_send_volume;
 	snd_kcontrol_t *ctl_attn;
@@ -993,6 +998,7 @@
 	void (*capture_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*capture_mic_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*capture_efx_interrupt)(emu10k1_t *emu, unsigned int status);
+	// FIXME: can go away - uses ALSA timer API now
 	void (*timer_interrupt)(emu10k1_t *emu);
 	void (*spdif_interrupt)(emu10k1_t *emu, unsigned int status);
 	void (*dsp_interrupt)(emu10k1_t *emu);
@@ -1000,6 +1006,7 @@
 	snd_pcm_substream_t *pcm_capture_substream;
 	snd_pcm_substream_t *pcm_capture_mic_substream;
 	snd_pcm_substream_t *pcm_capture_efx_substream;
+	snd_pcm_substream_t *pcm_playback_efx_substream;
 
 	snd_timer_t *timer;
 
@@ -1020,6 +1027,7 @@
 int snd_emu10k1_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_mic(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_pcm_efx(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
+int snd_emu10k1_pcm_multi(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_fx8010_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_mixer(emu10k1_t * emu);
 int snd_emu10k1_timer(emu10k1_t * emu, int device);
Index: alsa/alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.29
diff -u -r1.29 emu10k1.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1.c	10 Nov 2004 09:49:12 -0000	1.29
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1.c	14 Nov 2004 04:17:00 -0000
@@ -130,6 +130,11 @@
 		return err;
 	}
 
+	if ((err = snd_emu10k1_pcm_multi(emu, 3, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}		
+
 	if (emu->audigy) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
 			snd_card_free(card);
Index: alsa/alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.26
diff -u -r1.26 emumixer.c
--- alsa/alsa-kernel/pci/emu10k1/emumixer.c	17 Aug 2004 10:16:03 -0000	1.26
+++ alsa/alsa-kernel/pci/emu10k1/emumixer.c	14 Nov 2004 04:17:01 -0000
@@ -213,6 +213,17 @@
         .put =          snd_emu10k1_send_routing_put
 };
 
+static snd_kcontrol_new_t snd_emu10k1_efx_send_routing_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Multichannel PCM Send Routing",
+	.count =	16,
+        .info =         snd_emu10k1_send_routing_info,
+        .get =          snd_emu10k1_send_routing_get,
+        .put =          snd_emu10k1_send_routing_put
+};
+
 static int snd_emu10k1_send_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
@@ -282,6 +293,17 @@
         .put =          snd_emu10k1_send_volume_put
 };
 
+static snd_kcontrol_new_t snd_emu10k1_efx_send_volume_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Multichannel PCM Send Volume",
+	.count =	16,
+        .info =         snd_emu10k1_send_volume_info,
+        .get =          snd_emu10k1_send_volume_get,
+        .put =          snd_emu10k1_send_volume_put
+};
+
 static int snd_emu10k1_attn_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -345,6 +367,17 @@
         .put =          snd_emu10k1_attn_put
 };
 
+static snd_kcontrol_new_t snd_emu10k1_efx_attn_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Multichannel PCM Volume",
+	.count =	16,
+        .info =         snd_emu10k1_attn_info,
+        .get =          snd_emu10k1_attn_get,
+        .put =          snd_emu10k1_attn_put
+};
+
 static int snd_emu10k1_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
@@ -557,10 +590,8 @@
 			strcpy(emu->card->mixername, "Emu10k1");
 	}
 
-	if (emu->audigy)
-		c = audigy_rename_ctls;
-	else
-		c = emu10k1_rename_ctls;
+
+	c = (emu->audigy) ? audigy_rename_ctls : emu10k1_rename_ctls;
 	for (; *c; c += 2)
 		rename_ctl(card, c[0], c[1]);
 
@@ -568,16 +599,33 @@
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
+	
 	if ((kctl = emu->ctl_send_volume = snd_ctl_new1(&snd_emu10k1_send_volume_control, emu)) == NULL)
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
+	
 	if ((kctl = emu->ctl_attn = snd_ctl_new1(&snd_emu10k1_attn_control, emu)) == NULL)
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
 
-	/* intiailize the routing and volume table for each pcm playback stream */
+	if ((kctl = emu->ctl_send_routing = snd_ctl_new1(&snd_emu10k1_efx_send_routing_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	
+	if ((kctl = emu->ctl_send_volume = snd_ctl_new1(&snd_emu10k1_efx_send_volume_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	
+	if ((kctl = emu->ctl_attn = snd_ctl_new1(&snd_emu10k1_efx_attn_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+
+	/* initialize the routing and volume table for each pcm playback stream */
 	for (pcm = 0; pcm < 32; pcm++) {
 		emu10k1_pcm_mixer_t *mix;
 		int v;
@@ -597,6 +645,26 @@
 		mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
 	}
 	
+	/* initialize the routing and volume table for the multichannel playback stream */
+	for (pcm = 0; pcm < 16; pcm++) {
+		emu10k1_pcm_mixer_t *mix;
+		int v;
+		
+		mix = &emu->efx_pcm_mixer[pcm];
+		mix->epcm = NULL;
+
+		for (v = 0; v < 4; v++)
+			mix->send_routing[0][v] = 
+				mix->send_routing[1][v] = 
+				mix->send_routing[2][v] = v;
+		
+		memset(&mix->send_volume, 0, sizeof(mix->send_volume));
+		mix->send_volume[0][0] = mix->send_volume[0][1] =
+		mix->send_volume[1][0] = mix->send_volume[2][1] = 255;
+		
+		mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
+	}
+	
 	if (! emu->APS) { /* FIXME: APS has these controls? */
 		/* sb live! and audigy */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)
Index: alsa/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.33
diff -u -r1.33 emupcm.c
--- alsa/alsa-kernel/pci/emu10k1/emupcm.c	30 Sep 2004 10:06:53 -0000	1.33
+++ alsa/alsa-kernel/pci/emu10k1/emupcm.c	14 Nov 2004 04:17:02 -0000
@@ -42,13 +42,19 @@
 		return;
 	if (epcm->substream == NULL)
 		return;
-#if 0
-	printk("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
-			epcm->substream->runtime->hw->pointer(emu, epcm->substream),
-			snd_pcm_lib_period_bytes(epcm->substream),
-			snd_pcm_lib_buffer_bytes(epcm->substream));
-#endif
+	/*
+    	printk("in snd_emu10k1_pcm_interrupt, voice %i, WC = %i, master voice ptr %i\n",
+	    voice->number, 
+	    snd_emu10k1_wc(emu), 
+	    snd_emu10k1_ptr_read(emu, CCCA, voice->number) & CCCA_CURRADDR_MASK);
+	    */
 	snd_pcm_period_elapsed(epcm->substream);
+	/*
+	printk("in snd_emu10k1_pcm_interrupt, done with period_elapsed, voice %i, WC = %i, master voice ptr %i\n",
+	    voice->number, 
+	    snd_emu10k1_wc(emu), 
+	    snd_emu10k1_ptr_read(emu, CCCA, voice->number) & CCCA_CURRADDR_MASK);
+	*/
 }
 
 static void snd_emu10k1_pcm_ac97adc_interrupt(emu10k1_t *emu, unsigned int status)
@@ -81,12 +87,60 @@
 			return;
 	}
 #endif
+
 	snd_pcm_period_elapsed(emu->pcm_capture_efx_substream);
+
+        if (emu->pcm_playback_efx_substream == NULL) {
+	    printk("in capture efx irq handler, playback stream not start.  WC = %i\n",
+	     snd_emu10k1_wc(emu));
+	    return;
+	}
+
+	emu10k1_pcm_t *epcm = emu->pcm_playback_efx_substream->runtime->private_data;
+	if (epcm == NULL || !epcm->running) {
+	    return;
+	} else {
+	    if (epcm->first_ptr == 1) {
+		epcm->first_ptr = 0;
+		printk("in irq handler, first_ptr = 1\n");
+		return;
+	    }
+	    snd_pcm_period_elapsed(emu->pcm_playback_efx_substream);
+	}
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
+	/*
+	 printk("efx playback pointer: curraddr = %i, start_addr = %i, WC = %i\n",
+	    (unsigned int)ptr,
+	    (unsigned int)epcm->ccca_start_addr,
+	    snd_emu10k1_wc(emu));
+	*/
+	ptr += runtime->buffer_size;
+	ptr -= epcm->ccca_start_addr;
+	ptr %= runtime->buffer_size;
+	/*
+	printk("efx_playback_pointer is %i (buffer_size = %i, period_size = %i)\n",
+		ptr, 
+		(unsigned int) runtime->buffer_size,
+		(unsigned int) runtime->period_size);
+	*/
+	return ptr;
 }
 
 static int snd_emu10k1_pcm_channel_alloc(emu10k1_pcm_t * epcm, int voices)
 {
-	int err;
+	int err, i;
+	printk("pcm_channel_alloc: voices=%d\n", voices);
 
 	if (epcm->voices[1] != NULL && voices < 2) {
 		snd_emu10k1_voice_free(epcm->emu, epcm->voices[1]);
@@ -102,13 +156,22 @@
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
 	if (epcm->extra == NULL) {
 		err = snd_emu10k1_voice_alloc(epcm->emu, EMU10K1_PCM, 0, &epcm->extra);
@@ -232,9 +295,10 @@
 				       unsigned int start_addr,
 				       unsigned int end_addr)
 {
+	printk("init voice - master %i extra %i start_addr %i end_addr %i\n", master, extra, start_addr,end_addr);
 	snd_pcm_substream_t *substream = evoice->epcm->substream;
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[substream->number];
+	emu10k1_pcm_mixer_t *mix;
 	unsigned int silent_page, tmp;
 	int voice, stereo, w_16;
 	unsigned char attn, send_amount[8];
@@ -243,6 +307,11 @@
 	unsigned int pitch_target;
 
 	voice = evoice->number;
+	if (evoice->epcm->type == PLAYBACK_EFX) 
+	    mix = &emu->efx_pcm_mixer[voice];
+	else
+	    mix = &emu->pcm_mixer[substream->number];
+
 	stereo = runtime->channels == 2;
 	w_16 = snd_pcm_format_width(runtime->format) == 16;
 
@@ -272,11 +341,13 @@
 		memcpy(send_amount, &mix->send_volume[tmp][0], 8);
 	}
 
+	unsigned int ccis = stereo ? 28 : 30;
+	if (w_16)
+	    ccis *= 2;
+	
 	if (master) {
-		unsigned int ccis = stereo ? 28 : 30;
-		if (w_16)
-			ccis *= 2;
 		evoice->epcm->ccca_start_addr = start_addr + ccis;
+		//evoice->epcm->ccca_start_addr = start_addr;
 		if (extra) {
 			start_addr += ccis;
 			end_addr += ccis;
@@ -315,7 +386,7 @@
 	snd_emu10k1_ptr_write(emu, DSL, voice, end_addr | (send_amount[3] << 24));
 	snd_emu10k1_ptr_write(emu, PSST, voice, start_addr | (send_amount[2] << 24));
 	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
-	snd_emu10k1_ptr_write(emu, CCCA, voice, evoice->epcm->ccca_start_addr |
+	snd_emu10k1_ptr_write(emu, CCCA, voice, (start_addr + ccis) |
 			      emu10k1_select_interprom(pitch_target) |
 			      (w_16 ? 0 : CCCA_8BITSELECT));
 	// Clear filter delay memory
@@ -403,6 +474,35 @@
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
+
 static int snd_emu10k1_playback_prepare(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -426,6 +526,60 @@
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
+	printk("in snd_emu10k1_efx_playback_prepare - start_addr 0x%x end_addr 0x%x\n", start_addr,end_addr);
+
+	/*
+	 * now we need to divide the buffer into NUM_EFX_PLAYBACK chunks and initialize 
+	 * NUM_EFX_PLAYBACK voices to make the noninterleaved stream
+	 *
+	 * the kX driver leaves some space between voices
+	 */
+	unsigned int channel_size;
+	int i;
+	channel_size = ( end_addr - start_addr ) / NUM_EFX_PLAYBACK;
+
+	/* only difference wit the master voice is we use it for the pointer */
+	snd_emu10k1_pcm_init_voice(emu, 1, 0, epcm->voices[0],
+				   start_addr, start_addr + channel_size);
+
+	start_addr += channel_size;
+	for (i = 1; i < NUM_EFX_PLAYBACK; i++) {
+	    snd_emu10k1_pcm_init_voice(emu, 0, 0, epcm->voices[i],
+	    			   start_addr, start_addr+channel_size);
+	    start_addr += channel_size;
+	}
+
+	return 0;
+}
+
+static snd_pcm_hardware_t snd_emu10k1_efx_playback =
+{
+	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_NONINTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_PAUSE /* | SNDRV_PCM_INFO_SYNC_START */ ),
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
@@ -444,6 +598,7 @@
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int idx;
 
+	/* zeroing the buffer size will stop capture */
 	snd_emu10k1_ptr_write(emu, epcm->capture_bs_reg, 0, 0);
 	switch (epcm->type) {
 	case CAPTURE_AC97ADC:
@@ -527,8 +682,12 @@
 		return;
 	substream = evoice->epcm->substream;
 	runtime = substream->runtime;
-	mix = &emu->pcm_mixer[substream->number];
 	voice = evoice->number;
+	if (evoice->epcm->type == PLAYBACK_EFX) 
+	    mix = &emu->efx_pcm_mixer[voice];
+	else
+	    mix = &emu->pcm_mixer[substream->number];
+
 	pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
 	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
 	attn = extra ? 0 : 0x00ff;
@@ -536,12 +695,15 @@
 	snd_emu10k1_ptr_write(emu, IFATN, voice, attn);
 	snd_emu10k1_ptr_write(emu, VTFT, voice, (mix->attn[tmp] << 16) | 0xffff);
 	snd_emu10k1_ptr_write(emu, CVCF, voice, (mix->attn[tmp] << 16) | 0xffff);
-	snd_emu10k1_voice_clear_loop_stop(emu, voice);		
-	if (extra)
+	if (evoice->epcm->type == PLAYBACK_EFX) 
+	    snd_emu10k1_voice_set_loop_stop(emu, voice);		
+	else
+	    snd_emu10k1_voice_clear_loop_stop(emu, voice);		
+	if (extra && evoice->epcm->type != PLAYBACK_EFX)
 		snd_emu10k1_voice_intr_enable(emu, voice);
 	snd_emu10k1_ptr_write(emu, DCYSUSV, voice, 0x7f7f);
 	snd_emu10k1_ptr_write(emu, PTRX_PITCHTARGET, voice, pitch_target);
-	if (master)
+	if (master || evoice->epcm->type == PLAYBACK_EFX)
 		snd_emu10k1_ptr_write(emu, CPF_CURRENTPITCH, voice, pitch_target);
 	snd_emu10k1_ptr_write(emu, IP, voice, pitch);
 }
@@ -574,7 +736,7 @@
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);	/* do we need this? */
+		// snd_emu10k1_playback_invalidate_cache(emu, epcm->extra);	/* do we need this? */
 		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0]);
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
@@ -606,10 +768,17 @@
 	emu10k1_pcm_t *epcm = runtime->private_data;
 	int result = 0;
 
-	// printk("trigger - emu10k1 = %p, cmd = %i, pointer = %i\n", emu, cmd, substream->ops->pointer(substream));
+	/*printk("capture trigger - emu10k1 = 0x%x, cmd = %i, pointer = %i, WC = %i\n", 
+	    (int)emu, 
+	    cmd, 
+	    (int)substream->ops->pointer(substream), 
+	    snd_emu10k1_wc(emu));
+	*/
+	
 	spin_lock(&emu->reg_lock);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		// hmm this should cause full and half full interrupt to be raised?  
 		outl(epcm->capture_ipr, emu->port + IPR);
 		snd_emu10k1_intr_enable(emu, epcm->capture_inte);
 		// printk("adccr = 0x%x, adcbs = 0x%x\n", epcm->adccr, epcm->adcbs);
@@ -685,6 +854,111 @@
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
+        unsigned int ptr0, ptr1, sol;
+
+	printk("trigger - emu10k1 = 0x%x, cmd = %i, pointer = %i, WC = %i\n", 
+	    (int)emu, 
+	    cmd, 
+	    (int)substream->ops->pointer(substream), 
+	    snd_emu10k1_wc(emu));
+
+	spin_lock(&emu->reg_lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		// prepare voices
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		    snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[i]);
+		}
+		// start em - this will also set loop stop
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		    snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 0, 0);
+		}
+		// check 1st and last voice position
+		ptr0 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+		ptr1 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[15]->number) & 0x00ffffff;
+		printk("start - about to clear loop stop.  channel 0 curraddr = %i, channel 15 = %i, WC = %i\n", 
+			ptr0, 
+			ptr1, 
+			snd_emu10k1_wc(emu));
+		// wait a bit for all to reach loop end
+		snd_emu10k1_wait(emu, 100);
+		// check 1st and last voice position
+		ptr0 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+		ptr1 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[15]->number) & 0x00ffffff;
+		printk("start - waited a bit more.  channel 0 curraddr = %i, channel 15 = %i, WC = %i\n", 
+			ptr0, 
+			ptr1, 
+			snd_emu10k1_wc(emu));
+		// go
+		outl(SOLEL << 16, emu->port + PTR);
+		sol = inl(emu->port + DATA);
+		sol &= ~0xffff;
+		outl(sol, emu->port + DATA);
+		epcm->first_ptr = 1;
+		epcm->running = 1;
+		break;
+		/* follow thru */
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		    snd_emu10k1_playback_trigger_voice(emu, epcm->voices[i], 0, 0);
+		}
+		epcm->running = 1;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		ptr0 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+		ptr1 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[15]->number) & 0x00ffffff;
+		printk("stop - about to set loop stop and wait 1024 ticks.  channel 0 curraddr = %i, channel 15 = %i, WC = %i\n", 
+			ptr0, 
+			ptr1, 
+			snd_emu10k1_wc(emu));
+		// set loop stop on all voices
+		outl(SOLEL << 16, emu->port + PTR);
+		sol = inl(emu->port + DATA);
+		sol |= 0xffff;
+		outl(sol, emu->port + DATA);
+		// wait a bit for all to reach loop end
+		snd_emu10k1_wait(emu, 1024);
+		// ok they should be in sync here
+		ptr0 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[0]->number) & 0x00ffffff;
+		ptr1 = snd_emu10k1_ptr_read(emu, CCCA, epcm->voices[15]->number) & 0x00ffffff;
+		printk("stopped - channel 0 curraddr = %i, channel 15 = %i, WC = %i\n", 
+			ptr0, 
+			ptr1, 
+			snd_emu10k1_wc(emu));
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
+		    snd_emu10k1_playback_stop_voice(emu, epcm->voices[i]);
+		}
+		epcm->running = 0;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		epcm->running = 0;
+		// set loop stop on all voices
+		outl(SOLEL << 16, emu->port + PTR);
+		sol = inl(emu->port + DATA);
+		sol |= 0xffff;
+		outl(sol, emu->port + DATA);
+		for (i = 0; i < NUM_EFX_PLAYBACK; i++) {	
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
+
 static snd_pcm_uframes_t snd_emu10k1_capture_pointer(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -698,8 +972,15 @@
 		udelay(50);	// hack, it takes awhile until capture is started
 		epcm->first_ptr = 0;
 	}
-	ptr = snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & 0x0000ffff;
-	return bytes_to_frames(runtime, ptr);
+	ptr = bytes_to_frames(runtime, (snd_emu10k1_ptr_read(emu, epcm->capture_idx_reg, 0) & 0x0000ffff));
+	
+#if 0
+	printk("capture_pointer: %i frames (%i WC ticks) since last irq\n", 
+		(ptr + runtime->buffer_size - emu->last_capture_ptr) % runtime->buffer_size, 
+		ticks - emu->last_irq_time);
+#endif
+
+	return ptr;
 }
 
 /*
@@ -733,7 +1014,7 @@
 {
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				 SNDRV_PCM_INFO_MMAP_VALID),
+				 SNDRV_PCM_INFO_MMAP_VALID /* | SNDRV_PCM_INFO_SYNC_START */),
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
 	.rates =		SNDRV_PCM_RATE_8000_48000,
 	.rate_min =		8000,
@@ -781,6 +1062,54 @@
 		kfree(epcm);
 }
 
+static int snd_emu10k1_efx_playback_close(snd_pcm_substream_t * substream)
+{
+	emu10k1_t *emu = snd_pcm_substream_chip(substream);
+	emu10k1_pcm_mixer_t *mix;
+	int i;
+
+	for (i=0; i < NUM_EFX_PLAYBACK; i++) {
+	    mix = &emu->pcm_mixer[i];
+	    mix->epcm = NULL;
+	    snd_emu10k1_pcm_mixer_notify(emu, i, 0);
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
+	int i, j;
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
+	// snd_pcm_set_sync(substream);
+	
+	for (j=0; j < NUM_EFX_PLAYBACK; j++) {
+	    mix = &emu->efx_pcm_mixer[j];
+	    for (i = 0; i < 4; i++)
+		    mix->send_routing[0][i] = mix->send_routing[1][i] = mix->send_routing[2][i] = i;
+	    memset(&mix->send_volume, 0, sizeof(mix->send_volume));
+	    mix->send_volume[0][0] = mix->send_volume[0][1] =
+	    mix->send_volume[1][0] = mix->send_volume[2][1] = 255;
+	    mix->attn[0] = mix->attn[1] = mix->attn[2] = 0xffff;
+	    mix->epcm = epcm;
+	    snd_emu10k1_pcm_mixer_notify(emu, j, 1);
+	}
+	return 0;
+}
+
 static int snd_emu10k1_playback_open(snd_pcm_substream_t * substream)
 {
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
@@ -940,6 +1269,7 @@
 	emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
 	emu->pcm_capture_efx_substream = substream;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
+	// snd_pcm_set_sync(substream);
 	return 0;
 }
 
@@ -975,6 +1305,19 @@
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
@@ -1018,6 +1361,39 @@
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
Index: alsa/alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.21
diff -u -r1.21 emuproc.c
--- alsa/alsa-kernel/pci/emu10k1/emuproc.c	6 Sep 2004 15:05:19 -0000	1.21
+++ alsa/alsa-kernel/pci/emu10k1/emuproc.c	14 Nov 2004 04:17:02 -0000
@@ -178,7 +178,7 @@
 	unsigned int val;
 	int nefx = emu->audigy ? 64 : 32;
 	char **outputs = emu->audigy ? audigy_outs : creative_outs;
-	int idx;
+	int idx, reg;
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	val = emu->audigy ?
@@ -219,6 +219,17 @@
 	snd_iprintf(buffer, "\nZoomed Video\n");
 	snd_iprintf(buffer, "Rate Locked           : %s\n", val & SRCS_RATELOCKED ? "on" : "off");
 	snd_iprintf(buffer, "Estimated Sample Rate : 0x%x\n", val & SRCS_ESTSAMPLERATE);
+	
+	// per-voice parameters
+	for (idx = 0; idx < NUM_G; idx++) {
+	    snd_iprintf(buffer, "\nVoice %i PTR registers\n", idx);
+	    for (reg = 0x0; reg < 0x7f; reg++) {
+		snd_iprintf(buffer, "PTR 0x%x 0x%x\n",
+			reg,
+			snd_emu10k1_ptr_read(emu, reg, idx));
+	    }
+	}
+
 }
 
 static void snd_emu10k1_proc_acode_read(snd_info_entry_t *entry, 
@@ -318,7 +329,7 @@
 	snd_info_entry_t *entry;
 	
 	if (! snd_card_proc_new(emu->card, "emu10k1", &entry))
-		snd_info_set_text_ops(entry, emu, 1024, snd_emu10k1_proc_read);
+		snd_info_set_text_ops(entry, emu, 131072, snd_emu10k1_proc_read);
 
 	if (! snd_card_proc_new(emu->card, "fx8010_gpr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
Index: alsa/alsa-kernel/pci/emu10k1/voice.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/voice.c,v
retrieving revision 1.5
diff -u -r1.5 voice.c
--- alsa/alsa-kernel/pci/emu10k1/voice.c	12 Aug 2002 08:43:47 -0000	1.5
+++ alsa/alsa-kernel/pci/emu10k1/voice.c	14 Nov 2004 04:17:02 -0000
@@ -30,13 +30,27 @@
 #include <sound/core.h>
 #include <sound/emu10k1.h>
 
-static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int pair, emu10k1_voice_t **rvoice)
+static int voice_alloc(emu10k1_t *emu, emu10k1_voice_type_t type, int number, emu10k1_voice_t **rvoice)
 {
 	emu10k1_voice_t *voice, *voice2;
-	int idx;
 
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
@@ -56,8 +70,10 @@
 		case EMU10K1_MIDI:
 			voice->midi = 1;
 			break;
+		case EMU10K1_EFX:
+			break;
 		}
-		// printk("voice alloc - %i, pair = %i\n", voice->number, pair);
+		printk("voice alloc - %i, pair = %i\n", voice->number, pair);
 		*rvoice = voice;
 		return 0;
 	}
@@ -70,12 +86,12 @@
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
@@ -84,7 +100,7 @@
 			if (result >= 0) {
 				emu10k1_voice_t *pvoice = &emu->voices[result];
 				pvoice->interrupt = NULL;
-				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+				pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 				pvoice->epcm = NULL;
 			}
 		}
@@ -103,7 +119,7 @@
 	snd_assert(pvoice != NULL, return -EINVAL);
 	spin_lock_irqsave(&emu->voice_lock, flags);
 	pvoice->interrupt = NULL;
-	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = 0;
+	pvoice->use = pvoice->pcm = pvoice->synth = pvoice->midi = pvoice->efx = 0;
 	pvoice->epcm = NULL;
 	snd_emu10k1_voice_init(emu, pvoice->number);
 	spin_unlock_irqrestore(&emu->voice_lock, flags);




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
