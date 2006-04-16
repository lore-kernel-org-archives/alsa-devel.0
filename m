From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: [PATCH] azt3328.c: add suspend/resume support
Date: Sun, 16 Apr 2006 23:26:14 +0200
Message-ID: <20060416212614.GA16301@rhlx01.fht-esslingen.de>
References: <20060411082956.GA20725@rhlx01.fht-esslingen.de> <s5hvetg30n6.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvetg30n6.wl%tiwai@suse.de>
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
Cc: andi@lisas.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Apr 11, 2006 at 11:46:37AM +0200, Takashi Iwai wrote:
> At Tue, 11 Apr 2006 10:29:56 +0200,
> Andreas Mohr wrote:
> > +	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM; reg += 2)
> > +		*(u16 *)&chip->saved_regs_mixer[reg] = inw(chip->mixer_port + reg);
> 
> That's a bad style.  Rather define
> 
> 	u16 saved_regs_mixer[AZF_IO_SIZE_CODEC_PM / 2];
> 
> and
> 	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM / 2; reg++)
> 		chip->saved_regs_mixer[reg] = inw(chip->mixer_port + reg * 2);
> 
> than type-punning.  Or, you can use ARRAY_SIZE() in the loop, too.

Indeed. That better?

Changes:
- much better register array access
- add missing pre 3D/post 3D mixer switch (just like with standard AC97 mixers!)
- shorten/correct some mixer strings / rename some mixer controls to match
  AC97 names
- update some comments

With this update I consider this driver to be >= 95% finished. Yay!

Patch tested on 2.6.16-ck5, rediffed against current CVS.

Signed-off-by: Andreas Mohr <andi@lisas.de>


