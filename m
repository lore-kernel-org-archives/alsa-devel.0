From: Jaswinder Singh <jaswinder.singh@linaro.org>
Subject: [PATCH] ASoC: Samsung: Update email id of the author
Date: Sat, 25 Feb 2012 16:24:36 +0530
Message-ID: <1330167276-2913-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id CCBC724411
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 11:54:51 +0100 (CET)
Received: by pbcxa12 with SMTP id xa12so2120516pbc.38
	for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2012 02:54:49 -0800 (PST)
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
Cc: sbkim73@samsung.com, Jaswinder Singh <jassisinghbrar@gmail.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

I moved on from a great employer and the email-id no longer exists.
Update email-id to a personal one, assuming I don't move on from
myself anytime soon. And when I do, people don't get the eulogies
bounced.

Signed-off-by: Jaswinder Singh <jassisinghbrar@gmail.com>
---
 sound/soc/samsung/ac97.c        |    4 ++--
 sound/soc/samsung/i2s.c         |    4 ++--
 sound/soc/samsung/i2s.h         |    2 +-
 sound/soc/samsung/pcm.c         |    4 ++--
 sound/soc/samsung/smdk_wm8580.c |    4 ++--
 sound/soc/samsung/smdk_wm9713.c |    4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 7b9bf93..e8883d4d 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -4,7 +4,7 @@
  * 	Evolved from s3c2443-ac97.c
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd
- * 	Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *	Author: Jaswinder Singh <jassisinghbrar@gmail.com>
  * 	Credits: Graeme Gregory, Sean Choi
  *
  * This program is free software; you can redistribute it and/or modify
@@ -511,7 +511,7 @@ static struct platform_driver s3c_ac97_driver = {
 
 module_platform_driver(s3c_ac97_driver);
 
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:samsung-ac97");
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 87a874d..7ccb075 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -3,7 +3,7 @@
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
+ *	Jaswinder Singh <jassisinghbrar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -1143,7 +1143,7 @@ static struct platform_driver samsung_i2s_driver = {
 module_platform_driver(samsung_i2s_driver);
 
 /* Module information */
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("Samsung I2S Interface");
 MODULE_ALIAS("platform:samsung-i2s");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index 8e15f6a..d420a7c 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -3,7 +3,7 @@
  * ALSA SoC Audio Layer - Samsung I2S Controller driver
  *
  * Copyright (c) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassi.brar@samsung.com>
+ *	Jaswinder Singh <jassisinghbrar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 5678020..b7b2a1f 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -3,7 +3,7 @@
  * ALSA SoC Audio Layer - S3C PCM-Controller driver
  *
  * Copyright (c) 2009 Samsung Electronics Co. Ltd
- * Author: Jaswinder Singh <jassi.brar@samsung.com>
+ * Author: Jaswinder Singh <jassisinghbrar@gmail.com>
  * based upon I2S drivers by Ben Dooks.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -639,7 +639,7 @@ static struct platform_driver s3c_pcm_driver = {
 module_platform_driver(s3c_pcm_driver);
 
 /* Module information */
-MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
+MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("S3C PCM Controller Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:samsung-pcm");
diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index bff8758..ade2809 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -2,7 +2,7 @@
  *  smdk_wm8580.c
  *
  *  Copyright (c) 2009 Samsung Electronics Co. Ltd
- *  Author: Jaswinder Singh <jassi.brar@samsung.com>
+ *  Author: Jaswinder Singh <jassisinghbrar@gmail.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -253,6 +253,6 @@ static void __exit smdk_audio_exit(void)
 }
 module_exit(smdk_audio_exit);
 
-MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
+MODULE_AUTHOR("Jaswinder Singh, jassisinghbrar@gmail.com");
 MODULE_DESCRIPTION("ALSA SoC SMDK WM8580");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/smdk_wm9713.c b/sound/soc/samsung/smdk_wm9713.c
index 8e26a73..55b2ca7 100644
--- a/sound/soc/samsung/smdk_wm9713.c
+++ b/sound/soc/samsung/smdk_wm9713.c
@@ -2,7 +2,7 @@
  * smdk_wm9713.c  --  SoC audio for SMDK
  *
  * Copyright 2010 Samsung Electronics Co. Ltd.
- * Author: Jaswinder Singh Brar <jassi.brar@samsung.com>
+ * Author: Jaswinder Singh Brar <jassisinghbrar@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
@@ -103,6 +103,6 @@ module_init(smdk_init);
 module_exit(smdk_exit);
 
 /* Module information */
-MODULE_AUTHOR("Jaswinder Singh Brar, jassi.brar@samsung.com");
+MODULE_AUTHOR("Jaswinder Singh Brar, jassisinghbrar@gmail.com");
 MODULE_DESCRIPTION("ALSA SoC SMDK+WM9713");
 MODULE_LICENSE("GPL");
-- 
1.7.4.1
