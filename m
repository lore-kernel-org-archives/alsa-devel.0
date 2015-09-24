From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rl6347a: Clean up unneeded inclusion of
	header files
Date: Thu, 24 Sep 2015 23:34:01 +0800
Message-ID: <1443108841.21872.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 49484265AFC
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 17:34:08 +0200 (CEST)
Received: by pacgz1 with SMTP id gz1so9558915pac.3
 for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2015 08:34:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Also move the include of sound/hda_verbs.h to rl6347a.h because it is used
in rl6347a.h.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rl6347a.c | 19 +------------------
 sound/soc/codecs/rl6347a.h |  2 ++
 sound/soc/codecs/rt286.c   |  1 -
 sound/soc/codecs/rt298.c   |  1 -
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 91d5166..a4b910e 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -11,25 +11,8 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/dmi.h>
-#include <linux/acpi.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/initval.h>
-#include <sound/tlv.h>
-#include <sound/jack.h>
-#include <linux/workqueue.h>
-#include <sound/hda_verbs.h>
+#include <linux/regmap.h>
 
 #include "rl6347a.h"
 
diff --git a/sound/soc/codecs/rl6347a.h b/sound/soc/codecs/rl6347a.h
index 1cb56e5..e127919 100644
--- a/sound/soc/codecs/rl6347a.h
+++ b/sound/soc/codecs/rl6347a.h
@@ -12,6 +12,8 @@
 #ifndef __RL6347A_H__
 #define __RL6347A_H__
 
+#include <sound/hda_verbs.h>
+
 #define VERB_CMD(V, N, D) ((N << 20) | (V << 8) | D)
 
 #define RL6347A_VENDOR_REGISTERS	0x20
diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index bd93658..1fbdb4f 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -29,7 +29,6 @@
 #include <sound/jack.h>
 #include <linux/workqueue.h>
 #include <sound/rt286.h>
-#include <sound/hda_verbs.h>
 
 #include "rl6347a.h"
 #include "rt286.h"
diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 3c2f0f8..2a6c2ba 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -28,7 +28,6 @@
 #include <sound/jack.h>
 #include <linux/workqueue.h>
 #include <sound/rt298.h>
-#include <sound/hda_verbs.h>
 
 #include "rl6347a.h"
 #include "rt298.h"
-- 
2.1.4
