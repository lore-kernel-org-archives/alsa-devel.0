From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Fixes AC3 output on Audigy2 sound cards.
Date: Sat, 19 Mar 2005 14:03:26 +0000
Message-ID: <423C312E.7010503@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000306030907020508050402"
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

This is a multi-part message in MIME format.
--------------000306030907020508050402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch adds a DSP patch to fix an spdif_bug on some Audigy2 cards.
It also does detailed identification of the capabilities of the sound 
card so that the patch is only applied to the sound cards that really 
need it.

Signed off: James Courtier-Dutton



The Audigy2.conf file must be placed in alsa-lib.  /usr/share/alsa/cards.
audigy-ac3-fix.diff.txt is a patch against the current CVS.

--------------000306030907020508050402
Content-Type: text/plain;
 name="Audigy2.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Audigy2.conf"

#
# Configuration for the Audigy2 chip
#

<confdir:pcm/front.conf>

Audigy2.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0 ]
			}
						{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 8 9 0 0 0 0 0 0  8 9 0 0 0 0 0 0  8 9 0 0 0 0 0 0 ]
			}

		]
	}

}	

<confdir:pcm/rear.conf>

Audigy2.pcm.rear.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 255 255 0 0 0 0  0 0 255 0 0 0 0 0  0 0 0 255 0 0 0 0 ]
			}
		]
	}
}	

<confdir:pcm/center_lfe.conf>

Audigy2.pcm.center_lfe.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 6 7 0 0 0 0 0 0  6 7 0 0 0 0 0 0  6 7 0 0 0 0 0 0 ]
			}
		]
	}
}

<confdir:pcm/side.conf>

Audigy2.pcm.side.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 14 15 0 0 0 0 0 0  14 15 0 0 0 0 0 0  14 15 0 0 0 0 0 0 ]
			}
		]
	}
}

<confdir:pcm/surround40.conf>
<confdir:pcm/surround41.conf>
<confdir:pcm/surround50.conf>

Audigy2.pcm.surround40.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
	]
}

<confdir:pcm/surround51.conf>

Audigy2.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.center_lfe.0:CARD=" $CARD
				]
			}
			channels 2
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
		{ slave 2 channel 0 }
		{ slave 2 channel 1 }
	]
}

<confdir:pcm/surround71.conf>

Audigy2.pcm.surround71.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.center_lfe.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.side.0:CARD=" $CARD
				]
			}
			channels 2
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
		{ slave 2 channel 0 }
		{ slave 2 channel 1 }
		{ slave 3 channel 0 }
		{ slave 3 channel 1 }
	]
}

<confdir:pcm/iec958.conf>

Audigy2.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.AES0 {
		type integer
	}
	@args.AES1 {
		type integer
	}
	@args.AES2 {
		type integer
	}
	@args.AES3 {
		type integer
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}

	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "IEC958 Playback Default"
				preserve true
				value [ $AES0 $AES1 $AES2 $AES3 ]
			}
			{
				name "IEC958 Optical Raw Playback Switch"
				lock true
				preserve true
				value [ 1 1 ]
			}
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 20 21 0 0 0 0 0 0  20 21 0 0 0 0 0 0   20 21 0 0 0 0 0 0 ]
			}
			{
				name "Audigy Analog/Digital Output Jack"
				lock true
				preserve true
				value 1
			}
		]
	}
}

--------------000306030907020508050402
Content-Type: text/plain;
 name="audigy-ac3-fix.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy-ac3-fix.diff.txt"

Index: alsa-driver/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.59
diff -u -r1.59 emu10k1.h
--- alsa-driver/alsa-kernel/include/emu10k1.h	13 Mar 2005 12:17:08 -0000	1.59
+++ alsa-driver/alsa-kernel/include/emu10k1.h	19 Mar 2005 13:56:50 -0000
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
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c	19 Mar 2005 13:56:50 -0000
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
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1_main.c	19 Mar 2005 13:56:50 -0000
@@ -612,6 +612,23 @@
 	return snd_emu10k1_free(emu);
 }
 
