From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [PATCH 2/14] sound/ppc: fix-up sleeping paths
Date: Fri, 8 Jul 2005 17:04:05 -0700
Message-ID: <20050709000405.GE2596@us.ibm.com>
References: <20050709000324.GD2596@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.129])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 67655179
	for <alsa-devel@alsa-project.org>; Sat,  9 Jul 2005 02:04:09 +0200 (MEST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j69047eL323918
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 20:04:08 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j69047gJ409850
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:04:07 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j690474e021996
	for <alsa-devel@alsa-project.org>; Fri, 8 Jul 2005 18:04:07 -0600
Content-Disposition: inline
In-Reply-To: <20050709000324.GD2596@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Nishanth Aravamudan <nacc@us.ibm.com>

Jaroslav, I realize that you are not the explicit maintainer for any of
these drivers, but I figured you would at least be able to {N,}ACK the
changes. I didn't find any entry in MAINTAINERS for ppc-specific sound
drivers. If you would prefer split patches instead of the large
patchset, I can do that.

Description: Fix-up sleeping in sound/ppc. Replace big_mdelay() with
msleep() to guarantee the task delays as expected. This also involved
replacing/removing custom sleep functions.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 awacs.c   |    6 +++---
 pmac.h    |    5 -----
 tumbler.c |   16 ++++++++--------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff -urpN 2.6.13-rc2-kj/sound/ppc/awacs.c 2.6.13-rc2-kj-dev/sound/ppc/awacs.c
--- 2.6.13-rc2-kj/sound/ppc/awacs.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/ppc/awacs.c	2005-07-06 22:26:24.000000000 -0700
@@ -103,7 +103,7 @@ static void screamer_recalibrate(pmac_t 
 	snd_pmac_awacs_write_noreg(chip, 1, chip->awacs_reg[1]);
 	if (chip->manufacturer == 0x1)
 		/* delay for broken crystal part */
-		big_mdelay(750);
+		msleep(750);
 	snd_pmac_awacs_write_noreg(chip, 1,
 				   chip->awacs_reg[1] | MASK_RECALIBRATE | MASK_CMUTE | MASK_AMUTE);
 	snd_pmac_awacs_write_noreg(chip, 1, chip->awacs_reg[1]);
@@ -653,10 +653,10 @@ static void snd_pmac_awacs_resume(pmac_t
 {
 	if (machine_is_compatible("PowerBook3,1")
 	    || machine_is_compatible("PowerBook3,2")) {
-		big_mdelay(100);
+		msleep(100);
 		snd_pmac_awacs_write_reg(chip, 1,
 			chip->awacs_reg[1] & ~MASK_PAROUT);
-		big_mdelay(300);
+		msleep(300);
 	}
 
 	awacs_restore_all_regs(chip);
diff -urpN 2.6.13-rc2-kj/sound/ppc/pmac.h 2.6.13-rc2-kj-dev/sound/ppc/pmac.h
--- 2.6.13-rc2-kj/sound/ppc/pmac.h	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/ppc/pmac.h	2005-07-06 22:25:57.000000000 -0700
@@ -212,9 +212,4 @@ int snd_pmac_boolean_mono_info(snd_kcont
 
 int snd_pmac_add_automute(pmac_t *chip);
 
-#define big_mdelay(msec) do {\
-	set_current_state(TASK_UNINTERRUPTIBLE);\
-	schedule_timeout(((msec) * HZ + 999) / 1000);\
-} while (0)
-
 #endif /* __PMAC_H */
diff -urpN 2.6.13-rc2-kj/sound/ppc/tumbler.c 2.6.13-rc2-kj-dev/sound/ppc/tumbler.c
--- 2.6.13-rc2-kj/sound/ppc/tumbler.c	2005-07-06 07:57:20.000000000 -0700
+++ 2.6.13-rc2-kj-dev/sound/ppc/tumbler.c	2005-07-06 22:26:47.000000000 -0700
@@ -945,7 +945,7 @@ static void device_change_handler(void *
 			check_mute(chip, &mix->line_mute, 0, mix->auto_mute_notify,
 				   chip->lineout_sw_ctl);
 		if (mix->anded_reset)
-			big_mdelay(10);
+			msleep(10);
 		check_mute(chip, &mix->amp_mute, 1, mix->auto_mute_notify,
 			   chip->speaker_sw_ctl);
 		mix->drc_enable = 0;
@@ -954,7 +954,7 @@ static void device_change_handler(void *
 		check_mute(chip, &mix->amp_mute, 0, mix->auto_mute_notify,
 			   chip->speaker_sw_ctl);
 		if (mix->anded_reset)
-			big_mdelay(10);
+			msleep(10);
 		check_mute(chip, &mix->hp_mute, 1, mix->auto_mute_notify,
 			   chip->master_sw_ctl);
 		if (mix->line_mute.addr != 0)
@@ -1109,22 +1109,22 @@ static void tumbler_reset_audio(pmac_t *
 		DBG("(I) codec anded reset !\n");
 		write_audio_gpio(&mix->hp_mute, 0);
 		write_audio_gpio(&mix->amp_mute, 0);
-		big_mdelay(200);
+		msleep(200);
 		write_audio_gpio(&mix->hp_mute, 1);
 		write_audio_gpio(&mix->amp_mute, 1);
-		big_mdelay(100);
+		msleep(100);
 		write_audio_gpio(&mix->hp_mute, 0);
 		write_audio_gpio(&mix->amp_mute, 0);
-		big_mdelay(100);
+		msleep(100);
 	} else {
 		DBG("(I) codec normal reset !\n");
 
 		write_audio_gpio(&mix->audio_reset, 0);
-		big_mdelay(200);
+		msleep(200);
 		write_audio_gpio(&mix->audio_reset, 1);
-		big_mdelay(100);
+		msleep(100);
 		write_audio_gpio(&mix->audio_reset, 0);
-		big_mdelay(100);
+		msleep(100);
 	}
 }


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
