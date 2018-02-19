From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: add 'Audio Switch' block
	implementation" to the asoc tree
Date: Mon, 19 Feb 2018 12:18:23 +0000
Message-ID: <E1enkOl-0002js-IY@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 831D12673F2
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:18:24 +0100 (CET)
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
To: Michal Oleszczyk <oleszczyk.m@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: add 'Audio Switch' block implementation

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 7f7d5239f56cfd25ba8470354d9705815c079157 Mon Sep 17 00:00:00 2001
From: Michal Oleszczyk <oleszczyk.m@gmail.com>
Date: Mon, 19 Feb 2018 10:03:45 +0100
Subject: [PATCH] ASoC: sgtl5000: add 'Audio Switch' block implementation

Add mux for choosing DAC source: ADC, I2S or DAP. DAP - digital
audio processing block. Moreover create choosing mux for DAP main
source (ADC or I2S) and DAP mixer source (ADC or I2S). Mixer block
allows summing DAP main and mixer sources togheter with defined
volumes.

Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 78 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 05592ddcf0e6..1724c4622052 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -216,17 +216,54 @@ static SOC_ENUM_SINGLE_DECL(adc_enum,
 static const struct snd_kcontrol_new adc_mux =
 SOC_DAPM_ENUM("Capture Mux", adc_enum);
 
+/* input sources for headphone */
+static const char *hp_mux_text[] = {
+	"DAC", "LINE_IN"
+};
+
+static SOC_ENUM_SINGLE_DECL(hp_enum,
+			    SGTL5000_CHIP_ANA_CTRL, 6,
+			    hp_mux_text);
+
+static const struct snd_kcontrol_new hp_mux =
+SOC_DAPM_ENUM("Headphone Mux", hp_enum);
+
 /* input sources for DAC */
 static const char *dac_mux_text[] = {
-	"DAC", "LINE_IN"
+	"ADC", "I2S", "Rsvrd", "DAP"
 };
 
 static SOC_ENUM_SINGLE_DECL(dac_enum,
-			    SGTL5000_CHIP_ANA_CTRL, 6,
+			    SGTL5000_CHIP_SSS_CTRL, SGTL5000_DAC_SEL_SHIFT,
 			    dac_mux_text);
 
 static const struct snd_kcontrol_new dac_mux =
-SOC_DAPM_ENUM("Headphone Mux", dac_enum);
+SOC_DAPM_ENUM("Digital Input Mux", dac_enum);
+
+/* input sources for DAP */
+static const char *dap_mux_text[] = {
+	"ADC", "I2S"
+};
+
+static SOC_ENUM_SINGLE_DECL(dap_enum,
+			    SGTL5000_CHIP_SSS_CTRL, SGTL5000_DAP_SEL_SHIFT,
+			    dap_mux_text);
+
+static const struct snd_kcontrol_new dap_mux =
+SOC_DAPM_ENUM("DAP Mux", dap_enum);
+
+/* input sources for DAP mix */
+static const char *dapmix_mux_text[] = {
+	"ADC", "I2S"
+};
+
+static SOC_ENUM_SINGLE_DECL(dapmix_enum,
+			    SGTL5000_CHIP_SSS_CTRL, SGTL5000_DAP_MIX_SEL_SHIFT,
+			    dapmix_mux_text);
+
+static const struct snd_kcontrol_new dapmix_mux =
+SOC_DAPM_ENUM("DAP MIX Mux", dapmix_enum);
+
 
 static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("LINE_IN"),
@@ -243,7 +280,12 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0),
 
 	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
