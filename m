From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Support the TDM docking mode
Date: Thu, 20 Jul 2017 10:07:40 +0800
Message-ID: <1500516460-22008-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1562F267343
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 04:08:05 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, harshapriya.n@intel.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The TDM ducking mode can share the bus to other devices simultaneously.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 33 ++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5514.h | 12 ++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 4ca73bf..a105c84 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -871,11 +871,38 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5514_priv *rt5514 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val = 0;
+	unsigned int val = 0, val2 = 0;
 
 	if (rx_mask || tx_mask)
 		val |= RT5514_TDM_MODE;
 
+	switch (tx_mask) {
+	case 0x3:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH2 |
+			RT5514_TDM_DOCKING_START_SLOT0;
+		break;
+
+	case 0x30:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH2 |
+			RT5514_TDM_DOCKING_START_SLOT4;
+		break;
+
+	case 0xf:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH4 |
+			RT5514_TDM_DOCKING_START_SLOT0;
+		break;
+
+	case 0xf0:
+		val2 |= RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH4 |
+			RT5514_TDM_DOCKING_START_SLOT4;
+		break;
+
+	default:
+		break;
+	}
+
+
+
 	switch (slots) {
 	case 4:
 		val |= RT5514_TDMSLOT_SEL_RX_4CH | RT5514_TDMSLOT_SEL_TX_4CH;
@@ -921,6 +948,10 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK |
 		RT5514_TDM_MODE2, val);
 
+	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL2,
+		RT5514_TDM_DOCKING_MODE | RT5514_TDM_DOCKING_VALID_CH_MASK |
+		RT5514_TDM_DOCKING_START_MASK, val2);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 02bc212..75024a4 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -164,6 +164,18 @@
 #define RT5514_I2S_DL_24			(0x2 << 0)
 #define RT5514_I2S_DL_8				(0x3 << 0)
 
+/* RT5514_I2S_CTRL2 (0x2014) */
+#define RT5514_TDM_DOCKING_MODE			(0x1 << 31)
+#define RT5514_TDM_DOCKING_MODE_SFT		31
+#define RT5514_TDM_DOCKING_VALID_CH_MASK	(0x1 << 29)
+#define RT5514_TDM_DOCKING_VALID_CH_SFT		29
+#define RT5514_TDM_DOCKING_VALID_CH2		(0x0 << 29)
+#define RT5514_TDM_DOCKING_VALID_CH4		(0x1 << 29)
+#define RT5514_TDM_DOCKING_START_MASK		(0x1 << 28)
+#define RT5514_TDM_DOCKING_START_SFT		28
+#define RT5514_TDM_DOCKING_START_SLOT0		(0x0 << 28)
+#define RT5514_TDM_DOCKING_START_SLOT4		(0x1 << 28)
+
 /* RT5514_DIG_SOURCE_CTRL (0x20a4) */
 #define RT5514_AD1_DMIC_INPUT_SEL		(0x1 << 1)
 #define RT5514_AD1_DMIC_INPUT_SEL_SFT		1
-- 
2.7.4
