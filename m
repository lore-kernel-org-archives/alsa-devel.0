From: fmoraes@nc.rr.com
Subject: emu10k1x patch
Date: Tue, 06 Jul 2004 18:04:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1f9ae991f9ec6b.1f9ec6b1f9ae99@southeast.rr.com>
Reply-To: fmoraes@nc.rr.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_L9PAFF182me7pUTN5Onn7w)"
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

--Boundary_(ID_L9PAFF182me7pUTN5Onn7w)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Please commit to CVS with the following changes:
- added support for more periods (up to 512 for playback)
- formatting clean up

Francisco

--Boundary_(ID_L9PAFF182me7pUTN5Onn7w)
Content-type: text/plain; NAME=patch.txt
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=patch.txt

Index: alsa-driver/pci/emu10k1/emu10k1x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/emu10k1x.c,v
retrieving revision 1.7
diff -u -r1.7 emu10k1x.c
--- alsa-driver/pci/emu10k1/emu10k1x.c	2 Jul 2004 12:09:47 -0000	1.7
+++ alsa-driver/pci/emu10k1/emu10k1x.c	6 Jul 2004 22:02:53 -0000
@@ -77,14 +77,14 @@
 						/* the relevant bits and zero to the other bits	*/
 #define IPR_CH_0_LOOP           0x00000800      /* Channel 0 loop                               */
 #define IPR_CH_0_HALF_LOOP      0x00000100      /* Channel 0 half loop                          */
-#define IPR_CAP_0_LOOP          0x00080000      /* Channel capture loop                               */
-#define IPR_CAP_0_HALF_LOOP     0x00010000      /* Channel capture half loop                          */
+#define IPR_CAP_0_LOOP          0x00080000      /* Channel capture loop                         */
+#define IPR_CAP_0_HALF_LOOP     0x00010000      /* Channel capture half loop                    */
 
 #define INTE			0x0c		/* Interrupt enable register			*/
 #define INTE_CH_0_LOOP          0x00000800      /* Channel 0 loop                               */
 #define INTE_CH_0_HALF_LOOP     0x00000100      /* Channel 0 half loop                          */
-#define INTE_CAP_0_LOOP         0x00080000      /* Channel capture loop                               */
-#define INTE_CAP_0_HALF_LOOP    0x00010000      /* Channel capture half loop                          */
+#define INTE_CAP_0_LOOP         0x00080000      /* Channel capture loop                         */
+#define INTE_CAP_0_HALF_LOOP    0x00010000      /* Channel capture half loop                    */
 
 #define HCFG			0x14		/* Hardware config register			*/
 
@@ -93,6 +93,7 @@
 #define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
 						/* Should be set to 1 when the EMU10K1 is	*/
 						/* completely initialized.			*/
+#define GPIO			0x18		/* Defaults: 00001080-Analog, 00001000-SPDIF.   */
 
 
 #define AC97DATA		0x1c		/* AC97 register set data register (16 bit)	*/
@@ -102,6 +103,14 @@
 /********************************************************************************************************/
 /* Emu10k1x pointer-offset register set, accessed through the PTR and DATA registers			*/
 /********************************************************************************************************/
+#define PLAYBACK_LIST_ADDR	0x00		/* Base DMA address of a list of pointers to each period/size */
+						/* One list entry: 4 bytes for DMA address, 
+						 * 4 bytes for period_size << 16.
+						 * One list entry is 8 bytes long.
+						 * One list entry for each period in the buffer.
+						 */
+#define PLAYBACK_LIST_SIZE	0x01		/* Size of list in bytes << 16. E.g. 8 periods -> 0x00380000  */
+#define PLAYBACK_LIST_PTR	0x02		/* Pointer to the current period being played */
 #define PLAYBACK_DMA_ADDR	0x04		/* Playback DMA addresss */
 #define PLAYBACK_BUFFER_SIZE	0x05		/* Playback buffer size */
 #define PLAYBACK_POINTER	0x06		/* Playback buffer pointer. Sample currently in DAC */
@@ -158,6 +167,13 @@
 
 #define SPDIF_SELECT		0x45		/* Enables SPDIF or Analogue outputs 0-Analogue, 0x700-SPDIF */
 
