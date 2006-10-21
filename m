From: Tobin Davis <tdavis@dsl-only.net>
Subject: Patch to fix build issues on Mandriva 2006
	(2.6.12-12mdk)
Date: Sat, 21 Oct 2006 12:47:48 -0700
Message-ID: <1161460068.26400.68.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ze/onxUXwAz9kVy1Fv/K"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-ze/onxUXwAz9kVy1Fv/K
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The patch to pcm_native.patch may need more fixing, but it works on my
system now.  Not sure when latency.h was introduced to the kernel.
These patches were needed for me to be able to test build my patches.
The HG repository has been broken since before 1.0.13 release (I just
never tested it until recently).

Changelog entry follows:

Summary:  Fix build issues
        
        This patch fixes build issues on older kernels.

Signed off by:
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-ze/onxUXwAz9kVy1Fv/K
Content-Disposition: attachment; filename=build-fix.patch
Content-Type: text/x-patch; name=build-fix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- a/acore/pcm_native.patch	Mon Oct 16 21:36:50 2006 +0200
+++ b/acore/pcm_native.patch	Sat Oct 21 12:36:41 2006 -0700
@@ -1,11 +1,23 @@
---- ../alsa-kernel/core/pcm_native.c	2006-10-04 11:55:09.000000000 +0200
-+++ pcm_native.c	2006-10-04 17:01:36.000000000 +0200
+--- ../alsa-kernel/core/pcm_native.c	2006-10-08 09:54:15.000000000 -0700
++++ pcm_native.c	2006-10-21 12:26:28.000000000 -0700
 @@ -1,3 +1,4 @@
 +#define __NO_VERSION__
  /*
   *  Digital Audio (PCM) abstract layer
   *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
-@@ -363,7 +364,10 @@ static int period_to_usecs(struct snd_pc
+@@ -25,7 +26,11 @@
+ #include <linux/file.h>
+ #include <linux/slab.h>
+ #include <linux/time.h>
++#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 18)
+ #include <linux/latency.h>
++#else
++#include <latency_compat.h>
++#endif
+ #include <linux/uio.h>
+ #include <sound/core.h>
+ #include <sound/control.h>
+@@ -363,7 +368,10 @@
  	return usecs;
  }
  
--- a/acore/sound.patch	Mon Oct 16 21:36:50 2006 +0200
+++ b/acore/sound.patch	Sat Oct 21 12:36:41 2006 -0700
@@ -1,16 +1,17 @@
---- ../alsa-kernel/core/sound.c	2006-09-29 15:42:47.000000000 +0200
-+++ sound.c	2006-09-29 15:43:57.000000000 +0200
-@@ -41,6 +41,9 @@
+--- ../alsa-kernel/core/sound.c	2006-10-08 09:54:15.000000000 -0700
++++ sound.c	2006-10-21 12:30:30.000000000 -0700
+@@ -41,6 +41,10 @@
  EXPORT_SYMBOL(snd_major);
  
  static int cards_limit = 1;
 +#ifdef CONFIG_DEVFS_FS
 +static int device_mode = S_IFCHR | S_IRUGO | S_IWUGO;
++static struct snd_minor *mptr;
 +#endif
  
  MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
  MODULE_DESCRIPTION("Advanced Linux Sound Architecture driver for soundcards.");
-@@ -49,6 +52,10 @@
+@@ -49,6 +53,10 @@
  MODULE_PARM_DESC(major, "Major # for sound driver.");
  module_param(cards_limit, int, 0444);
  MODULE_PARM_DESC(cards_limit, "Count of auto-loadable soundcards.");

--=-ze/onxUXwAz9kVy1Fv/K
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-ze/onxUXwAz9kVy1Fv/K
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-ze/onxUXwAz9kVy1Fv/K--
