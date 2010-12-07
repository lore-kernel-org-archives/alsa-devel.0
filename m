From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 03/15] ASoC: twl6040: Add headset and handset
	mux controls
Date: Mon, 6 Dec 2010 18:17:47 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id F2DD110398E
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:17:50 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>

This patch adds support for the twl6040 headset and handset
MUX controls.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |  101 ++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index e908146..8464bcc 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -82,19 +82,19 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] = {
 	0x1B, /* TWL6040_LINEGAIN	0x0F	*/
 	0x00, /* TWL6040_HSLCTL		0x10	*/
 	0x00, /* TWL6040_HSRCTL		0x11	*/
-	0x00, /* TWL6040_HSGAIN		0x12	*/
-	0x00, /* TWL6040_EARCTL		0x13	*/
+	0xFF, /* TWL6040_HSGAIN		0x12	*/
+	0x1E, /* TWL6040_EARCTL		0x13	*/
 	0x00, /* TWL6040_HFLCTL		0x14	*/
-	0x00, /* TWL6040_HFLGAIN	0x15	*/
+	0x1D, /* TWL6040_HFLGAIN	0x15	*/
 	0x00, /* TWL6040_HFRCTL		0x16	*/
-	0x00, /* TWL6040_HFRGAIN	0x17	*/
+	0x1D, /* TWL6040_HFRGAIN	0x17	*/
 	0x00, /* TWL6040_VIBCTLL	0x18	*/
 	0x00, /* TWL6040_VIBDATL	0x19	*/
 	0x00, /* TWL6040_VIBCTLR	0x1A	*/
 	0x00, /* TWL6040_VIBDATR	0x1B	*/
 	0x00, /* TWL6040_HKCTL1		0x1C	*/
 	0x00, /* TWL6040_HKCTL2		0x1D	*/
-	0x00, /* TWL6040_GPOCTL		0x1E	*/
+	0x02, /* TWL6040_GPOCTL		0x1E	*/
 	0x00, /* TWL6040_ALB		0x1F	*/
 	0x00, /* TWL6040_DLB		0x20	*/
 	0x00, /* not used		0x21	*/
@@ -432,6 +432,13 @@ static DECLARE_TLV_DB_SCALE(mic_preamp_tlv, -600, 600, 0);
 static DECLARE_TLV_DB_SCALE(mic_amp_tlv, 600, 600, 0);
 
 /*
+ * AFMGAIN volume control:
+ * from 18 to 24 dB in 6 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(afm_amp_tlv, 600, 600, 0);
+
+
+/*
  * HSGAIN volume control:
  * from -30 to 0 dB in 2 dB steps
  */
@@ -457,9 +464,21 @@ static const char *twl6040_amicl_texts[] =
 static const char *twl6040_amicr_texts[] =
 	{"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
 
+static const char *twl6040_hs_texts[] = {
+	"Off", "HS DAC", "Line-In amp"
+};
+
+static const char *twl6040_hf_texts[] = {
+	"Off", "HF DAC", "Line-In amp"
+};
+
 static const struct soc_enum twl6040_enum[] = {
 	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3, 3, twl6040_amicl_texts),
 	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3, 3, twl6040_amicr_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_HSLCTL, 5, 3, twl6040_hs_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_HSRCTL, 5, 3, twl6040_hs_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_HFLCTL, 2, 3, twl6040_hf_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_HFRCTL, 2, 3, twl6040_hf_texts),
 };
 
 static const struct snd_kcontrol_new amicl_control =
@@ -469,18 +488,18 @@ static const struct snd_kcontrol_new amicr_control =
 	SOC_DAPM_ENUM("Route", twl6040_enum[1]);
 
 /* Headset DAC playback switches */
-static const struct snd_kcontrol_new hsdacl_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HSLCTL, 5, 1, 0);
+static const struct snd_kcontrol_new hsl_mux_controls =
+	SOC_DAPM_ENUM("Route", twl6040_enum[2]);
 
-static const struct snd_kcontrol_new hsdacr_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HSRCTL, 5, 1, 0);
+static const struct snd_kcontrol_new hsr_mux_controls =
+	SOC_DAPM_ENUM("Route", twl6040_enum[3]);
 
 /* Handsfree DAC playback switches */
-static const struct snd_kcontrol_new hfdacl_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFLCTL, 2, 1, 0);
+static const struct snd_kcontrol_new hfl_mux_controls =
+	SOC_DAPM_ENUM("Route", twl6040_enum[4]);
 
-static const struct snd_kcontrol_new hfdacr_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFRCTL, 2, 1, 0);
+static const struct snd_kcontrol_new hfr_mux_controls =
+	SOC_DAPM_ENUM("Route", twl6040_enum[5]);
 
 static const struct snd_kcontrol_new ep_driver_switch_controls =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_EARCTL, 0, 1, 0);
@@ -492,6 +511,10 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 	SOC_DOUBLE_TLV("Capture Volume",
 		TWL6040_REG_MICGAIN, 0, 3, 4, 0, mic_amp_tlv),
 
