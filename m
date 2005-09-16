From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] AZT3328 driver update (#2)
Date: Sat, 17 Sep 2005 01:48:28 +0200
Message-ID: <20050916234828.GA23429@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

this is now a reworked patch for my azt3328.c ALSA driver.

In addition to the changes of the previous patch version:
- improves/fixes some fatal playback/recording interaction
- improves IRQ handler performance (and actually fixes some weird code)
- coalesces some I/O accesses
- slightly improves I/O interface documentation
- improves/fixes logging
- defines out some less important debug code
- constifies some data

there are now the following updates included:
- FOUND the 1us DirectX timer area (yay!), made the code respect it properly
- renamed some "weird" mixer control names according to ControlNames.txt
- cleanup unneeded debug messages, reformatting
- improved I/O register documentation
- constified many more structs

Both playback and recording are working nicely.

Thanks,

Andreas Mohr

Signed-off-by: Andreas Mohr <andi@lisas.de>
(those updates done by me, and me alone)

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="azt3328.diff"

Index: alsa-kernel/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.c,v
retrieving revision 1.29
diff -u -r1.29 azt3328.c
--- alsa-kernel/pci/azt3328.c	12 Sep 2005 07:20:54 -0000	1.29
+++ alsa-kernel/pci/azt3328.c	16 Sep 2005 23:33:27 -0000
@@ -46,7 +46,7 @@
  *  - MPU401 (+ legacy address support) FIXME: how to enable legacy addr??
  *  - game port (legacy address support)
  *  - built-in General DirectX timer having a 20 bits counter
- *    with 1us resolution (FIXME: where is it?)
+ *    with 1us resolution
  *  - I2S serial port for external DAC
  *  - supports 33MHz PCI spec 2.1, PCI power management 1.0, compliant with ACPI
  *  - supports hardware volume control
@@ -152,13 +152,6 @@
 #define snd_azf3328_dbgplay(format, args...)
 #endif		
 
-#if DEBUG_IO
-#define snd_azf3328_dbgio(chip, where) \
-	    printk(KERN_ERR "%s: IDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQMASK %04x, IDX_IO_IRQSTATUS %04x\n", where, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQMASK), inw(chip->codec_port+IDX_IO_IRQSTATUS))
-#else
-#define snd_azf3328_dbgio(chip, where)
-#endif
-	    
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for AZF3328 soundcard.");
@@ -205,7 +198,7 @@
 	spinlock_t reg_lock;
 };
 
-static struct pci_device_id snd_azf3328_ids[] = {
+static const struct pci_device_id snd_azf3328_ids[] = {
 	{ 0x122D, 0x50DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* PCI168/3328 */
 	{ 0x122D, 0x80DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* 3328 */
 	{ 0, }
@@ -406,7 +399,11 @@
 			val = reg.mask - val;
 		ucontrol->value.integer.value[1] = val;
 	}
-	snd_azf3328_dbgmixer("get: %02x is %04x -> vol %02lx|%02lx (shift %02d|%02d, mask %02x, inv. %d, stereo %d)\n", reg.reg, oreg, ucontrol->value.integer.value[0], ucontrol->value.integer.value[1], reg.lchan_shift, reg.rchan_shift, reg.mask, reg.invert, reg.stereo);
+	snd_azf3328_dbgmixer("get: %02x is %04x -> vol %02lx|%02lx "
+			     "(shift %02d|%02d, mask %02x, inv. %d, stereo %d)\n",
+		reg.reg, oreg,
+		ucontrol->value.integer.value[0], ucontrol->value.integer.value[1],
+		reg.lchan_shift, reg.rchan_shift, reg.mask, reg.invert, reg.stereo);
 	snd_azf3328_dbgcallleave();
 	return 0;
 }
@@ -433,11 +430,18 @@
 		nreg |= (val << reg.rchan_shift);
 	}
 	if (reg.mask >= 0x07) /* it's a volume control, so better take care */
-		snd_azf3328_mixer_write_volume_gradually(chip, reg.reg, nreg >> 8, nreg & 0xff, SET_CHAN_LEFT|SET_CHAN_RIGHT, 0); /* just set both channels, doesn't matter */
+		snd_azf3328_mixer_write_volume_gradually(
+			chip, reg.reg, nreg >> 8, nreg & 0xff,
+			SET_CHAN_LEFT|SET_CHAN_RIGHT, /* just set both channels, doesn't matter */
+			0);
 	else
         	outw(nreg, chip->mixer_port + reg.reg);
 
-	snd_azf3328_dbgmixer("put: %02x to %02lx|%02lx, oreg %04x; shift %02d|%02d -> nreg %04x; after: %04x\n", reg.reg, ucontrol->value.integer.value[0], ucontrol->value.integer.value[1], oreg, reg.lchan_shift, reg.rchan_shift, nreg, inw(chip->mixer_port + reg.reg));
+	snd_azf3328_dbgmixer("put: %02x to %02lx|%02lx, "
+			     "oreg %04x; shift %02d|%02d -> nreg %04x; after: %04x\n",
+		reg.reg, ucontrol->value.integer.value[0], ucontrol->value.integer.value[1],
+		oreg, reg.lchan_shift, reg.rchan_shift,
+		nreg, inw(chip->mixer_port + reg.reg));
 	snd_azf3328_dbgcallleave();
 	return (nreg != oreg);
 }
