From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] azt3328.c fixes
Date: Sat, 9 Nov 2002 23:13:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021109221318.GA7150@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

now that I'm very happy that azt3328.c has made it into CVS,
I want to submit the following changes:

- "PCBeep Playback Volume" is a special volume ctrl, not standard mono volume,
  leading to control value change problems
- improved snd_azf3328_mixer_new() to resemble snd_sbmixer_init()

Have fun,

Andreas Mohr

P.S.: Expect an ALS4000 mixer patch soon !

Index: alsa-driver/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azt3328.c,v
retrieving revision 1.1
diff -u -r1.1 azt3328.c
--- alsa-driver/pci/azt3328.c	28 Oct 2002 11:51:36 -0000	1.1
+++ alsa-driver/pci/azt3328.c	9 Nov 2002 22:04:03 -0000
@@ -70,7 +70,7 @@
  *   - when Ctrl-C'ing mpg321, the playback loops a bit
  *     (premature DMA playback reset ?)
  *   - full-duplex sometimes breaks (IRQ management issues ?).
- *     Once even a spontaneous REBOOT !!!
+ *     Once even a spontaneous REBOOT happened !!!
  * 
  * TODO
  *  - where is Wave In Switch to be found ??? (who can check on Windows ??)
@@ -376,11 +376,11 @@
   .private_value = COMPOSE_MIXER_REG(reg, is_right_chan ? 0 : 8, 0, mask, 1, 0), \
 }
 
-#define AZF3328_MIXER_VOL_SPECIAL(xname, reg, mask, shift) \
+#define AZF3328_MIXER_VOL_SPECIAL(xname, reg, mask, shift, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
   .info = snd_azf3328_info_mixer, \
   .get = snd_azf3328_get_mixer, .put = snd_azf3328_put_mixer, \
-  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, mask, 0, 0), \
+  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, mask, invert, 0), \
 }
 
 static int snd_azf3328_info_mixer(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
@@ -474,7 +474,7 @@
 	AZF3328_MIXER_VOL_STEREO("Line Playback Volume", IDX_MIXER_LINEIN, 0x1f),
 	AZF3328_MIXER_VOL_STEREO("Wave Capture Volume", IDX_MIXER_WAVEIN, 0x07),
 	AZF3328_MIXER_SWITCH("PCBeep Playback Switch", IDX_MIXER_PCBEEP, 15, 1),
-	AZF3328_MIXER_VOL_MONO("PCBeep Playback Volume", IDX_MIXER_PCBEEP, 0x1f, 1),
+	AZF3328_MIXER_VOL_SPECIAL("PCBeep Playback Volume", IDX_MIXER_PCBEEP, 0x0f, 1, 1),
 	AZF3328_MIXER_SWITCH("Modem Playback Switch", IDX_MIXER_MODEMOUT, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Modem Playback Volume", IDX_MIXER_MODEMOUT, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Modem Capture Switch", IDX_MIXER_MODEMIN, 15, 1),
@@ -485,11 +485,11 @@
 	AZF3328_MIXER_VOL_STEREO("Aux Playback Volume", IDX_MIXER_AUX, 0x1f),
 	AZF3328_MIXER_SWITCH("Modem Out Select", IDX_MIXER_ADVCTL2, 8, 1),
 	AZF3328_MIXER_SWITCH("Mono Select Source", IDX_MIXER_ADVCTL2, 9, 1),
-	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1),
-	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9),
+	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1, 0),
+	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9, 0),
 	AZF3328_MIXER_SWITCH("3D Control - Toggle", IDX_MIXER_ADVCTL2, 13, 0),
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Volume", IDX_MIXER_ADVCTL1, 0x07, 1), /* "3D Width" */
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Space", IDX_MIXER_ADVCTL1, 0x03, 8), /* "Hifi 3D" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Volume", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Space", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
 #if MIXER_TESTING
 	AZF3328_MIXER_SWITCH("0", IDX_MIXER_ADVCTL2, 0, 0),
 	AZF3328_MIXER_SWITCH("1", IDX_MIXER_ADVCTL2, 1, 0),
@@ -509,6 +509,26 @@
 	AZF3328_MIXER_SWITCH("15", IDX_MIXER_ADVCTL2, 15, 0),
 #endif
 };