+	/* AFM gains */
+	SOC_DOUBLE_TLV("Aux FM Volume",
+		TWL6040_REG_LINEGAIN, 0, 5, 0xF, 0, afm_amp_tlv),
+
 	/* Playback gains */
 	SOC_DOUBLE_TLV("Headset Playback Volume",
 		TWL6040_REG_HSGAIN, 0, 4, 0xF, 1, hs_tlv),
@@ -528,6 +551,12 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("MicAmpR",
 			TWL6040_REG_MICRCTL, 0, 0, NULL, 0),
 
+	/* Auxiliary FM PGAs */
+	SND_SOC_DAPM_PGA("AFMAmpL",
+			TWL6040_REG_MICLCTL, 1, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("AFMAmpR",
+			TWL6040_REG_MICRCTL, 1, 0, NULL, 0),
+
 	/* ADCs */
 	SND_SOC_DAPM_ADC("ADC Left", "Left Front Capture",
 			TWL6040_REG_MICLCTL, 2, 0),
@@ -562,15 +591,15 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
-	/* Analog playback switches */
-	SND_SOC_DAPM_SWITCH("HSDAC Left Playback",
-			SND_SOC_NOPM, 0, 0, &hsdacl_switch_controls),
-	SND_SOC_DAPM_SWITCH("HSDAC Right Playback",
-			SND_SOC_NOPM, 0, 0, &hsdacr_switch_controls),
-	SND_SOC_DAPM_SWITCH("HFDAC Left Playback",
-			SND_SOC_NOPM, 0, 0, &hfdacl_switch_controls),
-	SND_SOC_DAPM_SWITCH("HFDAC Right Playback",
-			SND_SOC_NOPM, 0, 0, &hfdacr_switch_controls),
+	SND_SOC_DAPM_MUX("HF Left Playback",
+			SND_SOC_NOPM, 0, 0, &hfl_mux_controls),
+	SND_SOC_DAPM_MUX("HF Right Playback",
+			SND_SOC_NOPM, 0, 0, &hfr_mux_controls),
+	/* Analog playback Muxes */
+	SND_SOC_DAPM_MUX("HS Left Playback",
+			SND_SOC_NOPM, 0, 0, &hsl_mux_controls),
+	SND_SOC_DAPM_MUX("HS Right Playback",
+			SND_SOC_NOPM, 0, 0, &hsr_mux_controls),
 
 	/* Analog playback drivers */
 	SND_SOC_DAPM_PGA_E("Handsfree Left Driver",
@@ -614,12 +643,18 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Left", NULL, "MicAmpL"},
 	{"ADC Right", NULL, "MicAmpR"},
 
-	/* Headset playback path */
-	{"HSDAC Left Playback", "Switch", "HSDAC Left"},
-	{"HSDAC Right Playback", "Switch", "HSDAC Right"},
+	/* AFM path */
+	{"AFMAmpL", "NULL", "AFML"},
+	{"AFMAmpR", "NULL", "AFMR"},
 
-	{"Headset Left Driver", NULL, "HSDAC Left Playback"},
-	{"Headset Right Driver", NULL, "HSDAC Right Playback"},
+	{"HS Left Playback", "HS DAC", "HSDAC Left"},
+	{"HS Left Playback", "Line-In amp", "AFMAmpL"},
+
+	{"HS Right Playback", "HS DAC", "HSDAC Right"},
+	{"HS Right Playback", "Line-In amp", "AFMAmpR"},
+
+	{"Headset Left Driver", "NULL", "HS Left Playback"},
+	{"Headset Right Driver", "NULL", "HS Right Playback"},
 
 	{"HSOL", NULL, "Headset Left Driver"},
 	{"HSOR", NULL, "Headset Right Driver"},
@@ -628,12 +663,14 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earphone Driver", "Switch", "HSDAC Left"},
 	{"EP", NULL, "Earphone Driver"},
 
-	/* Handsfree playback path */
-	{"HFDAC Left Playback", "Switch", "HFDAC Left"},
-	{"HFDAC Right Playback", "Switch", "HFDAC Right"},
+	{"HF Left Playback", "HF DAC", "HFDAC Left"},
+	{"HF Left Playback", "Line-In amp", "AFMAmpL"},
+
+	{"HF Right Playback", "HF DAC", "HFDAC Right"},
+	{"HF Right Playback", "Line-In amp", "AFMAmpR"},
 
-	{"HFDAC Left PGA", NULL, "HFDAC Left Playback"},
-	{"HFDAC Right PGA", NULL, "HFDAC Right Playback"},
+	{"HFDAC Left PGA", NULL, "HF Left Playback"},
+	{"HFDAC Right PGA", NULL, "HF Right Playback"},
 
 	{"Handsfree Left Driver", "Switch", "HFDAC Left PGA"},
 	{"Handsfree Right Driver", "Switch", "HFDAC Right PGA"},
-- 
1.7.0.4
