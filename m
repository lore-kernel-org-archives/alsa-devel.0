From: fmoraes@nc.rr.com
Subject: [PATCH] emu10k1x.c updates
Date: Sun, 27 Jun 2004 10:57:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1df18991deed72.1deed721df1899@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_kQdf4RtaflDfx9rxUTspQw)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-language: en
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Boundary_(ID_kQdf4RtaflDfx9rxUTspQw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

- added capture support
- added S/PDIF support (untested)
- fixed interrupt bug when playing multiple channels
- split channels into separate PCMs
- documented some of the registers

I will be looking at some of the other features found on the AudigyLS.

Francisco

--Boundary_(ID_kQdf4RtaflDfx9rxUTspQw)
Content-type: text/plain; NAME=alsa-driver.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=alsa-driver.txt

Index: alsa-driver/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.3
diff -u -r1.3 emu10k1x.c
--- alsa-driver/pci/emu10k1/emu10k1x.c	25 May 2004 12:22:31 -0000	1.3
+++ alsa-driver/pci/emu10k1/emu10k1x.c	27 Jun 2004 14:28:06 -0000
@@ -2,11 +2,18 @@
  *  Copyright (c) by Francisco Moraes <fmoraes@nc.rr.com>
  *  Driver EMU10K1X chips
  *
+ *  Parts of this code were adapted from audigyls.c driver which is
+ *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
+ *
  *  BUGS:
  *    --
  *
  *  TODO:
- *    --
+ *    MIDI support
+ *
+ *  Chips (SB0200 model):
+ *    - EMU10K1X-DBQ
+ *    - STAC 9708T
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -74,10 +81,14 @@
 						/* the relevant bits and zero to the other bits	*/
 #define IPR_CH_0_LOOP           0x00000800      /* Channel 0 loop                               */
 #define IPR_CH_0_HALF_LOOP      0x00000100      /* Channel 0 half loop                          */
+#define IPR_CAP_0_LOOP          0x00080000      /* Channel capture loop                               */
+#define IPR_CAP_0_HALF_LOOP     0x00010000      /* Channel capture half loop                          */
 
 #define INTE			0x0c		/* Interrupt enable register			*/
 #define INTE_CH_0_LOOP          0x00000800      /* Channel 0 loop                               */
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
+#define INTE_CAP_0_LOOP         0x00080000      /* Channel capture loop                               */
+#define INTE_CAP_0_HALF_LOOP    0x00010000      /* Channel capture half loop                          */
 
 #define HCFG			0x14		/* Hardware config register			*/
 
@@ -92,6 +103,33 @@
 
 #define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
 
+/********************************************************************************************************/
+/* Emu10k1x pointer-offset register set, accessed through the PTR and DATA registers			*/
+/********************************************************************************************************/
+#define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
+#define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size */
+#define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
+
+/* Only one capture channel supported */
+#define CAPTURE_DMA_ADDR	0x10		/* Capture DMA address */
+#define CAPTURE_BUFFER_SIZE	0x11		/* Capture buffer size */
+#define CAPTURE_POINTER		0x12		/* Capture buffer pointer. Sample currently in ADC */
+
+/* From 0x20 - 0x3f, last samples played on each channel */
+
+#define TRIGGER_CHANNEL         0x40            /* Trigger channel playback                     */
+#define TRIGGER_CHANNEL_0       0x00000001      /* Trigger channel 0                            */
+#define TRIGGER_CHANNEL_1       0x00000002      /* Trigger channel 1                            */
+#define TRIGGER_CHANNEL_2       0x00000004      /* Trigger channel 2                            */
+#define TRIGGER_CAPTURE         0x00000100      /* Trigger capture channel                      */
+
+#define ROUTING                 0x41            /* Setup sound routing ?                        */
+#define ROUTING_FRONT_LEFT      0x00000001
+#define ROUTING_FRONT_RIGHT     0x00000002
+#define ROUTING_REAR_LEFT       0x00000004
+#define ROUTING_REAR_RIGHT      0x00000008
+#define ROUTING_CENTER_LFE      0x00010000
+
 #define SPCS0			0x42		/* SPDIF output Channel Status 0 register	*/
 
 #define SPCS1			0x43		/* SPDIF output Channel Status 1 register	*/
@@ -122,6 +160,23 @@
 #define SPCS_NOTAUDIODATA	0x00000002	/* 0 = Digital audio, 1 = not audio		*/
 #define SPCS_PROFESSIONAL	0x00000001	/* 0 = Consumer (IEC-958), 1 = pro (AES3-1992)	*/
 
+#define SPDIF_SELECT		0x45		/* Enables SPDIF or Analogue outputs 0-Analogue, 0x700-SPDIF */
+
+/**
+ * The hardware has 3 channels for playback and 1 for capture.
+ *  - channel 0 is the front channel
+ *  - channel 1 is the rear channel
+ *  - channel 2 is the center/lfe chanel
+ * Volume is controlled by the AC97 for the front and rear channels by
+ * the PCM Playback Volume, Sigmatel Surround Playback Volume and 
+ * Surround Playback Volume. The Sigmatel 4-Speaker Stereo switch affects
+ * the front/rear channel mixing in the REAR OUT jack. When using the
+ * 4-Speaker Stereo, both front and rear channels will be mixed in the
+ * REAR OUT.
+ * The center/lfe channel has no volume control and cannot be muted during
+ * playback.
+ */
+
 #define chip_t emu10k1x_t
 
 typedef struct snd_emu10k1x_voice emu10k1x_voice_t;
@@ -164,6 +219,8 @@
 	snd_pcm_t *pcm;
 
 	emu10k1x_voice_t voices[3];
+	emu10k1x_voice_t capture_voice;
+	u32 spdif_bits[3]; // SPDIF out setup
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer buffer;
@@ -186,7 +243,26 @@
 	.channels_max =		2,
 	.buffer_bytes_max =	(32*1024),
 	.period_bytes_min =	64,
-	.period_bytes_max =	(32*1024),
+	.period_bytes_max =	(16*1024),
+	.periods_min =		2,
+	.periods_max =		2,
+	.fifo_size =		0,
+};
+
+static snd_pcm_hardware_t snd_emu10k1x_capture_hw = {
+	.info =			(SNDRV_PCM_INFO_MMAP | 
+				 SNDRV_PCM_INFO_INTERLEAVED |
+				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+				 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
+	.rates =		SNDRV_PCM_RATE_48000,
+	.rate_min =		48000,
+	.rate_max =		48000,
+	.channels_min =		2,
+	.channels_max =		2,
+	.buffer_bytes_max =	(32*1024),
+	.period_bytes_min =	64,
+	.period_bytes_max =	(16*1024),
 	.periods_min =		2,
 	.periods_max =		2,
 	.fifo_size =		0,
@@ -235,16 +311,14 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-static int voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice)
+static int voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
 {
 	emu10k1x_voice_t *voice;
-	int idx;
+	int idx = id;
 
 	*rvoice = NULL;
-	for (idx = 0; idx < 3; idx ++) {
-		voice = &emu->voices[idx];
-		if (voice->use)
-			continue;
+	voice = &emu->voices[idx];
+	if (!voice->use) {
 		voice->use = 1;
 		*rvoice = voice;
 		return 0;
@@ -252,16 +326,16 @@
 	return -ENOMEM;
 }
 
-static int snd_emu10k1x_voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice)
+static int snd_emu10k1x_voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
 {
-	unsigned long flags;
+  unsigned long flags;
 	int result;
   
 	snd_assert(rvoice != NULL, return -EINVAL);
 
 	spin_lock_irqsave(&emu->voice_lock, flags);
   
-	result = voice_alloc(emu, rvoice);
+	result = voice_alloc(emu, rvoice, id);
 
 	spin_unlock_irqrestore(&emu->voice_lock, flags);
   
@@ -294,16 +368,16 @@
 static void snd_emu10k1x_pcm_interrupt(emu10k1x_t *emu, emu10k1x_voice_t *voice)
 {
 	emu10k1x_pcm_t *epcm;
-  
+
 	if ((epcm = voice->epcm) == NULL)
 		return;
 	if (epcm->substream == NULL)
 		return;
 #if 0
-	printk("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
-	       epcm->substream->runtime->hw->pointer(emu, epcm->substream),
-	       snd_pcm_lib_period_bytes(epcm->substream),
-	       snd_pcm_lib_buffer_bytes(epcm->substream));
+	snd_printk("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
+		   epcm->substream->ops->pointer(epcm->substream),
+		   snd_pcm_lib_period_bytes(epcm->substream),
+		   snd_pcm_lib_buffer_bytes(epcm->substream));
 #endif
 	snd_pcm_period_elapsed(epcm->substream);
 }
@@ -344,8 +418,10 @@
 	emu10k1x_pcm_t *epcm = snd_magic_cast(emu10k1x_pcm_t, runtime->private_data, return -ENXIO);
 
 	if (! epcm->voice) {
-		if ((err = snd_emu10k1x_voice_alloc(epcm->emu, &epcm->voice)) < 0)
+		if ((err = snd_emu10k1x_voice_alloc(epcm->emu, &epcm->voice, substream->pcm->device)) < 0)
 			return err;
+		epcm->voice->use = 1;
+		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
 		epcm->voice->epcm = epcm;
 		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
 	}
@@ -383,11 +459,16 @@
 	snd_emu10k1x_ptr_write(emu, 0x00, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x01, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x02, voice, 0);
-	snd_emu10k1x_ptr_write(emu, 0x04, voice, runtime->dma_addr);
-	snd_emu10k1x_ptr_write(emu, 0x05, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
-	snd_emu10k1x_ptr_write(emu, 0x06, voice, 0);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x07, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x08, voice, 0);
+	unsigned int value = snd_emu10k1x_ptr_read(emu, ROUTING, 0);
+	value |= 3 << (2*voice);
+	if(voice == 2)
+	  value |= 0x10000; // enable center/lfe channel this way
+	snd_emu10k1x_ptr_write(emu, ROUTING, 0, value);
 
 	return 0;
 }
@@ -402,14 +483,15 @@
 	int channel = epcm->voice->number;
 	int result = 0;
 
-//	printk("trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
+//	snd_printk("trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1x_ptr_write(emu, 0x40, 0, snd_emu10k1x_ptr_read(emu, 0x40, 0)|(1<<channel));
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|(TRIGGER_CHANNEL_0<<channel));
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_emu10k1x_ptr_write(emu, 0x40, 0, snd_emu10k1x_ptr_read(emu, 0x40, 0) & ~(1<<channel));
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CHANNEL_0<<channel));
 		epcm->running = 0;
 		break;
 	default:
@@ -432,14 +514,13 @@
 	if (!epcm->running)
 		return 0;
 
-	//  printk("pointer: %08X %08X\n", 
-	//	 snd_emu10k1x_ptr_read(emu, 0x06, channel),
-	//	 snd_emu10k1x_ptr_read(emu, 0x12, channel));
-	ptr = bytes_to_frames(runtime, snd_emu10k1x_ptr_read(emu, 0x06, channel));
+//	snd_printk("pointer: %08X\n", 
+//		   snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel));
+	ptr = bytes_to_frames(runtime, snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel));
 	if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
 
-	//	printk("ptr = 0x%x, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
+//	snd_printk("ptr = 0x%x, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
 	return ptr;
 }
 
@@ -455,6 +536,143 @@
 	.pointer =     snd_emu10k1x_pcm_pointer,
 };
 
+/* open_capture callback */
+static int snd_emu10k1x_pcm_open_capture(snd_pcm_substream_t *substream)
+{
+	emu10k1x_t *chip = snd_pcm_substream_chip(substream);
+	emu10k1x_pcm_t *epcm;
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	epcm = snd_magic_kcalloc(emu10k1x_pcm_t, 0, GFP_KERNEL);
+	if (epcm == NULL) {
+		return -ENOMEM;
+        }
+	epcm->emu = chip;
+	epcm->substream = substream;
+  
+	runtime->private_data = epcm;
+	runtime->private_free = snd_emu10k1x_pcm_free_substream;
+  
+	runtime->hw = snd_emu10k1x_capture_hw;
+
+	return 0;
+}
+
+/* close callback */
+static int snd_emu10k1x_pcm_close_capture(snd_pcm_substream_t *substream)
+{
+	return 0;
+}
+
+/* hw_params callback */
+static int snd_emu10k1x_pcm_hw_params_capture(snd_pcm_substream_t *substream,
+				      snd_pcm_hw_params_t * hw_params)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1x_pcm_t *epcm = snd_magic_cast(emu10k1x_pcm_t, runtime->private_data, return -ENXIO);
+
+	if (! epcm->voice) {
+		if (epcm->emu->capture_voice.use)
+			return -1;
+		epcm->voice = &epcm->emu->capture_voice;
+		epcm->voice->epcm = epcm;
+		epcm->voice->use = 1;
+		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
+	}
+
+	return snd_pcm_lib_malloc_pages(substream,
+					params_buffer_bytes(hw_params));
+}
+
+/* hw_free callback */
+static int snd_emu10k1x_pcm_hw_free_capture(snd_pcm_substream_t *substream)
+{
+	snd_pcm_runtime_t *runtime = substream->runtime;
+
+	emu10k1x_pcm_t *epcm;
+
+	if (runtime->private_data == NULL)
+		return 0;
+	epcm = snd_magic_cast(emu10k1x_pcm_t, runtime->private_data, return -ENXIO);
+
+	if (epcm->voice) {
+		epcm->voice->use = 0;
+		epcm->voice->interrupt = NULL;
+		epcm->voice->epcm = NULL;
+		epcm->voice = NULL;
+	}
+
+	return snd_pcm_lib_free_pages(substream);
+}
+
+/* prepare capture callback */
+static int snd_emu10k1x_pcm_prepare_capture(snd_pcm_substream_t *substream)
+{
+	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	//	snd_printk("prepare: rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+	snd_emu10k1x_ptr_write(emu, CAPTURE_DMA_ADDR, 0, runtime->dma_addr);
+	snd_emu10k1x_ptr_write(emu, CAPTURE_BUFFER_SIZE, 0, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
+	snd_emu10k1x_ptr_write(emu, CAPTURE_POINTER, 0, 0);
+
+	return 0;
+}
+
+/* trigger_capture callback */
+static int snd_emu10k1x_pcm_trigger_capture(snd_pcm_substream_t *substream,
+				    int cmd)
+{
+	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1x_pcm_t *epcm = snd_magic_cast(emu10k1x_pcm_t, runtime->private_data, return -ENXIO);
+	int result = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|TRIGGER_CAPTURE);
+		epcm->running = 1;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CAPTURE));
+		epcm->running = 0;
+		break;
+	default:
+		result = -EINVAL;
+		break;
+	}
+	return result;
+}
+
+/* pointer_capture callback */
+static snd_pcm_uframes_t
+snd_emu10k1x_pcm_pointer_capture(snd_pcm_substream_t *substream)
+{
+	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
+	snd_pcm_runtime_t *runtime = substream->runtime;
+	emu10k1x_pcm_t *epcm = snd_magic_cast(emu10k1x_pcm_t, runtime->private_data, return -ENXIO);
+	snd_pcm_uframes_t ptr;
+
+	if (!epcm->running)
+		return 0;
+
+	ptr = bytes_to_frames(runtime, snd_emu10k1x_ptr_read(emu, CAPTURE_POINTER, 0));
+	if (ptr >= runtime->buffer_size)
+		ptr -= runtime->buffer_size;
+
+	return ptr;
+}
+
+static snd_pcm_ops_t snd_emu10k1x_capture_ops = {
+	.open =        snd_emu10k1x_pcm_open_capture,
+	.close =       snd_emu10k1x_pcm_close_capture,
+	.ioctl =       snd_pcm_lib_ioctl,
+	.hw_params =   snd_emu10k1x_pcm_hw_params_capture,
+	.hw_free =     snd_emu10k1x_pcm_hw_free_capture,
+	.prepare =     snd_emu10k1x_pcm_prepare_capture,
+	.trigger =     snd_emu10k1x_pcm_trigger_capture,
+	.pointer =     snd_emu10k1x_pcm_pointer_capture,
+};
+
 static unsigned short snd_emu10k1x_ac97_read(ac97_t *ac97,
 					     unsigned short reg)
 {
@@ -499,7 +717,7 @@
 
 static int snd_emu10k1x_free(emu10k1x_t *chip)
 {
-	snd_emu10k1x_ptr_write(chip, 0x40, 0, 0);
+	snd_emu10k1x_ptr_write(chip, TRIGGER_CHANNEL, 0, 0);
 	// disable interrupts
 	outl(0, chip->port + INTE);
 	// disable audio
@@ -545,8 +763,8 @@
 		return IRQ_NONE;
 
 	mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
+	emu10k1x_voice_t *pvoice = chip->voices;
 	for(i = 0; i < 3; i++) {
-		emu10k1x_voice_t *pvoice = chip->voices;
 		if(status & mask) {
 			if(pvoice->use && pvoice->interrupt)
 				pvoice->interrupt(chip, pvoice);
@@ -554,13 +772,20 @@
 		pvoice++;
 		mask <<= 1;
 	}
+	// capture interrupt
+	if(status & (IPR_CAP_0_LOOP | IPR_CAP_0_HALF_LOOP)) {
+		emu10k1x_voice_t *pvoice = &chip->capture_voice;
+		if(pvoice->use && pvoice->interrupt)
+			pvoice->interrupt(chip, pvoice);
+	}
+
 	spin_lock(&chip->emu_lock);
 	// acknowledge the interrupt if necessary
 	outl(status, chip->port+IPR);
 
 	spin_unlock(&chip->emu_lock);
 
-	//	printk(KERN_INFO "interrupt %08x\n", status);
+//	snd_printk("interrupt %08x\n", status);
 
 	return IRQ_HANDLED;
 }
@@ -577,22 +802,43 @@
 	snd_pcm_t *pcm;
 	snd_pcm_substream_t *substream;
 	int err;
+	int capture = 0;
   
 	if (rpcm)
 		*rpcm = NULL;
-  
-	if ((err = snd_pcm_new(emu->card, "emu10k1x", device, 3, 0, &pcm)) < 0)
+	if (device == 0)
+	  capture = 1;
+	
+	if ((err = snd_pcm_new(emu->card, "emu10k1x", device, 1, capture, &pcm)) < 0)
 		return err;
   
 	pcm->private_data = emu;
 	pcm->private_free = snd_emu10k1x_pcm_free;
-  
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
-	//  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1x_capture_ops);
+	
+	switch(device) {
+	case 0:
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1x_capture_ops);
+	  break;
+	case 1:
+	case 2:
+	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
+	  break;
+	}
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
-	strcpy(pcm->name, "EMU10K1X");
+	switch(device) {
+	case 0:
+	  strcpy(pcm->name, "EMU10K1X Front");
+	  break;
+	case 1:
+	  strcpy(pcm->name, "EMU10K1X Rear");
+	  break;
+	case 2:
+	  strcpy(pcm->name, "EMU10K1X Center/LFE");
+	  break;
+	}
 	emu->pcm = pcm;
 
 	for(substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream; 
@@ -604,15 +850,13 @@
 							 32*1024, 32*1024)) < 0)
 			return err;
 
