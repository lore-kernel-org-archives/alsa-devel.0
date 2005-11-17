From: Guido Guenther <agx@sigxcpu.org>
Subject: [patch] PowerBook 6,1: headphone not detected after suspend in snd_powerpc
Date: Thu, 17 Nov 2005 10:22:05 +0100
Message-ID: <20051117092205.GA5893@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de [134.34.140.224])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4435B1C5
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2005 10:45:28 +0100 (MET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
ever since suspend to disk works I had the problem that headphone
(un)plugging doesn't get detected properly anymore after the first
resume.
Reloading the module worked around this ever since, however the real
cause of the problem was that after a resume the driver only got
interrupts on "unplug" not on "plug". Reactivating the headphone status
interrupt in tumbler_resume fixes this. This shouldn't cause
any trouble with software suspend.

--- orig/linux-2.6.14/sound/ppc/tumbler.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.14/sound/ppc/tumbler.c	2005-11-14 12:01:13.000000000 +0100
@@ -1194,8 +1195,14 @@
 	tumbler_set_master_volume(mix);
 	if (chip->update_automute)
 		chip->update_automute(chip, 0);
-	if (mix->headphone_irq >= 0)
+	if (mix->headphone_irq >= 0) {
+		unsigned char val;
+
 		enable_irq(mix->headphone_irq);
+		/* activate headphone status interrupts */
+		val = do_gpio_read(&mix->hp_detect);
+		do_gpio_write(&mix->hp_detect, val | 0x80);
+	}
 	if (mix->lineout_irq >= 0)
 		enable_irq(mix->lineout_irq);
 }

Signed-off-by: Guido Guenther <agx@sigxcpu.org>

Cheers,
 -- Guido


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
