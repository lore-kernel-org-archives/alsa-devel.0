From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] audigyls driver.
Date: Fri, 02 Jul 2004 17:42:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40E59061.10605@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080205050501080900080505"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7AE8725D
	for <alsa-devel@alsa-project.org>; Fri,  2 Jul 2004 18:41:21 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BgR6F-0005KL-0W
	for alsa-devel@alsa-project.org; Fri, 02 Jul 2004 17:41:19 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080205050501080900080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch against the current CVS.

I have implemented a separate DMA buffer for the period table list.
I have implemented a list for the remove/rename ctls.

Cheers
James

--------------080205050501080900080505
Content-Type: text/plain;
 name="audigyls2.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigyls2.diff.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.5
diff -u -r1.5 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	1 Jul 2004 08:38:28 -0000	1.5
+++ alsa-driver/pci/emu10k1/audigyls.c	2 Jul 2004 16:39:00 -0000
@@ -1,6 +1,7 @@
 /*
  *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver AUDIGYLS chips
+ *  Version: 0.8
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -17,16 +18,41 @@
  *      So, to record from the MIC, set the MIC Playback volume to max,
  *      unmute the MIC and turn up the MASTER Playback volume.
  *      So, to prevent feedback when capturing, minimise the "Capture feedback into Playback" volume.
- *      The Digital/Analog switch must be in Analog mode for CAPTURE.
+ *   
+ *    The only playback controls that currently do anything are: -
+ *    Analog Front
+ *    Analog Rear
+ *    Analog Center/LFE
+ *    SPDIF Front
+ *    SPDIF Rear
+ *    SPDIF Center/LFE
+ *   
+ *    For capture from Mic in or Line in.
+ *    (The AudigyLS uses the AC97 playback channel for capture. The AC97 capture channel is not used at all.)
+ *    Master
+ *    Mic  (The one marked as playback)
+ *    Mic boost
+ *    Line (The one marked as playback)
+ *    Digital/Analog ( switch must be in Analog mode for CAPTURE. )
+ *    CAPTURE feedback into PLAYBACK
+ * 
+ *  Changelog:
+ *    Support interrupts per period.
+ *    Removed noise from Center/LFE channel when in Analog mode.
+ *    Rename and remove mixer controls.
+ *  0.0.6
+ *    Use separate card based DMA buffer for periods table list.
+ *  0.0.7
+ *    Change remove and rename ctrls into lists.
+ *  0.0.8
+ *    Try to fix capture sources.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-audigyls kernel module.
  *    --
  *
  *  TODO:
- *    Need to add a way to select capture source.
  *    4 Capture channels, only one implemented so far.
- *    Need to find out what the AC97 chip actually does.
  *    Other rates apart from 48khz not implemented.
  *    MIDI
  *    --
@@ -107,6 +133,7 @@
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
 #define INTE_TIMER              0x00000008      /* Interrupt based on Timer                     */
 
+#define UNKNOWN14		0x10		/* Unknown ??. Defaults to 0 */
 #define HCFG			0x14		/* Hardware config register			*/
 
 #define HCFG_LOCKSOUNDCACHE	0x00000008	/* 1 = Cancel bustmaster accesses to soundcache */
@@ -114,19 +141,28 @@
 #define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
 						/* Should be set to 1 when the EMU10K1 is	*/
 						/* completely initialized.			*/
+#define GPIO			0x18		/* Defaults: 005f03a3-Analog, 005f02a2-SPDIF.   */
+#define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
+
+#define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
 
 /********************************************************************************************************/
 /* Audigy LS pointer-offset register set, accessed through the PTR and DATA registers                     */
 /********************************************************************************************************/
                                                                                                                            
 /* Initally all registers from 0x00 to 0x3f have zero contents. */
