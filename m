From: tom.ty89@gmail.com
Subject: [PATCH 1/1] ALSA: virtuoso: add de-emphasis control
Date: Mon, 17 Dec 2018 01:51:10 +0800
Message-ID: <5c16909a.1c69fb81.2150c.9583@mx.google.com>
References: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
Reply-To: clemens@ladisch.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <6b7d5f70-5e5a-59b4-9daf-315937a49639@ladisch.de>
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
index 24109d37ca09..429411d10e08 100644
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
@@ -621,6 +621,23 @@ static void update_pcm1796_oversampling(struct oxygen *chip)
 		pcm1796_write_cached(chip, i, 20, reg);
 }
 
+static void update_pcm1796_deemph(struct oxygen *chip)
+{
+	struct xonar_pcm179x *data = chip->model_data;
+	unsigned int i;
+	u8 reg;
+
+	reg = data->pcm1796_regs[0][18 - PCM1796_REG_BASE] & ~PCM1796_DMF_MASK;
+	if (data->current_rate == 48000)
+		reg |= PCM1796_DMF_48;
+	else if (data->current_rate == 44100)
+		reg |= PCM1796_DMF_441;
+	else if (data->current_rate == 32000)
+		reg |= PCM1796_DMF_32;
+	for (i = 0; i < data->dacs; ++i)
+		pcm1796_write_cached(chip, i, 18, reg);
+}
+
 static void set_pcm1796_params(struct oxygen *chip,
 			       struct snd_pcm_hw_params *params)
 {
@@ -629,6 +646,7 @@ static void set_pcm1796_params(struct oxygen *chip,
 	msleep(1);
 	data->current_rate = params_rate(params);
 	update_pcm1796_oversampling(chip);
+	update_pcm1796_deemph(chip);
 }
 
 static void update_pcm1796_volume(struct oxygen *chip)
@@ -653,9 +671,11 @@ static void update_pcm1796_mute(struct oxygen *chip)
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
@@ -777,6 +797,50 @@ static const struct snd_kcontrol_new rolloff_control = {
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
+	.name = "De-emphasis Playback Switch",
+	.info = snd_ctl_boolean_mono_info,
+	.get = deemph_get,
+	.put = deemph_put,
+};
+
 static const struct snd_kcontrol_new hdav_hdmi_control = {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 	.name = "HDMI Playback Switch",
@@ -1011,6 +1075,10 @@ static int add_pcm1796_controls(struct oxygen *chip)
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
