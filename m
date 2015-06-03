From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Avoid recursive locking in the
	DEADLOCK detector
Date: Wed, 3 Jun 2015 23:53:17 +0800
Message-ID: <1433346797-1908-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A03265AF3
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 17:53:40 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch is for to avoid recursive locking in the DEADLOCK detector.
In the driver, it encountered the warnning message of the recursive locking
in the function "regmap_lock_mutex".

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 31d969a..ee5b570 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4998,6 +4998,22 @@ static const struct regmap_config rt5677_regmap_physical = {
 	.num_ranges = ARRAY_SIZE(rt5677_ranges),
 };
 
+static void rt5677_regmap_lock_mutex(void *__lock)
+{
+	struct mutex *lock = __lock;
+
+	mutex_lock(lock);
+}
+
+static void rt5677_regmap_unlock_mutex(void *__lock)
+{
+	struct mutex *lock = __lock;
+
+	mutex_unlock(lock);
+}
+
+static struct mutex rt5677_regmap_lock;
+
 static const struct regmap_config rt5677_regmap = {
 	.reg_bits = 8,
 	.val_bits = 16,
@@ -5009,6 +5025,9 @@ static const struct regmap_config rt5677_regmap = {
 	.readable_reg = rt5677_readable_register,
 	.reg_read = rt5677_read,
 	.reg_write = rt5677_write,
+	.lock = rt5677_regmap_lock_mutex,
+	.unlock = rt5677_regmap_unlock_mutex,
+	.lock_arg = &rt5677_regmap_lock,
 
 	.cache_type = REGCACHE_RBTREE,
 	.reg_defaults = rt5677_reg,
@@ -5206,6 +5225,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	mutex_init(&rt5677_regmap_lock);
+
 	regmap_read(rt5677->regmap, RT5677_VENDOR_ID2, &val);
 	if (val != RT5677_DEVICE_ID) {
 		dev_err(&i2c->dev,
-- 
1.9.1
