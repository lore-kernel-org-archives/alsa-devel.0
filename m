From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v4 2/7] ASoC: da7210: Add support for High pass
 and Voice filters for ADC and DAC
Date: Sat, 15 Oct 2011 14:50:06 +0530
Message-ID: <1318670406.613.35.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id DDA8524417
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 11:08:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This patch add controls for setting cut-off for high pass and voice
filters of ADC and DAC. There are also switches to enable/disable
these filters.

Also removed hard coded, fixed  values of these parameters used by
previous version of driver.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
 sound/soc/codecs/da7210.c |   57 +++++++++++++++++++++++++-------------------
 1 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index c7b1635..480fc6d 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -167,6 +167,28 @@ static const unsigned int hp_out_tlv[] = {
 static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
 
+/* ADC and DAC high pass filter f0 value */
+static const char const *da7210_hpf_cutoff_txt[] = {
+	"Fs/8192*pi", "Fs/4096*pi", "Fs/2048*pi", "Fs/1024*pi"
+};
+
+static const struct soc_enum da7210_dac_hpf_cutoff =
+	SOC_ENUM_SINGLE(DA7210_DAC_HPF, 0, 4, da7210_hpf_cutoff_txt);
+
+static const struct soc_enum da7210_adc_hpf_cutoff =
+	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 0, 4, da7210_hpf_cutoff_txt);
+
+/* ADC and DAC voice (8kHz) high pass cutoff value */
+static const char const *da7210_vf_cutoff_txt[] = {
+	"2.5Hz", "25Hz", "50Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
+};
+
+static const struct soc_enum da7210_dac_vf_cutoff =
+	SOC_ENUM_SINGLE(DA7210_DAC_HPF, 4, 8, da7210_vf_cutoff_txt);
+
+static const struct soc_enum da7210_adc_vf_cutoff =
+	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 4, 8, da7210_vf_cutoff_txt);
+
 static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HeadPhone Playback Volume",
@@ -200,6 +222,16 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 		       eq_gain_tlv),
 	SOC_SINGLE_TLV("ADC EQ5 Volume", DA7210_ADC_EQ5, 0, 0xf, 1,
 		       eq_gain_tlv),
+
+	SOC_SINGLE("DAC HPF Switch", DA7210_DAC_HPF, 3, 1, 0),
+	SOC_ENUM("DAC HPF Cutoff", da7210_dac_hpf_cutoff),
+	SOC_SINGLE("DAC Voice Mode Switch", DA7210_DAC_HPF, 7, 1, 0),
+	SOC_ENUM("DAC Voice Cutoff", da7210_dac_vf_cutoff),
+
+	SOC_SINGLE("ADC HPF Switch", DA7210_ADC_HPF, 3, 1, 0),
+	SOC_ENUM("ADC HPF Cutoff", da7210_adc_hpf_cutoff),
+	SOC_SINGLE("ADC Voice Mode Switch", DA7210_ADC_HPF, 7, 1, 0),
+	SOC_ENUM("ADC Voice Cutoff", da7210_adc_vf_cutoff),
 };
 
 /* Codec private data */
@@ -275,7 +307,6 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 	u32 dai_cfg1;
-	u32 hpf_reg, hpf_mask, hpf_value;
 	u32 fs, bypass;
 
 	/* set DAI source to Left and Right ADC */
@@ -306,68 +337,45 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 
 	snd_soc_write(codec, DA7210_DAI_CFG1, dai_cfg1);
 
-	hpf_reg = (SNDRV_PCM_STREAM_PLAYBACK == substream->stream) ?
-		DA7210_DAC_HPF : DA7210_ADC_HPF;
-
 	switch (params_rate(params)) {
 	case 8000:
 		fs		= DA7210_PLL_FS_8000;
-		hpf_mask	= DA7210_VOICE_F0_MASK	| DA7210_VOICE_EN;
-		hpf_value	= DA7210_VOICE_F0_25	| DA7210_VOICE_EN;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	case 11025:
 		fs		= DA7210_PLL_FS_11025;
-		hpf_mask	= DA7210_VOICE_F0_MASK	| DA7210_VOICE_EN;
-		hpf_value	= DA7210_VOICE_F0_25	| DA7210_VOICE_EN;
 		bypass		= 0;
 		break;
 	case 12000:
 		fs		= DA7210_PLL_FS_12000;
-		hpf_mask	= DA7210_VOICE_F0_MASK	| DA7210_VOICE_EN;
-		hpf_value	= DA7210_VOICE_F0_25	| DA7210_VOICE_EN;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	case 16000:
 		fs		= DA7210_PLL_FS_16000;
-		hpf_mask	= DA7210_VOICE_F0_MASK	| DA7210_VOICE_EN;
-		hpf_value	= DA7210_VOICE_F0_25	| DA7210_VOICE_EN;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	case 22050:
 		fs		= DA7210_PLL_FS_22050;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= 0;
 		break;
 	case 32000:
 		fs		= DA7210_PLL_FS_32000;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	case 44100:
 		fs		= DA7210_PLL_FS_44100;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= 0;
 		break;
 	case 48000:
 		fs		= DA7210_PLL_FS_48000;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	case 88200:
 		fs		= DA7210_PLL_FS_88200;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= 0;
 		break;
 	case 96000:
 		fs		= DA7210_PLL_FS_96000;
-		hpf_mask	= DA7210_VOICE_EN;
-		hpf_value	= 0;
 		bypass		= DA7210_PLL_BYP;
 		break;
 	default:
@@ -377,7 +385,6 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	/* Disable active mode */
 	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
 
-	snd_soc_update_bits(codec, hpf_reg, hpf_mask, hpf_value);
 	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_FS_MASK, fs);
 	snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, bypass);
 
-- 
1.7.1
