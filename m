From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove some more redundant -codecs from
	driver names
Date: Wed,  3 Aug 2011 18:39:05 +0900
Message-ID: <1312364345-8653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 80F601038EA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 11:39:16 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8711.c |    4 ++--
 sound/soc/codecs/wm8728.c |    4 ++--
 sound/soc/codecs/wm8741.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index a537e4a..e1db7e4 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -443,7 +443,7 @@ static int __devexit wm8711_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8711_spi_driver = {
 	.driver = {
-		.name	= "wm8711-codec",
+		.name	= "wm8711",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8711_spi_probe,
@@ -487,7 +487,7 @@ MODULE_DEVICE_TABLE(i2c, wm8711_i2c_id);
 
 static struct i2c_driver wm8711_i2c_driver = {
 	.driver = {
-		.name = "wm8711-codec",
+		.name = "wm8711",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8711_i2c_probe,
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 86d4718..c8564f7 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -298,7 +298,7 @@ static int __devexit wm8728_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8728_spi_driver = {
 	.driver = {
-		.name	= "wm8728-codec",
+		.name	= "wm8728",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8728_spi_probe,
@@ -342,7 +342,7 @@ MODULE_DEVICE_TABLE(i2c, wm8728_i2c_id);
 
 static struct i2c_driver wm8728_i2c_driver = {
 	.driver = {
-		.name = "wm8728-codec",
+		.name = "wm8728",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8728_i2c_probe,
diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 1572a39..c1b6e91 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -541,7 +541,7 @@ MODULE_DEVICE_TABLE(i2c, wm8741_i2c_id);
 
 static struct i2c_driver wm8741_i2c_driver = {
 	.driver = {
-		.name = "wm8741-codec",
+		.name = "wm8741",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8741_i2c_probe,
-- 
1.7.5.4
