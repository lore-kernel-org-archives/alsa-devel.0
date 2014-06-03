From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: rl6231: Remove unneeded inclusion of
	header files
Date: Tue, 03 Jun 2014 14:56:35 +0800
Message-ID: <1401778595.19083.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f176.google.com (mail-vc0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C41C2655C5
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 08:56:41 +0200 (CEST)
Received: by mail-vc0-f176.google.com with SMTP id la4so6222808vcb.7
 for <alsa-devel@alsa-project.org>; Mon, 02 Jun 2014 23:56:40 -0700 (PDT)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/rl6231.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 7b82fbe..56650d6 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -11,25 +11,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/pm.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/regmap.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/acpi.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <sound/initval.h>
-#include <sound/tlv.h>
 
 #include "rl6231.h"
 
-- 
1.8.3.2
