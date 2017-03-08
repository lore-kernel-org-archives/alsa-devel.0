From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: enable TDM if more than 2
	channels" to the asoc tree
Date: Wed, 08 Mar 2017 14:22:56 +0100
Message-ID: <E1clbYO-0000Gf-QG@finisterre>
References: <1488971136-19100-8-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 005B6267198
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 14:23:17 +0100 (CET)
In-Reply-To: <1488971136-19100-8-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: enable TDM if more than 2 channels

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 948059ddf93f4dfbb1f2f00885d2172b835a03b1 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 8 Mar 2017 19:05:36 +0800
Subject: [PATCH] ASoC: rt5665: enable TDM if more than 2 channels

TDM is necessary for more than 2 channels. And there is no control bit
to specify which slots are using. Machine driver will not need to call
snd_soc_dai_set_tdm_slot if we do it in rt5665_hw_params.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 114 ++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index de2c104bbaf3..b8c50ed72396 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -3964,6 +3964,62 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 	{"PDMR", NULL, "PDM R Playback"},
 };
 
+static int rt5665_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int val = 0;
+
+	if (rx_mask || tx_mask)
+		val |= RT5665_I2S1_MODE_TDM;
+
+	switch (slots) {
+	case 4:
+		val |= RT5665_TDM_IN_CH_4;
+		val |= RT5665_TDM_OUT_CH_4;
+		break;
+	case 6:
+		val |= RT5665_TDM_IN_CH_6;
+		val |= RT5665_TDM_OUT_CH_6;
+		break;
+	case 8:
+		val |= RT5665_TDM_IN_CH_8;
+		val |= RT5665_TDM_OUT_CH_8;
+		break;
+	case 2:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (slot_width) {
+	case 20:
+		val |= RT5665_TDM_IN_LEN_20;
+		val |= RT5665_TDM_OUT_LEN_20;
+		break;
+	case 24:
+		val |= RT5665_TDM_IN_LEN_24;
+		val |= RT5665_TDM_OUT_LEN_24;
+		break;
+	case 32:
+		val |= RT5665_TDM_IN_LEN_32;
+		val |= RT5665_TDM_OUT_LEN_32;
+		break;
+	case 16:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_update_bits(codec, RT5665_TDM_CTRL_1,
+		RT5665_I2S1_MODE_MASK | RT5665_TDM_IN_CH_MASK |
+		RT5665_TDM_OUT_CH_MASK | RT5665_TDM_IN_LEN_MASK |
+		RT5665_TDM_OUT_LEN_MASK, val);
+
+	return 0;
+}
+
+
 static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -4010,6 +4066,9 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case RT5665_AIF1_1:
 	case RT5665_AIF1_2:
+		if (params_channels(params) > 2)
+			rt5665_set_tdm_slot(dai, 0xf, 0xf,
+				params_channels(params), params_width(params));
 		mask_clk = RT5665_I2S_PD1_MASK;
 		val_clk = pre_div << RT5665_I2S_PD1_SFT;
 		snd_soc_update_bits(codec, RT5665_I2S1_SDP,
@@ -4227,61 +4286,6 @@ static int rt5665_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int Source,
 	return 0;
 }
 
-static int rt5665_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-			unsigned int rx_mask, int slots, int slot_width)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	unsigned int val = 0;
-
-	if (rx_mask || tx_mask)
-		val |= RT5665_I2S1_MODE_TDM;
-
-	switch (slots) {
-	case 4:
-		val |= RT5665_TDM_IN_CH_4;
-		val |= RT5665_TDM_OUT_CH_4;
-		break;
-	case 6:
-		val |= RT5665_TDM_IN_CH_6;
-		val |= RT5665_TDM_OUT_CH_6;
-		break;
-	case 8:
-		val |= RT5665_TDM_IN_CH_8;
-		val |= RT5665_TDM_OUT_CH_8;
-		break;
-	case 2:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	switch (slot_width) {
-	case 20:
-		val |= RT5665_TDM_IN_LEN_20;
-		val |= RT5665_TDM_OUT_LEN_20;
-		break;
-	case 24:
-		val |= RT5665_TDM_IN_LEN_24;
-		val |= RT5665_TDM_OUT_LEN_24;
-		break;
-	case 32:
-		val |= RT5665_TDM_IN_LEN_32;
-		val |= RT5665_TDM_OUT_LEN_32;
-		break;
-	case 16:
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	snd_soc_update_bits(codec, RT5665_TDM_CTRL_1,
-		RT5665_I2S1_MODE_MASK | RT5665_TDM_IN_CH_MASK |
-		RT5665_TDM_OUT_CH_MASK | RT5665_TDM_IN_LEN_MASK |
-		RT5665_TDM_OUT_LEN_MASK, val);
-
-	return 0;
-}
-
 static int rt5665_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
 	struct snd_soc_codec *codec = dai->codec;
-- 
2.11.0
