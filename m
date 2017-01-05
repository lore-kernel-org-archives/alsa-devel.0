From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: pxa2xx-ac97: Remove unused DAI ID defines
Date: Thu,  5 Jan 2017 13:07:27 +0100
Message-ID: <1483618047-22545-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id CF10A266646
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 13:07:33 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used instead and the defines are
unused. The last user of these defines was removed in commit f0fba2ad1b6b
("ASoC: multi-component - ASoC Multi-Component Support"). So remove the
defines as well.

This also means the pxa2xx-ac97.h file no longer has any content and can be
removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr> (for mioa701_wm9713)
---
 sound/soc/pxa/e740_wm9705.c    |  3 ---
 sound/soc/pxa/e750_wm9705.c    |  2 --
 sound/soc/pxa/e800_wm9712.c    |  2 --
 sound/soc/pxa/em-x270.c        |  2 --
 sound/soc/pxa/mioa701_wm9713.c |  1 -
 sound/soc/pxa/palm27x.c        |  2 --
 sound/soc/pxa/pxa2xx-ac97.c    |  2 --
 sound/soc/pxa/pxa2xx-ac97.h    | 17 -----------------
 sound/soc/pxa/tosa.c           |  2 --
 sound/soc/pxa/zylonite.c       |  1 -
 10 files changed, 34 deletions(-)
 delete mode 100644 sound/soc/pxa/pxa2xx-ac97.h

diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 086c37a..8ab7032 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -22,9 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include "pxa2xx-ac97.h"
-
-
 #define E740_AUDIO_OUT 1
 #define E740_AUDIO_IN  2
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 7823278..fdcd94a 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -22,8 +22,6 @@
 
 #include <asm/mach-types.h>
 
-#include "pxa2xx-ac97.h"
-
 static int e750_spk_amp_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 07b9c6e..2df714f 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -21,8 +21,6 @@
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
 
-#include "pxa2xx-ac97.h"
-
 static int e800_spk_amp_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 966163d..6f2020f 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -30,8 +30,6 @@
 #include <asm/mach-types.h>
 #include <mach/audio.h>
 
-#include "pxa2xx-ac97.h"
-
 static struct snd_soc_dai_link em_x270_dai[] = {
 	{
 		.name = "AC97",
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 0fe0abe..8760a66 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -53,7 +53,6 @@
 #include <sound/initval.h>
 #include <sound/ac97_codec.h>
 
-#include "pxa2xx-ac97.h"
 #include "../codecs/wm9713.h"
 
 #define AC97_GPIO_PULL		0x58
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 387492d..9716704 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -27,8 +27,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/asoc-palm27x.h>
 
-#include "pxa2xx-ac97.h"
-
 static struct snd_soc_jack hs_jack;
 
 /* Headphones jack detection DAPM pins */
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 9615e6d..2e2fb18 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -27,8 +27,6 @@
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-#include "pxa2xx-ac97.h"
-
 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
 	pxa2xx_ac97_try_warm_reset(ac97);
diff --git a/sound/soc/pxa/pxa2xx-ac97.h b/sound/soc/pxa/pxa2xx-ac97.h
deleted file mode 100644
index a49c21b..0000000
--- a/sound/soc/pxa/pxa2xx-ac97.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * linux/sound/soc/pxa/pxa2xx-ac97.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _PXA2XX_AC97_H
-#define _PXA2XX_AC97_H
-
-/* pxa2xx DAI ID's */
-#define PXA2XX_DAI_AC97_HIFI	0
-#define PXA2XX_DAI_AC97_AUX		1
-#define PXA2XX_DAI_AC97_MIC		2
-
-#endif
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 2e312c6..e022b2a 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -31,8 +31,6 @@
 #include <mach/tosa.h>
 #include <mach/audio.h>
 
-#include "pxa2xx-ac97.h"
-
 #define TOSA_HP        0
 #define TOSA_MIC_INT   1
 #define TOSA_HEADSET   2
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index 8f301c7..6fbcdf0 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -22,7 +22,6 @@
 #include <sound/soc.h>
 
 #include "../codecs/wm9713.h"
-#include "pxa2xx-ac97.h"
 #include "pxa-ssp.h"
 
 /*
-- 
2.1.4