@@ -445,9 +449,9 @@
 static int snd_azf3328_info_mixer_enum(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
 {
 	azf3328_mixer_reg_t reg;
-	static char *texts1[2] = { "ModemOut1", "ModemOut2" };
-	static char *texts2[2] = { "MonoSelectSource1", "MonoSelectSource2" };
-        static char *texts3[8] = {
+	static const char * const texts1[2] = { "ModemOut1", "ModemOut2" };
+	static const char * const texts2[2] = { "MonoSelectSource1", "MonoSelectSource2" };
+	static const char * const texts3[8] = {
                 "Mic", "CD", "Video", "Aux", "Line",
                 "Mix", "Mix Mono", "Phone"
         };
@@ -486,7 +490,10 @@
 	}
 	else
         	ucontrol->value.enumerated.item[0] = (val >> reg.lchan_shift) & (reg.enum_c - 1);
-	snd_azf3328_dbgmixer("get_enum: %02x is %04x -> %d|%d (shift %02d, enum_c %d)\n", reg.reg, val, ucontrol->value.enumerated.item[0], ucontrol->value.enumerated.item[1], reg.lchan_shift, reg.enum_c);
+
+	snd_azf3328_dbgmixer("get_enum: %02x is %04x -> %d|%d (shift %02d, enum_c %d)\n",
+		reg.reg, val, ucontrol->value.enumerated.item[0], ucontrol->value.enumerated.item[1],
+		reg.lchan_shift, reg.enum_c);
         return 0;
 }
 
@@ -521,12 +528,12 @@
 	return (nreg != oreg);
 }
 
