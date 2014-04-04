From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 2/4] ASoC: spdif: Sort the header files
	alphabetically.
Date: Fri, 4 Apr 2014 15:10:27 +0800
Message-ID: <1396595429-16629-3-git-send-email-Li.Xiubo@freescale.com>
References: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 by alsa0.perex.cz (Postfix) with ESMTP id 48DCA26573F
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 09:54:53 +0200 (CEST)
In-Reply-To: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, Guangyu.Chen@freescale.com
Cc: alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 6452ca8..173553c 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -13,18 +13,18 @@
  * kind, whether express or implied.
  */
 
-#include <linux/module.h>
+#include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/clk-private.h>
-#include <linux/bitrev.h>
-#include <linux/regmap.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/regmap.h>
 
 #include <sound/asoundef.h>
-#include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
 
 #include "fsl_spdif.h"
 #include "imx-pcm.h"
-- 
1.8.4
