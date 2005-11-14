From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] ALS4000 update
Date: Tue, 15 Nov 2005 00:00:42 +0100
Message-ID: <20051114230042.GA2695@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

some update for the ALS4000 driver (tested with hardware in my PC):

- use common control names according to ControlNames.txt
- add some controls (Master Mono, 3D control)
- optimize struct snd_card_als4000_t layout (performance/size)
- save some bytes via unified error path
- constify some read-only data
- add ToDo list
- move GPL license text to top
- add comments

Diff against current CVS, please commit.

Signed-off-by: Andreas Mohr <andi@lisas.de>
(those updates done by me, and me alone)

Thanks,

Andreas Mohr (more updates to various cards to follow soon!)

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="als4000.diff"

Index: alsa-kernel/isa/sb/sb_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/sb_mixer.c,v
retrieving revision 1.17
diff -u -r1.17 sb_mixer.c
--- alsa-kernel/isa/sb/sb_mixer.c	20 Oct 2005 17:26:44 -0000	1.17
+++ alsa-kernel/isa/sb/sb_mixer.c	14 Nov 2005 22:55:33 -0000
@@ -669,25 +669,34 @@
 /*
  * ALS4000 specific mixer elements
  */
-/* FIXME: SB_ALS4000_MONO_IO_CTRL needs output select ctrl ! */
-static struct sbmix_elem snd_als4000_ctl_mono_output_switch =
-	SB_SINGLE("Mono Output Switch", SB_ALS4000_MONO_IO_CTRL, 5, 1);
-/* FIXME: mono input switch also available on DT019X ? */
-static struct sbmix_elem snd_als4000_ctl_mono_input_switch =
-	SB_SINGLE("Mono Input Switch", SB_DT019X_OUTPUT_SW2, 0, 1);
+/* FIXME: SB_ALS4000_MONO_IO_CTRL needs output select ctrl! */
+static struct sbmix_elem snd_als4000_ctl_master_mono_playback_switch =
+	SB_SINGLE("Master Mono Playback Switch", SB_ALS4000_MONO_IO_CTRL, 5, 1);
+static struct sbmix_elem snd_als4000_ctl_master_mono_capture_route =
+	SB_SINGLE("Master Mono Capture Route", SB_ALS4000_MONO_IO_CTRL, 6, 0x03);
+/* FIXME: mono playback switch also available on DT019X? */
+static struct sbmix_elem snd_als4000_ctl_mono_playback_switch =
+	SB_SINGLE("Mono Playback Switch", SB_DT019X_OUTPUT_SW2, 0, 1);
 static struct sbmix_elem snd_als4000_ctl_mic_20db_boost =
 	SB_SINGLE("Mic Boost (+20dB)", SB_ALS4000_MIC_IN_GAIN, 0, 0x03);
-static struct sbmix_elem snd_als4000_ctl_mixer_out_to_in =
-	SB_SINGLE("Mixer Out To In", SB_ALS4000_MIC_IN_GAIN, 7, 0x01);
-/* FIXME: 3D needs much more sophisticated controls, many more features ! */
-static struct sbmix_elem snd_als4000_ctl_3d_output_switch =
-	SB_SINGLE("3D Output Switch", SB_ALS4000_3D_SND_FX, 6, 0x01);
-static struct sbmix_elem snd_als4000_ctl_3d_output_ratio =
-	SB_SINGLE("3D Output Ratio", SB_ALS4000_3D_SND_FX, 0, 0x07);
-static struct sbmix_elem snd_als4000_ctl_3d_poweroff_switch =
+static struct sbmix_elem snd_als4000_ctl_mixer_loopback =
+	SB_SINGLE("Analog Loopback", SB_ALS4000_MIC_IN_GAIN, 7, 0x01);
+/* FIXME: functionality of 3D controls might be swapped, I didn't find
+ * a description of how to identify what is supposed to be what */
+static struct sbmix_elem snd_als4000_3d_control_switch =
+	SB_SINGLE("3D Control - Switch", SB_ALS4000_3D_SND_FX, 6, 0x01);
+static struct sbmix_elem snd_als4000_3d_control_ratio =
+	SB_SINGLE("3D Control - Level", SB_ALS4000_3D_SND_FX, 0, 0x07);
+static struct sbmix_elem snd_als4000_3d_control_freq =
+	/* FIXME: maybe there's actually some standard 3D ctrl name for it?? */
+	SB_SINGLE("3D Control - Freq", SB_ALS4000_3D_SND_FX, 4, 0x03);
+static struct sbmix_elem snd_als4000_3d_control_delay =
+	/* FIXME: ALS4000a.pdf mentions BBD (Bucket Brigade Device) time delay,
+	 * but what ALSA 3D attribute is that actually? "Center", "Depth",
+	 * "Wide" or "Space" or even "Level"? Assuming "Wide" for now... */
+	SB_SINGLE("3D Control - Wide", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f);
+static struct sbmix_elem snd_als4000_3d_control_poweroff_switch =
 	SB_SINGLE("3D PowerOff Switch", SB_ALS4000_3D_TIME_DELAY, 4, 0x01);
