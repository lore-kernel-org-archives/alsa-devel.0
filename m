From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]removes unneeded spin_lock_irqsave()s from snd-es1968
Date: Wed, 3 Nov 2004 00:50:43 +0100
Message-ID: <200411030050.43287.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T1BiBogxHSa0a+E"
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_T1BiBogxHSa0a+E
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Found this while testing Ingo Molnars realtime patches for 2.6.9.
Without the patch on a realtime enabled kernel, insmod gets stuck and never returns.
Please check the assumptions made below and correct me, if I'm wrong ;-)

Karsten

=======================================================
Summary: removes unneeded spin_lock_irqsave()s from snd-es1968

spin_lock_irqsave(&chip->reg_lock) was called a second time in sequence from
snd_es1968_bob_start() called from es1968_measure_clock().
While this didn't cause harm on my UP laptop with mainline kernels,
it made "insmod snd-es1968" hang on kernel 2.6.9-mm1-RT-V0.6.9.
The patch assumes that 2 callpaths don't need explicit spinlock protection:
1: The trigger callback, because it is called with IRQs disabled.
2. PM's suspend/resume callbacks, because  those are called while ortdinary user processes are frozen.
Thus the spin_lock_irqsave(&chip->reg_lock)  calls in snd_es1968_bob_start() / snd_es1968_bob_stop()
 are not needed.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
=======================================================

--Boundary-00=_T1BiBogxHSa0a+E
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-es1968.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-es1968.patch"

--- sound/pci/es1968.c~	2004-11-02 23:51:56.504888304 +0100
+++ sound/pci/es1968.c	2004-11-02 23:51:12.375596976 +0100
@@ -837,23 +837,19 @@
 static void snd_es1968_bob_stop(es1968_t *chip)
 {
 	u16 reg;
-	unsigned long flags;
 
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	reg = __maestro_read(chip, 0x11);
 	reg &= ~ESM_BOB_ENABLE;
 	__maestro_write(chip, 0x11, reg);
 	reg = __maestro_read(chip, 0x17);
 	reg &= ~ESM_BOB_START;
 	__maestro_write(chip, 0x17, reg);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 static void snd_es1968_bob_start(es1968_t *chip)
 {
 	int prescale;
 	int divide;
-	unsigned long flags;
 
 	/* compute ideal interrupt frequency for buffer size & play rate */
 	/* first, find best prescaler value to match freq */
@@ -882,13 +878,11 @@
 	} else if (divide > 1)
 		divide--;
 
-	spin_lock_irqsave(&chip->reg_lock, flags);
 	__maestro_write(chip, 6, 0x9000 | (prescale << 5) | divide);	/* set reg */
 
 	/* Now set IDR 11/17 */
 	__maestro_write(chip, 0x11, __maestro_read(chip, 0x11) | 1);
 	__maestro_write(chip, 0x17, __maestro_read(chip, 0x17) | 1);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
 /* call with substream spinlock */

--Boundary-00=_T1BiBogxHSa0a+E--


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
