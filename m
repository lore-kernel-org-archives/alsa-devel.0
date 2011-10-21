From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v8 2/3] ASoC: da7210: Add support for line out
 and DAC
Date: Fri, 21 Oct 2011 19:06:23 +0530
Message-ID: <1319204183.24621.265.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id B04F9103AED
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 15:25:36 +0200 (CEST)
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

DA7210 has three line outputs. OUT1 Left, OUT1 Right and OUT2 (mono).
This patch adds support for gain controls for these three line outs.
It also adds support for overall DAC gain control.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v7:
- Added DAPM support for OUT1 and OUT2 (Moved here from DAPM patch)
- Added comment explaining rational behind usage of STANDBY bits

Changes since v1:
- Removed explicit setting of default gains
- Renamed "DAC Playback" to "Digital Playback"
---
 sound/soc/codecs/da7210.c |   96 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 7a4b952..0ebcbd5 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -54,6 +54,9 @@
 #define DA7210_DAC_EQ5			0x1B
 #define DA7210_OUTMIX_L			0x1C
 #define DA7210_OUTMIX_R			0x1D
+#define DA7210_OUT1_L			0x1E
+#define DA7210_OUT1_R			0x1F
+#define DA7210_OUT2			0x20
 #define DA7210_HP_L_VOL			0x21
 #define DA7210_HP_R_VOL			0x22
 #define DA7210_HP_CFG			0x23
@@ -186,6 +189,17 @@
 #define DA7210_INPGA_MIN_VOL_NS		0x0A  /* 10.5dB */
 #define DA7210_AUX1_MIN_VOL_NS		0x35  /* 6dB */
 
+/* OUT1_L bit fields */
+#define DA7210_OUT1_L_EN		(1 << 7)
+
+/* OUT1_R bit fields */
+#define DA7210_OUT1_R_EN		(1 << 7)
+
+/* OUT2 bit fields */
+#define DA7210_OUT2_OUTMIX_R		(1 << 5)
+#define DA7210_OUT2_OUTMIX_L		(1 << 6)
+#define DA7210_OUT2_EN			(1 << 7)
+
 #define DA7210_VERSION "0.0.1"
 
 /*
@@ -206,8 +220,23 @@ static const unsigned int hp_out_tlv[] = {
 	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0),
 };
 
+static const unsigned int lineout_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x10, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	/* -54dB to 15dB */
+	0x11, 0x3f, TLV_DB_SCALE_ITEM(-5400, 150, 0)
+};
+
+static const unsigned int mono_vol_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0x0, 0x2, TLV_DB_SCALE_ITEM(-1800, 0, 1),
+	/* -18dB to 6dB */
+	0x3, 0x7, TLV_DB_SCALE_ITEM(-1800, 600, 0)
+};
+
 static const DECLARE_TLV_DB_SCALE(eq_gain_tlv, -1050, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_eq_master_gain_tlv, -1800, 600, 1);