-#define PLAYBACK_UNKNOWN0	0x00		/* Something used in playback */
-#define PLAYBACK_UNKNOWN1	0x01		/* Something used in playback */
-#define PLAYBACK_UNKNOWN2	0x02		/* Something used in playback */
-#define PLAYBACK_UNKNOWN3	0x03		/* Something ?? */
+#define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
+						/* One list entry: 4 bytes for DMA address, 
+						 * 4 bytes for period_size << 16.
+						 * One list entry is 8 bytes long.
+						 * One list entry for each period in the buffer.
+						 */
+#define PLAYBACK_LIST_SIZE	0x01		/* Size of list in bytes << 16. E.g. 8 periods -> 0x00380000  */
+#define PLAYBACK_LIST_PTR	0x02		/* Pointer to the current period being played */
+#define PLAYBACK_UNKNOWN3	0x03		/* Not used ?? */
 #define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
-#define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size. win2000 uses 0x04000000 */
-#define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
+#define PLAYBACK_PERIOD_SIZE	0x05		/* Playback period size. win2000 uses 0x04000000 */
+#define PLAYBACK_POINTER	0x06		/* Playback period pointer. Used with PLAYBACK_LIST_PTR to determine buffer position currently in DAC */
 #define PLAYBACK_UNKNOWN7	0x07		/* Something used in playback */
 #define PLAYBACK_UNKNOWN8	0x08		/* Something used in playback */
 #define PLAYBACK_UNKNOWN9	0x09		/* Something ?? */
@@ -134,10 +170,7 @@
 #define CAPTURE_BUFFER_SIZE	0x11		/* Capture buffer size */
 #define CAPTURE_POINTER		0x12		/* Capture buffer pointer. Sample currently in ADC */
 #define CAPTURE_UNKNOWN13	0x13		/* Something used in capture */
-#define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
-
-#define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
-#define PLAYBACk_LAST_SAMPLE    0x20		/* The sample currently being played */
+#define PLAYBACK_LAST_SAMPLE    0x20		/* The sample currently being played */
 /* 0x21 - 0x3f unused */
 #define BASIC_INTERRUPT         0x40		/* Used by both playback and capture interrupt handler */
 						/* Playback (0x1<<channel_id) */
@@ -189,6 +222,12 @@
 						/* 0x100 - Front, 0x800 - Rear, 0x200 - Center/LFE.
 						 * But as the jack is shared, use 0xf00.
 						 * The Windows2000 driver uses 0x0000000f for both digital and analog.
+						 * 0xf00 introduces interesting noises onto the Center/LFE.
+						 * If you turn the volume up, you hear computer noise,
+						 * e.g. mouse moving, changing between app windows etc.
+						 * So, I am going to set this to 0x0000000f all the time now,
+						 * same as the windows driver does.
+						 * Use register SPDIF_SELECT2(0x72) to switch between SPDIF and Analog.
 						 */
 #define CAPTURE_SOURCE          0x60            /* Capture Source 0 = MIC */
 #define CAPTURE_SOURCE_CHANNEL0 0xf0000000	/* Mask for selecting the Capture sources */
@@ -242,6 +281,10 @@
 #define PCM_REAR_CHANNEL 1
 #define PCM_CENTER_LFE_CHANNEL 2
 #define PCM_UNKNOWN_CHANNEL 3
+#define CONTROL_FRONT_CHANNEL 0
+#define CONTROL_REAR_CHANNEL 3
+#define CONTROL_CENTER_LFE_CHANNEL 1
+#define CONTROL_UNKNOWN_CHANNEL 2
 
 typedef struct snd_audigyls_voice audigyls_voice_t;
 typedef struct snd_audigyls_channel audigyls_channel_t;
@@ -297,7 +340,8 @@
 	audigyls_channel_t channels[4];
 	audigyls_channel_t capture_channel;
 	u32 spdif_bits[4];             /* s/pdif out setup */
-	int digital_analog;
+	int spdif_enable;
+	int capture_source;
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer buffer;
@@ -316,8 +360,8 @@
 	.rates =		SNDRV_PCM_RATE_48000,
 	.rate_min =		48000,
 	.rate_max =		48000,
-	.channels_min =		1,
-	.channels_max =		6,
+	.channels_min =		2,  //1,
+	.channels_max =		2,  //6,
 	.buffer_bytes_max =	(32*1024),
 	.period_bytes_min =	64,
 	.period_bytes_max =	(16*1024),
@@ -641,17 +685,27 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	int voice = epcm->voice->number;
-        voice=epcm->channel_id;
+	int voice = voice=epcm->channel_id;
+	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*voice));
+	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
+	int i;
 	