+/* This is the MPU port on the card                      					*/
+#define MUDATA		0x47
+#define MUCMD		0x48
+#define MUSTAT		MUCMD
+
+/* From 0x50 - 0x5f, last samples captured */
+
 /**
  * The hardware has 3 channels for playback and 1 for capture.
  *  - channel 0 is the front channel
@@ -217,12 +233,9 @@
 	u32 spdif_bits[3]; // SPDIF out setup
 
 	struct snd_dma_device dma_dev;
-	struct snd_dma_buffer buffer;
+	struct snd_dma_buffer dma_buffer;
 };
 
-#define emu10k1x_t_magic        0xa15a4501
-#define emu10k1x_pcm_t_magic	0xa15a4502
-
 /* hardware definition */
 static snd_pcm_hardware_t snd_emu10k1x_playback_hw = {
 	.info =			(SNDRV_PCM_INFO_MMAP | 
@@ -239,7 +252,7 @@
 	.period_bytes_min =	64,
 	.period_bytes_max =	(16*1024),
 	.periods_min =		2,
-	.periods_max =		2,
+	.periods_max =		512,
 	.fifo_size =		0,
 };
 
@@ -305,6 +318,15 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
+static void snd_emu10k1x_gpio_write(emu10k1x_t *emu, unsigned int value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->emu_lock, flags);
+	outl(value, emu->port + GPIO);
+	spin_unlock_irqrestore(&emu->emu_lock, flags);
+}
+
 static int voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
 {
 	emu10k1x_voice_t *voice;
@@ -322,7 +344,7 @@
 
 static int snd_emu10k1x_voice_alloc(emu10k1x_t *emu, emu10k1x_voice_t **rvoice, int id)
 {
-  unsigned long flags;
+	unsigned long flags;
 	int result;
   
 	snd_assert(rvoice != NULL, return -EINVAL);
@@ -368,7 +390,7 @@
 	if (epcm->substream == NULL)
 		return;
 #if 0
-	snd_printk("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
+	snd_printk(KERN_INFO "IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
 		   epcm->substream->ops->pointer(epcm->substream),
 		   snd_pcm_lib_period_bytes(epcm->substream),
 		   snd_pcm_lib_buffer_bytes(epcm->substream));
@@ -432,6 +454,7 @@
 
 	if (runtime->private_data == NULL)
 		return 0;
+	
 	epcm = runtime->private_data;
 
 	if (epcm->voice) {
@@ -449,21 +472,23 @@
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1x_pcm_t *epcm = runtime->private_data;
 	int voice = epcm->voice->number;
-	unsigned int value;
-
-	snd_emu10k1x_ptr_write(emu, 0x00, voice, 0);
-	snd_emu10k1x_ptr_write(emu, 0x01, voice, 0);
-	snd_emu10k1x_ptr_write(emu, 0x02, voice, 0);
+	u32 *table_base = (u32 *)(emu->dma_buffer.area+4096*voice);
+	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
+	int i;
+	
+	for(i=0; i < runtime->periods; i++) {
+		*table_base++=runtime->dma_addr+(i*period_size_bytes);
+		*table_base++=period_size_bytes<<16;
+	}
+ 
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_ADDR, voice, emu->dma_buffer.addr+4096*voice);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_SIZE, voice, (runtime->periods - 1) << 19);
+	snd_emu10k1x_ptr_write(emu, PLAYBACK_LIST_PTR, voice, 0);
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_DMA_ADDR, voice, runtime->dma_addr);
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_BUFFER_SIZE, voice, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_emu10k1x_ptr_write(emu, PLAYBACK_POINTER, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x07, voice, 0);
 	snd_emu10k1x_ptr_write(emu, 0x08, voice, 0);
-	value = snd_emu10k1x_ptr_read(emu, ROUTING, 0);
-	value |= 3 << (2*voice);
-	if(voice == 2)
-	  value |= 0x10000; // enable center/lfe channel this way
-	snd_emu10k1x_ptr_write(emu, ROUTING, 0, value);
 
 	return 0;
 }
@@ -478,7 +503,7 @@
 	int channel = epcm->voice->number;
 	int result = 0;
 
-//	snd_printk("trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
+//	snd_printk(KERN_INFO "trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -503,19 +528,24 @@
 	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1x_pcm_t *epcm = runtime->private_data;
-	unsigned int ptr = 0;
 	int channel = epcm->voice->number;
+	snd_pcm_uframes_t ptr = 0, ptr1 = 0, ptr2= 0,ptr3 = 0,ptr4 = 0;
 
 	if (!epcm->running)
 		return 0;
 
