From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5670: add set_bclk_ratio in dai ops
Date: Tue, 12 Sep 2017 14:20:05 +0800
Message-ID: <1505197205-12237-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D03C266B23
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 08:20:16 +0200 (CEST)
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

We need to set a specific bit for 50 bclk rate. So add set_bclk_ratio
function to set the bit.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 9545764..dbdd01c 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2582,6 +2582,22 @@ static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	return 0;
 }
 
+static int rt5670_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
+	if (dai->id != RT5670_AIF1)
+		return 0;
+
+	if (ratio == 50)
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x0800, 0x0800);
+	else
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x0800, 0x0);
+
+	return 0;
+}
+
 static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
@@ -2712,6 +2728,7 @@ static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.set_fmt = rt5670_set_dai_fmt,
 	.set_tdm_slot = rt5670_set_tdm_slot,
 	.set_pll = rt5670_set_dai_pll,
+	.set_bclk_ratio = rt5670_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver rt5670_dai[] = {
-- 
2.7.4
