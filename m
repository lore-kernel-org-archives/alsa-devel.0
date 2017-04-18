From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8540: fix tab conversion problem" to
	the asoc tree
Date: Tue, 18 Apr 2017 19:00:10 +0100
Message-ID: <E1d0XQA-0007D8-MD@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B7E8266DB4
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 20:00:20 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, John Hsu <KCHSU0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8540: fix tab conversion problem

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

>From babd658503a69c423aeab440f7d385f03ac54f7e Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Tue, 18 Apr 2017 10:32:04 +0800
Subject: [PATCH] ASoC: nau8540: fix tab conversion problem

Fix the tab converting to space problem.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8540.c | 1224 ++++++++++++++++++++++----------------------
 sound/soc/codecs/nau8540.h |  310 +++++------
 2 files changed, 767 insertions(+), 767 deletions(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index 9e8f0f4aa51a..c8bcb1db966d 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -39,147 +39,147 @@
 
 /* scaling for mclk from sysclk_src output */
 static const struct nau8540_fll_attr mclk_src_scaling[] = {
-       { 1, 0x0 },
-       { 2, 0x2 },
-       { 4, 0x3 },
-       { 8, 0x4 },
-       { 16, 0x5 },
-       { 32, 0x6 },
-       { 3, 0x7 },
-       { 6, 0xa },
-       { 12, 0xb },
-       { 24, 0xc },
+	{ 1, 0x0 },
+	{ 2, 0x2 },
+	{ 4, 0x3 },
+	{ 8, 0x4 },
+	{ 16, 0x5 },
+	{ 32, 0x6 },
+	{ 3, 0x7 },
+	{ 6, 0xa },
+	{ 12, 0xb },
+	{ 24, 0xc },
 };
 
 /* ratio for input clk freq */
 static const struct nau8540_fll_attr fll_ratio[] = {
-       { 512000, 0x01 },
-       { 256000, 0x02 },
-       { 128000, 0x04 },
-       { 64000, 0x08 },
-       { 32000, 0x10 },
-       { 8000, 0x20 },
-       { 4000, 0x40 },
+	{ 512000, 0x01 },
+	{ 256000, 0x02 },
+	{ 128000, 0x04 },
+	{ 64000, 0x08 },
+	{ 32000, 0x10 },
+	{ 8000, 0x20 },
+	{ 4000, 0x40 },
 };
 
 static const struct nau8540_fll_attr fll_pre_scalar[] = {
-       { 1, 0x0 },
-       { 2, 0x1 },
-       { 4, 0x2 },
-       { 8, 0x3 },
+	{ 1, 0x0 },
+	{ 2, 0x1 },
+	{ 4, 0x2 },
+	{ 8, 0x3 },
 };
 
 /* over sampling rate */
 static const struct nau8540_osr_attr osr_adc_sel[] = {
-       { 32, 3 },      /* OSR 32, SRC 1/8 */
-       { 64, 2 },      /* OSR 64, SRC 1/4 */
-       { 128, 1 },     /* OSR 128, SRC 1/2 */
-       { 256, 0 },     /* OSR 256, SRC 1 */
+	{ 32, 3 },	/* OSR 32, SRC 1/8 */
+	{ 64, 2 },	/* OSR 64, SRC 1/4 */
+	{ 128, 1 },	/* OSR 128, SRC 1/2 */
+	{ 256, 0 },	/* OSR 256, SRC 1 */
 };
 
 static const struct reg_default nau8540_reg_defaults[] = {
-       {NAU8540_REG_POWER_MANAGEMENT, 0x0000},
-       {NAU8540_REG_CLOCK_CTRL, 0x0000},
-       {NAU8540_REG_CLOCK_SRC, 0x0000},
-       {NAU8540_REG_FLL1, 0x0001},
-       {NAU8540_REG_FLL2, 0x3126},
-       {NAU8540_REG_FLL3, 0x0008},
-       {NAU8540_REG_FLL4, 0x0010},
-       {NAU8540_REG_FLL5, 0xC000},
-       {NAU8540_REG_FLL6, 0x6000},
-       {NAU8540_REG_FLL_VCO_RSV, 0xF13C},
-       {NAU8540_REG_PCM_CTRL0, 0x000B},
-       {NAU8540_REG_PCM_CTRL1, 0x3010},
-       {NAU8540_REG_PCM_CTRL2, 0x0800},
-       {NAU8540_REG_PCM_CTRL3, 0x0000},
-       {NAU8540_REG_PCM_CTRL4, 0x000F},
-       {NAU8540_REG_ALC_CONTROL_1, 0x0000},
-       {NAU8540_REG_ALC_CONTROL_2, 0x700B},
-       {NAU8540_REG_ALC_CONTROL_3, 0x0022},
-       {NAU8540_REG_ALC_CONTROL_4, 0x1010},
-       {NAU8540_REG_ALC_CONTROL_5, 0x1010},
-       {NAU8540_REG_NOTCH_FIL1_CH1, 0x0000},
-       {NAU8540_REG_NOTCH_FIL2_CH1, 0x0000},
-       {NAU8540_REG_NOTCH_FIL1_CH2, 0x0000},
-       {NAU8540_REG_NOTCH_FIL2_CH2, 0x0000},
-       {NAU8540_REG_NOTCH_FIL1_CH3, 0x0000},
-       {NAU8540_REG_NOTCH_FIL2_CH3, 0x0000},
-       {NAU8540_REG_NOTCH_FIL1_CH4, 0x0000},
-       {NAU8540_REG_NOTCH_FIL2_CH4, 0x0000},
-       {NAU8540_REG_HPF_FILTER_CH12, 0x0000},
-       {NAU8540_REG_HPF_FILTER_CH34, 0x0000},
-       {NAU8540_REG_ADC_SAMPLE_RATE, 0x0002},
-       {NAU8540_REG_DIGITAL_GAIN_CH1, 0x0400},
-       {NAU8540_REG_DIGITAL_GAIN_CH2, 0x0400},
-       {NAU8540_REG_DIGITAL_GAIN_CH3, 0x0400},
-       {NAU8540_REG_DIGITAL_GAIN_CH4, 0x0400},
-       {NAU8540_REG_DIGITAL_MUX, 0x00E4},
-       {NAU8540_REG_GPIO_CTRL, 0x0000},
-       {NAU8540_REG_MISC_CTRL, 0x0000},
-       {NAU8540_REG_I2C_CTRL, 0xEFFF},
-       {NAU8540_REG_VMID_CTRL, 0x0000},
-       {NAU8540_REG_MUTE, 0x0000},
-       {NAU8540_REG_ANALOG_ADC1, 0x0011},
-       {NAU8540_REG_ANALOG_ADC2, 0x0020},
-       {NAU8540_REG_ANALOG_PWR, 0x0000},
-       {NAU8540_REG_MIC_BIAS, 0x0004},
-       {NAU8540_REG_REFERENCE, 0x0000},
-       {NAU8540_REG_FEPGA1, 0x0000},
-       {NAU8540_REG_FEPGA2, 0x0000},
-       {NAU8540_REG_FEPGA3, 0x0101},
-       {NAU8540_REG_FEPGA4, 0x0101},
-       {NAU8540_REG_PWR, 0x0000},
+	{NAU8540_REG_POWER_MANAGEMENT, 0x0000},
+	{NAU8540_REG_CLOCK_CTRL, 0x0000},
+	{NAU8540_REG_CLOCK_SRC, 0x0000},
+	{NAU8540_REG_FLL1, 0x0001},
+	{NAU8540_REG_FLL2, 0x3126},
+	{NAU8540_REG_FLL3, 0x0008},
+	{NAU8540_REG_FLL4, 0x0010},
+	{NAU8540_REG_FLL5, 0xC000},
+	{NAU8540_REG_FLL6, 0x6000},
+	{NAU8540_REG_FLL_VCO_RSV, 0xF13C},
+	{NAU8540_REG_PCM_CTRL0, 0x000B},
+	{NAU8540_REG_PCM_CTRL1, 0x3010},
+	{NAU8540_REG_PCM_CTRL2, 0x0800},
+	{NAU8540_REG_PCM_CTRL3, 0x0000},
+	{NAU8540_REG_PCM_CTRL4, 0x000F},
+	{NAU8540_REG_ALC_CONTROL_1, 0x0000},
+	{NAU8540_REG_ALC_CONTROL_2, 0x700B},
+	{NAU8540_REG_ALC_CONTROL_3, 0x0022},
+	{NAU8540_REG_ALC_CONTROL_4, 0x1010},
+	{NAU8540_REG_ALC_CONTROL_5, 0x1010},
+	{NAU8540_REG_NOTCH_FIL1_CH1, 0x0000},
+	{NAU8540_REG_NOTCH_FIL2_CH1, 0x0000},
+	{NAU8540_REG_NOTCH_FIL1_CH2, 0x0000},
+	{NAU8540_REG_NOTCH_FIL2_CH2, 0x0000},
+	{NAU8540_REG_NOTCH_FIL1_CH3, 0x0000},
+	{NAU8540_REG_NOTCH_FIL2_CH3, 0x0000},
+	{NAU8540_REG_NOTCH_FIL1_CH4, 0x0000},
+	{NAU8540_REG_NOTCH_FIL2_CH4, 0x0000},
+	{NAU8540_REG_HPF_FILTER_CH12, 0x0000},
+	{NAU8540_REG_HPF_FILTER_CH34, 0x0000},
+	{NAU8540_REG_ADC_SAMPLE_RATE, 0x0002},
+	{NAU8540_REG_DIGITAL_GAIN_CH1, 0x0400},
+	{NAU8540_REG_DIGITAL_GAIN_CH2, 0x0400},
+	{NAU8540_REG_DIGITAL_GAIN_CH3, 0x0400},
+	{NAU8540_REG_DIGITAL_GAIN_CH4, 0x0400},
+	{NAU8540_REG_DIGITAL_MUX, 0x00E4},
+	{NAU8540_REG_GPIO_CTRL, 0x0000},
+	{NAU8540_REG_MISC_CTRL, 0x0000},
+	{NAU8540_REG_I2C_CTRL, 0xEFFF},
+	{NAU8540_REG_VMID_CTRL, 0x0000},
+	{NAU8540_REG_MUTE, 0x0000},
+	{NAU8540_REG_ANALOG_ADC1, 0x0011},
+	{NAU8540_REG_ANALOG_ADC2, 0x0020},
+	{NAU8540_REG_ANALOG_PWR, 0x0000},
+	{NAU8540_REG_MIC_BIAS, 0x0004},
+	{NAU8540_REG_REFERENCE, 0x0000},
+	{NAU8540_REG_FEPGA1, 0x0000},
+	{NAU8540_REG_FEPGA2, 0x0000},
+	{NAU8540_REG_FEPGA3, 0x0101},
+	{NAU8540_REG_FEPGA4, 0x0101},
+	{NAU8540_REG_PWR, 0x0000},
 };
 
 static bool nau8540_readable_reg(struct device *dev, unsigned int reg)
 {
-       switch (reg) {
-       case NAU8540_REG_POWER_MANAGEMENT ... NAU8540_REG_FLL_VCO_RSV:
-       case NAU8540_REG_PCM_CTRL0 ... NAU8540_REG_PCM_CTRL4:
-       case NAU8540_REG_ALC_CONTROL_1 ... NAU8540_REG_ALC_CONTROL_5:
-       case NAU8540_REG_ALC_GAIN_CH12 ... NAU8540_REG_ADC_SAMPLE_RATE:
-       case NAU8540_REG_DIGITAL_GAIN_CH1 ... NAU8540_REG_DIGITAL_MUX:
-       case NAU8540_REG_P2P_CH1 ... NAU8540_REG_I2C_CTRL:
-       case NAU8540_REG_I2C_DEVICE_ID:
-       case NAU8540_REG_VMID_CTRL ... NAU8540_REG_MUTE:
-       case NAU8540_REG_ANALOG_ADC1 ... NAU8540_REG_PWR:
-               return true;
-       default:
-               return false;
-       }
+	switch (reg) {
+	case NAU8540_REG_POWER_MANAGEMENT ... NAU8540_REG_FLL_VCO_RSV:
+	case NAU8540_REG_PCM_CTRL0 ... NAU8540_REG_PCM_CTRL4:
+	case NAU8540_REG_ALC_CONTROL_1 ... NAU8540_REG_ALC_CONTROL_5:
+	case NAU8540_REG_ALC_GAIN_CH12 ... NAU8540_REG_ADC_SAMPLE_RATE:
+	case NAU8540_REG_DIGITAL_GAIN_CH1 ... NAU8540_REG_DIGITAL_MUX:
+	case NAU8540_REG_P2P_CH1 ... NAU8540_REG_I2C_CTRL:
+	case NAU8540_REG_I2C_DEVICE_ID:
+	case NAU8540_REG_VMID_CTRL ... NAU8540_REG_MUTE:
+	case NAU8540_REG_ANALOG_ADC1 ... NAU8540_REG_PWR:
+		return true;
+	default:
+		return false;
+	}
 
 }
 
 static bool nau8540_writeable_reg(struct device *dev, unsigned int reg)
 {
-       switch (reg) {
-       case NAU8540_REG_SW_RESET ... NAU8540_REG_FLL_VCO_RSV:
-       case NAU8540_REG_PCM_CTRL0 ... NAU8540_REG_PCM_CTRL4:
-       case NAU8540_REG_ALC_CONTROL_1 ... NAU8540_REG_ALC_CONTROL_5:
-       case NAU8540_REG_NOTCH_FIL1_CH1 ... NAU8540_REG_ADC_SAMPLE_RATE:
-       case NAU8540_REG_DIGITAL_GAIN_CH1 ... NAU8540_REG_DIGITAL_MUX:
-       case NAU8540_REG_GPIO_CTRL ... NAU8540_REG_I2C_CTRL:
-       case NAU8540_REG_RST:
-       case NAU8540_REG_VMID_CTRL ... NAU8540_REG_MUTE:
-       case NAU8540_REG_ANALOG_ADC1 ... NAU8540_REG_PWR:
-               return true;
-       default:
-               return false;
-       }
+	switch (reg) {
+	case NAU8540_REG_SW_RESET ... NAU8540_REG_FLL_VCO_RSV:
+	case NAU8540_REG_PCM_CTRL0 ... NAU8540_REG_PCM_CTRL4:
+	case NAU8540_REG_ALC_CONTROL_1 ... NAU8540_REG_ALC_CONTROL_5:
+	case NAU8540_REG_NOTCH_FIL1_CH1 ... NAU8540_REG_ADC_SAMPLE_RATE:
+	case NAU8540_REG_DIGITAL_GAIN_CH1 ... NAU8540_REG_DIGITAL_MUX:
+	case NAU8540_REG_GPIO_CTRL ... NAU8540_REG_I2C_CTRL:
+	case NAU8540_REG_RST:
+	case NAU8540_REG_VMID_CTRL ... NAU8540_REG_MUTE:
+	case NAU8540_REG_ANALOG_ADC1 ... NAU8540_REG_PWR:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static bool nau8540_volatile_reg(struct device *dev, unsigned int reg)
 {
-       switch (reg) {
-       case NAU8540_REG_SW_RESET:
-       case NAU8540_REG_ALC_GAIN_CH12 ... NAU8540_REG_ALC_STATUS:
-       case NAU8540_REG_P2P_CH1 ... NAU8540_REG_PEAK_CH4:
-       case NAU8540_REG_I2C_DEVICE_ID:
-       case NAU8540_REG_RST:
-               return true;
-       default:
-               return false;
-       }
+	switch (reg) {
+	case NAU8540_REG_SW_RESET:
+	case NAU8540_REG_ALC_GAIN_CH12 ... NAU8540_REG_ALC_STATUS:
+	case NAU8540_REG_P2P_CH1 ... NAU8540_REG_PEAK_CH4:
+	case NAU8540_REG_I2C_DEVICE_ID:
+	case NAU8540_REG_RST:
+		return true;
+	default:
+		return false;
+	}
 }
 
 
@@ -187,255 +187,255 @@ static const DECLARE_TLV_DB_MINMAX(adc_vol_tlv, -12800, 3600);
 static const DECLARE_TLV_DB_MINMAX(fepga_gain_tlv, -100, 3600);
 
 static const struct snd_kcontrol_new nau8540_snd_controls[] = {
-       SOC_SINGLE_TLV("Mic1 Volume", NAU8540_REG_DIGITAL_GAIN_CH1,
-               0, 0x520, 0, adc_vol_tlv),
-       SOC_SINGLE_TLV("Mic2 Volume", NAU8540_REG_DIGITAL_GAIN_CH2,
-               0, 0x520, 0, adc_vol_tlv),
-       SOC_SINGLE_TLV("Mic3 Volume", NAU8540_REG_DIGITAL_GAIN_CH3,
-               0, 0x520, 0, adc_vol_tlv),
-       SOC_SINGLE_TLV("Mic4 Volume", NAU8540_REG_DIGITAL_GAIN_CH4,
-               0, 0x520, 0, adc_vol_tlv),
-
-       SOC_SINGLE_TLV("Frontend PGA1 Volume", NAU8540_REG_FEPGA3,
-               0, 0x25, 0, fepga_gain_tlv),
-       SOC_SINGLE_TLV("Frontend PGA2 Volume", NAU8540_REG_FEPGA3,
-               8, 0x25, 0, fepga_gain_tlv),
-       SOC_SINGLE_TLV("Frontend PGA3 Volume", NAU8540_REG_FEPGA4,
-               0, 0x25, 0, fepga_gain_tlv),
-       SOC_SINGLE_TLV("Frontend PGA4 Volume", NAU8540_REG_FEPGA4,
-               8, 0x25, 0, fepga_gain_tlv),
+	SOC_SINGLE_TLV("Mic1 Volume", NAU8540_REG_DIGITAL_GAIN_CH1,
+		0, 0x520, 0, adc_vol_tlv),
+	SOC_SINGLE_TLV("Mic2 Volume", NAU8540_REG_DIGITAL_GAIN_CH2,
+		0, 0x520, 0, adc_vol_tlv),
+	SOC_SINGLE_TLV("Mic3 Volume", NAU8540_REG_DIGITAL_GAIN_CH3,
+		0, 0x520, 0, adc_vol_tlv),
+	SOC_SINGLE_TLV("Mic4 Volume", NAU8540_REG_DIGITAL_GAIN_CH4,
+		0, 0x520, 0, adc_vol_tlv),
+
+	SOC_SINGLE_TLV("Frontend PGA1 Volume", NAU8540_REG_FEPGA3,
+		0, 0x25, 0, fepga_gain_tlv),
+	SOC_SINGLE_TLV("Frontend PGA2 Volume", NAU8540_REG_FEPGA3,
+		8, 0x25, 0, fepga_gain_tlv),
+	SOC_SINGLE_TLV("Frontend PGA3 Volume", NAU8540_REG_FEPGA4,
+		0, 0x25, 0, fepga_gain_tlv),
+	SOC_SINGLE_TLV("Frontend PGA4 Volume", NAU8540_REG_FEPGA4,
+		8, 0x25, 0, fepga_gain_tlv),
 };
 
 static const char * const adc_channel[] = {
-       "ADC channel 1", "ADC channel 2", "ADC channel 3", "ADC channel 4"
+	"ADC channel 1", "ADC channel 2", "ADC channel 3", "ADC channel 4"
 };
 static SOC_ENUM_SINGLE_DECL(
-       digital_ch4_enum, NAU8540_REG_DIGITAL_MUX, 6, adc_channel);
+	digital_ch4_enum, NAU8540_REG_DIGITAL_MUX, 6, adc_channel);
 
 static const struct snd_kcontrol_new digital_ch4_mux =
-       SOC_DAPM_ENUM("Digital CH4 Select", digital_ch4_enum);
+	SOC_DAPM_ENUM("Digital CH4 Select", digital_ch4_enum);
 
 static SOC_ENUM_SINGLE_DECL(
-       digital_ch3_enum, NAU8540_REG_DIGITAL_MUX, 4, adc_channel);
+	digital_ch3_enum, NAU8540_REG_DIGITAL_MUX, 4, adc_channel);
 
 static const struct snd_kcontrol_new digital_ch3_mux =
-       SOC_DAPM_ENUM("Digital CH3 Select", digital_ch3_enum);
+	SOC_DAPM_ENUM("Digital CH3 Select", digital_ch3_enum);
 
 static SOC_ENUM_SINGLE_DECL(
-       digital_ch2_enum, NAU8540_REG_DIGITAL_MUX, 2, adc_channel);
+	digital_ch2_enum, NAU8540_REG_DIGITAL_MUX, 2, adc_channel);
 
 static const struct snd_kcontrol_new digital_ch2_mux =
