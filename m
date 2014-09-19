From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/5] ASoC: max98090: Remove structure member
	irq from private data
Date: Fri, 19 Sep 2014 14:48:18 +0300
Message-ID: <1411127301-366-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 278F6261A7F
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:48:35 +0200 (CEST)
In-Reply-To: <1411127301-366-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

struct max98090_priv member irq is now used only locally in
max98090_i2c_probe() and can be removed.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 3 +--
 sound/soc/codecs/max98090.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index fe77df6a76c2..3e27de1f473b 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2463,7 +2463,6 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 	max98090->devtype = driver_data;
 	i2c_set_clientdata(i2c, max98090);
 	max98090->pdata = i2c->dev.platform_data;
-	max98090->irq = i2c->irq;
 
 	max98090->regmap = devm_regmap_init_i2c(i2c, &max98090_regmap);
 	if (IS_ERR(max98090->regmap)) {
@@ -2472,7 +2471,7 @@ static int max98090_i2c_probe(struct i2c_client *i2c,
 		goto err_enable;
 	}
 
-	ret = devm_request_threaded_irq(&i2c->dev, max98090->irq, NULL,
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 		"max98090_interrupt", max98090);
 	if (ret < 0) {
diff --git a/sound/soc/codecs/max98090.h b/sound/soc/codecs/max98090.h
index 14427a566f41..a16319512182 100644
--- a/sound/soc/codecs/max98090.h
+++ b/sound/soc/codecs/max98090.h
@@ -1529,7 +1529,6 @@ struct max98090_priv {
 	unsigned int bclk;
 	unsigned int lrclk;
 	struct max98090_cdata dai[1];
-	int irq;
 	int jack_state;
 	struct delayed_work jack_work;
 	struct delayed_work pll_det_enable_work;
-- 
2.1.0
