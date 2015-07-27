From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: max98090: Simplify
 max98090_readable_register implementation
Date: Mon, 27 Jul 2015 09:39:43 +0800
Message-ID: <1437961183.10891.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f170.google.com (mail-pd0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 3541F2605D7
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 03:39:51 +0200 (CEST)
Received: by pdrg1 with SMTP id g1so42623276pdr.2
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2015 18:39:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jerry Wong <jerry.wong@maximintegrated.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The readable registers are in consecutive ranges:
	0x01 ~ 0x03, 0x0D ~ 0xD1, 0xFF
So simplify the implementation by specifying a range of consecutive values
in a single case label.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/max98090.c | 71 ++-------------------------------------------
 1 file changed, 2 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 91c9f9f..315c71f 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -267,75 +267,8 @@ static bool max98090_volatile_register(struct device *dev, unsigned int reg)
 static bool max98090_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case M98090_REG_DEVICE_STATUS:
-	case M98090_REG_JACK_STATUS:
-	case M98090_REG_INTERRUPT_S:
-	case M98090_REG_RESERVED:
-	case M98090_REG_LINE_INPUT_CONFIG:
-	case M98090_REG_LINE_INPUT_LEVEL:
-	case M98090_REG_INPUT_MODE:
-	case M98090_REG_MIC1_INPUT_LEVEL:
-	case M98090_REG_MIC2_INPUT_LEVEL:
-	case M98090_REG_MIC_BIAS_VOLTAGE:
-	case M98090_REG_DIGITAL_MIC_ENABLE:
-	case M98090_REG_DIGITAL_MIC_CONFIG:
-	case M98090_REG_LEFT_ADC_MIXER:
-	case M98090_REG_RIGHT_ADC_MIXER:
-	case M98090_REG_LEFT_ADC_LEVEL:
-	case M98090_REG_RIGHT_ADC_LEVEL:
-	case M98090_REG_ADC_BIQUAD_LEVEL:
-	case M98090_REG_ADC_SIDETONE:
-	case M98090_REG_SYSTEM_CLOCK:
-	case M98090_REG_CLOCK_MODE:
-	case M98090_REG_CLOCK_RATIO_NI_MSB:
-	case M98090_REG_CLOCK_RATIO_NI_LSB:
-	case M98090_REG_CLOCK_RATIO_MI_MSB:
-	case M98090_REG_CLOCK_RATIO_MI_LSB:
-	case M98090_REG_MASTER_MODE:
-	case M98090_REG_INTERFACE_FORMAT:
-	case M98090_REG_TDM_CONTROL:
-	case M98090_REG_TDM_FORMAT:
-	case M98090_REG_IO_CONFIGURATION:
-	case M98090_REG_FILTER_CONFIG:
-	case M98090_REG_DAI_PLAYBACK_LEVEL:
-	case M98090_REG_DAI_PLAYBACK_LEVEL_EQ:
-	case M98090_REG_LEFT_HP_MIXER:
-	case M98090_REG_RIGHT_HP_MIXER:
-	case M98090_REG_HP_CONTROL:
-	case M98090_REG_LEFT_HP_VOLUME:
-	case M98090_REG_RIGHT_HP_VOLUME:
-	case M98090_REG_LEFT_SPK_MIXER:
-	case M98090_REG_RIGHT_SPK_MIXER:
-	case M98090_REG_SPK_CONTROL:
-	case M98090_REG_LEFT_SPK_VOLUME:
-	case M98090_REG_RIGHT_SPK_VOLUME:
-	case M98090_REG_DRC_TIMING:
-	case M98090_REG_DRC_COMPRESSOR:
-	case M98090_REG_DRC_EXPANDER:
-	case M98090_REG_DRC_GAIN:
-	case M98090_REG_RCV_LOUTL_MIXER:
-	case M98090_REG_RCV_LOUTL_CONTROL:
-	case M98090_REG_RCV_LOUTL_VOLUME:
-	case M98090_REG_LOUTR_MIXER:
-	case M98090_REG_LOUTR_CONTROL:
-	case M98090_REG_LOUTR_VOLUME:
-	case M98090_REG_JACK_DETECT:
-	case M98090_REG_INPUT_ENABLE:
-	case M98090_REG_OUTPUT_ENABLE:
-	case M98090_REG_LEVEL_CONTROL:
-	case M98090_REG_DSP_FILTER_ENABLE:
-	case M98090_REG_BIAS_CONTROL:
-	case M98090_REG_DAC_CONTROL:
-	case M98090_REG_ADC_CONTROL:
-	case M98090_REG_DEVICE_SHUTDOWN:
-	case M98090_REG_EQUALIZER_BASE ... M98090_REG_EQUALIZER_BASE + 0x68:
-	case M98090_REG_RECORD_BIQUAD_BASE ... M98090_REG_RECORD_BIQUAD_BASE + 0x0E:
-	case M98090_REG_DMIC3_VOLUME:
-	case M98090_REG_DMIC4_VOLUME:
-	case M98090_REG_DMIC34_BQ_PREATTEN:
-	case M98090_REG_RECORD_TDM_SLOT:
-	case M98090_REG_SAMPLE_RATE:
-	case M98090_REG_DMIC34_BIQUAD_BASE ... M98090_REG_DMIC34_BIQUAD_BASE + 0x0E:
+	case M98090_REG_DEVICE_STATUS ... M98090_REG_INTERRUPT_S:
+	case M98090_REG_LINE_INPUT_CONFIG ... 0xD1:
 	case M98090_REG_REVISION_ID:
 		return true;
 	default:
-- 
2.1.0
