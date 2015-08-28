From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: ics43432: Fix module license
Date: Fri, 28 Aug 2015 11:23:05 +0800
Message-ID: <1440732185.24389.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DAF260469
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 05:23:10 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so47047107pab.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 20:23:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Ricard Wanderlof <ricardw@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/ics43432.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
index 4f202c1..382a004 100644
--- a/sound/soc/codecs/ics43432.c
+++ b/sound/soc/codecs/ics43432.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2015 Axis Communications AB
  *
- * Licensed under GPL2.
+ * Licensed under GPL v2.
  */
 
 #include <linux/module.h>
@@ -74,4 +74,4 @@ module_platform_driver(ics43432_driver);
 
 MODULE_DESCRIPTION("ASoC ICS43432 driver");
 MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.1.0
