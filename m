From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add more width and channels
	support in the TDM mode
Date: Tue, 2 May 2017 10:42:56 +0800
Message-ID: <1493692976-7167-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D59D26691F
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 04:43:14 +0200 (CEST)
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

This patch adds more width and channels support in the TDM mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 23 +++++++++++++++++++++--
 sound/soc/codecs/rt5514.h |  6 ++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index f91221b..ff97360 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -906,9 +906,23 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	if (rx_mask || tx_mask)
 		val |= RT5514_TDM_MODE;
 
-	if (slots == 4)
+	switch (slots) {
+	case 4:
 		val |= RT5514_TDMSLOT_SEL_RX_4CH | RT5514_TDMSLOT_SEL_TX_4CH;
+		break;
+
+	case 6:
+		val |= RT5514_TDMSLOT_SEL_RX_6CH | RT5514_TDMSLOT_SEL_TX_6CH;
+		break;
+
+	case 8:
+		val |= RT5514_TDMSLOT_SEL_RX_8CH | RT5514_TDMSLOT_SEL_TX_8CH;
+		break;
 
+	case 2:
+	default:
+		break;
+	}
 
 	switch (slot_width) {
 	case 20:
@@ -919,6 +933,10 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		val |= RT5514_CH_LEN_RX_24 | RT5514_CH_LEN_TX_24;
 		break;
 
+	case 25:
+		val |= RT5514_TDM_MODE2;
+		break;
+
 	case 32:
 		val |= RT5514_CH_LEN_RX_32 | RT5514_CH_LEN_TX_32;
 		break;
@@ -930,7 +948,8 @@ static int rt5514_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	regmap_update_bits(rt5514->regmap, RT5514_I2S_CTRL1, RT5514_TDM_MODE |
 		RT5514_TDMSLOT_SEL_RX_MASK | RT5514_TDMSLOT_SEL_TX_MASK |
-		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK, val);
+		RT5514_CH_LEN_RX_MASK | RT5514_CH_LEN_TX_MASK |
+		RT5514_TDM_MODE2, val);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 5d343fb..02bc212 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -117,6 +117,8 @@
 #define RT5514_POW_ADCFEDL_BIT			0
 
 /* RT5514_I2S_CTRL1 (0x2010) */
+#define RT5514_TDM_MODE2			(0x1 << 30)
+#define RT5514_TDM_MODE2_SFT			30
 #define RT5514_TDM_MODE				(0x1 << 28)
 #define RT5514_TDM_MODE_SFT			28
 #define RT5514_I2S_LR_MASK			(0x1 << 26)
@@ -136,6 +138,8 @@
 #define RT5514_TDMSLOT_SEL_RX_MASK		(0x3 << 10)
 #define RT5514_TDMSLOT_SEL_RX_SFT		10
 #define RT5514_TDMSLOT_SEL_RX_4CH		(0x1 << 10)
+#define RT5514_TDMSLOT_SEL_RX_6CH		(0x2 << 10)
+#define RT5514_TDMSLOT_SEL_RX_8CH		(0x3 << 10)
 #define RT5514_CH_LEN_RX_MASK			(0x3 << 8)
 #define RT5514_CH_LEN_RX_SFT			8
 #define RT5514_CH_LEN_RX_16			(0x0 << 8)
@@ -145,6 +149,8 @@
 #define RT5514_TDMSLOT_SEL_TX_MASK		(0x3 << 6)
 #define RT5514_TDMSLOT_SEL_TX_SFT		6
 #define RT5514_TDMSLOT_SEL_TX_4CH		(0x1 << 6)
+#define RT5514_TDMSLOT_SEL_TX_6CH		(0x2 << 6)
+#define RT5514_TDMSLOT_SEL_TX_8CH		(0x3 << 6)
 #define RT5514_CH_LEN_TX_MASK			(0x3 << 4)
 #define RT5514_CH_LEN_TX_SFT			4
 #define RT5514_CH_LEN_TX_16			(0x0 << 4)
-- 
2.7.4