-static struct sbmix_elem snd_als4000_ctl_3d_delay =
-	SB_SINGLE("3D Delay", SB_ALS4000_3D_TIME_DELAY, 0, 0x0f);
 #ifdef NOT_AVAILABLE
 static struct sbmix_elem snd_als4000_ctl_fmdac =
 	SB_SINGLE("FMDAC Switch (Option ?)", SB_ALS4000_FMDAC, 0, 0x01);
@@ -716,13 +725,15 @@
 	&snd_sb16_ctl_pc_speaker_vol,
 	&snd_sb16_ctl_capture_vol,
 	&snd_sb16_ctl_play_vol,
-	&snd_als4000_ctl_mono_output_switch,
-	&snd_als4000_ctl_mono_input_switch,
-	&snd_als4000_ctl_mixer_out_to_in,
-	&snd_als4000_ctl_3d_output_switch,
-	&snd_als4000_ctl_3d_output_ratio,
-	&snd_als4000_ctl_3d_delay,
-	&snd_als4000_ctl_3d_poweroff_switch,
+	&snd_als4000_ctl_master_mono_playback_switch,
+	&snd_als4000_ctl_master_mono_capture_route,
+	&snd_als4000_ctl_mono_playback_switch,
+	&snd_als4000_ctl_mixer_loopback,
+	&snd_als4000_3d_control_switch,
+	&snd_als4000_3d_control_ratio,
+	&snd_als4000_3d_control_freq,
+	&snd_als4000_3d_control_delay,
+	&snd_als4000_3d_control_poweroff_switch,
 #ifdef NOT_AVAILABLE
 	&snd_als4000_ctl_fmdac,
 	&snd_als4000_ctl_qsound,
Index: alsa-kernel/pci/als4000.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/als4000.c,v
retrieving revision 1.46
diff -u -r1.46 als4000.c
--- alsa-kernel/pci/als4000.c	20 Oct 2005 17:25:51 -0000	1.46
+++ alsa-kernel/pci/als4000.c	14 Nov 2005 22:55:33 -0000
@@ -6,6 +6,21 @@
  *
  *  Framework borrowed from Massimo Piccioni's card-als100.c.
  *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
  * NOTES
  *
  *  Since Avance does not provide any meaningful documentation, and I
@@ -43,19 +58,9 @@
  * Set KSound:
  * - value -> some port 0x0c0d
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
-
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ * ToDo:
+ * - Proper shared IRQ handling?
+ * - power management? (card can do voice wakeup according to datasheet!!)
  */
 
 #include <sound/driver.h>
@@ -101,8 +106,9 @@
 #endif
 
 typedef struct {
-	struct pci_dev *pci;
+	/* most frequent access first */
 	unsigned long gcr;
+	struct pci_dev *pci;
 #ifdef SUPPORT_JOYSTICK
 	struct gameport *gameport;
 #endif
@@ -146,13 +152,13 @@
 	}
 }
 
-static void snd_als4000_set_capture_dma(sb_t *chip, dma_addr_t addr, unsigned size)
+static inline void snd_als4000_set_capture_dma(sb_t *chip, dma_addr_t addr, unsigned size)
 {
 	snd_als4000_gcr_write(chip, 0xa2, addr);
 	snd_als4000_gcr_write(chip, 0xa3, (size-1));
 }
 
-static void snd_als4000_set_playback_dma(sb_t *chip, dma_addr_t addr, unsigned size)
+static inline void snd_als4000_set_playback_dma(sb_t *chip, dma_addr_t addr, unsigned size)
 {
 	snd_als4000_gcr_write(chip, 0x91, addr);
 	snd_als4000_gcr_write(chip, 0x92, (size-1)|0x180000);
@@ -177,7 +183,7 @@
 }
 
 /* structure for setting up playback */
