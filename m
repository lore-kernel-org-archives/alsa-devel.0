From: fmoraes@nc.rr.com
Subject: Patch for emu10k1x driver
Date: Thu, 22 Jul 2004 20:02:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <246f46b2470a51.2470a51246f46b@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_iVuevnok8NcQ6ucevENtDw)"
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

--Boundary_(ID_iVuevnok8NcQ6ucevENtDw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Following changes:
- MIDI support
- voice clean up
- delayed interrupt enable/disable
- playback/capture constraints added
- fixed max number of periods

Francisco


--Boundary_(ID_iVuevnok8NcQ6ucevENtDw)
Content-type: text/plain; NAME=patch.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch.txt

Index: alsa-driver/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.10
diff -u -r1.10 emu10k1x.c
--- alsa-driver/pci/emu10k1/emu10k1x.c	12 Jul 2004 14:49:39 -0000	1.10
+++ alsa-driver/pci/emu10k1/emu10k1x.c	22 Jul 2004 23:59:40 -0000
@@ -9,7 +9,6 @@
  *    --
  *
  *  TODO:
- *    MIDI support
  *
  *  Chips (SB0200 model):
  *    - EMU10K1X-DBQ
@@ -41,6 +40,7 @@
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 MODULE_AUTHOR("Francisco Moraes <fmoraes@nc.rr.com>");
 MODULE_DESCRIPTION("EMU10K1X");
@@ -75,12 +75,16 @@
 #define IPR			0x08		/* Global interrupt pending register		*/
 						/* Clear pending interrupts by writing a 1 to	*/
 						/* the relevant bits and zero to the other bits	*/
+#define IPR_MIDITRANSBUFEMPTY   0x00000001	/* MIDI UART transmit buffer empty		*/
+#define IPR_MIDIRECVBUFEMPTY    0x00000002	/* MIDI UART receive buffer empty		*/
 #define IPR_CH_0_LOOP           0x00000800      /* Channel 0 loop                               */
 #define IPR_CH_0_HALF_LOOP      0x00000100      /* Channel 0 half loop                          */
 #define IPR_CAP_0_LOOP          0x00080000      /* Channel capture loop                         */
 #define IPR_CAP_0_HALF_LOOP     0x00010000      /* Channel capture half loop                    */
 
 #define INTE			0x0c		/* Interrupt enable register			*/
+#define INTE_MIDITXENABLE       0x00000001	/* Enable MIDI transmit-buffer-empty interrupts	*/
+#define INTE_MIDIRXENABLE       0x00000002	/* Enable MIDI receive-buffer-empty interrupts	*/
 #define INTE_CH_0_LOOP          0x00000800      /* Channel 0 loop                               */
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
 #define INTE_CAP_0_LOOP         0x00080000      /* Channel capture loop                         */
@@ -112,13 +116,16 @@
 #define PLAYBACK_LIST_SIZE	0x01		/* Size of list in bytes << 16. E.g. 8 periods -> 0x00380000  */
 #define PLAYBACK_LIST_PTR	0x02		/* Pointer to the current period being played */
 #define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
-#define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size */
-#define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
+#define PLAYBACK_PERIOD_SIZE	0x05		/* Playback period size */
+#define PLAYBACK_POINTER	0x06		/* Playback period pointer. Sample currently in DAC */
+#define PLAYBACK_UNKNOWN1       0x07
+#define PLAYBACK_UNKNOWN2       0x08
 
 /* Only one capture channel supported */
 #define CAPTURE_DMA_ADDR	0x10		/* Capture DMA address */
 #define CAPTURE_BUFFER_SIZE	0x11		/* Capture buffer size */
 #define CAPTURE_POINTER		0x12		/* Capture buffer pointer. Sample currently in ADC */
+#define CAPTURE_UNKNOWN         0x13
 
 /* From 0x20 - 0x3f, last samples played on each channel */
 
@@ -197,7 +204,6 @@
 	emu10k1x_t *emu;
 	int number;
 	int use;
-	void (*interrupt)(emu10k1x_t *emu, emu10k1x_voice_t *pvoice);
   
 	emu10k1x_pcm_t *epcm;
 };