-//	snd_printk("pointer: %08X\n", 
-//		   snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel));
-	ptr = bytes_to_frames(runtime, snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel));
+	ptr3 = snd_emu10k1x_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
+	ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
+	ptr4 = snd_emu10k1x_ptr_read(emu, PLAYBACK_LIST_PTR, channel);
+	
+	if (ptr3 != ptr4) 
+		ptr1 = snd_emu10k1x_ptr_read(emu, PLAYBACK_POINTER, channel);
+	ptr2 = bytes_to_frames(runtime, ptr1);
+	ptr2 += (ptr4 >> 3) * runtime->period_size;
+	ptr = ptr2;
 	if (ptr >= runtime->buffer_size)
 		ptr -= runtime->buffer_size;
 
-//	snd_printk("ptr = 0x%x, buffer_size = 0x%x, period_size = 0x%x, bits=%d, rate=%d\n", ptr, (int)runtime->buffer_size, (int)runtime->period_size, (int)runtime->frame_bits, (int)runtime->rate);
 	return ptr;
 }
 
@@ -541,7 +571,7 @@
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
 	if (epcm == NULL) {
 		return -ENOMEM;
-        }
+	}
 	epcm->emu = chip;
 	epcm->substream = substream;
   
@@ -561,7 +591,7 @@
 
 /* hw_params callback */
 static int snd_emu10k1x_pcm_hw_params_capture(snd_pcm_substream_t *substream,
-				      snd_pcm_hw_params_t * hw_params)
+					      snd_pcm_hw_params_t * hw_params)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	emu10k1x_pcm_t *epcm = runtime->private_data;
@@ -605,7 +635,7 @@
 {
 	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	//	snd_printk("prepare: rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, frames_to_bytes=%d\n",runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size,  frames_to_bytes(runtime, 1));
+
 	snd_emu10k1x_ptr_write(emu, CAPTURE_DMA_ADDR, 0, runtime->dma_addr);
 	snd_emu10k1x_ptr_write(emu, CAPTURE_BUFFER_SIZE, 0, frames_to_bytes(runtime, runtime->buffer_size)<<16); // buffer size in bytes
 	snd_emu10k1x_ptr_write(emu, CAPTURE_POINTER, 0, 0);
@@ -615,7 +645,7 @@
 
 /* trigger_capture callback */
 static int snd_emu10k1x_pcm_trigger_capture(snd_pcm_substream_t *substream,
-				    int cmd)
+					    int cmd)
 {
 	emu10k1x_t *emu = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
@@ -726,6 +756,12 @@
 	// release the irq
 	if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
+
+	// release the DMA
+	if (chip->dma_buffer.area) {
+		snd_dma_free_pages(&chip->dma_dev, &chip->dma_buffer);
+	}
+
 	// release the data
 	kfree(chip);
 	return 0;
@@ -779,7 +815,7 @@
 
 	spin_unlock(&chip->emu_lock);
 
-//	snd_printk("interrupt %08x\n", status);
+//	snd_printk(KERN_INFO "interrupt %08x\n", status);
 
 	return IRQ_HANDLED;
 }
@@ -801,7 +837,7 @@
 	if (rpcm)
 		*rpcm = NULL;
 	if (device == 0)
-	  capture = 1;
+		capture = 1;
 	
 	if ((err = snd_pcm_new(emu->card, "emu10k1x", device, 1, capture, &pcm)) < 0)
 		return err;
@@ -811,27 +847,27 @@
 	
 	switch(device) {
 	case 0:
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1x_capture_ops);
-	  break;
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_emu10k1x_capture_ops);
+		break;
 	case 1:
 	case 2:
-	  snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
-	  break;
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_emu10k1x_playback_ops);
+		break;
 	}
 
 	pcm->info_flags = 0;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
 	switch(device) {
 	case 0:
-	  strcpy(pcm->name, "EMU10K1X Front");
-	  break;
+		strcpy(pcm->name, "EMU10K1X Front");
+		break;
 	case 1:
-	  strcpy(pcm->name, "EMU10K1X Rear");
-	  break;
+		strcpy(pcm->name, "EMU10K1X Rear");
+		break;
 	case 2:
-	  strcpy(pcm->name, "EMU10K1X Center/LFE");
-	  break;
+		strcpy(pcm->name, "EMU10K1X Center/LFE");
+		break;
 	}
 	emu->pcm = pcm;
 
@@ -892,9 +928,9 @@
   
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 8,
-					     "My Chip")) == NULL) { 
+					     "EMU10K1X")) == NULL) { 
 		snd_emu10k1x_free(chip);
-		snd_printk("cannot allocate the port\n");
+		snd_printk(KERN_ERR "cannot allocate the port\n");
 		return -EBUSY;
 	}
 
