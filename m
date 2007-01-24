From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] tumbler.patch
Date: Thu, 25 Jan 2007 00:33:39 +0100
Message-ID: <20070125003339.26799dc8.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


The tumbler driver doesn't compile. This patch patches the patch.
(I tested it on 2.6 kernel only)


Signed-off-by Giuliano Pochini <pochini@shiny.it>

--- alsa-driver/ppc/tumbler.patch__orig	2007-01-24 23:45:45.000000000 +0100
+++ alsa-driver/ppc/tumbler.patch	2007-01-24 23:46:08.000000000 +0100
@@ -1,11 +1,11 @@
---- ../alsa-kernel/ppc/tumbler.c	2005-11-17 16:33:55.000000000 +0100
-+++ tumbler.c	2006-01-04 13:07:30.000000000 +0100
+--- ../alsa-kernel/ppc/tumbler.c	2007-01-24 22:55:13.000000000 +0100
++++ tumbler.c	2007-01-24 23:40:51.000000000 +0100
 @@ -1,3 +1,4 @@
 +#define __NO_VERSION__
  /*
   * PMac Tumbler/Snapper lowlevel functions
   *
-@@ -940,7 +941,11 @@
+@@ -941,7 +942,11 @@ static void check_mute(struct snd_pmac *
  	}
  }
  
@@ -14,10 +14,10 @@
 +#else
  static struct work_struct device_change;
 +#endif
+ static struct snd_pmac *device_change_chip;
  
- static void device_change_handler(void *self)
- {
-@@ -1009,7 +1014,11 @@
+ static void device_change_handler(struct work_struct *work)
+@@ -1011,7 +1016,11 @@ static void tumbler_update_automute(stru
  		mix = chip->mixer_data;
  		snd_assert(mix, return);
  		mix->auto_mute_notify = do_notify;
@@ -29,15 +29,15 @@
  	}
  }
  #endif /* PMAC_SUPPORT_AUTOMUTE */
-@@ -1416,7 +1425,11 @@
+@@ -1418,7 +1427,11 @@ int __init snd_pmac_tumbler_init(struct 
  	chip->resume = tumbler_resume;
  #endif
  
 +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 +	INIT_TQUEUE(&device_change, device_change_handler, (void *)chip);
 +#else
- 	INIT_WORK(&device_change, device_change_handler, (void *)chip);
+ 	INIT_WORK(&device_change, device_change_handler);
 +#endif
+ 	device_change_chip = chip;
  
  #ifdef PMAC_SUPPORT_AUTOMUTE
- 	if ((mix->headphone_irq >=0 || mix->lineout_irq >= 0)


--
Giuliano.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