-	SND_SOC_DAPM_MUX("Headphone Mux", SND_SOC_NOPM, 0, 0, &dac_mux),
+	SND_SOC_DAPM_MUX("Headphone Mux", SND_SOC_NOPM, 0, 0, &hp_mux),
+	SND_SOC_DAPM_MUX("Digital Input Mux", SND_SOC_NOPM, 0, 0, &dac_mux),
+	SND_SOC_DAPM_MUX("DAP Mux", SGTL5000_DAP_CTRL, 0, 0, &dap_mux),
+	SND_SOC_DAPM_MUX("DAP MIX Mux", SGTL5000_DAP_CTRL, 4, 0, &dapmix_mux),
+	SND_SOC_DAPM_MIXER("DAP", SGTL5000_CHIP_DIG_POWER, 4, 0, NULL, 0),
+
 
 	/* aif for i2s input */
 	SND_SOC_DAPM_AIF_IN("AIFIN", "Playback",
@@ -270,7 +312,19 @@ static const struct snd_soc_dapm_route sgtl5000_dapm_routes[] = {
 	{"ADC", NULL, "Capture Mux"},		/* adc_mux --> adc */
 	{"AIFOUT", NULL, "ADC"},		/* adc --> i2s_out */
 
-	{"DAC", NULL, "AIFIN"},			/* i2s-->dac,skip audio mux */
+	{"DAP Mux", "ADC", "ADC"},		/* adc --> DAP mux */
+	{"DAP Mux", NULL, "AIFIN"},		/* i2s --> DAP mux */
+	{"DAP", NULL, "DAP Mux"},		/* DAP mux --> dap */
+
+	{"DAP MIX Mux", "ADC", "ADC"},		/* adc --> DAP MIX mux */
+	{"DAP MIX Mux", NULL, "AIFIN"},		/* i2s --> DAP MIX mux */
+	{"DAP", NULL, "DAP MIX Mux"},		/* DAP MIX mux --> dap */
+
+	{"Digital Input Mux", "ADC", "ADC"},	/* adc --> audio mux */
+	{"Digital Input Mux", NULL, "AIFIN"},	/* i2s --> audio mux */
+	{"Digital Input Mux", NULL, "DAP"},	/* dap --> audio mux */
+	{"DAC", NULL, "Digital Input Mux"},	/* audio mux --> dac */
+
 	{"Headphone Mux", "DAC", "DAC"},	/* dac --> hp_mux */
 	{"LO", NULL, "DAC"},			/* dac --> line_out */
 
@@ -463,6 +517,9 @@ static const DECLARE_TLV_DB_RANGE(mic_gain_tlv,
 	1, 3, TLV_DB_SCALE_ITEM(2000, 1000, 0)
 );
 
+/* tlv for DAP channels, 0% - 100% - 200% */
+static const DECLARE_TLV_DB_SCALE(dap_volume, 0, 1, 0);
+
 /* tlv for hp volume, -51.5db to 12.0db, step .5db */
 static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
 
@@ -514,6 +571,11 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 			lineout_volume),
 	SOC_SINGLE("Lineout Playback Switch", SGTL5000_CHIP_ANA_CTRL, 8, 1, 1),
 
+	SOC_SINGLE_TLV("DAP Main channel", SGTL5000_DAP_MAIN_CHAN,
+	0, 0xffff, 0, dap_volume),
+
+	SOC_SINGLE_TLV("DAP Mix channel", SGTL5000_DAP_MIX_CHAN,
+	0, 0xffff, 0, dap_volume),
 	/* Automatic Volume Control (DAP AVC) */
 	SOC_SINGLE("AVC Switch", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),
 	SOC_SINGLE("AVC Hard Limiter Switch", SGTL5000_DAP_AVC_CTRL, 5, 1, 0),
@@ -1217,12 +1279,6 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 	/* disable short cut detector */
 	snd_soc_component_write(component, SGTL5000_CHIP_SHORT_CTRL, 0);
 
-	/*
-	 * set i2s as default input of sound switch
-	 * TODO: add sound switch to control and dapm widge.
-	 */
-	snd_soc_component_write(component, SGTL5000_CHIP_SSS_CTRL,
-			SGTL5000_DAC_SEL_I2S_IN << SGTL5000_DAC_SEL_SHIFT);
 	snd_soc_component_write(component, SGTL5000_CHIP_DIG_POWER,
 			SGTL5000_ADC_EN | SGTL5000_DAC_EN);
 
-- 
2.16.1
