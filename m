From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: ac97-codec: Remove ASoC level IO support
Date: Sat, 23 Aug 2014 11:05:21 +0200
Message-ID: <1408784721-23501-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-093.synserver.de (smtp-out-093.synserver.de
 [212.40.185.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AF314261622
 for <alsa-devel@alsa-project.org>; Sat, 23 Aug 2014 11:05:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This driver doesn't use any ASoC level IO nor does it register any controls
or DAPM elements that require it. This means it can safely be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ac97.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index e889e1b..bd9b183 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -69,19 +69,6 @@ static struct snd_soc_dai_driver ac97_dai = {
 	.ops = &ac97_dai_ops,
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	return soc_ac97_ops->read(codec->ac97, reg);
-}
-
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
-{
-	soc_ac97_ops->write(codec->ac97, reg, val);
-	return 0;
-}
-
 static int ac97_soc_probe(struct snd_soc_codec *codec)
 {
 	struct snd_ac97_bus *ac97_bus;
@@ -122,8 +109,6 @@ static int ac97_soc_resume(struct snd_soc_codec *codec)
 #endif
 
 static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
-	.write =	ac97_write,
-	.read =		ac97_read,
 	.probe = 	ac97_soc_probe,
 	.suspend =	ac97_soc_suspend,
 	.resume =	ac97_soc_resume,
-- 
1.8.0
