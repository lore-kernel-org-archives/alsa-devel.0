From: Gerhard Dirschl <gerhard.dirschl@gmx.de>
Subject: devfs trouble in latest cvs
Date: Fri, 9 May 2003 20:12:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030509181245.GA1617@euh11a303.stud.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

 Hi!

I'm running kernel version 2.4.21-rc1 on a dual-SMP machine with devfs.
I found some errors While tracking down a compile problem with the latest 
cvs code.

Typo in include/adriver.h
-devfs_handle_t snd_compat_devfs_mkdir(const char *dir);
-#define devfs_mk_dir snd_compat_devfs_mkdir
+devfs_handle_t snd_compat_devfs_mk_dir(const char *dir);
+#define devfs_mk_dir snd_compat_devfs_mk_dir

In acore/wrappers.c the placement of
#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 3, 0) ... #endif /* < 2.3.0 */
seems wrong. The following makes more sense to me.
@@ -30,6 +30,8 @@
 #endif
 }

+#endif /* < 2.3.0 */
+
 #if defined(CONFIG_DEVFS_FS)

 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 10)
@@ -79,5 +81,3 @@
 }

 #endif
-
-#endif /* < 2.3.0 */

There arte two different implementations of snd_compat_devfs_remove()
in acore/wrappers.c and acore/misc.c
The one in wrappers.c crashes my machine on driver unloading, the one in
misc.c works fine.

  ciao
     gerhard

-- 
Gerhard Dirschl
Karlsruhe
Germany


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