+/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, driver, name */
+
+static emu_chip_details_t emu_chip_details[] = {
+	{ 0x1102, 0x0008, 0x10011102, 0, 1, 0, 1, 0, 1, 0, 0, 0, "Audigy2", "Audigy 2 Value [SB0400]"} , /* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
+	{ 0x1102, 0x0008, 0x00000000, 0, 1, 0, 1, 0, 0, 0, 0, 0, "Audigy2", "Audigy 2 Value [Unknown]"} ,
+	{ 0x1102, 0x0004, 0x20071102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy2", "Audigy 4 PRO [SB0380]"} ,
+	{ 0x1102, 0x0004, 0x20021102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy2", "Audigy 2 ZS [SB0350]"} ,
+	{ 0x1102, 0x0004, 0x20011102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy2", "Audigy 2 ZS [2001]"} , /* Might have spdif_bug */
+	{ 0x1102, 0x0004, 0x10071102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy2", "Audigy 2 [SB0240]"} ,
+	{ 0x1102, 0x0004, 0x10051102, 0, 1, 1, 0, 1, 0, 1, 0, 0, "Audigy2", "Audigy 2 EX [1005]"} , /* Might have spdif_bug */
+	{ 0x1102, 0x0004, 0x10021102, 0, 1, 1, 0, 1, 1, 1, 1, 0, "Audigy2", "Audigy 2 Platinum [SB0240P]"} ,
+	{ 0x1102, 0x0004, 0x00000000, 0, 1, 1, 0, 0, 0, 1, 0, 0, "Audigy", "Audigy 1 or 2 [Unknown]"} ,
+	{ 0x1102, 0x0002, 0x40011102, 1, 0, 0, 0, 0, 0, 0, 0, 1, "EMU10K1", "E-mu APS [4001]"} ,
+	{ 0x1102, 0x0002, 0x00000000, 1, 0, 0, 0, 0, 0, 0, 1, 0, "EMU10K1", "SB Live [Unknown]"} ,
+	{ 0x0000, 0x0000, 0x00000000, 0, 0, 0, 0, 0, 0, 0, 0, 0, "Unknown"} ,
+};
+
 int __devinit snd_emu10k1_create(snd_card_t * card,
 		       struct pci_dev * pci,
 		       unsigned short extin_mask,
@@ -623,15 +640,14 @@
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
@@ -641,15 +657,6 @@
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
@@ -664,7 +671,42 @@
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
@@ -711,11 +753,7 @@
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
Index: alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.69
diff -u -r1.69 emufx.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emufx.c	17 Feb 2005 14:51:52 -0000	1.69
+++ alsa-driver/alsa-kernel/pci/emu10k1/emufx.c	19 Mar 2005 13:56:51 -0000
@@ -1339,6 +1339,7 @@
 	/* A_PUT_STEREO_OUTPUT(A_EXTOUT_FRONT_L, A_EXTOUT_FRONT_R, playback + SND_EMU10K1_PLAYBACK_CHANNELS); */
 
 	/* IEC958 Optical Raw Playback Switch */ 
+	gpr_map[gpr++] = 0;
 	gpr_map[gpr++] = 0x1008;
 	gpr_map[gpr++] = 0xffff0000;
 	for (z = 0; z < 2; z++) {
@@ -1349,7 +1350,14 @@
 		A_SWITCH(icode, &ptr, tmp + 0, tmp + 2, gpr + z);
 		A_SWITCH_NEG(icode, &ptr, tmp + 1, gpr + z);
 		A_SWITCH(icode, &ptr, tmp + 1, playback + SND_EMU10K1_PLAYBACK_CHANNELS + z, tmp + 1);
-		A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		if ((z==1) && (emu->card_capabilities->spdif_bug)) {
+			/* Due to a SPDIF output bug on some Audigy cards, this code delays the Right channel by 1 sample */
+			snd_printk("Installing spdif_bug patch: %s\n", emu->card_capabilities->name);
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(gpr - 3), A_C_00000000, A_C_00000000);
+			A_OP(icode, &ptr, iACC3, A_GPR(gpr - 3), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		} else {
+			A_OP(icode, &ptr, iACC3, A_EXTOUT(A_EXTOUT_FRONT_L + z), A_GPR(tmp + 0), A_GPR(tmp + 1), A_C_00000000);
+		}
 	}
 	snd_emu10k1_init_stereo_onoff_control(controls + nctl++, "IEC958 Optical Raw Playback Switch", gpr, 0);
 	gpr += 2;

--------------000306030907020508050402--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
