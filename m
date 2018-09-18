From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] sound: soc: rt5677-spi: Drop unused GPIO
	include
Date: Tue, 18 Sep 2018 12:11:57 -0700
Message-ID: <20180918191157.16996-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C3D926788E
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 21:12:03 +0200 (CEST)
Received: by mail-pg1-f193.google.com with SMTP id r1-v6so1483910pgp.11
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2018 12:12:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

This SPI driver does not use the legacy GPIO header so
just delete it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 sound/soc/codecs/rt5677-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
index bd51f3655ee3..84501c2020c7 100644
--- a/sound/soc/codecs/rt5677-spi.c
+++ b/sound/soc/codecs/rt5677-spi.c
@@ -18,7 +18,6 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/regulator/consumer.h>
-- 
2.17.1