-	/*
-	  for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
-	  substream; 
-	  substream = substream->next)
-	  snd_pcm_lib_preallocate_pages(substream, 
-	  SNDRV_DMA_TYPE_DEV, 
-	  snd_dma_pci_data(emu->pci), 
-	  64*1024, 64*1024);
-	*/
+	for (substream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream; 
+	     substream; 
+	     substream = substream->next)
+		snd_pcm_lib_preallocate_pages(substream, 
+					      SNDRV_DMA_TYPE_DEV, 
+					      snd_dma_pci_data(emu->pci), 
+					      32*1024, 32*1024);
   
 	if (rpcm)
 		*rpcm = pcm;
@@ -637,7 +881,7 @@
 		return err;
 	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
 	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
-		printk(KERN_ERR "error to set 28bit mask DMA\n");
+		snd_printk(KERN_ERR "error to set 28bit mask DMA\n");
 		return -ENXIO;
 	}
   
@@ -656,7 +900,7 @@
 	if ((chip->res_port = request_region(chip->port, 8,
 					     "My Chip")) == NULL) { 
 		snd_emu10k1x_free(chip);
-		printk(KERN_ERR "cannot allocate the port\n");
+		snd_printk("cannot allocate the port\n");
 		return -EBUSY;
 	}
 
