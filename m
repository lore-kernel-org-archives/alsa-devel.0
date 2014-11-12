From: <bardliao@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5670: check if asrc is useable
Date: Wed, 12 Nov 2014 19:54:31 +0800
Message-ID: <1415793273-7844-2-git-send-email-bardliao@realtek.com>
References: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D8A1265598
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 12:55:00 +0100 (CET)
In-Reply-To: <1415793273-7844-1-git-send-email-bardliao@realtek.com>
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

To use ASRC, the sysclk should be faster than 384 times sample
rate of I2S1.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 85dc210..898b17f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -575,6 +575,17 @@ static int is_using_asrc(struct snd_soc_dapm_widget *source,
 
 }
 
+static int can_use_asrc(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink)
+{
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(source->codec);
+
+	if (rt5670->sysclk > rt5670->lrck[RT5670_AIF1] * 384)
+		return 1;
+
+	return 0;
+}
+
 /* Digital Mixer */
 static const struct snd_kcontrol_new rt5670_sto1_adc_l_mix[] = {
 	SOC_DAPM_SINGLE("ADC1 Switch", RT5670_STO1_ADC_MIXER,
@@ -1638,8 +1649,8 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "DAC Mono Right Filter", NULL, "DAC MONO R ASRC", is_using_asrc },
 	{ "DAC Stereo1 Filter", NULL, "DAC STO ASRC", is_using_asrc },
 
-	{ "I2S1", NULL, "I2S1 ASRC" },
-	{ "I2S2", NULL, "I2S2 ASRC" },
+	{ "I2S1", NULL, "I2S1 ASRC", can_use_asrc},
+	{ "I2S2", NULL, "I2S2 ASRC", can_use_asrc},
 
 	{ "DMIC1", NULL, "DMIC L1" },
 	{ "DMIC1", NULL, "DMIC R1" },
-- 
1.8.1.1.439.g50a6b54
