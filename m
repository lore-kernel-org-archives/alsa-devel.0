From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] azt3328.c: add suspend/resume support
Date: Tue, 11 Apr 2006 10:29:56 +0200
Message-ID: <20060411082956.GA20725@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

- add suspend/resume handlers
- fix problem (private_data members not set)

Playing a file while suspending will resume correctly with this patch,
so I assume the hardware to get fully correctly reinitialized with
this patch (some sound looping and power change clicking may occur
in between, but that's not fully handled yet and relatively normal
or somewhat difficult to fix anyway).

Patch done and hardware-tested on 2.6.16-ck3, rediffed to ALSA CVS.

Signed-off-by: Andreas Mohr <andi@lisas.de>

Thanks!


Index: alsa-kernel/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/azt3328.c,v
retrieving revision 1.35
diff -u -r1.35 azt3328.c
--- alsa-kernel/pci/azt3328.c	17 Nov 2005 15:02:42 -0000	1.35
+++ alsa-kernel/pci/azt3328.c	11 Apr 2006 08:18:30 -0000
@@ -90,9 +90,11 @@
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
  */
 
@@ -213,6 +215,16 @@
 
 	struct pci_dev *pci;
 	int irq;
+
+#ifdef CONFIG_PM
+	/* register value containers for power management
+	 * Note: not always full I/O range preserved (just like Win driver!) */
+	u8 saved_regs_codec [AZF_IO_SIZE_CODEC_PM];
+	u8 saved_regs_io2   [AZF_IO_SIZE_IO2_PM];
+	u8 saved_regs_mpu   [AZF_IO_SIZE_MPU_PM];
+	u8 saved_regs_synth[AZF_IO_SIZE_SYNTH_PM];
+	u8 saved_regs_mixer[AZF_IO_SIZE_MIXER_PM];
+#endif
 };
 
 static const struct pci_device_id snd_azf3328_ids[] = {
@@ -1765,6 +1777,8 @@
 		goto out_err;
 	}
 
+	card->private_data = chip;
+
 	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_MPU401,
 				        chip->mpu_port, 1, pci->irq, 0,
 				        &chip->rmidi)) < 0) {
@@ -1790,6 +1804,8 @@
 		}
 	}
 
+	opl3->private_data = chip;
+
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->codec_port, chip->irq);
 
@@ -1833,11 +1849,85 @@
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
+	/* FIXME: this suspend function doesn't fully prevent looping sound.
+	 * I suspect it might be due to a kernel PM problem, but possibly
+	 * this function is still not entirely correct. */
+
+	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM; reg += 2)
+		*(u16 *)&chip->saved_regs_mixer[reg] = inw(chip->mixer_port + reg);
+
+	/* make sure to disable master volume etc. to prevent looping sound
+	 * (I didn't manage to successfully stop DMA engine yet) */
+	snd_azf3328_mixer_set_mute(chip, IDX_MIXER_PLAY_MASTER, 1);
+	snd_azf3328_mixer_set_mute(chip, IDX_MIXER_WAVEOUT, 1);
+	
+	for (reg = 0; reg < AZF_IO_SIZE_CODEC_PM; reg += 2)
+		*(u16 *)&chip->saved_regs_codec[reg] = inw(chip->codec_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_IO2_PM; reg += 2)
+		*(u16 *)&chip->saved_regs_io2[reg] = inw(chip->io2_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_MPU_PM; reg += 2)
+		*(u16 *)&chip->saved_regs_mpu[reg] = inw(chip->mpu_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_SYNTH_PM; reg += 2)
+		*(u16 *)&chip->saved_regs_synth[reg] = inw(chip->synth_port + reg);
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
+	for (reg = 0; reg < AZF_IO_SIZE_IO2_PM; reg += 2)
+		outw(*(u16 *)&chip->saved_regs_io2[reg], chip->io2_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_MPU_PM; reg += 2)
+		outw(*(u16 *)&chip->saved_regs_mpu[reg], chip->mpu_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_SYNTH_PM; reg += 2)
+		outw(*(u16 *)&chip->saved_regs_synth[reg], chip->synth_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_MIXER_PM; reg += 2)
+		outw(*(u16 *)&chip->saved_regs_mixer[reg], chip->mixer_port + reg);
+	for (reg = 0; reg < AZF_IO_SIZE_CODEC_PM; reg += 2)
+		outw(*(u16 *)&chip->saved_regs_codec[reg], chip->codec_port + reg);
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
+++ alsa-kernel/pci/azt3328.h	11 Apr 2006 08:18:30 -0000
@@ -5,6 +5,9 @@
 
 /*** main I/O area port indices ***/
 /* (only 0x70 of 0x80 bytes saved/restored by Windows driver) */
+#define AZF_IO_SIZE_CODEC	0x80
+#define AZF_IO_SIZE_CODEC_PM	0x70
+
 /* the driver initialisation suggests a layout of 4 main areas:
  * from 0x00 (playback), from 0x20 (recording) and from 0x40 (maybe MPU401??).
  * And another area from 0x60 to 0x6f (DirectX timer, IRQ management,
@@ -115,15 +118,26 @@
 
 /*** I/O 2 area port indices ***/
 /* (only 0x06 of 0x08 bytes saved/restored by Windows driver) */ 
+#define AZF_IO_SIZE_IO2		0x08
+#define AZF_IO_SIZE_IO2_PM	0x06
+
 #define IDX_IO2_LEGACY_ADDR	0x04
   #define LEGACY_SOMETHING		0x01 /* OPL3?? */
   #define LEGACY_JOY			0x08
 
+#define AZF_IO_SIZE_MPU		0x04
+#define AZF_IO_SIZE_MPU_PM	0x04 /* FIXME: size correct? */
+
+#define AZF_IO_SIZE_SYNTH	0x08
+#define AZF_IO_SIZE_SYNTH_PM	0x08 /* FIXME: size correct? */
 
 /*** mixer I/O area port indices ***/
 /* (only 0x22 of 0x40 bytes saved/restored by Windows driver)
  * generally spoken: AC97 register index = AZF3328 mixer reg index + 2
  * (in other words: AZF3328 NOT fully AC97 compliant) */
+#define AZF_IO_SIZE_MIXER	0x40
+#define AZF_IO_SIZE_MIXER_PM	0x22
+
   #define MIXER_VOLUME_RIGHT_MASK	0x001f
   #define MIXER_VOLUME_LEFT_MASK	0x1f00
   #define MIXER_MUTE_MASK		0x8000


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
