From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-dmic: Correct functional clock name
Date: Fri, 26 Oct 2012 12:33:08 +0200
Message-ID: <1351247588-30500-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 47993265095
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 12:33:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We should really use "fck" when asking for the functional clock and not
"dmic_fck".
This way we can ensure that multiple dmic modules can exist in the system.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Mark, Liam,

Would it be possible to send this patch for 3.7 as a fix?
The DMIC driver works withoput this patch but we ask for the functional clock
using the wrong name.

Thanks,
Peter

 sound/soc/omap/omap-dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 68f2cd1..5a6aeaf 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -464,9 +464,9 @@ static __devinit int asoc_dmic_probe(struct platform_device *pdev)
 
 	mutex_init(&dmic->mutex);
 
-	dmic->fclk = clk_get(dmic->dev, "dmic_fck");
+	dmic->fclk = clk_get(dmic->dev, "fck");
 	if (IS_ERR(dmic->fclk)) {
-		dev_err(dmic->dev, "cant get dmic_fck\n");
+		dev_err(dmic->dev, "cant get fck\n");
 		return -ENODEV;
 	}
 
-- 
1.7.12.4
