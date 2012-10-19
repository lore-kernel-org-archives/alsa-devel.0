From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/2] ASoC: Ux500: Fixup compile error
Date: Fri, 19 Oct 2012 15:30:27 +0200
Message-ID: <1350653427-28611-2-git-send-email-ulf.hansson@stericsson.com>
References: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350653427-28611-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The below commit introduced a compile error for a missing include file.
ASoC: ux500_msp_i2s: better use devm functions and fix error return code

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index e6ff328..ba15351 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -18,6 +18,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/of.h>
 
 #include <mach/hardware.h>
-- 
1.7.10
