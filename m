From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/13] ASoC: Add snd_soc_kcontrol_codec()
	helper function
Date: Tue, 18 Mar 2014 09:02:04 +0100
Message-ID: <1395129736-11938-2-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id D69C9261AE9
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:38 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For CODEC controls snd_kcontrol_chip() currently returns a pointer to the
CODEC that registered the control. With the upcoming consolidation of
platform and CODEC controls this will change. Prepare for this by introducing
the snd_soc_kcontrol_codec() helper function that will hide the implementation
details of how the CODEC for a control can be obtained. This will allow us to
change this easily in the future.

The patch also updates all CODEC drivers to use the new helper function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h               | 14 ++++++++++++++
 sound/soc/codecs/88pm860x-codec.c |  8 ++++----
 sound/soc/codecs/ab8500-codec.c   | 12 ++++++------
 sound/soc/codecs/adav80x.c        |  4 ++--
 sound/soc/codecs/ak4641.c         |  4 ++--
 sound/soc/codecs/cs4270.c         |  2 +-
 sound/soc/codecs/cs4271.c         |  4 ++--
 sound/soc/codecs/cs42l51.c        |  4 ++--
 sound/soc/codecs/da7210.c         |  4 ++--
 sound/soc/codecs/da7213.c         |  4 ++--
 sound/soc/codecs/da732x.c         |  4 ++--
 sound/soc/codecs/da9055.c         |  2 +-
 sound/soc/codecs/lm4857.c         |  4 ++--
 sound/soc/codecs/max9768.c        |  4 ++--
 sound/soc/codecs/max98088.c       | 12 ++++++------
 sound/soc/codecs/max98090.c       |  4 ++--
 sound/soc/codecs/max98095.c       | 16 ++++++++--------
 sound/soc/codecs/pcm1681.c        |  4 ++--
 sound/soc/codecs/rt5631.c         |  4 ++--
 sound/soc/codecs/sgtl5000.c       |  4 ++--
 sound/soc/codecs/sta32x.c         |  4 ++--
 sound/soc/codecs/tas5086.c        |  4 ++--
 sound/soc/codecs/tlv320aic23.c    |  4 ++--
 sound/soc/codecs/tlv320dac33.c    |  4 ++--
 sound/soc/codecs/twl4030.c        | 10 +++++-----
 sound/soc/codecs/twl6040.c        |  8 ++++----
 sound/soc/codecs/wl1273.c         | 12 ++++++------
 sound/soc/codecs/wm2000.c         |  8 ++++----
 sound/soc/codecs/wm8350.c         |  4 ++--
 sound/soc/codecs/wm8400.c         |  2 +-
 sound/soc/codecs/wm8580.c         |  2 +-
 sound/soc/codecs/wm8731.c         |  4 ++--
 sound/soc/codecs/wm8753.c         |  4 ++--
 sound/soc/codecs/wm8804.c         |  4 ++--
 sound/soc/codecs/wm8903.c         |  4 ++--
 sound/soc/codecs/wm8904.c         | 14 +++++++-------
 sound/soc/codecs/wm8955.c         |  4 ++--
 sound/soc/codecs/wm8958-dsp2.c    | 32 ++++++++++++++++----------------
 sound/soc/codecs/wm8960.c         |  4 ++--
 sound/soc/codecs/wm8962.c         |  8 ++++----
 sound/soc/codecs/wm8983.c         |  4 ++--
 sound/soc/codecs/wm8985.c         |  4 ++--
 sound/soc/codecs/wm8990.c         |  2 +-
 sound/soc/codecs/wm8991.c         |  2 +-
 sound/soc/codecs/wm8994.c         | 10 +++++-----
 sound/soc/codecs/wm8996.c         |  4 ++--
 sound/soc/codecs/wm9081.c         |  4 ++--
 sound/soc/codecs/wm_adsp.c        |  4 ++--
 sound/soc/codecs/wm_hubs.c        |  2 +-
 49 files changed, 154 insertions(+), 140 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f7de629..d7cef6b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1215,6 +1215,20 @@ static inline bool snd_soc_codec_is_active(struct snd_soc_codec *codec)
 	return snd_soc_component_is_active(&codec->component);
 }
 
