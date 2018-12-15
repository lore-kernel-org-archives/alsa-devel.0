From: tom.ty89@gmail.com
Subject: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Sat, 15 Dec 2018 22:32:10 +0800
Message-ID: <5c151073.1c69fb81.8fd52.ea81@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Tom Yan <tom.ty89@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Tom Yan <tom.ty89@gmail.com>

Add control for the de-emphasis filter in the PCM179x DACs

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index 24109d37ca09..0014c55ecc3d 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -331,7 +331,7 @@ static void pcm1796_init(struct oxygen *chip)
 	struct xonar_pcm179x *data = chip->model_data;
 
 	data->pcm1796_regs[0][18 - PCM1796_REG_BASE] =
-		PCM1796_DMF_DISABLED | PCM1796_FMT_24_I2S | PCM1796_ATLD;
+		PCM1796_FMT_24_I2S | PCM1796_ATLD;
 	if (!data->broken_i2c)
 		data->pcm1796_regs[0][18 - PCM1796_REG_BASE] |= PCM1796_MUTE;
 	data->pcm1796_regs[0][19 - PCM1796_REG_BASE] =
@@ -621,6 +621,33 @@ static void update_pcm1796_oversampling(struct oxygen *chip)
 		pcm1796_write_cached(chip, i, 20, reg);
 }
 
+static void update_pcm1796_deemph(struct oxygen *chip)
+{
+	struct xonar_pcm179x *data = chip->model_data;
+	unsigned int i;
+	u8 reg;
+
+	reg = data->pcm1796_regs[0][18 - PCM1796_REG_BASE] & ~PCM1796_DMF_MASK;
+	switch (data->current_rate) {
+	case 32000:
+	case 64000:
+		reg |= PCM1796_DMF_32;
+		break;
+	case 44100:
+	case 88200:
+	case 176400:
+		reg |= PCM1796_DMF_441;
+		break;
+	case 48000:
+	case 96000:
+	case 192000:
+		reg |= PCM1796_DMF_48;
+		break;
+	}
+	for (i = 0; i < data->dacs; ++i)
+		pcm1796_write_cached(chip, i, 18, reg);
+}
+
 static void set_pcm1796_params(struct oxygen *chip,
 			       struct snd_pcm_hw_params *params)
 {
@@ -629,6 +656,7 @@ static void set_pcm1796_params(struct oxygen *chip,
 	msleep(1);
 	data->current_rate = params_rate(params);
 	update_pcm1796_oversampling(chip);
+	update_pcm1796_deemph(chip);
 }
 
 static void update_pcm1796_volume(struct oxygen *chip)
@@ -653,9 +681,11 @@ static void update_pcm1796_mute(struct oxygen *chip)
 	unsigned int i;
 	u8 value;
 
-	value = PCM1796_DMF_DISABLED | PCM1796_FMT_24_I2S | PCM1796_ATLD;
+	value = data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
 	if (chip->dac_mute)
 		value |= PCM1796_MUTE;
+	else
+		value &= ~PCM1796_MUTE;
 	for (i = 0; i < data->dacs; ++i)
 		pcm1796_write_cached(chip, i, 18, value);
 }
@@ -777,6 +807,50 @@ static const struct snd_kcontrol_new rolloff_control = {
 	.put = rolloff_put,
 };
 
+static int deemph_get(struct snd_kcontrol *ctl,
+		       struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct xonar_pcm179x *data = chip->model_data;
+
+	value->value.integer.value[0] =
+		(data->pcm1796_regs[0][18 - PCM1796_REG_BASE] &
+		 PCM1796_DME) != PCM1796_DMF_DISABLED;
+	return 0;
+}
+
+static int deemph_put(struct snd_kcontrol *ctl,
+		       struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct xonar_pcm179x *data = chip->model_data;
+	unsigned int i;
+	int changed;
+	u8 reg;
+
+	mutex_lock(&chip->mutex);
+	reg = data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
+	if (!value->value.integer.value[0])
+		reg &= ~PCM1796_DME;
+	else
+		reg |= PCM1796_DME;
+	changed = reg != data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
+	if (changed) {
+		for (i = 0; i < data->dacs; ++i)
+			pcm1796_write(chip, i, 18, reg);
+	}
+	mutex_unlock(&chip->mutex);
+	return changed;
+}
+
+static const struct snd_kcontrol_new deemph_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "De-emphasis Switch",
+	.info = snd_ctl_boolean_mono_info,
+	.get = deemph_get,
+	.put = deemph_put,
+};
+
 static const struct snd_kcontrol_new hdav_hdmi_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "HDMI Playback Switch",
@@ -1011,6 +1085,10 @@ static int add_pcm1796_controls(struct oxygen *chip)
 				  snd_ctl_new1(&rolloff_control, chip));
 		if (err < 0)
 			return err;
+		err = snd_ctl_add(chip->card,
+				  snd_ctl_new1(&deemph_control, chip));
+		if (err < 0)
+			return err;
 	}
 	return 0;
 }
-- 
2.20.0
