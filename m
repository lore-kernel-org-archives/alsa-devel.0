From: Lee Revell <rlrevell@joe-job.com>
Subject: [patch] emu10k1: clean up card features
Date: Wed, 30 Mar 2005 03:17:22 -0500
Message-ID: <1112170642.5598.60.camel@mindpipe>
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
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch converts the emu10k1 driver to use the card capabilities
structure for some more things.

Not extensively tested but seems to work.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

? alsa/alsa-kernel/Documentation/emu10k1-jack.txt
? alsa/alsa-kernel/pci/emu10k1/alsafoo.patch
Index: alsa/alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.62
diff -u -r1.62 emu10k1.h
--- alsa/alsa-kernel/include/emu10k1.h	26 Mar 2005 19:35:29 -0000	1.62
+++ alsa/alsa-kernel/include/emu10k1.h	30 Mar 2005 08:15:18 -0000
@@ -1046,6 +1046,7 @@
 	unsigned char ca0108_chip;  /* Audigy 2 Value */
 	unsigned char ca0151_chip;  /* P16V */
 	unsigned char spk71;        /* Has 7.1 speakers */
+	unsigned char sblive51;	    /* SBLive! 5.1 - extout 0x11 -> center, 0x12 -> lfe */
 	unsigned char spdif_bug;    /* Has Spdif phasing bug */
 	unsigned char ac97_chip;    /* Has an AC97 chip */
 	unsigned char ecard;        /* APS EEPROM */
@@ -1057,11 +1058,8 @@
 	int irq;
 
 	unsigned long port;			/* I/O port number */
-	unsigned int APS: 1,			/* APS flag */
-	    no_ac97: 1,				/* no AC'97 */
-	    tos_link: 1,			/* tos link detected */
-	    rear_ac97: 1,			/* rear channels are on AC'97 */
-	    spk71:1;				/* 7.1 configuration (Audigy 2 ZS) */
+	unsigned int tos_link: 1,		/* tos link detected */
+	    rear_ac97: 1;			/* rear channels are on AC'97 */
 	const emu_chip_details_t *card_capabilities;	/* Contains profile of card capabilities */
 	unsigned int audigy;			/* is Audigy? */
 	unsigned int revision;			/* chip revision */
@@ -1456,7 +1454,6 @@
 #endif
 
 typedef struct {
-	unsigned int card;			/* card type */
 	unsigned int internal_tram_size;	/* in samples */
 	unsigned int external_tram_size;	/* in samples */
 	char fxbus_names[16][32];		/* names of FXBUSes */
Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.49
diff -u -r1.49 emu10k1_main.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Mar 2005 14:00:54 -0000	1.49
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	30 Mar 2005 08:15:19 -0000
@@ -170,7 +170,7 @@
 			SPCS_GENERATIONSTATUS | 0x00001200 |
 			0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
-	if (emu->audigy && emu->revision == 4) { /* audigy2 */
+	if (emu->card_capabilities->ca0151_chip) { /* audigy2 */
 		/* Hacks for Alice3 to work independent of haP16V driver */
 		u32 tmp;
 
@@ -600,7 +600,7 @@
 	if (emu->port)
 		pci_release_regions(emu->pci);
 	pci_disable_device(emu->pci);
-	if (emu->audigy && emu->revision == 4) /* P16V */	
+	if (emu->card_capabilities->ca0151_chip) /* P16V */	
 		snd_p16v_free(emu);
 	kfree(emu);
 	return 0;
@@ -688,15 +688,22 @@
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1} ,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
 	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002,
 	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1} ,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{ } /* terminator */
 };
 
@@ -747,7 +754,6 @@
 	emu->revision = revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
