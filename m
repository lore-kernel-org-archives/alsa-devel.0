From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] azt3328.c recording, joystick etc.
Date: Sat, 16 Nov 2002 23:28:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021116222840.GA1984@andi.hausnetz>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
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


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

- add recording input select and volume (that one was the missing part :)
- add smart joystick configuration part (autodetect etc.)
- add more PCI IDs
- silence MIDI IRQ output

This patch finally allowed me to record e.g. wave playback, albeit with an
*insane* amount of clicks and pops (my K7S5A DMA hardware behaviour
*really* sucks for this card :-\).

In other words: the azt3328 driver is now fairly complete, with the only
major missing part being the power management stuff...
(maybe I'm also going to tackle that one soon, dunno yet, depends on how
hot the chip runs in idle operation)

-- 
Andreas Mohr                        Stauferstr. 6, D-71272 Renningen, Germany
Tel. +49 7159 800604                http://mohr.de.tt

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="azt3328.diff"

Index: alsa-driver/pci/azt3328.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azt3328.h,v
retrieving revision 1.1
diff -u -r1.1 azt3328.h
--- alsa-driver/pci/azt3328.h	28 Oct 2002 11:51:36 -0000	1.1
+++ alsa-driver/pci/azt3328.h	16 Nov 2002 22:19:14 -0000
@@ -134,8 +134,16 @@
 #define IDX_MIXER_AUX           0x14
 #define IDX_MIXER_WAVEOUT       0x16
 #define IDX_MIXER_FMSYNTH       0x18
-#define IDX_MIXER_WAVEIN        0x1a
-#define IDX_MIXER_REC_MASTER    0x1c
+#define IDX_MIXER_REC_SELECT    0x1a
+  #define MIXER_REC_SELECT_MIC		0x00
+  #define MIXER_REC_SELECT_CD		0x01
+  #define MIXER_REC_SELECT_VIDEO	0x02
+  #define MIXER_REC_SELECT_AUX		0x03
+  #define MIXER_REC_SELECT_LINEIN	0x04
+  #define MIXER_REC_SELECT_MIXSTEREO	0x05
+  #define MIXER_REC_SELECT_MIXMONO	0x06
+  #define MIXER_REC_SELECT_MONOIN	0x07
+#define IDX_MIXER_REC_VOLUME    0x1c
 #define IDX_MIXER_ADVCTL1       0x1e
   /* unlisted bits are unmodifiable */
   #define MIXER_ADVCTL1_3DWIDTH_MASK	0x000e
Index: alsa-driver/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azt3328.c,v
retrieving revision 1.2
diff -u -r1.2 azt3328.c
--- alsa-driver/pci/azt3328.c	10 Nov 2002 13:13:32 -0000	1.2
+++ alsa-driver/pci/azt3328.c	16 Nov 2002 22:19:16 -0000
@@ -3,7 +3,8 @@
  *  Copyright (C) 2002 by Andreas Mohr <hw7oshyuv3001@sneakemail.com>
  *
  *  Framework borrowed from Bart Hartgers's als4000.c.
- *  Driver developed on the PCI168 AP(W) version (subsystem ID 1801).
+ *  Driver developed on the PCI168 AP(W) version (subsystem ID 1801),
+ *  found in a Fujitsu-Siemens PC ("Cordant", aluminum case).
  *  Other versions are:
  *  PCI168 A(W), sub ID 1800
  *  PCI168 A/AP, sub ID 8000
@@ -35,7 +36,7 @@
  *  for compatibility reasons) has the following features:
  *
  *  - builtin AC97 conformant codec (SNR over 80dB)
