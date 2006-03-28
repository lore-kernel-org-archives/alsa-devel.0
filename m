From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] maestro3.c: fix BUG, optimization
Date: Tue, 28 Mar 2006 09:58:33 +0200
Message-ID: <20060328075833.GA28413@rhlx01.fht-esslingen.de>
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

- fix brown-paper-bag locking bug (lock() / return / unlock())
- improve central function snd_m3_update_ptr()
  (avoid expensive integer divisions)
- add cpu_relax() to busy-wait I/O loop as recommended
  (does this require special macro support in ALSA for older kernels??)
- constify several structs
- spelling updates

Patch done and hardware-tested on 2.6.16-ck1, rediffed to ALSA CVS.

Signed-off-by: Andreas Mohr <andi@lisas.de>

Index: alsa-kernel/pci/maestro3.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/maestro3.c,v
retrieving revision 1.88
diff -u -r1.88 maestro3.c
--- alsa-kernel/pci/maestro3.c	24 Mar 2006 14:35:01 -0000	1.88
+++ alsa-kernel/pci/maestro3.c	28 Mar 2006 07:47:44 -0000
@@ -830,8 +830,8 @@
 	struct snd_pcm *pcm;
 
 	struct pci_dev *pci;
-	struct m3_quirk *quirk;
-	struct m3_hv_quirk *hv_quirk;
+	const struct m3_quirk *quirk;
+	const struct m3_hv_quirk *hv_quirk;
 
 	int dacs_active;
 	int timer_users;
@@ -891,7 +891,7 @@
 
 MODULE_DEVICE_TABLE(pci, snd_m3_ids);
 
