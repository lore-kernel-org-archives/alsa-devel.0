From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Add framework for better audigy sound card
 capabilities selection.
Date: Mon, 21 Mar 2005 21:22:54 +0000
Message-ID: <423F3B2E.4020400@superbug.co.uk>
References: <423B345F.3000901@hotmail.com> <s5hbr9c4w80.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070301090504080805030908"
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4DB93273
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2005 22:22:57 +0100 (MET)
In-Reply-To: <s5hbr9c4w80.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070301090504080805030908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> Hi,
> 
> the idea looks nice, but...
> 

Is this better?

James

Signed off: James Courtier-Dutton

Adds clearer card identification capabilities.

--------------070301090504080805030908
Content-Type: text/plain;
 name="audigy-card-ids.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy-card-ids.diff.txt"

Index: alsa-driver/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.59
diff -u -r1.59 emu10k1.h
--- alsa-driver/alsa-kernel/include/emu10k1.h	13 Mar 2005 12:17:08 -0000	1.59
+++ alsa-driver/alsa-kernel/include/emu10k1.h	21 Mar 2005 21:18:49 -0000
@@ -1035,6 +1035,23 @@
 	void (*interrupt)(emu10k1_t *emu, unsigned int status);
 } emu10k1_midi_t;
 
+typedef struct {
+	u32 vendor;
+	u32 device;
+	u32 subsystem;
+	u32 emu10k1_chip; /* Original SB Live. Not SB Live 24bit. */
+	u32 emu10k2_chip; /* Audigy 1 or Audigy 2. */
+	u32 ca0102_chip;  /* Audigy 1 or Audigy 2. Not SB Audigy 2 Value. */
+	u32 ca0108_chip;  /* Audigy 2 Value */
+	u32 ca0151_chip;  /* P16V */
+	u32 spk71;        /* Has 7.1 speakers */
+	u32 spdif_bug;    /* Has Spdif phasing bug */
+	u32 ac97_chip;    /* Has an AC97 chip */
+	u32 ecard;        /* APS EEPROM */
+	char * driver;
+	char * name;
+} emu_chip_details_t;
+
 struct _snd_emu10k1 {
 	int irq;
 
@@ -1044,6 +1061,7 @@
 	    tos_link: 1,			/* tos link detected */
 	    rear_ac97: 1,			/* rear channels are on AC'97 */
 	    spk71:1;				/* 7.1 configuration (Audigy 2 ZS) */
+	emu_chip_details_t *card_capabilities;	/* Contains profile of card capabilities */
 	unsigned int audigy;			/* is Audigy? */
 	unsigned int revision;			/* chip revision */
 	unsigned int serial;			/* serial number */
Index: alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.33
diff -u -r1.33 emu10k1.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c	17 Mar 2005 15:55:16 -0000	1.33
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c	21 Mar 2005 21:18:50 -0000
@@ -198,22 +198,8 @@
 	}
 #endif
  
-	if (emu->audigy && (emu->serial == 0x10011102) ) {
-		strcpy(card->driver, "Audigy2");
-		strcpy(card->shortname, "Sound Blaster Audigy2_Value");
-	} else if (emu->audigy && (emu->revision == 4) ) {
-		strcpy(card->driver, "Audigy2");
-		strcpy(card->shortname, "Sound Blaster Audigy2");
-	} else if (emu->audigy) {
-		strcpy(card->driver, "Audigy");
-		strcpy(card->shortname, "Sound Blaster Audigy");
-	} else if (emu->APS) {
-		strcpy(card->driver, "E-mu APS");
-		strcpy(card->shortname, "E-mu APS");
-	} else {
-		strcpy(card->driver, "EMU10K1");
-		strcpy(card->shortname, "Sound Blaster Live!");
-	}
+	strcpy(card->driver, emu->card_capabilities->driver);
+	strcpy(card->shortname, emu->card_capabilities->name);
 	sprintf(card->longname, "%s (rev.%d, serial:0x%x) at 0x%lx, irq %i", card->shortname, emu->revision, emu->serial, emu->port, emu->irq);
 
 	if ((err = snd_card_register(card)) < 0) {
Index: alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.45
diff -u -r1.45 emu10k1_main.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	17 Mar 2005 15:55:16 -0000	1.45
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	21 Mar 2005 21:18:50 -0000
@@ -612,6 +612,144 @@
 	return snd_emu10k1_free(emu);
 }
 
