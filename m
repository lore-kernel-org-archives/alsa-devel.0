From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/8] ASoC: rt5665: enhance jack type detection
	function
Date: Wed, 8 Mar 2017 19:05:30 +0800
Message-ID: <1488971136-19100-2-git-send-email-bardliao@realtek.com>
References: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF49266A33
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 12:05:47 +0100 (CET)
In-Reply-To: <1488971136-19100-1-git-send-email-bardliao@realtek.com>
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

Use manual mode for jack detection function to increase accuracy.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index a4c07c2..ecc02ee 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1192,10 +1192,13 @@ static int rt5665_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 
 		regmap_update_bits(rt5665->regmap, RT5665_EJD_CTRL_1,
-			0x180, 0x180);
+			0x1a0, 0x120);
 		regmap_write(rt5665->regmap, RT5665_EJD_CTRL_3, 0x3424);
+		regmap_write(rt5665->regmap, RT5665_IL_CMD_1, 0x0048);
 		regmap_write(rt5665->regmap, RT5665_SAR_IL_CMD_1, 0xa291);
 
+		usleep_range(10000, 15000);
+
 		rt5665->sar_adc_value = snd_soc_read(rt5665->codec,
 			RT5665_SAR_IL_CMD_4) & 0x7ff;
 
@@ -4779,7 +4782,7 @@ static int rt5665_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5665->regmap, RT5665_HP_LOGIC_CTRL_2, 0x0002);
 	regmap_update_bits(rt5665->regmap, RT5665_EJD_CTRL_1,
-		0xf000 | RT5665_VREF_POW_MASK, 0xd000 | RT5665_VREF_POW_REG);
+		0xf000 | RT5665_VREF_POW_MASK, 0xe000 | RT5665_VREF_POW_REG);
 	/* Work around for pow_pump */
 	regmap_update_bits(rt5665->regmap, RT5665_STO1_DAC_SIL_DET,
 		RT5665_DEB_STO_DAC_MASK, RT5665_DEB_80_MS);
-- 
2.7.4
