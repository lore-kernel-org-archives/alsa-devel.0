From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v3 6/6] ASoC: sgtl5000: Improve VAG power and mute control
Date: Fri, 12 Jul 2019 14:56:08 +0000
Message-ID: <20190712145550.27500-7-oleksandr.suvorov@toradex.com>
References: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712145550.27500-1-oleksandr.suvorov@toradex.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Change VAG power on/off control according to the following algorithm:
- turn VAG power ON on the 1st incoming event.
- keep it ON if there is any active VAG consumer (ADC/DAC/HP/Line-In).
- turn VAG power OFF when there is the latest consumer's pre-down event
  come.
- always delay after VAG power OFF to avoid pop.
- delay after VAG power ON if the initiative consumer is Line-In, this
  prevents pop during line-in muxing.

Also, according to the data sheet [1], to avoid any pops/clicks,
the outputs should be muted during input/output
routing changes.

[1] https://www.nxp.com/docs/en/data-sheet/SGTL5000.pdf

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v3:
- Add the reference to NXP SGTL5000 data sheet to commit message

Changes in v2:
- Fix patch formatting

 sound/soc/codecs/sgtl5000.c | 227 +++++++++++++++++++++++++++++++-----
 1 file changed, 195 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index c256162750d16..9318d9fea72c7 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -31,6 +31,13 @@
 #define SGTL5000_DAP_REG_OFFSET	0x0100
 #define SGTL5000_MAX_REG_OFFSET	0x013A
=20
+/* Delay for the VAG ramp up */
+#define SGTL5000_VAG_POWERUP_DELAY 500 /* ms */
+/* Delay for the VAG ramp down */
+#define SGTL5000_VAG_POWERDOWN_DELAY 500 /* ms */
+
+#define SGTL5000_OUTPUTS_MUTE (SGTL5000_HP_MUTE | SGTL5000_LINE_OUT_MUTE)
+
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] =3D {
 	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
@@ -123,6 +130,18 @@ enum  {
 	I2S_SCLK_STRENGTH_HIGH,
 };
=20
+enum {
+	HP_POWER_EVENT,
+	DAC_POWER_EVENT,
+	ADC_POWER_EVENT
+};
+
+struct sgtl5000_mute_state {
+	u16 hp_event;
+	u16 dac_event;
+	u16 adc_event;
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -137,8 +156,109 @@ struct sgtl5000_priv {
 	u8 micbias_voltage;
 	u8 lrclk_strength;
 	u8 sclk_strength;
+	struct sgtl5000_mute_state mute_state;
 };
=20
+static inline int hp_sel_input(struct snd_soc_component *component)
+{
+	return (snd_soc_component_read32(component, SGTL5000_CHIP_ANA_CTRL) &
+		SGTL5000_HP_SEL_MASK) >> SGTL5000_HP_SEL_SHIFT;
+}
+
+static inline u16 mute_output(struct snd_soc_component *component,
+			      u16 mute_mask)
+{
+	u16 mute_reg =3D snd_soc_component_read32(component,
+					      SGTL5000_CHIP_ANA_CTRL);
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+			    mute_mask, mute_mask);
+	return mute_reg;
+}
+
+static inline void restore_output(struct snd_soc_component *component,
+				  u16 mute_mask, u16 mute_reg)
+{
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_CTRL,
+		mute_mask, mute_reg);
+}
+
+static void vag_power_on(struct snd_soc_component *component, u32 source)
+{
+	if (snd_soc_component_read32(component, SGTL5000_CHIP_ANA_POWER) &
+	    SGTL5000_VAG_POWERUP)
+		return;
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
+			    SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+
+	/* When VAG powering on to get local loop from Line-In, the sleep
+	 * is required to avoid loud pop.
+	 */
+	if (hp_sel_input(component) =3D=3D SGTL5000_HP_SEL_LINE_IN &&
+	    source =3D=3D HP_POWER_EVENT)
+		msleep(SGTL5000_VAG_POWERUP_DELAY);
+}
+
+static int vag_power_consumers(struct snd_soc_component *component,
+			       u16 ana_pwr_reg, u32 source)
+{
+	int consumers =3D 0;
+
+	/* count dac/adc consumers unconditional */
+	if (ana_pwr_reg & SGTL5000_DAC_POWERUP)
+		consumers++;
+	if (ana_pwr_reg & SGTL5000_ADC_POWERUP)
+		consumers++;
+
+	/*
+	 * If the event comes from HP and Line-In is selected,
+	 * current action is 'DAC to be powered down'.
+	 * As HP_POWERUP is not set when HP muxed to line-in,
+	 * we need to keep VAG power ON.
+	 */
+	if (source =3D=3D HP_POWER_EVENT) {
+		if (hp_sel_input(component) =3D=3D SGTL5000_HP_SEL_LINE_IN)
+			consumers++;
+	} else {
+		if (ana_pwr_reg & SGTL5000_HP_POWERUP)
+			consumers++;
+	}
+
+	return consumers;
+}
+
+static void vag_power_off(struct snd_soc_component *component, u32 source)
+{
+	u16 ana_pwr =3D snd_soc_component_read32(component,
+					     SGTL5000_CHIP_ANA_POWER);
+
+	if (!(ana_pwr & SGTL5000_VAG_POWERUP))
+		return;
+
+	/*
+	 * This function calls when any of VAG power consumers is disappearing.
+	 * Thus, if there is more than one consumer at the moment, as minimum
+	 * one consumer will definitely stay after the end of the current
+	 * event.
+	 * Don't clear VAG_POWERUP if 2 or more consumers of VAG present:
+	 * - LINE_IN (for HP events) / HP (for DAC/ADC events)
+	 * - DAC
+	 * - ADC
+	 * (the current consumer is disappearing right now)
+	 */
+	if (vag_power_consumers(component, ana_pwr, source) >=3D 2)
+		return;
+
+	snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
+		SGTL5000_VAG_POWERUP, 0);
+	/* In power down case, we need wait 400-1000 ms
+	 * when VAG fully ramped down.
+	 * As longer we wait, as smaller pop we've got.
+	 */
+	msleep(SGTL5000_VAG_POWERDOWN_DELAY);
+}
+
 /*
  * mic_bias power on/off share the same register bits with
  * output impedance of mic bias, when power on mic bias, we
@@ -170,40 +290,79 @@ static int mic_bias_event(struct snd_soc_dapm_widget =
*w,
 	return 0;
 }
=20
-/*
- * As manual described, ADC/DAC only works when VAG powerup,
- * So enabled VAG before ADC/DAC up.
- * In power down case, we need wait 400ms when vag fully ramped down.
- */
-static int power_vag_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
+static void vag_and_mute_control(struct snd_soc_component *component,
+				 int event, int event_source,
+				 u16 mute_mask, u16 *mute_reg)
 {
-	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->dapm=
);
-	const u32 mask =3D SGTL5000_DAC_POWERUP | SGTL5000_ADC_POWERUP;
-
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
-		msleep(400);
+	case SND_SOC_DAPM_PRE_PMU:
+		*mute_reg =3D mute_output(component, mute_mask);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		vag_power_on(component, event_source);
+		restore_output(component, mute_mask, *mute_reg);
 		break;
