From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: adau1373: Convert to direct regmap
	usage
Date: Fri, 27 Sep 2013 13:47:08 +0200
Message-ID: <1380282430-28159-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-078.synserver.de (smtp-out-078.synserver.de
 [212.40.185.78])
 by alsa0.perex.cz (Postfix) with ESMTP id F0E20265079
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 13:45:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/adau1373.c | 295 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 235 insertions(+), 60 deletions(-)

diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 1aa10dd..c57c1f8 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -32,6 +32,7 @@ struct adau1373_dai {
 };
 
 struct adau1373 {
+	struct regmap *regmap;
 	struct adau1373_dai dais[3];
 };
 
@@ -152,37 +153,172 @@ struct adau1373 {
 #define ADAU1373_EP_CTRL_MICBIAS1_OFFSET 4
 #define ADAU1373_EP_CTRL_MICBIAS2_OFFSET 2
 
-static const uint8_t adau1373_default_regs[] = {
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x00 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x10 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x20 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, /* 0x30 */
-	0x00, 0x00, 0x00, 0x80, 0x00, 0x01, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x0a, 0x0a, 0x0a, 0x00, /* 0x40 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00, /* 0x50 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x60 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0x70 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x78, 0x18, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, /* 0x80 */
-	0x00, 0xc0, 0x88, 0x7a, 0xdf, 0x20, 0x00, 0x00,
-	0x78, 0x18, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, /* 0x90 */
-	0x00, 0xc0, 0x88, 0x7a, 0xdf, 0x20, 0x00, 0x00,
-	0x78, 0x18, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, /* 0xa0 */
-	0x00, 0xc0, 0x88, 0x7a, 0xdf, 0x20, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, /* 0xb0 */
-	0xff, 0xff, 0xff, 0xff, 0xff, 0x1f, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xc0 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 0xd0 */
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, /* 0xe0 */
-	0x00, 0x1f, 0x0f, 0x00, 0x00,
+static const struct reg_default adau1373_reg_defaults[] = {
+	{ ADAU1373_INPUT_MODE,		0x00 },
+	{ ADAU1373_AINL_CTRL(0),	0x00 },
+	{ ADAU1373_AINR_CTRL(0),	0x00 },
+	{ ADAU1373_AINL_CTRL(1),	0x00 },
+	{ ADAU1373_AINR_CTRL(1),	0x00 },
+	{ ADAU1373_AINL_CTRL(2),	0x00 },
+	{ ADAU1373_AINR_CTRL(2),	0x00 },
+	{ ADAU1373_AINL_CTRL(3),	0x00 },
+	{ ADAU1373_AINR_CTRL(3),	0x00 },
+	{ ADAU1373_LLINE_OUT(0),	0x00 },
+	{ ADAU1373_RLINE_OUT(0),	0x00 },
+	{ ADAU1373_LLINE_OUT(1),	0x00 },
+	{ ADAU1373_RLINE_OUT(1),	0x00 },
+	{ ADAU1373_LSPK_OUT,		0x00 },
+	{ ADAU1373_RSPK_OUT,		0x00 },
+	{ ADAU1373_LHP_OUT,		0x00 },
+	{ ADAU1373_RHP_OUT,		0x00 },
+	{ ADAU1373_ADC_GAIN,		0x00 },
+	{ ADAU1373_LADC_MIXER,		0x00 },
+	{ ADAU1373_RADC_MIXER,		0x00 },
+	{ ADAU1373_LLINE1_MIX,		0x00 },
+	{ ADAU1373_RLINE1_MIX,		0x00 },
+	{ ADAU1373_LLINE2_MIX,		0x00 },
+	{ ADAU1373_RLINE2_MIX,		0x00 },
+	{ ADAU1373_LSPK_MIX,		0x00 },
+	{ ADAU1373_RSPK_MIX,		0x00 },
+	{ ADAU1373_LHP_MIX,		0x00 },
+	{ ADAU1373_RHP_MIX,		0x00 },
+	{ ADAU1373_EP_MIX,		0x00 },
+	{ ADAU1373_HP_CTRL,		0x00 },
+	{ ADAU1373_HP_CTRL2,		0x00 },
+	{ ADAU1373_LS_CTRL,		0x00 },
+	{ ADAU1373_EP_CTRL,		0x00 },
+	{ ADAU1373_MICBIAS_CTRL1,	0x00 },
+	{ ADAU1373_MICBIAS_CTRL2,	0x00 },
+	{ ADAU1373_OUTPUT_CTRL,		0x00 },
+	{ ADAU1373_PWDN_CTRL1,		0x00 },
+	{ ADAU1373_PWDN_CTRL2,		0x00 },
+	{ ADAU1373_PWDN_CTRL3,		0x00 },
+	{ ADAU1373_DPLL_CTRL(0),	0x00 },
+	{ ADAU1373_PLL_CTRL1(0),	0x00 },
+	{ ADAU1373_PLL_CTRL2(0),	0x00 },
+	{ ADAU1373_PLL_CTRL3(0),	0x00 },
+	{ ADAU1373_PLL_CTRL4(0),	0x00 },
+	{ ADAU1373_PLL_CTRL5(0),	0x00 },
+	{ ADAU1373_PLL_CTRL6(0),	0x02 },
+	{ ADAU1373_DPLL_CTRL(1),	0x00 },
+	{ ADAU1373_PLL_CTRL1(1),	0x00 },
+	{ ADAU1373_PLL_CTRL2(1),	0x00 },
+	{ ADAU1373_PLL_CTRL3(1),	0x00 },
+	{ ADAU1373_PLL_CTRL4(1),	0x00 },
+	{ ADAU1373_PLL_CTRL5(1),	0x00 },
+	{ ADAU1373_PLL_CTRL6(1),	0x02 },
+	{ ADAU1373_HEADDECT,		0x00 },
+	{ ADAU1373_ADC_CTRL,		0x00 },
+	{ ADAU1373_CLK_SRC_DIV(0),	0x00 },
+	{ ADAU1373_CLK_SRC_DIV(1),	0x00 },
+	{ ADAU1373_DAI(0),		0x0a },
+	{ ADAU1373_DAI(1),		0x0a },
+	{ ADAU1373_DAI(2),		0x0a },
+	{ ADAU1373_BCLKDIV(0),		0x00 },
+	{ ADAU1373_BCLKDIV(1),		0x00 },
+	{ ADAU1373_BCLKDIV(2),		0x00 },
+	{ ADAU1373_SRC_RATIOA(0),	0x00 },
+	{ ADAU1373_SRC_RATIOB(0),	0x00 },
+	{ ADAU1373_SRC_RATIOA(1),	0x00 },
+	{ ADAU1373_SRC_RATIOB(1),	0x00 },
+	{ ADAU1373_SRC_RATIOA(2),	0x00 },
+	{ ADAU1373_SRC_RATIOB(2),	0x00 },
+	{ ADAU1373_DEEMP_CTRL,		0x00 },
+	{ ADAU1373_SRC_DAI_CTRL(0),	0x08 },
+	{ ADAU1373_SRC_DAI_CTRL(1),	0x08 },
+	{ ADAU1373_SRC_DAI_CTRL(2),	0x08 },
+	{ ADAU1373_DIN_MIX_CTRL(0),	0x00 },
+	{ ADAU1373_DIN_MIX_CTRL(1),	0x00 },
+	{ ADAU1373_DIN_MIX_CTRL(2),	0x00 },
+	{ ADAU1373_DIN_MIX_CTRL(3),	0x00 },
+	{ ADAU1373_DIN_MIX_CTRL(4),	0x00 },
+	{ ADAU1373_DOUT_MIX_CTRL(0),	0x00 },
+	{ ADAU1373_DOUT_MIX_CTRL(1),	0x00 },
+	{ ADAU1373_DOUT_MIX_CTRL(2),	0x00 },
+	{ ADAU1373_DOUT_MIX_CTRL(3),	0x00 },
+	{ ADAU1373_DOUT_MIX_CTRL(4),	0x00 },
+	{ ADAU1373_DAI_PBL_VOL(0),	0x00 },
+	{ ADAU1373_DAI_PBR_VOL(0),	0x00 },
+	{ ADAU1373_DAI_PBL_VOL(1),	0x00 },
+	{ ADAU1373_DAI_PBR_VOL(1),	0x00 },
+	{ ADAU1373_DAI_PBL_VOL(2),	0x00 },
+	{ ADAU1373_DAI_PBR_VOL(2),	0x00 },
+	{ ADAU1373_DAI_RECL_VOL(0),	0x00 },
+	{ ADAU1373_DAI_RECR_VOL(0),	0x00 },
+	{ ADAU1373_DAI_RECL_VOL(1),	0x00 },
+	{ ADAU1373_DAI_RECR_VOL(1),	0x00 },
+	{ ADAU1373_DAI_RECL_VOL(2),	0x00 },
+	{ ADAU1373_DAI_RECR_VOL(2),	0x00 },
+	{ ADAU1373_DAC1_PBL_VOL,	0x00 },
+	{ ADAU1373_DAC1_PBR_VOL,	0x00 },
+	{ ADAU1373_DAC2_PBL_VOL,	0x00 },
+	{ ADAU1373_DAC2_PBR_VOL,	0x00 },
+	{ ADAU1373_ADC_RECL_VOL,	0x00 },
+	{ ADAU1373_ADC_RECR_VOL,	0x00 },
+	{ ADAU1373_DMIC_RECL_VOL,	0x00 },
+	{ ADAU1373_DMIC_RECR_VOL,	0x00 },
+	{ ADAU1373_VOL_GAIN1,		0x00 },
+	{ ADAU1373_VOL_GAIN2,		0x00 },
+	{ ADAU1373_VOL_GAIN3,		0x00 },
+	{ ADAU1373_HPF_CTRL,		0x00 },
+	{ ADAU1373_BASS1,		0x00 },
+	{ ADAU1373_BASS2,		0x00 },
+	{ ADAU1373_DRC(0) + 0x0,	0x78 },
+	{ ADAU1373_DRC(0) + 0x1,	0x18 },
+	{ ADAU1373_DRC(0) + 0x2,	0x00 },
+	{ ADAU1373_DRC(0) + 0x3,	0x00 },
+	{ ADAU1373_DRC(0) + 0x4,	0x00 },
+	{ ADAU1373_DRC(0) + 0x5,	0xc0 },
+	{ ADAU1373_DRC(0) + 0x6,	0x00 },
+	{ ADAU1373_DRC(0) + 0x7,	0x00 },
+	{ ADAU1373_DRC(0) + 0x8,	0x00 },
+	{ ADAU1373_DRC(0) + 0x9,	0xc0 },
+	{ ADAU1373_DRC(0) + 0xa,	0x88 },
+	{ ADAU1373_DRC(0) + 0xb,	0x7a },
+	{ ADAU1373_DRC(0) + 0xc,	0xdf },
+	{ ADAU1373_DRC(0) + 0xd,	0x20 },
+	{ ADAU1373_DRC(0) + 0xe,	0x00 },
+	{ ADAU1373_DRC(0) + 0xf,	0x00 },
+	{ ADAU1373_DRC(1) + 0x0,	0x78 },
+	{ ADAU1373_DRC(1) + 0x1,	0x18 },
+	{ ADAU1373_DRC(1) + 0x2,	0x00 },
+	{ ADAU1373_DRC(1) + 0x3,	0x00 },
+	{ ADAU1373_DRC(1) + 0x4,	0x00 },
+	{ ADAU1373_DRC(1) + 0x5,	0xc0 },
+	{ ADAU1373_DRC(1) + 0x6,	0x00 },
+	{ ADAU1373_DRC(1) + 0x7,	0x00 },
+	{ ADAU1373_DRC(1) + 0x8,	0x00 },
+	{ ADAU1373_DRC(1) + 0x9,	0xc0 },
+	{ ADAU1373_DRC(1) + 0xa,	0x88 },
+	{ ADAU1373_DRC(1) + 0xb,	0x7a },
+	{ ADAU1373_DRC(1) + 0xc,	0xdf },
+	{ ADAU1373_DRC(1) + 0xd,	0x20 },
+	{ ADAU1373_DRC(1) + 0xe,	0x00 },
+	{ ADAU1373_DRC(1) + 0xf,	0x00 },
+	{ ADAU1373_DRC(2) + 0x0,	0x78 },
+	{ ADAU1373_DRC(2) + 0x1,	0x18 },
+	{ ADAU1373_DRC(2) + 0x2,	0x00 },
+	{ ADAU1373_DRC(2) + 0x3,	0x00 },
+	{ ADAU1373_DRC(2) + 0x4,	0x00 },
+	{ ADAU1373_DRC(2) + 0x5,	0xc0 },
+	{ ADAU1373_DRC(2) + 0x6,	0x00 },
+	{ ADAU1373_DRC(2) + 0x7,	0x00 },
+	{ ADAU1373_DRC(2) + 0x8,	0x00 },
+	{ ADAU1373_DRC(2) + 0x9,	0xc0 },
+	{ ADAU1373_DRC(2) + 0xa,	0x88 },
+	{ ADAU1373_DRC(2) + 0xb,	0x7a },
+	{ ADAU1373_DRC(2) + 0xc,	0xdf },
+	{ ADAU1373_DRC(2) + 0xd,	0x20 },
+	{ ADAU1373_DRC(2) + 0xe,	0x00 },
+	{ ADAU1373_DRC(2) + 0xf,	0x00 },
+	{ ADAU1373_3D_CTRL1,		0x00 },
+	{ ADAU1373_3D_CTRL2,		0x00 },
+	{ ADAU1373_FDSP_SEL1,		0x00 },
+	{ ADAU1373_FDSP_SEL2,		0x00 },
+	{ ADAU1373_FDSP_SEL2,		0x00 },
+	{ ADAU1373_FDSP_SEL4,		0x00 },
+	{ ADAU1373_DIGMICCTRL,		0x00 },
+	{ ADAU1373_DIGEN,		0x00 },
 };
 
 static const unsigned int adau1373_out_tlv[] = {
@@ -418,6 +554,7 @@ static int adau1373_pll_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int pll_id = w->name[3] - '1';
 	unsigned int val;
 
@@ -426,7 +563,7 @@ static int adau1373_pll_event(struct snd_soc_dapm_widget *w,
 	else
 		val = 0;
 
-	snd_soc_update_bits(codec, ADAU1373_PLL_CTRL6(pll_id),
+	regmap_update_bits(adau1373->regmap, ADAU1373_PLL_CTRL6(pll_id),
 		ADAU1373_PLL_CTRL6_PLL_EN, val);
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
@@ -938,7 +1075,7 @@ static int adau1373_hw_params(struct snd_pcm_substream *substream,
 
 	adau1373_dai->enable_src = (div != 0);
 
-	snd_soc_update_bits(codec, ADAU1373_BCLKDIV(dai->id),
+	regmap_update_bits(adau1373->regmap, ADAU1373_BCLKDIV(dai->id),
 		ADAU1373_BCLKDIV_SR_MASK | ADAU1373_BCLKDIV_BCLK_MASK,
 		(div << 2) | ADAU1373_BCLKDIV_64);
 
@@ -959,7 +1096,7 @@ static int adau1373_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	return snd_soc_update_bits(codec, ADAU1373_DAI(dai->id),
+	return regmap_update_bits(adau1373->regmap, ADAU1373_DAI(dai->id),
 			ADAU1373_DAI_WLEN_MASK, ctrl);
 }
 
@@ -1016,7 +1153,7 @@ static int adau1373_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, ADAU1373_DAI(dai->id),
+	regmap_update_bits(adau1373->regmap, ADAU1373_DAI(dai->id),
 		~ADAU1373_DAI_WLEN_MASK, ctrl);
 
 	return 0;
@@ -1039,7 +1176,7 @@ static int adau1373_set_dai_sysclk(struct snd_soc_dai *dai,
 	adau1373_dai->sysclk = freq;
 	adau1373_dai->clk_src = clk_id;
 
-	snd_soc_update_bits(dai->codec, ADAU1373_BCLKDIV(dai->id),
+	regmap_update_bits(adau1373->regmap, ADAU1373_BCLKDIV(dai->id),
 		ADAU1373_BCLKDIV_SOURCE, clk_id << 5);
 
 	return 0;
@@ -1120,6 +1257,7 @@ static struct snd_soc_dai_driver adau1373_dai_driver[] = {
 static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
 	int source, unsigned int freq_in, unsigned int freq_out)
 {
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	unsigned int dpll_div = 0;
 	unsigned int x, r, n, m, i, j, mode;
 
@@ -1187,36 +1325,36 @@ static int adau1373_set_pll(struct snd_soc_codec *codec, int pll_id,
 
 	if (dpll_div) {
 		dpll_div = 11 - dpll_div;
-		snd_soc_update_bits(codec, ADAU1373_PLL_CTRL6(pll_id),
+		regmap_update_bits(adau1373->regmap, ADAU1373_PLL_CTRL6(pll_id),
 			ADAU1373_PLL_CTRL6_DPLL_BYPASS, 0);
 	} else {
-		snd_soc_update_bits(codec, ADAU1373_PLL_CTRL6(pll_id),
+		regmap_update_bits(adau1373->regmap, ADAU1373_PLL_CTRL6(pll_id),
 			ADAU1373_PLL_CTRL6_DPLL_BYPASS,
 			ADAU1373_PLL_CTRL6_DPLL_BYPASS);
 	}
 
-	snd_soc_write(codec, ADAU1373_DPLL_CTRL(pll_id),
+	regmap_write(adau1373->regmap, ADAU1373_DPLL_CTRL(pll_id),
 		(source << 4) | dpll_div);
-	snd_soc_write(codec, ADAU1373_PLL_CTRL1(pll_id), (m >> 8) & 0xff);
-	snd_soc_write(codec, ADAU1373_PLL_CTRL2(pll_id), m & 0xff);
-	snd_soc_write(codec, ADAU1373_PLL_CTRL3(pll_id), (n >> 8) & 0xff);
-	snd_soc_write(codec, ADAU1373_PLL_CTRL4(pll_id), n & 0xff);
-	snd_soc_write(codec, ADAU1373_PLL_CTRL5(pll_id),
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL1(pll_id), (m >> 8) & 0xff);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL2(pll_id), m & 0xff);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL3(pll_id), (n >> 8) & 0xff);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL4(pll_id), n & 0xff);
+	regmap_write(adau1373->regmap, ADAU1373_PLL_CTRL5(pll_id),
 		(r << 3) | (x << 1) | mode);
 
 	/* Set sysclk to pll_rate / 4 */
-	snd_soc_update_bits(codec, ADAU1373_CLK_SRC_DIV(pll_id), 0x3f, 0x09);
+	regmap_update_bits(adau1373->regmap, ADAU1373_CLK_SRC_DIV(pll_id), 0x3f, 0x09);
 
 	return 0;
 }
 
-static void adau1373_load_drc_settings(struct snd_soc_codec *codec,
+static void adau1373_load_drc_settings(struct adau1373 *adau1373,
 	unsigned int nr, uint8_t *drc)
 {
 	unsigned int i;
 
 	for (i = 0; i < ADAU1373_DRC_SIZE; ++i)
-		snd_soc_write(codec, ADAU1373_DRC(nr) + i, drc[i]);
+		regmap_write(adau1373->regmap, ADAU1373_DRC(nr) + i, drc[i]);
 }
 
 static bool adau1373_valid_micbias(enum adau1373_micbias_voltage micbias)
@@ -1235,13 +1373,14 @@ static bool adau1373_valid_micbias(enum adau1373_micbias_voltage micbias)
 
 static int adau1373_probe(struct snd_soc_codec *codec)
 {
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
 	struct adau1373_platform_data *pdata = codec->dev->platform_data;
 	bool lineout_differential = false;
 	unsigned int val;
 	int ret;
 	int i;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
+	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
 	if (ret) {
 		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1256,7 +1395,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 			return -EINVAL;
 
 		for (i = 0; i < pdata->num_drc; ++i) {
-			adau1373_load_drc_settings(codec, i,
+			adau1373_load_drc_settings(adau1373, i,
 				pdata->drc_setting[i]);
 		}
 
@@ -1268,18 +1407,18 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 			if (pdata->input_differential[i])
 				val |= BIT(i);
 		}
-		snd_soc_write(codec, ADAU1373_INPUT_MODE, val);
+		regmap_write(adau1373->regmap, ADAU1373_INPUT_MODE, val);
 
 		val = 0;
 		if (pdata->lineout_differential)
 			val |= ADAU1373_OUTPUT_CTRL_LDIFF;
 		if (pdata->lineout_ground_sense)
 			val |= ADAU1373_OUTPUT_CTRL_LNFBEN;
-		snd_soc_write(codec, ADAU1373_OUTPUT_CTRL, val);
+		regmap_write(adau1373->regmap, ADAU1373_OUTPUT_CTRL, val);
 
 		lineout_differential = pdata->lineout_differential;
 
-		snd_soc_write(codec, ADAU1373_EP_CTRL,
+		regmap_write(adau1373->regmap, ADAU1373_EP_CTRL,
 			(pdata->micbias1 << ADAU1373_EP_CTRL_MICBIAS1_OFFSET) |
 			(pdata->micbias2 << ADAU1373_EP_CTRL_MICBIAS2_OFFSET));
 	}
@@ -1289,7 +1428,7 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(adau1373_lineout2_controls));
 	}
 
-	snd_soc_write(codec, ADAU1373_ADC_CTRL,
+	regmap_write(adau1373->regmap, ADAU1373_ADC_CTRL,
 	    ADAU1373_ADC_CTRL_RESET_FORCE | ADAU1373_ADC_CTRL_PEAK_DETECT);
 
 	return 0;
@@ -1298,17 +1437,19 @@ static int adau1373_probe(struct snd_soc_codec *codec)
 static int adau1373_set_bias_level(struct snd_soc_codec *codec,
 	enum snd_soc_bias_level level)
 {
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_update_bits(codec, ADAU1373_PWDN_CTRL3,
+		regmap_update_bits(adau1373->regmap, ADAU1373_PWDN_CTRL3,
 			ADAU1373_PWDN_CTRL3_PWR_EN, ADAU1373_PWDN_CTRL3_PWR_EN);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_update_bits(codec, ADAU1373_PWDN_CTRL3,
+		regmap_update_bits(adau1373->regmap, ADAU1373_PWDN_CTRL3,
 			ADAU1373_PWDN_CTRL3_PWR_EN, 0);
 		break;
 	}
@@ -1324,17 +1465,49 @@ static int adau1373_remove(struct snd_soc_codec *codec)
 
 static int adau1373_suspend(struct snd_soc_codec *codec)
 {
-	return adau1373_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = adau1373_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	regcache_cache_only(adau1373->regmap, true);
+
+	return ret;
 }
 
 static int adau1373_resume(struct snd_soc_codec *codec)
 {
+	struct adau1373 *adau1373 = snd_soc_codec_get_drvdata(codec);
+
+	regcache_cache_only(adau1373->regmap, false);
 	adau1373_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	snd_soc_cache_sync(codec);
+	regcache_sync(adau1373->regmap);
 
 	return 0;
 }
 
+static bool adau1373_register_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADAU1373_SOFT_RESET:
+	case ADAU1373_ADC_DAC_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config adau1373_regmap_config = {
+	.val_bits = 8,
+	.reg_bits = 8,
+
+	.volatile_reg = adau1373_register_volatile,
+	.max_register = ADAU1373_SOFT_RESET,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = adau1373_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(adau1373_reg_defaults),
+};
+
 static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.probe =	adau1373_probe,
 	.remove =	adau1373_remove,
@@ -1342,9 +1515,6 @@ static struct snd_soc_codec_driver adau1373_codec_driver = {
 	.resume =	adau1373_resume,
 	.set_bias_level = adau1373_set_bias_level,
 	.idle_bias_off = true,
-	.reg_cache_size = ARRAY_SIZE(adau1373_default_regs),
-	.reg_cache_default = adau1373_default_regs,
-	.reg_word_size = sizeof(uint8_t),
 
 	.set_pll = adau1373_set_pll,
 
@@ -1366,6 +1536,11 @@ static int adau1373_i2c_probe(struct i2c_client *client,
 	if (!adau1373)
 		return -ENOMEM;
 
+	adau1373->regmap = devm_regmap_init_i2c(client,
+		&adau1373_regmap_config);
+	if (IS_ERR(adau1373->regmap))
+		return PTR_ERR(adau1373->regmap);
+
 	dev_set_drvdata(&client->dev, adau1373);
 
 	ret = snd_soc_register_codec(&client->dev, &adau1373_codec_driver,
-- 
1.8.0
