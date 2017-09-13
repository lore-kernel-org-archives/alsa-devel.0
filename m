From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v3] ASoC: rt5670: add set_bclk_ratio in dai ops
Date: Wed, 13 Sep 2017 14:50:17 +0800
Message-ID: <1505285417-15211-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 697A7266943
 for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2017 08:50:29 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We need to set a specific bit for 50 bclk rate. So add set_bclk_ratio
function to set the bit.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
v2:
* add define for tdm data format select bit.
v3:
* change if (ratio == 50) to if ((ratio % 50) == 0) since the bit needs to be set if
  bclk ratio is divisible by 50.
---
 sound/soc/codecs/rt5670.c | 19 +++++++++++++++++++
 sound/soc/codecs/rt5670.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 9545764..78517d8 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2582,6 +2582,24 @@ static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
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
+	if ((ratio % 50) == 0)
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
+			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_50FS);
+	else
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3,
+			RT5670_TDM_DATA_MODE_SEL, RT5670_TDM_DATA_MODE_NOR);
+
+	return 0;
+}
+
 static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
@@ -2712,6 +2730,7 @@ static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.set_fmt = rt5670_set_dai_fmt,
 	.set_tdm_slot = rt5670_set_tdm_slot,
 	.set_pll = rt5670_set_dai_pll,
+	.set_bclk_ratio = rt5670_set_bclk_ratio,
 };
 
 static struct snd_soc_dai_driver rt5670_dai[] = {
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index 5ba485c..265df80 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1816,6 +1816,10 @@
 #define RT5670_ZCD_HP_DIS			(0x0 << 15)
 #define RT5670_ZCD_HP_EN			(0x1 << 15)
 
+/* General Control 3 (0xfc) */
+#define RT5670_TDM_DATA_MODE_SEL		(0x1 << 11)
+#define RT5670_TDM_DATA_MODE_NOR		(0x0 << 11)
+#define RT5670_TDM_DATA_MODE_50FS		(0x1 << 11)
 
 /* Codec Private Register definition */
 /* 3D Speaker Control (0x63) */
-- 
2.7.4
