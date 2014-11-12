From: <bardliao@realtek.com>
Subject: [PATCH 1/4] ASoC: rt5670: make bias level more
	reasonable
Date: Wed, 12 Nov 2014 14:21:29 +0800
Message-ID: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BFCAF265274
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 07:22:02 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patah separate bias level off to standby and off. The standby
level will provide the necessary power for JD and push button
functions.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index c4c42d5..85dc210 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2309,6 +2309,8 @@ static int rt5670_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
@@ -2330,16 +2332,27 @@ static int rt5670_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		snd_soc_write(codec, RT5670_PWR_DIG1, 0x0000);
-		snd_soc_write(codec, RT5670_PWR_DIG2, 0x0001);
-		snd_soc_write(codec, RT5670_PWR_VOL, 0x0000);
-		snd_soc_write(codec, RT5670_PWR_MIXER, 0x0001);
-		snd_soc_write(codec, RT5670_PWR_ANLG1, 0x2800);
-		snd_soc_write(codec, RT5670_PWR_ANLG2, 0x0004);
-		snd_soc_update_bits(codec, RT5670_DIG_MISC, 0x1, 0x0);
+		snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_PWR_VREF1 | RT5670_PWR_VREF2 |
+				RT5670_PWR_FV1 | RT5670_PWR_FV2, 0);
 		snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
 				RT5670_LDO_SEL_MASK, 0x1);
 		break;
+	case SND_SOC_BIAS_OFF:
+		if (rt5670->pdata.jd_mode)
+			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_PWR_VREF1 | RT5670_PWR_MB |
+				RT5670_PWR_BG | RT5670_PWR_VREF2 |
+				RT5670_PWR_FV1 | RT5670_PWR_FV2,
+				RT5670_PWR_MB | RT5670_PWR_BG);
+		else
+			snd_soc_update_bits(codec, RT5670_PWR_ANLG1,
+				RT5670_PWR_VREF1 | RT5670_PWR_MB |
+				RT5670_PWR_BG | RT5670_PWR_VREF2 |
+				RT5670_PWR_FV1 | RT5670_PWR_FV2, 0);
+
+		snd_soc_update_bits(codec, RT5670_DIG_MISC, 0x1, 0x0);
+		break;
 
 	default:
 		break;
-- 
1.8.1.1.439.g50a6b54
