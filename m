From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Subject: [PATCH] ASoC: tpa6130a2: Support for tpa6140's
	regulators
Date: Fri,  8 Jan 2010 17:48:31 +0200
Message-ID: <1262965711-15103-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id CEDAF103802
	for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2010 16:46:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

tpa6140a2 uses different names for the regulators.

Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
---
 include/sound/tpa6130a2-plat.h |    6 ++++++
 sound/soc/codecs/tpa6130a2.c   |   22 ++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
index e8c901e..e29fde6 100644
--- a/include/sound/tpa6130a2-plat.h
+++ b/include/sound/tpa6130a2-plat.h
@@ -23,7 +23,13 @@
 #ifndef TPA6130A2_PLAT_H
 #define TPA6130A2_PLAT_H
 
+enum tpa_model {
+	TPA6130A2,
+	TPA6140A2,
+};
+
 struct tpa6130a2_platform_data {
+	enum tpa_model id;
 	int power_gpio;
 };
 
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 8e98ccf..8b27281 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -41,6 +41,11 @@ static const char *tpa6130a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
 	"Vdd",
 };
 
+static const char *tpa6140a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
+	"HPVdd",
+	"AVdd",
+};
+
 /* This struct is used to save the context */
 struct tpa6130a2_data {
 	struct mutex mutex;
@@ -420,8 +425,21 @@ static int tpa6130a2_probe(struct i2c_client *client,
 		gpio_direction_output(data->power_gpio, 0);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
-		data->supplies[i].supply = tpa6130a2_supply_names[i];
+	switch (pdata->id) {
+	case TPA6130A2:
+		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
+			data->supplies[i].supply = tpa6130a2_supply_names[i];
+		break;
+	case TPA6140A2:
+		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
+			data->supplies[i].supply = tpa6140a2_supply_names[i];;
+		break;
+	default:
+		dev_warn(dev, "Unknown TPA model (%d). Assuming 6130A2\n",
+			 pdata->id);
+		for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
+			data->supplies[i].supply = tpa6130a2_supply_names[i];
+	}
 
 	ret = regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
 				 data->supplies);
-- 
1.6.0.4
