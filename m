From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/10] ASoC: twl6040: Combine the custom volsw
	get, and put functions
Date: Mon, 26 Sep 2011 16:26:25 +0300
Message-ID: <1317043593-27202-3-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 17332243AD
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:47 +0200 (CEST)
Received: by mail-bw0-f53.google.com with SMTP id zt12so7309158bkb.40
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:46 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

We can manage with one set of get, and put function for the gain
controls we need to handle with custom code due to the shadowing
of the register.
For both get, and put function we can call decide based on the
mc->rreg value, if we need to call the volsw, or the vlosw_2r
variant (in 2r case rreg is not 0).
Handling of the shadow values are the same for both type of
controls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   81 +++++++++----------------------------------
 1 files changed, 17 insertions(+), 64 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index b63ee24..0fd8719 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -763,15 +763,17 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int ret;
-	unsigned int reg = mc->reg;
 
 	/* For HS and HF we shadow the values and only actually write
 	 * them out when active in order to ensure the amplifier comes on
 	 * as quietly as possible. */
-	switch (reg) {
+	switch (mc->reg) {
 	case TWL6040_REG_HSGAIN:
 		out = &twl6040_priv->headset;
 		break;
+	case TWL6040_REG_HFLGAIN:
+		out = &twl6040_priv->handsfree;
+		break;
 	default:
 		break;
 	}
@@ -783,7 +785,12 @@ static int twl6040_put_volsw(struct snd_kcontrol *kcontrol,
 			return 1;
 	}
 
-	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	/* call the appropriate handler depending on the rreg */
+	if (mc->rreg)
+		ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
+	else
+		ret = snd_soc_put_volsw(kcontrol, ucontrol);
+
 	if (ret < 0)
 		return ret;
 
@@ -798,39 +805,12 @@ static int twl6040_get_volsw(struct snd_kcontrol *kcontrol,
 	struct twl6040_output *out = &twl6040_priv->headset;
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
 
-	switch (reg) {
+	switch (mc->reg) {
 	case TWL6040_REG_HSGAIN:
 		out = &twl6040_priv->headset;
-		ucontrol->value.integer.value[0] = out->left_vol;
-		ucontrol->value.integer.value[1] = out->right_vol;
-		return 0;
-
-	default:
 		break;
-	}
-
-	return snd_soc_get_volsw(kcontrol, ucontrol);
-}
-
-static int twl6040_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *out = NULL;
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	int ret;
-	unsigned int reg = mc->reg;
-
-	/* For HS and HF we shadow the values and only actually write
-	 * them out when active in order to ensure the amplifier comes on
-	 * as quietly as possible. */
-	switch (reg) {
 	case TWL6040_REG_HFLGAIN:
-	case TWL6040_REG_HFRGAIN:
 		out = &twl6040_priv->handsfree;
 		break;
 	default:
@@ -838,43 +818,16 @@ static int twl6040_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
 	}
 
 	if (out) {
-		out->left_vol = ucontrol->value.integer.value[0];
-		out->right_vol = ucontrol->value.integer.value[1];
-		if (!out->active)
-			return 1;
-	}
-
-	ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
-	if (ret < 0)
-		return ret;
-
-	return 1;
-}
-
-static int twl6040_get_volsw_2r(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct twl6040_data *twl6040_priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040_output *out = &twl6040_priv->handsfree;
-	struct soc_mixer_control *mc =
-		(struct soc_mixer_control *)kcontrol->private_value;
-	unsigned int reg = mc->reg;
-
-	/* If these are cached registers use the cache */
-	switch (reg) {
-	case TWL6040_REG_HFLGAIN:
-	case TWL6040_REG_HFRGAIN:
-		out = &twl6040_priv->handsfree;
 		ucontrol->value.integer.value[0] = out->left_vol;
 		ucontrol->value.integer.value[1] = out->right_vol;
 		return 0;
-
-	default:
-		break;
 	}
 
-	return snd_soc_get_volsw_2r(kcontrol, ucontrol);
+	/* call the appropriate handler depending on the rreg */
+	if (mc->rreg)
+		return snd_soc_get_volsw_2r(kcontrol, ucontrol);
+	else
+		return snd_soc_get_volsw(kcontrol, ucontrol);
 }
 
 /* double control with volume update */
@@ -899,7 +852,7 @@ static int twl6040_get_volsw_2r(struct snd_kcontrol *kcontrol,
 		SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
-	.get = twl6040_get_volsw_2r, .put = twl6040_put_volsw_2r_vu, \
+	.get = twl6040_get_volsw, .put = twl6040_put_volsw, \
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
 		 .rshift = xshift, .max = xmax, .invert = xinvert}, }
-- 
1.7.6.1