-	emu->card_type = EMU10K1_CARD_CREATIVE;
 	snd_printdd("vendor=0x%x, device=0x%x, subsystem_vendor_id=0x%x, subsystem_id=0x%x\n",pci->vendor, pci->device, emu->serial, emu->model);
 
 	for (c = emu_chip_details; c->vendor; c++) {
@@ -825,15 +831,6 @@
 
 	pci_set_master(pci);
 
-	if (c->ecard) {
-		emu->card_type = EMU10K1_CARD_EMUAPS;
-		emu->APS = 1;
-	}
-	if (! c->ac97_chip)
-		emu->no_ac97 = 1;
-	
-	emu->spk71 = c->spk71;
-	
 	emu->fx8010.fxbus_mask = 0x303f;
 	if (extin_mask == 0)
 		extin_mask = 0x3fcf;
@@ -842,7 +839,7 @@
 	emu->fx8010.extin_mask = extin_mask;
 	emu->fx8010.extout_mask = extout_mask;
 
-	if (emu->APS) {
+	if (emu->card_capabilities->ecard) {
 		if ((err = snd_emu10k1_ecard_init(emu)) < 0) {
 			snd_emu10k1_free(emu);
 			return err;
Index: alsa/alsa-kernel/pci/emu10k1/emufx.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emufx.c,v
retrieving revision 1.73
diff -u -r1.73 emufx.c
--- alsa/alsa-kernel/pci/emu10k1/emufx.c	23 Mar 2005 16:58:41 -0000	1.73
+++ alsa/alsa-kernel/pci/emu10k1/emufx.c	30 Mar 2005 08:15:21 -0000
@@ -1077,7 +1077,7 @@
 	gpr += 2;
 	
 	/* PCM Side Playback (independent from stereo mix) */
-	if (emu->spk71) {
+	if (emu->card_capabilities->spk71) {
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+6), A_C_00000000, A_GPR(gpr), A_FXBUS(FXBUS_PCM_LEFT_SIDE));
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+7), A_C_00000000, A_GPR(gpr+1), A_FXBUS(FXBUS_PCM_RIGHT_SIDE));
 		snd_emu10k1_init_stereo_control(&controls[nctl++], "PCM Side Playback Volume", gpr, 100);
@@ -1145,14 +1145,14 @@
 	A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_SPDIF_CD_L);
 	A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_SPDIF_CD_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "CD Playback Volume" : "Audigy CD Playback Volume",
+					emu->card_capabilities->ac97_chip ? "Audigy CD Playback Volume" : "CD Playback Volume",
 					gpr, 0);
 	gpr += 2;
 	/* Audigy CD Capture Volume */
 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_SPDIF_CD_L);
 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_SPDIF_CD_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "CD Capture Volume" : "Audigy CD Capture Volume",
+					emu->card_capabilities->ac97_chip ? "Audigy CD Capture Volume" : "CD Capture Volume",
 					gpr, 0);
 	gpr += 2;
 
@@ -1171,14 +1171,14 @@
 	A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_LINE2_L);
 	A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_LINE2_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "Line Playback Volume" : "Line2 Playback Volume",
+					emu->card_capabilities->ac97_chip ? "Line2 Playback Volume" : "Line Playback Volume",
 					gpr, 0);
 	gpr += 2;
 	/* Line2 Capture Volume */
 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_LINE2_L);
 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_LINE2_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "Line Capture Volume" : "Line2 Capture Volume",
+					emu->card_capabilities->ac97_chip ? "Line2 Capture Volume" : "Line Capture Volume",
 					gpr, 0);
 	gpr += 2;
         
@@ -1197,14 +1197,14 @@
 	A_ADD_VOLUME_IN(stereo_mix, gpr, A_EXTIN_AUX2_L);
 	A_ADD_VOLUME_IN(stereo_mix+1, gpr+1, A_EXTIN_AUX2_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "Aux Playback Volume" : "Aux2 Playback Volume",
+					emu->card_capabilities->ac97_chip ? "Aux2 Playback Volume" : "Aux Playback Volume",
 					gpr, 0);
 	gpr += 2;
 	/* Aux2 Capture Volume */
 	A_ADD_VOLUME_IN(capture, gpr, A_EXTIN_AUX2_L);
 	A_ADD_VOLUME_IN(capture+1, gpr+1, A_EXTIN_AUX2_R);
 	snd_emu10k1_init_stereo_control(&controls[nctl++],
-					emu->no_ac97 ? "Aux Capture Volume" : "Aux2 Capture Volume",
+					emu->card_capabilities->ac97_chip ? "Aux2 Capture Volume" : "Aux Capture Volume",
 					gpr, 0);
 	gpr += 2;
 	
