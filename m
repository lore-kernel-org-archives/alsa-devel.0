From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: make bias level more reasonale
Date: Tue, 4 Nov 2014 13:15:10 +0800
Message-ID: <1415078110-7381-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 067152605D6
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 06:15:50 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, yang.a.fang@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patah separate bias level off to standby and off. The standby
level will provide the necessary power for JD and push button
functions.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bc442f4..0e92e63 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2071,8 +2071,8 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
 	switch (level) {
-	case SND_SOC_BIAS_STANDBY:
-		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
+	case SND_SOC_BIAS_PREPARE:
+		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
 			snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_VREF1 | RT5645_PWR_MB |
 				RT5645_PWR_BG | RT5645_PWR_VREF2,
@@ -2087,15 +2087,24 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 
+	case SND_SOC_BIAS_STANDBY:
+		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
+			RT5645_PWR_VREF1 | RT5645_PWR_MB |
+			RT5645_PWR_BG | RT5645_PWR_VREF2,
+			RT5645_PWR_VREF1 | RT5645_PWR_MB |
+			RT5645_PWR_BG | RT5645_PWR_VREF2);
+		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
+			RT5645_PWR_FV1 | RT5645_PWR_FV2,
+			RT5645_PWR_FV1 | RT5645_PWR_FV2);
+		break;
+
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, RT5645_DEPOP_M2, 0x1100);
 		snd_soc_write(codec, RT5645_GEN_CTRL1, 0x0128);
-		snd_soc_write(codec, RT5645_PWR_DIG1, 0x0000);
-		snd_soc_write(codec, RT5645_PWR_DIG2, 0x0000);
-		snd_soc_write(codec, RT5645_PWR_VOL, 0x0000);
-		snd_soc_write(codec, RT5645_PWR_MIXER, 0x0000);
-		snd_soc_write(codec, RT5645_PWR_ANLG1, 0x0000);
-		snd_soc_write(codec, RT5645_PWR_ANLG2, 0x0000);
+		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
+				RT5645_PWR_VREF1 | RT5645_PWR_MB |
+				RT5645_PWR_BG | RT5645_PWR_VREF2 |
+				RT5645_PWR_FV1 | RT5645_PWR_FV2, 0x0);
 		break;
 
 	default:
-- 
1.8.1.1.439.g50a6b54
