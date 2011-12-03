From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/21] ASoC: Remove unused -codec from Wolfson
	device driver names
Date: Sat,  3 Dec 2011 21:33:09 +0000
Message-ID: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5EA7F243C7
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 22:33:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Devices that aren't MFDs don't need to distinguish this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    2 +-
 sound/soc/codecs/wm8727.c |    2 +-
 sound/soc/codecs/wm8900.c |    4 ++--
 sound/soc/codecs/wm8904.c |    2 +-
 sound/soc/codecs/wm8940.c |    2 +-
 sound/soc/codecs/wm8955.c |    2 +-
 sound/soc/codecs/wm8960.c |    2 +-
 sound/soc/codecs/wm8961.c |    2 +-
 sound/soc/codecs/wm8971.c |    2 +-
 sound/soc/codecs/wm8974.c |    2 +-
 sound/soc/codecs/wm8988.c |    2 +-
 sound/soc/codecs/wm8990.c |    2 +-
 sound/soc/codecs/wm8993.c |    2 +-
 sound/soc/codecs/wm9090.c |    2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 3a65571..9e92bbb 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -666,7 +666,7 @@ MODULE_DEVICE_TABLE(i2c, wm8510_i2c_id);
 
 static struct i2c_driver wm8510_i2c_driver = {
 	.driver = {
-		.name = "wm8510-codec",
+		.name = "wm8510",
 		.owner = THIS_MODULE,
 		.of_match_table = wm8510_of_match,
 	},
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index fad90a3..e817056 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -59,7 +59,7 @@ static int __devexit wm8727_remove(struct platform_device *pdev)
 
 static struct platform_driver wm8727_codec_driver = {
 	.driver = {
-			.name = "wm8727-codec",
+			.name = "wm8727",
 			.owner = THIS_MODULE,
 	},
 
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 6ac80cf..aa0302b 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1258,7 +1258,7 @@ static int __devexit wm8900_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8900_spi_driver = {
 	.driver = {
-		.name	= "wm8900-codec",
+		.name	= "wm8900",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8900_spi_probe,
@@ -1302,7 +1302,7 @@ MODULE_DEVICE_TABLE(i2c, wm8900_i2c_id);
 
 static struct i2c_driver wm8900_i2c_driver = {
 	.driver = {
-		.name = "wm8900-codec",
+		.name = "wm8900",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8900_i2c_probe,
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index babca49..1149a93 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2564,7 +2564,7 @@ MODULE_DEVICE_TABLE(i2c, wm8904_i2c_id);
 
 static struct i2c_driver wm8904_i2c_driver = {
 	.driver = {
-		.name = "wm8904-codec",
+		.name = "wm8904",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8904_i2c_probe,
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 9f1cce8..4d2854b 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -779,7 +779,7 @@ MODULE_DEVICE_TABLE(i2c, wm8940_i2c_id);
 
 static struct i2c_driver wm8940_i2c_driver = {
 	.driver = {
-		.name = "wm8940-codec",
+		.name = "wm8940",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8940_i2c_probe,
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index ca38722..f02256e 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -1037,7 +1037,7 @@ MODULE_DEVICE_TABLE(i2c, wm8955_i2c_id);
 
 static struct i2c_driver wm8955_i2c_driver = {
 	.driver = {
-		.name = "wm8955-codec",
+		.name = "wm8955",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8955_i2c_probe,
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ed2773f..b04f808 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -1030,7 +1030,7 @@ MODULE_DEVICE_TABLE(i2c, wm8960_i2c_id);
 
 static struct i2c_driver wm8960_i2c_driver = {
 	.driver = {
-		.name = "wm8960-codec",
+		.name = "wm8960",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8960_i2c_probe,
diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index c058701..434413b 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -1116,7 +1116,7 @@ MODULE_DEVICE_TABLE(i2c, wm8961_i2c_id);
 
 static struct i2c_driver wm8961_i2c_driver = {
 	.driver = {
-		.name = "wm8961-codec",
+		.name = "wm8961",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8961_i2c_probe,
diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index b01df56..0606484 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -724,7 +724,7 @@ MODULE_DEVICE_TABLE(i2c, wm8971_i2c_id);
 
 static struct i2c_driver wm8971_i2c_driver = {
 	.driver = {
-		.name = "wm8971-codec",
+		.name = "wm8971",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8971_i2c_probe,
diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index e41f999..b6136bb 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -671,7 +671,7 @@ MODULE_DEVICE_TABLE(i2c, wm8974_i2c_id);
 
 static struct i2c_driver wm8974_i2c_driver = {
 	.driver = {
-		.name = "wm8974-codec",
+		.name = "wm8974",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8974_i2c_probe,
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index 608c672..fbff293 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -822,7 +822,7 @@ static int __devexit wm8988_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8988_spi_driver = {
 	.driver = {
-		.name	= "wm8988-codec",
+		.name	= "wm8988",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8988_spi_probe,
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 58d7f0b..9a53dc4 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -1417,7 +1417,7 @@ MODULE_DEVICE_TABLE(i2c, wm8990_i2c_id);
 
 static struct i2c_driver wm8990_i2c_driver = {
 	.driver = {
-		.name = "wm8990-codec",
+		.name = "wm8990",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8990_i2c_probe,
diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 780c24c..e386127 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1641,7 +1641,7 @@ MODULE_DEVICE_TABLE(i2c, wm8993_i2c_id);
 
 static struct i2c_driver wm8993_i2c_driver = {
 	.driver = {
-		.name = "wm8993-codec",
+		.name = "wm8993",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8993_i2c_probe,
diff --git a/sound/soc/codecs/wm9090.c b/sound/soc/codecs/wm9090.c
index f94c060..4d90c54 100644
--- a/sound/soc/codecs/wm9090.c
+++ b/sound/soc/codecs/wm9090.c
@@ -685,7 +685,7 @@ MODULE_DEVICE_TABLE(i2c, wm9090_id);
 
 static struct i2c_driver wm9090_i2c_driver = {
 	.driver = {
-		.name = "wm9090-codec",
+		.name = "wm9090",
 		.owner = THIS_MODULE,
 	},
 	.probe = wm9090_i2c_probe,
-- 
1.7.7.3
