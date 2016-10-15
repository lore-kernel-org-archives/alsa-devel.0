From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] ASoC: wm9712: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 19:32:52 +0200
Message-ID: <1476552777-1849-2-git-send-email-lars@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A64EB261B03
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 19:33:08 +0200 (CEST)
In-Reply-To: <1476552777-1849-1-git-send-email-lars@metafoo.de>
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

This also means the wm9712.h file no longer has any content and can be
removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9712.c   |  1 -
 sound/soc/codecs/wm9712.h   | 11 -----------
 sound/soc/pxa/e800_wm9712.c |  1 -
 sound/soc/pxa/em-x270.c     |  1 -
 sound/soc/pxa/palm27x.c     |  1 -
 sound/soc/pxa/tosa.c        |  1 -
 6 files changed, 16 deletions(-)
 delete mode 100644 sound/soc/codecs/wm9712.h

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 557709e..034879e 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -21,7 +21,6 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
-#include "wm9712.h"
 
 #define WM9712_VENDOR_ID 0x574d4c12
 #define WM9712_VENDOR_ID_MASK 0xffffffff
diff --git a/sound/soc/codecs/wm9712.h b/sound/soc/codecs/wm9712.h
deleted file mode 100644
index fb69c3a..0000000
--- a/sound/soc/codecs/wm9712.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * wm9712.h  --  WM9712 Soc Audio driver
- */
-
-#ifndef _WM9712_H
-#define _WM9712_H
-
-#define WM9712_DAI_AC97_HIFI	0
-#define WM9712_DAI_AC97_AUX		1
-
-#endif
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 41bf714..07b9c6e 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -21,7 +21,6 @@
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
 
-#include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
 
 static int e800_spk_amp_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/pxa/em-x270.c b/sound/soc/pxa/em-x270.c
index 64743a0..966163d 100644
--- a/sound/soc/pxa/em-x270.c
+++ b/sound/soc/pxa/em-x270.c
@@ -30,7 +30,6 @@
 #include <asm/mach-types.h>
 #include <mach/audio.h>
 
-#include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
 
 static struct snd_soc_dai_link em_x270_dai[] = {
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index bcc81e9..387492d 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -27,7 +27,6 @@
 #include <mach/audio.h>
 #include <linux/platform_data/asoc-palm27x.h>
 
-#include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
 
 static struct snd_soc_jack hs_jack;
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index c508f02..daed981 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -31,7 +31,6 @@
 #include <mach/tosa.h>
 #include <mach/audio.h>
 
-#include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
 
 #define TOSA_HP        0
-- 
2.1.4
