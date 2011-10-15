From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v4 4/7] ASoC: da7210: Add support for ALC and
 Noise suppression
Date: Sat, 15 Oct 2011 14:55:03 +0530
Message-ID: <1318670703.613.47.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 98264244EB
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 11:13:39 +0200 (CEST)
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

This patch adds controls to set following ALC parameters,
 - Max gain, Min gain, Noise gain, Attack rate, Release rate and delay

It also adds a switch to enable/disable noise suppression.

As per DA7210 data sheet, ALC and noise suppression can be enabled
only if certain conditions are met. This condition checks are handled
by simply using "_EXT" version of controls to capture change events.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v1:
- Reading from register instead of cache
- Made debug message more specific about error
- Changed "Gain" to "Volume" in names of ALC controls
---
 sound/soc/codecs/da7210.c |  109 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index cac4f26..0871ebc 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -26,11 +26,15 @@
 #include <sound/tlv.h>
 
 /* DA7210 register space */
+#define DA7210_CONTROL			0x01
 #define DA7210_STATUS			0x02
 #define DA7210_STARTUP1			0x03
 #define DA7210_MIC_L			0x07
 #define DA7210_MIC_R			0x08
+#define DA7210_AUX1_L			0x09
+#define DA7210_AUX1_R			0x0A
 #define DA7210_AUX2			0x0B
+#define DA7210_IN_GAIN			0x0C
 #define DA7210_INMIX_L			0x0D
 #define DA7210_INMIX_R			0x0E
 #define DA7210_ADC_HPF			0x0F
@@ -59,6 +63,12 @@
 #define DA7210_PLL_DIV2			0x2A
 #define DA7210_PLL_DIV3			0x2B
 #define DA7210_PLL			0x2C
+#define DA7210_ALC_MAX			0x83
+#define DA7210_ALC_MIN			0x84
+#define DA7210_ALC_NOIS			0x85
+#define DA7210_ALC_ATT			0x86
+#define DA7210_ALC_REL			0x87
+#define DA7210_ALC_DEL			0x88
 #define DA7210_A_HID_UNLOCK		0x8A
 #define DA7210_A_TEST_UNLOCK		0x8B
 #define DA7210_A_PLL1			0x90
@@ -81,6 +91,7 @@
 #define DA7210_IN_R_EN			(1 << 7)
 
 /* ADC bit fields */
+#define DA7210_ADC_ALC_EN		(1 << 0)
 #define DA7210_ADC_L_EN			(1 << 3)
 #define DA7210_ADC_R_EN			(1 << 7)
 
@@ -150,6 +161,29 @@
 /* SOFTMUTE bit fields */
 #define DA7210_RAMP_EN			(1 << 6)
 
