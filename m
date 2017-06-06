From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5663: Fix the IRQ issue
Date: Tue, 6 Jun 2017 14:59:54 +0800
Message-ID: <1496732394-21460-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 3513B2668E2
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 09:00:16 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch fixed the IRQ issue.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5663.c | 2 +-
 sound/soc/codecs/rt5663.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a32508d..8569e8c 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3141,7 +3141,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5663->regmap, RT5663_DIG_MISC,
 			RT5663_DIG_GATE_CTRL_MASK, RT5663_DIG_GATE_CTRL_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_AUTO_1MRC_CLK,
-			RT5663_IRQ_POW_SAV_MASK, RT5663_IRQ_POW_SAV_EN);
+			RT5663_IRQ_MANUAL_MASK, RT5663_IRQ_MANUAL_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_IRQ_1,
 			RT5663_EN_IRQ_JD1_MASK, RT5663_EN_IRQ_JD1_EN);
 		regmap_update_bits(rt5663->regmap, RT5663_GPIO_1,
diff --git a/sound/soc/codecs/rt5663.h b/sound/soc/codecs/rt5663.h
index d77fae6..4621812 100644
--- a/sound/soc/codecs/rt5663.h
+++ b/sound/soc/codecs/rt5663.h
@@ -590,6 +590,10 @@
 #define RT5663_IRQ_POW_SAV_JD1_SHIFT		14
 #define RT5663_IRQ_POW_SAV_JD1_DIS		(0x0 << 14)
 #define RT5663_IRQ_POW_SAV_JD1_EN		(0x1 << 14)
+#define RT5663_IRQ_MANUAL_MASK			(0x1 << 8)
+#define RT5663_IRQ_MANUAL_SHIFT			8
+#define RT5663_IRQ_MANUAL_DIS			(0x0 << 8)
+#define RT5663_IRQ_MANUAL_EN			(0x1 << 8)
 
 /* IRQ Control 1 (0x00b6) */
 #define RT5663_EN_CB_JD_MASK			(0x1 << 3)
-- 
2.7.4
