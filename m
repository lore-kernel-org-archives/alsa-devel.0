From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] core/timer.c fixes
Date: Mon, 22 Jul 2002 10:30:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3BC2AF.9042C098@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The snd_timer_limit module parameter isn't used.

Leading zeros in the fractional part of the timer hardware resolution
are omitted.


Index: core/timer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/timer.c,v
retrieving revision 1.10
diff -u -r1.10 timer.c
--- core/timer.c	29 Apr 2002 13:51:35 -0000	1.10
+++ core/timer.c	22 Jul 2002 08:14:46 -0000
@@ -35,13 +35,10 @@
 #include <linux/kerneld.h>
 #endif
 
-int snd_timer_limit = 1;
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA timer interface");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
-MODULE_PARM(snd_timer_limit, "i");
-MODULE_PARM_DESC(snd_timer_limit, "Maximum global timers in system. (1 by default)");
 
 typedef struct {
 	snd_timer_instance_t *timeri;
@@ -876,7 +873,7 @@
 		}
 		snd_iprintf(buffer, "%s :", timer->name);
 		if (timer->hw.resolution)
-			snd_iprintf(buffer, " %lu.%luus (%lu ticks)", timer->hw.resolution / 1000, timer->hw.resolution % 1000,
timer->hw.ticks);
+			snd_iprintf(buffer, " %lu.%03luus (%lu ticks)", timer->hw.resolution / 1000, timer->hw.resolution % 1000,
timer->hw.ticks);
 		if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
 			snd_iprintf(buffer, " SLAVE");
 		snd_iprintf(buffer, "\n");


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