-       SOC_DAPM_ENUM("Digital CH2 Select", digital_ch2_enum);
+	SOC_DAPM_ENUM("Digital CH2 Select", digital_ch2_enum);
 
 static SOC_ENUM_SINGLE_DECL(
-       digital_ch1_enum, NAU8540_REG_DIGITAL_MUX, 0, adc_channel);
+	digital_ch1_enum, NAU8540_REG_DIGITAL_MUX, 0, adc_channel);
 
 static const struct snd_kcontrol_new digital_ch1_mux =
-       SOC_DAPM_ENUM("Digital CH1 Select", digital_ch1_enum);
+	SOC_DAPM_ENUM("Digital CH1 Select", digital_ch1_enum);
 
 static const struct snd_soc_dapm_widget nau8540_dapm_widgets[] = {
-       SND_SOC_DAPM_SUPPLY("MICBIAS2", NAU8540_REG_MIC_BIAS, 11, 0, NULL, 0),
-       SND_SOC_DAPM_SUPPLY("MICBIAS1", NAU8540_REG_MIC_BIAS, 10, 0, NULL, 0),
-
-       SND_SOC_DAPM_INPUT("MIC1"),
-       SND_SOC_DAPM_INPUT("MIC2"),
-       SND_SOC_DAPM_INPUT("MIC3"),
-       SND_SOC_DAPM_INPUT("MIC4"),
-
-       SND_SOC_DAPM_PGA("Frontend PGA1", NAU8540_REG_PWR, 12, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("Frontend PGA2", NAU8540_REG_PWR, 13, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("Frontend PGA3", NAU8540_REG_PWR, 14, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("Frontend PGA4", NAU8540_REG_PWR, 15, 0, NULL, 0),
-
-       SND_SOC_DAPM_ADC("ADC1", NULL,
-               NAU8540_REG_POWER_MANAGEMENT, 0, 0),
-       SND_SOC_DAPM_ADC("ADC2", NULL,
-               NAU8540_REG_POWER_MANAGEMENT, 1, 0),
-       SND_SOC_DAPM_ADC("ADC3", NULL,
-               NAU8540_REG_POWER_MANAGEMENT, 2, 0),
-       SND_SOC_DAPM_ADC("ADC4", NULL,
-               NAU8540_REG_POWER_MANAGEMENT, 3, 0),
-
-       SND_SOC_DAPM_PGA("ADC CH1", NAU8540_REG_ANALOG_PWR, 0, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("ADC CH2", NAU8540_REG_ANALOG_PWR, 1, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("ADC CH3", NAU8540_REG_ANALOG_PWR, 2, 0, NULL, 0),
-       SND_SOC_DAPM_PGA("ADC CH4", NAU8540_REG_ANALOG_PWR, 3, 0, NULL, 0),
-
-       SND_SOC_DAPM_MUX("Digital CH4 Mux",
-               SND_SOC_NOPM, 0, 0, &digital_ch4_mux),
-       SND_SOC_DAPM_MUX("Digital CH3 Mux",
-               SND_SOC_NOPM, 0, 0, &digital_ch3_mux),
-       SND_SOC_DAPM_MUX("Digital CH2 Mux",
-               SND_SOC_NOPM, 0, 0, &digital_ch2_mux),
-       SND_SOC_DAPM_MUX("Digital CH1 Mux",
-               SND_SOC_NOPM, 0, 0, &digital_ch1_mux),
-
-       SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS2", NAU8540_REG_MIC_BIAS, 11, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MICBIAS1", NAU8540_REG_MIC_BIAS, 10, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("MIC3"),
+	SND_SOC_DAPM_INPUT("MIC4"),
+
+	SND_SOC_DAPM_PGA("Frontend PGA1", NAU8540_REG_PWR, 12, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Frontend PGA2", NAU8540_REG_PWR, 13, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Frontend PGA3", NAU8540_REG_PWR, 14, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Frontend PGA4", NAU8540_REG_PWR, 15, 0, NULL, 0),
+
+	SND_SOC_DAPM_ADC("ADC1", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 0, 0),
+	SND_SOC_DAPM_ADC("ADC2", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 1, 0),
+	SND_SOC_DAPM_ADC("ADC3", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 2, 0),
+	SND_SOC_DAPM_ADC("ADC4", NULL,
+		NAU8540_REG_POWER_MANAGEMENT, 3, 0),
+
+	SND_SOC_DAPM_PGA("ADC CH1", NAU8540_REG_ANALOG_PWR, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC CH2", NAU8540_REG_ANALOG_PWR, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC CH3", NAU8540_REG_ANALOG_PWR, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC CH4", NAU8540_REG_ANALOG_PWR, 3, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("Digital CH4 Mux",
+		SND_SOC_NOPM, 0, 0, &digital_ch4_mux),
+	SND_SOC_DAPM_MUX("Digital CH3 Mux",
+		SND_SOC_NOPM, 0, 0, &digital_ch3_mux),
+	SND_SOC_DAPM_MUX("Digital CH2 Mux",
+		SND_SOC_NOPM, 0, 0, &digital_ch2_mux),
+	SND_SOC_DAPM_MUX("Digital CH1 Mux",
+		SND_SOC_NOPM, 0, 0, &digital_ch1_mux),
+
+	SND_SOC_DAPM_AIF_OUT("AIFTX", "Capture", 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route nau8540_dapm_routes[] = {
-       {"Frontend PGA1", NULL, "MIC1"},
-       {"Frontend PGA2", NULL, "MIC2"},
-       {"Frontend PGA3", NULL, "MIC3"},
-       {"Frontend PGA4", NULL, "MIC4"},
-
-       {"ADC1", NULL, "Frontend PGA1"},
-       {"ADC2", NULL, "Frontend PGA2"},
-       {"ADC3", NULL, "Frontend PGA3"},
-       {"ADC4", NULL, "Frontend PGA4"},
-
-       {"ADC CH1", NULL, "ADC1"},
-       {"ADC CH2", NULL, "ADC2"},
-       {"ADC CH3", NULL, "ADC3"},
-       {"ADC CH4", NULL, "ADC4"},
-
-       {"ADC1", NULL, "MICBIAS1"},
-       {"ADC2", NULL, "MICBIAS1"},
-       {"ADC3", NULL, "MICBIAS2"},
-       {"ADC4", NULL, "MICBIAS2"},
-
-       {"Digital CH1 Mux", "ADC channel 1", "ADC CH1"},
-       {"Digital CH1 Mux", "ADC channel 2", "ADC CH2"},
-       {"Digital CH1 Mux", "ADC channel 3", "ADC CH3"},
-       {"Digital CH1 Mux", "ADC channel 4", "ADC CH4"},
-
-       {"Digital CH2 Mux", "ADC channel 1", "ADC CH1"},
-       {"Digital CH2 Mux", "ADC channel 2", "ADC CH2"},
-       {"Digital CH2 Mux", "ADC channel 3", "ADC CH3"},
-       {"Digital CH2 Mux", "ADC channel 4", "ADC CH4"},
-
-       {"Digital CH3 Mux", "ADC channel 1", "ADC CH1"},
-       {"Digital CH3 Mux", "ADC channel 2", "ADC CH2"},
-       {"Digital CH3 Mux", "ADC channel 3", "ADC CH3"},
-       {"Digital CH3 Mux", "ADC channel 4", "ADC CH4"},
-
-       {"Digital CH4 Mux", "ADC channel 1", "ADC CH1"},
-       {"Digital CH4 Mux", "ADC channel 2", "ADC CH2"},
-       {"Digital CH4 Mux", "ADC channel 3", "ADC CH3"},
-       {"Digital CH4 Mux", "ADC channel 4", "ADC CH4"},
-
-       {"AIFTX", NULL, "Digital CH1 Mux"},
-       {"AIFTX", NULL, "Digital CH2 Mux"},
-       {"AIFTX", NULL, "Digital CH3 Mux"},
-       {"AIFTX", NULL, "Digital CH4 Mux"},
+	{"Frontend PGA1", NULL, "MIC1"},
+	{"Frontend PGA2", NULL, "MIC2"},
+	{"Frontend PGA3", NULL, "MIC3"},
+	{"Frontend PGA4", NULL, "MIC4"},
+
+	{"ADC1", NULL, "Frontend PGA1"},
+	{"ADC2", NULL, "Frontend PGA2"},
+	{"ADC3", NULL, "Frontend PGA3"},
+	{"ADC4", NULL, "Frontend PGA4"},
+
+	{"ADC CH1", NULL, "ADC1"},
+	{"ADC CH2", NULL, "ADC2"},
+	{"ADC CH3", NULL, "ADC3"},
+	{"ADC CH4", NULL, "ADC4"},
+
+	{"ADC1", NULL, "MICBIAS1"},
+	{"ADC2", NULL, "MICBIAS1"},
+	{"ADC3", NULL, "MICBIAS2"},
+	{"ADC4", NULL, "MICBIAS2"},
+
+	{"Digital CH1 Mux", "ADC channel 1", "ADC CH1"},
+	{"Digital CH1 Mux", "ADC channel 2", "ADC CH2"},
+	{"Digital CH1 Mux", "ADC channel 3", "ADC CH3"},
+	{"Digital CH1 Mux", "ADC channel 4", "ADC CH4"},
+
+	{"Digital CH2 Mux", "ADC channel 1", "ADC CH1"},
+	{"Digital CH2 Mux", "ADC channel 2", "ADC CH2"},
+	{"Digital CH2 Mux", "ADC channel 3", "ADC CH3"},
+	{"Digital CH2 Mux", "ADC channel 4", "ADC CH4"},
+
+	{"Digital CH3 Mux", "ADC channel 1", "ADC CH1"},
+	{"Digital CH3 Mux", "ADC channel 2", "ADC CH2"},
+	{"Digital CH3 Mux", "ADC channel 3", "ADC CH3"},
+	{"Digital CH3 Mux", "ADC channel 4", "ADC CH4"},
+
+	{"Digital CH4 Mux", "ADC channel 1", "ADC CH1"},
+	{"Digital CH4 Mux", "ADC channel 2", "ADC CH2"},
+	{"Digital CH4 Mux", "ADC channel 3", "ADC CH3"},
+	{"Digital CH4 Mux", "ADC channel 4", "ADC CH4"},
+
+	{"AIFTX", NULL, "Digital CH1 Mux"},
+	{"AIFTX", NULL, "Digital CH2 Mux"},
+	{"AIFTX", NULL, "Digital CH3 Mux"},
+	{"AIFTX", NULL, "Digital CH4 Mux"},
 };
 
 static int nau8540_clock_check(struct nau8540 *nau8540, int rate, int osr)
 {
-       int osrate;
+	int osrate;
 
-       if (osr >= ARRAY_SIZE(osr_adc_sel))
-               return -EINVAL;
-       osrate = osr_adc_sel[osr].osr;
+	if (osr >= ARRAY_SIZE(osr_adc_sel))
+		return -EINVAL;
+	osrate = osr_adc_sel[osr].osr;
 
-       if (rate * osr > CLK_ADC_MAX) {
-               dev_err(nau8540->dev, "exceed the maximum frequency of CLK_ADC\n");
-               return -EINVAL;
-       }
+	if (rate * osr > CLK_ADC_MAX) {
+		dev_err(nau8540->dev, "exceed the maximum frequency of CLK_ADC\n");
+		return -EINVAL;
+	}
 
-       return 0;
+	return 0;
 }
 
 static int nau8540_hw_params(struct snd_pcm_substream *substream,
-       struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-       struct snd_soc_codec *codec = dai->codec;
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
-       unsigned int val_len = 0, osr;
-
-       /* CLK_ADC = OSR * FS
-        * ADC clock frequency is defined as Over Sampling Rate (OSR)
-        * multiplied by the audio sample rate (Fs). Note that the OSR and Fs
-        * values must be selected such that the maximum frequency is less
-        * than 6.144 MHz.
-        */
-       regmap_read(nau8540->regmap, NAU8540_REG_ADC_SAMPLE_RATE, &osr);
-       osr &= NAU8540_ADC_OSR_MASK;
-       if (nau8540_clock_check(nau8540, params_rate(params), osr))
-               return -EINVAL;
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
-               NAU8540_CLK_ADC_SRC_MASK,
-               osr_adc_sel[osr].clk_src << NAU8540_CLK_ADC_SRC_SFT);
-
-       switch (params_width(params)) {
-       case 16:
-               val_len |= NAU8540_I2S_DL_16;
-               break;
-       case 20:
-               val_len |= NAU8540_I2S_DL_20;
-               break;
-       case 24:
-               val_len |= NAU8540_I2S_DL_24;
-               break;
-       case 32:
-               val_len |= NAU8540_I2S_DL_32;
-               break;
-       default:
-               return -EINVAL;
-       }
-
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL0,
-               NAU8540_I2S_DL_MASK, val_len);
-
-       return 0;
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val_len = 0, osr;
+
+	/* CLK_ADC = OSR * FS
+	 * ADC clock frequency is defined as Over Sampling Rate (OSR)
+	 * multiplied by the audio sample rate (Fs). Note that the OSR and Fs
+	 * values must be selected such that the maximum frequency is less
+	 * than 6.144 MHz.
+	 */
+	regmap_read(nau8540->regmap, NAU8540_REG_ADC_SAMPLE_RATE, &osr);
+	osr &= NAU8540_ADC_OSR_MASK;
+	if (nau8540_clock_check(nau8540, params_rate(params), osr))
+		return -EINVAL;
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
+		NAU8540_CLK_ADC_SRC_MASK,
+		osr_adc_sel[osr].clk_src << NAU8540_CLK_ADC_SRC_SFT);
+
+	switch (params_width(params)) {
+	case 16:
+		val_len |= NAU8540_I2S_DL_16;
+		break;
+	case 20:
+		val_len |= NAU8540_I2S_DL_20;
+		break;
+	case 24:
+		val_len |= NAU8540_I2S_DL_24;
+		break;
+	case 32:
+		val_len |= NAU8540_I2S_DL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL0,
+		NAU8540_I2S_DL_MASK, val_len);
+
+	return 0;
 }
 
 static int nau8540_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-       struct snd_soc_codec *codec = dai->codec;
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
-       unsigned int ctrl1_val = 0, ctrl2_val = 0;
-
-       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-       case SND_SOC_DAIFMT_CBM_CFM:
-               ctrl2_val |= NAU8540_I2S_MS_MASTER;
-               break;
-       case SND_SOC_DAIFMT_CBS_CFS:
-               break;
-       default:
-               return -EINVAL;
-       }
-
-       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-       case SND_SOC_DAIFMT_NB_NF:
-               break;
-       case SND_SOC_DAIFMT_IB_NF:
-               ctrl1_val |= NAU8540_I2S_BP_INV;
-               break;
-       default:
-               return -EINVAL;
-       }
-
-       switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-       case SND_SOC_DAIFMT_I2S:
-               ctrl1_val |= NAU8540_I2S_DF_I2S;
-               break;
-       case SND_SOC_DAIFMT_LEFT_J:
-               ctrl1_val |= NAU8540_I2S_DF_LEFT;
-               break;
-       case SND_SOC_DAIFMT_RIGHT_J:
-               ctrl1_val |= NAU8540_I2S_DF_RIGTH;
-               break;
-       case SND_SOC_DAIFMT_DSP_A:
-               ctrl1_val |= NAU8540_I2S_DF_PCM_AB;
-               break;
-       case SND_SOC_DAIFMT_DSP_B:
-               ctrl1_val |= NAU8540_I2S_DF_PCM_AB;
-               ctrl1_val |= NAU8540_I2S_PCMB_EN;
-               break;
-       default:
-               return -EINVAL;
-       }
-
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL0,
-               NAU8540_I2S_DL_MASK | NAU8540_I2S_DF_MASK |
-               NAU8540_I2S_BP_INV | NAU8540_I2S_PCMB_EN, ctrl1_val);
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
-               NAU8540_I2S_MS_MASK | NAU8540_I2S_DO12_OE, ctrl2_val);
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
-               NAU8540_I2S_DO34_OE, 0);
-
-       return 0;
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	unsigned int ctrl1_val = 0, ctrl2_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		ctrl2_val |= NAU8540_I2S_MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1_val |= NAU8540_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl1_val |= NAU8540_I2S_DF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1_val |= NAU8540_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ctrl1_val |= NAU8540_I2S_DF_RIGTH;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1_val |= NAU8540_I2S_DF_PCM_AB;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl1_val |= NAU8540_I2S_DF_PCM_AB;
+		ctrl1_val |= NAU8540_I2S_PCMB_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL0,
+		NAU8540_I2S_DL_MASK | NAU8540_I2S_DF_MASK |
+		NAU8540_I2S_BP_INV | NAU8540_I2S_PCMB_EN, ctrl1_val);
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+		NAU8540_I2S_MS_MASK | NAU8540_I2S_DO12_OE, ctrl2_val);
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+		NAU8540_I2S_DO34_OE, 0);
+
+	return 0;
 }
 
 /**
@@ -451,55 +451,55 @@ static int nau8540_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
  * Configures a DAI for TDM operation. Only support 4 slots TDM.
  */
 static int nau8540_set_tdm_slot(struct snd_soc_dai *dai,
-       unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-       struct snd_soc_codec *codec = dai->codec;
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
-       unsigned int ctrl2_val = 0, ctrl4_val = 0;
-
-       if (slots > 4 || ((tx_mask & 0xf0) && (tx_mask & 0xf)))
-               return -EINVAL;
-
-       ctrl4_val |= (NAU8540_TDM_MODE | NAU8540_TDM_OFFSET_EN);
-       if (tx_mask & 0xf0) {
-               ctrl2_val = 4 * slot_width;
-               ctrl4_val |= (tx_mask >> 4);
-       } else {
-               ctrl4_val |= tx_mask;
-       }
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL4,
-               NAU8540_TDM_MODE | NAU8540_TDM_OFFSET_EN |
-               NAU8540_TDM_TX_MASK, ctrl4_val);
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
-               NAU8540_I2S_DO12_OE, NAU8540_I2S_DO12_OE);
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
-               NAU8540_I2S_DO34_OE | NAU8540_I2S_TSLOT_L_MASK,
-               NAU8540_I2S_DO34_OE | ctrl2_val);
-
-       return 0;
+	struct snd_soc_codec *codec = dai->codec;
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	unsigned int ctrl2_val = 0, ctrl4_val = 0;
+
+	if (slots > 4 || ((tx_mask & 0xf0) && (tx_mask & 0xf)))
+		return -EINVAL;
+
+	ctrl4_val |= (NAU8540_TDM_MODE | NAU8540_TDM_OFFSET_EN);
+	if (tx_mask & 0xf0) {
+		ctrl2_val = 4 * slot_width;
+		ctrl4_val |= (tx_mask >> 4);
+	} else {
+		ctrl4_val |= tx_mask;
+	}
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL4,
+		NAU8540_TDM_MODE | NAU8540_TDM_OFFSET_EN |
+		NAU8540_TDM_TX_MASK, ctrl4_val);
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL1,
+		NAU8540_I2S_DO12_OE, NAU8540_I2S_DO12_OE);
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_PCM_CTRL2,
+		NAU8540_I2S_DO34_OE | NAU8540_I2S_TSLOT_L_MASK,
+		NAU8540_I2S_DO34_OE | ctrl2_val);
+
+	return 0;
 }
 
 
 static const struct snd_soc_dai_ops nau8540_dai_ops = {
-       .hw_params = nau8540_hw_params,
-       .set_fmt = nau8540_set_fmt,
-       .set_tdm_slot = nau8540_set_tdm_slot,
+	.hw_params = nau8540_hw_params,
+	.set_fmt = nau8540_set_fmt,
+	.set_tdm_slot = nau8540_set_tdm_slot,
 };
 
 #define NAU8540_RATES SNDRV_PCM_RATE_8000_48000
 #define NAU8540_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
