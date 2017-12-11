From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/4] ASoC: codecs: tas5720: add TAS5722 specific volume control
Date: Mon, 11 Dec 2017 13:01:56 -0600
Message-ID: <20171211190157.12371-3-afd@ti.com>
References: <20171211190157.12371-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171211190157.12371-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Dannenberg <dannenberg@ti.com>

The TAS5722 supports modifying volume in 0.25dB steps (as opposed to 0.5dB
steps on the TAS5720). Introduce a custom mixer control that allows taking
advantage of this finer output volume granularity.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tas5720.c | 88 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index f3006f301fe8..042068964afb 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -491,11 +491,59 @@ static const DECLARE_TLV_DB_RANGE(dac_analog_tlv,
  * setting the gain below -100 dB (register value <0x7) is effectively a MUTE
  * as per device datasheet.
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -10350, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas5720_dac_tlv, -10350, 50, 0);
+
 
 static const struct snd_kcontrol_new tas5720_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
-		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, dac_tlv),
+		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, tas5720_dac_tlv),
+	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
+		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
+};
+
+/*
+ * DAC digital volumes. From -103.5 to 24 dB in 0.25 dB steps. Note that
+ * setting the gain below -100 dB (register value <0x8)  is effectively a MUTE
+ * as per device datasheet.
+ *
+ * Note that for the TAS5722 the digital volume controls are actually split
+ * over two registers, so we need custom getters/setters for access.
+ */
+static DECLARE_TLV_DB_SCALE(tas5722_dac_tlv, -10350, 25, 0);
+
+static int tas5722_volume_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	unsigned int val;
+
+	val = snd_soc_read(codec, TAS5720_VOLUME_CTRL_REG);
+	ucontrol->value.integer.value[0] = val << 1;
+
+	val = snd_soc_read(codec, TAS5722_DIGITAL_CTRL2_REG);
+	ucontrol->value.integer.value[0] |= val & TAS5722_VOL_CONTROL_LSB;
+
+	return 0;
+}
+
+static int tas5722_volume_set(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	unsigned int sel = ucontrol->value.integer.value[0];
+
+	snd_soc_write(codec, TAS5720_VOLUME_CTRL_REG, sel >> 1);
+	snd_soc_update_bits(codec, TAS5722_DIGITAL_CTRL2_REG,
+			    TAS5722_VOL_CONTROL_LSB, sel);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new tas5722_snd_controls[] = {
+	SOC_SINGLE_EXT_TLV("Speaker Driver Playback Volume",
+			   0, 0, 511, 0,
+			   tas5722_volume_get, tas5722_volume_set,
+			   tas5722_dac_tlv),
 	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
 		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
 };
@@ -528,6 +576,22 @@ static const struct snd_soc_codec_driver soc_codec_dev_tas5720 = {
 	},
 };
 
+static struct snd_soc_codec_driver soc_codec_dev_tas5722 = {
+	.probe = tas5720_codec_probe,
+	.remove = tas5720_codec_remove,
+	.suspend = tas5720_suspend,
+	.resume = tas5720_resume,
+
+	.component_driver = {
+		.controls = tas5722_snd_controls,
+		.num_controls = ARRAY_SIZE(tas5722_snd_controls),
+		.dapm_widgets = tas5720_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(tas5720_dapm_widgets),
+		.dapm_routes = tas5720_audio_map,
+		.num_dapm_routes = ARRAY_SIZE(tas5720_audio_map),
+	}
+};
+
 /* PCM rates supported by the TAS5720 driver */
 #define TAS5720_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
 			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
@@ -614,9 +678,23 @@ static int tas5720_probe(struct i2c_client *client,
 
 	dev_set_drvdata(dev, data);
 
-	ret = snd_soc_register_codec(&client->dev,
-				     &soc_codec_dev_tas5720,
-				     tas5720_dai, ARRAY_SIZE(tas5720_dai));
+	switch (id->driver_data) {
+	case TAS5720:
+		ret = snd_soc_register_codec(&client->dev,
+					     &soc_codec_dev_tas5720,
+					     tas5720_dai,
+					     ARRAY_SIZE(tas5720_dai));
+		break;
+	case TAS5722:
+		ret = snd_soc_register_codec(&client->dev,
+					     &soc_codec_dev_tas5722,
+					     tas5720_dai,
+					     ARRAY_SIZE(tas5720_dai));
+		break;
+	default:
+		dev_err(dev, "unexpected private driver data\n");
+		return -EINVAL;
+	}
 	if (ret < 0) {
 		dev_err(dev, "failed to register codec: %d\n", ret);
 		return ret;
-- 
2.15.0
