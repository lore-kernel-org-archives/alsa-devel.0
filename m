From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Fix error handling of
	regulator_set_load" to the asoc tree
Date: Sat, 17 Nov 2018 03:27:39 +0000 (GMT)
Message-ID: <20181117032739.1D7A4440078@finisterre.ee.mobilebroadband>
References: <20181116092856.47815-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BCBA32679C0
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2018 04:27:47 +0100 (CET)
In-Reply-To: <20181116092856.47815-1-cychiang@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tzungbi@chromium.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Fix error handling of regulator_set_load

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 746dca0aebd4d77adccb76c500a60028a900dabb Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Fri, 16 Nov 2018 17:28:56 +0800
Subject: [PATCH] ASoC: rt5663: Fix error handling of regulator_set_load

The default implementation of regulator_set_load returns
REGULATOR_MODE_NORMAL, which is positive.  [This was a bug which is
being fixed but the change is valid anyway -- bronie]

rt5663_i2c_probe should only do error handling when return value of
regulator_set_load is negative.
In this case, rt5663_i2c_probe should return error.

Also, consolidate err_irq into err_enable.

Fix the missing goto for temporary regmap and rt5663->regmap.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 29c059ed0682..da6647015708 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3525,10 +3525,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
 		ret = regulator_set_load(rt5663->supplies[i].consumer,
 					 RT5663_SUPPLY_CURRENT_UA);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(&i2c->dev,
-				"Failed to set regulator %s, ret: %d\n",
+				"Failed to set regulator load on %s, ret: %d\n",
 				rt5663->supplies[i].supply, ret);
+			return ret;
 		}
 	}
 
@@ -3546,7 +3547,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
@@ -3579,7 +3580,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(rt5663->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	/* reset and calibrate */
@@ -3689,17 +3690,19 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
 	if (ret)
-		goto err_irq;
+		goto err_enable;
 
 	return 0;
 
-err_irq:
+
+	/*
+	 * Error after enabling regulators should goto err_enable
+	 * to disable regulators.
+	 */
+err_enable:
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
-err_enable:
-	dev_err(&i2c->dev,
-		"%s: Disable regulator after probe error\n", __func__);
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
-- 
2.19.1
