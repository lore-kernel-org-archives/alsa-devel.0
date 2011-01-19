From: Harsha Priya <priya.harsha@intel.com>
Subject: [PATCH 1/4] ASoC: sn95031: add capture support
Date: Wed, 19 Jan 2011 18:16:09 +0530
Message-ID: <1295441169-32063-1-git-send-email-priya.harsha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 99B7824465
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:32:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This patch adds the support for capture path in sn95031 codec.
This codec supports upto 6DMICs, 2 AMICs and Linein. The linein and AMICs
are connected through a MUX to ADC. The TX paths can be assigned to any of the
ADCs or DMICs.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |  292 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 291 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 593632c..5e8d091 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -33,6 +33,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/initval.h>
+#include <sound/tlv.h>
 #include "sn95031.h"
 
 #define SN95031_RATES (SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_44100)
@@ -40,7 +41,6 @@
 
 /*
  * todo:
- * capture paths
  * jack detection
  * PM functions
  */
@@ -145,6 +145,167 @@ static int sn95031_vihf_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int amic1_mic_bias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	unsigned int value = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("AMIC1 SND_SOC_DAPM_EVENT_ON doing\n");
+		value = BIT(2);
+	}
+	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(2), value);
+	return 0;
+}
+
+static int amic2_mic_bias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	unsigned int value = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("AMIC2 SND_SOC_DAPM_EVENT_ON doing\n");
+		value = BIT(3);
+	}
+	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(3), value);
+	return 0;
+}
+
+static int dmic12_mic_bias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	unsigned int ldo = 0, clk = 0, out = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("DMIC12 SND_SOC_DAPM_EVENT_ON doing\n");
+		ldo = BIT(5)|BIT(4);
+		clk = BIT(0);
+		out = BIT(3);
+	}
+	/* program DMIC LDO */
+	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
+	msleep(1);
+	/* enable/disable DMIC clock and o/p */
+	snd_soc_update_bits(w->codec, SN95031_DMICLK, BIT(0), clk);
+	snd_soc_update_bits(w->codec, SN95031_DMICMUX, BIT(3), out);
+	return 0;
+}
+
+static int dmic34_mic_bias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	unsigned int ldo = 0, clk = 0, out = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("DMIC34 SND_SOC_DAPM_EVENT_ON doing\n");
+		ldo = BIT(5)|BIT(4);
+		clk = BIT(1);
+		out = BIT(4);
+	}
+	/* program DMIC LDO */
+	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
+	msleep(1);
+	/* enable/disable DMIC clock */
+	snd_soc_update_bits(w->codec, SN95031_DMICLK, BIT(1), clk);
+	snd_soc_update_bits(w->codec, SN95031_DMICMUX, BIT(4), out);
+	return 0;
+}
+
+static int dmic56_mic_bias(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *k, int event)
+{
+	unsigned int ldo = 0, clk = 0, out = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		pr_debug("DMIC56 SND_SOC_DAPM_EVENT_ON doing\n");
+		ldo = BIT(7)|BIT(6);
+		clk = BIT(2);
+		out = BIT(5);
+	}
+	/* program DMIC LDO */
+	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(7)|BIT(6), ldo);
+	msleep(1);
+	/* enable/disable DMIC clock */
+	snd_soc_update_bits(w->codec, SN95031_DMICLK, BIT(2), clk);
+	snd_soc_update_bits(w->codec, SN95031_DMICMUX, BIT(5)|BIT(2), out);
+	return 0;
+}
+/* mux controls */
+static const char *sn95031_mic_texts[] = { "AMIC", "LineIn" };
+
+static const struct soc_enum sn95031_micl_enum =
+	SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 1, 2, sn95031_mic_texts);
+
+static const struct snd_kcontrol_new sn95031_micl_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_micl_enum);
+
+static const struct soc_enum sn95031_micr_enum =
+	SOC_ENUM_SINGLE(SN95031_ADCCONFIG, 3, 2, sn95031_mic_texts);
+
+static const struct snd_kcontrol_new sn95031_micr_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_micr_enum);
+
+static const char *sn95031_input_texts[] = {	"DMIC1", "DMIC2", "DMIC3",
+						"DMIC4", "DMIC5", "DMIC6",
+						"ADC Left", "ADC Right" };
+
+static const struct soc_enum sn95031_input1_enum =
+	SOC_ENUM_SINGLE(SN95031_AUDIOMUX12, 0, 8, sn95031_input_texts);
+
+static const struct snd_kcontrol_new sn95031_input1_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_input1_enum);
+
+static const struct soc_enum sn95031_input2_enum =
+	SOC_ENUM_SINGLE(SN95031_AUDIOMUX12, 4, 8, sn95031_input_texts);
+
+static const struct snd_kcontrol_new sn95031_input2_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_input2_enum);
+
+static const struct soc_enum sn95031_input3_enum =
+	SOC_ENUM_SINGLE(SN95031_AUDIOMUX34, 0, 8, sn95031_input_texts);
+
+static const struct snd_kcontrol_new sn95031_input3_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_input3_enum);
+
+static const struct soc_enum sn95031_input4_enum =
+	SOC_ENUM_SINGLE(SN95031_AUDIOMUX34, 4, 8, sn95031_input_texts);
+
+static const struct snd_kcontrol_new sn95031_input4_mux_control =
+	SOC_DAPM_ENUM("Route", sn95031_input4_enum);
+
+/* capture path controls */
+
+/* 0dB to 30dB in 10dB steps */
+static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 10, 30);
+
+static const char *sn95031_micmode_text[] = {"Single Ended", "Differential"};
+
+static const struct soc_enum sn95031_micmode1_enum =
+	SOC_ENUM_SINGLE(SN95031_MICAMP1, 1, 2, sn95031_micmode_text);
+static const struct soc_enum sn95031_micmode2_enum =
+	SOC_ENUM_SINGLE(SN95031_MICAMP2, 1, 2, sn95031_micmode_text);
+
+static const char *sn95031_dmic_cfg_text[] = {"GPO", "DMIC"};
+
+static const struct soc_enum sn95031_dmic12_cfg_enum =
+	SOC_ENUM_SINGLE(SN95031_DMICMUX, 0, 2, sn95031_dmic_cfg_text);
+static const struct soc_enum sn95031_dmic34_cfg_enum =
+	SOC_ENUM_SINGLE(SN95031_DMICMUX, 1, 2, sn95031_dmic_cfg_text);
+static const struct soc_enum sn95031_dmic56_cfg_enum =
+	SOC_ENUM_SINGLE(SN95031_DMICMUX, 2, 2, sn95031_dmic_cfg_text);
+
+static const struct snd_kcontrol_new sn95031_snd_controls[] = {
+	SOC_ENUM("Mic1Mode Capture Route", sn95031_micmode1_enum),
+	SOC_ENUM("Mic2Mode Capture Route", sn95031_micmode2_enum),
+	SOC_ENUM("DMIC12 Capture Route", sn95031_dmic12_cfg_enum),
+	SOC_ENUM("DMIC34 Capture Route", sn95031_dmic34_cfg_enum),
+	SOC_ENUM("DMIC56 Capture Route", sn95031_dmic56_cfg_enum),
+	SOC_SINGLE_TLV("Mic1 Capture Volume", SN95031_MICAMP1,
+			2, 4, 0, mic_tlv),
+	SOC_SINGLE_TLV("Mic2 Capture Volume", SN95031_MICAMP2,
+			2, 4, 0, mic_tlv),
+};
+
 /* DAPM widgets */
 static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 
