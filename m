From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [ALSA] remove unused #include <version.h>
Date: Sat, 23 Aug 2008 13:56:37 +0800
Message-ID: <20080823134332.1295.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 27F572459D
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Aug 2008 07:56:40 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so423926tid.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Aug 2008 22:56:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The file(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  sound/mips/au1x00.c
  sound/soc/at32/playpaq_wm8510.c
  sound/soc/at91/eti_b1_wm8731.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index ee0741f..fbef38a 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -38,7 +38,6 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
index 3f32621..fd2b2f3 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -22,7 +22,6 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/clk.h>
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index b081e83..b81d6b2 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -22,7 +22,6 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/timer.h>
