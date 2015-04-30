From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/6] ASoC: rt5645: remove RT5645_I2S_BCLK_MS1
	control
Date: Thu, 30 Apr 2015 18:18:42 +0800
Message-ID: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E13F02614E3
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:19:13 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

RT5645_I2S_BCLK_MS1 (reg 0x73 [5]) is reserverd in rt5645 and rt5650.
This function is move to TDM control. We can configure it by
snd_soc_dai_set_tdm_slot's slot_width parameter.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 5 ++---
 sound/soc/codecs/rt5645.h | 4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 8bad9fe..33ebe88 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2104,9 +2104,8 @@ static int rt5645_hw_params(struct snd_pcm_substream *substream,
 
 	switch (dai->id) {
 	case RT5645_AIF1:
-		mask_clk = RT5645_I2S_BCLK_MS1_MASK | RT5645_I2S_PD1_MASK;
-		val_clk = bclk_ms << RT5645_I2S_BCLK_MS1_SFT |
-			pre_div << RT5645_I2S_PD1_SFT;
+		mask_clk = RT5645_I2S_PD1_MASK;
+		val_clk = pre_div << RT5645_I2S_PD1_SFT;
 		snd_soc_update_bits(codec, RT5645_I2S1_SDP,
 			(0x3 << dl_sft), (val_len << dl_sft));
 		snd_soc_update_bits(codec, RT5645_ADDA_CLK1, mask_clk, val_clk);
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 4473636..fa5c560 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -942,10 +942,6 @@
 #define RT5645_I2S2_SDI_I2S2			(0x1 << 6)
 
 /* ADC/DAC Clock Control 1 (0x73) */
-#define RT5645_I2S_BCLK_MS1_MASK		(0x1 << 15)
-#define RT5645_I2S_BCLK_MS1_SFT			15
-#define RT5645_I2S_BCLK_MS1_32			(0x0 << 15)
-#define RT5645_I2S_BCLK_MS1_64			(0x1 << 15)
 #define RT5645_I2S_PD1_MASK			(0x7 << 12)
 #define RT5645_I2S_PD1_SFT			12
 #define RT5645_I2S_PD1_1			(0x0 << 12)
-- 
1.8.1.1.439.g50a6b54
