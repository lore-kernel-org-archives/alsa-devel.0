From: "buzzbuzz2@hotmail.com" <buzzbuzz2@hotmail.com>
Subject: [PATCH] Add framework for better audigy sound card capabilities selection.
Date: Fri, 18 Mar 2005 20:04:47 +0000
Message-ID: <423B345F.3000901@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020803050804030900020706"
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net [194.217.242.89])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5EDA247
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2005 21:04:48 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1DCNg5-000AqZ-4z
	for alsa-devel@alsa-project.org; Fri, 18 Mar 2005 20:02:37 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
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
--------------020803050804030900020706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds more options to help identify all the many different 
creative sound cards. It will eventually be used to control features 
more finely.

Signed off: James Courtier-Dutton



P.S. The reason for this patch is that there are so many different 
Creative sound cards now, that we have to write too many exception cases 
for each card. For example, the Audigy 1 does not have the P16V chip, 
and the Audigy 2 has it. The Audigy 2 Value does not have a P16V chip, 
but has all the features of the P16V chip, but only uses a different set 
of registers, so different code will be needed to support it. This patch 
adds a simple matrix, so when a new sound card arrives, we just add a 
new line to the matrix table, and the driver will work with it, instead 
of having to go all through the drivers code adding more and more if 
statements.

--------------020803050804030900020706
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
+++ alsa-driver/alsa-kernel/include/emu10k1.h	18 Mar 2005 19:55:33 -0000
@@ -1035,6 +1035,22 @@
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
+	char * name;
+} emu_chip_details_t;
+
 struct _snd_emu10k1 {
 	int irq;
 
Index: alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.44
diff -u -r1.44 emu10k1_main.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	13 Mar 2005 12:17:08 -0000	1.44
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	18 Mar 2005 19:55:33 -0000
@@ -611,6 +611,22 @@
 	return snd_emu10k1_free(emu);
 }
 
+/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, name */
+
+static emu_chip_details_t emu_chip_details[] = {
+	{ 0x1102, 0x0008, 0x10011102, 0, 1, 0, 1, 0, 1, 0, 0, 0, "Audigy 2 Value [SB0400]"} ,
+	{ 0x1102, 0x0008, 0x00000000, 0, 1, 0, 1, 0, 0, 0, 0, 0, "Audigy 2 Value [Unknown]"} ,
+	{ 0x1102, 0x0004, 0x20071102, 0, 1, 1, 0, 1, 1, 0, 1, 0, "Audigy 4 PRO [SB0380]"} ,
+	{ 0x1102, 0x0004, 0x20021102, 0, 1, 1, 0, 1, 1, 0, 1, 0, "Audigy 2 ZS [2002]"} ,
+	{ 0x1102, 0x0004, 0x20011102, 0, 1, 1, 0, 1, 1, 0, 1, 0, "Audigy 2 ZS [2001]"} ,
+	{ 0x1102, 0x0004, 0x10071102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy 2 [SB0240]"} ,
+	{ 0x1102, 0x0004, 0x10051102, 0, 1, 1, 0, 1, 0, 0, 0, 0, "Audigy 2 EX [1005]"} ,
+	{ 0x1102, 0x0004, 0x00000000, 0, 1, 1, 0, 0, 0, 1, 0, 0, "Audigy 1 or 2 [Unknown]"} ,
+	{ 0x1102, 0x0002, 0x40011102, 1, 0, 0, 0, 0, 0, 0, 0, 1, "E-mu APS [4001]"} ,
+	{ 0x1102, 0x0002, 0x00000000, 1, 0, 0, 0, 0, 0, 0, 1, 0, "SB Live [Unknown]"} ,
+	{ 0x0000, 0x0000, 0x00000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Unknown"} ,
+};
+
 int __devinit snd_emu10k1_create(snd_card_t * card,
 		       struct pci_dev * pci,
 		       unsigned short extin_mask,
@@ -622,15 +638,14 @@
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
@@ -640,15 +655,6 @@
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
@@ -663,7 +669,35 @@
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
@@ -710,11 +744,7 @@
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
 	

--------------020803050804030900020706--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
