From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1 cleanups
Date: Sun, 29 May 2005 00:06:10 -0400
Message-ID: <1117339570.19303.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

I hacked this up quickly, please review.

Some of these should probably be macros, like 

    IS_AUDIGY2(emu) 

for 

    emu->card_capabilities->ca0108_chip || emu->card_capabilities->ca0151_chip

etc.

This will break binary compatibility as some redundant struct members have been removed.

Lee

Index: alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.68
diff -u -r1.68 emu10k1.h
--- alsa-kernel/include/emu10k1.h	7 May 2005 14:34:13 -0000	1.68
+++ alsa-kernel/include/emu10k1.h	29 May 2005 04:02:10 -0000
@@ -1062,7 +1062,7 @@
 	unsigned char emu10k2_chip; /* Audigy 1 or Audigy 2. */
 	unsigned char ca0102_chip;  /* Audigy 1 or Audigy 2. Not SB Audigy 2 Value. */
 	unsigned char ca0108_chip;  /* Audigy 2 Value */
-	unsigned char ca0151_chip;  /* P16V */
+	unsigned char ca0151_chip;  /* Audigy 2.  Not SB Audigy 2 Value.  AKA P16V */
 	unsigned char spk71;        /* Has 7.1 speakers */
 	unsigned char sblive51;	    /* SBLive! 5.1 - extout 0x11 -> center, 0x12 -> lfe */
 	unsigned char spdif_bug;    /* Has Spdif phasing bug */
@@ -1080,7 +1080,6 @@
 	unsigned int tos_link: 1,		/* tos link detected */
 	    rear_ac97: 1;			/* rear channels are on AC'97 */
 	const emu_chip_details_t *card_capabilities;	/* Contains profile of card capabilities */
-	unsigned int audigy;			/* is Audigy? */
 	unsigned int revision;			/* chip revision */
 	unsigned int serial;			/* serial number */
 	unsigned short model;			/* subsystem id */
Index: alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.36
diff -u -r1.36 emu10k1.c
--- alsa-kernel/pci/emu10k1/emu10k1.c	11 Apr 2005 15:58:28 -0000	1.36
+++ alsa-kernel/pci/emu10k1/emu10k1.c	29 May 2005 04:02:11 -0000
@@ -140,7 +140,7 @@
 		return err;
 	}
 	/* This stores the periods table. */
-	if (emu->audigy && emu->revision == 4) { /* P16V */	
+	if (emu->card_capabilities->ca0108_chip || emu->card_capabilities->ca0151_chip) { /* P16V */	
 		if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &emu->p16v_buffer) < 0) {
 			snd_p16v_free(emu);
 			return -ENOMEM;
@@ -161,13 +161,13 @@
 		snd_card_free(card);
 		return err;
 	}