@@ -209,6 +215,21 @@
 	unsigned short running;
 };
 
+typedef struct {
+	struct snd_emu10k1x *emu;
+	snd_rawmidi_t *rmidi;
+	snd_rawmidi_substream_t *substream_input;
+	snd_rawmidi_substream_t *substream_output;
+	unsigned int midi_mode;
+	spinlock_t input_lock;
+	spinlock_t output_lock;
+	spinlock_t open_lock;
+	int tx_enable, rx_enable;
+	int port;
+	int ipr_tx, ipr_rx;
+	void (*interrupt)(emu10k1x_t *emu, unsigned int status);
+} emu10k1x_midi_t;
+
 // definition of the chip-specific record
 struct snd_emu10k1x {
 	snd_card_t *card;
@@ -234,6 +255,8 @@
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer dma_buffer;
+
+	emu10k1x_midi_t midi;
 };
 
 /* hardware definition */
@@ -252,7 +275,7 @@
 	.period_bytes_min =	64,
 	.period_bytes_max =	(16*1024),
 	.periods_min =		2,
-	.periods_max =		512,
+	.periods_max =		8,
 	.fifo_size =		0,
 };
 
@@ -318,59 +341,24 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-static void snd_emu10k1x_gpio_write(emu10k1x_t *emu, unsigned int value)
+static void snd_emu10k1x_intr_disable(emu10k1x_t *emu, unsigned int intrenb)
 {
 	unsigned long flags;
-
+	unsigned int enable;
+  
 	spin_lock_irqsave(&emu->emu_lock, flags);
-	outl(value, emu->port + GPIO);
+	enable = inl(emu->port + INTE) & ~intrenb;
+	outl(enable, emu->port + INTE);
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-static int voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
-{
-	emu10k1x_voice_t *voice;
-	int idx = id;
-
-	*rvoice = NULL;
-	voice = &emu->voices[idx];
-	if (!voice->use) {
-		voice->use = 1;
-		*rvoice = voice;
-		return 0;
-	}
-	return -ENOMEM;
-}
-
-static int snd_emu10k1x_voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
-{
-	unsigned long flags;
-	int result;
-  
-	snd_assert(rvoice != NULL, return -EINVAL);
-
-	spin_lock_irqsave(&emu->voice_lock, flags);
-  
-	result = voice_alloc(emu, rvoice, id);
-
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
-  
-	return result;
-}
-
-static int snd_emu10k1x_voice_free(emu10k1x_t *emu, emu10k1x_voice_t *pvoice)
+static void snd_emu10k1x_gpio_write(emu10k1x_t *emu, unsigned int value)
 {
 	unsigned long flags;
-  
-	snd_assert(pvoice != NULL, return -EINVAL);
-	spin_lock_irqsave(&emu->voice_lock, flags);
 
-	pvoice->interrupt = NULL;
-	pvoice->use = 0;
-	pvoice->epcm = NULL;
-
-	spin_unlock_irqrestore(&emu->voice_lock, flags);
-	return 0;
+	spin_lock_irqsave(&emu->emu_lock, flags);
+	outl(value, emu->port + GPIO);
+	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
 static void snd_emu10k1x_pcm_free_substream(snd_pcm_runtime_t *runtime)
@@ -404,6 +392,13 @@
 	emu10k1x_t *chip = snd_pcm_substream_chip(substream);
 	emu10k1x_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	int err;
+
+	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
+		return err;
+	}
+	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+                return err;
 
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL)
@@ -429,17 +424,13 @@
 static int snd_emu10k1x_pcm_hw_params(snd_pcm_substream_t *substream,
 				      snd_pcm_hw_params_t * hw_params)
 {
-	int err;
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1x_pcm_t *epcm = runtime->private_data;
 
 	if (! epcm->voice) {
-		if ((err = snd_emu10k1x_voice_alloc(epcm->emu, &epcm->voice, substream->pcm->device)) < 0)
-			return err;
+		epcm->voice = &epcm->emu->voices[substream->pcm->device];
 		epcm->voice->use = 1;
-		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
 		epcm->voice->epcm = epcm;
-		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
 	}
 
 	return snd_pcm_lib_malloc_pages(substream,
@@ -458,7 +449,8 @@
 	epcm = runtime->private_data;
 
 	if (epcm->voice) {
-		snd_emu10k1x_voice_free(epcm->emu, epcm->voice);
+		epcm->voice->use = 0;
+		epcm->voice->epcm = NULL;
 		epcm->voice = NULL;
 	}
 
@@ -472,7 +464,7 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1x_pcm_t *epcm = runtime->private_data;
 	int voice = epcm->voice->number;
-	u32 *table_base = (u32 *)(emu->dma_buffer.area+4096*voice);
+	u32 *table_base = (u32 *)(emu->dma_buffer.area+1024*voice);
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	int i;
 	
@@ -480,15 +472,16 @@
 		*table_base++=runtime->dma_addr+(i*period_size_bytes);
 		*table_base++=period_size_bytes<<16;
 	}
- 
-	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, emu->dma_buffer.addr+4096*voice);
+
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, emu->dma_buffer.addr+1024*voice);
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_SIZE, voice, (runtime->periods - 1) << 19);
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_PTR, voice, 0);
-	snd_emu10k1x_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
-	snd_emu10k1x_ptr_write(emu, PLAYBACK_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
-	snd_emu10k1x_ptr_write(emu, 0x07, voice, 0);
-	snd_emu10k1x_ptr_write(emu, 0x08, voice, 0);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_UNKNOWN1, voice, 0);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_UNKNOWN2, voice, 0);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
+
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_PERIOD_SIZE, voice, frames_to_bytes(runtime, runtime->period_size)<<16);
 
 	return 0;
 }
