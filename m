From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5640: Add the string "rt5639" to
	the list of I2C device IDs
Date: Thu, 10 Apr 2014 10:57:34 +0800
Message-ID: <1397098655-21965-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 79A56261A3A
 for <alsa-devel@alsa-project.org>; Thu, 10 Apr 2014 04:57:45 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the string "rt5639" to the list of I2C device IDs.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5640.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index d672f44..2e7132b 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1,5 +1,5 @@
 /*
- * rt5640.c  --  RT5640 ALSA SoC audio codec driver
+ * rt5640.c  --  RT5640/RT5639 ALSA SoC audio codec driver
  *
  * Copyright 2011 Realtek Semiconductor Corp.
  * Author: Johnny Hsu <johnnyhsu@realtek.com>
@@ -2164,6 +2164,7 @@ static const struct regmap_config rt5640_regmap = {
 
 static const struct i2c_device_id rt5640_i2c_id[] = {
 	{ "rt5640", 0 },
+	{ "rt5639", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
@@ -2322,6 +2323,6 @@ static struct i2c_driver rt5640_i2c_driver = {
 };
 module_i2c_driver(rt5640_i2c_driver);
 
-MODULE_DESCRIPTION("ASoC RT5640 driver");
+MODULE_DESCRIPTION("ASoC RT5640/RT5639 driver");
 MODULE_AUTHOR("Johnny Hsu <johnnyhsu@realtek.com>");
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.1.439.g50a6b54
