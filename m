From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/14] ASoC: ad1980: Remove unused header
Date: Thu, 30 Oct 2014 21:00:58 +0100
Message-ID: <1414699271-22797-2-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id A1470260701
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:15 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The constants defined in the ad1980 header are not used. So remove the file.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ad1980.c |  2 --
 sound/soc/codecs/ad1980.c         |  2 --
 sound/soc/codecs/ad1980.h         | 26 --------------------------
 3 files changed, 30 deletions(-)
 delete mode 100644 sound/soc/codecs/ad1980.h

diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index 3450e8f..0fa81a5 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -46,8 +46,6 @@
 #include <linux/gpio.h>
 #include <asm/portmux.h>
 
-#include "../codecs/ad1980.h"
-
 #include "bf5xx-ac97.h"
 
 static struct snd_soc_card bf5xx_board;
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 304d300..cc28dba 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -30,8 +30,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include "ad1980.h"
-
 /*
  * AD1980 register cache
  */
diff --git a/sound/soc/codecs/ad1980.h b/sound/soc/codecs/ad1980.h
deleted file mode 100644
index eb0af44..0000000
--- a/sound/soc/codecs/ad1980.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * ad1980.h  --  ad1980 Soc Audio driver
- *
- * WARNING:
- *
- * Because Analog Devices Inc. discontinued the ad1980 sound chip since
- * Sep. 2009, this ad1980 driver is not maintained, tested and supported
- * by ADI now.
- */
-
-#ifndef _AD1980_H
-#define _AD1980_H
-/* Bit definition of Power-Down Control/Status Register */
-#define ADC		0x0001
-#define DAC		0x0002
-#define ANL		0x0004
-#define REF		0x0008
-#define PR0		0x0100
-#define PR1		0x0200
-#define PR2		0x0400
-#define PR3		0x0800
-#define PR4		0x1000
-#define PR5		0x2000
-#define PR6		0x4000
-
-#endif
-- 
1.8.0
