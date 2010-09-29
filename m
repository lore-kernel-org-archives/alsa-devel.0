From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove unneeded use of spi_bus_type
Date: Wed, 29 Sep 2010 11:48:19 +0100
Message-ID: <1285757299-2065-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BA8931038E7
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 12:48:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

No need to explicitly set the bus type, spi_register_driver does
that for us.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8510.c |    1 -
 sound/soc/codecs/wm8711.c |    1 -
 sound/soc/codecs/wm8728.c |    1 -
 sound/soc/codecs/wm8731.c |    1 -
 sound/soc/codecs/wm8750.c |    1 -
 sound/soc/codecs/wm8753.c |    1 -
 sound/soc/codecs/wm8776.c |    1 -
 sound/soc/codecs/wm8900.c |    1 -
 sound/soc/codecs/wm8985.c |    1 -
 sound/soc/codecs/wm8988.c |    1 -
 10 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
index 02ecf54..8f10709 100644
--- a/sound/soc/codecs/wm8510.c
+++ b/sound/soc/codecs/wm8510.c
@@ -627,7 +627,6 @@ static int __devexit wm8510_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8510_spi_driver = {
 	.driver = {
 		.name	= "wm8510",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8510_spi_probe,
diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 52a923a..54fbd76 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -453,7 +453,6 @@ static int __devexit wm8711_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8711_spi_driver = {
 	.driver = {
 		.name	= "wm8711-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8711_spi_probe,
diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 32eba85..075f35e 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -307,7 +307,6 @@ static int __devexit wm8728_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8728_spi_driver = {
 	.driver = {
 		.name	= "wm8728-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8728_spi_probe,
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index bdce125..6313858 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -600,7 +600,6 @@ static int __devexit wm8731_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8731_spi_driver = {
 	.driver = {
 		.name	= "wm8731-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8731_spi_probe,
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 4d1ec9d..6c924cd 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -782,7 +782,6 @@ static int __devexit wm8750_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8750_spi_driver = {
 	.driver = {
 		.name	= "wm8750-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8750_spi_probe,
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 64ea066..8f679a1 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1651,7 +1651,6 @@ static int __devexit wm8753_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8753_spi_driver = {
 	.driver = {
 		.name	= "wm8753-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8753_spi_probe,
diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index c0b6917..04182c4 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -483,7 +483,6 @@ static int __devexit wm8776_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8776_spi_driver = {
 	.driver = {
 		.name	= "wm8776-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8776_spi_probe,
diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 25c8ccd..b4f1172 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -1291,7 +1291,6 @@ static int __devexit wm8900_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8900_spi_driver = {
 	.driver = {
 		.name	= "wm8900-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8900_spi_probe,
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index bd109c4..04ec1fe 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -1145,7 +1145,6 @@ static int __devexit wm8985_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8985_spi_driver = {
 	.driver = {
 		.name = "wm8985",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.probe = wm8985_spi_probe,
diff --git a/sound/soc/codecs/wm8988.c b/sound/soc/codecs/wm8988.c
index d08b1fe..d7f2597 100644
--- a/sound/soc/codecs/wm8988.c
+++ b/sound/soc/codecs/wm8988.c
@@ -844,7 +844,6 @@ static int __devexit wm8988_spi_remove(struct spi_device *spi)
 static struct spi_driver wm8988_spi_driver = {
 	.driver = {
 		.name	= "wm8988-codec",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8988_spi_probe,
-- 
1.7.3