@@ -902,7 +938,7 @@
 			SA_INTERRUPT|SA_SHIRQ, "EMU10K1X",
 			(void *)chip)) {
 		snd_emu10k1x_free(chip);
-		snd_printk("cannot grab irq\n");
+		snd_printk(KERN_ERR "cannot grab irq\n");
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
@@ -910,8 +946,8 @@
 	memset(&chip->dma_dev, 0, sizeof(chip->dma_dev));
 	chip->dma_dev.type = SNDRV_DMA_TYPE_DEV;
 	chip->dma_dev.dev = snd_dma_pci_data(pci);
-  
-	if(snd_dma_alloc_pages(&chip->dma_dev, 32 * 1024, &chip->buffer) < 0) {
+
+	if(snd_dma_alloc_pages(&chip->dma_dev, 32 * 1024, &chip->dma_buffer) < 0) {
 		snd_emu10k1x_free(chip);
 		return -ENOMEM;
 	}
@@ -921,7 +957,7 @@
 	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&chip->revision);
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
-	snd_printk("Model %04x Rev %08x Serial %08x\n", chip->model,
+	snd_printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
 		   chip->revision, chip->serial);
 
 	outl(0, chip->port + INTE);	
@@ -965,14 +1001,14 @@
 			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
 	snd_emu10k1x_ptr_write(chip, SPDIF_SELECT, 0, 0x700); // disable SPDIF
-	// verify the next line
-	snd_emu10k1x_ptr_write(chip, ROUTING, 0, 0x10000); // routing
+	snd_emu10k1x_ptr_write(chip, ROUTING, 0, 0x1003F); // routing
+	snd_emu10k1x_gpio_write(chip, 0x1080); // analog mode
 
 	outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
 
-	snd_emu10k1x_intr_enable(chip, (INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP) |
-				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<1) |
-				 ((INTE_CH_0_LOOP|INTE_CH_0_HALF_LOOP)<<2) |
+	snd_emu10k1x_intr_enable(chip, INTE_CH_0_LOOP |
+				 (INTE_CH_0_LOOP<<1) |
+				 (INTE_CH_0_LOOP<<2) |
 				 (INTE_CAP_0_LOOP|INTE_CAP_0_HALF_LOOP));
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
@@ -1016,16 +1052,17 @@
 					snd_info_buffer_t *buffer)
 {
 	emu10k1x_t *emu = entry->private_data;
-        char line[64];
-        unsigned int reg, channel_id , val;
-        while (!snd_info_get_line(buffer, line, sizeof(line))) {
-                if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
-                        continue;
-		
-                if ((reg < 0x49) && (reg >=0) && (val <= 0xffffffff) 
+	char line[64];
+	unsigned int reg, channel_id , val;
+
+	while (!snd_info_get_line(buffer, line, sizeof(line))) {
+		if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
+			continue;
+
+		if ((reg < 0x49) && (reg >=0) && (val <= 0xffffffff) 
 		    && (channel_id >=0) && (channel_id <= 2) )
 			snd_emu10k1x_ptr_write(emu, reg, channel_id, val);
-        }
+	}
 }
 
 static int __devinit snd_emu10k1x_proc_init(emu10k1x_t * emu)
@@ -1052,17 +1089,17 @@
 }
 
 static int snd_emu10k1x_shared_spdif_get(snd_kcontrol_t * kcontrol,
-					snd_ctl_elem_value_t * ucontrol)
+					 snd_ctl_elem_value_t * ucontrol)
 {
 	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
 
 	ucontrol->value.integer.value[0] = (snd_emu10k1x_ptr_read(emu, SPDIF_SELECT, 0) == 0x700) ? 0 : 1;
 
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1x_shared_spdif_put(snd_kcontrol_t * kcontrol,
-					snd_ctl_elem_value_t * ucontrol)
+					 snd_ctl_elem_value_t * ucontrol)
 {
 	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int val;
@@ -1073,11 +1110,15 @@
 	if (val) {
 		// enable spdif output
 		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x000);
+		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x700);
+		snd_emu10k1x_gpio_write(emu, 0x1000);
 	} else {
 		// disable spdif output
 		snd_emu10k1x_ptr_write(emu, SPDIF_SELECT, 0, 0x700);
+		snd_emu10k1x_ptr_write(emu, ROUTING, 0, 0x1003F);
+		snd_emu10k1x_gpio_write(emu, 0x1080);
 	}
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1x_shared_spdif __devinitdata =
@@ -1097,7 +1138,7 @@
 }
 
 static int snd_emu10k1x_spdif_get(snd_kcontrol_t * kcontrol,
-                                 snd_ctl_elem_value_t * ucontrol)
+				  snd_ctl_elem_value_t * ucontrol)
 {
 	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
@@ -1106,21 +1147,21 @@
 	ucontrol->value.iec958.status[1] = (emu->spdif_bits[idx] >> 8) & 0xff;
 	ucontrol->value.iec958.status[2] = (emu->spdif_bits[idx] >> 16) & 0xff;
 	ucontrol->value.iec958.status[3] = (emu->spdif_bits[idx] >> 24) & 0xff;
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1x_spdif_get_mask(snd_kcontrol_t * kcontrol,
-				      snd_ctl_elem_value_t * ucontrol)
+				       snd_ctl_elem_value_t * ucontrol)
 {
 	ucontrol->value.iec958.status[0] = 0xff;
 	ucontrol->value.iec958.status[1] = 0xff;
 	ucontrol->value.iec958.status[2] = 0xff;
 	ucontrol->value.iec958.status[3] = 0xff;
-        return 0;
+	return 0;
 }
 
 static int snd_emu10k1x_spdif_put(snd_kcontrol_t * kcontrol,
-                                 snd_ctl_elem_value_t * ucontrol)
+				  snd_ctl_elem_value_t * ucontrol)
 {
 	emu10k1x_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
@@ -1128,42 +1169,42 @@
 	unsigned int val;
 
 	val = (ucontrol->value.iec958.status[0] << 0) |
-	      (ucontrol->value.iec958.status[1] << 8) |
-	      (ucontrol->value.iec958.status[2] << 16) |
-	      (ucontrol->value.iec958.status[3] << 24);
+		(ucontrol->value.iec958.status[1] << 8) |
+		(ucontrol->value.iec958.status[2] << 16) |
+		(ucontrol->value.iec958.status[3] << 24);
 	change = val != emu->spdif_bits[idx];
 	if (change) {
 		snd_emu10k1x_ptr_write(emu, SPCS0 + idx, 0, val);
 		emu->spdif_bits[idx] = val;
 	}
-        return change;
+	return change;
 }
 
 static snd_kcontrol_new_t snd_emu10k1x_spdif_mask_control =
 {
 	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
-        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
+	.iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
 	.count =	3,
-        .info =         snd_emu10k1x_spdif_info,
-        .get =          snd_emu10k1x_spdif_get_mask
+	.info =         snd_emu10k1x_spdif_info,
+	.get =          snd_emu10k1x_spdif_get_mask
 };
 
 static snd_kcontrol_new_t snd_emu10k1x_spdif_control =
 {
-        .iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
-        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
 	.count =	3,
-        .info =         snd_emu10k1x_spdif_info,
-        .get =          snd_emu10k1x_spdif_get,
-        .put =          snd_emu10k1x_spdif_put
+	.info =         snd_emu10k1x_spdif_info,
+	.get =          snd_emu10k1x_spdif_get,
+	.put =          snd_emu10k1x_spdif_put
 };
 
 static int __devinit snd_emu10k1x_mixer(emu10k1x_t *emu)
 {
-        int err;
-        snd_kcontrol_t *kctl;
-        snd_card_t *card = emu->card;
+	int err;
+	snd_kcontrol_t *kctl;
+	snd_card_t *card = emu->card;
 
 	if ((kctl = snd_ctl_new1(&snd_emu10k1x_spdif_mask_control, emu)) == NULL)
 		return -ENOMEM;
@@ -1178,7 +1219,7 @@
 	if ((err = snd_ctl_add(card, kctl)))
 		return err;
 
-        return 0;
+	return 0;
 }
 
 static int __devinit snd_emu10k1x_probe(struct pci_dev *pci,
@@ -1227,7 +1268,7 @@
 		snd_card_free(card);
 		return err;
 	}
-
+	
 	snd_emu10k1x_proc_init(chip);
 
 	strcpy(card->driver, "EMU10K1X");
@@ -1285,5 +1326,5 @@
 
 module_init(alsa_card_emu10k1x_init)
 module_exit(alsa_card_emu10k1x_exit)
-     
+
 EXPORT_NO_SYMBOLS; /* for old kernels only */

--Boundary_(ID_L9PAFF182me7pUTN5Onn7w)--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