@@ -159,6 +320,20 @@ static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("VIB1OUT"),
 	SND_SOC_DAPM_OUTPUT("VIB2OUT"),
 
+	SND_SOC_DAPM_MIC("AMIC1", amic1_mic_bias), /* headset mic */
+	SND_SOC_DAPM_MIC("AMIC2", amic2_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC1", dmic12_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC2", dmic12_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC3", dmic34_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC4", dmic34_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC5", dmic56_mic_bias),
+	SND_SOC_DAPM_MIC("DMIC6", dmic56_mic_bias),
+	SND_SOC_DAPM_INPUT("LINEINL"),
+	SND_SOC_DAPM_INPUT("LINEINR"),
+
+	SND_SOC_DAPM_AIF_OUT("PCM_Out", "Capture", 0,
+			SND_SOC_NOPM, 0, 0),
+
 	SND_SOC_DAPM_SUPPLY("Headset Rail", SND_SOC_NOPM, 0, 0,
 			sn95031_vhs_event,
 			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -209,6 +384,46 @@ static const struct snd_soc_dapm_widget sn95031_dapm_widgets[] = {
 			SN95031_VIB1C5, 1, 0),
 	SND_SOC_DAPM_DAC("Vibra2 DAC", "Vibra2",
 			SN95031_VIB2C5, 1, 0),
+
+	/* capture widgets */
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "LineIn Enable Left",
+			SN95031_MICAMP1, 7, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "LineIn Enable Right",
+			SN95031_MICAMP2, 7, 1, 1, 0),
+
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC1 Enable", SN95031_MICAMP1,
+			0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "MIC2 Enable", SN95031_MICAMP2,
+			0, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "TX1 Enable", SN95031_AUDIOTXEN,
+			2, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "TX2 Enable", SN95031_AUDIOTXEN,
+			3, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "TX3 Enable", SN95031_AUDIOTXEN,
+			4, 1, 1, 0),
+	SND_SOC_DAPM_REG(snd_soc_dapm_switch, "TX4 Enable", SN95031_AUDIOTXEN,
+			5, 1, 1, 0),
+
+	/* ADC have null stream as they will be turned ON by TX path */
+	SND_SOC_DAPM_ADC("ADC Left", NULL,
+			SN95031_ADCCONFIG, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Right", NULL,
+			SN95031_ADCCONFIG, 2, 0),
+
+	SND_SOC_DAPM_MUX("Mic_InputL Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_micl_mux_control),
+	SND_SOC_DAPM_MUX("Mic_InputR Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_micr_mux_control),
+
+	SND_SOC_DAPM_MUX("Txpath1 Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_input1_mux_control),
+	SND_SOC_DAPM_MUX("Txpath2 Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_input2_mux_control),
+	SND_SOC_DAPM_MUX("Txpath3 Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_input3_mux_control),
+	SND_SOC_DAPM_MUX("Txpath4 Capture Route",
+			SND_SOC_NOPM, 0, 0, &sn95031_input4_mux_control),
+
 };
 
 static const struct snd_soc_dapm_route sn95031_audio_map[] = {
@@ -250,6 +465,69 @@ static const struct snd_soc_dapm_route sn95031_audio_map[] = {
 	{ "Lineout Right Playback", NULL, "Headset Right Filter"},
 	{ "Lineout Right Playback", NULL, "Speaker Right Filter"},
 	{ "Lineout Right Playback", NULL, "Vibra2 DAC"},
+
+	/* Headset (AMIC1) mic */
+	{ "MIC1 Enable", NULL, "AMIC1"},
+	{ "Mic_InputL Capture Route", "AMIC", "MIC1 Enable"},
+
+	/* AMIC2 */
+	{ "MIC2 Enable", NULL, "AMIC2"},
+	{ "Mic_InputR Capture Route", "AMIC", "MIC2 Enable"},
+
+
+	/* Linein */
+	{ "LineIn Enable Left", NULL, "LINEINL"},
+	{ "LineIn Enable Right", NULL, "LINEINR"},
+	{ "Mic_InputL Capture Route", "LineIn", "LineIn Enable Left"},
+	{ "Mic_InputR Capture Route", "LineIn", "LineIn Enable Right"},
+
+	/* ADC connection */
+	{ "ADC Left", NULL, "Mic_InputL Capture Route"},
+	{ "ADC Right", NULL, "Mic_InputR Capture Route"},
+
+	/*TX path inputs*/
+	{ "Txpath1 Capture Route", "ADC Left", "ADC Left"},
+	{ "Txpath2 Capture Route", "ADC Left", "ADC Left"},
+	{ "Txpath3 Capture Route", "ADC Left", "ADC Left"},
+	{ "Txpath4 Capture Route", "ADC Left", "ADC Left"},
+	{ "Txpath1 Capture Route", "ADC Right", "ADC Right"},
+	{ "Txpath2 Capture Route", "ADC Right", "ADC Right"},
+	{ "Txpath3 Capture Route", "ADC Right", "ADC Right"},
+	{ "Txpath4 Capture Route", "ADC Right", "ADC Right"},
+	{ "Txpath1 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath2 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath3 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath4 Capture Route", "DMIC1", "DMIC1"},
+	{ "Txpath1 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath2 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath3 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath4 Capture Route", "DMIC2", "DMIC2"},
+	{ "Txpath1 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath2 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath3 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath4 Capture Route", "DMIC3", "DMIC3"},
+	{ "Txpath1 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath2 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath3 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath4 Capture Route", "DMIC4", "DMIC4"},
+	{ "Txpath1 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath2 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath3 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath4 Capture Route", "DMIC5", "DMIC5"},
+	{ "Txpath1 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath2 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath3 Capture Route", "DMIC6", "DMIC6"},
+	{ "Txpath4 Capture Route", "DMIC6", "DMIC6"},
+
+	/* tx path */
+	{ "TX1 Enable", NULL, "Txpath1 Capture Route"},
+	{ "TX2 Enable", NULL, "Txpath2 Capture Route"},
+	{ "TX3 Enable", NULL, "Txpath3 Capture Route"},
+	{ "TX4 Enable", NULL, "Txpath4 Capture Route"},
+	{ "PCM_Out", NULL, "TX1 Enable"},
+	{ "PCM_Out", NULL, "TX2 Enable"},
+	{ "PCM_Out", NULL, "TX3 Enable"},
+	{ "PCM_Out", NULL, "TX4 Enable"},
 };
 
 /* speaker and headset mutes, for audio pops and clicks */
@@ -339,6 +617,13 @@ struct snd_soc_dai_driver sn95031_dais[] = {
 		.rates = SN95031_RATES,
 		.formats = SN95031_FORMATS,
 	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 5,
+		.rates = SN95031_RATES,
+		.formats = SN95031_FORMATS,
+	},
 	.ops = &sn95031_headset_dai_ops,
 },
 {	.name = "SN95031 Speaker",
@@ -390,6 +675,8 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SN95031_PCM2RXSLOT01, 0x10);
 	snd_soc_write(codec, SN95031_PCM2RXSLOT23, 0x32);
 	snd_soc_write(codec, SN95031_PCM2RXSLOT45, 0x54);
+	snd_soc_write(codec, SN95031_PCM2TXSLOT01, 0x10);
+	snd_soc_write(codec, SN95031_PCM2TXSLOT23, 0x32);
 	/* pcm port setting
 	 * This sets the pcm port to slave and clock at 19.2Mhz which
 	 * can support 6slots, sampling rate set per stream in hw-params
@@ -423,6 +710,9 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, SN95031_SSR2, 0x10);
 	snd_soc_write(codec, SN95031_SSR3, 0x40);
 
+	snd_soc_add_controls(codec, sn95031_snd_controls,
+			     ARRAY_SIZE(sn95031_snd_controls));
+
 	ret = snd_soc_dapm_new_controls(&codec->dapm, sn95031_dapm_widgets,
 				ARRAY_SIZE(sn95031_dapm_widgets));
 	if (ret)
-- 
1.7.2.3