- *    (really AC97 compliant ?? I sort of doubt it, when looking
+ *    (really AC97 compliant ?? I really doubt it when looking
  *    at the mixer register layout)
  *  - builtin genuine OPL3
  *  - full duplex 16bit playback/record at independent sampling rate
@@ -51,35 +52,31 @@
  *    required for Microsoft's logo compliance (FIXME: where ?)
  *  - PCI168 AP(W) card: power amplifier with 4 Watts/channel at 4 Ohms
  *
- * As this card probably doesn't have a DMA FIFO buffer, it is susceptible
- * to DMA transaction underruns (resulting in sound crackling/clicking/popping).
- * This is the case with VIA chipsets or, in my case, an SiS735, which is
- * supposed to be very fast and supposed to get rid of crackling much
- * better than a VIA, yet ironically I still get crackling, like many other
- * people with the same chipset.
- * Possible remedies:
- * - plug card into a different PCI slot, preferrably one that isn't shared
- *   too much (this helps a lot, but not completely !)
- * - get rid of PCI VGA card, use AGP instead
- * - upgrade or downgrade BIOS
- * - fiddle with PCI latency settings (setpci -v -s BUSID latency_timer=XX)
- *   Not too helpful.
- * - Disable ACPI/power management/"Auto Detect RAM/PCI Clk" in BIOS
+ *  As this card probably doesn't have a DMA FIFO buffer, it is susceptible
+ *  to DMA traffic underruns (resulting in sound crackling/clicking/popping).
+ *  This is the case with VIA chipsets or, in my case, an SiS735, which is
+ *  supposed to be very fast and supposed to get rid of crackling much
+ *  better than a VIA, yet ironically I still get crackling, like many other
+ *  people with the same chipset.
+ *  Possible remedies:
+ *  - plug card into a different PCI slot, preferrably one that isn't shared
+ *    too much (this helps a lot, but not completely !)
+ *  - get rid of PCI VGA card, use AGP instead
+ *  - upgrade or downgrade BIOS
+ *  - fiddle with PCI latency settings (setpci -v -s BUSID latency_timer=XX)
+ *    Not too helpful.
+ *  - Disable ACPI/power management/"Auto Detect RAM/PCI Clk" in BIOS
  * 
  * BUGS
- *   - when Ctrl-C'ing mpg321, the playback loops a bit
- *     (premature DMA playback reset ?)
- *   - full-duplex sometimes breaks (IRQ management issues ?).
- *     Once even a spontaneous REBOOT happened !!!
+ *  - when Ctrl-C'ing mpg321, the playback loops a bit
+ *    (premature DMA playback reset ?)
+ *  - full-duplex sometimes breaks (IRQ management issues ?).
+ *    Once even a spontaneous REBOOT happened !!!
  * 
  * TODO
- *  - where is Wave In Switch to be found ??? (who can check on Windows ??)
  *  - test MPU401 MIDI playback etc.
- *  - check what Windows' mixer control layout looks like (3D sound etc.)
- *  - activate legacy addresses (joystick, MPU401 etc.)
  *  - power management (CONFIG_PM). See e.g. intel8x0 or cs4281.
- *  - find out which register bits exactly are the ones responsible
- *    for distributing various signal sources to LineOut
+ *    Implement this in case the chip runs indeed pretty hot.
  *  - figure out what all unknown port bits are responsible for
  */
 
@@ -152,14 +149,8 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
-#if 0 /* NYI */
-static int joystick_port[SNDRV_CARDS] =
-#ifdef CONFIG_ISA
-	{0x200};	/* enable as default */
-#else
-	{0};	/* disabled */
-#endif
-#endif /* NYI */
+static int joystick[SNDRV_CARDS] =
+	{-1};	/* "unset" as default */
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(index, "Index value for AZF3328 soundcard.");
@@ -170,11 +161,9 @@
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(enable, "Enable AZF3328 soundcard.");
 MODULE_PARM_SYNTAX(enable, SNDRV_INDEX_DESC);
-#if 0 /* NYI */
-MODULE_PARM(joystick_port, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(joystick_port, "Joystick port address for AZF3328 soundcard. (0 = disabled)");
-MODULE_PARM_SYNTAX(joystick_port, SNDRV_ENABLED);
-#endif /* NYI */
+MODULE_PARM(joystick, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(joystick, "Forced joystick port enable for AZF3328 soundcard. (0 = force disable)");
+MODULE_PARM_SYNTAX(joystick, SNDRV_ENABLED);
 
 typedef struct _snd_azf3328 azf3328_t;
 #define chip_t azf3328_t
@@ -208,7 +197,8 @@
 };
 
 static struct pci_device_id snd_azf3328_ids[] __devinitdata = {
-	{ 0x122D, 0x50DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* AZF3328 */
+	{ 0x122D, 0x50DC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* PCI168/3328 */
+	{ 0x122D, 0x80DA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },   /* 3328 */
 	{ 0, }
 };
 
@@ -336,10 +326,11 @@
 	unsigned int mask;
 	unsigned int invert: 1;
 	unsigned int stereo: 1;
+	unsigned int enum_c: 4;
 } azf3328_mixer_reg_t;
 
-#define COMPOSE_MIXER_REG(reg,lchan_shift,rchan_shift,mask,invert,stereo) \
- ((reg) | (lchan_shift << 8) | (rchan_shift << 12) | (mask << 16) | (invert << 24) | (stereo << 25))
+#define COMPOSE_MIXER_REG(reg,lchan_shift,rchan_shift,mask,invert,stereo,enum_c) \
+ ((reg) | (lchan_shift << 8) | (rchan_shift << 12) | (mask << 16) | (invert << 24) | (stereo << 25) | (enum_c << 26))
 
 static void snd_azf3328_mixer_reg_decode(azf3328_mixer_reg_t *r, unsigned long val)
 {
@@ -349,6 +340,7 @@
 	r->mask = (val >> 16) & 0xff;
 	r->invert = (val >> 24) & 1;
 	r->stereo = (val >> 25) & 1;
+	r->enum_c = (val >> 26) & 0x0f;
 }
 
 /*
@@ -359,28 +351,35 @@
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
   .info = snd_azf3328_info_mixer, \
   .get = snd_azf3328_get_mixer, .put = snd_azf3328_put_mixer, \
-  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, 0x1, invert, 0), \
+  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, 0x1, invert, 0, 0), \
 }
 
-#define AZF3328_MIXER_VOL_STEREO(xname, reg, mask) \
+#define AZF3328_MIXER_VOL_STEREO(xname, reg, mask, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
   .info = snd_azf3328_info_mixer, \
   .get = snd_azf3328_get_mixer, .put = snd_azf3328_put_mixer, \
-  .private_value = COMPOSE_MIXER_REG(reg, 8, 0, mask, 1, 1), \
+  .private_value = COMPOSE_MIXER_REG(reg, 8, 0, mask, invert, 1, 0), \
 }
 
 #define AZF3328_MIXER_VOL_MONO(xname, reg, mask, is_right_chan) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
   .info = snd_azf3328_info_mixer, \
   .get = snd_azf3328_get_mixer, .put = snd_azf3328_put_mixer, \
-  .private_value = COMPOSE_MIXER_REG(reg, is_right_chan ? 0 : 8, 0, mask, 1, 0), \
+  .private_value = COMPOSE_MIXER_REG(reg, is_right_chan ? 0 : 8, 0, mask, 1, 0, 0), \
 }
 
 #define AZF3328_MIXER_VOL_SPECIAL(xname, reg, mask, shift, invert) \
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
   .info = snd_azf3328_info_mixer, \
   .get = snd_azf3328_get_mixer, .put = snd_azf3328_put_mixer, \
-  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, mask, invert, 0), \
+  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, mask, invert, 0, 0), \
+}
+
+#define AZF3328_MIXER_ENUM(xname, reg, enum_c, shift) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+  .info = snd_azf3328_info_mixer_enum, \
+  .get = snd_azf3328_get_mixer_enum, .put = snd_azf3328_put_mixer_enum, \
+  .private_value = COMPOSE_MIXER_REG(reg, shift, 0, 0, 0, 0, enum_c), \
 }
 
 static int snd_azf3328_info_mixer(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
@@ -453,38 +452,117 @@
 	return (nreg != oreg);
 }
 
+static int snd_azf3328_info_mixer_enum(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	azf3328_mixer_reg_t reg;
+	static char *texts1[2] = { "ModemOut1", "ModemOut2" };
+	static char *texts2[2] = { "MonoSelectSource1", "MonoSelectSource2" };
+        static char *texts3[8] = {
+                "Mic", "CD", "Video", "Aux", "Line",
+                "Mix", "Mix Mono", "Phone"
+        };
+
+	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
+        uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+        uinfo->count = (reg.reg == IDX_MIXER_REC_SELECT) ? 2 : 1;
+        uinfo->value.enumerated.items = reg.enum_c;
+        if (uinfo->value.enumerated.item > reg.enum_c - 1)
+                uinfo->value.enumerated.item = reg.enum_c - 1;
+	if (reg.reg == IDX_MIXER_ADVCTL2)
+	{
+		if (reg.lchan_shift == 8) /* modem out sel */
+			strcpy(uinfo->value.enumerated.name, texts1[uinfo->value.enumerated.item]);
+		else /* mono sel source */
+			strcpy(uinfo->value.enumerated.name, texts2[uinfo->value.enumerated.item]);
+	}
+	else
+        	strcpy(uinfo->value.enumerated.name, texts3[uinfo->value.enumerated.item]
+);
+        return 0;
+}
+
+static int snd_azf3328_get_mixer_enum(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	azf3328_mixer_reg_t reg;
+        azf3328_t *chip = snd_kcontrol_chip(kcontrol);
+        unsigned short val;
+        
+	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
+	val = inw(chip->mixer_port + reg.reg);
+	if (reg.reg == IDX_MIXER_REC_SELECT)
+	{
+        	ucontrol->value.enumerated.item[0] = (val >> 8) & (reg.enum_c - 1);
+        	ucontrol->value.enumerated.item[1] = (val >> 0) & (reg.enum_c - 1);
+	}
+	else
+        	ucontrol->value.enumerated.item[0] = (val >> reg.lchan_shift) & (reg.enum_c - 1);
+	snd_azf3328_dbgmixer("get_enum: %02x is %04x -> %d|%d (shift %02d, enum_c %d)\n", reg.reg, val, ucontrol->value.enumerated.item[0], ucontrol->value.enumerated.item[1], reg.lchan_shift, reg.enum_c);
+        return 0;
+}
+
+static int snd_azf3328_put_mixer_enum(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol)
+{
+	azf3328_mixer_reg_t reg;
+        azf3328_t *chip = snd_kcontrol_chip(kcontrol);
+	unsigned int oreg, nreg, val;
+        
+	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
+	oreg = inw(chip->mixer_port + reg.reg);
+	val = oreg;
+	if (reg.reg == IDX_MIXER_REC_SELECT)
+	{
+        	if (ucontrol->value.enumerated.item[0] > (reg.enum_c - 1) ||
+            	ucontrol->value.enumerated.item[1] > (reg.enum_c - 1))
+                	return -EINVAL;
+        	val = (ucontrol->value.enumerated.item[0] << 8) |
+        	      (ucontrol->value.enumerated.item[1] << 0);
+	}
+	else
+	{
+        	if (ucontrol->value.enumerated.item[0] > (reg.enum_c - 1))
+                	return -EINVAL;
+		val &= ~((reg.enum_c - 1) << reg.lchan_shift);
+        	val |= (ucontrol->value.enumerated.item[0] << reg.lchan_shift);
+	}
+	outw(val, chip->mixer_port + reg.reg);
+	nreg = val;
+
+	snd_azf3328_dbgmixer("put_enum: %02x to %04x, oreg %04x\n", reg.reg, val, oreg);
+	return (nreg != oreg);
+}
+
 #define NUM_CONTROLS(ary) (sizeof(ary) / sizeof(snd_kcontrol_new_t))
 
 static snd_kcontrol_new_t snd_azf3328_mixer_controls[] __devinitdata = {
 	AZF3328_MIXER_SWITCH("Master Playback Switch", IDX_MIXER_PLAY_MASTER, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Master Playback Volume", IDX_MIXER_PLAY_MASTER, 0x1f),
+	AZF3328_MIXER_VOL_STEREO("Master Playback Volume", IDX_MIXER_PLAY_MASTER, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Wave Playback Switch", IDX_MIXER_WAVEOUT, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Wave Playback Volume", IDX_MIXER_WAVEOUT, 0x1f),
+	AZF3328_MIXER_VOL_STEREO("Wave Playback Volume", IDX_MIXER_WAVEOUT, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Wave Playback 3D Bypass", IDX_MIXER_ADVCTL2, 7, 1),
 	AZF3328_MIXER_SWITCH("FM Playback Switch", IDX_MIXER_FMSYNTH, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("FM Playback Volume", IDX_MIXER_FMSYNTH, 0x1f),
+	AZF3328_MIXER_VOL_STEREO("FM Playback Volume", IDX_MIXER_FMSYNTH, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("CD Playback Switch", IDX_MIXER_CDAUDIO, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("CD Playback Volume", IDX_MIXER_CDAUDIO, 0x1f),
-	AZF3328_MIXER_SWITCH("Master Capture Switch", IDX_MIXER_REC_MASTER, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Master Capture Volume", IDX_MIXER_REC_MASTER, 0x07),
+	AZF3328_MIXER_VOL_STEREO("CD Playback Volume", IDX_MIXER_CDAUDIO, 0x1f, 1),
+	AZF3328_MIXER_SWITCH("Capture Switch", IDX_MIXER_REC_VOLUME, 15, 1),
+	AZF3328_MIXER_VOL_STEREO("Capture Volume", IDX_MIXER_REC_VOLUME, 0x0f, 0),
+	AZF3328_MIXER_ENUM("Capture Source", IDX_MIXER_REC_SELECT, 8, 0),
 	AZF3328_MIXER_SWITCH("Mic Playback Switch", IDX_MIXER_MIC, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Mic Playback Volume", IDX_MIXER_MIC, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Mic Boost (+20dB)", IDX_MIXER_MIC, 6, 0),
 	AZF3328_MIXER_SWITCH("Line Playback Switch", IDX_MIXER_LINEIN, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Line Playback Volume", IDX_MIXER_LINEIN, 0x1f),
-	AZF3328_MIXER_VOL_STEREO("Wave Capture Volume", IDX_MIXER_WAVEIN, 0x07),
+	AZF3328_MIXER_VOL_STEREO("Line Playback Volume", IDX_MIXER_LINEIN, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("PCBeep Playback Switch", IDX_MIXER_PCBEEP, 15, 1),
 	AZF3328_MIXER_VOL_SPECIAL("PCBeep Playback Volume", IDX_MIXER_PCBEEP, 0x0f, 1, 1),
+	AZF3328_MIXER_SWITCH("Video Playback Switch", IDX_MIXER_VIDEO, 15, 1),
+	AZF3328_MIXER_VOL_STEREO("Video Playback Volume", IDX_MIXER_VIDEO, 0x1f, 1),
+	AZF3328_MIXER_SWITCH("Aux Playback Switch", IDX_MIXER_AUX, 15, 1),
+	AZF3328_MIXER_VOL_STEREO("Aux Playback Volume", IDX_MIXER_AUX, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Modem Playback Switch", IDX_MIXER_MODEMOUT, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Modem Playback Volume", IDX_MIXER_MODEMOUT, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Modem Capture Switch", IDX_MIXER_MODEMIN, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Modem Capture Volume", IDX_MIXER_MODEMIN, 0x1f, 1),
-	AZF3328_MIXER_SWITCH("Video Playback Switch", IDX_MIXER_VIDEO, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Video Playback Volume", IDX_MIXER_VIDEO, 0x1f),
-	AZF3328_MIXER_SWITCH("Aux Playback Switch", IDX_MIXER_AUX, 15, 1),
-	AZF3328_MIXER_VOL_STEREO("Aux Playback Volume", IDX_MIXER_AUX, 0x1f),
-	AZF3328_MIXER_SWITCH("Modem Out Select", IDX_MIXER_ADVCTL2, 8, 1),
-	AZF3328_MIXER_SWITCH("Mono Select Source", IDX_MIXER_ADVCTL2, 9, 1),
+	AZF3328_MIXER_ENUM("Modem Out Select", IDX_MIXER_ADVCTL2, 2, 8),
+	AZF3328_MIXER_ENUM("Mono Select Source", IDX_MIXER_ADVCTL2, 2, 9),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1, 0),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9, 0),
 	AZF3328_MIXER_SWITCH("3D Control - Toggle", IDX_MIXER_ADVCTL2, 13, 0),
@@ -525,8 +603,7 @@
 	{ IDX_MIXER_AUX,		MIXER_MUTE_MASK|0x1f1f },
         { IDX_MIXER_WAVEOUT,		MIXER_MUTE_MASK|0x1f1f },
         { IDX_MIXER_FMSYNTH,		MIXER_MUTE_MASK|0x1f1f },
-        { IDX_MIXER_WAVEIN,		0x0707 },
-        { IDX_MIXER_REC_MASTER,		MIXER_MUTE_MASK|0x0707 },
+        { IDX_MIXER_REC_VOLUME,		MIXER_MUTE_MASK|0x0707 },
 };
 
 static int __devinit snd_azf3328_mixer_new(azf3328_t *chip)
@@ -935,7 +1012,6 @@
 	return frmres;
 }
 
-/* operation very similar to fm801 */
 static void snd_azf3328_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	azf3328_t *chip = snd_magic_cast(azf3328_t, dev_id, return);
@@ -955,10 +1031,10 @@
 		spin_lock(&chip->reg_lock);
 		which = inw(chip->codec_port+IDX_IO_PLAY_IRQMASK);
 		if (which & IRQ_FINISHED_PLAYBUF_1)
-			/* ack interrupt */
+			/* ack IRQ */
 			outw(which | IRQ_FINISHED_PLAYBUF_1, chip->codec_port+IDX_IO_PLAY_IRQMASK);
 		if (which & IRQ_FINISHED_PLAYBUF_2)
-			/* ack interrupt */
+			/* ack IRQ */
 			outw(which | IRQ_FINISHED_PLAYBUF_2, chip->codec_port+IDX_IO_PLAY_IRQMASK);
 		if (which & IRQ_PLAY_SOMETHING)
 		{
@@ -999,10 +1075,7 @@
                	spin_unlock(&chip->reg_lock);
 	}
 	if (status & IRQ_MPU401)
-	{
-		snd_printk("MIDI irq ack\n");
 		snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, regs);
-	}
 	if (status & IRQ_SOMEIRQ)
 		printk(KERN_ERR "azt3328: unknown IRQ type occurred, please report !\n");
 	count++;
@@ -1308,9 +1381,6 @@
 
 	snd_azf3328_dbgmisc("io2 %02x %02x %02x %02x %02x %02x\n", snd_azf3328_io2_read(chip, 0), snd_azf3328_io2_read(chip, 1), snd_azf3328_io2_read(chip, 2), snd_azf3328_io2_read(chip, 3), snd_azf3328_io2_read(chip, 4), snd_azf3328_io2_read(chip, 5));
 
-	/* FIXME: what does this ? (probably some legacy stuff) */
-	snd_azf3328_io2_write(chip, 4, snd_azf3328_io2_read(chip, 4) | 0x08);
-
 	for (tmp=0; tmp <= 0x01; tmp += 1)
 		snd_azf3328_dbgmisc("0x%02x: opl 0x%04x, mpu300 0x%04x, mpu310 0x%04x, mpu320 0x%04x, mpu330 0x%04x\n", tmp, inb(0x388 + tmp), inb(0x300 + tmp), inb(0x310 + tmp), inb(0x320 + tmp), inb(0x330 + tmp));
 
@@ -1341,6 +1411,54 @@
 	return 0;
 }
 
+static void __devinit snd_azf3328_config_joystick(azf3328_t *chip, int joystick)
+{
+	int i, detected = 0, activate = 0;
+	char *msg = NULL;
+	unsigned char val;
+
+	if (joystick == -1) /* auto detection/activation */
+	{
+		for (i=0x200; i <= 0x207; i++)
+			if (inb(i) != 0xff)
+				detected = 1; /* other joy found, don't activate */
+	}
+
+	if ((joystick == -1) && (detected == 1))
+	{
+		activate = 0;
+		msg = "DISABLED (address occupied by another joystick port)";
+	}
+	else
+	if ((joystick == -1) && (detected == 0))
+	{
+		activate = 1;
+		msg = "ENABLED (via autodetect)";
+	}
+	else
+	if (joystick == 0)
+	{
+		activate = 0;
+		msg = "DISABLED (forced)";
+	}
+	else
+	if (joystick == 1)
+	{
+		activate = 1;
+		msg = "ENABLED (Warning: forced !)";
+	}
+	val = inb(chip->io2_port + IDX_IO2_LEGACY_ADDR);
+	if (activate)
+	    val |= LEGACY_JOY;
+	else
+	    val &= ~LEGACY_JOY;
+
+	outb(val, chip->io2_port + IDX_IO2_LEGACY_ADDR);
+#ifdef MODULE
+	printk("azt3328: Joystick port: %s.", msg);
+#endif
+}
+
 static int __devinit snd_azf3328_probe(struct pci_dev *pci,
 					  const struct pci_device_id *pci_id)
 {
@@ -1403,8 +1521,21 @@
 		snd_card_free(card);
 		return err;
 	}
+
+#ifdef MODULE
+	printk(
+"azt3328: EXPERIMENTAL driver for Aztech AZF3328-based soundcards (e.g. PCI168).\n"
+"azt3328: Aztech does NOT support this driver and/or the soundcard (yet),\n"
+"azt3328: so simply don't even bother to try to get some support from them.\n"
+"azt3328: Please mail to hw7oshyuv3001@sneakemail.com for further info\n"
+"azt3328: (bug notification, driver development etc.).\n");
+#endif
+
+	snd_azf3328_config_joystick(chip, joystick[dev]);
+
 	pci_set_drvdata(pci, chip);
 	dev++;
+
 	snd_azf3328_dbgcallleave();
 	return 0;
 }
@@ -1445,15 +1576,6 @@
 #endif
 		return err;
 	}
-#ifdef MODULE
-	printk(
-"azt3328: EXPERIMENTAL driver for Aztech AZF3328-based soundcards (e.g. PCI168).\n"
-"azt3328: Aztech does NOT support this driver and/or the soundcard (yet),\n"
-"azt3328: so simply don't even bother to try to get some support from them.\n"
-"azt3328: Please mail to hw7oshyuv3001@sneakemail.com for further info\n"
-"azt3328: (bug notification, driver development etc.).\n");
-#endif
-
 #if DEBUG_CALLS
 	printk(KERN_ERR "snd_azf3328_io2_write: %p\nsnd_azf3328_io2_read: %p\nsnd_azf3328_mixer_write: %p\nsnd_azf3328_mixer_read: %p\nsnd_azf3328_mixer_set_mute: %p\nsnd_azf3328_mixer_write_volume_gradually: %p\nsnd_azf3328_mixer_reg_decode: %p\nsnd_azf3328_info_mixer: %p\nsnd_azf3328_get_mixer: %p\nsnd_azf3328_put_mixer: %p\nsnd_azf3328_mixer_new: %p\n", snd_azf3328_io2_write, snd_azf3328_io2_read, snd_azf3328_mixer_write, snd_azf3328_mixer_read, snd_azf3328_mixer_set_mute, snd_azf3328_mixer_write_volume_gradually, snd_azf3328_mixer_reg_decode, snd_azf3328_info_mixer, snd_azf3328_get_mixer, snd_azf3328_put_mixer, snd_azf3328_mixer_new);
 	printk(KERN_ERR "snd_azf3328_hw_params: %p\nsnd_azf3328_hw_free: %p\nsnd_azf3328_setfmt: %p\nsnd_azf3328_setdmaa: %p\nsnd_azf3328_playback_prepare: %p\nsnd_azf3328_capture_prepare: %p\nsnd_azf3328_playback_trigger: %p\nsnd_azf3328_capture_trigger: %p\nsnd_azf3328_playback_pointer: %p\nsnd_azf3328_capture_pointer: %p\nsnd_azf3328_interrupt: %p\n", snd_azf3328_hw_params, snd_azf3328_hw_free, snd_azf3328_setfmt, snd_azf3328_setdmaa, snd_azf3328_playback_prepare, snd_azf3328_capture_prepare, snd_azf3328_playback_trigger, snd_azf3328_capture_trigger, snd_azf3328_playback_pointer, snd_azf3328_capture_pointer, snd_azf3328_interrupt);

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
