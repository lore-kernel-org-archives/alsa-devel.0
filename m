From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2 v2] ASoC: rt5677: Add the slot_width "25"
	support in the TDM mode
Date: Tue, 13 Jan 2015 11:13:15 +0800
Message-ID: <1421118795-23092-2-git-send-email-oder_chiou@realtek.com>
References: <1421118795-23092-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D3EC92614A1
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 04:13:25 +0100 (CET)
In-Reply-To: <1421118795-23092-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, yang.a.fang@intel.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add the slot_width "25" support in the TDM mode for the Intel platform.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 24fc592..a683e69 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4103,7 +4103,7 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val = 0;
+	unsigned int val = 0, slot_width_25 = 0;
 
 	if (rx_mask || tx_mask)
 		val |= (1 << 12);
@@ -4127,6 +4127,8 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	case 20:
 		val |= (1 << 8);
 		break;
+	case 25:
+		slot_width_25 = 0x8080;
 	case 24:
 		val |= (2 << 8);
 		break;
@@ -4142,10 +4144,14 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	case RT5677_AIF1:
 		regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL1, 0x1f00,
 			val);
+		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x8000,
+			slot_width_25);
 		break;
 	case RT5677_AIF2:
 		regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL1, 0x1f00,
 			val);
+		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x80,
+			slot_width_25);
 		break;
 	default:
 		break;
-- 
1.8.1.1.439.g50a6b54
