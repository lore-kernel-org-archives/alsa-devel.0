From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: stac9766: Move register defines to
	main source file
Date: Fri,  4 Nov 2016 18:26:55 +0100
Message-ID: <1478280417-24832-3-git-send-email-lars@metafoo.de>
References: <1478280417-24832-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A53DA2674DD
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 18:27:13 +0100 (CET)
In-Reply-To: <1478280417-24832-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The stac9766 driver has a header file that defines 3 register locations.
Move these to the main source file since it is not really worth it having a
separate file for them. The header file is now empty and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/stac9766.c        |  6 ++++--
 sound/soc/codecs/stac9766.h        | 12 ------------
 sound/soc/fsl/efika-audio-fabric.c |  1 -
 3 files changed, 4 insertions(+), 15 deletions(-)
 delete mode 100644 sound/soc/codecs/stac9766.h

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index e54e4a4..f675d34 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -26,11 +26,13 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
-#include "stac9766.h"
-
 #define STAC9766_VENDOR_ID 0x83847666
 #define STAC9766_VENDOR_ID_MASK 0xffffffff
 
+#define AC97_STAC_DA_CONTROL 0x6A
+#define AC97_STAC_ANALOG_SPECIAL 0x6E
+#define AC97_STAC_STEREO_MIC 0x78
+
 /*
  * STAC9766 register cache
  */
diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
deleted file mode 100644
index e35cee8..0000000
--- a/sound/soc/codecs/stac9766.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * stac9766.h  --  STAC9766 Soc Audio driver
- */
-
-#ifndef _STAC9766_H
-#define _STAC9766_H
-
-#define AC97_STAC_DA_CONTROL 0x6A
-#define AC97_STAC_ANALOG_SPECIAL 0x6E
-#define AC97_STAC_STEREO_MIC 0x78
-
-#endif
diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index b2acd329..f200d1c 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -27,7 +27,6 @@
 
 #include "mpc5200_dma.h"
 #include "mpc5200_psc_ac97.h"
-#include "../codecs/stac9766.h"
 
 #define DRV_NAME "efika-audio-fabric"
 
-- 
2.1.4
