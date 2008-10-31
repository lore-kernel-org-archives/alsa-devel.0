From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: ALSA: ASoC codec: remove unused #include <version.h>
Date: Fri, 31 Oct 2008 22:50:00 +0800
Message-ID: <20081031223910.0F26.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A5EA24574
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 15:50:04 +0100 (CET)
Received: by ti-out-0910.google.com with SMTP id j3so677197tid.8
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 07:50:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The file(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
  sound/soc/codecs/ad73311.c

This patch removes the said #include <version.h>.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 37af860..59c4c8f 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -15,7 +15,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <sound/core.h>
