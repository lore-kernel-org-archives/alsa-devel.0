From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Fix the issue that the
	regmap_range "rt5677_ranges" cannot be accessed
Date: Mon, 24 Nov 2014 14:16:19 +0800
Message-ID: <1416809779-5308-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB8D2617AB
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 07:16:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

After the commit "19ba484d7b15c8650b30377aad6e65b34d3cf3d5", it will cause that
the regmap_range "rt5677_ranges" cannot be accessed. The patch fixes this issue.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 37 ++++++++++++++++++++++++++++++-------
 sound/soc/codecs/rt5677.h |  2 +-
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f2211f1..133010d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4287,6 +4287,7 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 	}
 
 	mutex_init(&rt5677->dsp_cmd_lock);
+	mutex_init(&rt5677->dsp_pri_lock);
 
 	return 0;
 }
@@ -4344,10 +4345,19 @@ static int rt5677_read(void *context, unsigned int reg, unsigned int *val)
 	struct i2c_client *client = context;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(client);
 
-	if (rt5677->is_dsp_mode)
-		rt5677_dsp_mode_i2c_read(rt5677, reg, val);
-	else
+	if (rt5677->is_dsp_mode) {
+		if (reg > 0xff) {
+			mutex_lock(&rt5677->dsp_pri_lock);
+			rt5677_dsp_mode_i2c_write(rt5677, RT5677_PRIV_INDEX,
+				reg & 0xff);
+			rt5677_dsp_mode_i2c_read(rt5677, RT5677_PRIV_DATA, val);
+			mutex_unlock(&rt5677->dsp_pri_lock);
+		} else {
+			rt5677_dsp_mode_i2c_read(rt5677, reg, val);
+		}
+	} else {
 		regmap_read(rt5677->regmap_physical, reg, val);
+	}
 
 	return 0;
 }
@@ -4357,10 +4367,20 @@ static int rt5677_write(void *context, unsigned int reg, unsigned int val)
 	struct i2c_client *client = context;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(client);
 
-	if (rt5677->is_dsp_mode)
-		rt5677_dsp_mode_i2c_write(rt5677, reg, val);
-	else
+	if (rt5677->is_dsp_mode) {
+		if (reg > 0xff) {
+			mutex_lock(&rt5677->dsp_pri_lock);
+			rt5677_dsp_mode_i2c_write(rt5677, RT5677_PRIV_INDEX,
+				reg & 0xff);
+			rt5677_dsp_mode_i2c_write(rt5677, RT5677_PRIV_DATA,
+				val);
+			mutex_unlock(&rt5677->dsp_pri_lock);
+		} else {
+			rt5677_dsp_mode_i2c_write(rt5677, reg, val);
+		}
+	} else {
 		regmap_write(rt5677->regmap_physical, reg, val);
+	}
 
 	return 0;
 }
@@ -4495,10 +4515,13 @@ static const struct regmap_config rt5677_regmap_physical = {
 	.reg_bits = 8,
 	.val_bits = 16,
 
-	.max_register = RT5677_VENDOR_ID2 + 1,
+	.max_register = RT5677_VENDOR_ID2 + 1 + (ARRAY_SIZE(rt5677_ranges) *
+						RT5677_PR_SPACING),
 	.readable_reg = rt5677_readable_register,
 
 	.cache_type = REGCACHE_NONE,
+	.ranges = rt5677_ranges,
+	.num_ranges = ARRAY_SIZE(rt5677_ranges),
 };
 
 static const struct regmap_config rt5677_regmap = {
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index a02f64c..dbd9ffd 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1670,7 +1670,7 @@ struct rt5677_priv {
 	struct rt5677_platform_data pdata;
 	struct regmap *regmap, *regmap_physical;
 	const struct firmware *fw1, *fw2;
-	struct mutex dsp_cmd_lock;
+	struct mutex dsp_cmd_lock, dsp_pri_lock;
 
 	int sysclk;
 	int sysclk_src;
-- 
1.8.1.1.439.g50a6b54