+static const DECLARE_TLV_DB_SCALE(dac_gain_tlv, -7725, 75, 0);
 
 /* ADC and DAC high pass filter f0 value */
 static const char const *da7210_hpf_cutoff_txt[] = {
@@ -306,6 +335,14 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("HeadPhone Playback Volume",
 			 DA7210_HP_L_VOL, DA7210_HP_R_VOL,
 			 0, 0x3F, 0, hp_out_tlv),
+	SOC_DOUBLE_R_TLV("Digital Playback Volume",
+			 DA7210_DAC_L, DA7210_DAC_R,
+			 0, 0x77, 1, dac_gain_tlv),
+	SOC_DOUBLE_R_TLV("Lineout Playback Volume",
+			 DA7210_OUT1_L, DA7210_OUT1_R,
+			 0, 0x3f, 0, lineout_vol_tlv),
+	SOC_SINGLE_TLV("Mono Playback Volume", DA7210_OUT2, 0, 0x7, 0,
+		       mono_vol_tlv),
 
 	/* DAC Equalizer  controls */
 	SOC_SINGLE("DAC EQ Switch", DA7210_DAC_EQ5, 7, 1, 0),
@@ -402,6 +439,12 @@ static const struct snd_kcontrol_new da7210_dapm_outmixr_controls[] = {
 	SOC_DAPM_SINGLE("DAC Right Switch", DA7210_OUTMIX_R, 4, 1, 0),
 };
 
+/* Mono Mixer */
+static const struct snd_kcontrol_new da7210_dapm_monomix_controls[] = {
+	SOC_DAPM_SINGLE("Outmix Right Switch", DA7210_OUT2, 5, 1, 0),
+	SOC_DAPM_SINGLE("Outmix Left Switch", DA7210_OUT2, 6, 1, 0),
+};
+
 /* DAPM widgets */
 static const struct snd_soc_dapm_widget da7210_dapm_widgets[] = {
 	/* Input Side */
@@ -443,16 +486,26 @@ static const struct snd_soc_dapm_widget da7210_dapm_widgets[] = {
 		&da7210_dapm_outmixr_controls[0],
 		ARRAY_SIZE(da7210_dapm_outmixr_controls)),
 
+	SND_SOC_DAPM_MIXER("Mono Mixer", SND_SOC_NOPM, 0, 0,
+		&da7210_dapm_monomix_controls[0],
+		ARRAY_SIZE(da7210_dapm_monomix_controls)),
+
 	/* Output PGAs */
 	SND_SOC_DAPM_PGA("OUTPGA Left Enable", DA7210_OUTMIX_L, 7, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("OUTPGA Right Enable", DA7210_OUTMIX_R, 7, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("Out1 Left", DA7210_STARTUP2, 0, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Out1 Right", DA7210_STARTUP2, 1, 1, NULL, 0),
+	SND_SOC_DAPM_PGA("Out2 Mono", DA7210_STARTUP2, 2, 1, NULL, 0),
 	SND_SOC_DAPM_PGA("Headphone Left", DA7210_STARTUP2, 3, 1, NULL, 0),
 	SND_SOC_DAPM_PGA("Headphone Right", DA7210_STARTUP2, 4, 1, NULL, 0),
 
 	/* Output Lines */
+	SND_SOC_DAPM_OUTPUT("OUT1L"),
+	SND_SOC_DAPM_OUTPUT("OUT1R"),
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
 };
 
 /* DAPM audio route definition */
@@ -478,14 +531,26 @@ static const struct snd_soc_dapm_route da7210_audio_map[] = {
 	{"Out Mixer Left", "DAC Left Switch", "DAC Left"},
 	{"Out Mixer Right", "DAC Right Switch", "DAC Right"},
 
+	{"Mono Mixer", "Outmix Right Switch", "Out Mixer Right"},
+	{"Mono Mixer", "Outmix Left Switch", "Out Mixer Left"},
+
 	{"OUTPGA Left Enable", NULL, "Out Mixer Left"},
 	{"OUTPGA Right Enable", NULL, "Out Mixer Right"},
 
+	{"Out1 Left", NULL, "OUTPGA Left Enable"},
+	{"OUT1L", NULL, "Out1 Left"},
+
+	{"Out1 Right", NULL, "OUTPGA Right Enable"},
+	{"OUT1R", NULL, "Out1 Right"},
+
 	{"Headphone Left", NULL, "OUTPGA Left Enable"},
 	{"HPL", NULL, "Headphone Left"},
 
 	{"Headphone Right", NULL, "OUTPGA Right Enable"},
 	{"HPR", NULL, "Headphone Right"},
+
+	{"Out2 Mono", NULL, "Mono Mixer"},
+	{"OUT2", NULL, "Out2 Mono"},
 };
 
 /* Codec private data */
@@ -791,6 +856,37 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	/* Enable ramp mode for DAC gain update */
 	snd_soc_write(codec, DA7210_SOFTMUTE, DA7210_RAMP_EN);
 
+	/*
+	 * For DA7210 codec, there are two ways to enable/disable analog IOs
+	 * and ADC/DAC,
+	 * (1) Using "Enable Bit" of register associated with that IO
+	 * (or ADC/DAC)
+	 *	e.g. Mic Left can be enabled using bit 7 of MIC_L(0x7) reg
+	 *
+	 * (2) Using "Standby Bit" of STARTUP2 or STARTUP3 register
+	 *	e.g. Mic left can be put to STANDBY using bit 0 of STARTUP3(0x5)
+	 *
+	 * Out of these two methods, the one using STANDBY bits is preferred
+	 * way to enable/disable individual blocks. This is because STANDBY
+	 * registers are part of system controller which allows system power
+	 * up/down in a controlled, pop-free manner. Also, as per application
+	 * note of DA7210, STANDBY register bits are only effective if a
+	 * particular IO (or ADC/DAC) is already enabled using enable/disable
+	 * register bits. Keeping these things in mind, current DAPM
+	 * implementation manipulates only STANDBY bits.
+	 *
+	 * Overall implementation can be outlined as below,
+	 *
+	 * - "Enable bit" of an IO or ADC/DAC is used to enable it in probe()
+	 * - "STANDBY bit" is controlled by DAPM
+	 */
+
+	/* Enable Line out amplifiers */
+	snd_soc_write(codec, DA7210_OUT1_L, DA7210_OUT1_L_EN);
+	snd_soc_write(codec, DA7210_OUT1_R, DA7210_OUT1_R_EN);
+	snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
+		     DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
+
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-- 
1.7.1
