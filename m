From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/9] ASoC: remove unused #include
	<linux/version.h>
Date: Wed, 16 Sep 2009 21:05:45 +0800
Message-ID: <1253106345-332-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f196.google.com (mail-px0-f196.google.com
	[209.85.216.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 72EF01037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Sep 2009 15:06:12 +0200 (CEST)
Received: by pxi34 with SMTP id 34so3271074pxi.16
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2009 06:06:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove unused #include <linux/version.h>('s) in
  sound/soc/codecs/ad1836.c
  sound/soc/codecs/ad1938.c
  sound/soc/codecs/wm8974.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 sound/soc/codecs/ad1836.c |    1 -
 sound/soc/codecs/ad1938.c |    1 -
 sound/soc/codecs/wm8974.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 3612bb9..01343dc 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -18,7 +18,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index e62b277..9a049a1 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -28,7 +28,6 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <sound/core.h>
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index d8a013a..98d663a 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -12,7 +12,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
1.6.1.3