-        | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+	 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_driver nau8540_dai = {
-       .name = "nau8540-hifi",
-       .capture = {
-               .stream_name = "Capture",
-               .channels_min = 1,
-               .channels_max = 4,
-               .rates = NAU8540_RATES,
-               .formats = NAU8540_FORMATS,
-       },
-       .ops = &nau8540_dai_ops,
+	.name = "nau8540-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 4,
+		.rates = NAU8540_RATES,
+		.formats = NAU8540_FORMATS,
+	},
+	.ops = &nau8540_dai_ops,
 };
 
 /**
@@ -513,320 +513,320 @@ static struct snd_soc_dai_driver nau8540_dai = {
  * Returns 0 for success or negative error code.
  */
 static int nau8540_calc_fll_param(unsigned int fll_in,
-       unsigned int fs, struct nau8540_fll *fll_param)
+	unsigned int fs, struct nau8540_fll *fll_param)
 {
-       u64 fvco, fvco_max;
-       unsigned int fref, i, fvco_sel;
-
-       /* Ensure the reference clock frequency (FREF) is <= 13.5MHz by dividing
-        * freq_in by 1, 2, 4, or 8 using FLL pre-scalar.
-        * FREF = freq_in / NAU8540_FLL_REF_DIV_MASK
-        */
-       for (i = 0; i < ARRAY_SIZE(fll_pre_scalar); i++) {
-               fref = fll_in / fll_pre_scalar[i].param;
-               if (fref <= NAU_FREF_MAX)
-                       break;
-       }
-       if (i == ARRAY_SIZE(fll_pre_scalar))
-               return -EINVAL;
-       fll_param->clk_ref_div = fll_pre_scalar[i].val;
-
-       /* Choose the FLL ratio based on FREF */
-       for (i = 0; i < ARRAY_SIZE(fll_ratio); i++) {
-               if (fref >= fll_ratio[i].param)
-                       break;
-       }
-       if (i == ARRAY_SIZE(fll_ratio))
-               return -EINVAL;
-       fll_param->ratio = fll_ratio[i].val;
-
-       /* Calculate the frequency of DCO (FDCO) given freq_out = 256 * Fs.
-        * FDCO must be within the 90MHz - 124MHz or the FFL cannot be
-        * guaranteed across the full range of operation.
-        * FDCO = freq_out * 2 * mclk_src_scaling
-        */
-       fvco_max = 0;
-       fvco_sel = ARRAY_SIZE(mclk_src_scaling);
-       for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
-               fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
-               if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
-                       fvco_max < fvco) {
-                       fvco_max = fvco;
-                       fvco_sel = i;
-               }
-       }
-       if (ARRAY_SIZE(mclk_src_scaling) == fvco_sel)
-               return -EINVAL;
-       fll_param->mclk_src = mclk_src_scaling[fvco_sel].val;
-
-       /* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
-        * input based on FDCO, FREF and FLL ratio.
-        */
-       fvco = div_u64(fvco_max << 16, fref * fll_param->ratio);
-       fll_param->fll_int = (fvco >> 16) & 0x3FF;
-       fll_param->fll_frac = fvco & 0xFFFF;
-       return 0;
+	u64 fvco, fvco_max;
+	unsigned int fref, i, fvco_sel;
+
+	/* Ensure the reference clock frequency (FREF) is <= 13.5MHz by dividing
+	 * freq_in by 1, 2, 4, or 8 using FLL pre-scalar.
+	 * FREF = freq_in / NAU8540_FLL_REF_DIV_MASK
+	 */
+	for (i = 0; i < ARRAY_SIZE(fll_pre_scalar); i++) {
+		fref = fll_in / fll_pre_scalar[i].param;
+		if (fref <= NAU_FREF_MAX)
+			break;
+	}
+	if (i == ARRAY_SIZE(fll_pre_scalar))
+		return -EINVAL;
+	fll_param->clk_ref_div = fll_pre_scalar[i].val;
+
+	/* Choose the FLL ratio based on FREF */
+	for (i = 0; i < ARRAY_SIZE(fll_ratio); i++) {
+		if (fref >= fll_ratio[i].param)
+			break;
+	}
+	if (i == ARRAY_SIZE(fll_ratio))
+		return -EINVAL;
+	fll_param->ratio = fll_ratio[i].val;
+
+	/* Calculate the frequency of DCO (FDCO) given freq_out = 256 * Fs.
+	 * FDCO must be within the 90MHz - 124MHz or the FFL cannot be
+	 * guaranteed across the full range of operation.
+	 * FDCO = freq_out * 2 * mclk_src_scaling
+	 */
+	fvco_max = 0;
+	fvco_sel = ARRAY_SIZE(mclk_src_scaling);
+	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
+		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
+		if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
+			fvco_max < fvco) {
+			fvco_max = fvco;
+			fvco_sel = i;
+		}
+	}
+	if (ARRAY_SIZE(mclk_src_scaling) == fvco_sel)
+		return -EINVAL;
+	fll_param->mclk_src = mclk_src_scaling[fvco_sel].val;
+
+	/* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
+	 * input based on FDCO, FREF and FLL ratio.
+	 */
+	fvco = div_u64(fvco_max << 16, fref * fll_param->ratio);
+	fll_param->fll_int = (fvco >> 16) & 0x3FF;
+	fll_param->fll_frac = fvco & 0xFFFF;
+	return 0;
 }
 
 static void nau8540_fll_apply(struct regmap *regmap,
-       struct nau8540_fll *fll_param)
+	struct nau8540_fll *fll_param)
 {
-       regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
-               NAU8540_CLK_SRC_MASK | NAU8540_CLK_MCLK_SRC_MASK,
-               NAU8540_CLK_SRC_MCLK | fll_param->mclk_src);
-       regmap_update_bits(regmap, NAU8540_REG_FLL1,
-               NAU8540_FLL_RATIO_MASK, fll_param->ratio);
-       /* FLL 16-bit fractional input */
-       regmap_write(regmap, NAU8540_REG_FLL2, fll_param->fll_frac);
-       /* FLL 10-bit integer input */
-       regmap_update_bits(regmap, NAU8540_REG_FLL3,
-               NAU8540_FLL_INTEGER_MASK, fll_param->fll_int);
-       /* FLL pre-scaler */
-       regmap_update_bits(regmap, NAU8540_REG_FLL4,
-               NAU8540_FLL_REF_DIV_MASK,
-               fll_param->clk_ref_div << NAU8540_FLL_REF_DIV_SFT);
-       regmap_update_bits(regmap, NAU8540_REG_FLL5,
-               NAU8540_FLL_CLK_SW_MASK, NAU8540_FLL_CLK_SW_REF);
-       regmap_update_bits(regmap,
-               NAU8540_REG_FLL6, NAU8540_DCO_EN, 0);
-       if (fll_param->fll_frac) {
-               regmap_update_bits(regmap, NAU8540_REG_FLL5,
-                       NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
-                       NAU8540_FLL_FTR_SW_MASK,
-                       NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
-                       NAU8540_FLL_FTR_SW_FILTER);
-               regmap_update_bits(regmap, NAU8540_REG_FLL6,
-                       NAU8540_SDM_EN, NAU8540_SDM_EN);
-       } else {
-               regmap_update_bits(regmap, NAU8540_REG_FLL5,
-                       NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
-                       NAU8540_FLL_FTR_SW_MASK, NAU8540_FLL_FTR_SW_ACCU);
-               regmap_update_bits(regmap,
-                       NAU8540_REG_FLL6, NAU8540_SDM_EN, 0);
-       }
+	regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
+		NAU8540_CLK_SRC_MASK | NAU8540_CLK_MCLK_SRC_MASK,
+		NAU8540_CLK_SRC_MCLK | fll_param->mclk_src);
+	regmap_update_bits(regmap, NAU8540_REG_FLL1,
+		NAU8540_FLL_RATIO_MASK, fll_param->ratio);
+	/* FLL 16-bit fractional input */
+	regmap_write(regmap, NAU8540_REG_FLL2, fll_param->fll_frac);
+	/* FLL 10-bit integer input */
+	regmap_update_bits(regmap, NAU8540_REG_FLL3,
+		NAU8540_FLL_INTEGER_MASK, fll_param->fll_int);
+	/* FLL pre-scaler */
+	regmap_update_bits(regmap, NAU8540_REG_FLL4,
+		NAU8540_FLL_REF_DIV_MASK,
+		fll_param->clk_ref_div << NAU8540_FLL_REF_DIV_SFT);
+	regmap_update_bits(regmap, NAU8540_REG_FLL5,
+		NAU8540_FLL_CLK_SW_MASK, NAU8540_FLL_CLK_SW_REF);
+	regmap_update_bits(regmap,
+		NAU8540_REG_FLL6, NAU8540_DCO_EN, 0);
+	if (fll_param->fll_frac) {
+		regmap_update_bits(regmap, NAU8540_REG_FLL5,
+			NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
+			NAU8540_FLL_FTR_SW_MASK,
+			NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
+			NAU8540_FLL_FTR_SW_FILTER);
+		regmap_update_bits(regmap, NAU8540_REG_FLL6,
+			NAU8540_SDM_EN, NAU8540_SDM_EN);
+	} else {
+		regmap_update_bits(regmap, NAU8540_REG_FLL5,
+			NAU8540_FLL_PDB_DAC_EN | NAU8540_FLL_LOOP_FTR_EN |
+			NAU8540_FLL_FTR_SW_MASK, NAU8540_FLL_FTR_SW_ACCU);
+		regmap_update_bits(regmap,
+			NAU8540_REG_FLL6, NAU8540_SDM_EN, 0);
+	}
 }
 
 /* freq_out must be 256*Fs in order to achieve the best performance */
 static int nau8540_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