-static struct {
+static const struct {
 	unsigned char dsp_cmd, dma_on, dma_off, format;
 } playback_cmd_vals[]={
 /* ALS4000_FORMAT_U8_MONO */
@@ -201,7 +207,7 @@
 
 /* structure for setting up capture */
 enum { CMD_WIDTH8=0x04, CMD_SIGNED=0x10, CMD_MONO=0x80, CMD_STEREO=0xA0 };
-static unsigned char capture_cmd_vals[]=
+static const unsigned char capture_cmd_vals[]=
 {
 CMD_WIDTH8|CMD_MONO,			/* ALS4000_FORMAT_U8_MONO */
 CMD_WIDTH8|CMD_SIGNED|CMD_MONO,		/* ALS4000_FORMAT_S8_MONO */	
@@ -228,9 +234,9 @@
 
 static int snd_als4000_capture_prepare(snd_pcm_substream_t * substream)
 {
-	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned long flags;
 	unsigned long size;
 	unsigned count;
 
@@ -256,9 +262,9 @@
 
 static int snd_als4000_playback_prepare(snd_pcm_substream_t *substream)
 {
-	unsigned long flags;
 	sb_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
+	unsigned long flags;
 	unsigned long size;
 	unsigned count;
 
@@ -353,6 +359,18 @@
 	return bytes_to_frames( substream->runtime, result );
 }
 
+/* FIXME: this IRQ routine doesn't really support IRQ sharing (we always
+ * return IRQ_HANDLED no matter whether we actually had an IRQ flag or not).
+ * ALS4000a.PDF writes that while ACKing IRQ in PCI block will *not* ACK
+ * the IRQ in the SB core, ACKing IRQ in SB block *will* ACK the PCI IRQ
+ * register (alt_port + 0x0e). Probably something could be optimized here to
+ * query/write one register only...
+ * And even if both registers need to be queried, then there's still the
+ * question of whether it's actually correct to ACK PCI IRQ before reading
+ * SB IRQ like we do now, since ALS4000a.PDF mentions that PCI IRQ will *clear*
+ * SB IRQ status.
+ * And do we *really* need the lock here for *reading* SB_DSP4_IRQSTATUS??
+ * */
 static irqreturn_t snd_als4000_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	sb_t *chip = dev_id;
@@ -706,8 +724,7 @@
 				    -1,
 				    SB_HW_ALS4000,
 				    &chip)) < 0) {
-		snd_card_free(card);
-		return err;
+		goto out_err;
 	}
 
 	chip->pci = pci;
@@ -724,40 +741,42 @@
 	if ((err = snd_mpu401_uart_new( card, 0, MPU401_HW_ALS4000,
 				        gcr+0x30, 1, pci->irq, 0,
 				        &chip->rmidi)) < 0) {
-		snd_card_free(card);
-		printk(KERN_ERR "als4000: no MPU-401device at 0x%lx ?\n", gcr+0x30);
-		return err;
+		printk(KERN_ERR "als4000: no MPU-401 device at 0x%lx?\n", gcr+0x30);
+		goto out_err;
 	}
 
 	if ((err = snd_als4000_pcm(chip, 0)) < 0) {
-		snd_card_free(card);
-		return err;
+		goto out_err;
 	}
 	if ((err = snd_sbmixer_new(chip)) < 0) {
-		snd_card_free(card);
-		return err;
+		goto out_err;
 	}	    
 
 	if (snd_opl3_create(card, gcr+0x10, gcr+0x12,
 			    OPL3_HW_AUTO, 1, &opl3) < 0) {
-		printk(KERN_ERR "als4000: no OPL device at 0x%lx-0x%lx ?\n",
+		printk(KERN_ERR "als4000: no OPL device at 0x%lx-0x%lx?\n",
 			   gcr+0x10, gcr+0x12 );
 	} else {
 		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-			snd_card_free(card);
-			return err;
+			goto out_err;
 		}
 	}
 
 	snd_als4000_create_gameport(acard, dev);
 
 	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
+		goto out_err;
 	}
 	pci_set_drvdata(pci, card);
 	dev++;
-	return 0;
+	err = 0;
+	goto out;
+
+out_err:
+	snd_card_free(card);
+	
+out:
+	return err;
 }
 
 static void __devexit snd_card_als4000_remove(struct pci_dev *pci)

--Kj7319i9nmIyA2yE--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
