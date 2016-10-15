From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/7] ASoC: wm9705: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 19:32:51 +0200
Message-ID: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CC5261740
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 19:33:08 +0200 (CEST)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. The last user of these defines was removed in commit
f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
remove the defines as well.

This also means the wm9705.h file no longer has any content and can be
removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9705.c   |  2 --
 sound/soc/codecs/wm9705.h   | 11 -----------
 sound/soc/pxa/e740_wm9705.c |  1 -
 sound/soc/pxa/e750_wm9705.c |  1 -
 4 files changed, 15 deletions(-)
 delete mode 100644 sound/soc/codecs/wm9705.h

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index dcdd055..266b6ec 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -20,8 +20,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
-#include "wm9705.h"
-
 #define WM9705_VENDOR_ID 0x574d4c05
 #define WM9705_VENDOR_ID_MASK 0xffffffff
 
diff --git a/sound/soc/codecs/wm9705.h b/sound/soc/codecs/wm9705.h
deleted file mode 100644
index 23ea9ce..0000000
--- a/sound/soc/codecs/wm9705.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * wm9705.h  --  WM9705 Soc Audio driver
- */
-
-#ifndef _WM9705_H
-#define _WM9705_H
-
-#define WM9705_DAI_AC97_HIFI	0
-#define WM9705_DAI_AC97_AUX	1
-
-#endif
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 1de8765..086c37a 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include "../codecs/wm9705.h"
 #include "pxa2xx-ac97.h"
 
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index b7eb7cd..7823278 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -22,7 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include "../codecs/wm9705.h"
 #include "pxa2xx-ac97.h"
 
 static int e750_spk_amp_event(struct snd_soc_dapm_widget *w,
-- 
2.1.4