-               unsigned int freq_in, unsigned int freq_out)
+		unsigned int freq_in, unsigned int freq_out)
 {
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
-       struct nau8540_fll fll_param;
-       int ret, fs;
-
-       switch (pll_id) {
-       case NAU8540_CLK_FLL_MCLK:
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_MCLK);
-               break;
-
-       case NAU8540_CLK_FLL_BLK:
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_BLK);
-               break;
-
-       case NAU8540_CLK_FLL_FS:
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
-                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_FS);
-               break;
-
-       default:
-               dev_err(nau8540->dev, "Invalid clock id (%d)\n", pll_id);
-               return -EINVAL;
-       }
-       dev_dbg(nau8540->dev, "Sysclk is %dHz and clock id is %d\n",
-               freq_out, pll_id);
-
-       fs = freq_out / 256;
-       ret = nau8540_calc_fll_param(freq_in, fs, &fll_param);
-       if (ret < 0) {
-               dev_err(nau8540->dev, "Unsupported input clock %d\n", freq_in);
-               return ret;
-       }
-       dev_dbg(nau8540->dev, "mclk_src=%x ratio=%x fll_frac=%x fll_int=%x clk_ref_div=%x\n",
-               fll_param.mclk_src, fll_param.ratio, fll_param.fll_frac,
-               fll_param.fll_int, fll_param.clk_ref_div);
-
-       nau8540_fll_apply(nau8540->regmap, &fll_param);
-       mdelay(2);
-       regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
-               NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
-
-       return 0;
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	struct nau8540_fll fll_param;
+	int ret, fs;
+
+	switch (pll_id) {
+	case NAU8540_CLK_FLL_MCLK:
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
+			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_MCLK);
+		break;
+
+	case NAU8540_CLK_FLL_BLK:
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
+			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_BLK);
+		break;
+
+	case NAU8540_CLK_FLL_FS:
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL3,
+			NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_FS);
+		break;
+
+	default:
+		dev_err(nau8540->dev, "Invalid clock id (%d)\n", pll_id);
+		return -EINVAL;
+	}
+	dev_dbg(nau8540->dev, "Sysclk is %dHz and clock id is %d\n",
+		freq_out, pll_id);
+
+	fs = freq_out / 256;
+	ret = nau8540_calc_fll_param(freq_in, fs, &fll_param);
+	if (ret < 0) {
+		dev_err(nau8540->dev, "Unsupported input clock %d\n", freq_in);
+		return ret;
+	}
+	dev_dbg(nau8540->dev, "mclk_src=%x ratio=%x fll_frac=%x fll_int=%x clk_ref_div=%x\n",
+		fll_param.mclk_src, fll_param.ratio, fll_param.fll_frac,
+		fll_param.fll_int, fll_param.clk_ref_div);
+
+	nau8540_fll_apply(nau8540->regmap, &fll_param);
+	mdelay(2);
+	regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
+		NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
+
+	return 0;
 }
 
 static int nau8540_set_sysclk(struct snd_soc_codec *codec,
-       int clk_id, int source, unsigned int freq, int dir)
+	int clk_id, int source, unsigned int freq, int dir)
 {
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
-
-       switch (clk_id) {
-       case NAU8540_CLK_DIS:
-       case NAU8540_CLK_MCLK:
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
-                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_MCLK);
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL6,
-                       NAU8540_DCO_EN, 0);
-               break;
-
-       case NAU8540_CLK_INTERNAL:
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL6,
-                       NAU8540_DCO_EN, NAU8540_DCO_EN);
-               regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
-                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
-               break;
-
-       default:
-               dev_err(nau8540->dev, "Invalid clock id (%d)\n", clk_id);
-               return -EINVAL;
-       }
-
-       dev_dbg(nau8540->dev, "Sysclk is %dHz and clock id is %d\n",
-               freq, clk_id);
-
-       return 0;
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case NAU8540_CLK_DIS:
+	case NAU8540_CLK_MCLK:
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
+			NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_MCLK);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL6,
+			NAU8540_DCO_EN, 0);
+		break;
+
+	case NAU8540_CLK_INTERNAL:
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_FLL6,
+			NAU8540_DCO_EN, NAU8540_DCO_EN);
+		regmap_update_bits(nau8540->regmap, NAU8540_REG_CLOCK_SRC,
+			NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
+		break;
+
+	default:
+		dev_err(nau8540->dev, "Invalid clock id (%d)\n", clk_id);
+		return -EINVAL;
+	}
+
+	dev_dbg(nau8540->dev, "Sysclk is %dHz and clock id is %d\n",
+		freq, clk_id);
+
+	return 0;
 }
 
 static void nau8540_reset_chip(struct regmap *regmap)
 {
-       regmap_write(regmap, NAU8540_REG_SW_RESET, 0x00);
-       regmap_write(regmap, NAU8540_REG_SW_RESET, 0x00);
+	regmap_write(regmap, NAU8540_REG_SW_RESET, 0x00);
+	regmap_write(regmap, NAU8540_REG_SW_RESET, 0x00);
 }
 
 static void nau8540_init_regs(struct nau8540 *nau8540)
 {
-       struct regmap *regmap = nau8540->regmap;
-
-       /* Enable Bias/VMID/VMID Tieoff */
-       regmap_update_bits(regmap, NAU8540_REG_VMID_CTRL,
-               NAU8540_VMID_EN | NAU8540_VMID_SEL_MASK,
-               NAU8540_VMID_EN | (0x2 << NAU8540_VMID_SEL_SFT));
-       regmap_update_bits(regmap, NAU8540_REG_REFERENCE,
-               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN,
-               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN);
-       mdelay(2);
-       regmap_update_bits(regmap, NAU8540_REG_MIC_BIAS,
-               NAU8540_PU_PRE, NAU8540_PU_PRE);
-       regmap_update_bits(regmap, NAU8540_REG_CLOCK_CTRL,
-               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN,
-               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN);
-       /* ADC OSR selection, CLK_ADC = Fs * OSR */
-       regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
-               NAU8540_ADC_OSR_MASK, NAU8540_ADC_OSR_64);
+	struct regmap *regmap = nau8540->regmap;
+
+	/* Enable Bias/VMID/VMID Tieoff */
+	regmap_update_bits(regmap, NAU8540_REG_VMID_CTRL,
+		NAU8540_VMID_EN | NAU8540_VMID_SEL_MASK,
+		NAU8540_VMID_EN | (0x2 << NAU8540_VMID_SEL_SFT));
+	regmap_update_bits(regmap, NAU8540_REG_REFERENCE,
+		NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN,
+		NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN);
+	mdelay(2);
+	regmap_update_bits(regmap, NAU8540_REG_MIC_BIAS,
+		NAU8540_PU_PRE, NAU8540_PU_PRE);
+	regmap_update_bits(regmap, NAU8540_REG_CLOCK_CTRL,
+		NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN,
+		NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN);
+	/* ADC OSR selection, CLK_ADC = Fs * OSR */
+	regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
+		NAU8540_ADC_OSR_MASK, NAU8540_ADC_OSR_64);
 }
 
 static int __maybe_unused nau8540_suspend(struct snd_soc_codec *codec)
 {
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
 
-       regcache_cache_only(nau8540->regmap, true);
-       regcache_mark_dirty(nau8540->regmap);
+	regcache_cache_only(nau8540->regmap, true);
+	regcache_mark_dirty(nau8540->regmap);
 
-       return 0;
+	return 0;
 }
 
 static int __maybe_unused nau8540_resume(struct snd_soc_codec *codec)
 {
-       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
+	struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
 
-       regcache_cache_only(nau8540->regmap, false);
-       regcache_sync(nau8540->regmap);
+	regcache_cache_only(nau8540->regmap, false);
+	regcache_sync(nau8540->regmap);
 
-       return 0;
+	return 0;
 }
 
 static struct snd_soc_codec_driver nau8540_codec_driver = {
-       .set_sysclk = nau8540_set_sysclk,
-       .set_pll = nau8540_set_pll,
-       .suspend = nau8540_suspend,
-       .resume = nau8540_resume,
-       .suspend_bias_off = true,
-
-       .component_driver = {
-               .controls = nau8540_snd_controls,
-               .num_controls = ARRAY_SIZE(nau8540_snd_controls),
-               .dapm_widgets = nau8540_dapm_widgets,
-               .num_dapm_widgets = ARRAY_SIZE(nau8540_dapm_widgets),
-               .dapm_routes = nau8540_dapm_routes,
-               .num_dapm_routes = ARRAY_SIZE(nau8540_dapm_routes),
-       },
+	.set_sysclk = nau8540_set_sysclk,
+	.set_pll = nau8540_set_pll,
+	.suspend = nau8540_suspend,
+	.resume = nau8540_resume,
+	.suspend_bias_off = true,
+
+	.component_driver = {
+		.controls = nau8540_snd_controls,
+		.num_controls = ARRAY_SIZE(nau8540_snd_controls),
+		.dapm_widgets = nau8540_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(nau8540_dapm_widgets),
+		.dapm_routes = nau8540_dapm_routes,
+		.num_dapm_routes = ARRAY_SIZE(nau8540_dapm_routes),
+	},
 };
 
 static const struct regmap_config nau8540_regmap_config = {
-       .val_bits = 16,
-       .reg_bits = 16,
+	.val_bits = 16,
+	.reg_bits = 16,
 
-       .max_register = NAU8540_REG_MAX,
-       .readable_reg = nau8540_readable_reg,
-       .writeable_reg = nau8540_writeable_reg,
-       .volatile_reg = nau8540_volatile_reg,
+	.max_register = NAU8540_REG_MAX,
+	.readable_reg = nau8540_readable_reg,
+	.writeable_reg = nau8540_writeable_reg,
+	.volatile_reg = nau8540_volatile_reg,
 
-       .cache_type = REGCACHE_RBTREE,
-       .reg_defaults = nau8540_reg_defaults,
-       .num_reg_defaults = ARRAY_SIZE(nau8540_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults = nau8540_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8540_reg_defaults),
 };
 
 static int nau8540_i2c_probe(struct i2c_client *i2c,
-       const struct i2c_device_id *id)
+	const struct i2c_device_id *id)
 {
-       struct device *dev = &i2c->dev;
-       struct nau8540 *nau8540 = dev_get_platdata(dev);
-       int ret, value;
-
-       if (!nau8540) {
-               nau8540 = devm_kzalloc(dev, sizeof(*nau8540), GFP_KERNEL);
-               if (!nau8540)
-                       return -ENOMEM;
-       }
-       i2c_set_clientdata(i2c, nau8540);
-
-       nau8540->regmap = devm_regmap_init_i2c(i2c, &nau8540_regmap_config);
-       if (IS_ERR(nau8540->regmap))
-               return PTR_ERR(nau8540->regmap);
-       ret = regmap_read(nau8540->regmap, NAU8540_REG_I2C_DEVICE_ID, &value);
-       if (ret < 0) {
-               dev_err(dev, "Failed to read device id from the NAU85L40: %d\n",
-                       ret);
-               return ret;
-       }
-
-       nau8540->dev = dev;
-       nau8540_reset_chip(nau8540->regmap);
-       nau8540_init_regs(nau8540);
-
-       return snd_soc_register_codec(dev,
-               &nau8540_codec_driver, &nau8540_dai, 1);
+	struct device *dev = &i2c->dev;
+	struct nau8540 *nau8540 = dev_get_platdata(dev);
+	int ret, value;
+
+	if (!nau8540) {
+		nau8540 = devm_kzalloc(dev, sizeof(*nau8540), GFP_KERNEL);
+		if (!nau8540)
+			return -ENOMEM;
+	}
+	i2c_set_clientdata(i2c, nau8540);
+
+	nau8540->regmap = devm_regmap_init_i2c(i2c, &nau8540_regmap_config);
+	if (IS_ERR(nau8540->regmap))
+		return PTR_ERR(nau8540->regmap);
+	ret = regmap_read(nau8540->regmap, NAU8540_REG_I2C_DEVICE_ID, &value);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read device id from the NAU85L40: %d\n",
+			ret);
+		return ret;
+	}
+
+	nau8540->dev = dev;
+	nau8540_reset_chip(nau8540->regmap);
+	nau8540_init_regs(nau8540);
+
+	return snd_soc_register_codec(dev,
+		&nau8540_codec_driver, &nau8540_dai, 1);
 }
 
 static int nau8540_i2c_remove(struct i2c_client *client)
 {
-       snd_soc_unregister_codec(&client->dev);
-       return 0;
+	snd_soc_unregister_codec(&client->dev);
+	return 0;
 }
 
 
 static const struct i2c_device_id nau8540_i2c_ids[] = {
-       { "nau8540", 0 },
-       { }
+	{ "nau8540", 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nau8540_i2c_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id nau8540_of_ids[] = {
-       { .compatible = "nuvoton,nau8540", },
-       {}
+	{ .compatible = "nuvoton,nau8540", },
+	{}
 };
 MODULE_DEVICE_TABLE(of, nau8540_of_ids);
 #endif
 
 static struct i2c_driver nau8540_i2c_driver = {
-       .driver = {
-               .name = "nau8540",
-               .of_match_table = of_match_ptr(nau8540_of_ids),
-       },
-       .probe = nau8540_i2c_probe,
-       .remove = nau8540_i2c_remove,
-       .id_table = nau8540_i2c_ids,
+	.driver = {
+		.name = "nau8540",
+		.of_match_table = of_match_ptr(nau8540_of_ids),
+	},
+	.probe = nau8540_i2c_probe,
+	.remove = nau8540_i2c_remove,
+	.id_table = nau8540_i2c_ids,
 };
 module_i2c_driver(nau8540_i2c_driver);
 
diff --git a/sound/soc/codecs/nau8540.h b/sound/soc/codecs/nau8540.h
index d06e65188cd5..5db5b224944d 100644
--- a/sound/soc/codecs/nau8540.h
+++ b/sound/soc/codecs/nau8540.h
@@ -12,211 +12,211 @@
 #ifndef __NAU8540_H__
 #define __NAU8540_H__
 
-#define NAU8540_REG_SW_RESET                   0x00
-#define NAU8540_REG_POWER_MANAGEMENT   0x01
-#define NAU8540_REG_CLOCK_CTRL         0x02
-#define NAU8540_REG_CLOCK_SRC                  0x03
-#define NAU8540_REG_FLL1                       0x04
-#define NAU8540_REG_FLL2                       0x05
-#define NAU8540_REG_FLL3                       0x06
-#define NAU8540_REG_FLL4                       0x07
-#define NAU8540_REG_FLL5                       0x08
-#define NAU8540_REG_FLL6                       0x09
-#define NAU8540_REG_FLL_VCO_RSV                0x0A
-#define NAU8540_REG_PCM_CTRL0                  0x10
-#define NAU8540_REG_PCM_CTRL1                  0x11
-#define NAU8540_REG_PCM_CTRL2                  0x12
-#define NAU8540_REG_PCM_CTRL3                  0x13
-#define NAU8540_REG_PCM_CTRL4                  0x14
-#define NAU8540_REG_ALC_CONTROL_1              0x20
-#define NAU8540_REG_ALC_CONTROL_2              0x21
-#define NAU8540_REG_ALC_CONTROL_3              0x22
-#define NAU8540_REG_ALC_CONTROL_4              0x23
-#define NAU8540_REG_ALC_CONTROL_5              0x24
-#define NAU8540_REG_ALC_GAIN_CH12              0x2D
-#define NAU8540_REG_ALC_GAIN_CH34              0x2E
-#define NAU8540_REG_ALC_STATUS         0x2F
-#define NAU8540_REG_NOTCH_FIL1_CH1             0x30
-#define NAU8540_REG_NOTCH_FIL2_CH1             0x31
-#define NAU8540_REG_NOTCH_FIL1_CH2             0x32
-#define NAU8540_REG_NOTCH_FIL2_CH2             0x33
-#define NAU8540_REG_NOTCH_FIL1_CH3             0x34
-#define NAU8540_REG_NOTCH_FIL2_CH3             0x35
-#define NAU8540_REG_NOTCH_FIL1_CH4             0x36
-#define NAU8540_REG_NOTCH_FIL2_CH4             0x37
-#define NAU8540_REG_HPF_FILTER_CH12            0x38
-#define NAU8540_REG_HPF_FILTER_CH34            0x39
-#define NAU8540_REG_ADC_SAMPLE_RATE            0x3A
-#define NAU8540_REG_DIGITAL_GAIN_CH1           0x40
-#define NAU8540_REG_DIGITAL_GAIN_CH2           0x41
-#define NAU8540_REG_DIGITAL_GAIN_CH3           0x42
-#define NAU8540_REG_DIGITAL_GAIN_CH4           0x43
-#define NAU8540_REG_DIGITAL_MUX                0x44
-#define NAU8540_REG_P2P_CH1                    0x48
-#define NAU8540_REG_P2P_CH2                    0x49
-#define NAU8540_REG_P2P_CH3                    0x4A
-#define NAU8540_REG_P2P_CH4                    0x4B
-#define NAU8540_REG_PEAK_CH1                   0x4C
-#define NAU8540_REG_PEAK_CH2                   0x4D
-#define NAU8540_REG_PEAK_CH3                   0x4E
-#define NAU8540_REG_PEAK_CH4                   0x4F
-#define NAU8540_REG_GPIO_CTRL                  0x50
-#define NAU8540_REG_MISC_CTRL                  0x51
-#define NAU8540_REG_I2C_CTRL                   0x52
-#define NAU8540_REG_I2C_DEVICE_ID              0x58
-#define NAU8540_REG_RST                        0x5A
-#define NAU8540_REG_VMID_CTRL                  0x60
-#define NAU8540_REG_MUTE                       0x61
-#define NAU8540_REG_ANALOG_ADC1                0x64
-#define NAU8540_REG_ANALOG_ADC2                0x65
-#define NAU8540_REG_ANALOG_PWR         0x66
-#define NAU8540_REG_MIC_BIAS                   0x67
-#define NAU8540_REG_REFERENCE                  0x68
-#define NAU8540_REG_FEPGA1                     0x69
-#define NAU8540_REG_FEPGA2                     0x6A
-#define NAU8540_REG_FEPGA3                     0x6B
-#define NAU8540_REG_FEPGA4                     0x6C
-#define NAU8540_REG_PWR                        0x6D
-#define NAU8540_REG_MAX                        NAU8540_REG_PWR
+#define NAU8540_REG_SW_RESET			0x00
+#define NAU8540_REG_POWER_MANAGEMENT	0x01
+#define NAU8540_REG_CLOCK_CTRL		0x02
+#define NAU8540_REG_CLOCK_SRC			0x03
+#define NAU8540_REG_FLL1			0x04
+#define NAU8540_REG_FLL2			0x05
+#define NAU8540_REG_FLL3			0x06
+#define NAU8540_REG_FLL4			0x07
+#define NAU8540_REG_FLL5			0x08
+#define NAU8540_REG_FLL6			0x09
+#define NAU8540_REG_FLL_VCO_RSV		0x0A
+#define NAU8540_REG_PCM_CTRL0			0x10
+#define NAU8540_REG_PCM_CTRL1			0x11
+#define NAU8540_REG_PCM_CTRL2			0x12
+#define NAU8540_REG_PCM_CTRL3			0x13
+#define NAU8540_REG_PCM_CTRL4			0x14
+#define NAU8540_REG_ALC_CONTROL_1		0x20
+#define NAU8540_REG_ALC_CONTROL_2		0x21
+#define NAU8540_REG_ALC_CONTROL_3		0x22
+#define NAU8540_REG_ALC_CONTROL_4		0x23
+#define NAU8540_REG_ALC_CONTROL_5		0x24
+#define NAU8540_REG_ALC_GAIN_CH12		0x2D
+#define NAU8540_REG_ALC_GAIN_CH34		0x2E
+#define NAU8540_REG_ALC_STATUS		0x2F
+#define NAU8540_REG_NOTCH_FIL1_CH1		0x30
+#define NAU8540_REG_NOTCH_FIL2_CH1		0x31
+#define NAU8540_REG_NOTCH_FIL1_CH2		0x32
+#define NAU8540_REG_NOTCH_FIL2_CH2		0x33
+#define NAU8540_REG_NOTCH_FIL1_CH3		0x34
+#define NAU8540_REG_NOTCH_FIL2_CH3		0x35
+#define NAU8540_REG_NOTCH_FIL1_CH4		0x36
+#define NAU8540_REG_NOTCH_FIL2_CH4		0x37
+#define NAU8540_REG_HPF_FILTER_CH12		0x38
+#define NAU8540_REG_HPF_FILTER_CH34		0x39
+#define NAU8540_REG_ADC_SAMPLE_RATE		0x3A
+#define NAU8540_REG_DIGITAL_GAIN_CH1		0x40
+#define NAU8540_REG_DIGITAL_GAIN_CH2		0x41
+#define NAU8540_REG_DIGITAL_GAIN_CH3		0x42
+#define NAU8540_REG_DIGITAL_GAIN_CH4		0x43
+#define NAU8540_REG_DIGITAL_MUX		0x44
+#define NAU8540_REG_P2P_CH1			0x48
+#define NAU8540_REG_P2P_CH2			0x49
+#define NAU8540_REG_P2P_CH3			0x4A
+#define NAU8540_REG_P2P_CH4			0x4B
+#define NAU8540_REG_PEAK_CH1			0x4C
+#define NAU8540_REG_PEAK_CH2			0x4D
+#define NAU8540_REG_PEAK_CH3			0x4E
+#define NAU8540_REG_PEAK_CH4			0x4F
+#define NAU8540_REG_GPIO_CTRL			0x50
+#define NAU8540_REG_MISC_CTRL			0x51
+#define NAU8540_REG_I2C_CTRL			0x52
+#define NAU8540_REG_I2C_DEVICE_ID		0x58
+#define NAU8540_REG_RST			0x5A
+#define NAU8540_REG_VMID_CTRL			0x60
+#define NAU8540_REG_MUTE			0x61
+#define NAU8540_REG_ANALOG_ADC1		0x64
+#define NAU8540_REG_ANALOG_ADC2		0x65
+#define NAU8540_REG_ANALOG_PWR		0x66
+#define NAU8540_REG_MIC_BIAS			0x67
+#define NAU8540_REG_REFERENCE			0x68
+#define NAU8540_REG_FEPGA1			0x69
+#define NAU8540_REG_FEPGA2			0x6A
+#define NAU8540_REG_FEPGA3			0x6B
+#define NAU8540_REG_FEPGA4			0x6C
+#define NAU8540_REG_PWR			0x6D
+#define NAU8540_REG_MAX			NAU8540_REG_PWR
 
 
 /* POWER_MANAGEMENT (0x01) */
-#define NAU8540_ADC4_EN                (0x1 << 3)
-#define NAU8540_ADC3_EN                (0x1 << 2)
-#define NAU8540_ADC2_EN                (0x1 << 1)
-#define NAU8540_ADC1_EN                0x1
+#define NAU8540_ADC4_EN		(0x1 << 3)
+#define NAU8540_ADC3_EN		(0x1 << 2)
+#define NAU8540_ADC2_EN		(0x1 << 1)
+#define NAU8540_ADC1_EN		0x1
 
 /* CLOCK_CTRL (0x02) */
-#define NAU8540_CLK_ADC_EN             (0x1 << 15)
-#define NAU8540_CLK_I2S_EN             (0x1 << 1)
+#define NAU8540_CLK_ADC_EN		(0x1 << 15)
+#define NAU8540_CLK_I2S_EN		(0x1 << 1)
 
 /* CLOCK_SRC (0x03) */
-#define NAU8540_CLK_SRC_SFT            15
-#define NAU8540_CLK_SRC_MASK           (1 << NAU8540_CLK_SRC_SFT)
-#define NAU8540_CLK_SRC_VCO            (1 << NAU8540_CLK_SRC_SFT)
-#define NAU8540_CLK_SRC_MCLK           (0 << NAU8540_CLK_SRC_SFT)
-#define NAU8540_CLK_ADC_SRC_SFT        6
-#define NAU8540_CLK_ADC_SRC_MASK       (0x3 << NAU8540_CLK_ADC_SRC_SFT)
-#define NAU8540_CLK_MCLK_SRC_MASK      0xf
+#define NAU8540_CLK_SRC_SFT		15
+#define NAU8540_CLK_SRC_MASK		(1 << NAU8540_CLK_SRC_SFT)
+#define NAU8540_CLK_SRC_VCO		(1 << NAU8540_CLK_SRC_SFT)
+#define NAU8540_CLK_SRC_MCLK		(0 << NAU8540_CLK_SRC_SFT)
+#define NAU8540_CLK_ADC_SRC_SFT	6
+#define NAU8540_CLK_ADC_SRC_MASK	(0x3 << NAU8540_CLK_ADC_SRC_SFT)
+#define NAU8540_CLK_MCLK_SRC_MASK	0xf
 
 /* FLL1 (0x04) */
-#define NAU8540_FLL_RATIO_MASK 0x7f
+#define NAU8540_FLL_RATIO_MASK	0x7f
 
 /* FLL3 (0x06) */
-#define NAU8540_FLL_CLK_SRC_SFT        10
-#define NAU8540_FLL_CLK_SRC_MASK       (0x3 << NAU8540_FLL_CLK_SRC_SFT)
-#define NAU8540_FLL_CLK_SRC_MCLK       (0 << NAU8540_FLL_CLK_SRC_SFT)
-#define NAU8540_FLL_CLK_SRC_BLK        (0x2 << NAU8540_FLL_CLK_SRC_SFT)
-#define NAU8540_FLL_CLK_SRC_FS         (0x3 << NAU8540_FLL_CLK_SRC_SFT)
-#define NAU8540_FLL_INTEGER_MASK       0x3ff
+#define NAU8540_FLL_CLK_SRC_SFT	10
+#define NAU8540_FLL_CLK_SRC_MASK	(0x3 << NAU8540_FLL_CLK_SRC_SFT)
+#define NAU8540_FLL_CLK_SRC_MCLK	(0 << NAU8540_FLL_CLK_SRC_SFT)
+#define NAU8540_FLL_CLK_SRC_BLK	(0x2 << NAU8540_FLL_CLK_SRC_SFT)
+#define NAU8540_FLL_CLK_SRC_FS		(0x3 << NAU8540_FLL_CLK_SRC_SFT)
+#define NAU8540_FLL_INTEGER_MASK	0x3ff
 
 /* FLL4 (0x07) */
-#define NAU8540_FLL_REF_DIV_SFT        10
-#define NAU8540_FLL_REF_DIV_MASK       (0x3 << NAU8540_FLL_REF_DIV_SFT)
+#define NAU8540_FLL_REF_DIV_SFT	10
+#define NAU8540_FLL_REF_DIV_MASK	(0x3 << NAU8540_FLL_REF_DIV_SFT)
 
 /* FLL5 (0x08) */
-#define NAU8540_FLL_PDB_DAC_EN (0x1 << 15)
-#define NAU8540_FLL_LOOP_FTR_EN        (0x1 << 14)
-#define NAU8540_FLL_CLK_SW_MASK        (0x1 << 13)
-#define NAU8540_FLL_CLK_SW_N2          (0x1 << 13)
-#define NAU8540_FLL_CLK_SW_REF (0x0 << 13)
-#define NAU8540_FLL_FTR_SW_MASK        (0x1 << 12)
-#define NAU8540_FLL_FTR_SW_ACCU        (0x1 << 12)
-#define NAU8540_FLL_FTR_SW_FILTER      (0x0 << 12)
+#define NAU8540_FLL_PDB_DAC_EN	(0x1 << 15)
+#define NAU8540_FLL_LOOP_FTR_EN	(0x1 << 14)
+#define NAU8540_FLL_CLK_SW_MASK	(0x1 << 13)
+#define NAU8540_FLL_CLK_SW_N2		(0x1 << 13)
+#define NAU8540_FLL_CLK_SW_REF	(0x0 << 13)
+#define NAU8540_FLL_FTR_SW_MASK	(0x1 << 12)
+#define NAU8540_FLL_FTR_SW_ACCU	(0x1 << 12)
+#define NAU8540_FLL_FTR_SW_FILTER	(0x0 << 12)
 
 /* FLL6 (0x9) */
-#define NAU8540_DCO_EN                 (0x1 << 15)
-#define NAU8540_SDM_EN                 (0x1 << 14)
+#define NAU8540_DCO_EN			(0x1 << 15)
+#define NAU8540_SDM_EN			(0x1 << 14)
 
 /* PCM_CTRL0 (0x10) */
-#define NAU8540_I2S_BP_SFT             7
-#define NAU8540_I2S_BP_INV             (0x1 << NAU8540_I2S_BP_SFT)
-#define NAU8540_I2S_PCMB_SFT           6
-#define NAU8540_I2S_PCMB_EN            (0x1 << NAU8540_I2S_PCMB_SFT)
-#define NAU8540_I2S_DL_SFT             2
-#define NAU8540_I2S_DL_MASK            (0x3 << NAU8540_I2S_DL_SFT)
-#define NAU8540_I2S_DL_16              (0 << NAU8540_I2S_DL_SFT)
-#define NAU8540_I2S_DL_20              (0x1 << NAU8540_I2S_DL_SFT)
-#define NAU8540_I2S_DL_24              (0x2 << NAU8540_I2S_DL_SFT)
-#define NAU8540_I2S_DL_32              (0x3 << NAU8540_I2S_DL_SFT)
-#define NAU8540_I2S_DF_MASK            0x3
-#define NAU8540_I2S_DF_RIGTH           0
-#define NAU8540_I2S_DF_LEFT            0x1
-#define NAU8540_I2S_DF_I2S             0x2
-#define NAU8540_I2S_DF_PCM_AB          0x3
+#define NAU8540_I2S_BP_SFT		7
+#define NAU8540_I2S_BP_INV		(0x1 << NAU8540_I2S_BP_SFT)
+#define NAU8540_I2S_PCMB_SFT		6
+#define NAU8540_I2S_PCMB_EN		(0x1 << NAU8540_I2S_PCMB_SFT)
+#define NAU8540_I2S_DL_SFT		2
+#define NAU8540_I2S_DL_MASK		(0x3 << NAU8540_I2S_DL_SFT)
+#define NAU8540_I2S_DL_16		(0 << NAU8540_I2S_DL_SFT)
+#define NAU8540_I2S_DL_20		(0x1 << NAU8540_I2S_DL_SFT)
+#define NAU8540_I2S_DL_24		(0x2 << NAU8540_I2S_DL_SFT)
+#define NAU8540_I2S_DL_32		(0x3 << NAU8540_I2S_DL_SFT)
+#define NAU8540_I2S_DF_MASK		0x3
+#define NAU8540_I2S_DF_RIGTH		0
+#define NAU8540_I2S_DF_LEFT		0x1
+#define NAU8540_I2S_DF_I2S		0x2
+#define NAU8540_I2S_DF_PCM_AB		0x3
 
 /* PCM_CTRL1 (0x11) */
-#define NAU8540_I2S_LRC_DIV_SFT        12
-#define NAU8540_I2S_LRC_DIV_MASK       (0x3 << NAU8540_I2S_LRC_DIV_SFT)
-#define NAU8540_I2S_DO12_OE            (0x1 << 4)
-#define NAU8540_I2S_MS_SFT             3
-#define NAU8540_I2S_MS_MASK            (0x1 << NAU8540_I2S_MS_SFT)
-#define NAU8540_I2S_MS_MASTER          (0x1 << NAU8540_I2S_MS_SFT)
-#define NAU8540_I2S_MS_SLAVE           (0x0 << NAU8540_I2S_MS_SFT)
-#define NAU8540_I2S_BLK_DIV_MASK       0x7
+#define NAU8540_I2S_LRC_DIV_SFT	12
+#define NAU8540_I2S_LRC_DIV_MASK	(0x3 << NAU8540_I2S_LRC_DIV_SFT)
+#define NAU8540_I2S_DO12_OE		(0x1 << 4)
+#define NAU8540_I2S_MS_SFT		3
+#define NAU8540_I2S_MS_MASK		(0x1 << NAU8540_I2S_MS_SFT)
+#define NAU8540_I2S_MS_MASTER		(0x1 << NAU8540_I2S_MS_SFT)
+#define NAU8540_I2S_MS_SLAVE		(0x0 << NAU8540_I2S_MS_SFT)
+#define NAU8540_I2S_BLK_DIV_MASK	0x7
 
 /* PCM_CTRL1 (0x12) */
-#define NAU8540_I2S_DO34_OE            (0x1 << 11)
-#define NAU8540_I2S_TSLOT_L_MASK       0x3ff
+#define NAU8540_I2S_DO34_OE		(0x1 << 11)
+#define NAU8540_I2S_TSLOT_L_MASK	0x3ff
 
 /* PCM_CTRL4 (0x14) */
-#define NAU8540_TDM_MODE               (0x1 << 15)
-#define NAU8540_TDM_OFFSET_EN          (0x1 << 14)
-#define NAU8540_TDM_TX_MASK            0xf
+#define NAU8540_TDM_MODE		(0x1 << 15)
+#define NAU8540_TDM_OFFSET_EN		(0x1 << 14)
+#define NAU8540_TDM_TX_MASK		0xf
 
 /* ADC_SAMPLE_RATE (0x3A) */
-#define NAU8540_ADC_OSR_MASK           0x3
-#define NAU8540_ADC_OSR_256            0x3
-#define NAU8540_ADC_OSR_128            0x2
-#define NAU8540_ADC_OSR_64             0x1
-#define NAU8540_ADC_OSR_32             0x0
+#define NAU8540_ADC_OSR_MASK		0x3
+#define NAU8540_ADC_OSR_256		0x3
+#define NAU8540_ADC_OSR_128		0x2
+#define NAU8540_ADC_OSR_64		0x1
+#define NAU8540_ADC_OSR_32		0x0
 
 /* VMID_CTRL (0x60) */
-#define NAU8540_VMID_EN                (1 << 6)
-#define NAU8540_VMID_SEL_SFT           4
-#define NAU8540_VMID_SEL_MASK          (0x3 << NAU8540_VMID_SEL_SFT)
+#define NAU8540_VMID_EN		(1 << 6)
+#define NAU8540_VMID_SEL_SFT		4
+#define NAU8540_VMID_SEL_MASK		(0x3 << NAU8540_VMID_SEL_SFT)
 
 /* MIC_BIAS (0x67) */
-#define NAU8540_PU_PRE                 (0x1 << 8)
+#define NAU8540_PU_PRE			(0x1 << 8)
 
 /* REFERENCE (0x68) */
-#define NAU8540_PRECHARGE_DIS          (0x1 << 13)
-#define NAU8540_GLOBAL_BIAS_EN (0x1 << 12)
+#define NAU8540_PRECHARGE_DIS		(0x1 << 13)
+#define NAU8540_GLOBAL_BIAS_EN	(0x1 << 12)
 
 
 /* System Clock Source */
 enum {
-       NAU8540_CLK_DIS,
-       NAU8540_CLK_MCLK,
-       NAU8540_CLK_INTERNAL,
-       NAU8540_CLK_FLL_MCLK,
-       NAU8540_CLK_FLL_BLK,
-       NAU8540_CLK_FLL_FS,
+	NAU8540_CLK_DIS,
+	NAU8540_CLK_MCLK,
+	NAU8540_CLK_INTERNAL,
+	NAU8540_CLK_FLL_MCLK,
+	NAU8540_CLK_FLL_BLK,
+	NAU8540_CLK_FLL_FS,
 };
 
 struct nau8540 {
-       struct device *dev;
-       struct regmap *regmap;
+	struct device *dev;
+	struct regmap *regmap;
 };
 
 struct nau8540_fll {
-       int mclk_src;
-       int ratio;
-       int fll_frac;
-       int fll_int;
-       int clk_ref_div;
+	int mclk_src;
+	int ratio;
+	int fll_frac;
+	int fll_int;
+	int clk_ref_div;
 };
 
 struct nau8540_fll_attr {
-       unsigned int param;
-       unsigned int val;
+	unsigned int param;
+	unsigned int val;
 };
 
 /* over sampling rate */
 struct nau8540_osr_attr {
-       unsigned int osr;
-       unsigned int clk_src;
+	unsigned int osr;
+	unsigned int clk_src;
 };
 
 
-#endif /* __NAU8540_H__ */
+#endif	/* __NAU8540_H__ */
-- 
2.11.0
