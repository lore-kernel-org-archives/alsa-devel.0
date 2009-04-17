From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH] ASoC: OMAP: Update contact
	addresses
Date: Fri, 17 Apr 2009 14:42:26 +0300
Message-ID: <1239968546-24500-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 869FF10380E
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 13:41:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

My email address is going to expire soon so update it. Adding also
Peter Ujfalusi <peter.ujfalusi@nokia.com> as a second contact to OMAP core
drivers since I won't have anymore access to non-public OMAP documentation
in the future and Peter is working with these drivers as well.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/n810.c       |    4 ++--
 sound/soc/omap/omap-mcbsp.c |    5 +++--
 sound/soc/omap/omap-mcbsp.h |    3 ++-
 sound/soc/omap/omap-pcm.c   |    5 +++--
 sound/soc/omap/omap-pcm.h   |    3 ++-
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index e54e1c2..b60b1df 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) 2008 Nokia Corporation
  *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -416,6 +416,6 @@ static void __exit n810_soc_exit(void)
 module_init(n810_soc_init);
 module_exit(n810_soc_exit);
 
-MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_AUTHOR("Jarkko Nikula <jhnikula@gmail.com>");
 MODULE_DESCRIPTION("ALSA SoC Nokia N810");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 4d6ef0b..495192a 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2008 Nokia Corporation
  *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
+ *          Peter Ujfalusi <peter.ujfalusi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -546,6 +547,6 @@ static void __exit snd_omap_mcbsp_exit(void)
 }
 module_exit(snd_omap_mcbsp_exit);
 
-MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_AUTHOR("Jarkko Nikula <jhnikula@gmail.com>");
 MODULE_DESCRIPTION("OMAP I2S SoC Interface");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index df7ad13..c8147aa 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2008 Nokia Corporation
  *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
+ *          Peter Ujfalusi <peter.ujfalusi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 1bdbb04..07cf7f4 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2008 Nokia Corporation
  *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
+ *          Peter Ujfalusi <peter.ujfalusi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -367,6 +368,6 @@ static void __exit omap_soc_platform_exit(void)
 }
 module_exit(omap_soc_platform_exit);
 
-MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@nokia.com>");
+MODULE_AUTHOR("Jarkko Nikula <jhnikula@gmail.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
index e4369bd..8d9d269 100644
--- a/sound/soc/omap/omap-pcm.h
+++ b/sound/soc/omap/omap-pcm.h
@@ -3,7 +3,8 @@
  *
  * Copyright (C) 2008 Nokia Corporation
  *
- * Contact: Jarkko Nikula <jarkko.nikula@nokia.com>
+ * Contact: Jarkko Nikula <jhnikula@gmail.com>
+ *          Peter Ujfalusi <peter.ujfalusi@nokia.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
-- 
1.6.2.1
