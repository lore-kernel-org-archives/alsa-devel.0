From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: rt298: enable IRQ for jack detection
Date: Tue, 16 Feb 2016 17:12:34 +0800
Message-ID: <1455613956-14287-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D5B7265802
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 10:12:52 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

There are some registers needed for enabling rt298 IRQ missed on
current driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 6 ++++++
 sound/soc/codecs/rt298.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 30c6de6..e67ef5f 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1225,6 +1225,12 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt298->regmap,
 				RT298_WIND_FILTER_CTRL, 0x0082, 0x0082);
 	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
+
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_INLINE_CMD, 0x81);
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_HP_OUT, 0x82);
+	regmap_write(rt298->regmap, RT298_UNSOLICITED_MIC1, 0x84);
+	regmap_update_bits(rt298->regmap, RT298_IRQ_FLAG_CTRL, 0x2, 0x2);
+
 	rt298->is_hp_in = -1;
 
 	if (rt298->i2c->irq) {
diff --git a/sound/soc/codecs/rt298.h b/sound/soc/codecs/rt298.h
index 31da162..d66f884 100644
--- a/sound/soc/codecs/rt298.h
+++ b/sound/soc/codecs/rt298.h
@@ -34,6 +34,7 @@
 #define RT298_HP_OUT					0x21
 #define RT298_MIXER_IN1					0x22
 #define RT298_MIXER_IN2					0x23
+#define RT298_INLINE_CMD				0x55
 
 #define RT298_SET_PIN_SFT				6
 #define RT298_SET_PIN_ENABLE				0x40
@@ -124,6 +125,12 @@
 	VERB_CMD(AC_VERB_SET_COEF_INDEX, RT298_VENDOR_REGISTERS, 0)
 #define RT298_PROC_COEF\
 	VERB_CMD(AC_VERB_SET_PROC_COEF, RT298_VENDOR_REGISTERS, 0)
+#define RT298_UNSOLICITED_INLINE_CMD\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_INLINE_CMD, 0)
+#define RT298_UNSOLICITED_HP_OUT\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_HP_OUT, 0)
+#define RT298_UNSOLICITED_MIC1\
+	VERB_CMD(AC_VERB_SET_UNSOLICITED_ENABLE, RT298_MIC1, 0)
 
 /* Index registers */
 #define RT298_A_BIAS_CTRL1	0x01
@@ -148,6 +155,7 @@
 #define RT298_DEPOP_CTRL2	0x67
 #define RT298_DEPOP_CTRL3	0x68
 #define RT298_DEPOP_CTRL4	0x69
+#define RT298_IRQ_FLAG_CTRL	0x7c
 
 /* SPDIF (0x06) */
 #define RT298_SPDIF_SEL_SFT	0
-- 
1.8.1.1.439.g50a6b54
