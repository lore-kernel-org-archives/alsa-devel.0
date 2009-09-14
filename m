From: pavel.hofman@ivitera.com
Subject: [PATCH 1/2] ak4113 build support
Date: Tue, 15 Sep 2009 00:48:10 +0200
Message-ID: <1252968491-31517-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>


Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/i2c/other/Makefile b/i2c/other/Makefile
index 37f1603..a86990e 100644
--- a/i2c/other/Makefile
+++ b/i2c/other/Makefile
@@ -5,7 +5,7 @@ endif
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
-export-objs += ak4xxx-adda.o ak4114.o ak4117.o pt2258.o tea575x-tuner.o
+export-objs += ak4xxx-adda.o ak4113.o ak4114.o ak4117.o pt2258.o tea575x-tuner.o
 
 include $(SND_TOPDIR)/alsa-kernel/i2c/other/Makefile
 
diff --git a/i2c/other/ak4113.c b/i2c/other/ak4113.c
new file mode 100644
index 0000000..41cb4ce
--- /dev/null
+++ b/i2c/other/ak4113.c
@@ -0,0 +1,2 @@
+#include "adriver.h"
+#include "../../alsa-kernel/i2c/other/ak4113.c"
diff --git a/utils/insert b/utils/insert
index af911d1..bfbbb83 100755
--- a/utils/insert
+++ b/utils/insert
@@ -395,6 +395,7 @@ case "$1" in
     #insert snd-i2c$SUFF
     #insert snd-cs8427$SUFF
     insert snd-ak4114$SUFF
+    insert snd-ak4113$SUFF
     insert snd-ak4xxx-adda$SUFF
     insert snd-ice17xx-ak4xxx$SUFF
     insert snd-ice1724$SUFF enable=1,1
-- 
1.5.6.3
