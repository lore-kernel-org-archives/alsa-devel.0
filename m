From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix WM8978/migor driver name conflict
Date: Sun, 19 Sep 2010 20:54:22 +0100
Message-ID: <1284926062-20549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3901103811
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Sep 2010 21:54:03 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Standardise on 'wm8978' as the name for the CODEC.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8978.c |    2 +-
 sound/soc/sh/migor.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 676a430..13b979a 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1038,7 +1038,7 @@ MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
 
 static struct i2c_driver wm8978_i2c_driver = {
 	.driver = {
-		.name = "WM8978-codec",
+		.name = "wm8978",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8978_i2c_probe,
diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index f462017..ac6c49c 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -156,7 +156,7 @@ static struct snd_soc_dai_link migor_dai = {
 	.cpu_dai_name = "siu-i2s-dai",
 	.codec_dai_name = "wm8978-hifi",
 	.platform_name = "siu-pcm-audio",
-	.codec_name = "wm8978-codec.0-001a",
+	.codec_name = "wm8978.0-001a",
 	.ops = &migor_dai_ops,
 	.init = migor_dai_init,
 };
-- 
1.7.1
