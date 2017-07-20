From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5665: add clock sync control for
	master mode
Date: Thu, 20 Jul 2017 13:07:51 +0800
Message-ID: <1500527271-11188-3-git-send-email-bardliao@realtek.com>
References: <1500527271-11188-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 821BA2673AE
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

We can sleect the i2s clock source for each i2s bus in master mode.
The choice is depended on the HW design and the use case.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index ef27561..7e64b25 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1381,6 +1381,16 @@ static void rt5665_jack_detect_handler(struct work_struct *work)
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
+static const char * const rt5665_clk_sync[] = {
+	"I2S1_1", "I2S1_2", "I2S2", "I2S3", "IF2 Slave", "IF3 Slave"
+};
+
+static const struct soc_enum rt5665_enum[] = {
+	SOC_ENUM_SINGLE(RT5665_I2S1_SDP, 11, 5, rt5665_clk_sync),
+	SOC_ENUM_SINGLE(RT5665_I2S2_SDP, 11, 5, rt5665_clk_sync),
+	SOC_ENUM_SINGLE(RT5665_I2S3_SDP, 11, 5, rt5665_clk_sync),
+};
+
 static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 	/* Headphone Output Volume */
 	SOC_DOUBLE_R_EXT_TLV("Headphone Playback Volume", RT5665_HPL_GAIN,
@@ -1446,6 +1456,11 @@ static const struct snd_kcontrol_new rt5665_snd_controls[] = {
 	SOC_DOUBLE_TLV("STO2 ADC Boost Gain Volume", RT5665_STO2_ADC_BOOST,
 		RT5665_STO2_ADC_L_BST_SFT, RT5665_STO2_ADC_R_BST_SFT,
 		3, 0, adc_bst_tlv),
+
+	/* I2S3 CLK Source */
+	SOC_ENUM("I2S1 Master Clk Sel", rt5665_enum[0]),
+	SOC_ENUM("I2S2 Master Clk Sel", rt5665_enum[1]),
+	SOC_ENUM("I2S3 Master Clk Sel", rt5665_enum[2]),
 };
 
 /**
-- 
2.7.4
