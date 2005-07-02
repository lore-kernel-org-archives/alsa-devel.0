From: Lee Revell <rlrevell@joe-job.com>
Subject: Fix emu10k1 breakages in kernel 2.6.12
Date: Fri, 01 Jul 2005 23:08:21 -0400
Message-ID: <1120273701.12256.30.camel@mindpipe>
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
To: stable@kernel.org
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

This set of critical fixes did not make it into the 2.6.12 kernel.

To better handle the large variety of devices it supports, the emu10k1
driver was recently cleaned up by moving all hardware details into a
table keyed by PCI ID; unfortunately some IDs were missing from the
table.

The typical effect is loss of mixer settings, mic not working, or no
sound at all when upgrading to 2.6.12.

Here are the broken out patches for reference:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c?rev=1.58&view=log

I hope I did not omit any of the authors.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>
From: James Courtier-Dutton <James@superbug.co.uk>
From: Arnaud Patard <arnaud.patard@rtp-net.org>
From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
From: Peter Zubaj <pzad@pobox.sk>
From: Lee Revell <rlrevell@joe-job.com>
From: Takashi Iwai <tiwai@suse.de>

--- include/sound/emu10k1.h	2005-06-17 15:48:29.000000000 -0400
+++ /home/rlrevell/cvs/alsa/alsa-kernel/include/emu10k1.h	2005-06-30 11:19:58.000000000 -0400
@@ -1039,28 +1057,28 @@
 	u32 vendor;
 	u32 device;
 	u32 subsystem;
+	unsigned char revision;
 	unsigned char emu10k1_chip; /* Original SB Live. Not SB Live 24bit. */
 	unsigned char emu10k2_chip; /* Audigy 1 or Audigy 2. */
 	unsigned char ca0102_chip;  /* Audigy 1 or Audigy 2. Not SB Audigy 2 Value. */
 	unsigned char ca0108_chip;  /* Audigy 2 Value */
 	unsigned char ca0151_chip;  /* P16V */
 	unsigned char spk71;        /* Has 7.1 speakers */
+	unsigned char sblive51;	    /* SBLive! 5.1 - extout 0x11 -> center, 0x12 -> lfe */
 	unsigned char spdif_bug;    /* Has Spdif phasing bug */
 	unsigned char ac97_chip;    /* Has an AC97 chip */
 	unsigned char ecard;        /* APS EEPROM */
