From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: ak4535: Remove bitrotted driver
	version
Date: Thu, 16 Feb 2012 23:04:14 -0800
Message-ID: <1329462255-11374-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 654BE103A9D
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 08:04:22 +0100 (CET)
In-Reply-To: <1329462255-11374-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4535.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 71fca53..e13303a 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -27,8 +27,6 @@
 
 #include "ak4535.h"
 
-#define AK4535_VERSION "0.3"
-
 /* codec private data */
 struct ak4535_priv {
 	unsigned int sysclk;
@@ -372,8 +370,6 @@ static int ak4535_probe(struct snd_soc_codec *codec)
 	struct ak4535_priv *ak4535 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	printk(KERN_INFO "AK4535 Audio Codec %s", AK4535_VERSION);
-
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4535->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-- 
1.7.9.rc1