-static snd_kcontrol_new_t snd_azf3328_mixer_controls[] __devinitdata = {
+static const snd_kcontrol_new_t snd_azf3328_mixer_controls[] __devinitdata = {
 	AZF3328_MIXER_SWITCH("Master Playback Switch", IDX_MIXER_PLAY_MASTER, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Master Playback Volume", IDX_MIXER_PLAY_MASTER, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Wave Playback Switch", IDX_MIXER_WAVEOUT, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Wave Playback Volume", IDX_MIXER_WAVEOUT, 0x1f, 1),
-	AZF3328_MIXER_SWITCH("Wave Playback 3D Bypass", IDX_MIXER_ADVCTL2, 7, 1),
+	AZF3328_MIXER_SWITCH("Wave 3D Bypass Playback Switch", IDX_MIXER_ADVCTL2, 7, 1),
 	AZF3328_MIXER_SWITCH("FM Playback Switch", IDX_MIXER_FMSYNTH, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("FM Playback Volume", IDX_MIXER_FMSYNTH, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("CD Playback Switch", IDX_MIXER_CDAUDIO, 15, 1),
@@ -539,8 +546,8 @@
 	AZF3328_MIXER_SWITCH("Mic Boost (+20dB)", IDX_MIXER_MIC, 6, 0),
 	AZF3328_MIXER_SWITCH("Line Playback Switch", IDX_MIXER_LINEIN, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Line Playback Volume", IDX_MIXER_LINEIN, 0x1f, 1),
-	AZF3328_MIXER_SWITCH("PCBeep Playback Switch", IDX_MIXER_PCBEEP, 15, 1),
-	AZF3328_MIXER_VOL_SPECIAL("PCBeep Playback Volume", IDX_MIXER_PCBEEP, 0x0f, 1, 1),
+	AZF3328_MIXER_SWITCH("PC Speaker Playback Switch", IDX_MIXER_PCBEEP, 15, 1),
+	AZF3328_MIXER_VOL_SPECIAL("PC Speaker Playback Volume", IDX_MIXER_PCBEEP, 0x0f, 1, 1),
 	AZF3328_MIXER_SWITCH("Video Playback Switch", IDX_MIXER_VIDEO, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Video Playback Volume", IDX_MIXER_VIDEO, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Aux Playback Switch", IDX_MIXER_AUX, 15, 1),
@@ -553,8 +560,8 @@
 	AZF3328_MIXER_ENUM("Mono Select Source", IDX_MIXER_ADVCTL2, 2, 9),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1, 0),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9, 0),
-	AZF3328_MIXER_SWITCH("3D Control - Toggle", IDX_MIXER_ADVCTL2, 13, 0),
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Volume", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
+	AZF3328_MIXER_SWITCH("3D Control - Switch", IDX_MIXER_ADVCTL2, 13, 0),
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Wide", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
 	AZF3328_MIXER_VOL_SPECIAL("3D Control - Space", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
 #if MIXER_TESTING
 	AZF3328_MIXER_SWITCH("0", IDX_MIXER_ADVCTL2, 0, 0),
@@ -576,9 +583,7 @@
 #endif
 };
 
-#define AZF3328_INIT_VALUES (sizeof(snd_azf3328_init_values)/sizeof(unsigned int)/2)
-
-static unsigned int snd_azf3328_init_values[][2] = {
+static const unsigned int snd_azf3328_init_values[][2] = {
         { IDX_MIXER_PLAY_MASTER,	MIXER_MUTE_MASK|0x1f1f },
         { IDX_MIXER_MODEMOUT,		MIXER_MUTE_MASK|0x1f1f },
 	{ IDX_MIXER_BASSTREBLE,		0x0000 },
@@ -597,7 +602,7 @@
 static int __devinit snd_azf3328_mixer_new(azf3328_t *chip)
 {
 	snd_card_t *card;
-	snd_kcontrol_new_t *sw;
+	const snd_kcontrol_new_t *sw;
 	unsigned int idx;
 	int err;
 
@@ -610,7 +615,7 @@
 	snd_azf3328_mixer_write(chip, IDX_MIXER_RESET, 0x0, WORD_VALUE);
 
 	/* mute and zero volume channels */
-	for (idx = 0; idx < AZF3328_INIT_VALUES; idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(snd_azf3328_init_values); idx++) {
 		snd_azf3328_mixer_write(chip, snd_azf3328_init_values[idx][0], snd_azf3328_init_values[idx][1], WORD_VALUE);
 	}
 	
@@ -701,7 +706,15 @@
 	 * FIXME: does this have some side effects for full-duplex
 	 * or other dramatic side effects? */
 	if (reg == IDX_IO_PLAY_SOUNDFORMAT) /* only do it for playback */
-		outw(inw(chip->codec_port + IDX_IO_PLAY_FLAGS)|DMA_PLAY_SOMETHING1|DMA_PLAY_SOMETHING2|SOMETHING_ALMOST_ALWAYS_SET|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_PLAY_FLAGS);
+		outw(
+			inw(chip->codec_port + IDX_IO_PLAY_FLAGS) |
+			DMA_PLAY_SOMETHING1 |
+			DMA_PLAY_SOMETHING2 |
+			SOMETHING_ALMOST_ALWAYS_SET |
+			DMA_EPILOGUE_SOMETHING |
+			DMA_SOMETHING_ELSE,
+			chip->codec_port + IDX_IO_PLAY_FLAGS
+		);
 
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 	snd_azf3328_dbgcallleave();
@@ -718,24 +731,34 @@
 	unsigned int count1;
 	unsigned int count2;
 	unsigned long flags;
-	int reg_offs = do_recording ? 0x20 : 0x00;
-
+	int reg_offs;
+	unsigned int is_running;
+	
 	snd_azf3328_dbgcallenter();
+	if (do_recording)
+	{
+		reg_offs = 0x20; /* access the capture register section */
+		is_running = chip->is_recording;
+	}
+	else
+	{
+		reg_offs = 0x00; /* access the playback register section */
+		is_running = chip->is_playing;
+	}
+
 	/* AZF3328 uses a two buffer pointer DMA playback approach */
-	if (!chip->is_playing)
+	if (!is_running)
 	{
+		unsigned long count_combo;
 		addr1 = addr;
 		addr2 = addr+(size/2);
-		count1 = (size/2)-1;
-		count2 = (size/2)-1;
-#if DEBUG_PLAY_REC
+		count1 = count2 = (size/2)-1;
 		snd_azf3328_dbgplay("setting dma: buf1 %08lx[%d], buf2 %08lx[%d]\n", addr1, count1, addr2, count2);
-#endif
+		count_combo = count1 | (count2 << 16);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 		outl(addr1, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_START_1);
 		outl(addr2, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_START_2);
-		outw(count1, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_1);
-		outw(count2, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_2);
+		outl(count_combo, chip->codec_port+reg_offs+IDX_IO_PLAY_DMA_LEN_1);
 		spin_unlock_irqrestore(&chip->reg_lock, flags);
 	}
 	snd_azf3328_dbgcallleave();
@@ -787,8 +810,7 @@
 	snd_azf3328_dbgcalls("snd_azf3328_playback_trigger cmd %d\n", cmd);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-
-		snd_azf3328_dbgio(chip, "trigger1");
+		snd_azf3328_dbgplay("START PLAYBACK\n");
 
 		/* mute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
@@ -802,7 +824,7 @@
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 	    
 		/* FIXME: clear interrupts or what??? */
-		outw(0xffff, chip->codec_port+IDX_IO_PLAY_IRQMASK);
+		outw(0xffff, chip->codec_port+IDX_IO_PLAY_IRQTYPE);
 		spin_unlock(&chip->reg_lock);
 
 		snd_azf3328_setdmaa(chip, runtime->dma_addr, snd_pcm_lib_period_bytes(substream), snd_pcm_lib_buffer_bytes(substream), 0);
@@ -818,7 +840,7 @@
 		status1 |= DMA_RESUME | DMA_EPILOGUE_SOMETHING;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 #else /* NT4 */
-		outw(0x00, chip->codec_port+IDX_IO_PLAY_FLAGS);
+		outw(0x0000, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_PLAY_SOMETHING1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_PLAY_SOMETHING1|DMA_PLAY_SOMETHING2, chip->codec_port+IDX_IO_PLAY_FLAGS);
 		outw(DMA_RESUME|SOMETHING_ALMOST_ALWAYS_SET|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port+IDX_IO_PLAY_FLAGS);
@@ -828,10 +850,12 @@
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
 
-		snd_azf3328_dbgio(chip, "trigger2");
 		chip->is_playing = 1;
+		snd_azf3328_dbgplay("STARTED PLAYBACK\n");
 		break;
-        case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_STOP:
+		snd_azf3328_dbgplay("STOP PLAYBACK\n");
+
 		/* mute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
 
@@ -842,6 +866,8 @@
 		status1 &= ~DMA_RESUME;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 
+		/* hmm, is this really required? we're resetting the same bit
+		 * immediately thereafter... */
 		status1 |= DMA_PLAY_SOMETHING1;
 		outw(status1, chip->codec_port+IDX_IO_PLAY_FLAGS);
 
@@ -852,6 +878,7 @@
 		/* now unmute WaveOut */
 		snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 0);
 		chip->is_playing = 0;
+		snd_azf3328_dbgplay("STOPPED PLAYBACK\n");
 		break;
         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_printk("FIXME: SNDRV_PCM_TRIGGER_PAUSE_PUSH NIY!\n");
@@ -880,7 +907,7 @@
         switch (cmd) {
         case SNDRV_PCM_TRIGGER_START:
 
-		snd_azf3328_dbgio(chip, "trigger1");
+		snd_azf3328_dbgplay("START CAPTURE\n");
 
 		snd_azf3328_setfmt(chip, IDX_IO_REC_SOUNDFORMAT, runtime->rate, snd_pcm_format_width(runtime->format), runtime->channels);
 
@@ -891,7 +918,7 @@
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
 	    
 		/* FIXME: clear interrupts or what??? */
-		outw(0xffff, chip->codec_port+IDX_IO_REC_IRQMASK);
+		outw(0xffff, chip->codec_port+IDX_IO_REC_IRQTYPE);
 		spin_unlock(&chip->reg_lock);
 
 		snd_azf3328_setdmaa(chip, runtime->dma_addr, snd_pcm_lib_period_bytes(substream), snd_pcm_lib_buffer_bytes(substream), 1);
@@ -902,7 +929,7 @@
 		status1 |= DMA_PLAY_SOMETHING1 | DMA_PLAY_SOMETHING2;
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
 
-		/* start playback again */
+		/* start capture again */
 		/* FIXME: what is this value (0x0010)??? */
 		status1 |= DMA_RESUME | DMA_EPILOGUE_SOMETHING;
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
@@ -914,10 +941,12 @@
 #endif
 		spin_unlock(&chip->reg_lock);
 
-		snd_azf3328_dbgio(chip, "trigger2");
-		chip->is_playing = 1;
+		chip->is_recording = 1;
+		snd_azf3328_dbgplay("STARTED CAPTURE\n");
 		break;
         case SNDRV_PCM_TRIGGER_STOP:
+		snd_azf3328_dbgplay("STOP CAPTURE\n");
+
 		spin_lock(&chip->reg_lock);
 		/* stop recording */
 		status1 = inw(chip->codec_port+IDX_IO_REC_FLAGS);
@@ -932,7 +961,8 @@
 		outw(status1, chip->codec_port+IDX_IO_REC_FLAGS);
 		spin_unlock(&chip->reg_lock);
 	    
-		chip->is_playing = 0;
+		chip->is_recording = 0;
+		snd_azf3328_dbgplay("STOPPED CAPTURE\n");
 		break;
         case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_printk("FIXME: SNDRV_PCM_TRIGGER_PAUSE_PUSH NIY!\n");
@@ -964,7 +994,7 @@
 
 	result = playptr - bufptr;
 	frmres = bytes_to_frames( substream->runtime, result );
-	snd_azf3328_dbgplay("result %lx, playptr %lx (base %x), frames %ld\n", result, playptr, substream->runtime->dma_addr, frmres);
+	snd_azf3328_dbgplay("PLAY @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
 
@@ -984,7 +1014,7 @@
 
 	result = recptr - bufptr;
 	frmres = bytes_to_frames( substream->runtime, result );
-	snd_azf3328_dbgplay("result %lx, rec ptr %lx (base %x), frames %ld\n", result, recptr, substream->runtime->dma_addr, frmres);
+	snd_azf3328_dbgplay("REC  @ 0x%8lx, frames %8ld\n", result, frmres);
 	return frmres;
 }
 
@@ -992,75 +1022,79 @@
 {
 	azf3328_t *chip = dev_id;
 	unsigned int status, which;
-	static unsigned long count;
+	static unsigned long irq_count;
 
 	status  = inw(chip->codec_port+IDX_IO_IRQSTATUS);
 
         /* fast path out, to ease interrupt sharing */
-	if (!(status & (IRQ_PLAYBACK|IRQ_RECORDING|IRQ_MPU401|IRQ_SOMEIRQ)))
+	if (!(status & (IRQ_PLAYBACK|IRQ_RECORDING|IRQ_MPU401|IRQ_TIMER)))
 		return IRQ_NONE; /* must be interrupt for another device */
 
-	snd_azf3328_dbgplay("Interrupt %ld!\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQMASK %04x, IDX_IO_IRQSTATUS %04x\n", count, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQMASK), inw(chip->codec_port+IDX_IO_IRQSTATUS));
+	snd_azf3328_dbgplay("Interrupt %ld!\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQTYPE %04x, IDX_IO_IRQSTATUS %04x\n",
+		irq_count, inw(chip->codec_port+IDX_IO_PLAY_FLAGS), inw(chip->codec_port+IDX_IO_PLAY_IRQTYPE), status);
 		
 	if (status & IRQ_PLAYBACK)
 	{
 		spin_lock(&chip->reg_lock);
-		which = inw(chip->codec_port+IDX_IO_PLAY_IRQMASK);
-		if (which & IRQ_FINISHED_PLAYBUF_1)
-			/* ack IRQ */
-			outw(which | IRQ_FINISHED_PLAYBUF_1, chip->codec_port+IDX_IO_PLAY_IRQMASK);
-		if (which & IRQ_FINISHED_PLAYBUF_2)
-			/* ack IRQ */
-			outw(which | IRQ_FINISHED_PLAYBUF_2, chip->codec_port+IDX_IO_PLAY_IRQMASK);
+		which = inw(chip->codec_port+IDX_IO_PLAY_IRQTYPE);
+		/* ack all IRQ types immediately */
+		outw(which, chip->codec_port+IDX_IO_PLAY_IRQTYPE);
+               	spin_unlock(&chip->reg_lock);
 		if (which & IRQ_PLAY_SOMETHING)
 		{
 			snd_azf3328_dbgplay("azt3328: unknown play IRQ type occurred, please report!\n");
 		}
 		if (chip->pcm && chip->playback_substream)
 		{
-			snd_azf3328_dbgplay("which %x, playptr %lx\n", which, inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
+			snd_azf3328_dbgplay("which %x, playptr %x\n", which, inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
 			snd_pcm_period_elapsed(chip->playback_substream);
-			snd_azf3328_dbgplay("period done, playptr %lx.\n", inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
+			snd_azf3328_dbgplay("period done, playptr %x\n", inl(chip->codec_port+IDX_IO_PLAY_DMA_CURRPOS));
 		}
 		else
 			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
-               	spin_unlock(&chip->reg_lock);
 	}
 	if (status & IRQ_RECORDING)
 	{
                 spin_lock(&chip->reg_lock);
-		which = inw(chip->codec_port+IDX_IO_REC_IRQMASK);
-		if (which & IRQ_FINISHED_RECBUF_1)
-			/* ack interrupt */
-			outw(which | IRQ_FINISHED_RECBUF_1, chip->codec_port+IDX_IO_REC_IRQMASK);
-		if (which & IRQ_FINISHED_RECBUF_2)
-			/* ack interrupt */
-			outw(which | IRQ_FINISHED_RECBUF_2, chip->codec_port+IDX_IO_REC_IRQMASK);
+		which = inw(chip->codec_port+IDX_IO_REC_IRQTYPE);
+		/* ack all IRQ types immediately */
+		outw(which, chip->codec_port+IDX_IO_REC_IRQTYPE);
+               	spin_unlock(&chip->reg_lock);
 		if (which & IRQ_REC_SOMETHING)
 		{
 			snd_azf3328_dbgplay("azt3328: unknown rec IRQ type occurred, please report!\n");
 		}
 		if (chip->pcm && chip->capture_substream)
 		{
-			snd_azf3328_dbgplay("which %x, recptr %lx\n", which, inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
-			spin_unlock(&chip->reg_lock);
+			snd_azf3328_dbgplay("which %x, recptr %x\n", which, inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
 			snd_pcm_period_elapsed(chip->capture_substream);
-			spin_lock(&chip->reg_lock);
-			snd_azf3328_dbgplay("period done, recptr %lx.\n", inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
+			snd_azf3328_dbgplay("period done, recptr %x\n", inl(chip->codec_port+IDX_IO_REC_DMA_CURRPOS));
 		}
-               	spin_unlock(&chip->reg_lock);
 	}
 	if (status & IRQ_MPU401)
+	{
+		snd_azf3328_dbgplay("azt3328: MPU401 IRQ\n");
 		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
-	if (status & IRQ_SOMEIRQ)
-		snd_azf3328_dbgplay("azt3328: unknown IRQ type occurred, please report!\n");
-	count++;
+		/* hmm, do we have to ack the IRQ here somehow? If so, then I don't know how... */
+	}
+	if (status & IRQ_TIMER)
+	{
+		unsigned long timerval;
+		timerval = inl(chip->codec_port+IDX_IO_TIMER_VALUE);
+		snd_azf3328_dbgplay("azt3328: DirectX timer IRQ, current value %ld\n",
+			timerval & TIMER_VALUE_MASK);
+
+		/* ACK timer IRQ,
+		 * by writing back the same config settings but not touching the value */
+		outb(timerval >> 24, chip->codec_port+IDX_IO_TIMER_VALUE + 3);
+	}
+	irq_count++;
 	return IRQ_HANDLED;
 }
 
 /*****************************************************************/
 
-static snd_pcm_hardware_t snd_azf3328_playback =
+static const snd_pcm_hardware_t snd_azf3328_playback =
 {
 	/* FIXME!! Correct? */
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
@@ -1083,7 +1117,7 @@
 	.fifo_size =		0,
 };
 
-static snd_pcm_hardware_t snd_azf3328_capture =
+static const snd_pcm_hardware_t snd_azf3328_capture =
 {
 	/* FIXME */
 	.info =			(SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
@@ -1287,11 +1321,12 @@
 	snd_azf3328_mixer_set_mute(chip, IDX_MIXER_PLAY_MASTER, 1); /* first mute master volume */
 	snd_azf3328_mixer_write(chip, IDX_MIXER_RESET, 0x0, WORD_VALUE);
 
-        /* interrupt setup - mask everything */
-	/* FIXME */
+        /* interrupt setup - mask everything (FIXME!) */
+	/* well, at least we know how to disable the timer */
+	outb(0x0, chip->codec_port + IDX_IO_TIMER_VALUE + 3);
 
         synchronize_irq(chip->irq);
-      __end_hw:
+__end_hw:
 	snd_azf3328_free_joystick(chip);
         if (chip->irq >= 0)
 		free_irq(chip->irq, (void *)chip);
@@ -1328,6 +1363,23 @@
 }
 #endif
 
+static void snd_azf3328_debug_show_ports(void)
+{
+#if DEBUG_MISC
+	u16 tmp;
+
+	snd_azf3328_dbgmisc("codec_port 0x%lx, io2_port 0x%lx, mpu_port 0x%lx, synth_port 0x%lx, mixer_port 0x%lx, irq %d\n", chip->codec_port, chip->io2_port, chip->mpu_port, chip->synth_port, chip->mixer_port, chip->irq);
+
+	snd_azf3328_dbgmisc("io2 %02x %02x %02x %02x %02x %02x\n", snd_azf3328_io2_read(chip, 0), snd_azf3328_io2_read(chip, 1), snd_azf3328_io2_read(chip, 2), snd_azf3328_io2_read(chip, 3), snd_azf3328_io2_read(chip, 4), snd_azf3328_io2_read(chip, 5));
+
+	for (tmp=0; tmp <= 0x01; tmp += 1)
+		snd_azf3328_dbgmisc("0x%02x: opl 0x%04x, mpu300 0x%04x, mpu310 0x%04x, mpu320 0x%04x, mpu330 0x%04x\n", tmp, inb(0x388 + tmp), inb(0x300 + tmp), inb(0x310 + tmp), inb(0x320 + tmp), inb(0x330 + tmp));
+
+	for (tmp = 0; tmp <= 0x6E; tmp += 2)
+		snd_azf3328_dbgmisc("0x%02x: 0x%04x\n", tmp, inb(chip->codec_port + tmp));
+#endif
+}
+
 static int __devinit snd_azf3328_create(snd_card_t * card,
                                          struct pci_dev *pci,
                                          unsigned long device_type,
@@ -1338,7 +1390,6 @@
 	static snd_device_ops_t ops = {
 		.dev_free =     snd_azf3328_dev_free,
 	};
-	u16 tmp;
 
 	*rchip = NULL;
 
@@ -1384,13 +1435,8 @@
 	pci_set_master(pci);
 	synchronize_irq(chip->irq);
 
-	snd_azf3328_dbgmisc("codec_port 0x%lx, io2_port 0x%lx, mpu_port 0x%lx, synth_port 0x%lx, mixer_port 0x%lx, irq %d\n", chip->codec_port, chip->io2_port, chip->mpu_port, chip->synth_port, chip->mixer_port, chip->irq);
-
-	snd_azf3328_dbgmisc("io2 %02x %02x %02x %02x %02x %02x\n", snd_azf3328_io2_read(chip, 0), snd_azf3328_io2_read(chip, 1), snd_azf3328_io2_read(chip, 2), snd_azf3328_io2_read(chip, 3), snd_azf3328_io2_read(chip, 4), snd_azf3328_io2_read(chip, 5));
-
-	for (tmp=0; tmp <= 0x01; tmp += 1)
-		snd_azf3328_dbgmisc("0x%02x: opl 0x%04x, mpu300 0x%04x, mpu310 0x%04x, mpu320 0x%04x, mpu330 0x%04x\n", tmp, inb(0x388 + tmp), inb(0x300 + tmp), inb(0x310 + tmp), inb(0x320 + tmp), inb(0x330 + tmp));
-
+	snd_azf3328_debug_show_ports();
+	
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
 		snd_azf3328_free(chip);
 		return err;
@@ -1408,10 +1454,9 @@
 	/* standard chip init stuff */
 	spin_lock_irq(&chip->reg_lock);
 	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_PLAY_FLAGS);
-	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_SOMETHING_FLAGS);
 	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_REC_FLAGS);
-	outb(0x0, chip->codec_port + IDX_IO_IRQ63H);
-
+	outb(DMA_PLAY_SOMETHING2|DMA_EPILOGUE_SOMETHING|DMA_SOMETHING_ELSE, chip->codec_port + IDX_IO_SOMETHING_FLAGS);
+	outb(0x0, chip->codec_port + IDX_IO_TIMER_VALUE + 3); /* disable timer */
 	spin_unlock_irq(&chip->reg_lock);
 
 	snd_card_set_dev(card, &pci->dev);
@@ -1473,8 +1518,6 @@
 		}
 	}
 
-	snd_azf3328_dbgio(chip, "create");
-
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->codec_port, chip->irq);
 
Index: alsa-kernel/pci/azt3328.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.h,v
retrieving revision 1.1
diff -u -r1.1 azt3328.h
--- alsa-kernel/pci/azt3328.h	2 Jun 2003 12:59:41 -0000	1.1
+++ alsa-kernel/pci/azt3328.h	16 Sep 2005 23:33:27 -0000
@@ -1,19 +1,22 @@
-#ifndef __SOUND_AZF3328_H
-#define __SOUND_AZF3328_H
+#ifndef __SOUND_AZT3328_H
+#define __SOUND_AZT3328_H
 
 /* type argument to use for the I/O functions */
 #define WORD_VALUE      0x1000
 #define DWORD_VALUE     0x2000
 #define BYTE_VALUE      0x4000
 
+/* "PU" == "power-up value", as tested on PCI168 PCI rev. 10 */
+
 /*** main I/O area port indices ***/
 /* (only 0x70 of 0x80 bytes saved/restored by Windows driver) */
-/* the driver initialisation suggests a layout of 3 main areas:
- * from 0x00 (playback), from 0x20 (recording) and from 0x40 (maybe DirectX
- * timer ???). and probably another area from 0x60 to 0x6f
- * (IRQ management, power management etc. ???). */
-/* playback area */
-#define IDX_IO_PLAY_FLAGS       0x00
+/* the driver initialisation suggests a layout of 4 main areas:
+ * from 0x00 (playback), from 0x20 (recording) and from 0x40 (maybe MPU401??).
+ * And another area from 0x60 to 0x6f (DirectX timer, IRQ management,
+ * power management etc.???). */
+
+/** playback area **/
+#define IDX_IO_PLAY_FLAGS       0x00 /* PU:0x0000 */
      /* able to reactivate output after output muting due to 8/16bit
       * output change, just like 0x0002.
       * 0x0001 is the only bit that's able to start the DMA counter */
@@ -29,7 +32,7 @@
   #define DMA_EPILOGUE_SOMETHING	0x0010
   #define DMA_SOMETHING_ELSE		0x0020 /* ??? */
   #define SOMETHING_UNMODIFIABLE	0xffc0 /* unused ? not modifiable */
-#define IDX_IO_PLAY_IRQMASK     0x02
+#define IDX_IO_PLAY_IRQTYPE     0x02 /* PU:0x0001 */
   /* write back to flags in case flags are set, in order to ACK IRQ in handler
    * (bit 1 of port 0x64 indicates interrupt for one of these three types)
    * sometimes in this case it just writes 0xffff to globally ACK all IRQs
@@ -41,13 +44,13 @@
   #define IRQMASK_SOME_STATUS_1		0x0008 /* \ related bits */
   #define IRQMASK_SOME_STATUS_2		0x0010 /* / (checked together in loop) */
   #define IRQMASK_UNMODIFIABLE		0xffe0 /* unused ? not modifiable */
-#define IDX_IO_PLAY_DMA_START_1 0x04 /* start address of 1st DMA play area */
-#define IDX_IO_PLAY_DMA_START_2 0x08 /* start address of 2nd DMA play area */
-#define IDX_IO_PLAY_DMA_LEN_1   0x0c /* length of 1st DMA play area */
-#define IDX_IO_PLAY_DMA_LEN_2   0x0e /* length of 2nd DMA play area */
-#define IDX_IO_PLAY_DMA_CURRPOS 0x10 /* current DMA position  */
-#define IDX_IO_PLAY_DMA_CURROFS	0x14 /* offset within current DMA play area */
-#define IDX_IO_PLAY_SOUNDFORMAT 0x16
+#define IDX_IO_PLAY_DMA_START_1 0x04 /* start address of 1st DMA play area, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_START_2 0x08 /* start address of 2nd DMA play area, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_LEN_1   0x0c /* length of 1st DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_DMA_LEN_2   0x0e /* length of 2nd DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_DMA_CURRPOS 0x10 /* current DMA position, PU:0x00000000 */
+#define IDX_IO_PLAY_DMA_CURROFS	0x14 /* offset within current DMA play area, PU:0x0000 */
+#define IDX_IO_PLAY_SOUNDFORMAT 0x16 /* PU:0x0010 */
   /* all unspecified bits can't be modified */
   #define SOUNDFORMAT_FREQUENCY_MASK	0x000f
     /* all _SUSPECTED_ values are not used by Windows drivers, so we don't
@@ -68,9 +71,10 @@
     #define SOUNDFORMAT_FREQ_SUSPECTED_64000	0x07
   #define SOUNDFORMAT_FLAG_16BIT	0x0010
   #define SOUNDFORMAT_FLAG_2CHANNELS	0x0020
-/* recording area (see also: playback bit flag definitions) */
-#define IDX_IO_REC_FLAGS	0x20 /* ?? */
-#define IDX_IO_REC_IRQMASK	0x22 /* ?? */
+
+/** recording area (see also: playback bit flag definitions) **/
+#define IDX_IO_REC_FLAGS	0x20 /* ??, PU:0x0000 */
+#define IDX_IO_REC_IRQTYPE	0x22 /* ??, PU:0x0000 */
   #define IRQ_REC_SOMETHING		0x0001 /* something & ACK */
   #define IRQ_FINISHED_RECBUF_1		0x0002 /* 1st dmabuf finished & ACK */
   #define IRQ_FINISHED_RECBUF_2		0x0004 /* 2nd dmabuf finished & ACK */
@@ -78,39 +82,46 @@
    * but OTOH they are most likely at port 0x22 instead */
   #define IRQMASK_SOME_STATUS_1		0x0008 /* \ related bits */
   #define IRQMASK_SOME_STATUS_2		0x0010 /* / (checked together in loop) */
-#define IDX_IO_REC_DMA_START_1  0x24
-#define IDX_IO_REC_DMA_START_2  0x28
-#define IDX_IO_REC_DMA_LEN_1    0x2c
-#define IDX_IO_REC_DMA_LEN_2    0x2e
-#define IDX_IO_REC_DMA_CURRPOS  0x30
-#define IDX_IO_REC_DMA_CURROFS  0x34
-#define IDX_IO_REC_SOUNDFORMAT  0x36
-/* some third area ? (after playback and recording) */
-#define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init */
+#define IDX_IO_REC_DMA_START_1  0x24 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_START_2  0x28 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_LEN_1    0x2c /* PU:0x0000 */
+#define IDX_IO_REC_DMA_LEN_2    0x2e /* PU:0x0000 */
+#define IDX_IO_REC_DMA_CURRPOS  0x30 /* PU:0x00000000 */
+#define IDX_IO_REC_DMA_CURROFS  0x34 /* PU:0x00000000 */
+#define IDX_IO_REC_SOUNDFORMAT  0x36 /* PU:0x0000 */
+
+/** hmm, what is this I/O area for? MPU401?? (after playback, recording, ???, timer) **/
+#define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init, PU:0x0000 */
 /* general */
-#define IDX_IO_60H		0x60 /* writing 0xffff returns 0xffff */
-#define IDX_IO_62H		0x62 /* writing to WORD 0x0062 can hang the box ! --> responsible for IRQ management as a whole ?? */
-#define IDX_IO_IRQ63H		0x63 /* FIXME !! */
-  #define IO_IRQ63H_SOMETHING		0x04 /* being set in IRQ handler in case port 0x00 had 0x0020 set upon IRQ handler */
+#define IDX_IO_42H		0x42 /* PU:0x0001 */
+
+/** DirectX timer, main interrupt area (FIXME: and something else?) **/ 
+#define IDX_IO_TIMER_VALUE	0x60 /* found this timer area by pure luck :-) */
+  #define TIMER_VALUE_MASK		0x000fffff /* timer countdown value; triggers IRQ when timer is finished */
+  #define TIMER_ENABLE_COUNTDOWN	0x01000000 /* activate the timer countdown */
+  #define TIMER_ENABLE_IRQ		0x02000000 /* trigger timer IRQ on zero transition */
+  #define TIMER_SOMEFLAG		0x04000000 /* being set in IRQ handler in case port 0x00 (hmm, not port 0x64!?!?) had 0x0020 set upon IRQ handler */
 #define IDX_IO_IRQSTATUS        0x64
   #define IRQ_PLAYBACK			0x0001
   #define IRQ_RECORDING			0x0002
   #define IRQ_MPU401			0x0010
-  #define IRQ_SOMEIRQ			0x0020 /* ???? */
+  #define IRQ_TIMER			0x0020 /* DirectX timer */
   #define IRQ_WHO_KNOWS_UNUSED		0x00e0 /* probably unused */
 #define IDX_IO_66H		0x66    /* writing 0xffff returns 0x0000 */
-#define IDX_IO_SOME_VALUE	0x68	/* this is always set to 0x3ff, and writable; maybe some buffer limit, but I couldn't find out more */
-#define IDX_IO_6AH		0x6A	/* this WORD can be set to have bits 0x0028 activated; actually inhibits PCM playback !!! maybe power management ?? */
-#define IDX_IO_6CH		0x6C	/* this WORD can have all its bits activated ? */
+#define IDX_IO_SOME_VALUE	0x68	/* this is set to e.g. 0x3ff or 0x300, and writable; maybe some buffer limit, but I couldn't find out more, PU:0x00ff */
+#define IDX_IO_6AH		0x6A	/* this WORD can be set to have bits 0x0028 activated; actually inhibits PCM playback!!! maybe power management?? */
+#define IDX_IO_6CH		0x6C
 #define IDX_IO_6EH		0x6E	/* writing 0xffff returns 0x83fe */
 /* further I/O indices not saved/restored, so probably not used */
 
+
 /*** I/O 2 area port indices ***/
 /* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */ 
 #define IDX_IO2_LEGACY_ADDR	0x04
-  #define LEGACY_SOMETHING		0x01 /* OPL3 ?? */
+  #define LEGACY_SOMETHING		0x01 /* OPL3?? */
   #define LEGACY_JOY			0x08
 
+
 /*** mixer I/O area port indices ***/
 /* (only 0x22 of 0x40 bytes saved/restored by Windows driver)
  * generally spoken: AC97 register index = AZF3328 mixer reg index + 2
@@ -148,18 +159,18 @@
   /* unlisted bits are unmodifiable */
   #define MIXER_ADVCTL1_3DWIDTH_MASK	0x000e
   #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300
-#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg ! */
+#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg! */
   /* unlisted bits are unmodifiable */
-  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass ? mutes WaveOut at LineOut */
-  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select ? */
-  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source ? */
-  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable ? */
+  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass? mutes WaveOut at LineOut */
+  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select? */
+  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source? */
+  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable? */
   #define MIXER_ADVCTL2_BIT15		0x8000 /* unknown */
   
-#define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown ??? */
+#define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown??? */
 
 /* driver internal flags */
 #define SET_CHAN_LEFT	1
 #define SET_CHAN_RIGHT	2
 
-#endif /* __SOUND_AZF3328_H  */
+#endif /* __SOUND_AZT3328_H  */

--LZvS9be/3tNcYl/X--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
