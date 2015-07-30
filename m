From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 20/27] ASoC: Export OF module alias information in missing codec drivers
Date: Thu, 30 Jul 2015 18:18:45 +0200
Message-ID: <1438273132-20926-21-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/soc/codecs/da9055.c | 1 +
 sound/soc/codecs/wm8510.c | 1 +
 sound/soc/codecs/wm8523.c | 1 +
 sound/soc/codecs/wm8580.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 04c76f37e1fd..19635d830b47 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1533,6 +1533,7 @@ static const struct of_device_id da9055_of_match[] = {
 	{ .compatible = "dlg,da9055-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, da9055_of_match);
 
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 3cff5a699e57..b098a83a44d8 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -598,6 +598,7 @@ static const struct of_device_id wm8510_of_match[] = {
 	{ .compatible = "wlf,wm8510" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8510_of_match);
 
 static const struct regmap_config wm8510_regmap = {
 	.reg_bits = 7,
diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 5f8fde56e68b..aa287a3965e7 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -430,6 +430,7 @@ static const struct of_device_id wm8523_of_match[] = {
 	{ .compatible = "wlf,wm8523" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8523_of_match);
 
 static const struct regmap_config wm8523_regmap = {
 	.reg_bits = 8,
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index abf60355f7f7..66602bf02f6e 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -916,6 +916,7 @@ static const struct of_device_id wm8580_of_match[] = {
 	{ .compatible = "wlf,wm8580" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, wm8580_of_match);
 
 static const struct regmap_config wm8580_regmap = {
 	.reg_bits = 7,
-- 
2.4.3
