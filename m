From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5665: fix wrong pre div reg of IF2
	and IF3
Date: Mon, 20 Mar 2017 10:20:54 +0800
Message-ID: <1489976454-7441-2-git-send-email-bardliao@realtek.com>
References: <1489976454-7441-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id E09E526690C
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 03:21:12 +0100 (CET)
In-Reply-To: <1489976454-7441-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The pre divider control register of IF1 and IF2/3 are different.
The driver used the same register for all interfaces which was a
mistake.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 21b07ca..42bb5fd 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4080,7 +4080,7 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct rt5665_priv *rt5665 = snd_soc_codec_get_drvdata(codec);
-	unsigned int val_len = 0, val_clk, mask_clk, val_bits = 0x0100;
+	unsigned int val_len = 0, val_clk, reg_clk, mask_clk, val_bits = 0x0100;
 	int pre_div, frame_size;
 
 	rt5665->lrck[dai->id] = params_rate(params);
@@ -4124,6 +4124,7 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 		if (params_channels(params) > 2)
 			rt5665_set_tdm_slot(dai, 0xf, 0xf,
 				params_channels(params), params_width(params));
+		reg_clk = RT5665_ADDA_CLK_1;
 		mask_clk = RT5665_I2S_PD1_MASK;
 		val_clk = pre_div << RT5665_I2S_PD1_SFT;
 		snd_soc_update_bits(codec, RT5665_I2S1_SDP,
@@ -4131,12 +4132,14 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case RT5665_AIF2_1:
 	case RT5665_AIF2_2:
+		reg_clk = RT5665_ADDA_CLK_2;
 		mask_clk = RT5665_I2S_PD2_MASK;
 		val_clk = pre_div << RT5665_I2S_PD2_SFT;
 		snd_soc_update_bits(codec, RT5665_I2S2_SDP,
 			RT5665_I2S_DL_MASK, val_len);
 		break;
 	case RT5665_AIF3:
+		reg_clk = RT5665_ADDA_CLK_2;
 		mask_clk = RT5665_I2S_PD3_MASK;
 		val_clk = pre_div << RT5665_I2S_PD3_SFT;
 		snd_soc_update_bits(codec, RT5665_I2S3_SDP,
@@ -4147,7 +4150,7 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, RT5665_ADDA_CLK_1, mask_clk, val_clk);
+	snd_soc_update_bits(codec, reg_clk, mask_clk, val_clk);
 	snd_soc_update_bits(codec, RT5665_STO1_DAC_SIL_DET, 0x3700, val_bits);
 
 	switch (rt5665->lrck[dai->id]) {
-- 
2.7.4
