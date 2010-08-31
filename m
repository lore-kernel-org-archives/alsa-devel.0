From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement WM8994 DAC data source muxes
Date: Wed,  1 Sep 2010 00:16:55 +0100
Message-ID: <1283296615-16328-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B13EC24699
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Sep 2010 01:16:43 +0200 (CEST)
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

Allow selection of the channel used for input to the AIFnDAC signals.
This isn't integrated into DAPM since we treat the data as a single
mono channel until just beyond this selection so it ends up having
no visible effect on the routing.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e03072c..c45ab00 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2072,6 +2072,22 @@ static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static const char *aifdac_src_text[] = {
+	"Left", "Right"
+};
+
+static const struct soc_enum aif1dacl_src =
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 15, 2, aifdac_src_text);
+
+static const struct soc_enum aif1dacr_src =
+	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 14, 2, aifdac_src_text);
+
+static const struct soc_enum aif2dacl_src =
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 15, 2, aifdac_src_text);
+
+static const struct soc_enum aif2dacr_src =
+	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aifdac_src_text);
+
 static const struct snd_kcontrol_new wm8994_snd_controls[] = {
 SOC_DOUBLE_R_TLV("AIF1ADC1 Volume", WM8994_AIF1_ADC1_LEFT_VOLUME,
 		 WM8994_AIF1_ADC1_RIGHT_VOLUME,
@@ -2083,6 +2099,11 @@ SOC_DOUBLE_R_TLV("AIF2ADC Volume", WM8994_AIF2_ADC_LEFT_VOLUME,
 		 WM8994_AIF2_ADC_RIGHT_VOLUME,
 		 1, 119, 0, digital_tlv),
 
+SOC_ENUM("AIF1DACL Source", aif1dacl_src),
+SOC_ENUM("AIF1DACR Source", aif1dacr_src),
+SOC_ENUM("AIF2DACL Source", aif1dacl_src),
+SOC_ENUM("AIF2DACR Source", aif1dacr_src),
+
 SOC_DOUBLE_R_TLV("AIF1DAC1 Volume", WM8994_AIF1_DAC1_LEFT_VOLUME,
 		 WM8994_AIF1_DAC1_RIGHT_VOLUME, 1, 96, 0, digital_tlv),
 SOC_DOUBLE_R_TLV("AIF1DAC2 Volume", WM8994_AIF1_DAC2_LEFT_VOLUME,
-- 
1.7.1
