From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5677: Use the regmap functions
	instead of the snd_soc functions
Date: Tue, 13 Jan 2015 11:13:14 +0800
Message-ID: <1421118795-23092-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CA96C26147E
 for <alsa-devel@alsa-project.org>; Tue, 13 Jan 2015 04:13:25 +0100 (CET)
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

The patch uses the regmap functions instead of the snd_soc functions in some
cases.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 32c368c..24fc592 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -925,6 +925,8 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 static int is_using_asrc(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
+	struct snd_soc_codec *codec = source->codec;
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg, shift, val;
 
 	if (source->reg == RT5677_ASRC_1) {
@@ -991,7 +993,9 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 		}
 	}
 
-	val = (snd_soc_read(source->codec, reg) >> shift) & 0xf;
+	regmap_read(rt5677->regmap, reg, &val);
+	val = (val >> shift) & 0xf;
+
 	switch (val) {
 	case 1 ... 6:
 		return 1;
@@ -4098,6 +4102,7 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			unsigned int rx_mask, int slots, int slot_width)
 {
 	struct snd_soc_codec *codec = dai->codec;
+	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val = 0;
 
 	if (rx_mask || tx_mask)
@@ -4135,10 +4140,12 @@ static int rt5677_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 
 	switch (dai->id) {
 	case RT5677_AIF1:
-		snd_soc_update_bits(codec, RT5677_TDM1_CTRL1, 0x1f00, val);
+		regmap_update_bits(rt5677->regmap, RT5677_TDM1_CTRL1, 0x1f00,
+			val);
 		break;
 	case RT5677_AIF2:
-		snd_soc_update_bits(codec, RT5677_TDM2_CTRL1, 0x1f00, val);
+		regmap_update_bits(rt5677->regmap, RT5677_TDM2_CTRL1, 0x1f00,
+			val);
 		break;
 	default:
 		break;
-- 
1.8.1.1.439.g50a6b54
