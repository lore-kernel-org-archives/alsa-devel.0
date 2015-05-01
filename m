From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] ASoC: lm4857: Use DAPM demux
Date: Fri,  1 May 2015 18:02:44 +0200
Message-ID: <1430496165-13917-3-git-send-email-lars@metafoo.de>
References: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 52D05260538
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 19:15:52 +0200 (CEST)
In-Reply-To: <1430496165-13917-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use a DAPM auto-disable demux to model the Mode control which affects the
routing of the input pin to the output pins. This allows us to remove the
custom code for handling the Mode control.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/lm4857.c | 100 ++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 74 deletions(-)

diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 79ad4cb..dac9165 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -23,11 +23,6 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
-struct lm4857 {
-	struct regmap *regmap;
-	uint8_t mode;
-};
-
 static const struct reg_default lm4857_default_regs[] = {
 	{ 0x0, 0x00 },
 	{ 0x1, 0x00 },
@@ -46,64 +41,33 @@ static const struct reg_default lm4857_default_regs[] = {
 #define LM4857_WAKEUP 5
 #define LM4857_EPGAIN 4
 
-static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
-
-	ucontrol->value.integer.value[0] = lm4857->mode;
-
-	return 0;
-}
-
-static int lm4857_set_mode(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
-	uint8_t value = ucontrol->value.integer.value[0];
-
-	lm4857->mode = value;
-
-	if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
-		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F, value + 6);
-
-	return 1;
-}
-
-static int lm4857_set_bias_level(struct snd_soc_codec *codec,
-				 enum snd_soc_bias_level level)
-{
-	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
-
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F,
-			lm4857->mode + 6);
-		break;
-	case SND_SOC_BIAS_STANDBY:
-		regmap_update_bits(lm4857->regmap, LM4857_CTRL, 0x0F, 0);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
+static const unsigned int lm4857_mode_values[] = {
+	0,
+	6,
+	7,
+	8,
+	9,
+};
 
-static const char *lm4857_mode[] = {
+static const char * const lm4857_mode_texts[] = {
+	"Off",
 	"Earpiece",
 	"Loudspeaker",
 	"Loudspeaker + Headphone",
 	"Headphone",
 };
 
-static SOC_ENUM_SINGLE_EXT_DECL(lm4857_mode_enum, lm4857_mode);
+static SOC_VALUE_ENUM_SINGLE_AUTODISABLE_DECL(lm4857_mode_enum,
+	LM4857_CTRL, 0, 0xf, lm4857_mode_texts, lm4857_mode_values);
+
+static const struct snd_kcontrol_new lm4857_mode_ctrl =
+	SOC_DAPM_ENUM("Mode", lm4857_mode_enum);
 
 static const struct snd_soc_dapm_widget lm4857_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("IN"),
 
+	SND_SOC_DAPM_DEMUX("Mode", SND_SOC_NOPM, 0, 0, &lm4857_mode_ctrl),
+
 	SND_SOC_DAPM_OUTPUT("LS"),
 	SND_SOC_DAPM_OUTPUT("HP"),
 	SND_SOC_DAPM_OUTPUT("EP"),
@@ -125,24 +89,18 @@ static const struct snd_kcontrol_new lm4857_controls[] = {
 		LM4857_WAKEUP, 1, 0),
 	SOC_SINGLE("Earpiece 6dB Playback Switch", LM4857_CTRL,
 		LM4857_EPGAIN, 1, 0),
-
-	SOC_ENUM_EXT("Mode", lm4857_mode_enum,
-		lm4857_get_mode, lm4857_set_mode),
 };
 
-/* There is a demux between the input signal and the output signals.
- * Currently there is no easy way to model it in ASoC and since it does not make
- * much of a difference in practice simply connect the input direclty to the
- * outputs. */
 static const struct snd_soc_dapm_route lm4857_routes[] = {
-	{"LS", NULL, "IN"},
-	{"HP", NULL, "IN"},
-	{"EP", NULL, "IN"},
+	{ "Mode", NULL, "IN" },
+	{ "LS", "Loudspeaker", "Mode" },
+	{ "LS", "Loudspeaker + Headphone", "Mode" },
+	{ "HP", "Headphone", "Mode" },
+	{ "HP", "Loudspeaker + Headphone", "Mode" },
+	{ "EP", "Earpiece", "Mode" },
 };
 
 static struct snd_soc_codec_driver soc_codec_dev_lm4857 = {
-	.set_bias_level = lm4857_set_bias_level,
-
 	.controls = lm4857_controls,
 	.num_controls = ARRAY_SIZE(lm4857_controls),
 	.dapm_widgets = lm4857_dapm_widgets,
@@ -165,17 +123,11 @@ static const struct regmap_config lm4857_regmap_config = {
 static int lm4857_i2c_probe(struct i2c_client *i2c,
 			    const struct i2c_device_id *id)
 {
-	struct lm4857 *lm4857;
-
-	lm4857 = devm_kzalloc(&i2c->dev, sizeof(*lm4857), GFP_KERNEL);
-	if (!lm4857)
-		return -ENOMEM;
-
-	i2c_set_clientdata(i2c, lm4857);
+	struct regmap *regmap;
 
-	lm4857->regmap = devm_regmap_init_i2c(i2c, &lm4857_regmap_config);
-	if (IS_ERR(lm4857->regmap))
-		return PTR_ERR(lm4857->regmap);
+	regmap = devm_regmap_init_i2c(i2c, &lm4857_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_lm4857, NULL, 0);
 }
-- 
1.8.0
