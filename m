From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5665: add clcok control for master
	mode
Date: Thu, 20 Jul 2017 13:07:50 +0800
Message-ID: <1500527271-11188-2-git-send-email-bardliao@realtek.com>
References: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E377267343
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 07:08:06 +0200 (CEST)
In-Reply-To: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add i2s clock control for codec master mode.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 24 +++++++++++++++++++++++-
 sound/soc/codecs/rt5665.h | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index d3103ef..ef27561 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4186,6 +4186,15 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
+	if (rt5665->master[RT5665_AIF2_1] || rt5665->master[RT5665_AIF2_2]) {
+		snd_soc_update_bits(codec, RT5665_I2S_M_CLK_CTRL_1,
+			RT5665_I2S2_M_PD_MASK, pre_div << RT5665_I2S2_M_PD_SFT);
+	}
+	if (rt5665->master[RT5665_AIF3]) {
+		snd_soc_update_bits(codec, RT5665_I2S_M_CLK_CTRL_1,
+			RT5665_I2S3_M_PD_MASK, pre_div << RT5665_I2S3_M_PD_SFT);
+	}
+
 	return 0;
 }
 
@@ -4262,7 +4271,7 @@ static int rt5665_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 				   int source, unsigned int freq, int dir)
 {
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
-	unsigned int reg_val = 0;
+	unsigned int reg_val = 0, src = 0;
 
 	if (freq == rt5665->sysclk && clk_id == rt5665->sysclk_src)
 		return 0;
@@ -4270,12 +4279,15 @@ static int rt5665_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 	switch (clk_id) {
 	case RT5665_SCLK_S_MCLK:
 		reg_val |= RT5665_SCLK_SRC_MCLK;
+		src = RT5665_CLK_SRC_MCLK;
 		break;
 	case RT5665_SCLK_S_PLL1:
 		reg_val |= RT5665_SCLK_SRC_PLL1;
+		src = RT5665_CLK_SRC_PLL1;
 		break;
 	case RT5665_SCLK_S_RCCLK:
 		reg_val |= RT5665_SCLK_SRC_RCCLK;
+		src = RT5665_CLK_SRC_RCCLK;
 		break;
 	default:
 		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
@@ -4283,6 +4295,16 @@ static int rt5665_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 	}
 	snd_soc_update_bits(codec, RT5665_GLB_CLK,
 		RT5665_SCLK_SRC_MASK, reg_val);
+
+	if (rt5665->master[RT5665_AIF2_1] || rt5665->master[RT5665_AIF2_2]) {
+		snd_soc_update_bits(codec, RT5665_I2S_M_CLK_CTRL_1,
+			RT5665_I2S2_SRC_MASK, src << RT5665_I2S2_SRC_SFT);
+	}
+	if (rt5665->master[RT5665_AIF3]) {
+		snd_soc_update_bits(codec, RT5665_I2S_M_CLK_CTRL_1,
+			RT5665_I2S3_SRC_MASK, src << RT5665_I2S3_SRC_SFT);
+	}
+
 	rt5665->sysclk = freq;
 	rt5665->sysclk_src = clk_id;
 
diff --git a/sound/soc/codecs/rt5665.h b/sound/soc/codecs/rt5665.h
index d95249c..5ddebd6 100644
--- a/sound/soc/codecs/rt5665.h
+++ b/sound/soc/codecs/rt5665.h
@@ -1628,6 +1628,27 @@
 #define RT5665_PWR_CLK1M_PD			(0x0 << 8)
 #define RT5665_PWR_CLK1M_PU			(0x1 << 8)
 
+/* I2S Master Mode Clock Control 1 (0x00a0) */
+#define RT5665_CLK_SRC_MCLK			(0x0)
+#define RT5665_CLK_SRC_PLL1			(0x1)
+#define RT5665_CLK_SRC_RCCLK			(0x2)
+#define RT5665_I2S_PD_1				(0x0)
+#define RT5665_I2S_PD_2				(0x1)
+#define RT5665_I2S_PD_3				(0x2)
+#define RT5665_I2S_PD_4				(0x3)
+#define RT5665_I2S_PD_6				(0x4)
+#define RT5665_I2S_PD_8				(0x5)
+#define RT5665_I2S_PD_12			(0x6)
+#define RT5665_I2S_PD_16			(0x7)
+#define RT5665_I2S2_SRC_MASK			(0x3 << 12)
+#define RT5665_I2S2_SRC_SFT			12
+#define RT5665_I2S2_M_PD_MASK			(0x7 << 8)
+#define RT5665_I2S2_M_PD_SFT			8
+#define RT5665_I2S3_SRC_MASK			(0x3 << 4)
+#define RT5665_I2S3_SRC_SFT			4
+#define RT5665_I2S3_M_PD_MASK			(0x7 << 0)
+#define RT5665_I2S3_M_PD_SFT			0
+
 
 /* EQ Control 1 (0x00b0) */
 #define RT5665_EQ_SRC_DAC			(0x0 << 15)
-- 
2.7.4
