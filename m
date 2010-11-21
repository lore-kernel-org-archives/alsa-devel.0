From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/4] ASoC: Do not include soc-dai.h
Date: Sun, 21 Nov 2010 19:48:46 +0200
Message-ID: <1290361727-25162-3-git-send-email-jhnikula@gmail.com>
References: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E0F78103838
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 18:49:00 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 24so3507424eyg.38
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 09:49:00 -0800 (PST)
In-Reply-To: <1290361727-25162-1-git-send-email-jhnikula@gmail.com>
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

There is no need to include soc-dai.h since soc.h includes it. Convert
drivers to include only soc.h.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/cq93vc.c |    1 -
 sound/soc/codecs/wl1273.c |    2 +-
 sound/soc/sh/siu.h        |    2 +-
 sound/soc/sh/siu_dai.c    |    2 +-
 sound/soc/sh/siu_pcm.c    |    2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 1a6f511..46dbfd0 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -36,7 +36,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <sound/soc-dai.h>
 #include <sound/initval.h>
 
 #include <mach/dm365.h>
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index c606b3e..d3ffa2f 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -25,7 +25,7 @@
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc-dai.h>
+#include <sound/soc.h>
 #include <sound/initval.h>
 
 #include "wl1273.h"
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 9f4dcb9..83c3430 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -75,7 +75,7 @@ struct siu_firmware {
 
 #include <sound/core.h>
 #include <sound/pcm.h>
-#include <sound/soc-dai.h>
+#include <sound/soc.h>
 
 #define SIU_PERIOD_BYTES_MAX	8192		/* DMA transfer/period size */
 #define SIU_PERIOD_BYTES_MIN	256		/* DMA transfer/period size */
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index af53b64..4973c29 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -28,7 +28,7 @@
 #include <asm/siu.h>
 
 #include <sound/control.h>
-#include <sound/soc-dai.h>
+#include <sound/soc.h>
 
 #include "siu.h"
 
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index ed29c9e..a423bab 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -29,7 +29,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <sound/soc-dai.h>
+#include <sound/soc.h>
 
 #include <asm/siu.h>
 
-- 
1.7.0.4