-static struct m3_quirk m3_quirk_list[] = {
+static const struct m3_quirk m3_quirk_list[] = {
 	/* panasonic CF-28 "toughbook" */
 	{
 		.name = "Panasonic CF-28",
@@ -949,7 +949,7 @@
 };
 
 /* These values came from the Windows driver. */
-static struct m3_hv_quirk m3_hv_quirk_list[] = {
+static const struct m3_hv_quirk m3_hv_quirk_list[] = {
 	/* Allegro chips */
 	{ 0x125D, 0x1988, 0x0E11, 0x002E, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
 	{ 0x125D, 0x1988, 0x0E11, 0x0094, HV_CTRL_ENABLE | HV_BUTTON_FROM_GD, 0 },
@@ -1360,7 +1360,7 @@
 }
 
 
-static struct play_vals {
+static const struct play_vals {
 	u16 addr, val;
 } pv[] = {
 	{CDATA_LEFT_VOLUME, ARB_VOLUME},
@@ -1427,7 +1427,7 @@
 /*
  *    Native record driver 
  */
-static struct rec_vals {
+static const struct rec_vals {
 	u16 addr, val;
 } rv[] = {
 	{CDATA_LEFT_VOLUME, ARB_VOLUME},
@@ -1597,12 +1597,26 @@
 	if (! s->running)
 		return;
 
-	hwptr = snd_m3_get_pointer(chip, s, subs) % s->dma_size;
-	diff = (s->dma_size + hwptr - s->hwptr) % s->dma_size;
+	hwptr = snd_m3_get_pointer(chip, s, subs);
+
+	/* try to avoid expensive modulo divisions */
+	if (hwptr >= s->dma_size)
+		hwptr %= s->dma_size;
+
+	diff = s->dma_size + hwptr - s->hwptr;
+	if (diff >= s->dma_size)
+		diff %= s->dma_size;
+
 	s->hwptr = hwptr;
 	s->count += diff;
+
 	if (s->count >= (signed)s->period_size) {
-		s->count %= s->period_size;
+
+		if (s->count < 2 * (signed)s->period_size)
+			s->count -= (signed)s->period_size;
+		else
+			s->count %= s->period_size;
+
 		spin_unlock(&chip->reg_lock);
 		snd_pcm_period_elapsed(subs);
 		spin_lock(&chip->reg_lock);
@@ -1941,6 +1955,7 @@
 	do {
 		if (! (snd_m3_inb(chip, 0x30) & 1))
 			return 0;
+		cpu_relax();
 	} while (i-- > 0);
 
 	snd_printk(KERN_ERR "ac97 serial bus busy\n");
@@ -1952,16 +1967,18 @@
 {
 	struct snd_m3 *chip = ac97->private_data;
 	unsigned long flags;
-	unsigned short data;
+	unsigned short data = 0xffff;
 
 	if (snd_m3_ac97_wait(chip))
-		return 0xffff;
+		goto fail;
 	spin_lock_irqsave(&chip->ac97_lock, flags);
 	snd_m3_outb(chip, 0x80 | (reg & 0x7f), CODEC_COMMAND);
 	if (snd_m3_ac97_wait(chip))
-		return 0xffff;
+		goto fail_unlock;
 	data = snd_m3_inw(chip, CODEC_DATA);
+fail_unlock:
 	spin_unlock_irqrestore(&chip->ac97_lock, flags);
+fail:
 	return data;
 }
 
@@ -2120,7 +2137,7 @@
  * DSP Code images
  */
 
-static u16 assp_kernel_image[] __devinitdata = {
+static const u16 assp_kernel_image[] __devinitdata = {
     0x7980, 0x0030, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x00FB, 0x7980, 0x00DD, 0x7980, 0x03B4, 
     0x7980, 0x0332, 0x7980, 0x0287, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 
     0x7980, 0x031A, 0x7980, 0x03B4, 0x7980, 0x022F, 0x7980, 0x03B4, 0x7980, 0x03B4, 0x7980, 0x03B4, 
@@ -2207,7 +2224,7 @@
  * Mini sample rate converter code image
  * that is to be loaded at 0x400 on the DSP.
  */
-static u16 assp_minisrc_image[] __devinitdata = {
+static const u16 assp_minisrc_image[] __devinitdata = {
 
     0xBF80, 0x101E, 0x906E, 0x006E, 0x8B88, 0x6980, 0xEF88, 0x906F, 0x0D6F, 0x6900, 0xEB08, 0x0412, 
     0xBC20, 0x696E, 0xB801, 0x906E, 0x7980, 0x0403, 0xB90E, 0x8807, 0xBE43, 0xBF01, 0xBE47, 0xBE41, 
@@ -2250,7 +2267,7 @@
  */
 
 #define MINISRC_LPF_LEN 10
-static u16 minisrc_lpf[MINISRC_LPF_LEN] __devinitdata = {
+static const u16 minisrc_lpf[MINISRC_LPF_LEN] __devinitdata = {
 	0X0743, 0X1104, 0X0A4C, 0XF88D, 0X242C,
 	0X1023, 0X1AA9, 0X0B60, 0XEFDD, 0X186F
 };
@@ -2357,7 +2374,7 @@
 	 */
 
 	/*
-	 * align instance address to 256 bytes so that it's
+	 * align instance address to 256 bytes so that its
 	 * shifted list address is aligned.
 	 * list address = (mem address >> 1) >> 7;
 	 */
@@ -2646,8 +2663,8 @@
 {
 	struct snd_m3 *chip;
 	int i, err;
-	struct m3_quirk *quirk;
-	struct m3_hv_quirk *hv_quirk;
+	const struct m3_quirk *quirk;
+	const struct m3_hv_quirk *hv_quirk;
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_m3_dev_free,
 	};
@@ -2842,12 +2859,12 @@
 	}
 
 #if 0 /* TODO: not supported yet */
-	/* TODO enable midi irq and i/o */
+	/* TODO enable MIDI IRQ and I/O */
 	err = snd_mpu401_uart_new(chip->card, 0, MPU401_HW_MPU401,
 				  chip->iobase + MPU401_DATA_PORT, 1,
 				  chip->irq, 0, &chip->rmidi);
 	if (err < 0)
-		printk(KERN_WARNING "maestro3: no midi support.\n");
+		printk(KERN_WARNING "maestro3: no MIDI support.\n");
 #endif
 
 	pci_set_drvdata(pci, card);
-- 
GNU/Linux. It's not the software that's free, it's you.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