-
 	case SND_SOC_DAPM_PRE_PMD:
-		/*
-		 * Don't clear VAG_POWERUP, when both DAC and ADC are
-		 * operational to prevent inadvertently starving the
-		 * other one of them.
-		 */
-		if ((snd_soc_component_read32(component, SGTL5000_CHIP_ANA_POWER) &
-				mask) !=3D mask) {
-			snd_soc_component_update_bits(component, SGTL5000_CHIP_ANA_POWER,
-				SGTL5000_VAG_POWERUP, 0);
-			msleep(400);
-		}
+		*mute_reg =3D mute_output(component, mute_mask);
+		vag_power_off(component, event_source);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		restore_output(component, mute_mask, *mute_reg);
 		break;
 	default:
 		break;
 	}
+}
+
+/*
+ * Mute Headphone when power it up/down.
+ * Control VAG power on HP power path.
+ */
+static int headphone_pga_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, HP_POWER_EVENT,
+			     SGTL5000_HP_MUTE,
+			     &sgtl5000->mute_state.hp_event);
+
+	return 0;
+}
+
+/* As manual describes, ADC/DAC powering up/down requires
+ * to mute outputs to avoid pops.
+ * Control VAG power on ADC/DAC power path.
+ */
+static int adc_updown_depop(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, ADC_POWER_EVENT,
+			     SGTL5000_OUTPUTS_MUTE,
+			     &sgtl5000->mute_state.adc_event);
+
+	return 0;
+}
+
+static int dac_updown_depop(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =3D
+		snd_soc_dapm_to_component(w->dapm);
+	struct sgtl5000_priv *sgtl5000 =3D
+		snd_soc_component_get_drvdata(component);
+
+	vag_and_mute_control(component, event, DAC_POWER_EVENT,
+			     SGTL5000_OUTPUTS_MUTE,
+			     &sgtl5000->mute_state.dac_event);
=20
 	return 0;
 }
@@ -280,7 +439,10 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm_=
widgets[] =3D {
 			    mic_bias_event,
 			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
=20
-	SND_SOC_DAPM_PGA("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA_E("HP", SGTL5000_CHIP_ANA_POWER, 4, 0, NULL, 0,
+			   headphone_pga_event,
+			   SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
 	SND_SOC_DAPM_PGA("LO", SGTL5000_CHIP_ANA_POWER, 0, 0, NULL, 0),
=20
 	SND_SOC_DAPM_MUX("Capture Mux", SND_SOC_NOPM, 0, 0, &adc_mux),
@@ -301,11 +463,12 @@ static const struct snd_soc_dapm_widget sgtl5000_dapm=
_widgets[] =3D {
 				0, SGTL5000_CHIP_DIG_POWER,
 				1, 0),
=20
-	SND_SOC_DAPM_ADC("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0),
-	SND_SOC_DAPM_DAC("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0),
-
-	SND_SOC_DAPM_PRE("VAG_POWER_PRE", power_vag_event),
-	SND_SOC_DAPM_POST("VAG_POWER_POST", power_vag_event),
+	SND_SOC_DAPM_ADC_E("ADC", "Capture", SGTL5000_CHIP_ANA_POWER, 1, 0,
+			   adc_updown_depop, SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DAC", "Playback", SGTL5000_CHIP_ANA_POWER, 3, 0,
+			   dac_updown_depop, SND_SOC_DAPM_PRE_POST_PMU |
+			   SND_SOC_DAPM_PRE_POST_PMD),
 };
=20
 /* routes for sgtl5000 */
--=20
2.20.1
