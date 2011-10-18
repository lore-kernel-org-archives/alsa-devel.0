From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v5 1/2] ASoC: da7210: Add support for mute and
 zero cross controls
Date: Tue, 18 Oct 2011 19:11:31 +0530
Message-ID: <1318945291.13721.49.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 85B65103932
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 15:30:36 +0200 (CEST)
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

This patch adds support for below set of controls,
(1) Mute controls for MIC, AUX and ADC
(2) Zero cross controls for head phone, AUX, INPGA and line out
(3) Head phone mode selection - class H or G

It also adds digital_mute() call back.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v4:
- Converted ADC mute controls to a single stereo control

Changes since v2:
- Added digital_mute() call back and removed control for "DAC Mute
Switch"
- Renamed mute control switches

Changes since v1:
- Changed Mic mute control to a double control
- Fixed a typo
---
 sound/soc/codecs/da7210.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 480fc6d..a31be70 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -30,6 +30,7 @@
 #define DA7210_STARTUP1			0x03
 #define DA7210_MIC_L			0x07
 #define DA7210_MIC_R			0x08
+#define DA7210_AUX2			0x0B
 #define DA7210_INMIX_L			0x0D
 #define DA7210_INMIX_R			0x0E
 #define DA7210_ADC_HPF			0x0F
@@ -41,6 +42,7 @@
 #define DA7210_DAC_L			0x15
 #define DA7210_DAC_R			0x16
 #define DA7210_DAC_SEL			0x17
+#define DA7210_SOFTMUTE			0x18
 #define DA7210_DAC_EQ1_2		0x19
 #define DA7210_DAC_EQ3_4		0x1A
 #define DA7210_DAC_EQ5			0x1B
@@ -49,6 +51,7 @@
 #define DA7210_HP_L_VOL			0x21
 #define DA7210_HP_R_VOL			0x22
 #define DA7210_HP_CFG			0x23
+#define DA7210_ZERO_CROSS		0x24
 #define DA7210_DAI_SRC_SEL		0x25
 #define DA7210_DAI_CFG1			0x26
 #define DA7210_DAI_CFG3			0x28
@@ -144,6 +147,9 @@
 #define DA7210_PLL_FS_96000		(0xF << 0)
 #define DA7210_PLL_EN			(0x1 << 7)
 
+/* SOFTMUTE bit fields */
+#define DA7210_RAMP_EN			(1 << 6)
+
 #define DA7210_VERSION "0.0.1"
 
 /*
@@ -189,6 +195,13 @@ static const struct soc_enum da7210_dac_vf_cutoff =
 static const struct soc_enum da7210_adc_vf_cutoff =
 	SOC_ENUM_SINGLE(DA7210_ADC_HPF, 4, 8, da7210_vf_cutoff_txt);
 
+static const char *da7210_hp_mode_txt[] = {
+	"Class H", "Class G"
+};
+
+static const struct soc_enum da7210_hp_mode_sel =
+	SOC_ENUM_SINGLE(DA7210_HP_CFG, 0, 2, da7210_hp_mode_txt);
+
 static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HeadPhone Playback Volume",
@@ -232,6 +245,21 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 	SOC_ENUM("ADC HPF Cutoff", da7210_adc_hpf_cutoff),
 	SOC_SINGLE("ADC Voice Mode Switch", DA7210_ADC_HPF, 7, 1, 0),
 	SOC_ENUM("ADC Voice Cutoff", da7210_adc_vf_cutoff),
+
+	/* Mute controls */
+	SOC_DOUBLE_R("Mic Capture Switch", DA7210_MIC_L, DA7210_MIC_R, 3, 1, 0),
+	SOC_SINGLE("Aux2 Capture Switch", DA7210_AUX2, 2, 1, 0),
+	SOC_DOUBLE("ADC Capture Switch", DA7210_ADC, 2, 6, 1, 0),
+	SOC_SINGLE("Digital Soft Mute Switch", DA7210_SOFTMUTE, 7, 1, 0),
+	SOC_SINGLE("Digital Soft Mute Rate", DA7210_SOFTMUTE, 0, 0x7, 0),
+
+	/* Zero cross controls */
+	SOC_DOUBLE("Aux1 ZC Switch", DA7210_ZERO_CROSS, 0, 1, 1, 0),
+	SOC_DOUBLE("In PGA ZC Switch", DA7210_ZERO_CROSS, 2, 3, 1, 0),
+	SOC_DOUBLE("Lineout ZC Switch", DA7210_ZERO_CROSS, 4, 5, 1, 0),
+	SOC_DOUBLE("Headphone ZC Switch", DA7210_ZERO_CROSS, 6, 7, 1, 0),
+
+	SOC_ENUM("Headphone Class", da7210_hp_mode_sel),
 };
 
 /* Codec private data */
@@ -448,6 +476,18 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 	return 0;
 }
 
+static int da7210_mute(struct snd_soc_dai *dai, int mute)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	u8 mute_reg = snd_soc_read(codec, DA7210_DAC_HPF) & 0xFB;
+
+	if (mute)
+		snd_soc_write(codec, DA7210_DAC_HPF, mute_reg | 0x4);
+	else
+		snd_soc_write(codec, DA7210_DAC_HPF, mute_reg);
+	return 0;
+}
+
 #define DA7210_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
@@ -456,6 +496,7 @@ static struct snd_soc_dai_ops da7210_dai_ops = {
 	.startup	= da7210_startup,
 	.hw_params	= da7210_hw_params,
 	.set_fmt	= da7210_set_dai_fmt,
+	.digital_mute	= da7210_mute,
 };
 
 static struct snd_soc_dai_driver da7210_dai = {
@@ -545,6 +586,9 @@ static int da7210_probe(struct snd_soc_codec *codec)
 		     DA7210_HP_2CAP_MODE | DA7210_HP_SENSE_EN |
 		     DA7210_HP_L_EN | DA7210_HP_MODE | DA7210_HP_R_EN);
 
+	/* Enable ramp mode for DAC gain update */
+	snd_soc_write(codec, DA7210_SOFTMUTE, DA7210_RAMP_EN);
+
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-- 
1.7.1
