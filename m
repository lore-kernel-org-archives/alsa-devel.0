From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: 88pm860x-codec: Cleanup manual bias
	level transitions
Date: Sat,  6 Sep 2014 14:29:31 +0200
Message-ID: <1410006575-499-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D248264F0D
 for <alsa-devel@alsa-project.org>; Sat,  6 Sep 2014 14:29:41 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/88pm860x-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 922006d..4c3b0af 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1337,8 +1337,6 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 		}
 	}
 
-	pm860x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
 out:
@@ -1354,7 +1352,6 @@ static int pm860x_remove(struct snd_soc_codec *codec)
 
 	for (i = 3; i >= 0; i--)
 		free_irq(pm860x->irq[i], pm860x);
-	pm860x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-- 
1.8.0
