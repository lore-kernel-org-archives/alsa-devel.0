From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v8 3/3 RESEND] ASoC: da7210: Add support for
 line input and mic
Date: Mon, 2 Jan 2012 17:35:52 +0530
Message-ID: <1325505952.12508.12.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FFFB244A8
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 12:53:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

DA7210 has three line inputs (AUX1 Left, AUX1 Right and AUX2) and
a stereo MIC. This patch adds gain controls for MIC, AUX1, AUX2 as
well as INPGA.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v7:
- Added DAPM support for AUX1, AUX2 and INPGA (Moved here from DAPM
patch)

Changes since v2:
- Removed static enable of mic and aux, as now DAPM will take care of
that

Changes since v1:
- Removed explicit setting of default gains
- Removed control to set mic bias voltage
---
 sound/soc/codecs/da7210.c |   77 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 62e6a9c..ab38e93 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -181,9 +181,14 @@
 
 /* AUX1_L bit fields */
 #define DA7210_AUX1_L_VOL		(0x3F << 0)
+#define DA7210_AUX1_L_EN		(1 << 7)
 
 /* AUX1_R bit fields */
 #define DA7210_AUX1_R_VOL		(0x3F << 0)
+#define DA7210_AUX1_R_EN		(1 << 7)
+
+/* AUX2 bit fields */
+#define DA7210_AUX2_EN			(1 << 3)
 
 /* Minimum INPGA and AUX1 volume to enable noise suppression */
 #define DA7210_INPGA_MIN_VOL_NS		0x0A  /* 10.5dB */
@@ -234,9 +239,19 @@ static const unsigned int mono_vol_tlv[] = {
 	0x3, 0x7, TLV_DB_SCALE_ITEM(-1800, 600, 0)
 };
 
+static const unsigned int aux1_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	/* -48dB to 21dB */
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-4800, 150, 0)
+};
+
 static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
 static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