Index: alsa-kernel/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.c,v
retrieving revision 1.35
diff -u -r1.35 azt3328.c
--- alsa-kernel/pci/azt3328.c	17 Nov 2005 15:02:42 -0000	1.35
+++ alsa-kernel/pci/azt3328.c	16 Apr 2006 21:18:42 -0000
@@ -33,14 +33,21 @@
  *  in the first place >:-P}),
  *  I was forced to base this driver on reverse engineering
  *  (3 weeks' worth of evenings filled with driver work).
- *  (and no, I did NOT go the easy way: to pick up a PCI128 for 9 Euros)
+ *  (and no, I did NOT go the easy way: to pick up a SB PCI128 for 9 Euros)
  *
  *  The AZF3328 chip (note: AZF3328, *not* AZT3328, that's just the driver name
  *  for compatibility reasons) has the following features:
  *
  *  - builtin AC97 conformant codec (SNR over 80dB)
- *    (really AC97 compliant?? I really doubt it when looking
- *    at the mixer register layout)
+ *    Note that "conformant" != "compliant"!! this chip's mixer register layout
+ *    *differs* from the standard AC97 layout:
+ *    they chose to not implement the headphone register (which is not a
+ *    problem since it's merely optional), yet when doing this, they committed
+ *    the grave sin of letting other registers follow immediately instead of
+ *    keeping a headphone dummy register, thereby shifting the mixer register
+ *    addresses illegally. So far unfortunately it looks like the very flexible
+ *    ALSA AC97 support is still not enough to easily compensate for such a
+ *    grave layout violation despite all tweaks and quirks mechanisms it offers.
  *  - builtin genuine OPL3
  *  - full duplex 16bit playback/record at independent sampling rate
  *  - MPU401 (+ legacy address support) FIXME: how to enable legacy addr??
@@ -90,10 +97,15 @@
  * 
  * TODO
  *  - test MPU401 MIDI playback etc.
- *  - power management. See e.g. intel8x0 or cs4281.
- *    This would be nice since the chip runs a bit hot, and it's *required*
- *    anyway for proper ACPI power management.
+ *  - add some power micro-management (disable various units of the card
+ *    as long as they're unused). However this requires I/O ports which I
+ *    haven't figured out yet and which thus might not even exist...
+ *    The standard suspend/resume functionality could probably make use of
+ *    some improvement, too...
  *  - figure out what all unknown port bits are responsible for
+ *  - figure out some cleverly evil scheme to possibly make ALSA AC97 code
+ *    fully accept our quite incompatible ""AC97"" mixer and thus save some
+ *    code (but I'm not too optimistic that doing this is possible at all)
  */
 
 #include <sound/driver.h>
@@ -213,6 +225,16 @@
 
 	struct pci_dev *pci;
 	int irq;
+
+#ifdef CONFIG_PM
+	/* register value containers for power management
+	 * Note: not always full I/O range preserved (just like Win driver!) */
+	u16 saved_regs_codec [AZF_IO_SIZE_CODEC_PM / 2];
+	u16 saved_regs_io2   [AZF_IO_SIZE_IO2_PM / 2];
+	u16 saved_regs_mpu   [AZF_IO_SIZE_MPU_PM / 2];
+	u16 saved_regs_synth[AZF_IO_SIZE_SYNTH_PM / 2];
+	u16 saved_regs_mixer[AZF_IO_SIZE_MIXER_PM / 2];
+#endif
 };
 
 static const struct pci_device_id snd_azf3328_ids[] = {
@@ -513,15 +535,18 @@
 			    struct snd_ctl_elem_info *uinfo)
 {
 	static const char * const texts1[] = {
-		"ModemOut1", "ModemOut2"
+		"Mic1", "Mic2"
 	};
 	static const char * const texts2[] = {
-		"MonoSelectSource1", "MonoSelectSource2"
+		"Mix", "Mic"
 	};
 	static const char * const texts3[] = {
                 "Mic", "CD", "Video", "Aux",
 		"Line", "Mix", "Mix Mono", "Phone"
         };
+	static const char * const texts4[] = {
+		"pre 3D", "post 3D"
+        };
 	struct azf3328_mixer_reg reg;
 
 	snd_azf3328_mixer_reg_decode(&reg, kcontrol->private_value);
@@ -532,10 +557,17 @@
                 uinfo->value.enumerated.item = reg.enum_c - 1U;
 	if (reg.reg == IDX_MIXER_ADVCTL2)
 	{
-		if (reg.lchan_shift == 8) /* modem out sel */
-			strcpy(uinfo->value.enumerated.name, texts1[uinfo->value.enumerated.item]);
-		else /* mono sel source */
-			strcpy(uinfo->value.enumerated.name, texts2[uinfo->value.enumerated.item]);
+		switch(reg.lchan_shift) {
+			case 8: /* modem out sel */
+				strcpy(uinfo->value.enumerated.name, texts1[uinfo->value.enumerated.item]);
+				break;
+			case 9: /* mono sel source */
+				strcpy(uinfo->value.enumerated.name, texts2[uinfo->value.enumerated.item]);
+				break;
+			case 15: /* PCM Out Path */
+				strcpy(uinfo->value.enumerated.name, texts4[uinfo->value.enumerated.item]);
+				break;
+		}
 	}
 	else
         	strcpy(uinfo->value.enumerated.name, texts3[uinfo->value.enumerated.item]
@@ -628,13 +660,14 @@
 	AZF3328_MIXER_VOL_MONO("Modem Playback Volume", IDX_MIXER_MODEMOUT, 0x1f, 1),
 	AZF3328_MIXER_SWITCH("Modem Capture Switch", IDX_MIXER_MODEMIN, 15, 1),
 	AZF3328_MIXER_VOL_MONO("Modem Capture Volume", IDX_MIXER_MODEMIN, 0x1f, 1),
-	AZF3328_MIXER_ENUM("Modem Out Select", IDX_MIXER_ADVCTL2, 2, 8),
-	AZF3328_MIXER_ENUM("Mono Select Source", IDX_MIXER_ADVCTL2, 2, 9),
+	AZF3328_MIXER_ENUM("Mic Select", IDX_MIXER_ADVCTL2, 2, 8),
+	AZF3328_MIXER_ENUM("Mono Output Select", IDX_MIXER_ADVCTL2, 2, 9),
+	AZF3328_MIXER_ENUM("PCM", IDX_MIXER_ADVCTL2, 2, 15), /* PCM Out Path, place in front since it controls *both* 3D and Bass/Treble! */
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Treble", IDX_MIXER_BASSTREBLE, 0x07, 1, 0),
 	AZF3328_MIXER_VOL_SPECIAL("Tone Control - Bass", IDX_MIXER_BASSTREBLE, 0x07, 9, 0),
 	AZF3328_MIXER_SWITCH("3D Control - Switch", IDX_MIXER_ADVCTL2, 13, 0),
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Wide", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
-	AZF3328_MIXER_VOL_SPECIAL("3D Control - Space", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Width", IDX_MIXER_ADVCTL1, 0x07, 1, 0), /* "3D Width" */
+	AZF3328_MIXER_VOL_SPECIAL("3D Control - Depth", IDX_MIXER_ADVCTL1, 0x03, 8, 0), /* "Hifi 3D" */
 #if MIXER_TESTING
 	AZF3328_MIXER_SWITCH("0", IDX_MIXER_ADVCTL2, 0, 0),
 	AZF3328_MIXER_SWITCH("1", IDX_MIXER_ADVCTL2, 1, 0),
@@ -1765,6 +1798,8 @@
 		goto out_err;
 	}
 
+	card->private_data = chip;
+
 	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_MPU401,
 				        chip->mpu_port, 1, pci->irq, 0,
 				        &chip->rmidi)) < 0) {
@@ -1790,6 +1825,8 @@
 		}
 	}
 
+	opl3->private_data = chip;
+
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->codec_port, chip->irq);
 
