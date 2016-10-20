From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5660: enable MCLK detection
Date: Thu, 20 Oct 2016 10:13:44 +0800
Message-ID: <1476929624-6761-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 128D92665FC
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 04:14:01 +0200 (CEST)
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

There is a power saving mechanism in rt5660. It will turn off some
unused power when MCLK is not present. We call that "MCLK detection"
and it should be enabled by default.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5660.c | 4 ++++
 sound/soc/codecs/rt5660.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5660.c b/sound/soc/codecs/rt5660.c
index 9f0933c..76cf76a 100644
--- a/sound/soc/codecs/rt5660.c
+++ b/sound/soc/codecs/rt5660.c
@@ -1311,6 +1311,10 @@ static int rt5660_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
+	regmap_update_bits(rt5660->regmap, RT5660_GEN_CTRL1,
+		RT5660_AUTO_DIS_AMP | RT5660_MCLK_DET | RT5660_POW_CLKDET,
+		RT5660_AUTO_DIS_AMP | RT5660_MCLK_DET | RT5660_POW_CLKDET);
+
 	if (rt5660->pdata.dmic1_data_pin) {
 		regmap_update_bits(rt5660->regmap, RT5660_GPIO_CTRL1,
 			RT5660_GP1_PIN_MASK, RT5660_GP1_PIN_DMIC1_SCL);
diff --git a/sound/soc/codecs/rt5660.h b/sound/soc/codecs/rt5660.h
index 6cdb926..bba18fb6 100644
--- a/sound/soc/codecs/rt5660.h
+++ b/sound/soc/codecs/rt5660.h
@@ -810,6 +810,9 @@
 /* General Control 1 (0xfa) */
 #define RT5660_PWR_VREF_HP			(0x1 << 11)
 #define RT5660_PWR_VREF_HP_SFT			11
+#define RT5660_AUTO_DIS_AMP			(0x1 << 6)
+#define RT5660_MCLK_DET				(0x1 << 5)
+#define RT5660_POW_CLKDET			(0x1 << 1)
 #define RT5660_DIG_GATE_CTRL			(0x1)
 #define RT5660_DIG_GATE_CTRL_SFT		0
 
-- 
1.8.1.1.439.g50a6b54