+/**
+ * snd_soc_kcontrol_codec() - Returns the CODEC that registered the control
+ * @kcontrol: The control for which to get the CODEC
+ *
+ * Note: This function will only work correctly if the control has been
+ * registered with snd_soc_add_codec_controls() or via table based setup of
+ * snd_soc_codec_driver. Otherwise the behavior is undefined.
+ */
+static inline struct snd_soc_codec *snd_soc_kcontrol_codec(
+	struct snd_kcontrol *kcontrol)
+{
+	return snd_kcontrol_chip(kcontrol);
+}
+
 int snd_soc_util_init(void);
 void snd_soc_util_exit(void);
 
diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index b07e171..b18cafa 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -276,7 +276,7 @@ static int snd_soc_get_volsw_2r_st(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	int val[2], val2[2], i;
@@ -300,7 +300,7 @@ static int snd_soc_put_volsw_2r_st(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	int err;
@@ -333,7 +333,7 @@ static int snd_soc_get_volsw_2r_out(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -353,7 +353,7 @@ static int snd_soc_put_volsw_2r_out(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 1ad92cb..1fb4402 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1139,7 +1139,7 @@ static void anc_configure(struct snd_soc_codec *codec,
 static int sid_status_control_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
 	mutex_lock(&codec->mutex);
@@ -1153,7 +1153,7 @@ static int sid_status_control_get(struct snd_kcontrol *kcontrol,
 static int sid_status_control_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 	unsigned int param, sidconf, val;
 	int status = 1;
@@ -1208,7 +1208,7 @@ out:
 static int anc_status_control_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
 	mutex_lock(&codec->mutex);
@@ -1221,7 +1221,7 @@ static int anc_status_control_get(struct snd_kcontrol *kcontrol,
 static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 	struct device *dev = codec->dev;
 	bool apply_fir, apply_iir;
@@ -1306,7 +1306,7 @@ static int filter_control_info(struct snd_kcontrol *kcontrol,
 static int filter_control_get(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct filter_control *fc =
 			(struct filter_control *)kcontrol->private_value;
 	unsigned int i;
@@ -1322,7 +1322,7 @@ static int filter_control_get(struct snd_kcontrol *kcontrol,
 static int filter_control_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct filter_control *fc =
 			(struct filter_control *)kcontrol->private_value;
 	unsigned int i;
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index 5062e34..cf170b5 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -315,7 +315,7 @@ static int adav80x_set_deemph(struct snd_soc_codec *codec)
 static int adav80x_put_deemph(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 	unsigned int deemph = ucontrol->value.enumerated.item[0];
 
@@ -330,7 +330,7 @@ static int adav80x_put_deemph(struct snd_kcontrol *kcontrol,
 static int adav80x_get_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct adav80x *adav80x = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = adav80x->deemph;
diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 868c0e2..7afe8f4 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -74,7 +74,7 @@ static int ak4641_set_deemph(struct snd_soc_codec *codec)
 static int ak4641_put_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 
@@ -89,7 +89,7 @@ static int ak4641_put_deemph(struct snd_kcontrol *kcontrol,
 static int ak4641_get_deemph(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct ak4641_priv *ak4641 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = ak4641->deemph;
diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index 3920e62..9947a95 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -438,7 +438,7 @@ static int cs4270_dai_mute(struct snd_soc_dai *dai, int mute)
 static int cs4270_soc_put_mute(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct cs4270_private *cs4270 = snd_soc_codec_get_drvdata(codec);
 	int left = !ucontrol->value.integer.value[0];
 	int right = !ucontrol->value.integer.value[1];
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index aef4965..93cec52 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -284,7 +284,7 @@ static int cs4271_set_deemph(struct snd_soc_codec *codec)
 static int cs4271_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = cs4271->deemph;
@@ -294,7 +294,7 @@ static int cs4271_get_deemph(struct snd_kcontrol *kcontrol,
 static int cs4271_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct cs4271_private *cs4271 = snd_soc_codec_get_drvdata(codec);
 
 	cs4271->deemph = ucontrol->value.enumerated.item[0];
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 1870620..edf46e8 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -55,7 +55,7 @@ struct cs42l51_private {
 static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned long value = snd_soc_read(codec, CS42L51_PCM_MIXER)&3;
 
 	switch (value) {
@@ -83,7 +83,7 @@ static int cs42l51_get_chan_mix(struct snd_kcontrol *kcontrol,
 static int cs42l51_set_chan_mix(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned char val;
 
 	switch (ucontrol->value.integer.value[0]) {
diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 137e8eb..21810e5 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -335,7 +335,7 @@ static SOC_ENUM_SINGLE_DECL(da7210_hp_mode_sel,
 static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 
 	if (ucontrol->value.integer.value[0]) {
 		/* Check if noise suppression is enabled */
@@ -358,7 +358,7 @@ static int da7210_put_alc_sw(struct snd_kcontrol *kcontrol,
 static int da7210_put_noise_sup_sw(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	u8 val;
 
 	if (ucontrol->value.integer.value[0]) {
diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 738fa18..9ec577f 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -345,7 +345,7 @@ static void da7213_alc_calib(struct snd_soc_codec *codec)
 static int da7213_put_mixin_gain(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -361,7 +361,7 @@ static int da7213_put_mixin_gain(struct snd_kcontrol *kcontrol,
 static int da7213_put_alc_sw(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
 
 	/* Force ALC offset calibration if enabling ALC */
diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 7d168ec..60bd0b5 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -332,7 +332,7 @@ static SOC_ENUM_SINGLE_DECL(da732x_adc2_voice_filter_enum,
 static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
 	unsigned int sel = ucontrol->value.integer.value[0];
@@ -360,7 +360,7 @@ static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 static int da732x_hpf_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
 	int val;
diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index 4ff06b5..ad19cc5 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -484,7 +484,7 @@ static int da9055_get_alc_data(struct snd_soc_codec *codec, u8 reg_val)
 static int da9055_put_alc_sw(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	u8 reg_val, adc_left, adc_right, mic_left, mic_right;
 	int avg_left_data, avg_right_data, offset_l, offset_r;
 
diff --git a/sound/soc/codecs/lm4857.c b/sound/soc/codecs/lm4857.c
index 4f048db..a924bb9 100644
--- a/sound/soc/codecs/lm4857.c
+++ b/sound/soc/codecs/lm4857.c
@@ -49,7 +49,7 @@ static const struct reg_default lm4857_default_regs[] = {
 static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = lm4857->mode;
@@ -60,7 +60,7 @@ static int lm4857_get_mode(struct snd_kcontrol *kcontrol,
 static int lm4857_set_mode(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct lm4857 *lm4857 = snd_soc_codec_get_drvdata(codec);
 	uint8_t value = ucontrol->value.integer.value[0];
 
diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index ec481fc..e1c196a 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -43,7 +43,7 @@ static struct reg_default max9768_default_regs[] = {
 static int max9768_get_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
 	int val = gpio_get_value_cansleep(max9768->mute_gpio);
 
@@ -55,7 +55,7 @@ static int max9768_get_gpio(struct snd_kcontrol *kcontrol,
 static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
 
 	gpio_set_value_cansleep(max9768->mute_gpio, !ucontrol->value.integer.value[0]);
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ef7cf89..9134982 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -635,7 +635,7 @@ static SOC_ENUM_SINGLE_DECL(max98088_dai1_adc_filter_enum,
 static int max98088_mic1pre_set(struct snd_kcontrol *kcontrol,
                                struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -649,7 +649,7 @@ static int max98088_mic1pre_set(struct snd_kcontrol *kcontrol,
 static int max98088_mic1pre_get(struct snd_kcontrol *kcontrol,
                                struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
 
        ucontrol->value.integer.value[0] = max98088->mic1pre;
@@ -659,7 +659,7 @@ static int max98088_mic1pre_get(struct snd_kcontrol *kcontrol,
 static int max98088_mic2pre_set(struct snd_kcontrol *kcontrol,
                                struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -673,7 +673,7 @@ static int max98088_mic2pre_set(struct snd_kcontrol *kcontrol,
 static int max98088_mic2pre_get(struct snd_kcontrol *kcontrol,
                                struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
 
        ucontrol->value.integer.value[0] = max98088->mic2pre;
@@ -1750,7 +1750,7 @@ static void max98088_setup_eq2(struct snd_soc_codec *codec)
 static int max98088_put_eq_enum(struct snd_kcontrol *kcontrol,
                                 struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        struct max98088_pdata *pdata = max98088->pdata;
        int channel = max98088_get_channel(codec, kcontrol->id.name);
@@ -1782,7 +1782,7 @@ static int max98088_put_eq_enum(struct snd_kcontrol *kcontrol,
 static int max98088_get_eq_enum(struct snd_kcontrol *kcontrol,
                                 struct snd_ctl_elem_value *ucontrol)
 {
-       struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+       struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        int channel = max98088_get_channel(codec, kcontrol->id.name);
        struct max98088_cdata *cdata;
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 98c6e10..1baa12c 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -426,7 +426,7 @@ static const unsigned int max98090_rcv_lout_tlv[] = {
 static int max98090_get_enab_tlv(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
@@ -466,7 +466,7 @@ static int max98090_get_enab_tlv(struct snd_kcontrol *kcontrol,
 static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98090_priv *max98090 = snd_soc_codec_get_drvdata(codec);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 03f0536..5d4c621 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -612,7 +612,7 @@ static SOC_ENUM_SINGLE_DECL(max98095_dai3_dac_filter_enum,
 static int max98095_mic1pre_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -626,7 +626,7 @@ static int max98095_mic1pre_set(struct snd_kcontrol *kcontrol,
 static int max98095_mic1pre_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = max98095->mic1pre;
@@ -636,7 +636,7 @@ static int max98095_mic1pre_get(struct snd_kcontrol *kcontrol,
 static int max98095_mic2pre_set(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -650,7 +650,7 @@ static int max98095_mic2pre_set(struct snd_kcontrol *kcontrol,
 static int max98095_mic2pre_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = max98095->mic2pre;
@@ -1737,7 +1737,7 @@ static int max98095_get_eq_channel(const char *name)
 static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	struct max98095_pdata *pdata = max98095->pdata;
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
@@ -1801,7 +1801,7 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 static int max98095_get_eq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	int channel = max98095_get_eq_channel(kcontrol->id.name);
 	struct max98095_cdata *cdata;
@@ -1891,7 +1891,7 @@ static int max98095_get_bq_channel(struct snd_soc_codec *codec,
 static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	struct max98095_pdata *pdata = max98095->pdata;
 	int channel = max98095_get_bq_channel(codec, kcontrol->id.name);
@@ -1952,7 +1952,7 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 static int max98095_get_bq_enum(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	int channel = max98095_get_bq_channel(codec, kcontrol->id.name);
 	struct max98095_cdata *cdata;
diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index e427544..a722a02 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -115,7 +115,7 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
 static int pcm1681_get_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = priv->deemph;
@@ -126,7 +126,7 @@ static int pcm1681_get_deemph(struct snd_kcontrol *kcontrol,
 static int pcm1681_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	priv->deemph = ucontrol->value.enumerated.item[0];
diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index d4c229f..30e2347 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -188,7 +188,7 @@ static unsigned int mic_bst_tlv[] = {
 static int rt5631_dmic_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = rt5631->dmic_used_flag;
@@ -199,7 +199,7 @@ static int rt5631_dmic_get(struct snd_kcontrol *kcontrol,
 static int rt5631_dmic_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
 
 	rt5631->dmic_used_flag = ucontrol->value.integer.value[0];
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d3ed1be..b56caef 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -296,7 +296,7 @@ static int dac_info_volsw(struct snd_kcontrol *kcontrol,
 static int dac_get_volsw(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int reg;
 	int l;
 	int r;
@@ -349,7 +349,7 @@ static int dac_get_volsw(struct snd_kcontrol *kcontrol,
 static int dac_put_volsw(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int reg;
 	int l;
 	int r;
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 1257774..0579d18 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -243,7 +243,7 @@ static int sta32x_coefficient_info(struct snd_kcontrol *kcontrol,
 static int sta32x_coefficient_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
 	unsigned int cfud;
@@ -272,7 +272,7 @@ static int sta32x_coefficient_get(struct snd_kcontrol *kcontrol,
 static int sta32x_coefficient_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
 	int numcoef = kcontrol->private_value >> 16;
 	int index = kcontrol->private_value & 0xffff;
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index a895a5e..d48491a 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -272,7 +272,7 @@ static int tas5086_set_deemph(struct snd_soc_codec *codec)
 static int tas5086_get_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = priv->deemph;
@@ -283,7 +283,7 @@ static int tas5086_get_deemph(struct snd_kcontrol *kcontrol,
 static int tas5086_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 
 	priv->deemph = ucontrol->value.enumerated.item[0];
diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 20864ee..686b8b8 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -82,7 +82,7 @@ static const DECLARE_TLV_DB_SCALE(sidetone_vol_tlv, -1800, 300, 0);
 static int snd_soc_tlv320aic23_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	u16 val, reg;
 
 	val = (ucontrol->value.integer.value[0] & 0x07);
@@ -105,7 +105,7 @@ static int snd_soc_tlv320aic23_put_volsw(struct snd_kcontrol *kcontrol,
 static int snd_soc_tlv320aic23_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	u16 val;
 
 	val = snd_soc_read(codec, TLV320AIC23_ANLG) & (0x1C0);
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 6bfc8a1..517055a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -442,7 +442,7 @@ static int dac33_playback_event(struct snd_soc_dapm_widget *w,
 static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = dac33->fifo_mode;
@@ -453,7 +453,7 @@ static int dac33_get_fifo_mode(struct snd_kcontrol *kcontrol,
 static int dac33_set_fifo_mode(struct snd_kcontrol *kcontrol,
 			 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct tlv320dac33_priv *dac33 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 975e0f7..69e12a3 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -830,7 +830,7 @@ static int snd_soc_get_volsw_twl4030(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
@@ -859,7 +859,7 @@ static int snd_soc_put_volsw_twl4030(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
@@ -888,7 +888,7 @@ static int snd_soc_get_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -915,7 +915,7 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	unsigned int shift = mc->shift;
@@ -956,7 +956,7 @@ static SOC_ENUM_SINGLE_DECL(twl4030_op_modes_enum,
 static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
 	if (twl4030->configured) {
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index bd3a206..0f6067f 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -484,7 +484,7 @@ static SOC_ENUM_SINGLE_EXT_DECL(twl6040_power_mode_enum,
 static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = priv->hs_power_mode;
@@ -495,7 +495,7 @@ static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_headset_power_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int high_perf = ucontrol->value.enumerated.item[0];
 	int ret = 0;
@@ -512,7 +512,7 @@ static int twl6040_headset_power_put_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_pll_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = priv->pll_power_mode;
@@ -523,7 +523,7 @@ static int twl6040_pll_get_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_pll_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 
 	priv->pll_power_mode = ucontrol->value.enumerated.item[0];
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index 6be5f80..4ead0dc 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -172,7 +172,7 @@ out:
 static int snd_wl1273_get_audio_route(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = wl1273->mode;
@@ -190,7 +190,7 @@ static const char * const wl1273_audio_route[] = { "Bt", "FmRx", "FmTx" };
 static int snd_wl1273_set_audio_route(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
 	if (wl1273->mode == ucontrol->value.integer.value[0])
@@ -214,7 +214,7 @@ static SOC_ENUM_SINGLE_EXT_DECL(wl1273_enum, wl1273_audio_route);
 static int snd_wl1273_fm_audio_get(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
 	dev_dbg(codec->dev, "%s: enter.\n", __func__);
@@ -227,7 +227,7 @@ static int snd_wl1273_fm_audio_get(struct snd_kcontrol *kcontrol,
 static int snd_wl1273_fm_audio_put(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 	int val, r = 0;
 
@@ -251,7 +251,7 @@ static SOC_ENUM_SINGLE_EXT_DECL(wl1273_audio_enum, wl1273_audio_strings);
 static int snd_wl1273_fm_volume_get(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 
 	dev_dbg(codec->dev, "%s: enter.\n", __func__);
@@ -264,7 +264,7 @@ static int snd_wl1273_fm_volume_get(struct snd_kcontrol *kcontrol,
 static int snd_wl1273_fm_volume_put(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wl1273_priv *wl1273 = snd_soc_codec_get_drvdata(codec);
 	int r;
 
diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 83a2c87..a4c352c 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -607,7 +607,7 @@ static int wm2000_anc_set_mode(struct wm2000_priv *wm2000)
 static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
 	ucontrol->value.enumerated.item[0] = wm2000->anc_active;
@@ -618,7 +618,7 @@ static int wm2000_anc_mode_get(struct snd_kcontrol *kcontrol,
 static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int anc_active = ucontrol->value.enumerated.item[0];
 	int ret;
@@ -640,7 +640,7 @@ static int wm2000_anc_mode_put(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 
 	ucontrol->value.enumerated.item[0] = wm2000->spk_ena;
@@ -651,7 +651,7 @@ static int wm2000_speaker_get(struct snd_kcontrol *kcontrol,
 static int wm2000_speaker_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm2000_priv *wm2000 = dev_get_drvdata(codec->dev);
 	int val = ucontrol->value.enumerated.item[0];
 	int ret;
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 757256b..42a72b2 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -302,7 +302,7 @@ static int pga_event(struct snd_soc_dapm_widget *w,
 static int wm8350_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8350_data *wm8350_priv = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out = NULL;
 	struct soc_mixer_control *mc =
@@ -345,7 +345,7 @@ static int wm8350_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
 static int wm8350_get_volsw_2r(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8350_data *wm8350_priv = snd_soc_codec_get_drvdata(codec);
 	struct wm8350_output *out1 = &wm8350_priv->out1;
 	struct wm8350_output *out2 = &wm8350_priv->out2;
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 146564f..edfdbcd 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -93,7 +93,7 @@ static const DECLARE_TLV_DB_SCALE(out_sidetone_tlv, -3600, 0, 0);
 static int wm8400_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
         struct snd_ctl_elem_value *ucontrol)
 {
-        struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int reg = mc->reg;
diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 7558c83..72a0712 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -252,7 +252,7 @@ static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index d74f439..763b265 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -119,7 +119,7 @@ static int wm8731_set_deemph(struct snd_soc_codec *codec)
 static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8731->deemph;
@@ -130,7 +130,7 @@ static int wm8731_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8731_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 	int ret = 0;
diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index cbb8d55..53e57b4 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -234,7 +234,7 @@ SOC_ENUM_SINGLE(WM8753_OUTCTL, 2, 2, wm8753_rout2_phase),
 static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = wm8753->dai_func;
@@ -244,7 +244,7 @@ static int wm8753_get_dai(struct snd_kcontrol *kcontrol,
 static int wm8753_set_dai(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8753_priv *wm8753 = snd_soc_codec_get_drvdata(codec);
 	u16 ioctl;
 
diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index ee76f0f..589455c 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -106,7 +106,7 @@ static int txsrc_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec;
 	unsigned int src;
 
-	codec = snd_kcontrol_chip(kcontrol);
+	codec = snd_soc_kcontrol_codec(kcontrol);
 	src = snd_soc_read(codec, WM8804_SPDTX4);
 	if (src & 0x40)
 		ucontrol->value.integer.value[0] = 1;
@@ -122,7 +122,7 @@ static int txsrc_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec;
 	unsigned int src, txpwr;
 
-	codec = snd_kcontrol_chip(kcontrol);
+	codec = snd_soc_kcontrol_codec(kcontrol);
 
 	if (ucontrol->value.integer.value[0] != 0
 			&& ucontrol->value.integer.value[0] != 1)
diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index b0084a1..b84940c 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -439,7 +439,7 @@ static int wm8903_set_deemph(struct snd_soc_codec *codec)
 static int wm8903_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8903->deemph;
@@ -450,7 +450,7 @@ static int wm8903_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8903_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8903_priv *wm8903 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 	int ret = 0;
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 49c35c3..f7c5499 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -391,7 +391,7 @@ static void wm8904_set_drc(struct snd_soc_codec *codec)
 static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.integer.value[0];
@@ -409,7 +409,7 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 static int wm8904_get_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8904->drc_cfg;
@@ -462,7 +462,7 @@ static void wm8904_set_retune_mobile(struct snd_soc_codec *codec)
 static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.integer.value[0];
@@ -480,7 +480,7 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8904_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8904->retune_mobile_cfg;
@@ -520,7 +520,7 @@ static int wm8904_set_deemph(struct snd_soc_codec *codec)
 static int wm8904_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8904->deemph;
@@ -530,7 +530,7 @@ static int wm8904_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8904_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 
@@ -570,7 +570,7 @@ static SOC_ENUM_SINGLE_DECL(hpf_mode, WM8904_ADC_DIGITAL_0, 5,
 static int wm8904_adc_osr_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int val;
 	int ret;
 
diff --git a/sound/soc/codecs/wm8955.c b/sound/soc/codecs/wm8955.c
index fecd4e4..7e443c4 100644
--- a/sound/soc/codecs/wm8955.c
+++ b/sound/soc/codecs/wm8955.c
@@ -390,7 +390,7 @@ static int wm8955_set_deemph(struct snd_soc_codec *codec)
 static int wm8955_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8955->deemph;
@@ -400,7 +400,7 @@ static int wm8955_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8955_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8955_priv *wm8955 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 
diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 7ac2e51..b2ebb10 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -456,7 +456,7 @@ static int wm8958_dsp2_busy(struct wm8994_priv *wm8994, int aif)
 static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
@@ -478,7 +478,7 @@ static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_mbc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8994->mbc_cfg;
@@ -500,7 +500,7 @@ static int wm8958_mbc_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int mbc = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = wm8994->mbc_ena[mbc];
@@ -512,7 +512,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int mbc = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (wm8994->mbc_ena[mbc] == ucontrol->value.integer.value[0])
@@ -546,7 +546,7 @@ static int wm8958_mbc_put(struct snd_kcontrol *kcontrol,
 static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
@@ -568,7 +568,7 @@ static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_vss_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8994->vss_cfg;
@@ -579,7 +579,7 @@ static int wm8958_get_vss_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
@@ -601,7 +601,7 @@ static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8994->vss_hpf_cfg;
@@ -623,7 +623,7 @@ static int wm8958_vss_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int vss = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = wm8994->vss_ena[vss];
@@ -635,7 +635,7 @@ static int wm8958_vss_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int vss = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (wm8994->vss_ena[vss] == ucontrol->value.integer.value[0])
@@ -684,7 +684,7 @@ static int wm8958_hpf_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int hpf = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (hpf < 3)
@@ -699,7 +699,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int hpf = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (hpf < 3) {
@@ -746,7 +746,7 @@ static int wm8958_hpf_put(struct snd_kcontrol *kcontrol,
 static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	int value = ucontrol->value.integer.value[0];
@@ -768,7 +768,7 @@ static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 static int wm8958_get_enh_eq_enum(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8994->enh_eq_cfg;
@@ -790,7 +790,7 @@ static int wm8958_enh_eq_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int eq = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = wm8994->enh_eq_ena[eq];
@@ -802,7 +802,7 @@ static int wm8958_enh_eq_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
 	int eq = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
 	if (wm8994->enh_eq_ena[eq] == ucontrol->value.integer.value[0])
diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d04e9ca..a145d04 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -178,7 +178,7 @@ static int wm8960_set_deemph(struct snd_soc_codec *codec)
 static int wm8960_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.enumerated.item[0] = wm8960->deemph;
@@ -188,7 +188,7 @@ static int wm8960_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int deemph = ucontrol->value.enumerated.item[0];
 
diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 5522d25..37986c8 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1552,7 +1552,7 @@ static int wm8962_dsp2_ena_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	int shift = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = !!(wm8962->dsp2_ena & 1 << shift);
@@ -1564,7 +1564,7 @@ static int wm8962_dsp2_ena_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	int shift = kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
 	int old = wm8962->dsp2_ena;
 	int ret = 0;
@@ -1602,7 +1602,7 @@ out:
 static int wm8962_put_hp_sw(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int ret;
 
 	/* Apply the update (if any) */
@@ -1632,7 +1632,7 @@ static int wm8962_put_hp_sw(struct snd_kcontrol *kcontrol,
 static int wm8962_put_spk_sw(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int ret;
 
 	/* Apply the update (if any) */
diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
index 2b9bfa5..19d5baa 100644
--- a/sound/soc/codecs/wm8983.c
+++ b/sound/soc/codecs/wm8983.c
@@ -552,7 +552,7 @@ static const struct snd_soc_dapm_route wm8983_audio_map[] = {
 static int eqmode_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg;
 
 	reg = snd_soc_read(codec, WM8983_EQ1_LOW_SHELF);
@@ -567,7 +567,7 @@ static int eqmode_get(struct snd_kcontrol *kcontrol,
 static int eqmode_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int regpwr2, regpwr3;
 	unsigned int reg_eq;
 
diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
index 5473dc9..ad23ffb 100644
--- a/sound/soc/codecs/wm8985.c
+++ b/sound/soc/codecs/wm8985.c
@@ -526,7 +526,7 @@ static const struct snd_soc_dapm_route wm8985_dapm_routes[] = {
 static int eqmode_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg;
 
 	reg = snd_soc_read(codec, WM8985_EQ1_LOW_SHELF);
@@ -541,7 +541,7 @@ static int eqmode_get(struct snd_kcontrol *kcontrol,
 static int eqmode_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int regpwr2, regpwr3;
 	unsigned int reg_eq;
 
diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index c413c19..b5c1f0f 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -132,7 +132,7 @@ static const DECLARE_TLV_DB_SCALE(out_sidetone_tlv, -3600, 0, 0);
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int reg = mc->reg;
diff --git a/sound/soc/codecs/wm8991.c b/sound/soc/codecs/wm8991.c
index 844cc4a..b8fd284f 100644
--- a/sound/soc/codecs/wm8991.c
+++ b/sound/soc/codecs/wm8991.c
@@ -154,7 +154,7 @@ static const unsigned int out_sidetone_tlv[] = {
 static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int reg = kcontrol->private_value & 0xff;
 	int ret;
 	u16 val;
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 6303537..3eb390b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -298,7 +298,7 @@ static int wm8994_put_drc_sw(struct snd_kcontrol *kcontrol,
 {
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int mask, ret;
 
 	/* Can't enable both ADC and DAC paths simultaneously */
@@ -355,7 +355,7 @@ static int wm8994_get_drc(const char *name)
 static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
@@ -378,7 +378,7 @@ static int wm8994_put_drc_enum(struct snd_kcontrol *kcontrol,
 static int wm8994_get_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int drc = wm8994_get_drc(kcontrol->id.name);
 
@@ -462,7 +462,7 @@ static int wm8994_get_retune_mobile_block(const char *name)
 static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
 	struct wm8994_pdata *pdata = &control->pdata;
@@ -485,7 +485,7 @@ static int wm8994_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8994_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	int block = wm8994_get_retune_mobile_block(kcontrol->id.name);
 
diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index c6cbb3b..6926633 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -412,7 +412,7 @@ static int wm8996_get_retune_mobile_block(const char *name)
 static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	struct wm8996_pdata *pdata = &wm8996->pdata;
 	int block = wm8996_get_retune_mobile_block(kcontrol->id.name);
@@ -434,7 +434,7 @@ static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8996_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	int block = wm8996_get_retune_mobile_block(kcontrol->id.name);
 
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index d18eff3..185eb97 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -340,7 +340,7 @@ static SOC_ENUM_SINGLE_DECL(speaker_mode, WM9081_ANALOGUE_SPEAKER_2, 6,
 static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg;
 
 	reg = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
@@ -361,7 +361,7 @@ static int speaker_mode_get(struct snd_kcontrol *kcontrol,
 static int speaker_mode_put(struct snd_kcontrol *kcontrol,
 			    struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	unsigned int reg_pwr = snd_soc_read(codec, WM9081_POWER_MANAGEMENT);
 	unsigned int reg2 = snd_soc_read(codec, WM9081_ANALOGUE_SPEAKER_2);
 
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bb5f7b4..d9686dc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -242,7 +242,7 @@ struct wm_coeff_ctl {
 static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *adsp = snd_soc_codec_get_drvdata(codec);
 
@@ -254,7 +254,7 @@ static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *adsp = snd_soc_codec_get_drvdata(codec);
 
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index b620966..916817f 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -337,7 +337,7 @@ static void enable_dc_servo(struct snd_soc_codec *codec)
 static int wm8993_put_dc_servo(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm_hubs_data *hubs = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-- 
1.8.0
