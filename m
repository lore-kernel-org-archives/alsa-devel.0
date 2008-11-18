From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 17/17] ASoC: Move uda134x_codec.h to uda134x.h
Date: Tue, 18 Nov 2008 12:38:23 +0000
Message-ID: <1227011903-2825-17-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1227011903-2825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-13-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-14-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-15-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227011903-2825-16-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A6F7D10381F
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 13:38:28 +0100 (CET)
In-Reply-To: <1227011903-2825-16-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For consistency with other ASoC codec drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/uda134x.c          |    2 +-
 sound/soc/codecs/uda134x.h          |   36 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/uda134x_codec.h    |   36 -----------------------------------
 sound/soc/s3c24xx/s3c24xx_uda134x.c |    2 +-
 4 files changed, 38 insertions(+), 38 deletions(-)
 create mode 100644 sound/soc/codecs/uda134x.h
 delete mode 100644 sound/soc/codecs/uda134x_codec.h

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 04b30da..69ef521 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -24,7 +24,7 @@
 #include <sound/uda134x.h>
 #include <sound/l3.h>
 
-#include "uda134x_codec.h"
+#include "uda134x.h"
 
 
 #define POWER_OFF_ON_STANDBY 1
diff --git a/sound/soc/codecs/uda134x.h b/sound/soc/codecs/uda134x.h
new file mode 100644
index 0000000..94f4404
--- /dev/null
+++ b/sound/soc/codecs/uda134x.h
@@ -0,0 +1,36 @@
+#ifndef _UDA134X_CODEC_H
+#define _UDA134X_CODEC_H
+
+#define UDA134X_L3ADDR	5
+#define UDA134X_DATA0_ADDR	((UDA134X_L3ADDR << 2) | 0)
+#define UDA134X_DATA1_ADDR	((UDA134X_L3ADDR << 2) | 1)
+#define UDA134X_STATUS_ADDR	((UDA134X_L3ADDR << 2) | 2)
+
+#define UDA134X_EXTADDR_PREFIX	0xC0
+#define UDA134X_EXTDATA_PREFIX	0xE0
+
+/* UDA134X registers */
+#define UDA134X_EA000	0
+#define UDA134X_EA001	1
+#define UDA134X_EA010	2
+#define UDA134X_EA011	3
+#define UDA134X_EA100	4
+#define UDA134X_EA101	5
+#define UDA134X_EA110	6
+#define UDA134X_EA111	7
+#define UDA134X_STATUS0 8
+#define UDA134X_STATUS1 9
+#define UDA134X_DATA000 10
+#define UDA134X_DATA001 11
+#define UDA134X_DATA010 12
+#define UDA134X_DATA1	13
+
+#define UDA134X_REGS_NUM 14
+
+#define STATUS0_DAIFMT_MASK (~(7<<1))
+#define STATUS0_SYSCLK_MASK (~(3<<4))
+
+extern struct snd_soc_dai uda134x_dai;
+extern struct snd_soc_codec_device soc_codec_dev_uda134x;
+
+#endif
diff --git a/sound/soc/codecs/uda134x_codec.h b/sound/soc/codecs/uda134x_codec.h
deleted file mode 100644
index 94f4404..0000000
--- a/sound/soc/codecs/uda134x_codec.h
+++ /dev/null
@@ -1,36 +0,0 @@
-#ifndef _UDA134X_CODEC_H
-#define _UDA134X_CODEC_H
-
-#define UDA134X_L3ADDR	5
-#define UDA134X_DATA0_ADDR	((UDA134X_L3ADDR << 2) | 0)
-#define UDA134X_DATA1_ADDR	((UDA134X_L3ADDR << 2) | 1)
-#define UDA134X_STATUS_ADDR	((UDA134X_L3ADDR << 2) | 2)
-
-#define UDA134X_EXTADDR_PREFIX	0xC0
-#define UDA134X_EXTDATA_PREFIX	0xE0
-
-/* UDA134X registers */
-#define UDA134X_EA000	0
-#define UDA134X_EA001	1
-#define UDA134X_EA010	2
-#define UDA134X_EA011	3
-#define UDA134X_EA100	4
-#define UDA134X_EA101	5
-#define UDA134X_EA110	6
-#define UDA134X_EA111	7
-#define UDA134X_STATUS0 8
-#define UDA134X_STATUS1 9
-#define UDA134X_DATA000 10
-#define UDA134X_DATA001 11
-#define UDA134X_DATA010 12
-#define UDA134X_DATA1	13
-
-#define UDA134X_REGS_NUM 14
-
-#define STATUS0_DAIFMT_MASK (~(7<<1))
-#define STATUS0_SYSCLK_MASK (~(3<<4))
-
-extern struct snd_soc_dai uda134x_dai;
-extern struct snd_soc_codec_device soc_codec_dev_uda134x;
-
-#endif
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index 29a6813..487b010 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -26,7 +26,7 @@
 
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-i2s.h"
-#include "../codecs/uda134x_codec.h"
+#include "../codecs/uda134x.h"
 
 
 /* #define ENFORCE_RATES 1 */
-- 
1.5.6.5
