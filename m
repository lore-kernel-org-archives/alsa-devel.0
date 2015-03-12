From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Add TDM support for rt5650
Date: Thu, 12 Mar 2015 20:25:07 +0800
Message-ID: <1426163107-32363-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D518426068A
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 13:25:19 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt5650 and rt5645 use different register bits for TDM configuration.
This patch modifies rt5645_set_tdm_slot to support both codecs.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index debf16c..af468ae 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2283,23 +2283,42 @@ static int rt5645_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	unsigned int val = 0;
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	unsigned int i_slot_sft, o_slot_sft, i_width_sht, o_width_sht, en_sft;
+	unsigned int mask, val = 0;
 
+	switch (rt5645->codec_type) {
+	case CODEC_TYPE_RT5650:
+		en_sft = 15;
+		i_slot_sft = 10;
+		o_slot_sft = 8;
+		i_width_sht = 6;
+		o_width_sht = 4;
+		mask = 0x8ff0;
+		break;
+	default:
+		en_sft = 14;
+		i_slot_sft = o_slot_sft = 12;
+		i_width_sht = o_width_sht = 10;
+		mask = 0x7c00;
+		break;
+	}
 	if (rx_mask || tx_mask) {
-		val |= (1 << 14);
-		snd_soc_update_bits(codec, RT5645_BASS_BACK,
-			RT5645_G_BB_BST_MASK, RT5645_G_BB_BST_25DB);
+		val |= (1 << en_sft);
+		if (rt5645->codec_type == CODEC_TYPE_RT5645)
+			snd_soc_update_bits(codec, RT5645_BASS_BACK,
+				RT5645_G_BB_BST_MASK, RT5645_G_BB_BST_25DB);
 	}
 
 	switch (slots) {
 	case 4:
-		val |= (1 << 12);
+		val |= (1 << i_slot_sft) | (1 << o_slot_sft);
 		break;
 	case 6:
-		val |= (2 << 12);
+		val |= (2 << i_slot_sft) | (2 << o_slot_sft);
 		break;
 	case 8:
-		val |= (3 << 12);
+		val |= (3 << i_slot_sft) | (3 << o_slot_sft);
 		break;
 	case 2:
 	default:
@@ -2308,20 +2327,20 @@ static int rt5645_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	switch (slot_width) {
 	case 20:
-		val |= (1 << 10);
+		val |= (1 << i_width_sht) | (1 << o_width_sht);
 		break;
 	case 24:
-		val |= (2 << 10);
+		val |= (2 << i_width_sht) | (2 << o_width_sht);
 		break;
 	case 32:
-		val |= (3 << 10);
+		val |= (3 << i_width_sht) | (3 << o_width_sht);
 		break;
 	case 16:
 	default:
 		break;
 	}
 
-	snd_soc_update_bits(codec, RT5645_TDM_CTRL_1, 0x7c00, val);
+	snd_soc_update_bits(codec, RT5645_TDM_CTRL_1, mask, val);
 
 	return 0;
 }
-- 
1.8.1.1.439.g50a6b54
