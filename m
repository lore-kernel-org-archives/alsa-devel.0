From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Provide ADC left/right channel source
	selection on WM8994
Date: Thu, 18 Nov 2010 15:50:31 +0000
Message-ID: <1290095431-2774-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C6D481037F2
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 16:50:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow the application to choose if the ADC data presented on the left
and right channels is sourced from the internal left or right channel.
This allows a mono recording to be presented as stereo on the external
bus.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3ca734d..3c4d178 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -503,21 +503,33 @@ static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const char *aifdac_src_text[] = {
+static const char *aif_chan_src_text[] = {
 	"Left", "Right"
 };
 
+static const struct soc_enum aif1adcl_src =
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_1, 15, 2, aif_chan_src_text);
+
+static const struct soc_enum aif1adcr_src =
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_1, 14, 2, aif_chan_src_text);
+
+static const struct soc_enum aif2adcl_src =
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_1, 15, 2, aif_chan_src_text);
+
+static const struct soc_enum aif2adcr_src =
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_1, 14, 2, aif_chan_src_text);
+
 static const struct soc_enum aif1dacl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 15, 2, aifdac_src_text);
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 15, 2, aif_chan_src_text);
 
 static const struct soc_enum aif1dacr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 14, 2, aifdac_src_text);
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 14, 2, aif_chan_src_text);
 
 static const struct soc_enum aif2dacl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 15, 2, aifdac_src_text);
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 15, 2, aif_chan_src_text);
 
 static const struct soc_enum aif2dacr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aifdac_src_text);
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aif_chan_src_text);
 
 static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 {
@@ -692,6 +704,11 @@ SOC_DOUBLE_R_TLV("AIF2ADC Volume", WM8994_AIF2_ADC_LEFT_VOLUME,
 		 WM8994_AIF2_ADC_RIGHT_VOLUME,
 		 1, 119, 0, digital_tlv),
 
+SOC_ENUM("AIF1ADCL Source", aif1adcl_src),
+SOC_ENUM("AIF1ADCR Source", aif1adcr_src),
+SOC_ENUM("AIF2ADCL Source", aif1adcl_src),
+SOC_ENUM("AIF2ADCR Source", aif1adcr_src),
+
 SOC_ENUM("AIF1DACL Source", aif1dacl_src),
 SOC_ENUM("AIF1DACR Source", aif1dacr_src),
 SOC_ENUM("AIF2DACL Source", aif1dacl_src),
-- 
1.7.1
