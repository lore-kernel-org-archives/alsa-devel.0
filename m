From: Andreas Mohr <andi@lisas.de>
Subject: Repaired version ([PATCH] PCI168 snd-azt3328: some
	more fixups)
Date: Mon, 23 Jun 2008 00:07:24 +0200
Message-ID: <20080622220724.GA15867@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C77B10381A
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 00:07:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

update: darn, I just noticed that those "unknown" play/rec IRQ types
actually do turn up on dmesg _sometimes_ (a bit too often),
thus a printk KERN_WARNING wasn't quite such a good idea...
(revert it to optional debug logging, will possibly figure out its meaning
later)

----

another update:

- fix problem with codec register 0x6a being write-only
  by adding a software shadow register
  (caused annoying noise after module loading due to _toggling_
  between gameport and audio bits instead of configuring them properly)
- rename several "Wave" mixer controls to "PCM", since this is
  what Wine and several other apps are looking for (IOW, _requiring_)
  and this is what AC97 specs use as naming, too,
  thus I'd guess it's what these controls are
- cleanup, small optimizations

Patch diffed against patched 2.6.26-rc6 (patched with my last patch
submission, that is, IOW it should apply to current ALSA tree easily).
checkpatch.pl tested, runtime tested.

Hopefully this will come in time for 1.0.17 and/or the next kernel merge
before my previous patch hits the streets ;)
(to have this all in one go)

Thanks!

Signed-off-by: Andreas Mohr <andi@lisas.de>


--- azt3328.c.my_org	2008-06-14 08:20:36.000000000 +0200
+++ azt3328.c	2008-06-22 23:02:57.000000000 +0200
@@ -289,6 +289,12 @@
 	struct pci_dev *pci;
 	int irq;
 
+	/* register 0x6a is write-only, thus need to remember setting.
+	 * If we need to add more registers here, then we might try to fold this
+	 * into some transparent combined shadow register handling with
+	 * CONFIG_PM register storage below, but that's slightly difficult. */
+	u16 shadow_reg_codec_6AH;
+
 #ifdef CONFIG_PM
 	/* register value containers for power management
 	 * Note: not always full I/O range preserved (just like Win driver!) */
@@ -324,21 +330,6 @@
 	return 0;
 }
 
-static int
-snd_azf3328_io_reg_setw(unsigned reg, u16 mask, int do_set)
-{
-	u16 prev = inw(reg), new;
-
-	new = (do_set) ? (prev|mask) : (prev & ~mask);
-	/* we need to always write the new value no matter whether it differs or not,
-	 * since some register bits don't indicate their setting */
-	outw(new, reg);
-	if (new != prev)
-		return 1;
-
-	return 0;
-}
-
 static inline void
 snd_azf3328_codec_outb(const struct snd_azf3328 *chip, unsigned reg, u8 value)
 {
@@ -662,7 +653,7 @@
 		"pre 3D", "post 3D"
         };
 	struct azf3328_mixer_reg reg;
-	const char *p = NULL;
+	const char * const *p = NULL;
 
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
         uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
@@ -673,20 +664,20 @@
 	if (reg.reg == IDX_MIXER_ADVCTL2) {
 		switch(reg.lchan_shift) {
 		case 8: /* modem out sel */
-			p = texts1[uinfo->value.enumerated.item];
+			p = texts1;
 			break;
 		case 9: /* mono sel source */
-			p = texts2[uinfo->value.enumerated.item];
+			p = texts2;
 			break;
 		case 15: /* PCM Out Path */
-			p = texts4[uinfo->value.enumerated.item];
+			p = texts4;
 			break;
 		}
 	} else
 	if (reg.reg == IDX_MIXER_REC_SELECT)
-		p = texts3[uinfo->value.enumerated.item];
+		p = texts3;
 
-	strcpy(uinfo->value.enumerated.name, p);
+	strcpy(uinfo->value.enumerated.name, p[uinfo->value.enumerated.item]);
         return 0;
 }
 
