From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] No devfs_find_and_unregister in Linux 2.4.x
Date: Thu, 26 Sep 2002 11:33:29 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209261120570.9725-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

The last change to alsa-kernel/core/sound.c doesn't work with 
Linux 2.4.20-pre8 with devfs support enabled:

# depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.20-pre8/kernel/sound/acore/snd.o
depmod:         devfs_find_and_unregister

There is no "devfs_find_and_unregister" in the sources of Linux 
2.4.20-pre8.  Maybe that patch was meant for Linux 2.5.x?

The revision of alsa-kernel/core/sound.c that introduces 
devfs_find_and_unregister is 1.22:

revision 1.22
date: 2002/09/26 12:56:09;  author: perex;  state: Exp;  lines: +2 -2
Sync with the kernel tree

This patch restores the old code for 2.4.x kernels (tested and known to
work with my kernel only):

=================================
--- sound.c
+++ sound.c
@@ -367,6 +367,9 @@ static void __exit alsa_sound_exit(void)
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
 		master = devfs_find_handle(NULL, controlname, strlen(controlname), 0, 0, DEVFS_SPECIAL_CHR, 0);
 		devfs_unregister(master);
+#elif LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
+		master = devfs_find_handle(NULL, controlname, 0, 0, DEVFS_SPECIAL_CHR, 0);
+		devfs_unregister(master);
 #else
 		devfs_find_and_unregister(NULL, controlname, 0, 0, DEVFS_SPECIAL_CHR, 0);
 #endif
=================================

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