-        //printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
-	snd_audigyls_ptr_write(emu, 0x00, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x01, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x02, voice, 0);
+        //snd_printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
+	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+	/* FIXME: Check emu->buffer.size before actually writing to it. */
+        for(i=0; i < runtime->periods; i++) {
+		table_base[i*2]=runtime->dma_addr+(i*period_size_bytes);
+		table_base[(i*2)+1]=period_size_bytes<<16;
+	}
+ 
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, emu->buffer.addr+(8*16*voice));
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_SIZE, voice, (runtime->periods - 1) << 19);
+	snd_audigyls_ptr_write(emu, PLAYBACK_LIST_PTR, voice, 0);
 	snd_audigyls_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
-	snd_audigyls_ptr_write(emu, PLAYBACK_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_audigyls_ptr_write(emu, PLAYBACK_PERIOD_SIZE, voice, frames_to_bytes(runtime, runtime->period_size)<<16); // buffer size in bytes
 	snd_audigyls_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
-	snd_audigyls_ptr_write(emu, 0x07, voice, 0);
+	snd_audigyls_ptr_write(emu, 0x07, voice, 0x0);
 	snd_audigyls_ptr_write(emu, 0x08, voice, 0);
         snd_audigyls_ptr_write(emu, PLAYBACK_MUTE, 0x0, 0x0); /* Unmute output */
 #if 0
@@ -683,7 +737,6 @@
 	snd_audigyls_ptr_write(emu, CAPTURE_DMA_ADDR, voice, runtime->dma_addr);
 	snd_audigyls_ptr_write(emu, CAPTURE_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_audigyls_ptr_write(emu, CAPTURE_POINTER, voice, 0);
-        snd_audigyls_ptr_write(emu, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC or Line in */
 	snd_audigyls_ptr_write(emu, EXTENDED_INT_MASK, 0, snd_audigyls_ptr_read(emu, EXTENDED_INT_MASK, 0) | (0x110000<<voice));
 
 	return 0;
@@ -752,15 +805,19 @@
 	audigyls_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	audigyls_pcm_t *epcm = runtime->private_data;
-	snd_pcm_uframes_t ptr, ptr1, ptr2 = 0;
+	snd_pcm_uframes_t ptr, ptr1, ptr2,ptr3,ptr4 = 0;
 	int channel = epcm->voice->number;
         channel=epcm->channel_id;
 
 	if (!epcm->running)
 		return 0;
 
+	ptr3 = snd_audigyls_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
 	ptr1 = snd_audigyls_ptr_read(emu, PLAYBACK_POINTER, channel);
+	ptr4 = snd_audigyls_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
+	if (ptr3 != ptr4) ptr1 = snd_audigyls_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr2 = bytes_to_frames(runtime, ptr1);
+	ptr2+= (ptr4 >> 3) * runtime->period_size;
 	ptr=ptr2;
         if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
@@ -901,7 +958,8 @@
 		snd_audigyls_ptr_write(chip, EXTENDED_INT_MASK, 0, 0);
 		udelay(1000);
 		// disable audio
-		outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		//outl(HCFG_LOCKSOUNDCACHE, chip->port + HCFG);
+		outl(0, chip->port + HCFG);
 		/* FIXME: We need to stop and DMA transfers here.
 		 *        But as I am not sure how yet, we cannot from the dma pages.
 		 * So we can fix: snd-malloc: Memory leak?  pages not freed = 8
@@ -953,7 +1011,7 @@
 		return IRQ_NONE;
 
 	//printk(KERN_INFO "interrupt status = %08x, chip=%p, channel=%p\n", status,chip, chip->channels);
-        stat76 = snd_audigyls_ptr_read(chip, 0x76, 0);
+        stat76 = snd_audigyls_ptr_read(chip, EXTENDED_INT, 0);
 	//mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
         mask = 0x11; /* 0x1 for one half, 0x10 for the other half period. */
 	for(i = 0; i < 4; i++) {
@@ -977,7 +1035,7 @@
                 }
         }
 
-        snd_audigyls_ptr_write(chip, 0x76, 0, stat76);
+        snd_audigyls_ptr_write(chip, EXTENDED_INT, 0, stat76);
 	spin_lock(&chip->emu_lock);
 	// acknowledge the interrupt if necessary
 	outl(status, chip->port+IPR);
@@ -1037,7 +1095,7 @@
 		if ((err = snd_pcm_lib_preallocate_pages(substream, 
 							 SNDRV_DMA_TYPE_DEV, 
 							 snd_dma_pci_data(emu->pci), 
-							 32*1024, 32*1024)) < 0)
+							 64*1024, 64*1024)) < 0) /* FIXME: 32*1024 for sound buffer, between 32and64 for Periods table. */
 			return err;
 	}
 
