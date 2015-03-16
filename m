From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: rt286: Drop unnecessary dapm
	bias_level initialization
Date: Mon, 16 Mar 2015 16:39:56 +0100
Message-ID: <1426520397-24263-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-126.synserver.de
 [212.40.185.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 679892612C9
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 16:39:53 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The default value for the bias_level is SND_SOC_BIAS_OFF when probe is being
called, there is no need to initialize it explicitly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/rt286.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index fb3f5d3..7bbe714 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1048,7 +1048,6 @@ static int rt286_probe(struct snd_soc_codec *codec)
 	struct rt286_priv *rt286 = snd_soc_codec_get_drvdata(codec);
 
 	rt286->codec = codec;
-	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 
 	if (rt286->i2c->irq) {
 		regmap_update_bits(rt286->regmap,
-- 
1.8.0
