From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] ASoC: da732x: Cleanup manual bias level
	transitions
Date: Tue,  9 Sep 2014 20:42:45 +0200
Message-ID: <1410288165-32127-6-git-send-email-lars@metafoo.de>
References: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 3635026533D
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 20:42:49 +0200 (CEST)
In-Reply-To: <1410288165-32127-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/da732x.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index c28cf33..f35e83e 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1507,26 +1507,7 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int da732x_probe(struct snd_soc_codec *codec)
-{
-	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
-
-	da732x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
-static int da732x_remove(struct snd_soc_codec *codec)
-{
-
-	da732x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_da732x = {
-	.probe			= da732x_probe,
-	.remove			= da732x_remove,
 	.set_bias_level		= da732x_set_bias_level,
 	.controls		= da732x_snd_controls,
 	.num_controls		= ARRAY_SIZE(da732x_snd_controls),
-- 
1.8.0