@@ -1090,8 +1148,8 @@
 	spin_lock_init(&chip->voice_lock);
   
 	chip->port = pci_resource_start(pci, 0);
-	if ((chip->res_port = request_region(chip->port, 8,
-					     "My Chip")) == NULL) { 
+	if ((chip->res_port = request_region(chip->port, 0x20,
+					     "snd_audigyls")) == NULL) { 
 		snd_audigyls_free(chip);
 		printk(KERN_ERR "cannot allocate the port\n");
 		return -EBUSY;
@@ -1109,8 +1167,8 @@
 	memset(&chip->dma_dev, 0, sizeof(chip->dma_dev));
 	chip->dma_dev.type = SNDRV_DMA_TYPE_DEV;
 	chip->dma_dev.dev = snd_dma_pci_data(pci);
-  
-	if(snd_dma_alloc_pages(&chip->dma_dev, 32 * 1024, &chip->buffer) < 0) {
+ 	/* This stores the periods table. */ 
+	if(snd_dma_alloc_pages(&chip->dma_dev, 1024, &chip->buffer) < 0) {
 		snd_audigyls_free(chip);
 		return -ENOMEM;
 	}
@@ -1188,12 +1246,13 @@
 	//snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0xf0f003f); /* OSS drivers set this. */
 	/* Analog or Digital output */
 	snd_audigyls_ptr_write(chip, SPDIF_SELECT1, 0, 0xf);
-	snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0x0b000000); /* 0x000b0000 for analog, from win2000 drivers */
-	chip->digital_analog = 0; /* Set digital SPDIF output on */
+	snd_audigyls_ptr_write(chip, SPDIF_SELECT2, 0, 0x000b0000); /* 0x0b000000 for digital, 0x000b0000 for analog, from win2000 drivers */
+	chip->spdif_enable = 0; /* Set digital SPDIF output off */
+	chip->capture_source = 3; /* Set CAPTURE_SOURCE */
 	//snd_audigyls_ptr_write(chip, 0x45, 0, 0); /* Analogue out */
 	//snd_audigyls_ptr_write(chip, 0x45, 0, 0xf00); /* Digital out */
 
-	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c80000); /* goes to 0x40c81000 when not doing SPDIF IN/OUT */
+	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 0, 0x40c81000); /* goes to 0x40c80000 when doing SPDIF IN/OUT */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 1, 0xffffffff); /* (Mute) CAPTURE feedback into PLAYBACK volume. Only lower 16 bits matter. */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 2, 0x30300000); /* SPDIF IN Volume */
 	snd_audigyls_ptr_write(chip, CAPTURE_CONTROL, 3, 0x00700000); /* SPDIF IN Volume, 0x70 = (vol & 0x3f) | 0x40 */
@@ -1204,16 +1263,20 @@
 	for(ch = 0; ch < 4; ch++) {
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME1, ch, 0x30303030); /* Only high 16 bits matter */
 		snd_audigyls_ptr_write(chip, CAPTURE_VOLUME2, ch, 0x30303030);
-		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0x30303030);
-		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0x30303030);
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME1, ch, 0xffffffff); /* Mute */
+		snd_audigyls_ptr_write(chip, PLAYBACK_VOLUME2, ch, 0xffffffff); /* Mute */
 	}
         snd_audigyls_ptr_write(chip, CAPTURE_SOURCE, 0x0, 0x333300e4); /* Select MIC, Line in, TAD in, AUX in */
