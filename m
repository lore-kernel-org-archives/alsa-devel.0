From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98090: Simplify
	max98090_readable_register implementation" to the asoc tree
Date: Wed, 29 Jul 2015 15:13:01 +0100
Message-ID: <E1ZKS6P-0004Wq-9e@finisterre>
References: <1437961183.10891.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E411A265150
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2015 16:13:18 +0200 (CEST)
In-Reply-To: <1437961183.10891.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98090: Simplify max98090_readable_register implementation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 62d6d47cb8bd5ace08a90a1cd78f6908e9f9c2d3 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 27 Jul 2015 09:39:43 +0800
Subject: [PATCH] ASoC: max98090: Simplify max98090_readable_register
 implementation

The readable registers are in consecutive ranges:
	0x01 ~ 0x03, 0x0D ~ 0xD1, 0xFF
So simplify the implementation by specifying a range of consecutive values
in a single case label.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98090.c | 71 ++-------------------------------------------
 1 file changed, 2 insertions(+), 69 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1697340..17ab597 100644
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
2.1.4
