From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 1/14] sound/pci: fix-up sleeping paths
Date: Fri, 8 Jul 2005 17:03:24 -0700
Message-ID: <20050709000324.GD2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09D08179
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:03:27 +0200 (MEST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j6903Rdt004517
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:03:27 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j6903QCf243650
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:03:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j6903QvJ031098
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:03:26 -0400
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
To: perex@suse.cz, sailer@ife.ee.ethz.ch, mulix@mulix.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Jaroslav, I realize that you are not the explicit maintainer for many of
these drivers, but I figured you would at least be able to {N,}ACK the
changes. I tried to add any Maintainers I could find to the recipient
list, and hope any I missed are on one of the two lists.  I'm sorry for
having put them into the same patchset, and if split patches would be
preferred, I can do that.

Description: Fix-up sleeping in sound/pci. These changes fall under the
following two categories:

	1) Replace schedule_timeout() with msleep() to guarantee the
	task delays as expected. This also involved replacing/removing
	custom sleep functions.
	2) Do not assume jiffies will only increment by one if you
	request a 1 jiffy sleep, i.e. use time_after/time_before in
	while loops.

Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 ac97/ac97_codec.c      |   17 +++++++++--------
 ali5451/ali5451.c      |    4 ++--
 cs46xx/cs46xx_lib.c    |   15 +++++----------
 ens1370.c              |   12 +-----------
 es1968.c               |   14 ++++----------
 intel8x0.c             |    3 +--
 maestro3.c             |   22 +++++++---------------
 mixart/mixart.c        |    4 ++--
 rme9652/hdsp.c         |    6 ++----
 trident/trident_main.c |    3 +--
 via82xx.c              |   13 ++++++-------
 via82xx_modem.c        |   13 ++++++-------
 ymfpci/ymfpci_main.c   |    6 +++---
 13 files changed, 49 insertions(+), 83 deletions(-)

