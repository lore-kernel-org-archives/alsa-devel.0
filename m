From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Check for exact register match in
	wm97xx_reset()
Date: Fri, 13 Jun 2008 15:39:12 +0100
Message-ID: <1213367953-32239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79AF21037F8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:39:14 +0200 (CEST)
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

To provide added robustness in case an AC97 controller reads back all
zeros in error cases check for an exact match when testing to see if
resets have brought the codec back.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9712.c |    4 ++--
 sound/soc/codecs/wm9713.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 28ac66f..09e2985 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -589,12 +589,12 @@ static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
 {
 	if (try_warm && soc_ac97_ops.warm_reset) {
 		soc_ac97_ops.warm_reset(codec->ac97);
-		if (!(ac97_read(codec, 0) & 0x8000))
+		if (ac97_read(codec, 0) == 0x6174)
 			return 1;
 	}
 
 	soc_ac97_ops.reset(codec->ac97);
-	if (ac97_read(codec, 0) & 0x8000)
+	if (ac97_read(codec, 0) != 0x6174)
 		goto err;
 	return 0;
 
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index aba3301..131bb5b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1076,12 +1076,12 @@ int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
 	if (try_warm && soc_ac97_ops.warm_reset) {
 		soc_ac97_ops.warm_reset(codec->ac97);
-		if (!(ac97_read(codec, 0) & 0x8000))
+		if (ac97_read(codec, 0) == 0x6174)
 			return 1;
 	}
 
 	soc_ac97_ops.reset(codec->ac97);
-	if (ac97_read(codec, 0) & 0x8000)
+	if (ac97_read(codec, 0) != 0x6174)
 		return -EIO;
 	return 0;
 }
-- 
1.5.5.4
