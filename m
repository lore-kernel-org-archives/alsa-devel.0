From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: [PATCH] Update to audigyls.c
Date: Thu, 08 Jul 2004 14:45:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40ED4FEC.8030200@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090209070800070809090506"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5143928F
	for <alsa-devel@alsa-project.org>; Thu,  8 Jul 2004 15:45:20 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BiZDB-000PHV-0W
	for alsa-devel@alsa-project.org; Thu, 08 Jul 2004 14:45:17 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090209070800070809090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

See attached patch.

Changes:
+ *  0.0.9
+ *    Fix AC3 output.
+ *    Enable S32_LE format support.
+ *  0.0.10
+ *    Enable 48000 and 96000 rates.
+ *  0.0.11
+ *    Add Model name recognition.

--------------090209070800070809090506
Content-Type: text/plain;
 name="audigyls-patch-against-latest-cvs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigyls-patch-against-latest-cvs.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.8
diff -u -r1.8 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	5 Jul 2004 15:07:21 -0000	1.8
+++ alsa-driver/pci/emu10k1/audigyls.c	6 Jul 2004 17:11:33 -0000
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) by James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver AUDIGYLS chips
- *  Version: 0.8
+ *  Version: 0.0.11
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -46,6 +46,13 @@
  *    Change remove and rename ctrls into lists.
  *  0.0.8
  *    Try to fix capture sources.
+ *  0.0.9
+ *    Fix AC3 output.
+ *    Enable S32_LE format support.
+ *  0.0.10
+ *    Enable 48000 and 96000 rates. (Rates other that these do not work, even with "plug:front".)
+ *  0.0.11
+ *    Add Model name recognition.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-audigyls kernel module.
@@ -57,6 +64,7 @@
  *    MIDI
  *    --
  *  GENERAL INFO:
+ *    Model: SB0310
  *    P17 Chip: CA0106-DAT
  *    AC97 Codec: STAC 9721
  *    ADC: Philips 1361T (Stereo 24bit)
@@ -135,7 +143,10 @@
 
 #define UNKNOWN14		0x10		/* Unknown ??. Defaults to 0 */
 #define HCFG			0x14		/* Hardware config register			*/
+						/* 0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
 
+#define HCFG_8_CHANNEL		0x00000200	/* 1 = 8 channels, 0 = 2 channels per substream. */
+#define HCFG_S32_LE		0x00000800	/* 1 = S32_LE, 0 = S16_LE */
 #define HCFG_LOCKSOUNDCACHE	0x00000008	/* 1 = Cancel bustmaster accesses to soundcache */
 						/* NOTE: This should generally never be used.  	*/
 #define HCFG_AUDIOENABLE	0x00000001	/* 0 = CODECs transmit zero-valued samples	*/
@@ -317,6 +328,16 @@
 	unsigned short running;
 };
 
+typedef struct {
+	u32 serial;
+	char * name;
+} audigyls_names_t;
+
+static audigyls_names_t audigyls_chip_names[] = {
+	 { 0x10021102, "AudigyLS [SB0310]"} , 
+	 { 0, "AudigyLS [Unknown]" }
+};
+
 // definition of the chip-specific record
 struct snd_audigyls {
 	snd_card_t *card;
@@ -353,10 +374,10 @@
 				 SNDRV_PCM_INFO_INTERLEAVED |
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID),
-	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_48000,
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.rates =		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000,
 	.rate_min =		48000,
-	.rate_max =		48000,
+	.rate_max =		96000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
 	.buffer_bytes_max =	(32*1024),
@@ -685,11 +706,46 @@
 	int voice = voice=epcm->channel_id;
 	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*voice));
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
+	u32 hcfg_mask = 0x00000800; /* We only know what bits 17 and 19 do. */
+	u32 hcfg_set = 0x00000000;
+	u32 hcfg;
+	u32 reg40_mask = 0x30000;
+	u32 reg40_set = 0;
+	u32 reg40;
 	int i;
 	
