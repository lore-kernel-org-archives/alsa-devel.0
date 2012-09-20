From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 15/34] ASoC: imx-ssi: remove unneeded
	mach/hardware.h inclusion
Date: Thu, 20 Sep 2012 14:45:28 +0800
Message-ID: <1348123547-31082-16-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 97400264EEB
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 08:47:05 +0200 (CEST)
Received: by pbbro8 with SMTP id ro8so4390080pbb.38
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 23:47:04 -0700 (PDT)
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Javier Martin <javier.martin@vista-silicon.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/fsl/imx-ssi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 006f7d4..dd56644 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -48,7 +48,6 @@
 #include <sound/soc.h>
 
 #include <linux/platform_data/asoc-imx-ssi.h>
-#include <mach/hardware.h>
 
 #include "imx-ssi.h"
 
-- 
1.7.9.5