+static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(aux2_vol_tlv, -600, 600, 0);
+static const DECLARE_TLV_DB_SCALE(inpga_gain_tlv, -450, 150, 0);
 
 /* ADC and DAC high pass filter f0 value */
 static const char * const da7210_hpf_cutoff_txt[] = {
@@ -344,6 +359,17 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 	SOC_SINGLE_TLV("Mono Playback Volume", DA7210_OUT2, 0, 0x7, 0,
 		       mono_vol_tlv),
 
+	SOC_DOUBLE_R_TLV("Mic Capture Volume",
+			 DA7210_MIC_L, DA7210_MIC_R,
+			 0, 0x5, 0, mic_vol_tlv),
+	SOC_DOUBLE_R_TLV("Aux1 Capture Volume",
+			 DA7210_AUX1_L, DA7210_AUX1_R,
+			 0, 0x3f, 0, aux1_vol_tlv),
+	SOC_SINGLE_TLV("Aux2 Capture Volume", DA7210_AUX2, 0, 0x3, 0,
+		       aux2_vol_tlv),
+	SOC_DOUBLE_TLV("In PGA Capture Volume", DA7210_IN_GAIN, 0, 4, 0xF, 0,
+		       inpga_gain_tlv),
+
 	/* DAC Equalizer  controls */
 	SOC_SINGLE("DAC EQ Switch", DA7210_DAC_EQ5, 7, 1, 0),
 	SOC_SINGLE_TLV("DAC EQ1 Volume", DA7210_DAC_EQ1_2, 0, 0xf, 1,
@@ -421,26 +447,42 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 static const struct snd_kcontrol_new da7210_dapm_inmixl_controls[] = {
 	SOC_DAPM_SINGLE("Mic Left Switch", DA7210_INMIX_L, 0, 1, 0),
 	SOC_DAPM_SINGLE("Mic Right Switch", DA7210_INMIX_L, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux1 Left Switch", DA7210_INMIX_L, 2, 1, 0),
+	SOC_DAPM_SINGLE("Aux2 Switch", DA7210_INMIX_L, 3, 1, 0),
+	SOC_DAPM_SINGLE("Outmix Left Switch", DA7210_INMIX_L, 4, 1, 0),
 };
 
 /* In Mixer Right */
 static const struct snd_kcontrol_new da7210_dapm_inmixr_controls[] = {
 	SOC_DAPM_SINGLE("Mic Right Switch", DA7210_INMIX_R, 0, 1, 0),
 	SOC_DAPM_SINGLE("Mic Left Switch", DA7210_INMIX_R, 1, 1, 0),
+	SOC_DAPM_SINGLE("Aux1 Right Switch", DA7210_INMIX_R, 2, 1, 0),
+	SOC_DAPM_SINGLE("Aux2 Switch", DA7210_INMIX_R, 3, 1, 0),
+	SOC_DAPM_SINGLE("Outmix Right Switch", DA7210_INMIX_R, 4, 1, 0),
 };
 
 /* Out Mixer Left */
 static const struct snd_kcontrol_new da7210_dapm_outmixl_controls[] = {
+	SOC_DAPM_SINGLE("Aux1 Left Switch", DA7210_OUTMIX_L, 0, 1, 0),
+	SOC_DAPM_SINGLE("Aux2 Switch", DA7210_OUTMIX_L, 1, 1, 0),
+	SOC_DAPM_SINGLE("INPGA Left Switch", DA7210_OUTMIX_L, 2, 1, 0),
+	SOC_DAPM_SINGLE("INPGA Right Switch", DA7210_OUTMIX_L, 3, 1, 0),
 	SOC_DAPM_SINGLE("DAC Left Switch", DA7210_OUTMIX_L, 4, 1, 0),
 };
 
 /* Out Mixer Right */
 static const struct snd_kcontrol_new da7210_dapm_outmixr_controls[] = {
+	SOC_DAPM_SINGLE("Aux1 Right Switch", DA7210_OUTMIX_R, 0, 1, 0),
+	SOC_DAPM_SINGLE("Aux2 Switch", DA7210_OUTMIX_R, 1, 1, 0),
+	SOC_DAPM_SINGLE("INPGA Left Switch", DA7210_OUTMIX_R, 2, 1, 0),
+	SOC_DAPM_SINGLE("INPGA Right Switch", DA7210_OUTMIX_R, 3, 1, 0),
 	SOC_DAPM_SINGLE("DAC Right Switch", DA7210_OUTMIX_R, 4, 1, 0),
 };
 
 /* Mono Mixer */
 static const struct snd_kcontrol_new da7210_dapm_monomix_controls[] = {
+	SOC_DAPM_SINGLE("INPGA Right Switch", DA7210_OUT2, 3, 1, 0),
+	SOC_DAPM_SINGLE("INPGA Left Switch", DA7210_OUT2, 4, 1, 0),
 	SOC_DAPM_SINGLE("Outmix Right Switch", DA7210_OUT2, 5, 1, 0),
 	SOC_DAPM_SINGLE("Outmix Left Switch", DA7210_OUT2, 6, 1, 0),
 };
@@ -451,14 +493,23 @@ static const struct snd_soc_dapm_widget da7210_dapm_widgets[] = {
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("MICL"),
 	SND_SOC_DAPM_INPUT("MICR"),
+	SND_SOC_DAPM_INPUT("AUX1L"),
+	SND_SOC_DAPM_INPUT("AUX1R"),
+	SND_SOC_DAPM_INPUT("AUX2"),
 
 	/* Input PGAs */
 	SND_SOC_DAPM_PGA("Mic Left", DA7210_STARTUP3, 0, 1, NULL, 0),
 	SND_SOC_DAPM_PGA("Mic Right", DA7210_STARTUP3, 1, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Aux1 Left", DA7210_STARTUP3, 2, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Aux1 Right", DA7210_STARTUP3, 3, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Aux2 Mono", DA7210_STARTUP3, 4, 1, NULL, 0),
 
 	SND_SOC_DAPM_PGA("INPGA Left", DA7210_INMIX_L, 7, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("INPGA Right", DA7210_INMIX_R, 7, 0, NULL, 0),
 
+	/* MICBIAS */
+	SND_SOC_DAPM_SUPPLY("Mic Bias", DA7210_MIC_L, 6, 0, NULL, 0),
+
 	/* Input Mixers */
 	SND_SOC_DAPM_MIXER("In Mixer Left", SND_SOC_NOPM, 0, 0,
 		&da7210_dapm_inmixl_controls[0],
@@ -514,12 +565,21 @@ static const struct snd_soc_dapm_route da7210_audio_map[] = {
 	/* Input path */
 	{"Mic Left", NULL, "MICL"},
 	{"Mic Right", NULL, "MICR"},
+	{"Aux1 Left", NULL, "AUX1L"},
+	{"Aux1 Right", NULL, "AUX1R"},
+	{"Aux2 Mono", NULL, "AUX2"},
 
 	{"In Mixer Left", "Mic Left Switch", "Mic Left"},
 	{"In Mixer Left", "Mic Right Switch", "Mic Right"},
+	{"In Mixer Left", "Aux1 Left Switch", "Aux1 Left"},
+	{"In Mixer Left", "Aux2 Switch", "Aux2 Mono"},
+	{"In Mixer Left", "Outmix Left Switch", "Out Mixer Left"},
 
 	{"In Mixer Right", "Mic Right Switch", "Mic Right"},
 	{"In Mixer Right", "Mic Left Switch", "Mic Left"},
+	{"In Mixer Right", "Aux1 Right Switch", "Aux1 Right"},
+	{"In Mixer Right", "Aux2 Switch", "Aux2 Mono"},
+	{"In Mixer Right", "Outmix Right Switch", "Out Mixer Right"},
 
 	{"INPGA Left", NULL, "In Mixer Left"},
 	{"ADC Left", NULL, "INPGA Left"},
@@ -528,9 +588,20 @@ static const struct snd_soc_dapm_route da7210_audio_map[] = {
 	{"ADC Right", NULL, "INPGA Right"},
 
 	/* Output path */
+	{"Out Mixer Left", "Aux1 Left Switch", "Aux1 Left"},
+	{"Out Mixer Left", "Aux2 Switch", "Aux2 Mono"},
+	{"Out Mixer Left", "INPGA Left Switch", "INPGA Left"},
+	{"Out Mixer Left", "INPGA Right Switch", "INPGA Right"},
 	{"Out Mixer Left", "DAC Left Switch", "DAC Left"},
+
+	{"Out Mixer Right", "Aux1 Right Switch", "Aux1 Right"},
+	{"Out Mixer Right", "Aux2 Switch", "Aux2 Mono"},
+	{"Out Mixer Right", "INPGA Right Switch", "INPGA Right"},
+	{"Out Mixer Right", "INPGA Left Switch", "INPGA Left"},
 	{"Out Mixer Right", "DAC Right Switch", "DAC Right"},
 
+	{"Mono Mixer", "INPGA Right Switch", "INPGA Right"},
+	{"Mono Mixer", "INPGA Left Switch", "INPGA Left"},
 	{"Mono Mixer", "Outmix Right Switch", "Out Mixer Right"},
 	{"Mono Mixer", "Outmix Left Switch", "Out Mixer Left"},
 
@@ -887,6 +958,12 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
 		     DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
 
+	/* Enable Aux1 */
+	snd_soc_write(codec, DA7210_AUX1_L, DA7210_AUX1_L_EN);
+	snd_soc_write(codec, DA7210_AUX1_R, DA7210_AUX1_R_EN);
+	/* Enable Aux2 */
+	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
+
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-- 
1.7.1