@@ -745,9 +736,11 @@
 static struct snd_kcontrol_new snd_azf3328_mixer_controls[] __devinitdata = {
 	AZF3328_MIXER_SWITCH("Master Playback Switch", IDX_MIXER_PLAY_MASTER, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("Master Playback Volume", IDX_MIXER_PLAY_MASTER, 0x1f, 1),
-	AZF3328_MIXER_SWITCH("Wave Playback Switch", IDX_MIXER_WAVEOUT, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Wave Playback Volume", IDX_MIXER_WAVEOUT, 0x1f, 1),
-	AZF3328_MIXER_SWITCH("Wave 3D Bypass Playback Switch", IDX_MIXER_ADVCTL2, 7, 1),
+	AZF3328_MIXER_SWITCH("PCM Playback Switch", IDX_MIXER_WAVEOUT, 15, 1),
+	AZF3328_MIXER_VOL_STEREO("PCM Playback Volume",
+					IDX_MIXER_WAVEOUT, 0x1f, 1),
+	AZF3328_MIXER_SWITCH("PCM 3D Bypass Playback Switch",
+					IDX_MIXER_ADVCTL2, 7, 1),
 	AZF3328_MIXER_SWITCH("FM Playback Switch", IDX_MIXER_FMSYNTH, 15, 1),
 	AZF3328_MIXER_VOL_STEREO("FM Playback Volume", IDX_MIXER_FMSYNTH, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("CD Playback Switch", IDX_MIXER_CDAUDIO, 15, 1),
@@ -874,7 +867,7 @@
 static void
 snd_azf3328_codec_setfmt(struct snd_azf3328 *chip,
 			       unsigned reg,
-			       unsigned int bitrate,
+			       enum azf_freq_t bitrate,
 			       unsigned int format_width,
 			       unsigned int channels
 )
@@ -958,15 +951,29 @@
 	snd_azf3328_codec_setfmt(chip, reg, AZF_FREQ_4000, 8, 1);
 }
 
+static void
+snd_azf3328_codec_reg_6AH_update(struct snd_azf3328 *chip,
+					unsigned bitmask,
+					int enable
+)
+{
+	if (enable)
+		chip->shadow_reg_codec_6AH &= ~bitmask;
+	else
+		chip->shadow_reg_codec_6AH |= bitmask;
+	snd_azf3328_dbgplay("6AH_update mask 0x%04x enable %d: val 0x%04x\n",
+			bitmask, enable, chip->shadow_reg_codec_6AH);
+	snd_azf3328_codec_outw(chip, IDX_IO_6AH, chip->shadow_reg_codec_6AH);
+}
+
 static inline void
 snd_azf3328_codec_enable(struct snd_azf3328 *chip, int enable)
 {
+	snd_azf3328_dbgplay("codec_enable %d\n", enable);
 	/* no idea what exactly is being done here, but I strongly assume it's
 	 * PM related */
-	snd_azf3328_io_reg_setw(
-		chip->codec_io+IDX_IO_6AH,
-		IO_6A_PAUSE_PLAYBACK_BIT8,
-		!enable
+	snd_azf3328_codec_reg_6AH_update(
+		chip, IO_6A_PAUSE_PLAYBACK_BIT8, enable
 	);
 }
 
@@ -1404,10 +1411,8 @@
 static inline void
 snd_azf3328_gameport_axis_circuit_enable(struct snd_azf3328 *chip, int enable)
 {
-	snd_azf3328_io_reg_setw(
-		chip->codec_io+IDX_IO_6AH,
-		IO_6A_SOMETHING2_GAMEPORT,
-		!enable
+	snd_azf3328_codec_reg_6AH_update(
+		chip, IO_6A_SOMETHING2_GAMEPORT, enable
 	);
 }
 
@@ -1525,8 +1530,6 @@
 {
 	struct gameport *gp;
 
-	int io_port = chip->game_io;
-
 	chip->gameport = gp = gameport_allocate_port();
 	if (!gp) {
 		printk(KERN_ERR "azt3328: cannot alloc memory for gameport\n");
@@ -1536,7 +1539,7 @@
 	gameport_set_name(gp, "AZF3328 Gameport");
 	gameport_set_phys(gp, "pci%s/gameport0", pci_name(chip->pci));
 	gameport_set_dev_parent(gp, &chip->pci->dev);
-	gp->io = io_port;
+	gp->io = chip->game_io;
 	gameport_set_port_data(gp, chip);
 
 	gp->open = snd_azf3328_gameport_open;
@@ -1577,6 +1580,15 @@
 
 /******************************************************************/
 
+static inline void
+snd_azf3328_irq_log_unknown_type(u8 which)
+{
+	snd_azf3328_dbgplay(
+	"azt3328: unknown IRQ type (%x) occurred, please report!\n",
+		which
+	);
+}
+
 static irqreturn_t
 snd_azf3328_interrupt(int irq, void *dev_id)
 {
@@ -1594,11 +1606,14 @@
 	))
 		return IRQ_NONE; /* must be interrupt for another device */
 
-	snd_azf3328_dbgplay("Interrupt %ld!\nIDX_IO_PLAY_FLAGS %04x, IDX_IO_PLAY_IRQTYPE %04x, IDX_IO_IRQSTATUS %04x\n",
-		irq_count++ /* debug-only */,
-		snd_azf3328_codec_inw(chip, IDX_IO_PLAY_FLAGS),
-		snd_azf3328_codec_inw(chip, IDX_IO_PLAY_IRQTYPE),
-		status);
+	snd_azf3328_dbgplay(
+		"irq_count %ld! IDX_IO_PLAY_FLAGS %04x, "
+		"IDX_IO_PLAY_IRQTYPE %04x, IDX_IO_IRQSTATUS %04x\n",
+			irq_count++ /* debug-only */,
+			snd_azf3328_codec_inw(chip, IDX_IO_PLAY_FLAGS),
+			snd_azf3328_codec_inw(chip, IDX_IO_PLAY_IRQTYPE),
+			status
+	);
 
 	if (status & IRQ_TIMER) {
 		/* snd_azf3328_dbgplay("timer %ld\n",
@@ -1631,9 +1646,9 @@
 				)
 			);
 		} else
-			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
+			printk(KERN_WARNING "azt3328: irq handler problem!\n");
 		if (which & IRQ_PLAY_SOMETHING)
-			snd_azf3328_dbgplay("azt3328: unknown play IRQ type occurred, please report!\n");
+			snd_azf3328_irq_log_unknown_type(which);
 	}
 	if (status & IRQ_RECORDING) {
                 spin_lock(&chip->reg_lock);
@@ -1653,9 +1668,9 @@
 				)
 			);
 		} else
-			snd_azf3328_dbgplay("azt3328: ouch, irq handler problem!\n");
+			printk(KERN_WARNING "azt3328: irq handler problem!\n");
 		if (which & IRQ_REC_SOMETHING)
-			snd_azf3328_dbgplay("azt3328: unknown rec IRQ type occurred, please report!\n");
+			snd_azf3328_irq_log_unknown_type(which);
 	}
 	if (status & IRQ_GAMEPORT)
 		snd_azf3328_gameport_interrupt(chip);
@@ -2311,6 +2326,10 @@
 
 	for (reg = 0; reg < AZF_IO_SIZE_CODEC_PM / 2; ++reg)
 		chip->saved_regs_codec[reg] = inw(chip->codec_io + reg * 2);
+
+	/* manually store the one currently relevant write-only reg, too */
+	chip->saved_regs_codec[IDX_IO_6AH / 2] = chip->shadow_reg_codec_6AH;
+
 	for (reg = 0; reg < AZF_IO_SIZE_GAME_PM / 2; ++reg)
 		chip->saved_regs_game[reg] = inw(chip->game_io + reg * 2);
 	for (reg = 0; reg < AZF_IO_SIZE_MPU_PM / 2; ++reg)

--- azt3328.h.my_org	2008-06-14 08:18:51.000000000 +0200
+++ azt3328.h	2008-06-22 14:03:30.000000000 +0200
@@ -1,7 +1,8 @@
 #ifndef __SOUND_AZT3328_H
 #define __SOUND_AZT3328_H
 
-/* "PU" == "power-up value", as tested on PCI168 PCI rev. 10 */
+/* "PU" == "power-up value", as tested on PCI168 PCI rev. 10
+ * "WRITE_ONLY"  == register does not indicate actual bit values */
 
 /*** main I/O area port indices ***/
 /* (only 0x70 of 0x80 bytes saved/restored by Windows driver) */
@@ -76,7 +77,7 @@
   #define SOUNDFORMAT_FLAG_2CHANNELS	0x0020
 
 /* define frequency helpers, for maximum value safety */
-enum {
+enum azf_freq_t {
 #define AZF_FREQ(rate) AZF_FREQ_##rate = rate
   AZF_FREQ(4000),
   AZF_FREQ(4800),
@@ -150,11 +151,18 @@
   #define IO_68_RANDOM_TOGGLE1	0x0100	/* toggles randomly */
   #define IO_68_RANDOM_TOGGLE2	0x0200	/* toggles randomly */
   /* umm, nope, behaviour of these bits changes depending on what we wrote
-   * to 0x6b!! */
+   * to 0x6b!!
+   * And they change upon playback/stop, too:
+   * Writing a value to 0x68 will display this exact value during playback,
+   * too but when stopped it can fall back to a rather different
+   * seemingly random value). Hmm, possibly this is a register which
+   * has a remote shadow which needs proper device supply which only exists
+   * in case playback is active? Or is this driver-induced?
+   */
 
 /* this WORD can be set to have bits 0x0028 activated (FIXME: correct??);
  * actually inhibits PCM playback!!! maybe power management??: */
-#define IDX_IO_6AH		0x6A
+#define IDX_IO_6AH		0x6A /* WRITE_ONLY! */
   /* bit 5: enabling this will activate permanent counting of bytes 2/3
    * at gameport I/O (0xb402/3) (equal values each) and cause
    * gameport legacy I/O at 0x0200 to be _DISABLED_!
