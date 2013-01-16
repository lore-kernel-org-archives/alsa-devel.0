From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Don't request FLL lock IRQ
Date: Wed, 16 Jan 2013 17:28:00 +0900
Message-ID: <1358324880-23668-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 169FC26508C
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 09:37:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <Liam.R.Girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We only log the result and since the interrupt triggers on loss of lock
during shutdown this may lead to spurious interrupts during shutdown
delaying the process.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   19 -------------------
 sound/soc/codecs/arizona.h |    1 -
 2 files changed, 20 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 9da5eee..b3621d6 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1008,17 +1008,6 @@ int arizona_init_dai(struct arizona_priv *priv, int id)
 }
 EXPORT_SYMBOL_GPL(arizona_init_dai);
 
-static irqreturn_t arizona_fll_lock(int irq, void *data)
-{
-	struct arizona_fll *fll = data;
-
-	arizona_fll_dbg(fll, "Lock status changed\n");
-
-	complete(&fll->lock);
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t arizona_fll_clock_ok(int irq, void *data)
 {
 	struct arizona_fll *fll = data;
@@ -1258,7 +1247,6 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 {
 	int ret;
 
-	init_completion(&fll->lock);
 	init_completion(&fll->ok);
 
 	fll->id = id;
@@ -1269,13 +1257,6 @@ int arizona_init_fll(struct arizona *arizona, int id, int base, int lock_irq,
 	snprintf(fll->clock_ok_name, sizeof(fll->clock_ok_name),
 		 "FLL%d clock OK", id);
 
-	ret = arizona_request_irq(arizona, lock_irq, fll->lock_name,
-				  arizona_fll_lock, fll);
-	if (ret != 0) {
-		dev_err(arizona->dev, "Failed to get FLL%d lock IRQ: %d\n",
-			id, ret);
-	}
-
 	ret = arizona_request_irq(arizona, ok_irq, fll->clock_ok_name,
 				  arizona_fll_clock_ok, fll);
 	if (ret != 0) {
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index b3b97f56..67fd49b 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -200,7 +200,6 @@ struct arizona_fll {
 	int id;
 	unsigned int base;
 	unsigned int vco_mult;
-	struct completion lock;
 	struct completion ok;
 	unsigned int fref;
 	unsigned int fout;
-- 
1.7.10.4
