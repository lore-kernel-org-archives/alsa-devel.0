From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5665: add ADC STO2 ASRC support
Date: Tue, 2 May 2017 11:00:39 +0800
Message-ID: <1493694039-7816-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 35C9226691F
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 05:00:54 +0200 (CEST)
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

"ADC Stereo2 Filter" is with ASRC supported.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 8cd2230..ece77b8 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2684,6 +2684,8 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 		RT5665_DAC_MONO_R_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5665_ASRC_1,
 		RT5665_ADC_STO1_ASRC_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5665_ASRC_1,
+		RT5665_ADC_STO2_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC Mono L ASRC", 1, RT5665_ASRC_1,
 		RT5665_ADC_MONO_L_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC Mono R ASRC", 1, RT5665_ASRC_1,
@@ -3227,6 +3229,7 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 
 	/*ASRC*/
 	{"ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc},
+	{"ADC Stereo2 Filter", NULL, "ADC STO2 ASRC", is_using_asrc},
 	{"ADC Mono Left Filter", NULL, "ADC Mono L ASRC", is_using_asrc},
 	{"ADC Mono Right Filter", NULL, "ADC Mono R ASRC", is_using_asrc},
 	{"DAC Mono Left Filter", NULL, "DAC Mono L ASRC", is_using_asrc},
-- 
2.7.4