@@ -507,12 +500,17 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|(TRIGGER_CHANNEL_0<<channel));
+		if(runtime->periods == 2)
+			snd_emu10k1x_intr_enable(emu, (INTE_CH_0_LOOP | INTE_CH_0_HALF_LOOP) << channel);
+		else
+			snd_emu10k1x_intr_enable(emu, INTE_CH_0_LOOP << channel);
 		epcm->running = 1;
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|(TRIGGER_CHANNEL_0<<channel));
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CHANNEL_0<<channel));
 		epcm->running = 0;
+		snd_emu10k1x_intr_disable(emu, (INTE_CH_0_LOOP | INTE_CH_0_HALF_LOOP) << channel);
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CHANNEL_0<<channel));
 		break;
 	default:
 		result = -EINVAL;
@@ -537,12 +535,16 @@
 	ptr3 = snd_emu10k1x_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
 	ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr4 = snd_emu10k1x_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
+
+	if(ptr4 == 0 && ptr1 == frames_to_bytes(runtime, runtime->buffer_size))
+		return 0;
 	
 	if (ptr3 != ptr4) 
 		ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
 	ptr2 = bytes_to_frames(runtime, ptr1);
 	ptr2 += (ptr4 >> 3) * runtime->period_size;
 	ptr = ptr2;
+
 	if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
 
@@ -567,6 +569,12 @@
 	emu10k1x_t *chip = snd_pcm_substream_chip(substream);
 	emu10k1x_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	int err;
+
+	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+                return err;
+	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+                return err;
 
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL) {
@@ -602,7 +610,6 @@
 		epcm->voice = &epcm->emu->capture_voice;
 		epcm->voice->epcm = epcm;
 		epcm->voice->use = 1;
-		epcm->voice->interrupt = snd_emu10k1x_pcm_interrupt;
 	}
 
 	return snd_pcm_lib_malloc_pages(substream,
@@ -622,7 +629,6 @@
 
 	if (epcm->voice) {
 		epcm->voice->use = 0;
-		epcm->voice->interrupt = NULL;
 		epcm->voice->epcm = NULL;
 		epcm->voice = NULL;
 	}
@@ -639,6 +645,7 @@
 	snd_emu10k1x_ptr_write(emu, CAPTURE_DMA_ADDR, 0, runtime->dma_addr);
 	snd_emu10k1x_ptr_write(emu, CAPTURE_BUFFER_SIZE, 0, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_emu10k1x_ptr_write(emu, CAPTURE_POINTER, 0, 0);
+	snd_emu10k1x_ptr_write(emu, CAPTURE_UNKNOWN, 0, 0);
 
 	return 0;
 }
@@ -654,12 +661,16 @@
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		snd_emu10k1x_intr_enable(emu, INTE_CAP_0_LOOP | 
+					 INTE_CAP_0_HALF_LOOP);
 		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0)|TRIGGER_CAPTURE);
 		epcm->running = 1;
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CAPTURE));
 		epcm->running = 0;
