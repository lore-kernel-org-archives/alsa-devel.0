From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/3] ASoC: tpa6130a2: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:10 +0530
Message-ID: <195792a282b569037357ca17e4baad19893f0609.1524819052.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 52AB72678A0
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 10:56:33 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id p10-v6so1075816pgn.1
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 01:56:33 -0700 (PDT)
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/codecs/tpa6130a2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 616cd4b..18f32b9 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -62,7 +62,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			return ret;
 		}
 		/* Power on */
-		if (data->power_gpio >= 0)
+		if (gpio_is_valid(data->power_gpio))
 			gpio_set_value(data->power_gpio, 1);
 
 		/* Sync registers */
@@ -72,7 +72,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 			dev_err(data->dev,
 				"Failed to sync registers: %d\n", ret);
 			regcache_cache_only(data->regmap, true);
-			if (data->power_gpio >= 0)
+			if (gpio_is_valid(data->power_gpio))
 				gpio_set_value(data->power_gpio, 0);
 			ret2 = regulator_disable(data->supply);
 			if (ret2 != 0)
@@ -89,7 +89,7 @@ static int tpa6130a2_power(struct tpa6130a2_data *data, bool enable)
 		regcache_cache_only(data->regmap, true);
 
 		/* Power off */
-		if (data->power_gpio >= 0)
+		if (gpio_is_valid(data->power_gpio))
 			gpio_set_value(data->power_gpio, 0);
 
 		ret = regulator_disable(data->supply);
@@ -259,7 +259,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
 
 	data->id = id->driver_data;
 
-	if (data->power_gpio >= 0) {
+	if (gpio_is_valid(data->power_gpio)) {
 		ret = devm_gpio_request(dev, data->power_gpio,
 					"tpa6130a2 enable");
 		if (ret < 0) {
-- 
1.9.1
