From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: wm8962: Hold a runtime PM reference
	while handling interrupts
Date: Fri, 31 Jan 2014 15:29:58 +0000
Message-ID: <1391182201-29439-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5889F2625E6
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 16:30:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

If the device is runtime suspended then we can't interact with it as it
may have been powered off and the register map will be in cache only
mode.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8962.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 97db3b45b411..aa7ae76d5e28 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3003,6 +3003,12 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 	unsigned int active;
 	int reg, ret;
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to resume: %d\n", ret);
+		return ret;
+	}
+
 	ret = regmap_read(wm8962->regmap, WM8962_INTERRUPT_STATUS_2_MASK,
 			  &mask);
 	if (ret != 0) {
@@ -3019,8 +3025,10 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 
 	active &= ~mask;
 
-	if (!active)
+	if (!active) {
+		pm_runtime_put(dev);
 		return IRQ_NONE;
+	}
 
 	/* Acknowledge the interrupts */
 	ret = regmap_write(wm8962->regmap, WM8962_INTERRUPT_STATUS_2, active);
@@ -3070,6 +3078,8 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 				   msecs_to_jiffies(250));
 	}
 
+	pm_runtime_put(dev);
+
 	return IRQ_HANDLED;
 }
 
-- 
1.9.rc1
