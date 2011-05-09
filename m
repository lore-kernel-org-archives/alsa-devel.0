From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] ASoC: tpa6130a2: Update e-mail address
Date: Mon, 9 May 2011 11:52:32 +0300
Message-ID: <1304931155-2987-3-git-send-email-peter.ujfalusi@ti.com>
References: <1304931155-2987-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id CEB1E103879
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 10:52:42 +0200 (CEST)
In-Reply-To: <1304931155-2987-1-git-send-email-peter.ujfalusi@ti.com>
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
---
 include/sound/tpa6130a2-plat.h |    3 ++-
 sound/soc/codecs/tpa6130a2.c   |    3 ++-
 sound/soc/codecs/tpa6130a2.h   |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
index e29fde6..6d35ca4 100644
--- a/include/sound/tpa6130a2-plat.h
+++ b/include/sound/tpa6130a2-plat.h
@@ -3,7 +3,8 @@
  *
  * Copyright (C) Nokia Corporation
  *
- * Written by Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Contact: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 1f1ac81..ddc84eb 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -4,6 +4,7 @@
  * Copyright (C) Nokia Corporation
  *
  * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Contact: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -495,7 +496,7 @@ static void __exit tpa6130a2_exit(void)
 	i2c_del_driver(&tpa6130a2_i2c_driver);
 }
 
-MODULE_AUTHOR("Peter Ujfalusi");
+MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
 MODULE_DESCRIPTION("TPA6130A2 Headphone amplifier driver");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/soc/codecs/tpa6130a2.h b/sound/soc/codecs/tpa6130a2.h
index 5df49c8..e704554 100644
--- a/sound/soc/codecs/tpa6130a2.h
+++ b/sound/soc/codecs/tpa6130a2.h
@@ -4,6 +4,7 @@
  * Copyright (C) Nokia Corporation
  *
  * Author: Peter Ujfalusi <peter.ujfalusi@nokia.com>
+ * Contact: Peter Ujfalusi <peter.ujfalusi@ti.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
-- 
1.7.5.rc3
