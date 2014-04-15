From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl: Add explicit include of of.h
Date: Tue, 15 Apr 2014 12:12:06 +0100
Message-ID: <1397560326-28268-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25DFC264ED5
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 13:12:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Hopefully fixing a build failure reported by Stephen Rothwell - though
quite why the other OF headers don't include this as well I'm not sure.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5428a1fda260..2fbbd8416c00 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-- 
1.9.1
