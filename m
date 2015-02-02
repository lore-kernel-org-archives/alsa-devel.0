From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: davinci-evm: Do not include edma
	headers
Date: Mon, 2 Feb 2015 14:49:41 +0200
Message-ID: <1422881382-26405-2-git-send-email-peter.ujfalusi@ti.com>
References: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7643C2605EA
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:49:50 +0100 (CET)
In-Reply-To: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: olof@lixom.net, alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

The machine driver has no business with the underlying dma.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 158cb3d1db70..d1a8b6e3ac3b 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -14,7 +14,6 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/edma.h>
 #include <linux/i2c.h>
 #include <linux/of_platform.h>
 #include <linux/clk.h>
@@ -25,8 +24,6 @@
 #include <asm/dma.h>
 #include <asm/mach-types.h>
 
-#include <linux/edma.h>
-
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 
-- 
2.2.2
