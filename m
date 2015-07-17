From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Constify dev_pm_ops variables
Date: Fri, 17 Jul 2015 10:54:49 +0800
Message-ID: <1437101689.31985.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 09DE8260654
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 04:54:55 +0200 (CEST)
Received: by pacan13 with SMTP id an13so53067130pac.1
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 19:54:54 -0700 (PDT)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The dev_pm_ops variables are not modified after initialization in these
drivers, so make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/wm2200.c | 2 +-
 sound/soc/codecs/wm5100.c | 2 +-
 sound/soc/codecs/wm8962.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index cdaa175..878d43a 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -2481,7 +2481,7 @@ static int wm2200_runtime_resume(struct device *dev)
 }
 #endif
 
-static struct dev_pm_ops wm2200_pm = {
+static const struct dev_pm_ops wm2200_pm = {
 	SET_RUNTIME_PM_OPS(wm2200_runtime_suspend, wm2200_runtime_resume,
 			   NULL)
 };
diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index e5572d2..eb494d0 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2706,7 +2706,7 @@ static int wm5100_runtime_resume(struct device *dev)
 }
 #endif
 
-static struct dev_pm_ops wm5100_pm = {
+static const struct dev_pm_ops wm5100_pm = {
 	SET_RUNTIME_PM_OPS(wm5100_runtime_suspend, wm5100_runtime_resume,
 			   NULL)
 };
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c67e304..cbd1886 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3859,7 +3859,7 @@ static int wm8962_runtime_suspend(struct device *dev)
 }
 #endif
 
-static struct dev_pm_ops wm8962_pm = {
+static const struct dev_pm_ops wm8962_pm = {
 	SET_RUNTIME_PM_OPS(wm8962_runtime_suspend, wm8962_runtime_resume, NULL)
 };
 
-- 
2.1.0
