From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2] ASoC: rt5640: enable MCLK detection
Date: Mon, 17 Oct 2016 19:14:04 +0800
Message-ID: <1476702844-31473-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id DEBC9266A8F
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2016 13:14:33 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There is a power saving mechanism in rt5640. It will turn off some
unused power when MCLK is not present. We call that "MCLK detection"
and it should be enabled by default.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* Improve commit message.
---
 sound/soc/codecs/rt5640.c | 3 +++
 sound/soc/codecs/rt5640.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 3cc1135..0a7378f 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2407,6 +2407,9 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
+	regmap_update_bits(rt5640->regmap, RT5640_DUMMY1,
+				RT5640_MCLK_DET, RT5640_MCLK_DET);
+
 	if (rt5640->pdata.in1_diff)
 		regmap_update_bits(rt5640->regmap, RT5640_IN1_IN2,
 					RT5640_IN_DF1, RT5640_IN_DF1);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index 90c8871..22c017c 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -1970,6 +1970,8 @@
 #define RT5640_ZCD_HP_DIS			(0x0 << 15)
 #define RT5640_ZCD_HP_EN			(0x1 << 15)
 
+/* General Control 1 (0xfa) */
+#define RT5640_MCLK_DET				(0x1 << 11)
 
 /* Codec Private Register definition */
 /* 3D Speaker Control (0x63) */
-- 
1.8.1.1.439.g50a6b54