-	char * driver;
-	char * name;
+	const char *driver;
+	const char *name;
+	const char *id;		/* for backward compatibility - can be NULL if not needed */
 } emu_chip_details_t;
 
 struct _snd_emu10k1 {
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
@@ -1453,7 +1474,6 @@
 #endif
 
 typedef struct {
-	unsigned int card;			/* card type */
 	unsigned int internal_tram_size;	/* in samples */
 	unsigned int external_tram_size;	/* in samples */
 	char fxbus_names[16][32];		/* names of FXBUSes */
--- sound/pci/emu10k1/emuproc.c	2005-06-17 15:48:29.000000000 -0400
+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emuproc.c	2005-06-30 11:19:58.000000000 -0400
@@ -182,7 +189,7 @@
 	
 	snd_iprintf(buffer, "EMU10K1\n\n");
 	snd_iprintf(buffer, "Card                  : %s\n",
-		    emu->audigy ? "Audigy" : (emu->APS ? "EMU APS" : "Creative"));
+		    emu->audigy ? "Audigy" : (emu->card_capabilities->ecard ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
 	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes / 2);
 	snd_iprintf(buffer, "\n");
--- sound/pci/emu10k1/emumixer.c.orig	2005-07-01 22:24:08.000000000 -0400
+++ sound/pci/emu10k1/emumixer.c	2005-07-01 22:31:11.000000000 -0400
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
--- sound/pci/emu10k1/emufx.c	2005-06-17 15:48:29.000000000 -0400
+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emufx.c	2005-06-30 11:19:58.000000000 -0400
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
@@ -2128,7 +2133,6 @@
 	int res;
 
 	memset(info, 0, sizeof(info));
-	info->card = emu->card_type;
 	info->internal_tram_size = emu->fx8010.itram_size;
 	info->external_tram_size = emu->fx8010.etram_pages.bytes / 2;
 	fxbus = fxbuses;
--- sound/pci/emu10k1/emu10k1_main.c	2005-06-17 15:48:29.000000000 -0400
+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2005-06-30 11:19:58.000000000 -0400
@@ -170,7 +170,7 @@
 			SPCS_GENERATIONSTATUS | 0x00001200 |
 			0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 
-	if (emu->audigy && emu->revision == 4) { /* audigy2 */
+	if (emu->card_capabilities->ca0151_chip) { /* audigy2 */
 		/* Hacks for Alice3 to work independent of haP16V driver */
 		u32 tmp;
 
@@ -189,7 +189,7 @@
 		/* Enabled Phased (8-channel) P16V playback */
 		outl(0x0201, emu->port + HCFG2);
 		/* Set playback routing. */
-		snd_emu10k1_ptr_write(emu, CAPTURE_P16V_SOURCE, 0, 78e4);
+		snd_emu10k1_ptr20_write(emu, CAPTURE_P16V_SOURCE, 0, 0x78e4);
 	}
 	if (emu->audigy && (emu->serial == 0x10011102) ) { /* audigy2 Value */
 		/* Hacks for Alice3 to work independent of haP16V driver */
@@ -600,7 +600,7 @@
 	if (emu->port)
 		pci_release_regions(emu->pci);
 	pci_disable_device(emu->pci);
-	if (emu->audigy && emu->revision == 4) /* P16V */	
+	if (emu->card_capabilities->ca0151_chip) /* P16V */	
 		snd_p16v_free(emu);
 	kfree(emu);
 	return 0;
@@ -612,21 +612,24 @@
 	return snd_emu10k1_free(emu);
 }
 
-/* vendor, device, subsystem, emu10k1_chip, emu10k2_chip, ca0102_chip, ca0108_chip, ca0151_chip, spk71, spdif_bug, ac97_chip, ecard, driver, name */
-
 static emu_chip_details_t emu_chip_details[] = {
 	/* Audigy 2 Value AC3 out does not work yet. Need to find out how to turn off interpolators.*/
 	{.vendor = 0x1102, .device = 0x0008, .subsystem = 0x10011102,
 	 .driver = "Audigy2", .name = "Audigy 2 Value [SB0400]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
-	 .spk71 = 1} ,
+	 .spk71 = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0008, 
 	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
-	 .ca0108_chip = 1} ,
+	 .ca0108_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
 	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -635,6 +638,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20021102,
 	 .driver = "Audigy2", .name = "Audigy 2 ZS [SB0350]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -643,6 +647,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20011102,
 	 .driver = "Audigy2", .name = "Audigy 2 ZS [2001]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -651,6 +656,7 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10071102,
 	 .driver = "Audigy2", .name = "Audigy 2 [SB0240]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
@@ -659,35 +665,165 @@
 	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10051102,
 	 .driver = "Audigy2", .name = "Audigy 2 EX [1005]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
 	 .spdif_bug = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10021102,
 	 .driver = "Audigy2", .name = "Audigy 2 Platinum [SB0240P]", 
+	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ca0151_chip = 1,
 	 .spk71 = 1,
 	 .spdif_bug = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .revision = 0x04,
+	 .driver = "Audigy2", .name = "Audigy 2 [Unknown]",
+	 .id = "Audigy2",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ca0151_chip = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x10020052,
+	 .driver = "Audigy", .name = "Audigy 1 ES [SB0160]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00531102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00511102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
-	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
+	 .driver = "Audigy", .name = "Audigy 1 [Unknown]", 
+	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
-	 .spdif_bug = 1} ,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
+	 .id = "APS",
 	 .emu10k1_chip = 1,
 	 .ecard = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Player 5.1 [SB0060]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80401102,
+	 .driver = "EMU10K1", .name = "SBLive! Platinum [CT4760P]", 
+	 .id = "Live",
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00211102,
+	 .driver = "EMU10K1", .name = "SBLive! [CT4620]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x00201102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4670]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80221102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4780]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80231102,
+	 .driver = "EMU10K1", .name = "SB PCI512 [CT4790]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80261102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4830]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80311102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4831]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80271102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4832]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80511102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4850]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80281102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4870]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80321102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [CT4871]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80611102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0060]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80691102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0101]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806A1102,
+	 .driver = "EMU10K1", .name = "SBLive! Value [SB0103]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x806B1102,
+	 .driver = "EMU10K1", .name = "SBLive! [SB0105]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002,
 	 .driver = "EMU10K1", .name = "SB Live [Unknown]", 
+	 .id = "Live",
 	 .emu10k1_chip = 1,
-	 .ac97_chip = 1} ,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{ } /* terminator */
 };
 
@@ -738,13 +874,15 @@
 	emu->revision = revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &emu->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &emu->model);
-	emu->card_type = EMU10K1_CARD_CREATIVE;
 	snd_printdd("vendor=0x%x, device=0x%x, subsystem_vendor_id=0x%x, subsystem_id=0x%x\n",pci->vendor, pci->device, emu->serial, emu->model);
 
 	for (c = emu_chip_details; c->vendor; c++) {
 		if (c->vendor == pci->vendor && c->device == pci->device) {
-			if (c->subsystem == emu->serial) break;
-			if (c->subsystem == 0) break;
+			if (c->subsystem && c->subsystem != emu->serial)
+				continue;
+			if (c->revision && c->revision != emu->revision)
+				continue;
+			break;
 		}
 	}
 	if (c->vendor == 0) {
@@ -759,6 +897,23 @@
 	else
 		snd_printdd("Sound card name=%s, vendor=0x%x, device=0x%x, subsystem=0x%x\n", c->name, pci->vendor, pci->device, emu->serial);
 	
+	if (!*card->id && c->id) {
+		int i, n = 0;
+		strlcpy(card->id, c->id, sizeof(card->id));
+		for (;;) {
+			for (i = 0; i < snd_ecards_limit; i++) {
+				if (snd_cards[i] && !strcmp(snd_cards[i]->id, card->id))
+					break;
+			}
+			if (i >= snd_ecards_limit)
+				break;
+			n++;
+			if (n >= SNDRV_CARDS)
+				break;
+			snprintf(card->id, sizeof(card->id), "%s_%d", c->id, n);
+		}
+	}
+
 	is_audigy = emu->audigy = c->emu10k2_chip;
 
 	/* set the DMA transfer mask */
@@ -816,15 +971,6 @@
 
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
@@ -833,7 +979,7 @@
 	emu->fx8010.extin_mask = extin_mask;
 	emu->fx8010.extout_mask = extout_mask;
 
-	if (emu->APS) {
+	if (emu->card_capabilities->ecard) {
 		if ((err = snd_emu10k1_ecard_init(emu)) < 0) {
 			snd_emu10k1_free(emu);
 			return err;






-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