+		snd_emu10k1x_intr_disable(emu, INTE_CAP_0_LOOP | 
+					  INTE_CAP_0_HALF_LOOP);
+		snd_emu10k1x_ptr_write(emu, TRIGGER_CHANNEL, 0, snd_emu10k1x_ptr_read(emu, TRIGGER_CHANNEL, 0) & ~(TRIGGER_CAPTURE));
 		break;
 	default:
 		result = -EINVAL;
@@ -784,39 +795,45 @@
 	int i;
 	int mask;
 
-	spin_lock(&chip->emu_lock);
-
 	status = inl(chip->port + IPR);
 
-	// call updater, unlock before it
-	spin_unlock(&chip->emu_lock);
-  
-	if (! status)
-		return IRQ_NONE;
-
-	mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
-	for(i = 0; i < 3; i++) {
-		if(status & mask) {
-			if(pvoice->use && pvoice->interrupt)
-				pvoice->interrupt(chip, pvoice);
+	if(status) {
+		// capture interrupt
+		if(status & (IPR_CAP_0_LOOP | IPR_CAP_0_HALF_LOOP)) {
+			emu10k1x_voice_t *pvoice = &chip->capture_voice;
+			if(pvoice->use)
+				snd_emu10k1x_pcm_interrupt(chip, pvoice);
+			else
+				snd_emu10k1x_intr_disable(chip, 
+							  INTE_CAP_0_LOOP |
+							  INTE_CAP_0_HALF_LOOP);
 		}
-		pvoice++;
-		mask <<= 1;
-	}
-	// capture interrupt
-	if(status & (IPR_CAP_0_LOOP | IPR_CAP_0_HALF_LOOP)) {
-		emu10k1x_voice_t *pvoice = &chip->capture_voice;
-		if(pvoice->use && pvoice->interrupt)
-			pvoice->interrupt(chip, pvoice);
-	}
-
-	spin_lock(&chip->emu_lock);
-	// acknowledge the interrupt if necessary
-	outl(status, chip->port+IPR);
-
-	spin_unlock(&chip->emu_lock);
+		
+		mask = IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP;
+		for(i = 0; i < 3; i++) {
+			if(status & mask) {
+				if(pvoice->use)
+					snd_emu10k1x_pcm_interrupt(chip, pvoice);
+				else 
+					snd_emu10k1x_intr_disable(chip, mask);
+			}
+			pvoice++;
+			mask <<= 1;
+		}
+		
+		if (status & (IPR_MIDITRANSBUFEMPTY|IPR_MIDIRECVBUFEMPTY)) {
+			if (chip->midi.interrupt)
+				chip->midi.interrupt(chip, status);
+			else
+				snd_emu10k1x_intr_disable(chip, INTE_MIDITXENABLE|INTE_MIDIRXENABLE);
+		}
+		
+		// acknowledge the interrupt if necessary
+		if(status)
+			outl(status, chip->port+IPR);
 
-//	snd_printk(KERN_INFO "interrupt %08x\n", status);
+//		snd_printk(KERN_INFO "interrupt %08x\n", status);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -948,7 +965,7 @@
 	chip->dma_dev.type = SNDRV_DMA_TYPE_DEV;
 	chip->dma_dev.dev = snd_dma_pci_data(pci);
 
-	if(snd_dma_alloc_pages(&chip->dma_dev, 32 * 1024, &chip->dma_buffer) < 0) {
+	if(snd_dma_alloc_pages(&chip->dma_dev, 4 * 1024, &chip->dma_buffer) < 0) {
 		snd_emu10k1x_free(chip);
 		return -ENOMEM;
 	}
@@ -1007,11 +1024,6 @@
 
 	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
 
-	snd_emu10k1x_intr_enable(chip, INTE_CH_0_LOOP |
-				 (INTE_CH_0_LOOP<<1) |
-				 (INTE_CH_0_LOOP<<2) |
-				 (INTE_CAP_0_LOOP|INTE_CAP_0_HALF_LOOP));
-
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
 				  chip, &ops)) < 0) {
 		snd_emu10k1x_free(chip);
@@ -1223,6 +1235,316 @@
 	return 0;
 }
 