-	if (emu->audigy && emu->revision == 4) { /* P16V */	
+	if (emu->card_capabilities->ca0108_chip || emu->card_capabilities->ca0151_chip) { /* P16V */	
 		if ((err = snd_p16v_pcm(emu, 4, NULL)) < 0) {
 			snd_card_free(card);
 			return err;
 		}
 	}
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
 			snd_card_free(card);
 			return err;
Index: alsa-kernel/pci/emu10k1/emu10k1_callback.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_callback.c,v
retrieving revision 1.13
diff -u -r1.13 emu10k1_callback.c
--- alsa-kernel/pci/emu10k1/emu10k1_callback.c	16 Feb 2005 10:25:36 -0000	1.13
+++ alsa-kernel/pci/emu10k1/emu10k1_callback.c	29 May 2005 04:02:11 -0000
@@ -338,7 +338,7 @@
 
 	/* set channel routing */
 	/* A = left(0), B = right(1), C = reverb(c), D = chorus(d) */
-	if (hw->audigy) {
+	if (hw->card_capabilities->emu10k2_chip) {
 		temp = FXBUS_MIDI_LEFT | (FXBUS_MIDI_RIGHT << 8) | 
 			(FXBUS_MIDI_REVERB << 16) | (FXBUS_MIDI_CHORUS << 24);
 		snd_emu10k1_ptr_write(hw, A_FXRT1, ch, temp);
Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.57
diff -u -r1.57 emu10k1_main.c
--- alsa-kernel/pci/emu10k1/emu10k1_main.c	27 May 2005 11:31:34 -0000	1.57
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	29 May 2005 04:02:12 -0000
@@ -85,7 +85,7 @@
 	snd_emu10k1_ptr_write(emu, ENVVAL, ch, 0);
 
 	/* Audigy extra stuffs */
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		snd_emu10k1_ptr_write(emu, 0x4c, ch, 0); /* ?? */
 		snd_emu10k1_ptr_write(emu, 0x4d, ch, 0); /* ?? */
 		snd_emu10k1_ptr_write(emu, 0x4e, ch, 0); /* ?? */
@@ -123,7 +123,7 @@
 	snd_emu10k1_ptr_write(emu, SOLEL, 0, 0);
 	snd_emu10k1_ptr_write(emu, SOLEH, 0, 0);
 
-	if (emu->audigy){
+	if (emu->card_capabilities->emu10k2_chip){
 		/* set SPDIF bypass mode */
 		snd_emu10k1_ptr_write(emu, SPBYPASS, 0, SPBYPASS_FORMAT);
 		/* enable rear left + rear right AC97 slots */
@@ -190,8 +190,7 @@
 		outl(0x0201, emu->port + HCFG2);
 		/* Set playback routing. */
 		snd_emu10k1_ptr20_write(emu, CAPTURE_P16V_SOURCE, 0, 0x78e4);
-	}
-	if (emu->audigy && (emu->serial == 0x10011102) ) { /* audigy2 Value */
+	} else if (emu->card_capabilities->ca0108_chip ) { /* audigy2 Value */
 		/* Hacks for Alice3 to work independent of haP16V driver */
 		u32 tmp;
 
@@ -245,15 +244,15 @@
 	 *   Lock Sound Memory = 0
 	 *   Auto Mute = 1
 	 */
-	if (emu->audigy) {
-		if (emu->revision == 4) /* audigy2 */
+	if (emu->card_capabilities->emu10k2_chip) {
+		if (emu->card_capabilities->ca0108_chip || emu->card_capabilities->ca0151_chip) /* audigy2 [value] */
 			outl(HCFG_AUDIOENABLE |
 			     HCFG_AC3ENABLE_CDSPDIF |
 			     HCFG_AC3ENABLE_GPSPDIF |
 			     HCFG_AUTOMUTE | HCFG_JOYENABLE, emu->port + HCFG);
-		else
+		else									/* audigy1 */
 			outl(HCFG_AUTOMUTE | HCFG_JOYENABLE, emu->port + HCFG);
-	} else if (emu->model == 0x20 ||
+	} else if (emu->model == 0x20 ||						/* FIXME - use card caps for this */
 	    emu->model == 0xc400 ||
 	    (emu->model == 0x21 && emu->revision < 6))
 		outl(HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE, emu->port + HCFG);
@@ -262,7 +261,7 @@
 		outl(HCFG_LOCKTANKCACHE_MASK | HCFG_AUTOMUTE | HCFG_JOYENABLE, emu->port + HCFG);
 
 	if (enable_ir) {	/* enable IR for SB Live */
-		if (emu->audigy) {
+		if (emu->card_capabilities->emu10k2_chip) {
 			unsigned int reg = inl(emu->port + A_IOCFG);
 			outl(reg | A_IOCFG_GPOUT2, emu->port + A_IOCFG);
 			udelay(500);
@@ -279,10 +278,8 @@
  		}
 	}
 	
-	if (emu->audigy) {	/* enable analog output */
-		unsigned int reg = inl(emu->port + A_IOCFG);
-		outl(reg | A_IOCFG_GPOUT0, emu->port + A_IOCFG);
-	}
+	if (emu->card_capabilities->emu10k2_chip)	/* enable analog output */
+		outl(inl(emu->port + A_IOCFG) | A_IOCFG_GPOUT0, emu->port + A_IOCFG);
 
 	/*
 	 *  Initialize the effect engine
@@ -296,15 +293,15 @@
 	outl(inl(emu->port + HCFG) | HCFG_AUDIOENABLE, emu->port + HCFG);
 
 	/* Enable analog/digital outs on audigy */
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		outl(inl(emu->port + A_IOCFG) & ~0x44, emu->port + A_IOCFG);
  
-		if (emu->revision == 4) { /* audigy2 */
+		if (emu->card_capabilities->ca0151_chip) { /* audigy2 */
 			/* Unmute Analog now.  Set GPO6 to 1 for Apollo.
 			 * This has to be done after init ALice3 I2SOut beyond 48KHz.
 			 * So, sequence is important. */
 			outl(inl(emu->port + A_IOCFG) | 0x0040, emu->port + A_IOCFG);
-		} else if (emu->serial == 0x10011102) { /* audigy2 value */
+		} else if (emu->card_capabilities->ca0108_chip) { /* audigy2 value */
 			/* Unmute Analog now. */
 			outl(inl(emu->port + A_IOCFG) | 0x0060, emu->port + A_IOCFG);
 		} else {
@@ -368,7 +365,7 @@
 	snd_emu10k1_ptr_write(emu, ADCBA, 0, 0);
 	snd_emu10k1_ptr_write(emu, TCBS, 0, TCBS_BUFFSIZE_16K);
 	snd_emu10k1_ptr_write(emu, TCB, 0, 0);
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		snd_emu10k1_ptr_write(emu, A_DBG, 0, A_DBG_SINGLE_STEP);
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, EMU10K1_DBG_SINGLE_STEP);
@@ -759,7 +756,6 @@
 {
 	emu10k1_t *emu;
 	int err;
-	int is_audigy;
 	unsigned char revision;
 	const emu_chip_details_t *c;
 	static snd_device_ops_t ops = {
@@ -836,10 +832,8 @@
 		}
 	}
 
-	is_audigy = emu->audigy = c->emu10k2_chip;
-
 	/* set the DMA transfer mask */
-	emu->dma_mask = is_audigy ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
+	emu->dma_mask = emu->card_capabilities->emu10k2_chip ? AUDIGY_DMA_MASK : EMU10K1_DMA_MASK;
 	if (pci_set_dma_mask(pci, emu->dma_mask) < 0 ||
 	    pci_set_consistent_dma_mask(pci, emu->dma_mask) < 0) {
 		snd_printk(KERN_ERR "architecture does not support PCI busmaster DMA with mask 0x%lx\n", emu->dma_mask);
@@ -847,10 +841,8 @@
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
-	if (is_audigy)
-		emu->gpr_base = A_FXGPREGBASE;
-	else
-		emu->gpr_base = FXGPREGBASE;
+
+	emu->gpr_base = emu->card_capabilities->emu10k2_chip ? A_FXGPREGBASE : FXGPREGBASE;
 
 	if ((err = pci_request_regions(pci, "EMU10K1")) < 0) {
 		kfree(emu);
Index: alsa-kernel/pci/emu10k1/emu10k1_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_synth.c,v
retrieving revision 1.10
diff -u -r1.10 emu10k1_synth.c
--- alsa-kernel/pci/emu10k1/emu10k1_synth.c	22 Nov 2004 18:36:05 -0000	1.10
+++ alsa-kernel/pci/emu10k1/emu10k1_synth.c	29 May 2005 04:02:12 -0000
@@ -56,7 +56,7 @@
 	emu->pitch_shift = -501;
 	emu->memhdr = hw->memhdr;
 	emu->midi_ports = arg->seq_ports < 2 ? arg->seq_ports : 2; /* maximum two ports */
-	emu->midi_devidx = hw->audigy ? 2 : 1; /* audigy has two external midis */
+	emu->midi_devidx = hw->card_capabilities->emu10k2_chip ? 2 : 1; /* audigy has two external midis */
 	emu->linear_panning = 0;
 	emu->hwdep_idx = 2; /* FIXED */
 
Index: alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.74
diff -u -r1.74 emufx.c
--- alsa-kernel/pci/emu10k1/emufx.c	30 Mar 2005 12:51:19 -0000	1.74
+++ alsa-kernel/pci/emu10k1/emufx.c	29 May 2005 04:02:14 -0000
@@ -497,13 +497,13 @@
 
 static void snd_emu10k1_efx_write(emu10k1_t *emu, unsigned int pc, unsigned int data)
 {
-	pc += emu->audigy ? A_MICROCODEBASE : MICROCODEBASE;
+	pc += emu->card_capabilities->emu10k2_chip ? A_MICROCODEBASE : MICROCODEBASE;
 	snd_emu10k1_ptr_write(emu, pc, 0, data);
 }
 
 unsigned int snd_emu10k1_efx_read(emu10k1_t *emu, unsigned int pc)
 {
-	pc += emu->audigy ? A_MICROCODEBASE : MICROCODEBASE;
+	pc += emu->card_capabilities->emu10k2_chip ? A_MICROCODEBASE : MICROCODEBASE;
 	return snd_emu10k1_ptr_read(emu, pc, 0);
 }
 
@@ -512,7 +512,7 @@
 	int gpr;
 	u32 val;
 
-	for (gpr = 0; gpr < (emu->audigy ? 0x200 : 0x100); gpr++) {
+	for (gpr = 0; gpr < (emu->card_capabilities->emu10k2_chip ? 0x200 : 0x100); gpr++) {
 		if (!test_bit(gpr, icode->gpr_valid))
 			continue;
 		if (get_user(val, &icode->gpr_map[gpr]))
@@ -527,7 +527,7 @@
 	int gpr;
 	u32 val;
 
-	for (gpr = 0; gpr < (emu->audigy ? 0x200 : 0x100); gpr++) {
+	for (gpr = 0; gpr < (emu->card_capabilities->emu10k2_chip ? 0x200 : 0x100); gpr++) {
 		set_bit(gpr, icode->gpr_valid);
 		val = snd_emu10k1_ptr_read(emu, emu->gpr_base + gpr, 0);
 		if (put_user(val, &icode->gpr_map[gpr]))
@@ -541,14 +541,14 @@
 	int tram;
 	u32 addr, val;
 
-	for (tram = 0; tram < (emu->audigy ? 0x100 : 0xa0); tram++) {
+	for (tram = 0; tram < (emu->card_capabilities->emu10k2_chip ? 0x100 : 0xa0); tram++) {
 		if (!test_bit(tram, icode->tram_valid))
 			continue;
 		if (get_user(val, &icode->tram_data_map[tram]) ||
 		    get_user(addr, &icode->tram_addr_map[tram]))
 			return -EFAULT;
 		snd_emu10k1_ptr_write(emu, TANKMEMDATAREGBASE + tram, 0, val);
-		if (!emu->audigy) {
+		if (!emu->card_capabilities->emu10k2_chip) {
 			snd_emu10k1_ptr_write(emu, TANKMEMADDRREGBASE + tram, 0, addr);
 		} else {
 			snd_emu10k1_ptr_write(emu, TANKMEMADDRREGBASE + tram, 0, addr << 12);
@@ -564,10 +564,10 @@
 	u32 val, addr;
 
 	memset(icode->tram_valid, 0, sizeof(icode->tram_valid));
-	for (tram = 0; tram < (emu->audigy ? 0x100 : 0xa0); tram++) {
+	for (tram = 0; tram < (emu->card_capabilities->emu10k2_chip ? 0x100 : 0xa0); tram++) {
 		set_bit(tram, icode->tram_valid);
 		val = snd_emu10k1_ptr_read(emu, TANKMEMDATAREGBASE + tram, 0);
-		if (!emu->audigy) {
+		if (!emu->card_capabilities->emu10k2_chip) {
 			addr = snd_emu10k1_ptr_read(emu, TANKMEMADDRREGBASE + tram, 0);
 		} else {
 			addr = snd_emu10k1_ptr_read(emu, TANKMEMADDRREGBASE + tram, 0) >> 12;
@@ -584,7 +584,7 @@
 {
 	u32 pc, lo, hi;
 
-	for (pc = 0; pc < (emu->audigy ? 2*1024 : 2*512); pc += 2) {
+	for (pc = 0; pc < (emu->card_capabilities->emu10k2_chip ? 2*1024 : 2*512); pc += 2) {
 		if (!test_bit(pc / 2, icode->code_valid))
 			continue;
 		if (get_user(lo, &icode->code[pc + 0]) ||
@@ -601,7 +601,7 @@
 	u32 pc;
 
 	memset(icode->code_valid, 0, sizeof(icode->code_valid));
-	for (pc = 0; pc < (emu->audigy ? 2*1024 : 2*512); pc += 2) {
+	for (pc = 0; pc < (emu->card_capabilities->emu10k2_chip ? 2*1024 : 2*512); pc += 2) {
 		set_bit(pc / 2, icode->code_valid);
 		if (put_user(snd_emu10k1_efx_read(emu, pc + 0), &icode->code[pc + 0]))
 			return -EFAULT;
@@ -851,7 +851,7 @@
 	strlcpy(emu->fx8010.name, icode->name, sizeof(emu->fx8010.name));
 	/* stop FX processor - this may be dangerous, but it's better to miss
 	   some samples than generate wrong ones - [jk] */
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg | A_DBG_SINGLE_STEP);
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg | EMU10K1_DBG_SINGLE_STEP);
@@ -863,7 +863,7 @@
 	    (err = snd_emu10k1_add_controls(emu, icode)) < 0)
 		goto __error;
 	/* start FX processor when the DSP code is updated */
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg);
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg);
@@ -2040,7 +2040,7 @@
 
 int __devinit snd_emu10k1_init_efx(emu10k1_t *emu)
 {
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		return _snd_emu10k1_audigy_init_efx(emu);
 	else
 		return _snd_emu10k1_init_efx(emu);
@@ -2049,7 +2049,7 @@
 void snd_emu10k1_free_efx(emu10k1_t *emu)
 {
 	/* stop processor */
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg = A_DBG_SINGLE_STEP);
 	else
 		snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg = EMU10K1_DBG_SINGLE_STEP);
@@ -2136,8 +2136,8 @@
 	info->internal_tram_size = emu->fx8010.itram_size;
 	info->external_tram_size = emu->fx8010.etram_pages.bytes / 2;
 	fxbus = fxbuses;
-	extin = emu->audigy ? audigy_ins : creative_ins;
-	extout = emu->audigy ? audigy_outs : creative_outs;
+	extin = emu->card_capabilities->emu10k2_chip ? audigy_ins : creative_ins;
+	extout = emu->card_capabilities->emu10k2_chip ? audigy_outs : creative_outs;
 	fxbus_mask = emu->fx8010.fxbus_mask;
 	extin_mask = emu->fx8010.extin_mask;
 	extout_mask = emu->fx8010.extout_mask;
@@ -2243,7 +2243,7 @@
 	case SNDRV_EMU10K1_IOCTL_STOP:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP);
@@ -2251,7 +2251,7 @@
 	case SNDRV_EMU10K1_IOCTL_CONTINUE:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg = 0);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg = 0);
@@ -2259,12 +2259,12 @@
 	case SNDRV_EMU10K1_IOCTL_ZERO_TRAM_COUNTER:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg | A_DBG_ZC);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg | EMU10K1_DBG_ZC);
 		udelay(10);
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg);
@@ -2276,18 +2276,18 @@
 			return -EFAULT;
 		if (addr > 0x1ff)
 			return -EINVAL;
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP | addr);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP | addr);
 		udelay(10);
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_emu10k1_ptr_write(emu, A_DBG, 0, emu->fx8010.dbg |= A_DBG_SINGLE_STEP | A_DBG_STEP_ADDR | addr);
 		else
 			snd_emu10k1_ptr_write(emu, DBG, 0, emu->fx8010.dbg |= EMU10K1_DBG_SINGLE_STEP | EMU10K1_DBG_STEP | addr);
 		return 0;
 	case SNDRV_EMU10K1_IOCTL_DBG_READ:
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			addr = snd_emu10k1_ptr_read(emu, A_DBG, 0);
 		else
 			addr = snd_emu10k1_ptr_read(emu, DBG, 0);
Index: alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.37
diff -u -r1.37 emumixer.c
--- alsa-kernel/pci/emu10k1/emumixer.c	11 Apr 2005 16:03:03 -0000	1.37
+++ alsa-kernel/pci/emu10k1/emumixer.c	29 May 2005 04:02:14 -0000
@@ -201,7 +201,7 @@
 
 static void update_emu10k1_fxrt(emu10k1_t *emu, int voice, unsigned char *route)
 {
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		snd_emu10k1_ptr_write(emu, A_FXRT1, voice,
 				      snd_emu10k1_compose_audigy_fxrt1(route));
 		snd_emu10k1_ptr_write(emu, A_FXRT2, voice,
@@ -218,7 +218,7 @@
 	snd_emu10k1_ptr_write(emu, PTRX_FXSENDAMOUNT_B, voice, volume[1]);
 	snd_emu10k1_ptr_write(emu, PSST_FXSENDAMOUNT_C, voice, volume[2]);
 	snd_emu10k1_ptr_write(emu, DSL_FXSENDAMOUNT_D, voice, volume[3]);
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		unsigned int val = ((unsigned int)volume[4] << 24) |
 			((unsigned int)volume[5] << 16) |
 			((unsigned int)volume[6] << 8) |
@@ -233,9 +233,9 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = emu->audigy ? 3*8 : 3*4;
+	uinfo->count = emu->card_capabilities->emu10k2_chip ? 3*8 : 3*4;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = emu->audigy ? 0x3f : 0x0f;
+	uinfo->value.integer.max = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 	return 0;
 }
 
@@ -246,8 +246,8 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int voice, idx;
-	int num_efx = emu->audigy ? 8 : 4;
-	int mask = emu->audigy ? 0x3f : 0x0f;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
+	int mask = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (voice = 0; voice < 3; voice++)
@@ -265,8 +265,8 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int change = 0, voice, idx, val;
-	int num_efx = emu->audigy ? 8 : 4;
-	int mask = emu->audigy ? 0x3f : 0x0f;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
+	int mask = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (voice = 0; voice < 3; voice++)
@@ -307,7 +307,7 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = emu->audigy ? 3*8 : 3*4;
+	uinfo->count = emu->card_capabilities->emu10k2_chip ? 3*8 : 3*4;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = 255;
 	return 0;
@@ -320,7 +320,7 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int idx;
-	int num_efx = emu->audigy ? 8 : 4;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < 3*num_efx; idx++)
@@ -336,7 +336,7 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int change = 0, idx, val;
-	int num_efx = emu->audigy ? 8 : 4;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < 3*num_efx; idx++) {
@@ -441,9 +441,9 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = emu->audigy ? 8 : 4;
+	uinfo->count = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 	uinfo->value.integer.min = 0;
-	uinfo->value.integer.max = emu->audigy ? 0x3f : 0x0f;
+	uinfo->value.integer.max = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 	return 0;
 }
 
@@ -454,8 +454,8 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int idx;
-	int num_efx = emu->audigy ? 8 : 4;
-	int mask = emu->audigy ? 0x3f : 0x0f;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
+	int mask = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < num_efx; idx++)
@@ -473,8 +473,8 @@
 	int ch = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[ch];
 	int change = 0, idx, val;
-	int num_efx = emu->audigy ? 8 : 4;
-	int mask = emu->audigy ? 0x3f : 0x0f;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
+	int mask = emu->card_capabilities->emu10k2_chip ? 0x3f : 0x0f;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < num_efx; idx++) {
@@ -510,7 +510,7 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = emu->audigy ? 8 : 4;
+	uinfo->count = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 	uinfo->value.integer.min = 0;
 	uinfo->value.integer.max = 255;
 	return 0;
@@ -523,7 +523,7 @@
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[snd_ctl_get_ioffidx(kcontrol, &ucontrol->id)];
 	int idx;
-	int num_efx = emu->audigy ? 8 : 4;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < num_efx; idx++)
@@ -540,7 +540,7 @@
 	int ch = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	emu10k1_pcm_mixer_t *mix = &emu->efx_pcm_mixer[ch];
 	int change = 0, idx, val;
-	int num_efx = emu->audigy ? 8 : 4;
+	int num_efx = emu->card_capabilities->emu10k2_chip ? 8 : 4;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
 	for (idx = 0; idx < num_efx; idx++) {
@@ -643,7 +643,7 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		ucontrol->value.integer.value[0] = inl(emu->port + A_IOCFG) & A_IOCFG_GPOUT0 ? 1 : 0;
 	else
 		ucontrol->value.integer.value[0] = inl(emu->port + HCFG) & HCFG_GPOUT0 ? 1 : 0;
@@ -659,7 +659,7 @@
 	int change = 0;
 
 	spin_lock_irqsave(&emu->reg_lock, flags);
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		reg = inl(emu->port + A_IOCFG);
 		val = ucontrol->value.integer.value[0] ? A_IOCFG_GPOUT0 : 0;
 		change = (reg & A_IOCFG_GPOUT0) != val;
@@ -811,7 +811,7 @@
 		ac97.scaps = AC97_SCAP_NO_SPDIF;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &emu->ac97)) < 0)
 			return err;
-		if (emu->audigy) {
+		if (emu->card_capabilities->emu10k2_chip) {
 			/* set master volume to 0 dB */
 			snd_ac97_write(emu->ac97, AC97_MASTER, 0x0000);
 			/* set capture source to mic */
@@ -837,13 +837,13 @@
 	} else {
 		if (emu->card_capabilities->ecard)
 			strcpy(emu->card->mixername, "EMU APS");
-		else if (emu->audigy)
+		else if (emu->card_capabilities->emu10k2_chip)
 			strcpy(emu->card->mixername, "SB Audigy");
 		else
 			strcpy(emu->card->mixername, "Emu10k1");
 	}
 
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		c = audigy_rename_ctls;
 	else
 		c = emu10k1_rename_ctls;
@@ -910,7 +910,7 @@
 		mix->send_routing[0][1] = (pcm == 0) ? 1 : 0;
 		for (v = 0; v < 2; v++)
 			mix->send_routing[0][2+v] = 13+v;
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			for (v = 0; v < 4; v++)
 				mix->send_routing[0][4+v] = 60+v;
 		
@@ -932,7 +932,7 @@
 			return err;
 	}
 
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		if ((kctl = snd_ctl_new1(&snd_audigy_shared_spdif, emu)) == NULL)
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
Index: alsa-kernel/pci/emu10k1/emumpu401.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumpu401.c,v
retrieving revision 1.14
diff -u -r1.14 emumpu401.c
--- alsa-kernel/pci/emu10k1/emumpu401.c	21 Mar 2005 08:13:32 -0000	1.14
+++ alsa-kernel/pci/emu10k1/emumpu401.c	29 May 2005 04:02:14 -0000
@@ -30,7 +30,7 @@
 
 static inline unsigned char mpu401_read(emu10k1_t *emu, emu10k1_midi_t *mpu, int idx)
 {
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		return (unsigned char)snd_emu10k1_ptr_read(emu, mpu->port + idx, 0);
 	else
 		return inb(emu->port + mpu->port + idx);
@@ -38,7 +38,7 @@
 
 static inline void mpu401_write(emu10k1_t *emu, emu10k1_midi_t *mpu, int data, int idx)
 {
-	if (emu->audigy)
+	if (emu->card_capabilities->emu10k2_chip)
 		snd_emu10k1_ptr_write(emu, mpu->port + idx, 0, data);
 	else
 		outb(data, emu->port + mpu->port + idx);
Index: alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.47
diff -u -r1.47 emupcm.c
--- alsa-kernel/pci/emu10k1/emupcm.c	20 Apr 2005 09:03:31 -0000	1.47
+++ alsa-kernel/pci/emu10k1/emupcm.c	29 May 2005 04:02:16 -0000
@@ -336,7 +336,7 @@
 	}
 
 	// setup routing
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		snd_emu10k1_ptr_write(emu, A_FXRT1, voice,
 				      snd_emu10k1_compose_audigy_fxrt1(send_routing));
 		snd_emu10k1_ptr_write(emu, A_FXRT2, voice,
@@ -585,7 +585,7 @@
 		snd_emu10k1_ptr_write(emu, ADCCR, 0, 0);
 		break;
 	case CAPTURE_EFX:
-		if (emu->audigy) {
+		if (emu->card_capabilities->emu10k2_chip) {
 			snd_emu10k1_ptr_write(emu, A_FXWC1, 0, 0);
 			snd_emu10k1_ptr_write(emu, A_FXWC2, 0, 0);
 		} else
@@ -608,10 +608,10 @@
 		epcm->capture_bs_val++;
 	}
 	if (epcm->type == CAPTURE_AC97ADC) {
-		epcm->capture_cr_val = emu->audigy ? A_ADCCR_LCHANENABLE : ADCCR_LCHANENABLE;
+		epcm->capture_cr_val = emu->card_capabilities->emu10k2_chip ? A_ADCCR_LCHANENABLE : ADCCR_LCHANENABLE;
 		if (runtime->channels > 1)
-			epcm->capture_cr_val |= emu->audigy ? A_ADCCR_RCHANENABLE : ADCCR_RCHANENABLE;
-		epcm->capture_cr_val |= emu->audigy ?
+			epcm->capture_cr_val |= emu->card_capabilities->emu10k2_chip ? A_ADCCR_RCHANENABLE : ADCCR_RCHANENABLE;
+		epcm->capture_cr_val |= emu->card_capabilities->emu10k2_chip ?
 			snd_emu10k1_audigy_capture_rate_reg(runtime->rate) :
 			snd_emu10k1_capture_rate_reg(runtime->rate);
 	}
@@ -777,7 +777,7 @@
 			snd_emu10k1_ptr_write(emu, ADCCR, 0, epcm->capture_cr_val);
 			break;
 		case CAPTURE_EFX:
-			if (emu->audigy) {
+			if (emu->card_capabilities->emu10k2_chip) {
 				snd_emu10k1_ptr_write(emu, A_FXWC1, 0, epcm->capture_cr_val);
 				snd_emu10k1_ptr_write(emu, A_FXWC2, 0, epcm->capture_cr_val2);
 			} else
@@ -800,7 +800,7 @@
 			snd_emu10k1_ptr_write(emu, ADCCR, 0, 0);
 			break;
 		case CAPTURE_EFX:
-			if (emu->audigy) {
+			if (emu->card_capabilities->emu10k2_chip) {
 				snd_emu10k1_ptr_write(emu, A_FXWC1, 0, 0);
 				snd_emu10k1_ptr_write(emu, A_FXWC2, 0, 0);
 			} else
@@ -1106,7 +1106,7 @@
 	epcm->capture_inte = INTE_ADCBUFENABLE;
 	epcm->capture_ba_reg = ADCBA;
 	epcm->capture_bs_reg = ADCBS;
-	epcm->capture_idx_reg = emu->audigy ? A_ADCIDX : ADCIDX;
+	epcm->capture_idx_reg = emu->card_capabilities->emu10k2_chip ? A_ADCIDX : ADCIDX;
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_capture;
@@ -1142,7 +1142,7 @@
 	epcm->capture_inte = INTE_MICBUFENABLE;
 	epcm->capture_ba_reg = MICBA;
 	epcm->capture_bs_reg = MICBS;
-	epcm->capture_idx_reg = emu->audigy ? A_MICIDX : MICIDX;
+	epcm->capture_idx_reg = emu->card_capabilities->emu10k2_chip ? A_MICIDX : MICIDX;
 	substream->runtime->private_data = epcm;
 	substream->runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_capture;
@@ -1169,7 +1169,7 @@
 	emu10k1_t *emu = snd_pcm_substream_chip(substream);
 	emu10k1_pcm_t *epcm;
 	snd_pcm_runtime_t *runtime = substream->runtime;
-	int nefx = emu->audigy ? 64 : 32;
+	int nefx = emu->card_capabilities->emu10k2_chip ? 64 : 32;
 	int idx;
 
 	epcm = kcalloc(1, sizeof(*epcm), GFP_KERNEL);
@@ -1374,7 +1374,7 @@
 static int snd_emu10k1_pcm_efx_voices_mask_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
-	int nefx = emu->audigy ? 64 : 32;
+	int nefx = emu->card_capabilities->emu10k2_chip ? 64 : 32;
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
 	uinfo->count = nefx;
 	uinfo->value.integer.min = 0;
@@ -1385,7 +1385,7 @@
 static int snd_emu10k1_pcm_efx_voices_mask_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
-	int nefx = emu->audigy ? 64 : 32;
+	int nefx = emu->card_capabilities->emu10k2_chip ? 64 : 32;
 	int idx;
 	
 	spin_lock_irq(&emu->reg_lock);
@@ -1399,8 +1399,8 @@
 {
 	emu10k1_t *emu = snd_kcontrol_chip(kcontrol);
 	unsigned int nval[2], bits;
-	int nefx = emu->audigy ? 64 : 32;
-	int nefxb = emu->audigy ? 7 : 6;
+	int nefx = emu->card_capabilities->emu10k2_chip ? 64 : 32;
+	int nefxb = emu->card_capabilities->emu10k2_chip ? 7 : 6;
 	int change, idx;
 	
 	nval[0] = nval[1] = 0;
@@ -1709,7 +1709,7 @@
 	 */	
 	
 	/* emu->efx_voices_mask[0] = FXWC_DEFAULTROUTE_C | FXWC_DEFAULTROUTE_A; */
-	if (emu->audigy) {
+	if (emu->card_capabilities->emu10k2_chip) {
 		emu->efx_voices_mask[0] = 0;
 		emu->efx_voices_mask[1] = 0xffff;
 	} else {
Index: alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.30
diff -u -r1.30 emuproc.c
--- alsa-kernel/pci/emu10k1/emuproc.c	12 Apr 2005 15:27:29 -0000	1.30
+++ alsa-kernel/pci/emu10k1/emuproc.c	29 May 2005 04:02:16 -0000
@@ -183,25 +183,25 @@
 
 	emu10k1_t *emu = entry->private_data;
 	unsigned int val, val1;
-	int nefx = emu->audigy ? 64 : 32;
-	char **outputs = emu->audigy ? audigy_outs : creative_outs;
+	int nefx = emu->card_capabilities->emu10k2_chip ? 64 : 32;
+	char **outputs = emu->card_capabilities->emu10k2_chip ? audigy_outs : creative_outs;
 	int idx;
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	snd_iprintf(buffer, "Card                  : %s\n",
-		    emu->audigy ? "Audigy" : (emu->card_capabilities->ecard ? "EMU APS" : "Creative"));
+		    emu->card_capabilities->emu10k2_chip ? "Audigy" : (emu->card_capabilities->ecard ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
 	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes / 2);
 	snd_iprintf(buffer, "\n");
 	snd_iprintf(buffer, "Effect Send Routing   :\n");
 	for (idx = 0; idx < NUM_G; idx++) {
-		val = emu->audigy ?
+		val = emu->card_capabilities->emu10k2_chip ?
 			snd_emu10k1_ptr_read(emu, A_FXRT1, idx) :
 			snd_emu10k1_ptr_read(emu, FXRT, idx);
-		val1 = emu->audigy ?
+		val1 = emu->card_capabilities->emu10k2_chip ?
 			snd_emu10k1_ptr_read(emu, A_FXRT2, idx) :
 			0;
-		if (emu->audigy) {
+		if (emu->card_capabilities->emu10k2_chip) {
 			snd_iprintf(buffer, "Ch%i: A=%i, B=%i, C=%i, D=%i, ",
 				idx,
 				val & 0x3f,
@@ -228,7 +228,7 @@
 			snd_iprintf(buffer, "  Output %02i [%s]\n", idx, outputs[idx]);
 	}
 	snd_iprintf(buffer, "\nAll FX Outputs        :\n");
-	for (idx = 0; idx < (emu->audigy ? 64 : 32); idx++)
+	for (idx = 0; idx < (emu->card_capabilities->emu10k2_chip ? 64 : 32); idx++)
 		snd_iprintf(buffer, "  Output %02i [%s]\n", idx, outputs[idx]);
 }
 
@@ -269,12 +269,12 @@
 
 	snd_iprintf(buffer, "FX8010 Instruction List '%s'\n", emu->fx8010.name);
 	snd_iprintf(buffer, "  Code dump      :\n");
-	for (pc = 0; pc < (emu->audigy ? 1024 : 512); pc++) {
+	for (pc = 0; pc < (emu->card_capabilities->emu10k2_chip ? 1024 : 512); pc++) {
 		u32 low, high;
 			
 		low = snd_emu10k1_efx_read(emu, pc * 2);
 		high = snd_emu10k1_efx_read(emu, pc * 2 + 1);
-		if (emu->audigy)
+		if (emu->card_capabilities->emu10k2_chip)
 			snd_iprintf(buffer, "    OP(0x%02x, 0x%03x, 0x%03x, 0x%03x, 0x%03x) /* 0x%04x: 0x%08x%08x */\n",
 				    (high >> 24) & 0x0f,
 				    (high >> 12) & 0x7ff,
@@ -319,9 +319,9 @@
 	} else if (!strcmp(entry->name, "fx8010_tram_data")) {
 		offset = TANKMEMDATAREGBASE;
 	} else if (!strcmp(entry->name, "fx8010_code")) {
-		offset = emu->audigy ? A_MICROCODEBASE : MICROCODEBASE;
+		offset = emu->card_capabilities->emu10k2_chip ? A_MICROCODEBASE : MICROCODEBASE;
 	} else {
-		offset = emu->audigy ? A_FXGPREGBASE : FXGPREGBASE;
+		offset = emu->card_capabilities->emu10k2_chip ? A_FXGPREGBASE : FXGPREGBASE;
 	}
 	size = count;
 	if (pos + size > entry->size)
@@ -333,7 +333,7 @@
 		if ((tmp = kmalloc(size + 8, GFP_KERNEL)) == NULL)
 			return -ENOMEM;
 		for (idx = 0; idx < ((pos & 3) + size + 3) >> 2; idx++)
-			if (tram_addr && emu->audigy) {
+			if (tram_addr && emu->card_capabilities->emu10k2_chip) {
 				tmp[idx] = snd_emu10k1_ptr_read(emu, offset + idx + (pos >> 2), 0) >> 11;
 				tmp[idx] |= snd_emu10k1_ptr_read(emu, 0x100 + idx + (pos >> 2), 0) << 20;
 			} else 
@@ -574,28 +574,28 @@
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_GPR : TOTAL_SIZE_GPR;
+		entry->size = emu->card_capabilities->emu10k2_chip ? A_TOTAL_SIZE_GPR : TOTAL_SIZE_GPR;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_tram_data", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_DATA : TOTAL_SIZE_TANKMEM_DATA ;
+		entry->size = emu->card_capabilities->emu10k2_chip ? A_TOTAL_SIZE_TANKMEM_DATA : TOTAL_SIZE_TANKMEM_DATA ;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_tram_addr", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_TANKMEM_ADDR : TOTAL_SIZE_TANKMEM_ADDR ;
+		entry->size = emu->card_capabilities->emu10k2_chip ? A_TOTAL_SIZE_TANKMEM_ADDR : TOTAL_SIZE_TANKMEM_ADDR ;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_code", &entry)) {
 		entry->content = SNDRV_INFO_CONTENT_DATA;
 		entry->private_data = emu;
 		entry->mode = S_IFREG | S_IRUGO /*| S_IWUSR*/;
-		entry->size = emu->audigy ? A_TOTAL_SIZE_CODE : TOTAL_SIZE_CODE;
+		entry->size = emu->card_capabilities->emu10k2_chip ? A_TOTAL_SIZE_CODE : TOTAL_SIZE_CODE;
 		entry->c.ops = &snd_emu10k1_proc_ops_fx8010;
 	}
 	if (! snd_card_proc_new(emu->card, "fx8010_acode", &entry)) {
Index: alsa-kernel/pci/emu10k1/io.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/io.c,v
retrieving revision 1.10
diff -u -r1.10 io.c
--- alsa-kernel/pci/emu10k1/io.c	13 Mar 2005 12:17:09 -0000	1.10
+++ alsa-kernel/pci/emu10k1/io.c	29 May 2005 04:02:16 -0000
@@ -36,7 +36,7 @@
 	unsigned int regptr, val;
 	unsigned int mask;
 
-	mask = emu->audigy ? A_PTR_ADDRESS_MASK : PTR_ADDRESS_MASK;
+	mask = emu->card_capabilities->emu10k2_chip ? A_PTR_ADDRESS_MASK : PTR_ADDRESS_MASK;
 	regptr = ((reg << 16) & mask) | (chn & PTR_CHANNELNUM_MASK);
 
 	if (reg & 0xff000000) {
@@ -67,7 +67,7 @@
 	unsigned long flags;
 	unsigned int mask;
 
-	mask = emu->audigy ? A_PTR_ADDRESS_MASK : PTR_ADDRESS_MASK;
+	mask = emu->card_capabilities->emu10k2_chip ? A_PTR_ADDRESS_MASK : PTR_ADDRESS_MASK;
 	regptr = ((reg << 16) & mask) | (chn & PTR_CHANNELNUM_MASK);
 
 	if (reg & 0xff000000) {
Index: alsa-kernel/pci/emu10k1/irq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/irq.c,v
retrieving revision 1.15
diff -u -r1.15 irq.c
--- alsa-kernel/pci/emu10k1/irq.c	26 Mar 2005 19:35:30 -0000	1.15
+++ alsa-kernel/pci/emu10k1/irq.c	29 May 2005 04:02:16 -0000
@@ -191,7 +191,7 @@
 				INTE_INTERVALTIMERENB |
 				INTE_MIDITXENABLE |
 				INTE_MIDIRXENABLE;
-			if (emu->audigy)
+			if (emu->card_capabilities->emu10k2_chip)
 				bits |= INTE_A_MIDITXENABLE2 | INTE_A_MIDIRXENABLE2;
 			snd_emu10k1_intr_disable(emu, bits);
 		}




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