diff -urpN 2.6.13-rc2-kj/sound/pci/ac97/ac97_codec.c 2.6.13-rc2-kj-dev/sound/pci/ac97/ac97_codec.c
--- 2.6.13-rc2-kj/sound/pci/ac97/ac97_codec.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/ac97/ac97_codec.c	2005-07-08 12:27:19.000000000 -0700
@@ -2225,6 +2225,7 @@ void snd_ac97_restore_iec958(ac97_t *ac9
 void snd_ac97_resume(ac97_t *ac97)
 {
 	int i;
+	unsigned long end_time;
 
 	if (ac97->bus->ops->reset) {
 		ac97->bus->ops->reset(ac97);
@@ -2242,26 +2243,26 @@ void snd_ac97_resume(ac97_t *ac97)
 	snd_ac97_write(ac97, AC97_POWERDOWN, ac97->regs[AC97_POWERDOWN]);
 	if (ac97_is_audio(ac97)) {
 		ac97->bus->ops->write(ac97, AC97_MASTER, 0x8101);
-		for (i = HZ/10; i >= 0; i--) {
+		end_time = jiffies + msecs_to_jiffies(100);
+		do {
 			if (snd_ac97_read(ac97, AC97_MASTER) == 0x8101)
 				break;
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
-		}
+		} while (time_after_eq(end_time, jiffies));
 		/* FIXME: extra delay */
 		ac97->bus->ops->write(ac97, AC97_MASTER, 0x8000);
-		if (snd_ac97_read(ac97, AC97_MASTER) != 0x8000) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(HZ/4);
-		}
+		if (snd_ac97_read(ac97, AC97_MASTER) != 0x8000)
+			msleep(250);
 	} else {
-		for (i = HZ/10; i >= 0; i--) {
+		end_time = jiffies + msecs_to_jiffies(100);
+		do {
 			unsigned short val = snd_ac97_read(ac97, AC97_EXTENDED_MID);
 			if (val != 0xffff && (val & 1) != 0)
 				break;
 			set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
-		}
+		} while (time_after_eq(end_time, jiffies));
 	}
 __reset_ready:
 
diff -urpN 2.6.13-rc2-kj/sound/pci/ali5451/ali5451.c 2.6.13-rc2-kj-dev/sound/pci/ali5451/ali5451.c
--- 2.6.13-rc2-kj/sound/pci/ali5451/ali5451.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/ali5451/ali5451.c	2005-07-08 12:28:38.000000000 -0700
@@ -399,7 +399,7 @@ static int snd_ali_codec_ready(	ali_t *c
 	unsigned long end_time;
 	unsigned int res;
 	
-	end_time = jiffies + 10 * (HZ >> 2);
+	end_time = jiffies + 10 * msecs_to_jiffies(250);
 	do {
 		res = snd_ali_5451_peek(codec,port);
 		if (! (res & 0x8000))
@@ -422,7 +422,7 @@ static int snd_ali_stimer_ready(ali_t *c
 	dwChk1 = snd_ali_5451_peek(codec, ALI_STIMER);
 	dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 
-	end_time = jiffies + 10 * (HZ >> 2);
+	end_time = jiffies + 10 * msecs_to_jiffies(250);
 	do {
 		dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 		if (dwChk2 != dwChk1)
diff -urpN 2.6.13-rc2-kj/sound/pci/cs46xx/cs46xx_lib.c 2.6.13-rc2-kj-dev/sound/pci/cs46xx/cs46xx_lib.c
--- 2.6.13-rc2-kj/sound/pci/cs46xx/cs46xx_lib.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/cs46xx/cs46xx_lib.c	2005-07-06 22:04:35.000000000 -0700
@@ -2400,8 +2400,7 @@ static void snd_cs46xx_codec_reset (ac97
 		if ((err = snd_ac97_read(ac97, AC97_REC_GAIN)) == 0x8a05)
 			return;
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/100);
+		msleep(10);
 	} while (time_after_eq(end_time, jiffies));
 
 	snd_printk("CS46xx secondary codec dont respond!\n");  
@@ -2435,8 +2434,7 @@ static int __devinit cs46xx_detect_codec
 			err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97[codec]);
 			return err;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/100);
+		msleep(10);
 	}
 	snd_printdd("snd_cs46xx: codec %d detection timeout\n", codec);
 	return -ENXIO;
@@ -3018,8 +3016,7 @@ static int snd_cs46xx_chip_init(cs46xx_t
 	/*
          *  Wait until the PLL has stabilized.
 	 */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/10); /* 100ms */
+	msleep(100);
 
 	/*
 	 *  Turn on clocking of the core so that we can setup the serial ports.
@@ -3072,8 +3069,7 @@ static int snd_cs46xx_chip_init(cs46xx_t
 		 */
 		if (snd_cs46xx_peekBA0(chip, BA0_ACSTS) & ACSTS_CRDY)
 			goto ok1;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((HZ+99)/100);
+		msleep(10);
 	}
 
 
@@ -3122,8 +3118,7 @@ static int snd_cs46xx_chip_init(cs46xx_t
 		 */
 		if ((snd_cs46xx_peekBA0(chip, BA0_ACISV) & (ACISV_ISV3 | ACISV_ISV4)) == (ACISV_ISV3 | ACISV_ISV4))
 			goto ok2;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((HZ+99)/100);
+		msleep(10);
 	}
 
 #ifndef CONFIG_SND_CS46XX_NEW_DSP
diff -urpN 2.6.13-rc2-kj/sound/pci/ens1370.c 2.6.13-rc2-kj-dev/sound/pci/ens1370.c
--- 2.6.13-rc2-kj/sound/pci/ens1370.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/ens1370.c	2005-07-06 22:05:18.000000000 -0700
@@ -2008,21 +2008,11 @@ static int __devinit snd_ensoniq_create(
 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
 		    pci->device == es1371_ac97_reset_hack[idx].did &&
 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
-		        unsigned long tmo;
-			signed long tmo2;
-
 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
 			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
 			/* need to delay around 20ms(bleech) to give
 			some CODECs enough time to wakeup */
-			tmo = jiffies + (HZ / 50) + 1;
-			while (1) {
-				tmo2 = tmo - jiffies;
-				if (tmo2 <= 0)
-					break;
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				schedule_timeout(tmo2);
-			}
+			msleep(20);
 			break;
 		}
 	/* AC'97 warm reset to start the bitclk */
diff -urpN 2.6.13-rc2-kj/sound/pci/es1968.c 2.6.13-rc2-kj-dev/sound/pci/es1968.c
--- 2.6.13-rc2-kj/sound/pci/es1968.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/es1968.c	2005-07-08 11:54:17.000000000 -0700
@@ -664,11 +664,6 @@ inline static u16 maestro_read(es1968_t 
 	return result;
 }
 
-#define big_mdelay(msec) do {\
-	set_current_state(TASK_UNINTERRUPTIBLE);\
-	schedule_timeout(((msec) * HZ + 999) / 1000);\
-} while (0)
-	
 /* Wait for the codec bus to be free */
 static int snd_es1968_ac97_wait(es1968_t *chip)
 {
@@ -1809,8 +1804,7 @@ static void __devinit es1968_measure_clo
 	snd_es1968_trigger_apu(chip, apu, ESM_APU_16BITLINEAR);
 	do_gettimeofday(&start_time);
 	spin_unlock_irq(&chip->reg_lock);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 20); /* 50 msec */
