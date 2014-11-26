From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/11] ASoC: tlv320aic3x: Cleanup manual bias
	level transitions
Date: Wed, 26 Nov 2014 20:57:57 +0100
Message-ID: <1417031880-11364-8-git-send-email-lars@metafoo.de>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-046.synserver.de (smtp-out-050.synserver.de
 [212.40.185.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B05392610B7
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 22:26:51 +0100 (CET)
In-Reply-To: <1417031880-11364-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic3x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index f0a8281..b7ebce0 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1491,7 +1491,6 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int i;
 
-	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	list_del(&aic3x->list);
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		regulator_unregister_notifier(aic3x->supplies[i].consumer,
-- 
1.8.0
