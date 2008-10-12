From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: ALSA: ASoC codec: remove unused #include <version.h>
Date: Sun, 12 Oct 2008 23:12:56 +0800
Message-ID: <20081012231108.E7F2.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 85AA62433A
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Oct 2008 17:13:21 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so671839tid.8
	for <alsa-devel@alsa-project.org>; Sun, 12 Oct 2008 08:13:02 -0700 (PDT)
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
 sound/soc/codecs/ad1980.c
 sound/soc/codecs/wm8580.c
 sound/soc/codecs/wm8900.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 4e09c1f..1397b8e 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -13,7 +13,6 @@

 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index df1ffbe..a10edda 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -18,7 +18,6 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 0b8c6d3..3b326c9 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -18,7 +18,6 @@

 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
