From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unneeded -codec from WM8753
	driver name
Date: Mon,  8 Aug 2011 13:36:37 +0900
Message-ID: <1312778197-29683-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CF421037F8
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 06:59:43 +0200 (CEST)
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
 sound/soc/codecs/wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index ffa2ffe..a702550 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1519,7 +1519,7 @@ static int __devexit wm8753_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8753_spi_driver = {
 	.driver = {
-		.name	= "wm8753-codec",
+		.name	= "wm8753",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8753_spi_probe,
@@ -1563,7 +1563,7 @@ MODULE_DEVICE_TABLE(i2c, wm8753_i2c_id);
 
 static struct i2c_driver wm8753_i2c_driver = {
 	.driver = {
-		.name = "wm8753-codec",
+		.name = "wm8753",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8753_i2c_probe,
-- 
1.7.5.4
