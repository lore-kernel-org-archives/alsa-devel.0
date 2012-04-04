From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: tlv320aic23: Remove driver-specific
	version number
Date: Wed,  4 Apr 2012 15:53:11 +0100
Message-ID: <1333551191-11485-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5C56246BB
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 16:53:15 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It's never been updated since the driver was merged.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/tlv320aic23.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 16d55f9..b0cafd3 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -34,8 +34,6 @@
 
 #include "tlv320aic23.h"
 
-#define AIC23_VERSION "0.1"
-
 /*
  * AIC23 register cache
  */
@@ -548,8 +546,6 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 	struct aic23 *aic23 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	printk(KERN_INFO "AIC23 Audio Codec %s\n", AIC23_VERSION);
-
 	ret = snd_soc_codec_set_cache_io(codec, 7, 9, aic23->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-- 
1.7.9.1
