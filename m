From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH TINYCOMPRESS 11/14 v2] compress:
	Add	missing header includes
Date: Fri, 22 Feb 2013 16:08:01 +0000
Message-ID: <20130222160801.GK21174@opensource.wolfsonmicro.com>
References: <20130210001933.GK31139@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7BA8265DDD
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 17:08:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130210001933.GK31139@opensource.wolfsonmicro.com>
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

---
 compress.c |    1 +
 cplay.c    |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/compress.c b/compress.c
index 45b34d0..ebd28db 100644
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