@@ -1833,11 +1870,80 @@
 	snd_azf3328_dbgcallleave();
 }
 
+#ifdef CONFIG_PM
+static int
+snd_azf3328_suspend(struct pci_dev *pci, pm_message_t state)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct snd_azf3328 *chip = card->private_data;
+	int reg;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	
+	snd_pcm_suspend_all(chip->pcm);
+
+	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM / 2; reg++)
+		chip->saved_regs_mixer[reg] = inw(chip->mixer_port + reg * 2);
+
+	/* make sure to disable master volume etc. to prevent looping sound */
+	snd_azf3328_mixer_set_mute(chip, IDX_MIXER_PLAY_MASTER, 1);
+	snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
+	
+	for (reg = 0; reg < AZF_IO_SIZE_CODEC_PM / 2; reg++)
+		chip->saved_regs_codec[reg] = inw(chip->codec_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_IO2_PM / 2; reg++)
+		chip->saved_regs_io2[reg] = inw(chip->io2_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_MPU_PM / 2; reg++)
+		chip->saved_regs_mpu[reg] = inw(chip->mpu_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_SYNTH_PM / 2; reg++)
+		chip->saved_regs_synth[reg] = inw(chip->synth_port + reg * 2);
+
+	pci_set_power_state(pci, PCI_D3hot);
+	pci_disable_device(pci);
+	pci_save_state(pci);
+	return 0;
+}
+
+static int
+snd_azf3328_resume(struct pci_dev *pci)
+{
+	struct snd_card *card = pci_get_drvdata(pci);
+	struct snd_azf3328 *chip = card->private_data;
+	int reg;
+
+	pci_restore_state(pci);
+	pci_enable_device(pci);
+	pci_set_power_state(pci, PCI_D0);
+	pci_set_master(pci);
+
+	for (reg = 0; reg < AZF_IO_SIZE_IO2_PM / 2; reg++)
+		outw(chip->saved_regs_io2[reg], chip->io2_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_MPU_PM / 2; reg++)
+		outw(chip->saved_regs_mpu[reg], chip->mpu_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_SYNTH_PM / 2; reg++)
+		outw(chip->saved_regs_synth[reg], chip->synth_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM / 2; reg++)
+		outw(chip->saved_regs_mixer[reg], chip->mixer_port + reg * 2);
+	for (reg = 0; reg < AZF_IO_SIZE_CODEC_PM / 2; reg++)
+		outw(chip->saved_regs_codec[reg], chip->codec_port + reg * 2);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif
+
+
+
+
 static struct pci_driver driver = {
 	.name = "AZF3328",
 	.id_table = snd_azf3328_ids,
 	.probe = snd_azf3328_probe,
 	.remove = __devexit_p(snd_azf3328_remove),
+#ifdef CONFIG_PM
+	.suspend = snd_azf3328_suspend,
+	.resume = snd_azf3328_resume,
+#endif
 };
 
 static int __init
Index: alsa-kernel/pci/azt3328.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.h,v
retrieving revision 1.2
diff -u -r1.2 azt3328.h
--- alsa-kernel/pci/azt3328.h	25 Oct 2005 10:17:45 -0000	1.2
+++ alsa-kernel/pci/azt3328.h	16 Apr 2006 21:18:42 -0000
@@ -5,6 +5,9 @@
 
 /*** main I/O area port indices ***/
 /* (only 0x70 of 0x80 bytes saved/restored by Windows driver) */
+#define AZF_IO_SIZE_CODEC	0x80
+#define AZF_IO_SIZE_CODEC_PM	0x70
+
 /* the driver initialisation suggests a layout of 4 main areas:
  * from 0x00 (playback), from 0x20 (recording) and from 0x40 (maybe MPU401??).
  * And another area from 0x60 to 0x6f (DirectX timer, IRQ management,
@@ -87,7 +90,7 @@
 #define IDX_IO_REC_DMA_CURROFS  0x34 /* PU:0x00000000 */
 #define IDX_IO_REC_SOUNDFORMAT  0x36 /* PU:0x0000 */
 
-/** hmm, what is this I/O area for? MPU401?? (after playback, recording, ???, timer) **/
+/** hmm, what is this I/O area for? MPU401?? or external DAC via I2S?? (after playback, recording, ???, timer) **/
 #define IDX_IO_SOMETHING_FLAGS	0x40 /* gets set to 0x34 just like port 0x0 and 0x20 on card init, PU:0x0000 */
 /* general */
 #define IDX_IO_42H		0x42 /* PU:0x0001 */
@@ -107,7 +110,8 @@
   #define IRQ_UNKNOWN2			0x0080 /* probably unused */
 #define IDX_IO_66H		0x66    /* writing 0xffff returns 0x0000 */
 #define IDX_IO_SOME_VALUE	0x68	/* this is set to e.g. 0x3ff or 0x300, and writable; maybe some buffer limit, but I couldn't find out more, PU:0x00ff */
-#define IDX_IO_6AH		0x6A	/* this WORD can be set to have bits 0x0028 activated; actually inhibits PCM playback!!! maybe power management?? */
+#define IDX_IO_6AH		0x6A	/* this WORD can be set to have bits 0x0028 activated (FIXME: correct??); actually inhibits PCM playback!!! maybe power management?? */
+  #define IO_6A_PAUSE_PLAYBACK		0x0200 /* bit 9; sure, this pauses playback, but what the heck is this really about?? */
 #define IDX_IO_6CH		0x6C
 #define IDX_IO_6EH		0x6E	/* writing 0xffff returns 0x83fe */
 /* further I/O indices not saved/restored, so probably not used */
@@ -115,15 +119,25 @@
 
 /*** I/O 2 area port indices ***/
 /* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */ 
+#define AZF_IO_SIZE_IO2		0x08
+#define AZF_IO_SIZE_IO2_PM	0x06
+
 #define IDX_IO2_LEGACY_ADDR	0x04
   #define LEGACY_SOMETHING		0x01 /* OPL3?? */
   #define LEGACY_JOY			0x08
 
+#define AZF_IO_SIZE_MPU		0x04
+#define AZF_IO_SIZE_MPU_PM	0x04
+
+#define AZF_IO_SIZE_SYNTH	0x08
+#define AZF_IO_SIZE_SYNTH_PM	0x06
 
 /*** mixer I/O area port indices ***/
 /* (only 0x22 of 0x40 bytes saved/restored by Windows driver)
- * generally spoken: AC97 register index = AZF3328 mixer reg index + 2
- * (in other words: AZF3328 NOT fully AC97 compliant) */
+ * UNFORTUNATELY azf3328 is NOT truly AC97 compliant: see main file intro */
+#define AZF_IO_SIZE_MIXER	0x40
+#define AZF_IO_SIZE_MIXER_PM	0x22
+
   #define MIXER_VOLUME_RIGHT_MASK	0x001f
   #define MIXER_VOLUME_LEFT_MASK	0x1f00
   #define MIXER_MUTE_MASK		0x8000
@@ -156,14 +170,14 @@
 #define IDX_MIXER_ADVCTL1       0x1e
   /* unlisted bits are unmodifiable */
   #define MIXER_ADVCTL1_3DWIDTH_MASK	0x000e
-  #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300
-#define IDX_MIXER_ADVCTL2       0x20 /* resembles AC97_GENERAL_PURPOSE reg! */
+  #define MIXER_ADVCTL1_HIFI3D_MASK	0x0300 /* yup, this is missing the high bit that official AC97 contains, plus it doesn't have linear bit value range behaviour but instead acts weirdly (possibly we're dealing with two *different* 3D settings here??) */
+#define IDX_MIXER_ADVCTL2       0x20 /* subset of AC97_GENERAL_PURPOSE reg! */
   /* unlisted bits are unmodifiable */
-  #define MIXER_ADVCTL2_BIT7		0x0080 /* WaveOut 3D Bypass? mutes WaveOut at LineOut */
-  #define MIXER_ADVCTL2_BIT8		0x0100 /* is this Modem Out Select? */
-  #define MIXER_ADVCTL2_BIT9		0x0200 /* Mono Select Source? */
-  #define MIXER_ADVCTL2_BIT13		0x2000 /* 3D enable? */
-  #define MIXER_ADVCTL2_BIT15		0x8000 /* unknown */
+  #define MIXER_ADVCTL2_LPBK		0x0080 /* Loopback mode -- Win driver: "WaveOut3DBypass"? mutes WaveOut at LineOut */
+  #define MIXER_ADVCTL2_MS		0x0100 /* Mic Select 0=Mic1, 1=Mic2 -- Win driver: "ModemOutSelect"?? */
+  #define MIXER_ADVCTL2_MIX		0x0200 /* Mono output select 0=Mix, 1=Mic; Win driver: "MonoSelectSource"?? */
+  #define MIXER_ADVCTL2_3D		0x2000 /* 3D Enhancement 1=on */
+  #define MIXER_ADVCTL2_POP		0x8000 /* Pcm Out Path, 0=pre 3D, 1=post 3D */
   
 #define IDX_MIXER_SOMETHING30H	0x30 /* used, but unknown??? */
 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
