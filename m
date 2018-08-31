From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: tas5720: add TAS5722 specific
	volume control" to the asoc tree
Date: Fri, 31 Aug 2018 16:40:53 +0100 (BST)
Message-ID: <20180831154053.2E8EF11226FE@debutante.sirena.org.uk>
References: <20180831144714.16499-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 94A9C2679FD
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2018 17:40:53 +0200 (CEST)
In-Reply-To: <20180831144714.16499-1-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrew F ., Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: tas5720: add TAS5722 specific volume control

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

>From ec94c177bf3700ce44c53c375a3fb4c347f2b08f Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Fri, 31 Aug 2018 09:47:13 -0500
Subject: [PATCH] ASoC: codecs: tas5720: add TAS5722 specific volume control

The TAS5722 supports modifying volume in 0.25dB steps (as opposed to
0.5dB steps on the TAS5720). Introduce a custom mixer control that
allows taking advantage of this finer output volume granularity.

Also add custom getters/setters for access as the TAS5722 digital volume
controls are split over two registers.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas5720.c | 88 ++++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index ae3d032ac35a..3c469112477a 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -485,15 +485,56 @@ static const DECLARE_TLV_DB_RANGE(dac_analog_tlv,
 );
 
 /*
- * DAC digital volumes. From -103.5 to 24 dB in 0.5 dB steps. Note that
- * setting the gain below -100 dB (register value <0x7) is effectively a MUTE
- * as per device datasheet.
+ * DAC digital volumes. From -103.5 to 24 dB in 0.5 dB or 0.25 dB steps
+ * depending on the device. Note that setting the gain below -100 dB
+ * (register value <0x7) is effectively a MUTE as per device datasheet.
+ *
+ * Note that for the TAS5722 the digital volume controls are actually split
+ * over two registers, so we need custom getters/setters for access.
  */
-static DECLARE_TLV_DB_SCALE(dac_tlv, -10350, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas5720_dac_tlv, -10350, 50, 0);
+static DECLARE_TLV_DB_SCALE(tas5722_dac_tlv, -10350, 25, 0);
+
+static int tas5722_volume_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int val;
+
+	snd_soc_component_read(component, TAS5720_VOLUME_CTRL_REG, &val);
+	ucontrol->value.integer.value[0] = val << 1;
+
+	snd_soc_component_read(component, TAS5722_DIGITAL_CTRL2_REG, &val);
+	ucontrol->value.integer.value[0] |= val & TAS5722_VOL_CONTROL_LSB;
+
+	return 0;
+}
+
+static int tas5722_volume_set(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int sel = ucontrol->value.integer.value[0];
+
+	snd_soc_component_write(component, TAS5720_VOLUME_CTRL_REG, sel >> 1);
+	snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
+				      TAS5722_VOL_CONTROL_LSB, sel);
+
+	return 0;
+}
 
 static const struct snd_kcontrol_new tas5720_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Driver Playback Volume",
-		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, dac_tlv),
+		       TAS5720_VOLUME_CTRL_REG, 0, 0xff, 0, tas5720_dac_tlv),
+	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
+		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
+};
+
+static const struct snd_kcontrol_new tas5722_snd_controls[] = {
+	SOC_SINGLE_EXT_TLV("Speaker Driver Playback Volume",
+			   0, 0, 511, 0,
+			   tas5722_volume_get, tas5722_volume_set,
+			   tas5722_dac_tlv),
 	SOC_SINGLE_TLV("Speaker Driver Analog Gain", TAS5720_ANALOG_CTRL_REG,
 		       TAS5720_ANALOG_GAIN_SHIFT, 3, 0, dac_analog_tlv),
 };
@@ -527,6 +568,23 @@ static const struct snd_soc_component_driver soc_component_dev_tas5720 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+static const struct snd_soc_component_driver soc_component_dev_tas5722 = {
+	.probe = tas5720_codec_probe,
+	.remove = tas5720_codec_remove,
+	.suspend = tas5720_suspend,
+	.resume = tas5720_resume,
+	.controls = tas5722_snd_controls,
+	.num_controls = ARRAY_SIZE(tas5722_snd_controls),
+	.dapm_widgets = tas5720_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tas5720_dapm_widgets),
+	.dapm_routes = tas5720_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(tas5720_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+};
+
 /* PCM rates supported by the TAS5720 driver */
 #define TAS5720_RATES	(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
 			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
@@ -613,9 +671,23 @@ static int tas5720_probe(struct i2c_client *client,
 
 	dev_set_drvdata(dev, data);
 
-	ret = devm_snd_soc_register_component(&client->dev,
-				     &soc_component_dev_tas5720,
-				     tas5720_dai, ARRAY_SIZE(tas5720_dai));
+	switch (id->driver_data) {
+	case TAS5720:
+		ret = devm_snd_soc_register_component(&client->dev,
+					&soc_component_dev_tas5720,
+					tas5720_dai,
+					ARRAY_SIZE(tas5720_dai));
+		break;
+	case TAS5722:
+		ret = devm_snd_soc_register_component(&client->dev,
+					&soc_component_dev_tas5722,
+					tas5720_dai,
+					ARRAY_SIZE(tas5720_dai));
+		break;
+	default:
+		dev_err(dev, "unexpected private driver data\n");
+		return -EINVAL;
+	}
 	if (ret < 0) {
 		dev_err(dev, "failed to register component: %d\n", ret);
 		return ret;
-- 
2.19.0.rc1
