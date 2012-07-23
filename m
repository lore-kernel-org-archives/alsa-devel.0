From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: isabelle: Remove version.h header
	file inclusion
Date: Mon, 23 Jul 2012 17:25:15 +0530
Message-ID: <1343044515-5212-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id CF534265243
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 13:56:01 +0200 (CEST)
Received: by yenr13 with SMTP id r13so5090151yen.38
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 04:56:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, mr.swami.reddy@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

version.h header file inclusion is no longer needed for this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/isabelle.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index 5d8f39e..1bf5560 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -13,7 +13,6 @@
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
1.7.4.1