+#define EMU10K1X_MIDI_MODE_INPUT	(1<<0)
+#define EMU10K1X_MIDI_MODE_OUTPUT	(1<<1)
+
+static inline unsigned char mpu401_read(emu10k1x_t *emu, emu10k1x_midi_t *mpu, int idx)
+{
+	return (unsigned char)snd_emu10k1x_ptr_read(emu, mpu->port + idx, 0);
+}
+
+static inline void mpu401_write(emu10k1x_t *emu, emu10k1x_midi_t *mpu, int data, int idx)
+{
+	snd_emu10k1x_ptr_write(emu, mpu->port + idx, 0, data);
+}
+
+#define mpu401_write_data(emu, mpu, data)	mpu401_write(emu, mpu, data, 0)
+#define mpu401_write_cmd(emu, mpu, data)	mpu401_write(emu, mpu, data, 1)
+#define mpu401_read_data(emu, mpu)		mpu401_read(emu, mpu, 0)
+#define mpu401_read_stat(emu, mpu)		mpu401_read(emu, mpu, 1)
+
+#define mpu401_input_avail(emu,mpu)	(!(mpu401_read_stat(emu,mpu) & 0x80))
+#define mpu401_output_ready(emu,mpu)	(!(mpu401_read_stat(emu,mpu) & 0x40))
+
+#define MPU401_RESET		0xff
+#define MPU401_ENTER_UART	0x3f
+#define MPU401_ACK		0xfe
+
+static void mpu401_clear_rx(emu10k1x_t *emu, emu10k1x_midi_t *mpu)
+{
+	int timeout = 100000;
+	for (; timeout > 0 && mpu401_input_avail(emu, mpu); timeout--)
+		mpu401_read_data(emu, mpu);
+#ifdef CONFIG_SND_DEBUG
+	if (timeout <= 0)
+		snd_printk(KERN_ERR "cmd: clear rx timeout (status = 0x%x)\n", mpu401_read_stat(emu, mpu));
+#endif
+}
+
+/*
+
+ */
+
+static void do_emu10k1x_midi_interrupt(emu10k1x_t *emu, emu10k1x_midi_t *midi, unsigned int status)
+{
+	unsigned char byte;
+
+	if (midi->rmidi == NULL) {
+		snd_emu10k1x_intr_disable(emu, midi->tx_enable | midi->rx_enable);
+		return;
+	}
+
+	spin_lock(&midi->input_lock);
+	if ((status & midi->ipr_rx) && mpu401_input_avail(emu, midi)) {
+		if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_INPUT)) {
+			mpu401_clear_rx(emu, midi);
+		} else {
+			byte = mpu401_read_data(emu, midi);
+			spin_unlock(&midi->input_lock);
+			if (midi->substream_input)
+				snd_rawmidi_receive(midi->substream_input, &byte, 1);
+			spin_lock(&midi->input_lock);
+		}
+	}
+	spin_unlock(&midi->input_lock);
+
+	spin_lock(&midi->output_lock);
+	if ((status & midi->ipr_tx) && mpu401_output_ready(emu, midi)) {
+		if (midi->substream_output &&
+		    snd_rawmidi_transmit(midi->substream_output, &byte, 1) == 1) {
+			mpu401_write_data(emu, midi, byte);
+		} else {
+			snd_emu10k1x_intr_disable(emu, midi->tx_enable);
+		}
+	}
+	spin_unlock(&midi->output_lock);
+}
+
+static void snd_emu10k1x_midi_interrupt(emu10k1x_t *emu, unsigned int status)
+{
+	do_emu10k1x_midi_interrupt(emu, &emu->midi, status);
+}
+
+static void snd_emu10k1x_midi_cmd(emu10k1x_t * emu, emu10k1x_midi_t *midi, unsigned char cmd, int ack)
+{
+	unsigned long flags;
+	int timeout, ok;
+
+	spin_lock_irqsave(&midi->input_lock, flags);
+	mpu401_write_data(emu, midi, 0x00);
+	/* mpu401_clear_rx(emu, midi); */
+
+	mpu401_write_cmd(emu, midi, cmd);
+	if (ack) {
+		ok = 0;
+		timeout = 10000;
+		while (!ok && timeout-- > 0) {
+			if (mpu401_input_avail(emu, midi)) {
+				if (mpu401_read_data(emu, midi) == MPU401_ACK)
+					ok = 1;
+			}
+		}
+		if (!ok && mpu401_read_data(emu, midi) == MPU401_ACK)
+			ok = 1;
+	} else {
+		ok = 1;
+	}
+	spin_unlock_irqrestore(&midi->input_lock, flags);
+	if (!ok)
+		snd_printk(KERN_ERR "midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
+			   cmd, emu->port,
+			   mpu401_read_stat(emu, midi),
+			   mpu401_read_data(emu, midi));
+}
+
+static int snd_emu10k1x_midi_input_open(snd_rawmidi_substream_t * substream)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	unsigned long flags;
+	
+	emu = midi->emu;
+	snd_assert(emu, return -ENXIO);
+	spin_lock_irqsave(&midi->open_lock, flags);
+	midi->midi_mode |= EMU10K1X_MIDI_MODE_INPUT;
+	midi->substream_input = substream;
+	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_OUTPUT)) {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+	} else {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+	}
+	return 0;
+}
+
+static int snd_emu10k1x_midi_output_open(snd_rawmidi_substream_t * substream)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	unsigned long flags;
+
+	emu = midi->emu;
+	snd_assert(emu, return -ENXIO);
+	spin_lock_irqsave(&midi->open_lock, flags);
+	midi->midi_mode |= EMU10K1X_MIDI_MODE_OUTPUT;
+	midi->substream_output = substream;
+	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_INPUT)) {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 1);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_ENTER_UART, 1);
+	} else {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+	}
+	return 0;
+}
+
+static int snd_emu10k1x_midi_input_close(snd_rawmidi_substream_t * substream)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	unsigned long flags;
+
+	emu = midi->emu;
+	snd_assert(emu, return -ENXIO);
+	spin_lock_irqsave(&midi->open_lock, flags);
+	snd_emu10k1x_intr_disable(emu, midi->rx_enable);
+	midi->midi_mode &= ~EMU10K1X_MIDI_MODE_INPUT;
+	midi->substream_input = NULL;
+	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_OUTPUT)) {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
+	} else {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+	}
+	return 0;
+}
+
+static int snd_emu10k1x_midi_output_close(snd_rawmidi_substream_t * substream)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	unsigned long flags;
+
+	emu = midi->emu;
+	snd_assert(emu, return -ENXIO);
+	spin_lock_irqsave(&midi->open_lock, flags);
+	snd_emu10k1x_intr_disable(emu, midi->tx_enable);
+	midi->midi_mode &= ~EMU10K1X_MIDI_MODE_OUTPUT;
+	midi->substream_output = NULL;
+	if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_INPUT)) {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+		snd_emu10k1x_midi_cmd(emu, midi, MPU401_RESET, 0);
+	} else {
+		spin_unlock_irqrestore(&midi->open_lock, flags);
+	}
+	return 0;
+}
+
+static void snd_emu10k1x_midi_input_trigger(snd_rawmidi_substream_t * substream, int up)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	emu = midi->emu;
+	snd_assert(emu, return);
+
+	if (up)
+		snd_emu10k1x_intr_enable(emu, midi->rx_enable);
+	else
+		snd_emu10k1x_intr_disable(emu, midi->rx_enable);
+}
+
+static void snd_emu10k1x_midi_output_trigger(snd_rawmidi_substream_t * substream, int up)
+{
+	emu10k1x_t *emu;
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)substream->rmidi->private_data;
+	unsigned long flags;
+
+	emu = midi->emu;
+	snd_assert(emu, return);
+
+	if (up) {
+		int max = 4;
+		unsigned char byte;
+	
+		/* try to send some amount of bytes here before interrupts */
+		spin_lock_irqsave(&midi->output_lock, flags);
+		while (max > 0) {
+			if (mpu401_output_ready(emu, midi)) {
+				if (!(midi->midi_mode & EMU10K1X_MIDI_MODE_OUTPUT) ||
+				    snd_rawmidi_transmit(substream, &byte, 1) != 1) {
+					/* no more data */
+					spin_unlock_irqrestore(&midi->output_lock, flags);
+					return;
+				}
+				mpu401_write_data(emu, midi, byte);
+				max--;
+			} else {
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&midi->output_lock, flags);
+		snd_emu10k1x_intr_enable(emu, midi->tx_enable);
+	} else {
+		snd_emu10k1x_intr_disable(emu, midi->tx_enable);
+	}
+}
+
+/*
+
+ */
+
+static snd_rawmidi_ops_t snd_emu10k1x_midi_output =
+{
+	.open =		snd_emu10k1x_midi_output_open,
+	.close =	snd_emu10k1x_midi_output_close,
+	.trigger =	snd_emu10k1x_midi_output_trigger,
+};
+
+static snd_rawmidi_ops_t snd_emu10k1x_midi_input =
+{
+	.open =		snd_emu10k1x_midi_input_open,
+	.close =	snd_emu10k1x_midi_input_close,
+	.trigger =	snd_emu10k1x_midi_input_trigger,
+};
+
+static void snd_emu10k1x_midi_free(snd_rawmidi_t *rmidi)
+{
+	emu10k1x_midi_t *midi = (emu10k1x_midi_t *)rmidi->private_data;
+	midi->interrupt = NULL;
+	midi->rmidi = NULL;
+}
+
+static int __devinit emu10k1x_midi_init(emu10k1x_t *emu, emu10k1x_midi_t *midi, int device, char *name)
+{
+	snd_rawmidi_t *rmidi;
+	int err;
+
+	if ((err = snd_rawmidi_new(emu->card, name, device, 1, 1, &rmidi)) < 0)
+		return err;
+	midi->emu = emu;
+	spin_lock_init(&midi->open_lock);
+	spin_lock_init(&midi->input_lock);
+	spin_lock_init(&midi->output_lock);
+	strcpy(rmidi->name, name);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_emu10k1x_midi_output);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_emu10k1x_midi_input);
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |
+	                     SNDRV_RAWMIDI_INFO_INPUT |
+	                     SNDRV_RAWMIDI_INFO_DUPLEX;
+	rmidi->private_data = midi;
+	rmidi->private_free = snd_emu10k1x_midi_free;
+	midi->rmidi = rmidi;
+	return 0;
+}
+
+static int __devinit snd_emu10k1x_midi(emu10k1x_t *emu)
+{
+	emu10k1x_midi_t *midi = &emu->midi;
+	int err;
+
+	if ((err = emu10k1x_midi_init(emu, midi, 0, "EMU10K1X MPU-401 (UART)")) < 0)
+		return err;
+
+	midi->tx_enable = INTE_MIDITXENABLE;
+	midi->rx_enable = INTE_MIDIRXENABLE;
+	midi->port = MUDATA;
+	midi->ipr_tx = IPR_MIDITRANSBUFEMPTY;
+	midi->ipr_rx = IPR_MIDIRECVBUFEMPTY;
+	midi->interrupt = snd_emu10k1x_midi_interrupt;
+	return 0;
+}
+
 static int __devinit snd_emu10k1x_probe(struct pci_dev *pci,
 					const struct pci_device_id *pci_id)
 {
@@ -1270,6 +1592,11 @@
 		return err;
 	}
 	
+	if ((err = snd_emu10k1x_midi(chip)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
 	snd_emu10k1x_proc_init(chip);
 
 	strcpy(card->driver, "EMU10K1X");

--Boundary_(ID_iVuevnok8NcQ6ucevENtDw)--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