@@ -664,7 +908,7 @@
 			SA_INTERRUPT|SA_SHIRQ, "EMU10K1X",
 			(void *)chip)) {
 		snd_emu10k1x_free(chip);
-		printk(KERN_ERR "cannot grab irq\n");
+		snd_printk("cannot grab irq\n");
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
@@ -683,10 +927,10 @@
 	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&chip->revision);
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
-	printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
-	       chip->revision, chip->serial);
+	snd_printk("Model %04x Rev %08x Serial %08x\n", chip->model,
+		   chip->revision, chip->serial);
 
-	outl(0, chip->port + INTE);
+	outl(0, chip->port + INTE);	
 
 	for(ch = 0; ch < 3; ch++) {
 		chip->voices[ch].emu = chip;
@@ -708,29 +952,34 @@
 	 *  P                 = 0     (Consumer)
 	 */
 	snd_emu10k1x_ptr_write(chip, SPCS0, 0,
+			       chip->spdif_bits[0] = 
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	snd_emu10k1x_ptr_write(chip, SPCS1, 0,
+			       chip->spdif_bits[1] = 
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	snd_emu10k1x_ptr_write(chip, SPCS2, 0,
+			       chip->spdif_bits[2] = 
 			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
 			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
 			       SPCS_GENERATIONSTATUS | 0x00001200 |
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
-	snd_emu10k1x_ptr_write(chip, 0x41, 0, 0x70f); // ???
-	snd_emu10k1x_ptr_write(chip, 0x45, 0, 0);
+	snd_emu10k1x_ptr_write(chip, SPDIF_SELECT, 0, 0x700); // disable SPDIF
+	// verify the next line
+	snd_emu10k1x_ptr_write(chip, ROUTING, 0, 0x10000); // routing
 
 	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
 
 	snd_emu10k1x_intr_enable(chip, (INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP) |
-				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP) << 1) |
-				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP) << 2));
+				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<1) |
+				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<2) |
+				 (INTE_CAP_0_LOOP|INTE_CAP_0_HALF_LOOP));
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
 				  chip, &ops)) < 0) {
@@ -750,30 +999,195 @@
 	int i;
 
 	snd_iprintf(buffer, "Registers:\n\n");
-	for(i = 0; i < 0x40; i+=4) {
+	for(i = 0; i < 0x20; i+=4) {
 		spin_lock_irqsave(&emu->emu_lock, flags);
 		value = inl(emu->port + i);
 		spin_unlock_irqrestore(&emu->emu_lock, flags);
 		snd_iprintf(buffer, "Register %02X: %08lX\n", i, value);
 	}
 	snd_iprintf(buffer, "\nRegisters\n\n");
-	for(i = 0; i < 0x50; i++) {
+	for(i = 0; i <= 0x48; i++) {
 		value = snd_emu10k1x_ptr_read(emu, i, 0);
-		value1 = snd_emu10k1x_ptr_read(emu, i, 1);
-		value2 = snd_emu10k1x_ptr_read(emu, i, 2);
-		snd_iprintf(buffer, "%02X: %08lX %08lX %08lX\n", i, value, value1, value2);
+		if(i < 0x10 || (i >= 0x20 && i < 0x40)) {
+			value1 = snd_emu10k1x_ptr_read(emu, i, 1);
+			value2 = snd_emu10k1x_ptr_read(emu, i, 2);
+			snd_iprintf(buffer, "%02X: %08lX %08lX %08lX\n", i, value, value1, value2);
+		} else {
+			snd_iprintf(buffer, "%02X: %08lX\n", i, value);
+		}
 	}
 }
 
+static void snd_emu10k1x_proc_reg_write(snd_info_entry_t *entry, 
+					snd_info_buffer_t *buffer)
+{
+	emu10k1x_t *emu = snd_magic_cast(emu10k1x_t, entry->private_data, 
+					 return);
+        char line[64];
+        unsigned int reg, channel_id , val;
+        while (!snd_info_get_line(buffer, line, sizeof(line))) {
+                if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
+                        continue;
+		
+                if ((reg < 0x49) && (reg >=0) && (val <= 0xffffffff) 
+		    && (channel_id >=0) && (channel_id <= 2) )
+			snd_emu10k1x_ptr_write(emu, reg, channel_id, val);
+        }
+}
+
 static int __devinit snd_emu10k1x_proc_init(emu10k1x_t * emu)
 {
 	snd_info_entry_t *entry;
 	
-	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry))
+	if(! snd_card_proc_new(emu->card, "emu10k1x_regs", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_emu10k1x_proc_reg_read);
+		entry->c.text.write_size = 64;
+		entry->c.text.write = snd_emu10k1x_proc_reg_write;
+		entry->private_data = emu;
+	}
+	
+	return 0;
+}
+
+static int snd_emu10k1x_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
 	return 0;
 }
 
