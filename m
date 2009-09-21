From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH] some minor changes for AD1836 and AD1938 codec
	drivers
Date: Mon, 21 Sep 2009 11:20:51 +0800
Message-ID: <1253503251-18617-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 93AB3103811
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 05:19:47 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

1. delete redundant assignment to bus field in spi_driver structure
2. fix lost assignment to set_bias_level entry in ad1938 codec dai
3. change spi driver name of ad1836 from "ad1836-spi" to "ad1836"

Signed-off-by: Barry Song <barry.song@analog.com>
---
 sound/soc/codecs/ad1836.c |    3 +--
 sound/soc/codecs/ad1938.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 01343dc..c48485f 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -251,8 +251,7 @@ static int __devexit ad1836_spi_remove(struct spi_device *spi)
 
 static struct spi_driver ad1836_spi_driver = {
 	.driver = {
-		.name	= "ad1836-spi",
-		.bus	= &spi_bus_type,
+		.name	= "ad1836",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1836_spi_probe,
diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index 9a049a1..34b30ef 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -456,7 +456,6 @@ static int __devexit ad1938_spi_remove(struct spi_device *spi)
 static struct spi_driver ad1938_spi_driver = {
 	.driver = {
 		.name	= "ad1938",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad1938_spi_probe,
@@ -515,6 +514,7 @@ static int ad1938_register(struct ad1938_priv *ad1938)
 	codec->num_dai = 1;
 	codec->write = ad1938_write_reg;
 	codec->read = ad1938_read_reg_cache;
+	codec->set_bias_level = ad1938_set_bias_level;
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 
-- 
1.5.6.3
