From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/8] ASoC: rt5665: increase LDO level
Date: Wed, 8 Mar 2017 19:05:29 +0800
Message-ID: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA62266927
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Too low LDO level will cause a few functions unstable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index fe2cf1e..a4c07c2 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4798,7 +4798,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 	/* Enhance performance*/
 	regmap_update_bits(rt5665->regmap, RT5665_PWR_ANLG_1,
 		RT5665_HP_DRIVER_MASK | RT5665_LDO1_DVO_MASK,
-		RT5665_HP_DRIVER_5X | RT5665_LDO1_DVO_09);
+		RT5665_HP_DRIVER_5X | RT5665_LDO1_DVO_12);
 
 	INIT_DELAYED_WORK(&rt5665->jack_detect_work,
 				rt5665_jack_detect_handler);
-- 
2.7.4
