From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ymfpci timer
Date: Mon, 06 Oct 2003 17:58:24 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310061754190.26227-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


This adds support for the timer on ymfpci chips.


Index: alsa-kernel/include/ymfpci.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/ymfpci.h,v
retrieving revision 1.10
diff -u -r1.10 ymfpci.h
--- alsa-kernel/include/ymfpci.h	16 Jun 2003 07:31:38 -0000	1.10
+++ alsa-kernel/include/ymfpci.h	6 Oct 2003 15:48:35 -0000
@@ -25,6 +25,7 @@
 #include "pcm.h"
 #include "rawmidi.h"
 #include "ac97_codec.h"
+#include "timer.h"
 #include <linux/gameport.h>

 #ifndef PCI_VENDOR_ID_YAMAHA
@@ -349,6 +350,7 @@

 	ac97_t *ac97;
 	snd_rawmidi_t *rawmidi;
+	snd_timer_t *timer;

 	struct pci_dev *pci;
 	snd_card_t *card;
@@ -389,6 +391,7 @@
 int snd_ymfpci_pcm_spdif(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_pcm_4ch(ymfpci_t *chip, int device, snd_pcm_t **rpcm);
 int snd_ymfpci_mixer(ymfpci_t *chip, int rear_switch);
+int snd_ymfpci_timer(ymfpci_t *chip, int device);
 #if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
 int snd_ymfpci_joystick(ymfpci_t *chip);
 #endif
Index: alsa-kernel/pci/ymfpci/ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.26
diff -u -r1.26 ymfpci.c
--- alsa-kernel/pci/ymfpci/ymfpci.c	12 Aug 2003 14:10:16 -0000	1.26
+++ alsa-kernel/pci/ymfpci/ymfpci.c	6 Oct 2003 15:48:35 -0000
@@ -206,6 +206,10 @@
 		snd_card_free(card);
 		return err;
 	}
+	if ((err = snd_ymfpci_timer(chip, 0)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
 	if (chip->mpu_res) {
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_YMFPCI,
 					       mpu_port[dev], 1,
Index: alsa-kernel/pci/ymfpci/ymfpci_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci_main.c,v
retrieving revision 1.41
diff -u -r1.41 ymfpci_main.c
--- alsa-kernel/pci/ymfpci/ymfpci_main.c	14 Aug 2003 11:05:38 -0000	1.41
+++ alsa-kernel/pci/ymfpci/ymfpci_main.c	6 Oct 2003 15:48:36 -0000
@@ -779,7 +779,8 @@

 	status = snd_ymfpci_readw(chip, YDSXGR_INTFLAG);
 	if (status & 1) {
-		/* timer handler */
+		if (chip->timer)
+			snd_timer_interrupt(chip->timer, chip->timer->sticks);
 	}
 	snd_ymfpci_writew(chip, YDSXGR_INTFLAG, status);

@@ -1699,6 +1700,77 @@
 	}

 	return 0;
+}
+
+
+/*
+ * timer
+ */
+
+static int snd_ymfpci_timer_start(snd_timer_t *timer)
+{
+	ymfpci_t *chip;
+	unsigned long flags;
+	unsigned int count;
+
+	chip = snd_timer_chip(timer);
+	count = timer->sticks - 1;
+	if (count == 0) /* minimum time is 20.8 us */
+		count = 1;
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	snd_ymfpci_writew(chip, YDSXGR_TIMERCOUNT, count);
+	snd_ymfpci_writeb(chip, YDSXGR_TIMERCTRL, 0x03);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	return 0;
+}
+
+static int snd_ymfpci_timer_stop(snd_timer_t *timer)
+{
+	ymfpci_t *chip;
+	unsigned long flags;
+
+	chip = snd_timer_chip(timer);
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	snd_ymfpci_writeb(chip, YDSXGR_TIMERCTRL, 0x00);
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	return 0;
+}
+
+static int snd_ymfpci_timer_precise_resolution(snd_timer_t *timer,
+					       unsigned long *num, unsigned long *den)
+{
+	*num = 1;
+	*den = 96000;
+	return 0;
+}
+
+static struct _snd_timer_hardware snd_ymfpci_timer_hw = {
+	.flags = SNDRV_TIMER_HW_AUTO,
+	.resolution = 10417, /* 1/2fs = 10.41666...us */
+	.ticks = 65536,
+	.start = snd_ymfpci_timer_start,
+	.stop = snd_ymfpci_timer_stop,
+	.precise_resolution = snd_ymfpci_timer_precise_resolution,
+};
+
+int snd_ymfpci_timer(ymfpci_t *chip, int device)
+{
+	snd_timer_t *timer = NULL;
+	snd_timer_id_t tid;
+	int err;
+
+	tid.dev_class = SNDRV_TIMER_CLASS_CARD;
+	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
+	tid.card = chip->card->number;
+	tid.device = device;
+	tid.subdevice = 0;
+	if ((err = snd_timer_new(chip->card, "YMFPCI", &tid, &timer)) >= 0) {
+		strcpy(timer->name, "YMFPCI timer");
+		timer->private_data = chip;
+		timer->hw = snd_ymfpci_timer_hw;
+	}
+	chip->timer = timer;
+	return err;
 }






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
