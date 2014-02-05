From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/8] ASoC: da9055: Fix device registration of
	PMIC and CODEC devices
Date: Wed, 5 Feb 2014 17:48:32 +0000
Message-ID: <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDEC26501B
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:35 +0100 (CET)
In-Reply-To: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

Currently the I2C device Ids conflict for the MFD and CODEC so
cannot be both instantiated on one platform. This patch updates
the Ids and names to make them unique from each other.

It should be noted that the I2C addresses for both PMIC and CODEC
are modifiable so instantiation of the two are kept as separate
devices, rather than instantiating the CODEC from the MFD code.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/mfd/da9055-i2c.c  |   12 ++++++++++--
 sound/soc/codecs/da9055.c |   11 +++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 13af7e5..8103e43 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -53,17 +53,25 @@ static int da9055_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }

+/*
+ * DO NOT change the device Ids. The naming is intentionally specific as both
+ * the PMIC and CODEC parts of this chip are instantiated separately as I2C
+ * devices (both have configurable I2C addresses, and are to all intents and
+ * purposes separate). As a result there are specific DA9055 ids for PMIC
+ * and CODEC, which must be different to operate together.
+ */
 static struct i2c_device_id da9055_i2c_id[] = {
-	{"da9055", 0},
+	{"da9055-pmic", 0},
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);

 static struct i2c_driver da9055_i2c_driver = {
 	.probe = da9055_i2c_probe,
 	.remove = da9055_i2c_remove,
 	.id_table = da9055_i2c_id,
 	.driver = {
-		.name = "da9055",
+		.name = "da9055-pmic",
 		.owner = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 52b79a4..4228126 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -1523,8 +1523,15 @@ static int da9055_remove(struct i2c_client *client)
 	return 0;
 }

+/*
+ * DO NOT change the device Ids. The naming is intentionally specific as both
+ * the CODEC and PMIC parts of this chip are instantiated separately as I2C
+ * devices (both have configurable I2C addresses, and are to all intents and
+ * purposes separate). As a result there are specific DA9055 Ids for CODEC
+ * and PMIC, which must be different to operate together.
+ */
 static const struct i2c_device_id da9055_i2c_id[] = {
-	{ "da9055", 0 },
+	{ "da9055-codec", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
@@ -1532,7 +1539,7 @@ MODULE_DEVICE_TABLE(i2c, da9055_i2c_id);
 /* I2C codec control layer */
 static struct i2c_driver da9055_i2c_driver = {
 	.driver = {
-		.name = "da9055",
+		.name = "da9055-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe		= da9055_i2c_probe,
--
1.7.0.4
