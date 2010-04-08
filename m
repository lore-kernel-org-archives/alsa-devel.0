From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 10/16] ASoC: wm2000: remove unused #include
	<linux/version.h>
Date: Thu,  8 Apr 2010 19:50:08 +0800
Message-ID: <1270727408-1672-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 309B324389
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 13:50:17 +0200 (CEST)
Received: by qyk17 with SMTP id 17so23725qyk.9
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 04:50:14 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Huang Weiyi <weiyi.huang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove unused #include <linux/version.h>('s) in
  sound/soc/codecs/wm2000.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 sound/soc/codecs/wm2000.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index a34cbcf..002e289 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -23,7 +23,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/firmware.h>
-- 
1.6.1.3