+/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, driver, name */
+
+static emu_chip_details_t emu_chip_details[] = {
+	/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 0,
+	 .ca0108_chip = 1,
+	 .ca0151_chip = 0,
+	 .spk71 = 1,
+	 .spdif_bug = 0,
+	 .ac97_chip = 0,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]"} , 
+	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x00000000,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 0,
+	 .ca0108_chip = 1,
+	 .ca0151_chip = 0,
+	 .spk71 = 0,
+	 .spdif_bug = 0,
+	 .ac97_chip = 0,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20011102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10071102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 0,
+	 .spdif_bug = 1,
+	 .ac97_chip = 0,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 1,
+	 .spk71 = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]"} , 
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00000000,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 0,
+	 .spk71 = 0,
+	 .spdif_bug = 1,
+	 .ac97_chip = 0,
+	 .ecard = 0,
+	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]"} , 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
+	 .emu10k1_chip = 1,
+	 .emu10k2_chip = 0,
+	 .ca0102_chip = 0,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 0,
+	 .spk71 = 0,
+	 .spdif_bug = 0,
+	 .ac97_chip = 0,
+	 .ecard = 1,
+	 .driver = "EMU10K1", .name = "E-mu APS [4001]"} , 
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00000000,
+	 .emu10k1_chip = 1,
+	 .emu10k2_chip = 0,
+	 .ca0102_chip = 0,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 0,
+	 .spk71 = 0,
+	 .spdif_bug = 0,
+	 .ac97_chip = 1,
+	 .ecard = 0,
+	 .driver = "EMU10K1", .name = "SB Live [Unknown]"} , 
+	{.vendor = 0x0000, .device = 0x0000, .subsystem = 0x00000000,
+	 .emu10k1_chip = 0,
+	 .emu10k2_chip = 0,
+	 .ca0102_chip = 0,
+	 .ca0108_chip = 0,
+	 .ca0151_chip = 0,
+	 .spk71 = 0,
+	 .spdif_bug = 0,
+	 .ac97_chip = 0,
+	 .ecard = 0,
+	 .driver = "Unknown", .name = "Unknown"} , 
+};
+
 int __devinit snd_emu10k1_create(snd_card_t * card,
 		       struct pci_dev * pci,
 		       unsigned short extin_mask,
@@ -623,15 +761,14 @@
 	emu10k1_t *emu;
 	int err;
 	int is_audigy;
+	int entry_number;
+	emu_chip_details_t *c;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_emu10k1_dev_free,
 	};
 	
 	*remu = NULL;
 
-	// is_audigy = (int)pci->driver_data;
-	is_audigy = (pci->device == 0x0004) || ( (pci->device == 0x0008) );
-
 	/* enable PCI device */
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
@@ -641,15 +778,6 @@
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-	/* set the DMA transfer mask */
-	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
-	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
-	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
-		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
-		kfree(emu);
-		pci_disable_device(pci);
-		return -ENXIO;
-	}
 	emu->card = card;
 	spin_lock_init(&emu->reg_lock);
 	spin_lock_init(&emu->emu_lock);
@@ -664,7 +792,42 @@
 	emu->irq = -1;
 	emu->synth = NULL;
 	emu->get_synth_voice = NULL;
+	/* read revision & serial */
+	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&emu->revision);
+	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
+	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
+	emu->card_type = EMU10K1_CARD_CREATIVE;
+	snd_printk("vendor=0x%x, device=0x%x, subsystem_vendor_id=0x%x, subsystem_id=0x%x\n",pci->vendor, pci->device, emu->serial, emu->model);
 
+	entry_number=0;
+	for (c=emu_chip_details; c->vendor; c++) {
+		if ((c->vendor == pci->vendor) && (c->device == pci->device) ) {
+			if (c->subsystem == emu->serial) break;
+			if (c->subsystem == 0) break;
+		}
+		entry_number++;
+	}
+	emu->card_capabilities = c;
+	if (c->vendor == 0) {
+		snd_printk("Card not recognised\n");
+		kfree(emu);
+		pci_disable_device(pci);
+		return -ENOENT;
+	}
+	if (c->subsystem != 0) snd_printk("Sound card name=%s\n", c->name);
+	else snd_printk("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x\n", c->name, pci->vendor, pci->device, emu->serial);  
+	
+	// is_audigy = (int)pci->driver_data;
+	is_audigy = (pci->device == 0x0004) || ( (pci->device == 0x0008) );
+	/* set the DMA transfer mask */
+	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
+	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
+	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
+		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
+		kfree(emu);
+		pci_disable_device(pci);
+		return -ENXIO;
+	}
 	emu->audigy = is_audigy;
 	if (is_audigy)
 		emu->gpr_base = A_FXGPREGBASE;
@@ -711,11 +874,7 @@
 	emu->memhdr->block_extra_size = sizeof(emu10k1_memblk_t) - sizeof(snd_util_memblk_t);
 
 	pci_set_master(pci);
-	/* read revision & serial */
-	pci_read_config_byte(pci, PCI_REVISION_ID, (char *)&emu->revision);
-	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
-	emu->card_type = EMU10K1_CARD_CREATIVE;
+
 	if (emu->serial == 0x40011102) {
 		emu->card_type = EMU10K1_CARD_EMUAPS;
 		emu->APS = 1;

--------------070301090504080805030908--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
