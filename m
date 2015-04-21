From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: rt5645: Fix mask for setting
 RT5645_DMIC_2_DP_GPIO12 bit
Date: Tue, 21 Apr 2015 12:19:49 +0800
Message-ID: <1429589989.12465.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id EBDC32606C9
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 06:19:55 +0200 (CEST)
Received: by paboj16 with SMTP id oj16so228572097pab.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 21:19:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Current code uses wrong mask when setting RT5645_DMIC_2_DP_GPIO12 bit,
fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Bard,
I don't have the h/w to test, so please review and test this patch.
Thanks,
Axel
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 69528ae..a249f65 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2770,7 +2770,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 		case RT5645_DMIC_DATA_GPIO12:
 			regmap_update_bits(rt5645->regmap, RT5645_DMIC_CTRL1,
-				RT5645_DMIC_1_DP_MASK, RT5645_DMIC_2_DP_GPIO12);
+				RT5645_DMIC_2_DP_MASK, RT5645_DMIC_2_DP_GPIO12);
 			regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
 				RT5645_GP12_PIN_MASK,
 				RT5645_GP12_PIN_DMIC2_SDA);
-- 
2.1.0