+	chip->capture_source = 3; /* Set CAPTURE_SOURCE */
 
-	outl(0, chip->port+0x18);
-	snd_audigyls_intr_enable(chip, 0x105);
-
-	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
+	//outl(0, chip->port+GPIO);
+	outl(0x005f03a3, chip->port+GPIO); /* Analog */
+	//outl(0x005f02a2, chip->port+GPIO);   /* SPDIF */
+	snd_audigyls_intr_enable(chip, 0x105); /* Win2000 uses 0x1e0 */
 
+	//outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
+	outl(0x00001409, chip->port+HCFG);
+	
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
 				  chip, &ops)) < 0) {
 		snd_audigyls_free(chip);
@@ -1345,14 +1408,10 @@
 
 static int snd_audigyls_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
-	static char *texts[2] = { "Digital", "Analog " };
-
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-                uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
 	return 0;
 }
 
@@ -1361,7 +1420,7 @@
 {
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.enumerated.item[0] = emu->digital_analog;
+	ucontrol->value.enumerated.item[0] = emu->spdif_enable;
 	return 0;
 }
 
@@ -1371,23 +1430,29 @@
 	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
 	int change = 0;
+	u32 mask;
 
 	val = ucontrol->value.enumerated.item[0] ;
-	change = (emu->digital_analog != val);
+	change = (emu->spdif_enable != val);
 	if (change) {
-		emu->digital_analog = val;
-		if (val == 0) {
+		emu->spdif_enable = val;
+		if (val == 1) {
 			/* Digital */
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf);
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x0b000000);
 			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
 				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) & ~0x1000);
+			mask = inl(emu->port + GPIO) & ~0x101;
+			outl(mask, emu->port + GPIO);
+
 		} else {
 			/* Analog */
-			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf00);
+			snd_audigyls_ptr_write(emu, SPDIF_SELECT1, 0, 0xf);
 			snd_audigyls_ptr_write(emu, SPDIF_SELECT2, 0, 0x000b0000);
 			snd_audigyls_ptr_write(emu, CAPTURE_CONTROL, 0,
 				snd_audigyls_ptr_read(emu, CAPTURE_CONTROL, 0) | 0x1000);
+			mask = inl(emu->port + GPIO) | 0x101;
+			outl(mask, emu->port + GPIO);
 		}
 	}
         return change;
@@ -1396,12 +1461,63 @@
 static snd_kcontrol_new_t snd_audigyls_shared_spdif __devinitdata =
 {
 	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name =		"Analog/Digital Output Jack",
+	.name =		"SPDIF Out",
 	.info =		snd_audigyls_shared_spdif_info,
 	.get =		snd_audigyls_shared_spdif_get,
 	.put =		snd_audigyls_shared_spdif_put
 };
 
+static int snd_audigyls_capture_source_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	static char *texts[4] = { "SPDIF      ", "What U Hear", "Unknown    ", "AC97       " };
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item > 3)
+                uinfo->value.enumerated.item = 3;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_audigyls_capture_source_get(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = emu->capture_source;
+	return 0;
+}
+
+static int snd_audigyls_capture_source_put(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	int change = 0;
+	u32 mask;
+	u32 source;
+
+	val = ucontrol->value.enumerated.item[0] ;
+	change = (emu->capture_source != val);
+	if (change) {
+		emu->capture_source = val;
+		source = (val << 28) | (val << 24) | (val << 20) | (val << 16);
+		mask = snd_audigyls_ptr_read(emu, CAPTURE_SOURCE, 0) & 0xffff;
+		snd_audigyls_ptr_write(emu, CAPTURE_SOURCE, 0, source | mask);
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_audigyls_capture_source __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Capture Source",
+	.info =		snd_audigyls_capture_source_info,
+	.get =		snd_audigyls_capture_source_get,
+	.put =		snd_audigyls_capture_source_put
+};
+
 static int snd_audigyls_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
@@ -1472,7 +1588,7 @@
         .put =          snd_audigyls_spdif_put
 };
 
-static int snd_audigyls_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo, int channel_id)
+static int snd_audigyls_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
         uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
         uinfo->count = 2;
