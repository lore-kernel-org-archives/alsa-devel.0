From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: add interval timer support
Date: Wed, 03 Nov 2004 16:24:41 -0500
Message-ID: <1099517082.1617.38.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
	 <1099511035.1617.32.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099511035.1617.32.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-03 at 14:43 -0500, Lee Revell wrote:
> OK I converted this code to use the ALSA timer API.

Here is the patch against ALSA CVS.  I tested it with the ALSA from
kernel 2.6.9-rc3-mm3 because CVS does not build currently.

diff -Nru alsa-orig/alsa-kernel/pci/emu10k1/emu10k1.c alsa/alsa-kernel/pci/emu10k1/emu10k1.c
--- alsa-orig/alsa-kernel/pci/emu10k1/emu10k1.c	2004-10-23 12:10:27.000000000 -0400
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1.c	2004-11-03 13:21:06.000000000 -0500
@@ -124,6 +124,12 @@
 		snd_card_free(card);
 		return err;
 	}
+	
+	if ((err = snd_emu10k1_timer(emu, 0)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
 	if (emu->audigy) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
 			snd_card_free(card);
diff -Nru alsa-orig/alsa-kernel/pci/emu10k1/irq.c alsa/alsa-kernel/pci/emu10k1/irq.c
--- alsa-orig/alsa-kernel/pci/emu10k1/irq.c	2004-06-29 12:10:33.000000000 -0400
+++ alsa/alsa-kernel/pci/emu10k1/irq.c	2004-11-03 13:22:02.000000000 -0500
@@ -112,8 +112,8 @@
 			status &= ~(IPR_A_MIDITRANSBUFEMPTY2|IPR_A_MIDIRECVBUFEMPTY2);
 		}
 		if (status & IPR_INTERVALTIMER) {
-			if (emu->timer_interrupt)
-				emu->timer_interrupt(emu);
+			if (emu->timer)
+				snd_timer_interrupt(emu->timer, emu->timer->sticks);
 			else
 				snd_emu10k1_intr_disable(emu, INTE_INTERVALTIMERENB);
 			status &= ~IPR_INTERVALTIMER;
diff -Nru alsa-orig/alsa-kernel/pci/emu10k1/timer.c alsa/alsa-kernel/pci/emu10k1/timer.c
--- alsa-orig/alsa-kernel/pci/emu10k1/timer.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa/alsa-kernel/pci/emu10k1/timer.c	2004-11-03 16:20:54.000000000 -0500
@@ -0,0 +1,99 @@
+/*
+ *  Copyright (c) by Lee Revell <rlrevell@joe-job.com>
+ *  
+ *  Routines for control of EMU10K1 chips
+ *
+ *  Copied from similar code by Clemens Ladisch in the ymfpci driver
+ * 
+ *  BUGS:
+ *    --
+ *
+ *  TODO:
+ *    --
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/time.h>
+#include <sound/core.h>
+#include <sound/emu10k1.h>
+
+static int snd_emu10k1_timer_start(snd_timer_t *timer)
+{
+	emu10k1_t *emu;
+	unsigned long flags;
+	unsigned int delay;
+
+	emu = snd_timer_chip(timer);
+	delay = timer->sticks - 1;
+	if (delay < 5 ) /* minimum time is 5 ticks */
+		delay = 5;
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	snd_emu10k1_intr_enable(emu, INTE_INTERVALTIMERENB);
+	outw(delay & TIMER_RATE_MASK, emu->port + TIMER);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_emu10k1_timer_stop(snd_timer_t *timer)
+{
+	emu10k1_t *emu;
+	unsigned long flags;
+
+	emu = snd_timer_chip(timer);
+	spin_lock_irqsave(&emu->reg_lock, flags);
+	snd_emu10k1_intr_disable(emu, INTE_INTERVALTIMERENB);
+	spin_unlock_irqrestore(&emu->reg_lock, flags);
+	return 0;
+}
+
+static int snd_emu10k1_timer_precise_resolution(snd_timer_t *timer,
+					       unsigned long *num, unsigned long *den)
+{
+	*num = 1;
+	*den = 48000;
+	return 0;
+}
+
+static struct _snd_timer_hardware snd_emu10k1_timer_hw = {
+	.flags = SNDRV_TIMER_HW_AUTO,
+	.resolution = 20833, /* 1 sample @ 48KHZ = 20.833...us */
+	.ticks = 1024,
+	.start = snd_emu10k1_timer_start,
+	.stop = snd_emu10k1_timer_stop,
+	.precise_resolution = snd_emu10k1_timer_precise_resolution,
+};
+
+int __devinit snd_emu10k1_timer(emu10k1_t *emu, int device)
+{
+	snd_timer_t *timer = NULL;
+	snd_timer_id_t tid;
+	int err;
+
+	tid.dev_class = SNDRV_TIMER_CLASS_CARD;
+	tid.dev_sclass = SNDRV_TIMER_SCLASS_NONE;
+	tid.card = emu->card->number;
+	tid.device = device;
+	tid.subdevice = 0;
+	if ((err = snd_timer_new(emu->card, "EMU10K1", &tid, &timer)) >= 0) {
+		strcpy(timer->name, "EMU10K1 timer");
+		timer->private_data = emu;
+		timer->hw = snd_emu10k1_timer_hw;
+	}
+	emu->timer = timer;
+	return err;
+}




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
