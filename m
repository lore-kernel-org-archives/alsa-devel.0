From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/5] ASoC: tpa6130a2: Update e-mail address
Date: Tue, 10 May 2011 09:01:07 +0300
Message-ID: <1305007270-6566-3-git-send-email-peter.ujfalusi@ti.com>
References: <1305007270-6566-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0E51038C9
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 08:01:17 +0200 (CEST)
In-Reply-To: <1305007270-6566-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/tpa6130a2-plat.h |    2 +-
 sound/soc/codecs/tpa6130a2.c   |    4 ++--
 sound/soc/codecs/tpa6130a2.h   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
index e29fde6..89beccb 100644
--- a/include/sound/tpa6130a2-plat.h
+++ b/include/sound/tpa6130a2-plat.h
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Nokia Corporation
  *
- * Written by Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 1f1ac81..239e0c4 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Nokia Corporation
  *
- * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -495,7 +495,7 @@ static void __exit tpa6130a2_exit(void)
 	i2c_del_driver(&tpa6130a2_i2c_driver);
 }
 
-MODULE_AUTHOR("Peter Ujfalusi");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_DESCRIPTION("TPA6130A2 Headphone amplifier driver");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 5df49c8..4174440 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Nokia Corporation
  *
- * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
-- 
1.7.5.rc3