+/* CONTROL bit fields */
+#define DA7210_NOISE_SUP_EN		(1 << 3)
+
+/* IN_GAIN bit fields */
+#define DA7210_INPGA_L_VOL		(0x0F << 0)
+#define DA7210_INPGA_R_VOL		(0xF0 << 0)
+
+/* ZERO_CROSS bit fields */
+#define DA7210_AUX1_L_ZC		(1 << 0)
+#define DA7210_AUX1_R_ZC		(1 << 1)
+#define DA7210_HP_L_ZC			(1 << 6)
+#define DA7210_HP_R_ZC			(1 << 7)
+
+/* AUX1_L bit fields */
+#define DA7210_AUX1_L_VOL		(0x3F << 0)
+
+/* AUX1_R bit fields */
+#define DA7210_AUX1_R_VOL		(0x3F << 0)
+
+/* Minimum INPGA and AUX1 volume to enable noise suppression */
+#define DA7210_INPGA_MIN_VOL_NS		0x0A  /* 10.5dB */
+#define DA7210_AUX1_MIN_VOL_NS		0x35  /* 6dB */
+
 #define DA7210_VERSION "0.0.1"
 
 /*
@@ -202,6 +236,68 @@ static const char *da7210_hp_mode_txt[] = {
 static const struct soc_enum da7210_hp_mode_sel =
 	SOC_ENUM_SINGLE(DA7210_HP_CFG, 0, 2, da7210_hp_mode_txt);
 
+/* ALC can be enabled only if noise suppression is disabled */
+static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.integer.value[0]) {
+		/* Check if noise suppression is enabled */
+		if (snd_soc_read(codec, DA7210_CONTROL) & DA7210_NOISE_SUP_EN) {
+			dev_dbg(codec->dev,
+				"Disable noise suppression to enable ALC\n");
+			return -EPERM;
+		}
+	}
+	/* If all conditions are met or we are actually disabling ALC */
+	return snd_soc_put_volsw(kcontrol, ucontrol);
+}
+
+/* Noise suppression can be enabled only if following conditions are met
+ *  ALC disabled
+ *  ZC enabled for HP and AUX1 PGA
+ *  INPGA_L_VOL and INPGA_R_VOL >= 10.5 dB
+ *  AUX1_L_VOL and AUX1_R_VOL >= 6 dB
+ */
+static int da7210_put_noise_sup_sw(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u8 val;
+
+	if (ucontrol->value.integer.value[0]) {
+		/* Check if ALC is enabled */
+		if (snd_soc_read(codec, DA7210_ADC) & DA7210_ADC_ALC_EN)
+			goto err;
+
+		/* Check ZC for HP and AUX1 PGA */
+		if ((snd_soc_read(codec, DA7210_ZERO_CROSS) &
+			(DA7210_AUX1_L_ZC | DA7210_AUX1_R_ZC | DA7210_HP_L_ZC |
+			DA7210_HP_R_ZC)) != 0xc3)
+			goto err;
+
+		/* Check INPGA_L_VOL and INPGA_R_VOL */
+		val = snd_soc_read(codec, DA7210_IN_GAIN);
+		if (((val & DA7210_INPGA_L_VOL) < DA7210_INPGA_MIN_VOL_NS) ||
+			(((val & DA7210_INPGA_R_VOL) >> 4) <
+			DA7210_INPGA_MIN_VOL_NS))
+			goto err;
+
+		/* Check AUX1_L_VOL and AUX1_R_VOL */
+		if (((snd_soc_read(codec, DA7210_AUX1_L) & DA7210_AUX1_L_VOL) <
+		    DA7210_AUX1_MIN_VOL_NS) ||
+		    ((snd_soc_read(codec, DA7210_AUX1_R) & DA7210_AUX1_R_VOL) <
+		    DA7210_AUX1_MIN_VOL_NS))
+			goto err;
+	}
+	/* If all conditions are met or we are actually disabling Noise sup */
+	return snd_soc_put_volsw(kcontrol, ucontrol);
+
+err:
+	return -EPERM;
+}
+
 static const struct snd_kcontrol_new da7210_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HeadPhone Playback Volume",
@@ -261,6 +357,19 @@ static const struct snd_kcontrol_new da7210_snd_controls[] = {
 	SOC_DOUBLE("Headphone ZC Switch", DA7210_ZERO_CROSS, 6, 7, 1, 0),
 
 	SOC_ENUM("Headphone Class", da7210_hp_mode_sel),
+
+	/* ALC controls */
+	SOC_SINGLE_EXT("ALC Enable Switch", DA7210_ADC, 0, 1, 0,
+		       snd_soc_get_volsw, da7210_put_alc_sw),
+	SOC_SINGLE("ALC Capture Max Volume", DA7210_ALC_MAX, 0, 0x3F, 0),
+	SOC_SINGLE("ALC Capture Min Volume", DA7210_ALC_MIN, 0, 0x3F, 0),
+	SOC_SINGLE("ALC Capture Noise Volume", DA7210_ALC_NOIS, 0, 0x3F, 0),
+	SOC_SINGLE("ALC Capture Attack Rate", DA7210_ALC_ATT, 0, 0xFF, 0),
+	SOC_SINGLE("ALC Capture Release Rate", DA7210_ALC_REL, 0, 0xFF, 0),
+	SOC_SINGLE("ALC Capture Release Delay", DA7210_ALC_DEL, 0, 0xFF, 0),
+
+	SOC_SINGLE_EXT("Noise Suppression Enable Switch", DA7210_CONTROL, 3, 1,
+		       0, snd_soc_get_volsw, da7210_put_noise_sup_sw),
 };
 
 /* Codec private data */
-- 
1.7.1