-        //snd_printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
+        snd_printk("prepare:voice_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",voice, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
         //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
 	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+	switch (runtime->rate) {
+        case 48000:
+		reg40_set = 0;
+		break;
+	case 96000:
+		reg40_set = 0x20000;
+		break;
+	default:
+		reg40_set = 0;
+		break;
+	}
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		hcfg_set=0;
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		hcfg_set=0x800;
+		break;
+	default:
+		hcfg_set=0;
+		break;
+	}
+	hcfg = inl(emu->port + HCFG) ;
+	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
+	outl(hcfg, emu->port + HCFG);
+	reg40 = snd_audigyls_ptr_read(emu, 0x40, 0);
+	reg40 = (reg40 & ~reg40_mask) | reg40_set;
+	snd_audigyls_ptr_write(emu, 0x40, 0, reg40);
+
 	/* FIXME: Check emu->buffer.size before actually writing to it. */
         for(i=0; i < runtime->periods; i++) {
 		table_base[i*2]=runtime->dma_addr+(i*period_size_bytes);
@@ -1154,7 +1210,7 @@
 	}
 
 	if (request_irq(pci->irq, snd_audigyls_interrupt,
-			SA_INTERRUPT|SA_SHIRQ, "AUDIGYLS",
+			SA_INTERRUPT|SA_SHIRQ, "snd_audigyls",
 			(void *)chip)) {
 		snd_audigyls_free(chip);
 		printk(KERN_ERR "cannot grab irq\n");
@@ -1176,7 +1232,7 @@
 	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&chip->revision);
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
-#if 0
+#if 1
 	printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
 	       chip->revision, chip->serial);
 #endif
@@ -1273,8 +1329,9 @@
 	snd_audigyls_intr_enable(chip, 0x105); /* Win2000 uses 0x1e0 */
 
 	//outl(HCFG_LOCKSOUNDCACHE|HCFG_AUDIOENABLE, chip->port+HCFG);
-	outl(0x00001409, chip->port+HCFG);
-	
+	//outl(0x00001409, chip->port+HCFG); /* 0x1000 causes AC3 to fails. Maybe it effects 24 bit output. */
+	outl(0x00000009, chip->port+HCFG);
+
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL,
 				  chip, &ops)) < 0) {
 		snd_audigyls_free(chip);
@@ -1284,6 +1341,24 @@
 	return 0;
 }
 
+static void snd_audigyls_proc_reg_write32(snd_info_entry_t *entry, 
+				       snd_info_buffer_t * buffer)
+{
+	audigyls_t *emu = entry->private_data;
+	unsigned long flags;
+        char line[64];
+        u32 reg, val;
+        while (!snd_info_get_line(buffer, line, sizeof(line))) {
+                if (sscanf(line, "%x %x", &reg, &val) != 2)
+                        continue;
+                if ((reg < 0x40) && (reg >=0) && (val <= 0xffffffff) ) {
+			spin_lock_irqsave(&emu->emu_lock, flags);
+			outl(val, emu->port + (reg & 0xfffffffc));
+			spin_unlock_irqrestore(&emu->emu_lock, flags);
+		}
+        }
+}
+
 static void snd_audigyls_proc_reg_read32(snd_info_entry_t *entry, 
 				       snd_info_buffer_t * buffer)
 {
@@ -1387,8 +1462,11 @@
 {
 	snd_info_entry_t *entry;
 	
-	if(! snd_card_proc_new(emu->card, "audigyls_reg32", &entry))
+	if(! snd_card_proc_new(emu->card, "audigyls_reg32", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read32);
+		entry->c.text.write_size = 64;
+		entry->c.text.write = snd_audigyls_proc_reg_write32;
+	}
 	if(! snd_card_proc_new(emu->card, "audigyls_reg16", &entry))
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read16);
 	if(! snd_card_proc_new(emu->card, "audigyls_reg8", &entry))
@@ -1972,6 +2050,7 @@
 	static int dev;
 	snd_card_t *card;
 	audigyls_t *chip;
+	audigyls_names_t *c;
 	int err;
 
 	if (dev >= SNDRV_CARDS)
@@ -2021,8 +2100,12 @@
 
 	strcpy(card->driver, "AudigyLS");
 	strcpy(card->shortname, "AUDIGYLS");
+
+	for (c=audigyls_chip_names; c->serial; c++) {
+		if (c->serial == chip->serial) break;
+	}
 	sprintf(card->longname, "%s at 0x%lx irq %i",
-		card->shortname, chip->port, chip->irq);
+		c->name, chip->port, chip->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);

--------------090209070800070809090506--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
