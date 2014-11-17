From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 2/3] ASoC: rt5670: add DMIC ASRC support
Date: Mon, 17 Nov 2014 15:27:22 +0800
Message-ID: <1416209243-4879-2-git-send-email-bardliao@realtek.com>
References: <1416209243-4879-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EA602614E0
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 08:28:06 +0100 (CET)
In-Reply-To: <1416209243-4879-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch will enable ASRC for DMIC if ASRC is useable.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index fc26742..8a0833d 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1294,6 +1294,14 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
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
@@ -1650,6 +1658,10 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
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
