From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Implement WM8903 oversampling rate
	controls
Date: Fri, 10 Dec 2010 19:17:06 +0000
Message-ID: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4397245DF
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 20:17:12 +0100 (CET)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 797992c..542c7c4 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -481,6 +481,16 @@ static const char *hpf_mode_text[] = {
 static const struct soc_enum hpf_mode =
 	SOC_ENUM_SINGLE(WM8903_ADC_DIGITAL_0, 5, 4, hpf_mode_text);
 
+static const char *osr_text[] = {
+	"Low power", "High performance"
+};
+
+static const struct soc_enum adc_osr =
+	SOC_ENUM_SINGLE(WM8903_ANALOGUE_ADC_0, 0, 2, osr_text);
+
+static const struct soc_enum dac_osr =
+	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 0, 2, osr_text);
+
 static const char *drc_slope_text[] = {
 	"1", "1/2", "1/4", "1/8", "1/16", "0"
 };
@@ -619,6 +629,7 @@ SOC_SINGLE("Right Input PGA Common Mode Switch", WM8903_ANALOGUE_RIGHT_INPUT_1,
 	   6, 1, 0),
 
 /* ADCs */
+SOC_ENUM("ADC OSR", adc_osr),
 SOC_SINGLE("HPF Switch", WM8903_ADC_DIGITAL_0, 4, 1, 0),
 SOC_ENUM("HPF Mode", hpf_mode),
 SOC_SINGLE("DRC Switch", WM8903_DRC_0, 15, 1, 0),
@@ -650,6 +661,7 @@ SOC_DOUBLE_TLV("Digital Sidetone Volume", WM8903_DAC_DIGITAL_0, 4, 8,
 	       12, 0, digital_sidetone_tlv),
 
 /* DAC */
+SOC_ENUM("DAC OSR", dac_osr),
 SOC_DOUBLE_R_TLV("Digital Playback Volume", WM8903_DAC_DIGITAL_VOLUME_LEFT,
 		 WM8903_DAC_DIGITAL_VOLUME_RIGHT, 1, 120, 0, digital_tlv),
 SOC_ENUM("DAC Soft Mute Rate", soft_mute),
-- 
1.7.1
