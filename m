From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] tumbler.c patch fails
Date: Tue, 3 Jan 2006 20:58:57 +0000
Message-ID: <20060103205857.6d06733d.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


patching file tumbler.c
Hunk #2 succeeded at 941 with fuzz 2 (offset 94 lines).
Hunk #3 FAILED at 994.
Hunk #4 succeeded at 1425 with fuzz 1 (offset 260 lines).
1 out of 4 hunks FAILED -- saving rejects to file tumbler.c.rej
make[1]: *** [tumbler.c] Error 1
make[1]: Leaving directory `/home/giu/soft/alsa/alsa-driver/ppc'
make: *** [dep] Error 1



This patch fixed tumbler.patch so it doesn't fail anymore. I'm not 100% sure
it's the right fix.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver/ppc/tumbler.patch__orig	2006-01-03 20:47:04.000000000 +0000
+++ alsa-driver/ppc/tumbler.patch	2006-01-03 20:49:32.000000000 +0000
@@ -1,11 +1,11 @@
---- ../alsa-kernel/ppc/tumbler.c	2004-08-16 12:48:40.285950840 +0200
-+++ tumbler.c	2004-08-16 12:51:36.742361538 +0200
+--- ../alsa-kernel/ppc/tumbler.c	2005-11-20 16:14:15.000000000 +0000
++++ tumbler.c	2006-01-03 20:38:54.000000000 +0000
 @@ -1,3 +1,4 @@
 +#define __NO_VERSION__
  /*
   * PMac Tumbler/Snapper lowlevel functions
   *
-@@ -846,7 +847,11 @@
+@@ -940,7 +941,11 @@ static void check_mute(struct snd_pmac *
  	}
  }
  
@@ -15,21 +15,21 @@
  static struct work_struct device_change;
 +#endif
  
- static void
- device_change_handler(void *self)
-@@ -895,7 +900,11 @@
- 
- 		/* finally we need to schedule an update of the mixer values
- 		   (master and DRC are enough for now) -ReneR */
+ static void device_change_handler(void *self)
+ {
+@@ -1009,7 +1014,11 @@ static void tumbler_update_automute(stru
+ 		mix = chip->mixer_data;
+ 		snd_assert(mix, return);
+ 		mix->auto_mute_notify = do_notify;
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 +		schedule_task(&device_change);
 +#else
  		schedule_work(&device_change);
 +#endif
- 
  	}
  }
-@@ -1156,7 +1165,11 @@
+ #endif /* PMAC_SUPPORT_AUTOMUTE */
+@@ -1416,7 +1425,11 @@ int __init snd_pmac_tumbler_init(struct 
  	chip->resume = tumbler_resume;
  #endif
  
@@ -40,4 +40,4 @@
 +#endif
  
  #ifdef PMAC_SUPPORT_AUTOMUTE
- 	if (mix->headphone_irq >=0 && (err = snd_pmac_add_automute(chip)) < 0)
+ 	if ((mix->headphone_irq >=0 || mix->lineout_irq >= 0)




--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
