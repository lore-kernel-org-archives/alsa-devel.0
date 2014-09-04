From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/9] ASoC: ssm2518: Cleanup manual bias level
	transitions
Date: Thu,  4 Sep 2014 19:44:11 +0200
Message-ID: <1409852652-27939-9-git-send-email-lars@metafoo.de>
References: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBB62656E9
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
In-Reply-To: <1409852652-27939-1-git-send-email-lars@metafoo.de>
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

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_OFF at the end of CODEC probe()
can also be removed as the CODEC is already in OFF state at this point.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2518.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index e8680be..67ea55a 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -646,17 +646,6 @@ static struct snd_soc_dai_driver ssm2518_dai = {
 	.ops = &ssm2518_dai_ops,
 };
 
-static int ssm2518_probe(struct snd_soc_codec *codec)
-{
-	return ssm2518_set_bias_level(codec, SND_SOC_BIAS_OFF);
-}
-
-static int ssm2518_remove(struct snd_soc_codec *codec)
-{
-	ssm2518_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
 static int ssm2518_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 	int source, unsigned int freq, int dir)
 {
@@ -727,8 +716,6 @@ static int ssm2518_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 }
 
 static struct snd_soc_codec_driver ssm2518_codec_driver = {
-	.probe = ssm2518_probe,
-	.remove = ssm2518_remove,
 	.set_bias_level = ssm2518_set_bias_level,
 	.set_sysclk = ssm2518_set_sysclk,
 	.idle_bias_off = true,
-- 
1.8.0
