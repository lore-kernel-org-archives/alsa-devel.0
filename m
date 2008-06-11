From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/10] ASoC: Fix register cache sizes for
	Wolfson codecs
Date: Wed, 11 Jun 2008 13:47:06 +0100
Message-ID: <1213188435-1986-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 58FBA24380
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 14:47:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The register cache size is used by the codec_reg sysfs file which works in
terms of the register cache access functions rather than in terms of raw
access to the cache so the size specified needs to be in terms of the
number of elements.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    2 +-
 sound/soc/codecs/wm8750.c |    2 +-
 sound/soc/codecs/wm8753.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 5acf43a..7788053 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -534,7 +534,7 @@ static int wm8731_init(struct snd_soc_device *socdev)
 	codec->set_bias_level = wm8731_set_bias_level;
 	codec->dai = &wm8731_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = sizeof(wm8731_reg);
+	codec->reg_cache_size = ARRAY_SIZE(wm8731_reg);
 	codec->reg_cache = kmemdup(wm8731_reg, sizeof(wm8731_reg), GFP_KERNEL);
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/wm8750.c b/sound/soc/codecs/wm8750.c
index 1f11ad2..1ae670a 100644
--- a/sound/soc/codecs/wm8750.c
+++ b/sound/soc/codecs/wm8750.c
@@ -798,7 +798,7 @@ static int wm8750_init(struct snd_soc_device *socdev)
 	codec->set_bias_level = wm8750_set_bias_level;
 	codec->dai = &wm8750_dai;
 	codec->num_dai = 1;
-	codec->reg_cache_size = sizeof(wm8750_reg);
+	codec->reg_cache_size = ARRAY_SIZE(wm8750_reg);
 	codec->reg_cache = kmemdup(wm8750_reg, sizeof(wm8750_reg), GFP_KERNEL);
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index c32e632..285c5ea 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1557,7 +1557,7 @@ static int wm8753_init(struct snd_soc_device *socdev)
 	codec->set_bias_level = wm8753_set_bias_level;
 	codec->dai = wm8753_dai;
 	codec->num_dai = 2;
-	codec->reg_cache_size = sizeof(wm8753_reg);
+	codec->reg_cache_size = ARRAY_SIZE(wm8753_reg);
 	codec->reg_cache = kmemdup(wm8753_reg, sizeof(wm8753_reg), GFP_KERNEL);
 
 	if (codec->reg_cache == NULL)
-- 
1.5.5.3
