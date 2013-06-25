From: Mark Brown <broonie@linaro.org>
Subject: [PATCH] ASoC: stac9766: Remove version number
Date: Tue, 25 Jun 2013 17:07:25 +0100
Message-ID: <1372176445-8135-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4443926569C
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 18:07:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

There is no need to have versioning beyond that for the kernel, especially
when the version number never gets updated.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/stac9766.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 2eda85ba..cbc7ae3 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -28,8 +28,6 @@
 
 #include "stac9766.h"
 
-#define STAC9766_VERSION "0.10"
-
 /*
  * STAC9766 register cache
  */
@@ -338,8 +336,6 @@ static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
-	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
-
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
-- 
1.8.3.1
