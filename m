From: Kristof vansant <de_lupus@pandora.be>
Subject: [PATCH] for vx make bug on kernel 2.6!!!! add to cvs plz
Date: Tue, 06 Jan 2004 23:53:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073429602.2670.14.camel@d51528079.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Before I added this line alsa-driver would have make error on vxp440.c
and vxpocket.c . This patch should keep the driver working with kernel
2.4 to. Can someone test it and add it to the CVS. 

[root@d51528079 vx]# cat vxkernel26.patch
--- ./vxp440.c.kernel26 2004-01-06 20:40:30.757564000 +0100
+++ ./vxp440.c  2004-01-06 20:44:50.167564000 +0100
@@ -1,11 +1,13 @@
 #include <linux/config.h>
 #include <linux/version.h>
  
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #if defined(CONFIG_MODVERSIONS) && !defined(__GENKSYMS__) &&
!defined(__DEPEND__)
 #define MODVERSIONS
 #include <linux/modversions.h>
 #include "sndversions.h"
 #endif
+#endif
  
 #include "config.h"
 #include "adriver.h"
--- ./vxpocket.c.kernel26       2004-01-06 23:41:09.047564000 +0100
+++ ./vxpocket.c        2004-01-06 23:43:34.537564000 +0100
@@ -1,11 +1,13 @@
 #include <linux/config.h>
 #include <linux/version.h>
  
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
 #if defined(CONFIG_MODVERSIONS) && !defined(__GENKSYMS__) &&
!defined(__DEPEND__)
 #define MODVERSIONS
 #include <linux/modversions.h>
 #include "sndversions.h"
 #endif
+#endif
  
 #include "config.h"
 #include "adriver.h"

-- 
lupus  (Kristof Vansant Belgium)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
