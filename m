From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH 1/2] ASoC: fsl_sai: Use usleep_range() instead
	of msleep()
Date: Fri, 15 Jan 2016 19:35:24 +0800
Message-ID: <1452857725-32414-2-git-send-email-lixiubo@cmss.chinamobile.com>
References: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D32A26058E
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 12:34:53 +0100 (CET)
In-Reply-To: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Xiubo Li <lixiubo@cmss.chinamobile.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Since msleep() will sleep longer than intended time for values less
than 20ms, this patch allows the use of usleep_range for just 1ms.
usleep_range is a finer precision implementation of msleep and is
designed to be a drop-in replacement for udelay where a precise
sleep/busy-wait is unnecessary.

More details see Documentation/timers/timers-howto.txt.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_sai.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index fef264d..0754df7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -17,6 +17,7 @@
 #include <linux/of_address.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/time.h>
 #include <sound/core.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/pcm_params.h>
@@ -919,7 +920,7 @@ static int fsl_sai_resume(struct device *dev)
 	regcache_cache_only(sai->regmap, false);
 	regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
 	regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
-	msleep(1);
+	usleep_range(1000, 2000);
 	regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
 	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
 	return regcache_sync(sai->regmap);
-- 
1.8.3.1
