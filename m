From: domen@coderock.org
Subject: [patch 1/1] sound/emu8000: replace schedule_timeout() with msleep()
Date: Sat, 05 Mar 2005 16:37:03 +0100
Message-ID: <20050305153703.CE9AE1EE1E@trashy.coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 093A21A8
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2005 16:37:11 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org, domen@coderock.org, nacc@us.ibm.com
List-Id: alsa-devel@alsa-project.org




Use ssleep() instead of schedule_timeout() to guarantee the task
delays as expected. The current code uses TASK_INTERRUPTIBLE, but does not check
for signals / early return, so ssleep() should be appropriate. I am fairly
certain the time conversion is ok, as well.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/sound/isa/sb/emu8000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN sound/isa/sb/emu8000.c~ssleep-sound_isa_sb_emu8000 sound/isa/sb/emu8000.c
--- kj/sound/isa/sb/emu8000.c~ssleep-sound_isa_sb_emu8000	2005-03-05 16:11:20.000000000 +0100
+++ kj-domen/sound/isa/sb/emu8000.c	2005-03-05 16:11:20.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/emu8000.h>
 #include <sound/emu8000_reg.h>
@@ -355,8 +356,7 @@ init_arrays(emu8000_t *emu)
 {
 	send_array(emu, init1, ARRAY_SIZE(init1)/4);
 
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ * (44099 + 1024)) / 44100); /* wait for 1024 clocks */
+	msleep(1024 * 1000 / 44100); /* wait for 1024 clocks */
 	send_array(emu, init2, ARRAY_SIZE(init2)/4);
 	send_array(emu, init3, ARRAY_SIZE(init3)/4);
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