@@ -1480,31 +1596,6 @@
         uinfo->value.integer.max = 255;
         return 0;
 }
-static int snd_audigyls_volume_info_front(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_FRONT_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_center_lfe(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_unknown(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_UNKNOWN_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_rear(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = PCM_REAR_CHANNEL;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
-static int snd_audigyls_volume_info_feedback(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
-{
-	int channel_id = 1;
-        return snd_audigyls_volume_info(kcontrol, uinfo, channel_id);
-}
 
 static int snd_audigyls_volume_get(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol, int reg, int channel_id)
@@ -1518,35 +1609,65 @@
         return 0;
 }
 
-static int snd_audigyls_volume_get_front(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_front(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_FRONT_CHANNEL;
+	int channel_id = CONTROL_FRONT_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
 
-static int snd_audigyls_volume_get_center_lfe(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_get_unknown(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_UNKNOWN_CHANNEL;
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_get_rear(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_get_spdif_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_REAR_CHANNEL;
+	int channel_id = CONTROL_REAR_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_audigyls_volume_get_analog_front(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_FRONT_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+
+static int snd_audigyls_volume_get_analog_center_lfe(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_get_analog_unknown(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_get_analog_rear(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_REAR_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_get(kcontrol, ucontrol, reg, channel_id);
+}
+
 static int snd_audigyls_volume_get_feedback(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
@@ -1567,34 +1688,63 @@
         snd_audigyls_ptr_write(emu, reg, channel_id, value);
         return 1;
 }
-static int snd_audigyls_volume_put_front(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_front(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_FRONT_CHANNEL;
+	int channel_id = CONTROL_FRONT_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_center_lfe(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_center_lfe(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_CENTER_LFE_CHANNEL;
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_unknown(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_unknown(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_UNKNOWN_CHANNEL;
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
-static int snd_audigyls_volume_put_rear(snd_kcontrol_t * kcontrol,
+static int snd_audigyls_volume_put_spdif_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
-	int channel_id = PCM_REAR_CHANNEL;
+	int channel_id = CONTROL_REAR_CHANNEL;
 	int reg = PLAYBACK_VOLUME1;
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_audigyls_volume_put_analog_front(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_FRONT_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_center_lfe(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_CENTER_LFE_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_unknown(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_UNKNOWN_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+static int snd_audigyls_volume_put_analog_rear(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	int channel_id = CONTROL_REAR_CHANNEL;
+	int reg = PLAYBACK_VOLUME2;
+        return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
+}
+
 static int snd_audigyls_volume_put_feedback(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
@@ -1603,43 +1753,76 @@
         return snd_audigyls_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
 
-static snd_kcontrol_new_t snd_audigyls_volume_control_front =
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_front =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "Analog Front Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_front,
+        .put =          snd_audigyls_volume_put_analog_front
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_center_lfe =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Front Volume",
-        .info =         snd_audigyls_volume_info_front,
-        .get =          snd_audigyls_volume_get_front,
-        .put =          snd_audigyls_volume_put_front
+        .name =         "Analog Center/LFE Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_center_lfe,
+        .put =          snd_audigyls_volume_put_analog_center_lfe
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_center_lfe =
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_unknown =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Center/LFE Volume",
-        .info =         snd_audigyls_volume_info_center_lfe,
-        .get =          snd_audigyls_volume_get_center_lfe,
-        .put =          snd_audigyls_volume_put_center_lfe
+        .name =         "Analog Unknown Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_unknown,
+        .put =          snd_audigyls_volume_put_analog_unknown
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_unknown =
+static snd_kcontrol_new_t snd_audigyls_volume_control_analog_rear =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Unknown Volume",
-        .info =         snd_audigyls_volume_info_unknown,
-        .get =          snd_audigyls_volume_get_unknown,
-        .put =          snd_audigyls_volume_put_unknown
+        .name =         "Analog Rear Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_analog_rear,
+        .put =          snd_audigyls_volume_put_analog_rear
 };
-static snd_kcontrol_new_t snd_audigyls_volume_control_rear =
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_front =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         "PCM Rear Volume",
-        .info =         snd_audigyls_volume_info_rear,
-        .get =          snd_audigyls_volume_get_rear,
-        .put =          snd_audigyls_volume_put_rear
+        .name =         "SPDIF Front Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_front,
+        .put =          snd_audigyls_volume_put_spdif_front
 };
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_center_lfe =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "SPDIF Center/LFE Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_center_lfe,
+        .put =          snd_audigyls_volume_put_spdif_center_lfe
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_unknown =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "SPDIF Unknown Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_unknown,
+        .put =          snd_audigyls_volume_put_spdif_unknown
+};
+static snd_kcontrol_new_t snd_audigyls_volume_control_spdif_rear =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "SPDIF Rear Volume",
+        .info =         snd_audigyls_volume_info,
+        .get =          snd_audigyls_volume_get_spdif_rear,
+        .put =          snd_audigyls_volume_put_spdif_rear
+};
+
 static snd_kcontrol_new_t snd_audigyls_volume_control_feedback =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
         .name =         "CAPTURE feedback into PLAYBACK",
-        .info =         snd_audigyls_volume_info_feedback,
+        .info =         snd_audigyls_volume_info,
         .get =          snd_audigyls_volume_get_feedback,
         .put =          snd_audigyls_volume_put_feedback
 };
@@ -1664,7 +1847,6 @@
 	return snd_ctl_find_id(card, &sid);
 }
 
-#if 0
 static int rename_ctl(snd_card_t *card, const char *src, const char *dst)
 {
 	snd_kcontrol_t *kctl = ctl_find(card, src);
@@ -1674,26 +1856,86 @@
 	}
 	return -ENOENT;
 }
-#endif
 
 static int __devinit snd_audigyls_mixer(audigyls_t *emu)
 {
         int err;
         snd_kcontrol_t *kctl;
         snd_card_t *card = emu->card;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_front, emu)) == NULL)
+	char **c;
+	static char *audigyls_remove_ctls[] = {
+		"Master Mono Playback Switch",
+		"Master Mono Playback Volume",
+		"3D Control - Switch",
+		"3D Control Sigmatel - Depth",
+		"PCM Playback Switch",
+		"PCM Playback Volume",
+		"CD Playback Switch",
+		"CD Playback Volume",
+		"Phone Playback Switch",
+		"Phone Playback Volume",
+		"Video Playback Switch",
+		"Video Playback Volume",
+		"PC Speaker Playback Switch",
+		"PC Speaker Playback Volume",
+		"Mono Output Select",
+		"Capture Source",
+		"Capture Switch",
+		"Capture Volume",
+		"External Amplifier",
+		"Sigmatel 4-Speaker Stereo Playback Switch",
+		"Sigmatel Surround Phase Inversion Playback ",
+		NULL
+	};
+	static char *audigyls_rename_ctls[] = {
+		"Master Playback Switch", "Capture Switch",
+		"Master Playback Volume", "Capture Volume",
+		"Line Playback Switch", "AC97 Line Capture Switch",
+		"Line Playback Volume", "AC97 Line Capture Volume",
+		"Aux Playback Switch", "AC97 Aux Capture Switch",
+		"Aux Playback Volume", "AC97 Aux Capture Volume",
+		"Mic Playback Switch", "AC97 Mic Capture Switch",
+		"Mic Playback Volume", "AC97 Mic Capture Volume",
+		"Mic Select", "AC97 Mic Select",
+		"Mic Boost (+20dB)", "AC97 Mic Boost (+20dB)",
+		NULL
+	};
+#if 1
+	for (c=audigyls_remove_ctls; *c; c++)
+		remove_ctl(card, *c);
+	for (c=audigyls_rename_ctls; *c; c += 2)
+		rename_ctl(card, c[0], c[1]);
+#endif
+
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_front, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_rear, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_center_lfe, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_analog_unknown, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_front, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_rear, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_rear, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_center_lfe, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_center_lfe, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_spdif_unknown, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
@@ -1709,6 +1951,10 @@
 		return -ENOMEM;
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
+	if ((kctl = snd_ctl_new1(&snd_audigyls_capture_source, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
 	if ((kctl = ctl_find(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT))) != NULL) {
 		/* already defined by ac97, remove it */
 		/* FIXME: or do we need both controls? */

--------------080205050501080900080505--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
