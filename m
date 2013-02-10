From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH TINYCOMPRESS 11/14] compress: Add missing
	header includes
Date: Sun, 10 Feb 2013 00:19:33 +0000
Message-ID: <20130210001933.GK31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 726672616A0
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2013 01:19:35 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This fixes build problems caused by dependencies that were
not explicitly included.

diff --git a/compress.c b/compress.c
index 7ee287d..34936bd 100644
--- a/compress.c
+++ b/compress.c
@@ -66,6 +66,7 @@
 #include <sys/time.h>
 #include <limits.h>
 
+#include <linux/types.h>
 #include <linux/ioctl.h>
 #define __force
 #define __bitwise
diff --git a/cplay.c b/cplay.c
index d2a968c..3af6d13 100644
--- a/cplay.c
+++ b/cplay.c
@@ -51,6 +51,8 @@
  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
+#include <stdint.h>
+#include <linux/types.h>
 #include <fcntl.h>
 #include <errno.h>
 #include <unistd.h>
@@ -60,6 +62,7 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <getopt.h>
+#include <sys/time.h>
 #define __force
 #define __bitwise
 #define __user
-- 
1.7.2.5