+
+#define AZF3328_INIT_VALUES (sizeof(snd_azf3328_init_values)/sizeof(unsigned int)/2)
+
+static unsigned int snd_azf3328_init_values[][2] = {
+        { IDX_MIXER_PLAY_MASTER,	MIXER_MUTE_MASK|0x1f1f },
+        { IDX_MIXER_MODEMOUT,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_BASSTREBLE,		0x0000 },
+	{ IDX_MIXER_PCBEEP,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_MODEMIN,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_MIC,		MIXER_MUTE_MASK|0x001f },
+	{ IDX_MIXER_LINEIN,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_CDAUDIO,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_VIDEO,		MIXER_MUTE_MASK|0x1f1f },
+	{ IDX_MIXER_AUX,		MIXER_MUTE_MASK|0x1f1f },
+        { IDX_MIXER_WAVEOUT,		MIXER_MUTE_MASK|0x1f1f },
+        { IDX_MIXER_FMSYNTH,		MIXER_MUTE_MASK|0x1f1f },
+        { IDX_MIXER_WAVEIN,		0x0707 },
+        { IDX_MIXER_REC_MASTER,		MIXER_MUTE_MASK|0x0707 },
+};
+
 static int __devinit snd_azf3328_mixer_new(azf3328_t *chip)
 {
 	snd_card_t *card;
@@ -520,48 +540,23 @@
 
 	card = chip->card;
 
-	strcpy(card->mixername, "AZF3328 mixer");
-
-	/* reset mixer */
+	/* mixer reset */
 	snd_azf3328_mixer_write(chip, IDX_MIXER_RESET, 0x0, WORD_VALUE);
 
-	/* shut down or initialize mixer controls */
-	snd_azf3328_mixer_write(chip, IDX_MIXER_PLAY_MASTER,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_MODEMOUT,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_BASSTREBLE,
-			0x0000, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_PCBEEP,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_MODEMIN,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_MIC,
-			MIXER_MUTE_MASK|0x001f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_LINEIN,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_CDAUDIO,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_VIDEO,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_AUX,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_WAVEOUT,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_FMSYNTH,
-			MIXER_MUTE_MASK|0x1f1f, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_WAVEIN,
-			0x0707, WORD_VALUE);
-	snd_azf3328_mixer_write(chip, IDX_MIXER_REC_MASTER,
-			MIXER_MUTE_MASK|0x0707, WORD_VALUE);
+	/* mute and zero volume channels */
+	for (idx = 0; idx < AZF3328_INIT_VALUES; idx++) {
+		snd_azf3328_mixer_write(chip, snd_azf3328_init_values[idx][0], snd_azf3328_init_values[idx][1], WORD_VALUE);
+	}
 	
 	/* add mixer controls */
 	sw = snd_azf3328_mixer_controls;
 	for (idx = 0; idx < NUM_CONTROLS(snd_azf3328_mixer_controls); idx++, sw++) {
-		err = snd_ctl_add(chip->card, snd_ctl_new1(sw, chip));
-		if (err < 0)
+		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(sw, chip))) < 0)
 			return err;
 	}
+	snd_component_add(card, "AZF3328 mixer");
+	strcpy(card->mixername, "AZF3328 mixer");
+
 	snd_azf3328_dbgcallleave();
 	return 0;
 }
@@ -951,7 +946,7 @@
 
         /* fast path out, to ease interrupt sharing */
 	if (!(status & (IRQ_PLAYBACK|IRQ_RECORDING|IRQ_MPU401|IRQ_SOMEIRQ)))
-		return; /* must be interrupt for another card */
+		return; /* must be interrupt for another device */
 
 	snd_azf3328_dbgplay("Interrupt %ld !\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQMASK %04x, IDX_IO_IRQSTATUS %04x\n", count, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQMASK), inw(chip->codec_port+IDX_IO_IRQSTATUS));
 		
@@ -1453,7 +1448,7 @@
 #ifdef MODULE
 	printk(
 "azt3328: EXPERIMENTAL driver for Aztech AZF3328-based soundcards (e.g. PCI168).\n"
-"azt3328: Aztech does NOT support this driver and/or the soundcard in any way,\n"
+"azt3328: Aztech does NOT support this driver and/or the soundcard (yet),\n"
 "azt3328: so simply don't even bother to try to get some support from them.\n"
 "azt3328: Please mail to hw7oshyuv3001@sneakemail.com for further info\n"
 "azt3328: (bug notification, driver development etc.).\n");

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
Tel. +49 7159 800604                http://mohr.de.tt


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