@@ -1232,7 +1232,7 @@
 	snd_emu10k1_init_mono_control(&controls[nctl++], "LFE Playback Volume", gpr, 0);
 	gpr++;
 	
-	if (emu->spk71) {
+	if (emu->card_capabilities->spk71) {
 		/* Stereo Mix Side Playback */
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+6), A_GPR(playback+6), A_GPR(gpr), A_GPR(stereo_mix));
 		A_OP(icode, &ptr, iMAC0, A_GPR(playback+7), A_GPR(playback+7), A_GPR(gpr+1), A_GPR(stereo_mix+1));
@@ -1266,7 +1266,7 @@
 	A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 3), A_GPR(playback + 3), A_C_00000000, A_C_00000000); /* rear right */
 	A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 4), A_GPR(playback + 4), A_C_00000000, A_C_00000000); /* center */
 	A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 5), A_GPR(playback + 5), A_C_00000000, A_C_00000000); /* LFE */
-	if (emu->spk71) {
+	if (emu->card_capabilities->spk71) {
 		A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 6), A_GPR(playback + 6), A_C_00000000, A_C_00000000); /* side left */
 		A_OP(icode, &ptr, iACC3, A_GPR(playback + SND_EMU10K1_PLAYBACK_CHANNELS + 7), A_GPR(playback + 7), A_C_00000000, A_C_00000000); /* side right */
 	}
@@ -1359,7 +1359,7 @@
 	A_PUT_STEREO_OUTPUT(A_EXTOUT_AREAR_L, A_EXTOUT_AREAR_R, playback+2 + SND_EMU10K1_PLAYBACK_CHANNELS);
 	A_PUT_OUTPUT(A_EXTOUT_ACENTER, playback+4 + SND_EMU10K1_PLAYBACK_CHANNELS);
 	A_PUT_OUTPUT(A_EXTOUT_ALFE, playback+5 + SND_EMU10K1_PLAYBACK_CHANNELS);
-	if (emu->spk71)
+	if (emu->card_capabilities->spk71)
 		A_PUT_STEREO_OUTPUT(A_EXTOUT_ASIDE_L, A_EXTOUT_ASIDE_R, playback+6 + SND_EMU10K1_PLAYBACK_CHANNELS);
 
 	/* headphone */
@@ -1982,22 +1982,27 @@
 		OP(icode, &ptr, iACC3, EXTOUT(EXTOUT_MIC_CAP), GPR(capture + 2), C_00000000, C_00000000);
 
 	/* EFX capture - capture the 16 EXTINS */
