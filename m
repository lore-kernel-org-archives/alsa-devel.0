From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded
	mach/hardware.h inclusion
Date: Mon, 17 Sep 2012 13:34:45 +0800
Message-ID: <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E0F982615F1
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 07:36:07 +0200 (CEST)
Received: by pbbro8 with SMTP id ro8so10198282pbb.38
 for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2012 22:36:07 -0700 (PDT)
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/fsl/imx-ssi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index e6a17ba..1a28f15 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -48,7 +48,6 @@
 #include <sound/soc.h>
 
 #include <linux/platform_data/asoc-imx-ssi.h>
-#include <mach/hardware.h>
 
 #include "imx-ssi.h"
 
-- 
1.7.9.5
