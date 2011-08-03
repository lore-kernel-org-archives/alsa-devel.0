From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove redundant -codec from WM8750
Date: Wed,  3 Aug 2011 18:27:05 +0900
Message-ID: <1312363625-6012-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBEF81038EA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 11:27:14 +0200 (CEST)
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
 sound/soc/codecs/wm8750.c         |    2 +-
 sound/soc/pxa/spitz.c             |    2 +-
 sound/soc/pxa/z2.c                |    2 +-
 sound/soc/samsung/jive_wm8750.c   |    2 +-
 sound/soc/samsung/smartq_wm8987.c |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index b7c96c6..f0ccbef 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -841,7 +841,7 @@ MODULE_DEVICE_TABLE(i2c, wm8750_i2c_id);
 
 static struct i2c_driver wm8750_i2c_driver = {
 	.driver = {
-		.name = "wm8750-codec",
+		.name = "wm8750",
 		.owner = THIS_MODULE,
 		.of_match_table = wm8750_of_match,
 	},
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index b253d86..ce920e3 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -312,7 +312,7 @@ static struct snd_soc_dai_link spitz_dai = {
 	.cpu_dai_name = "pxa2xx-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8750-codec.0-001b",
+	.codec_name = "wm8750.0-001b",
 	.init = spitz_wm8750_init,
 	.ops = &spitz_ops,
 };
diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index d69d9fc..4b81ffd 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -198,7 +198,7 @@ static struct snd_soc_dai_link z2_dai = {
 	.cpu_dai_name	= "pxa2xx-i2s",
 	.codec_dai_name	= "wm8750-hifi",
 	.platform_name = "pxa-pcm-audio",
-	.codec_name	= "wm8750-codec.0-001b",
+	.codec_name	= "wm8750.0-001b",
 	.init		= z2_wm8750_init,
 	.ops		= &z2_ops,
 };
diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 14eb6ea..ed8f13a 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -131,7 +131,7 @@ static struct snd_soc_dai_link jive_dai = {
 	.cpu_dai_name	= "s3c2412-i2s",
 	.codec_dai_name = "wm8750-hifi",
 	.platform_name	= "samsung-audio",
-	.codec_name	= "wm8750-codec.0-001a",
+	.codec_name	= "wm8750.0-001a",
 	.init		= jive_wm8750_init,
 	.ops		= &jive_ops,
 };
diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index 0a2c4f2..bbd1476 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -207,7 +207,7 @@ static struct snd_soc_dai_link smartq_dai[] = {
 		.cpu_dai_name	= "samsung-i2s.0",
 		.codec_dai_name	= "wm8750-hifi",
 		.platform_name	= "samsung-audio",
-		.codec_name	= "wm8750-codec.0-0x1a",
+		.codec_name	= "wm8750.0-0x1a",
 		.init		= smartq_wm8987_init,
 		.ops		= &smartq_hifi_ops,
 	},
-- 
1.7.5.4
