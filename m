From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [SOUND/SOC] removed unused #include <version.h>
Date: Sun, 17 Aug 2008 07:51:15 +0800
Message-ID: <20080817072047.162D.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 78D5624353
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Aug 2008 01:51:27 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so603825tid.8
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 16:51:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The files below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  sound/soc/codecs/wm8753.c
  sound/soc/codecs/wm9712.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 8604809..dc7b18f 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -34,7 +34,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 1fb7f9a..2f1c91b 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -13,7 +13,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <sound/core.h>
