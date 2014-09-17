From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5677: Add the TDM function
Date: Wed, 17 Sep 2014 15:12:33 +0800
Message-ID: <1410937953-13884-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 79A752651CB
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 09:13:24 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the TDM function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 02bc8bd..1d4719f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3107,6 +3107,59 @@ static int rt5677_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	return 0;
 }
 
+static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val = 0;
+
+	if (rx_mask || tx_mask)
+		val |= (1 << 12);
+
+	switch (slots) {
+	case 4:
+		val |= (1 << 10);
+		break;
+	case 6:
+		val |= (2 << 10);
+		break;
+	case 8:
+		val |= (3 << 10);
+		break;
+	case 2:
+	default:
+		break;
+	}
+
+	switch (slot_width) {
+	case 20:
+		val |= (1 << 8);
+		break;
+	case 24:
+		val |= (2 << 8);
+		break;
+	case 32:
+		val |= (3 << 8);
+		break;
+	case 16:
+	default:
+		break;
+	}
+
+	switch (dai->id) {
+	case RT5677_AIF1:
+		snd_soc_update_bits(codec, RT5677_TDM1_CTRL1, 0x1f00, val);
+		break;
+	case RT5677_AIF2:
+		snd_soc_update_bits(codec, RT5677_TDM2_CTRL1, 0x1f00, val);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
@@ -3357,6 +3410,7 @@ static struct snd_soc_dai_ops rt5677_aif_dai_ops = {
 	.set_fmt = rt5677_set_dai_fmt,
 	.set_sysclk = rt5677_set_dai_sysclk,
 	.set_pll = rt5677_set_dai_pll,
+	.set_tdm_slot = rt5677_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver rt5677_dai[] = {
-- 
1.8.1.1.439.g50a6b54