+	msleep(50);
 	spin_lock_irq(&chip->reg_lock);
 	offset = __apu_get_register(chip, apu, 5);
 	do_gettimeofday(&stop_time);
@@ -2093,7 +2087,7 @@ static void snd_es1968_ac97_reset(es1968
 	outw(0x0000, ioaddr + 0x60);	/* write 0 to gpio 0 */
 	udelay(20);
 	outw(0x0001, ioaddr + 0x60);	/* write 1 to gpio 1 */
-	big_mdelay(20);
+	msleep(20);
 
 	outw(save_68 | 0x1, ioaddr + 0x68);	/* now restore .. */
 	outw((inw(ioaddr + 0x38) & 0xfffc) | 0x1, ioaddr + 0x38);
@@ -2109,7 +2103,7 @@ static void snd_es1968_ac97_reset(es1968
 	outw(0x0001, ioaddr + 0x60);	/* write 1 to gpio */
 	udelay(20);
 	outw(0x0009, ioaddr + 0x60);	/* write 9 to gpio */
-	big_mdelay(500);
+	msleep(500);
 	//outw(inw(ioaddr + 0x38) & 0xfffc, ioaddr + 0x38);
 	outw(inw(ioaddr + 0x3a) & 0xfffc, ioaddr + 0x3a);
 	outw(inw(ioaddr + 0x3c) & 0xfffc, ioaddr + 0x3c);
@@ -2135,7 +2129,7 @@ static void snd_es1968_ac97_reset(es1968
 
 		if (w > 10000) {
 			outb(inb(ioaddr + 0x37) | 0x08, ioaddr + 0x37);	/* do a software reset */
-			big_mdelay(500);	/* oh my.. */
+			msleep(500);	/* oh my.. */
 			outb(inb(ioaddr + 0x37) & ~0x08,
 				ioaddr + 0x37);
 			udelay(1);
diff -urpN 2.6.13-rc2-kj/sound/pci/intel8x0.c 2.6.13-rc2-kj-dev/sound/pci/intel8x0.c
--- 2.6.13-rc2-kj/sound/pci/intel8x0.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/intel8x0.c	2005-07-08 11:54:26.000000000 -0700
@@ -2451,8 +2451,7 @@ static void __devinit intel8x0_measure_a
 	}
 	do_gettimeofday(&start_time);
 	spin_unlock_irq(&chip->reg_lock);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 20);
+	msleep(50);
 	spin_lock_irq(&chip->reg_lock);
 	/* check the position */
 	pos = ichdev->fragsize1;
diff -urpN 2.6.13-rc2-kj/sound/pci/maestro3.c 2.6.13-rc2-kj-dev/sound/pci/maestro3.c
--- 2.6.13-rc2-kj/sound/pci/maestro3.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/maestro3.c	2005-07-06 22:27:25.000000000 -0700
@@ -1050,11 +1050,6 @@ static struct m3_hv_quirk m3_hv_quirk_li
  * lowlevel functions
  */
 
-#define big_mdelay(msec) do {\
-	set_current_state(TASK_UNINTERRUPTIBLE);\
-	schedule_timeout(((msec) * HZ) / 1000);\
-} while (0)
-	
 inline static void snd_m3_outw(m3_t *chip, u16 value, unsigned long reg)
 {
 	outw(value, chip->iobase + reg);
@@ -1096,7 +1091,7 @@ static void snd_m3_assp_write(m3_t *chip
 static void snd_m3_assp_halt(m3_t *chip)
 {
 	chip->reset_state = snd_m3_inb(chip, DSP_PORT_CONTROL_REG_B) & ~REGB_STOP_CLOCK;
-	big_mdelay(10);
+	msleep(10);
 	snd_m3_outb(chip, chip->reset_state & ~REGB_ENABLE_RESET, DSP_PORT_CONTROL_REG_B);
 }
 
@@ -2080,8 +2075,7 @@ static void snd_m3_ac97_reset(m3_t *chip
 		outw(0, io + GPIO_DATA);
 		outw(dir | GPO_PRIMARY_AC97, io + GPIO_DIRECTION);
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((delay1 * HZ) / 1000);
+		msleep(delay1);
 
 		outw(GPO_PRIMARY_AC97, io + GPIO_DATA);
 		udelay(5);
@@ -2089,8 +2083,7 @@ static void snd_m3_ac97_reset(m3_t *chip
 		outw(IO_SRAM_ENABLE | SERIAL_AC_LINK_ENABLE, io + RING_BUS_CTRL_A);
 		outw(~0, io + GPIO_MASK);
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((delay2 * HZ) / 1000);
+		msleep(delay2);
 
 		if (! snd_m3_try_read_vendor(chip))
 			break;
@@ -2108,9 +2101,9 @@ static void snd_m3_ac97_reset(m3_t *chip
 	 */
 	tmp = inw(io + RING_BUS_CTRL_A);
 	outw(RAC_SDFS_ENABLE|LAC_SDFS_ENABLE, io + RING_BUS_CTRL_A);
-	big_mdelay(20);
+	msleep(20);
 	outw(tmp, io + RING_BUS_CTRL_A);
-	big_mdelay(50);
+	msleep(50);
 #endif
 }
 
@@ -2135,8 +2128,7 @@ static int __devinit snd_m3_mixer(m3_t *
 
 	/* seems ac97 PCM needs initialization.. hack hack.. */
 	snd_ac97_write(chip->ac97, AC97_PCM, 0x8000 | (15 << 8) | 15);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 10);
+	msleep(100);
 	snd_ac97_write(chip->ac97, AC97_PCM, 0);
 
 	memset(&id, 0, sizeof(id));
@@ -2589,7 +2581,7 @@ static int m3_suspend(snd_card_t *card, 
 	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
 
-	big_mdelay(10); /* give the assp a chance to idle.. */
+	msleep(10); /* give the assp a chance to idle.. */
 
 	snd_m3_assp_halt(chip);
 
diff -urpN 2.6.13-rc2-kj/sound/pci/mixart/mixart.c 2.6.13-rc2-kj-dev/sound/pci/mixart/mixart.c
--- 2.6.13-rc2-kj/sound/pci/mixart/mixart.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/mixart/mixart.c	2005-07-08 13:47:26.000000000 -0700
@@ -445,9 +445,9 @@ static int snd_mixart_trigger(snd_pcm_su
 
 static int mixart_sync_nonblock_events(mixart_mgr_t *mgr)
 {
-	int timeout = HZ;
+	unsigned long timeout = jiffies + HZ;
 	while (atomic_read(&mgr->msg_processed) > 0) {
-		if (! timeout--) {
+		if (time_after(jiffies, timeout)) {
 			snd_printk(KERN_ERR "mixart: cannot process nonblock events!\n");
 			return -EBUSY;
 		}
diff -urpN 2.6.13-rc2-kj/sound/pci/rme9652/hdsp.c 2.6.13-rc2-kj-dev/sound/pci/rme9652/hdsp.c
--- 2.6.13-rc2-kj/sound/pci/rme9652/hdsp.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/rme9652/hdsp.c	2005-07-06 22:55:11.000000000 -0700
@@ -678,8 +678,7 @@ static int snd_hdsp_load_firmware_from_c
 		}
 
 		if ((1000 / HZ) < 3000) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout((3000 * HZ + 999) / 1000);
+			ssleep(3);
 		} else {
 			mdelay(3000);
 		}
@@ -5036,8 +5035,7 @@ static int __devinit snd_hdsp_create(snd
 	if (!is_9652 && !is_9632) {
 		/* we wait 2 seconds to let freshly inserted cardbus cards do their hardware init */
  		if ((1000 / HZ) < 2000) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout((2000 * HZ + 999) / 1000);
+			ssleep(2);
 		} else {
 			mdelay(2000);
 		}
diff -urpN 2.6.13-rc2-kj/sound/pci/trident/trident_main.c 2.6.13-rc2-kj-dev/sound/pci/trident/trident_main.c
--- 2.6.13-rc2-kj/sound/pci/trident/trident_main.c	2005-07-06 07:57:08.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/trident/trident_main.c	2005-07-06 22:55:36.000000000 -0700
@@ -3152,8 +3152,7 @@ static int snd_trident_gameport_open(str
 	switch (mode) {
 		case GAMEPORT_MODE_COOKED:
 			outb(GAMEPORT_MODE_ADC, TRID_REG(chip, GAMEPORT_GCR));
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1 + 20 * HZ / 1000); /* 20msec */
+			msleep(20);
 			return 0;
 		case GAMEPORT_MODE_RAW:
 			outb(0, TRID_REG(chip, GAMEPORT_GCR));
diff -urpN 2.6.13-rc2-kj/sound/pci/via82xx.c 2.6.13-rc2-kj-dev/sound/pci/via82xx.c
--- 2.6.13-rc2-kj/sound/pci/via82xx.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/via82xx.c	2005-07-08 12:30:59.000000000 -0700
@@ -547,8 +547,7 @@ static void snd_via82xx_codec_wait(ac97_
 	int err;
 	err = snd_via82xx_codec_ready(chip, ac97->num);
 	/* here we need to wait fairly for long time.. */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/2);
+	msleep(500);
 }
 
 static void snd_via82xx_codec_write(ac97_t *ac97,
@@ -1847,7 +1846,7 @@ static void __devinit snd_via82xx_proc_i
 static int snd_via82xx_chip_init(via82xx_t *chip)
 {
 	unsigned int val;
-	int max_count;
+	unsigned long end_time;
 	unsigned char pval;
 
 #if 0 /* broken on K7M? */
@@ -1889,14 +1888,14 @@ static int snd_via82xx_chip_init(via82xx
 	}
 
 	/* wait until codec ready */
-	max_count = ((3 * HZ) / 4) + 1;
+	end_time = jiffies + msecs_to_jiffies(750);
 	do {
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (--max_count > 0);
+	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
 		snd_printk("AC'97 codec is not ready [0x%x]\n", val);
@@ -1905,7 +1904,7 @@ static int snd_via82xx_chip_init(via82xx
 	snd_via82xx_codec_xwrite(chip, VIA_REG_AC97_READ |
 				 VIA_REG_AC97_SECONDARY_VALID |
 				 (VIA_REG_AC97_CODEC_ID_SECONDARY << VIA_REG_AC97_CODEC_ID_SHIFT));
-	max_count = ((3 * HZ) / 4) + 1;
+	end_time = jiffies + msecs_to_jiffies(750);
 	snd_via82xx_codec_xwrite(chip, VIA_REG_AC97_READ |
 				 VIA_REG_AC97_SECONDARY_VALID |
 				 (VIA_REG_AC97_CODEC_ID_SECONDARY << VIA_REG_AC97_CODEC_ID_SHIFT));
@@ -1916,7 +1915,7 @@ static int snd_via82xx_chip_init(via82xx
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (--max_count > 0);
+	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
       __ac97_ok2:
diff -urpN 2.6.13-rc2-kj/sound/pci/via82xx_modem.c 2.6.13-rc2-kj-dev/sound/pci/via82xx_modem.c
--- 2.6.13-rc2-kj/sound/pci/via82xx_modem.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/via82xx_modem.c	2005-07-08 12:32:09.000000000 -0700
@@ -408,8 +408,7 @@ static void snd_via82xx_codec_wait(ac97_
 	int err;
 	err = snd_via82xx_codec_ready(chip, ac97->num);
 	/* here we need to wait fairly for long time.. */
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ/2);
+	msleep(500);
 }
 
 static void snd_via82xx_codec_write(ac97_t *ac97,
@@ -923,7 +922,7 @@ static void __devinit snd_via82xx_proc_i
 static int snd_via82xx_chip_init(via82xx_t *chip)
 {
 	unsigned int val;
-	int max_count;
+	unsigned long end_time;
 	unsigned char pval;
 
 	pci_read_config_byte(chip->pci, VIA_MC97_CTRL, &pval);
@@ -962,14 +961,14 @@ static int snd_via82xx_chip_init(via82xx
 	}
 
 	/* wait until codec ready */
-	max_count = ((3 * HZ) / 4) + 1;
+	end_time = jiffies + msecs_to_jiffies(750);
 	do {
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (--max_count > 0);
+	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
 		snd_printk("AC'97 codec is not ready [0x%x]\n", val);
@@ -977,7 +976,7 @@ static int snd_via82xx_chip_init(via82xx
 	snd_via82xx_codec_xwrite(chip, VIA_REG_AC97_READ |
 				 VIA_REG_AC97_SECONDARY_VALID |
 				 (VIA_REG_AC97_CODEC_ID_SECONDARY << VIA_REG_AC97_CODEC_ID_SHIFT));
-	max_count = ((3 * HZ) / 4) + 1;
+	end_time = jiffies + msecs_to_jiffies(750);
 	snd_via82xx_codec_xwrite(chip, VIA_REG_AC97_READ |
 				 VIA_REG_AC97_SECONDARY_VALID |
 				 (VIA_REG_AC97_CODEC_ID_SECONDARY << VIA_REG_AC97_CODEC_ID_SHIFT));
@@ -988,7 +987,7 @@ static int snd_via82xx_chip_init(via82xx
 		}
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (--max_count > 0);
+	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
       __ac97_ok2:
diff -urpN 2.6.13-rc2-kj/sound/pci/ymfpci/ymfpci_main.c 2.6.13-rc2-kj-dev/sound/pci/ymfpci/ymfpci_main.c
--- 2.6.13-rc2-kj/sound/pci/ymfpci/ymfpci_main.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/pci/ymfpci/ymfpci_main.c	2005-07-08 12:33:00.000000000 -0700
@@ -84,16 +84,16 @@ static inline void snd_ymfpci_writel(ymf
 
 static int snd_ymfpci_codec_ready(ymfpci_t *chip, int secondary)
 {
-	signed long end_time;
+	unsigned long end_time;
 	u32 reg = secondary ? YDSXGR_SECSTATUSADR : YDSXGR_PRISTATUSADR;
 	
-	end_time = (jiffies + ((3 * HZ) / 4)) + 1;
+	end_time = jiffies + msecs_to_jiffies(750);
 	do {
 		if ((snd_ymfpci_readw(chip, reg) & 0x8000) == 0)
 			return 0;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(1);
-	} while (end_time - (signed long)jiffies >= 0);
+	} while (time_before(jiffies, end_time));
 	snd_printk("codec_ready: codec %i is not ready [0x%x]\n", secondary, snd_ymfpci_readw(chip, reg));
 	return -EBUSY;
 }


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
