From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove redundant -codec from WM8776
	driver name
Date: Mon, 29 Aug 2011 14:26:37 +0100
Message-ID: <1314624397-15316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E62E245D7
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 12:37:56 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8776.c |    4 ++--
 sound/soc/fsl/p1022_ds.c  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 8e7953b..367a990 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -481,7 +481,7 @@ static int __devexit wm8776_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8776_spi_driver = {
 	.driver = {
-		.name	= "wm8776-codec",
+		.name	= "wm8776",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8776_spi_probe,
@@ -525,7 +525,7 @@ MODULE_DEVICE_TABLE(i2c, wm8776_i2c_id);
 
 static struct i2c_driver wm8776_i2c_driver = {
 	.driver = {
-		.name = "wm8776-codec",
+		.name = "wm8776",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8776_i2c_probe,
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index fcb862e..e8849ed 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -267,7 +267,7 @@ static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
 	if (bus < 0)
 		return bus;
 
-	snprintf(buf, len, "%s-codec.%u-%04x", temp, bus, addr);
+	snprintf(buf, len, "%s.%u-%04x", temp, bus, addr);
 
 	return 0;
 }
-- 
1.7.5.4
