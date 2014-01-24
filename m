From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 15/19] ALSA: Oxygen: Use headphone volume
	control
Date: Fri, 24 Jan 2014 16:18:16 +0400
Message-ID: <1390565900-3337-15-git-send-email-v1ron@mail.ru>
References: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1390565900-3337-1-git-send-email-v1ron@mail.ru>
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
Cc: alsa-devel@alsa-project.org, Roman Volkov <v1ron@mail.ru>
List-Id: alsa-devel@alsa-project.org

I tried both variants: volume control and impedance selector.
In the first case one minus is that we can't change the
volume of multichannel output without additional software
volume control. However, I am using this variant for the
last three months and this seems good. All multichannel
speaker systems have internal amplifier with the
volume control included, but not all headphones have
this regulator. In the second case, my software volume
control does not save the value after reboot.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg_mixer.c |  115 ++++++++++++++++++++++++++-----------
 1 file changed, 83 insertions(+), 32 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index 1cc82a7..56e0db1 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -100,54 +100,93 @@ static int output_select_put(struct snd_kcontrol *ctl,
 	return changed;
 }
 
-static int hp_volume_offset_info(struct snd_kcontrol *ctl,
-				 struct snd_ctl_elem_info *info)
+/* CS4245 Headphone Channels A&B Volume Control */
+
+static int hp_stereo_volume_info(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_info *info)
 {
-	static const char *const names[3] = {
-		"< 64 ohms", "64-150 ohms", "150-300 ohms"
-	};
+	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	info->count = 2;
+	info->value.integer.min = 0;
+	info->value.integer.max = 255;
+	return 0;
+}
 
-	return snd_ctl_enum_info(info, 1, 3, names);
+static int hp_stereo_volume_get(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+	unsigned int tmp;
+
+	mutex_lock(&chip->mutex);
+	tmp = (~data->cs4245_shadow[CS4245_DAC_A_CTRL]) & 255;
+	val->value.integer.value[0] = tmp;
+	tmp = (~data->cs4245_shadow[CS4245_DAC_B_CTRL]) & 255;
+	val->value.integer.value[1] = tmp;
+	mutex_unlock(&chip->mutex);
+	return 0;
 }
 
-static int hp_volume_offset_get(struct snd_kcontrol *ctl,
-				struct snd_ctl_elem_value *value)
+static int hp_stereo_volume_put(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
 {
 	struct oxygen *chip = ctl->private_data;
 	struct dg *data = chip->model_data;
+	int ret;
+	int changed = 0;
+	long new1 = val->value.integer.value[0];
+	long new2 = val->value.integer.value[1];
+
+	if ((new1 > 255) || (new1 < 0) || (new2 > 255) || (new2 < 0))
+		return -EINVAL;
 
 	mutex_lock(&chip->mutex);
-	if (data->hp_vol_att > 2 * 7)
-		value->value.enumerated.item[0] = 0;
-	else if (data->hp_vol_att > 0)
-		value->value.enumerated.item[0] = 1;
-	else
-		value->value.enumerated.item[0] = 2;
+	if ((data->cs4245_shadow[CS4245_DAC_A_CTRL] != ~new1) ||
+	   (data->cs4245_shadow[CS4245_DAC_B_CTRL] != ~new2)) {
+		data->cs4245_shadow[CS4245_DAC_A_CTRL] = ~new1;
+		data->cs4245_shadow[CS4245_DAC_B_CTRL] = ~new2;
+		ret = cs4245_write_spi(chip, CS4245_DAC_A_CTRL);
+		if (ret >= 0)
+			ret = cs4245_write_spi(chip, CS4245_DAC_B_CTRL);
+		changed = ret >= 0 ? 1 : ret;
+	}
+	mutex_unlock(&chip->mutex);
+
+	return changed;
+}
+
+/* Headphone Mute */
+
+static int hp_mute_get(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = ((data->cs4245_shadow[CS4245_DAC_CTRL_1]
+		& CS4245_MUTE_DAC) == 0);
 	mutex_unlock(&chip->mutex);
 	return 0;
 }
 
-static int hp_volume_offset_put(struct snd_kcontrol *ctl,
-				struct snd_ctl_elem_value *value)
+static int hp_mute_put(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
 {
-	static const s8 atts[3] = { 2 * 16, 2 * 7, 0 };
 	struct oxygen *chip = ctl->private_data;
 	struct dg *data = chip->model_data;
-	s8 att;
+	int ret;
 	int changed;
 
-	if (value->value.enumerated.item[0] > 2)
+	if (val->value.integer.value[0] > 1)
 		return -EINVAL;
-	att = atts[value->value.enumerated.item[0]];
 	mutex_lock(&chip->mutex);
-	changed = att != data->hp_vol_att;
-	if (changed) {
-		data->hp_vol_att = att;
-		if (data->output_sel) {
-			cs4245_write_cached(chip, CS4245_DAC_A_CTRL, att);
-			cs4245_write_cached(chip, CS4245_DAC_B_CTRL, att);
-		}
-	}
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] &= ~CS4245_MUTE_DAC;
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] |=
+		(~val->value.integer.value[0] << 2) & CS4245_MUTE_DAC;
+	ret = cs4245_write_spi(chip, CS4245_DAC_CTRL_1);
+	changed = ret >= 0 ? 1 : ret;
 	mutex_unlock(&chip->mutex);
 	return changed;
 }
@@ -313,6 +352,7 @@ static int hpf_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 	.tlv = { .p = cs4245_pga_db_scale }, \
 	.private_value = index, \
 }
+static const DECLARE_TLV_DB_MINMAX(hp_db_scale, -12550, 0);
 static const struct snd_kcontrol_new dg_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -323,10 +363,21 @@ static const struct snd_kcontrol_new dg_controls[] = {
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Headphones Impedance Playback Enum",
-		.info = hp_volume_offset_info,
-		.get = hp_volume_offset_get,
-		.put = hp_volume_offset_put,
+		.name = "Headphone Playback Volume",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = hp_stereo_volume_info,
+		.get = hp_stereo_volume_get,
+		.put = hp_stereo_volume_put,
+		.tlv = { .p = hp_db_scale, },
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Headphone Playback Switch",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_mono_info,
+		.get = hp_mute_get,
+		.put = hp_mute_put,
 	},
 	INPUT_VOLUME("Mic Capture Volume", 0),
 	INPUT_VOLUME("Aux Capture Volume", 1),
-- 
1.7.10.4