+static int snd_emu10k1x_shared_spdif_get(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = (snd_emu10k1x_ptr_read(emu, SPDIF_SELECT, 0) == 0x700) ? 0 : 1;
+
+        return 0;
+}
+
+static int snd_emu10k1x_shared_spdif_put(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int val;
+	int change = 0;
+
+	val = ucontrol->value.integer.value[0] ;
+
+	if (val) {
+		// enable spdif output
+		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x000);
+	} else {
+		// disable spdif output
+		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x700);
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_emu10k1x_shared_spdif __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Analog/Digital Output Jack",
+	.info =		snd_emu10k1x_shared_spdif_info,
+	.get =		snd_emu10k1x_shared_spdif_get,
+	.put =		snd_emu10k1x_shared_spdif_put
+};
+
+static int snd_emu10k1x_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_emu10k1x_spdif_get(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	ucontrol->value.iec958.status[0] = (emu->spdif_bits[idx] >> 0) & 0xff;
+	ucontrol->value.iec958.status[1] = (emu->spdif_bits[idx] >> 8) & 0xff;
+	ucontrol->value.iec958.status[2] = (emu->spdif_bits[idx] >> 16) & 0xff;
+	ucontrol->value.iec958.status[3] = (emu->spdif_bits[idx] >> 24) & 0xff;
+        return 0;
+}
+
+static int snd_emu10k1x_spdif_get_mask(snd_kcontrol_t * kcontrol,
+				      snd_ctl_elem_value_t * ucontrol)
+{
+	ucontrol->value.iec958.status[0] = 0xff;
+	ucontrol->value.iec958.status[1] = 0xff;
+	ucontrol->value.iec958.status[2] = 0xff;
+	ucontrol->value.iec958.status[3] = 0xff;
+        return 0;
+}
+
+static int snd_emu10k1x_spdif_put(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	int change;
+	unsigned int val;
+
+	val = (ucontrol->value.iec958.status[0] << 0) |
+	      (ucontrol->value.iec958.status[1] << 8) |
+	      (ucontrol->value.iec958.status[2] << 16) |
+	      (ucontrol->value.iec958.status[3] << 24);
+	change = val != emu->spdif_bits[idx];
+	if (change) {
+		snd_emu10k1x_ptr_write(emu, SPCS0 + idx, 0, val);
+		emu->spdif_bits[idx] = val;
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_emu10k1x_spdif_mask_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
+	.count =	3,
+        .info =         snd_emu10k1x_spdif_info,
+        .get =          snd_emu10k1x_spdif_get_mask
+};
+
+static snd_kcontrol_new_t snd_emu10k1x_spdif_control =
+{
+        .iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.count =	3,
+        .info =         snd_emu10k1x_spdif_info,
+        .get =          snd_emu10k1x_spdif_get,
+        .put =          snd_emu10k1x_spdif_put
+};
+
+static int __devinit snd_emu10k1x_mixer(emu10k1x_t *emu)
+{
+        int err;
+        snd_kcontrol_t *kctl;
+        snd_card_t *card = emu->card;
+
+	if ((kctl = snd_ctl_new1(&snd_emu10k1x_spdif_mask_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	if ((kctl = snd_ctl_new1(&snd_emu10k1x_shared_spdif, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	if ((kctl = snd_ctl_new1(&snd_emu10k1x_spdif_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+
+        return 0;
+}
+
 static int __devinit snd_emu10k1x_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
@@ -802,16 +1216,29 @@
 		snd_card_free(card);
 		return err;
 	}
+	if ((err = snd_emu10k1x_pcm(chip, 1, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	if ((err = snd_emu10k1x_pcm(chip, 2, NULL)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
 
 	if ((err = snd_emu10k1x_ac97(chip)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
+	if ((err = snd_emu10k1x_mixer(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
 	snd_emu10k1x_proc_init(chip);
 
-	strcpy(card->driver, "Dell SB Live");
-	strcpy(card->shortname, "EMU10K1X");
+	strcpy(card->driver, "EMU10K1X");
+	strcpy(card->shortname, "Dell Sound Blaster Live!");
 	sprintf(card->longname, "%s at 0x%lx irq %i",
 		card->shortname, chip->port, chip->irq);
 
@@ -840,7 +1267,7 @@
 
 // pci_driver definition
 static struct pci_driver driver = {
-	.name = "Emu10k1x",
+	.name = "EMU10K1X",
 	.id_table = snd_emu10k1x_ids,
 	.probe = snd_emu10k1x_probe,
 	.remove = __devexit_p(snd_emu10k1x_remove),

--Boundary_(ID_kQdf4RtaflDfx9rxUTspQw)
Content-type: text/plain; NAME=alsa-lib.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=alsa-lib.txt

Index: alsa-lib/src/conf/cards/EMU10K1X.conf
===================================================================
RCS file: alsa-lib/src/conf/cards/EMU10K1X.conf
diff -N alsa-lib/src/conf/cards/EMU10K1X.conf
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-lib/src/conf/cards/EMU10K1X.conf	27 Jun 2004 14:54:05 -0000
@@ -0,0 +1,169 @@
+#
+# Configuration for the EMU10K1X chip
+#
+
+<confdir:pcm/front.conf>
+
+EMU10K1X.pcm.front.0 {
+	@args [ CARD  ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 0
+}	
+
+<confdir:pcm/rear.conf>
+
+EMU10K1X.pcm.rear.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 1
+}	
+
+<confdir:pcm/center_lfe.conf>
+
+EMU10K1X.pcm.center_lfe.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type hw
+	card $CARD
+	device 2
+}	
+
+<confdir:pcm/surround40.conf>
+
+EMU10K1X.pcm.surround40.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.EMU10K1X.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.EMU10K1X.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+	]
+}
+
+<confdir:pcm/surround41.conf>
+<confdir:pcm/surround50.conf>
+<confdir:pcm/surround51.conf>
+
+EMU10K1X.pcm.surround51.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type multi
+	slaves [
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.EMU10K1X.pcm.front.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.EMU10K1X.pcm.rear.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+		{
+			pcm {
+				@func concat
+				strings [
+					"cards.EMU10K1X.pcm.center_lfe.0:CARD=" $CARD
+				]
+			}
+			channels 2
+		}
+	]
+	bindings [
+		{ slave 0 channel 0 }
+		{ slave 0 channel 1 }
+		{ slave 1 channel 0 }
+		{ slave 1 channel 1 }
+		{ slave 2 channel 0 }
+		{ slave 2 channel 1 }
+	]
+}
+
+<confdir:pcm/iec958.conf>
+
+EMU10K1X.pcm.iec958.0 {
+	@args [ CARD AES0 AES1 AES2 AES3 ]
+	@args.CARD {
+		type string
+	}
+	@args.AES0 {
+		type integer
+	}
+	@args.AES1 {
+		type integer
+	}
+	@args.AES2 {
+		type integer
+	}
+	@args.AES3 {
+		type integer
+	}
+	type hooks
+	slave.pcm {
+		type hw
+		card $CARD
+		device 0
+	}
+	hooks.0 {
+		type ctl_elems
+		hook_args [
+			{
+				name "Analog/Digital Output Jack"
+				lock true
+				preserve true
+				value 0
+			}
+			{
+				name "IEC958 Playback Default"
+				index 0
+				lock true
+				preserve true
+				value [ $AES0 $AES1 $AES2 $AES3 ]
+			}
+		]
+	}
+}
Index: alsa-lib/src/conf/cards/Makefile.am
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/Makefile.am,v
retrieving revision 1.22
diff -u -r1.22 Makefile.am
--- alsa-lib/src/conf/cards/Makefile.am	18 Jun 2004 14:29:03 -0000	1.22
+++ alsa-lib/src/conf/cards/Makefile.am	27 Jun 2004 14:54:05 -0000
@@ -13,6 +13,7 @@
 	CMI8738-MC6.conf \
 	CS46xx.conf \
 	EMU10K1.conf \
+	EMU10K1X.conf \
 	ENS1370.conf \
 	ENS1371.conf \
 	FM801.conf \

--Boundary_(ID_kQdf4RtaflDfx9rxUTspQw)--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
