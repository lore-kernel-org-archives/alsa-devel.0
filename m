From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Remove -codec from WM8731 driver name
Date: Sun, 27 Mar 2011 14:42:16 +0100
Message-ID: <1301233336-21048-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1301233336-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8EE0C103865
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Mar 2011 15:42:11 +0200 (CEST)
In-Reply-To: <1301233336-21048-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/atmel/sam9g20_wm8731.c |    2 +-
 sound/soc/au1x/db1200.c          |    2 +-
 sound/soc/codecs/wm8731.c        |    4 ++--
 sound/soc/pxa/corgi.c            |    2 +-
 sound/soc/pxa/poodle.c           |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index af3c730..28afbbf 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -184,7 +184,7 @@ static struct snd_soc_dai_link at91sam9g20ek_dai = {
 	.codec_dai_name = "wm8731-hifi",
 	.init = at91sam9g20ek_wm8731_init,
 	.platform_name = "atmel-pcm-audio",
-	.codec_name = "wm8731-codec.0-001b",
+	.codec_name = "wm8731.0-001b",
 	.ops = &at91sam9g20ek_ops,
 };
 
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index cb99f04..1d3e258 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -77,7 +77,7 @@ static struct snd_soc_dai_link db1200_i2s_dai = {
 	.codec_dai_name	= "wm8731-hifi",
 	.cpu_dai_name	= "au1xpsc_i2s.1",
 	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "wm8731-codec.0-001b",
+	.codec_name	= "wm8731.0-001b",
 	.ops		= &db1200_i2s_wm8731_ops,
 };
 
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 44a591e..6dec7ce 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -659,7 +659,7 @@ static int __devexit wm8731_spi_remove(struct spi_device *spi)
 
 static struct spi_driver wm8731_spi_driver = {
 	.driver = {
-		.name	= "wm8731-codec",
+		.name	= "wm8731",
 		.owner	= THIS_MODULE,
 	},
 	.probe		= wm8731_spi_probe,
@@ -703,7 +703,7 @@ MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);
 
 static struct i2c_driver wm8731_i2c_driver = {
 	.driver = {
-		.name = "wm8731-codec",
+		.name = "wm8731",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8731_i2c_probe,
diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 9027da4..28757fb 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -310,7 +310,7 @@ static struct snd_soc_dai_link corgi_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8731-codec.0-001b",
+	.codec_name = "wm8731.0-001b",
 	.init = corgi_wm8731_init,
 	.ops = &corgi_ops,
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index a7d4999..da3ae43 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -276,7 +276,7 @@ static struct snd_soc_dai_link poodle_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8731-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8731-codec.0-001b",
+	.codec_name = "wm8731.0-001b",
 	.init = poodle_wm8731_init,
 	.ops = &poodle_ops,
 };
-- 
1.7.4.1
