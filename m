From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 1/2] ASoC: pcm3060: Improve stylistics of file comments
Date: Tue, 28 Aug 2018 23:42:30 +0200
Message-ID: <20180828214231.10164-1-kmarinushkin@birdec.tech>
References: <20180828194045.GQ2414@sirena.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828194045.GQ2414@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Kevin Cernekee <cernekee@chromium.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Modified the complete file comments in C++ style, to make them look more
intentional

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm3060-i2c.c | 9 ++++-----
 sound/soc/codecs/pcm3060-spi.c | 9 ++++-----
 sound/soc/codecs/pcm3060.c     | 9 ++++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/pcm3060-i2c.c b/sound/soc/codecs/pcm3060-i2c.c
index 03d2b4323626..cdc8314882bc 100644
--- a/sound/soc/codecs/pcm3060-i2c.c
+++ b/sound/soc/codecs/pcm3060-i2c.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 I2C driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 I2C driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/i2c.h>
 #include <linux/module.h>
diff --git a/sound/soc/codecs/pcm3060-spi.c b/sound/soc/codecs/pcm3060-spi.c
index 8961e095ae73..f6f19fa80932 100644
--- a/sound/soc/codecs/pcm3060-spi.c
+++ b/sound/soc/codecs/pcm3060-spi.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 SPI driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 SPI driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index ef7c627c9ac5..5b9718fa766d 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -1,9 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * PCM3060 codec driver
- *
- * Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
- */
+//
+// PCM3060 codec driver
+//
+// Copyright (C) 2018 Kirill Marinushkin <kmarinushkin@birdec.tech>
 
 #include <linux/module.h>
 #include <sound/pcm_params.h>
-- 
2.13.6
