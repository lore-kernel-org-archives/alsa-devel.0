From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/10] ASoC: blackfin: Remove unused bf5xx-{i2s,
	tdm, ac97}-pcm.h
Date: Tue, 28 May 2013 19:22:09 +0200
Message-ID: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id D13A22610BA
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 19:22:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Scott Jiang <scott.jiang.linux@gmail.com>, Steven Miao <realmz6@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The structs defined in these files are completely unused, so remove both the
structs and the files.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |  1 -
 sound/soc/blackfin/bf5xx-ac97-pcm.h | 26 --------------------------
 sound/soc/blackfin/bf5xx-ad1836.c   |  1 -
 sound/soc/blackfin/bf5xx-ad193x.c   |  1 -
 sound/soc/blackfin/bf5xx-ad1980.c   |  1 -
 sound/soc/blackfin/bf5xx-ad73311.c  |  1 -
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |  1 -
 sound/soc/blackfin/bf5xx-i2s-pcm.h  | 26 --------------------------
 sound/soc/blackfin/bf5xx-ssm2602.c  |  1 -
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |  1 -
 sound/soc/blackfin/bf5xx-tdm-pcm.h  | 18 ------------------
 11 files changed, 78 deletions(-)
 delete mode 100644 sound/soc/blackfin/bf5xx-ac97-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s-pcm.h
 delete mode 100644 sound/soc/blackfin/bf5xx-tdm-pcm.h

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 7e2f360..53f8408 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -39,7 +39,6 @@
 
 #include <asm/dma.h>
 
-#include "bf5xx-ac97-pcm.h"
 #include "bf5xx-ac97.h"
 #include "bf5xx-sport.h"
 
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.h b/sound/soc/blackfin/bf5xx-ac97-pcm.h
deleted file mode 100644
index d324d58..0000000
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * linux/sound/arm/bf5xx-ac97-pcm.h -- ALSA PCM interface for the Blackfin
- *
- * Copyright 2007 Analog Device Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BF5XX_AC97_PCM_H
-#define _BF5XX_AC97_PCM_H
-
-struct bf5xx_pcm_dma_params {
-	char *name;			/* stream identifier */
-};
-
-struct bf5xx_gpio {
-	u32 sys;
-	u32 rx;
-	u32 tx;
-	u32 clk;
-	u32 frm;
-};
-
-#endif
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index d23f4b0..1528176 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -30,7 +30,6 @@
 
 #include "../codecs/ad1836.h"
 
-#include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 
 static struct snd_soc_card bf5xx_ad1836;
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index 0e55e9f..ce773b3 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -39,7 +39,6 @@
 
 #include "../codecs/ad193x.h"
 
-#include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 
 static struct snd_soc_card bf5xx_ad193x;
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index b30f88b..3450e8f 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -48,7 +48,6 @@
 
 #include "../codecs/ad1980.h"
 
-#include "bf5xx-ac97-pcm.h"
 #include "bf5xx-ac97.h"
 
 static struct snd_soc_card bf5xx_board;
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 61cc91d..786bbdd 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -45,7 +45,6 @@
 
 #include "../codecs/ad73311.h"
 #include "bf5xx-sport.h"
-#include "bf5xx-i2s-pcm.h"
 
 #if CONFIG_SND_BF5XX_SPORT_NUM == 0
 #define bfin_write_SPORT_TCR1	bfin_write_SPORT0_TCR1
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 262c1de..8726c3a 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -39,7 +39,6 @@
 
 #include <asm/dma.h>
 
-#include "bf5xx-i2s-pcm.h"
 #include "bf5xx-sport.h"
 
 static void bf5xx_dma_irq(void *data)
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.h b/sound/soc/blackfin/bf5xx-i2s-pcm.h
deleted file mode 100644
index 0c2c5a6..0000000
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * linux/sound/arm/bf5xx-i2s-pcm.h -- ALSA PCM interface for the Blackfin
- *
- * Copyright 2007 Analog Device Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BF5XX_I2S_PCM_H
-#define _BF5XX_I2S_PCM_H
-
-struct bf5xx_pcm_dma_params {
-	char *name;			/* stream identifier */
-};
-
-struct bf5xx_gpio {
-	u32 sys;
-	u32 rx;
-	u32 tx;
-	u32 clk;
-	u32 frm;
-};
-
-#endif
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 7dbeef1..9c19ccc 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -40,7 +40,6 @@
 #include <linux/gpio.h>
 #include "../codecs/ssm2602.h"
 #include "bf5xx-sport.h"
-#include "bf5xx-i2s-pcm.h"
 
 static struct snd_soc_card bf5xx_ssm2602;
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 19e855d..a6b5457 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -39,7 +39,6 @@
 
 #include <asm/dma.h>
 
-#include "bf5xx-tdm-pcm.h"
 #include "bf5xx-tdm.h"
 #include "bf5xx-sport.h"
 
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.h b/sound/soc/blackfin/bf5xx-tdm-pcm.h
deleted file mode 100644
index 7f8cc01..0000000
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * sound/soc/blackfin/bf5xx-tdm-pcm.h -- ALSA PCM interface for the Blackfin
- *
- * Copyright 2009 Analog Device Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BF5XX_TDM_PCM_H
-#define _BF5XX_TDM_PCM_H
-
-struct bf5xx_pcm_dma_params {
-	char *name;                     /* stream identifier */
-};
-
-#endif
-- 
1.8.0