-	OP(icode, &ptr, iACC3, FXBUS2(14), C_00000000, C_00000000, EXTIN(0));
-	OP(icode, &ptr, iACC3, FXBUS2(15), C_00000000, C_00000000, EXTIN(1));
-	OP(icode, &ptr, iACC3, FXBUS2(0), C_00000000, C_00000000, EXTIN(2));
-	OP(icode, &ptr, iACC3, FXBUS2(3), C_00000000, C_00000000, EXTIN(3));
-	/* Dont connect anything to FXBUS2 1 and 2.  These are shared with 
-	 * Center/LFE on the SBLive 5.1.  The kX driver only changes the 
-	 * routing when it detects an SBLive 5.1.
-	 *
-	 * Since only 14 of the 16 EXTINs are used, this is not a big problem.  
-	 * We route AC97L and R to FX capture 14 and 15, SPDIF CD in to FX capture 
-	 * 0 and 3, then the rest of the EXTINs to the corresponding FX capture 
-	 * channel.
-	 */
-	for (z = 4; z < 14; z++) {
-		OP(icode, &ptr, iACC3, FXBUS2(z), C_00000000, C_00000000, EXTIN(z));
+	if (emu->card_capabilities->sblive51) {
+		/* On the Live! 5.1, FXBUS2(1) and FXBUS(2) are shared with EXTOUT_ACENTER
+		 * and EXTOUT_ALFE, so we can't connect inputs to them for multitrack recording.
+		 *
+		 * Since only 14 of the 16 EXTINs are used, this is not a big problem.  
+		 * We route AC97L and R to FX capture 14 and 15, SPDIF CD in to FX capture 
+		 * 0 and 3, then the rest of the EXTINs to the corresponding FX capture 
+		 * channel.  Multitrack recorders will still see the center/lfe output signal 
+		 * on the second and third channels.
+		 */
+		OP(icode, &ptr, iACC3, FXBUS2(14), C_00000000, C_00000000, EXTIN(0));
+		OP(icode, &ptr, iACC3, FXBUS2(15), C_00000000, C_00000000, EXTIN(1));
+		OP(icode, &ptr, iACC3, FXBUS2(0), C_00000000, C_00000000, EXTIN(2));
+		OP(icode, &ptr, iACC3, FXBUS2(3), C_00000000, C_00000000, EXTIN(3));
+		for (z = 4; z < 14; z++)
+			OP(icode, &ptr, iACC3, FXBUS2(z), C_00000000, C_00000000, EXTIN(z));
+	} else {
+		for (z = 0; z < 16; z++)
+			OP(icode, &ptr, iACC3, FXBUS2(z), C_00000000, C_00000000, EXTIN(z));
 	}
+	    
 
 	if (gpr > tmp) {
 		snd_BUG();
@@ -2128,7 +2133,6 @@
 	int res;
 
 	memset(info, 0, sizeof(info));
-	info->card = emu->card_type;
 	info->internal_tram_size = emu->fx8010.itram_size;
 	info->external_tram_size = emu->fx8010.etram_pages.bytes / 2;
 	fxbus = fxbuses;
Index: alsa/alsa-kernel/pci/emu10k1/emumixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emumixer.c,v
retrieving revision 1.34
diff -u -r1.34 emumixer.c
--- alsa/alsa-kernel/pci/emu10k1/emumixer.c	23 Mar 2005 17:04:17 -0000	1.34
+++ alsa/alsa-kernel/pci/emu10k1/emumixer.c	30 Mar 2005 08:15:22 -0000
@@ -791,7 +791,7 @@
 		NULL
 	};
 
-	if (!emu->no_ac97) {
+	if (emu->card_capabilities->ac97_chip) {
 		ac97_bus_t *pbus;
 		ac97_template_t ac97;
 		static ac97_bus_ops_t ops = {
@@ -833,7 +833,7 @@
 		for (; *c; c++)
 			remove_ctl(card, *c);
 	} else {
-		if (emu->APS)
+		if (emu->card_capabilities->ecard)
 			strcpy(emu->card->mixername, "EMU APS");
 		else if (emu->audigy)
 			strcpy(emu->card->mixername, "SB Audigy");
@@ -918,7 +918,7 @@
 		mix->attn[0] = 0xffff;
 	}
 	
-	if (! emu->APS) { /* FIXME: APS has these controls? */
+	if (! emu->card_capabilities->ecard) { /* FIXME: APS has these controls? */
 		/* sb live! and audigy */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_spdif_mask_control, emu)) == NULL)
 			return -ENOMEM;
@@ -939,14 +939,14 @@
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
-	} else if (! emu->APS) {
+	} else if (! emu->card_capabilities->ecard) {
 		/* sb live! */
 		if ((kctl = snd_ctl_new1(&snd_emu10k1_shared_spdif, emu)) == NULL)
 			return -ENOMEM;
 		if ((err = snd_ctl_add(card, kctl)))
 			return err;
 	}
-	if (emu->audigy && emu->revision == 4) { /* P16V */
+	if (emu->card_capabilities->ca0151_chip) { /* P16V */
 		if ((err = snd_p16v_mixer(emu)))
 			return err;
 	}
Index: alsa/alsa-kernel/pci/emu10k1/emuproc.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emuproc.c,v
retrieving revision 1.26
diff -u -r1.26 emuproc.c
--- alsa/alsa-kernel/pci/emu10k1/emuproc.c	21 Mar 2005 19:45:01 -0000	1.26
+++ alsa/alsa-kernel/pci/emu10k1/emuproc.c	30 Mar 2005 08:15:22 -0000
@@ -182,7 +182,7 @@
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	snd_iprintf(buffer, "Card                  : %s\n",
-		    emu->audigy ? "Audigy" : (emu->APS ? "EMU APS" : "Creative"));
+		    emu->audigy ? "Audigy" : (emu->card_capabilities->ecard ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
 	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes / 2);
 	snd_iprintf(buffer, "\n");




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
