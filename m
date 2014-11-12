From: <bardliao@realtek.com>
Subject: [PATCH 3/4] ASoC: rt5670: add DMIC ASRC support
Date: Wed, 12 Nov 2014 14:21:31 +0800
Message-ID: <1415773292-2299-3-git-send-email-bardliao@realtek.com>
References: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0FE26526D
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 07:22:02 +0100 (CET)
In-Reply-To: <1415773292-2299-1-git-send-email-bardliao@realtek.com>
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

This patch will enable ASRC for DMIC if ASRC is useable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 898b17f..89fa507 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1292,6 +1292,14 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 			      9, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("DAC MONO R ASRC", 1, RT5670_ASRC_1,
 			      8, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO1 ASRC", 1, RT5670_ASRC_1,
+			      7, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC STO2 ASRC", 1, RT5670_ASRC_1,
+			      6, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO L ASRC", 1, RT5670_ASRC_1,
+			      5, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("DMIC MONO R ASRC", 1, RT5670_ASRC_1,
+			      4, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5670_ASRC_1,
 			      3, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5670_ASRC_1,
@@ -1648,6 +1656,10 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "DAC Mono Left Filter", NULL, "DAC MONO L ASRC", is_using_asrc },
 	{ "DAC Mono Right Filter", NULL, "DAC MONO R ASRC", is_using_asrc },
 	{ "DAC Stereo1 Filter", NULL, "DAC STO ASRC", is_using_asrc },
+	{ "Stereo1 DMIC Mux", NULL, "DMIC STO1 ASRC", can_use_asrc },
+	{ "Stereo2 DMIC Mux", NULL, "DMIC STO2 ASRC", can_use_asrc },
+	{ "Mono DMIC L Mux", NULL, "DMIC MONO L ASRC", can_use_asrc },
+	{ "Mono DMIC R Mux", NULL, "DMIC MONO R ASRC", can_use_asrc },
 
 	{ "I2S1", NULL, "I2S1 ASRC", can_use_asrc},
 	{ "I2S2", NULL, "I2S2 ASRC", can_use_asrc},
-- 
1.8.1.1.439.g50a6b54
