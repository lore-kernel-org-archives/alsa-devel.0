From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v3 16/16] ALSA: Oxygen: The new mixer
	implementation
Date: Fri, 17 Jan 2014 19:08:35 +0400
Message-ID: <1389971315-3215-16-git-send-email-v1ron@mail.ru>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
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

The mixer changed. In the new implementation, the headphone
volume changes instead of having the 'impedance control'.
This allows to use headphones without builtin volume control
and without software volume control. Four input sources with
independent mute and volume controls, but only one source can
be selected.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/Makefile         |    2 +-
 sound/pci/oxygen/xonar_dg_mixer.c |  483 +++++++++++++++++++++++++++++++++++++
 2 files changed, 484 insertions(+), 1 deletion(-)
 create mode 100644 sound/pci/oxygen/xonar_dg_mixer.c

diff --git a/sound/pci/oxygen/Makefile b/sound/pci/oxygen/Makefile
index 0f87265..8f4c409 100644
--- a/sound/pci/oxygen/Makefile
+++ b/sound/pci/oxygen/Makefile
@@ -1,5 +1,5 @@
 snd-oxygen-lib-objs := oxygen_io.o oxygen_lib.o oxygen_mixer.o oxygen_pcm.o
-snd-oxygen-objs := oxygen.o xonar_dg.o
+snd-oxygen-objs := oxygen.o xonar_dg_mixer.o xonar_dg.o
 snd-virtuoso-objs := virtuoso.o xonar_lib.o \
 	xonar_pcm179x.o xonar_cs43xx.o xonar_wm87x6.o xonar_hdmi.o
 
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
new file mode 100644
index 0000000..39a0da7
--- /dev/null
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -0,0 +1,483 @@
+/*
+ * Mixer controls for the Xonar DG/DGX
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) Roman Volkov <v1ron@mail.ru>
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License, version 2.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * It is not good that we do not have software volume control
+ * as the Windows driver does. CS4361 cannot attenuate the volume.
+ * When we are switching from headphones to the speakers,
+ * which are controlled by the simple DAC CS4361, our headphones
+ * in the rear jack can stun us.
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/tlv.h>
+#include "oxygen.h"
+#include "xonar_dg.h"
+#include "cs4245.h"
+
+/* CS4245 Headphone Channels A&B Volume Control */
+static int xonar_dg_dac_stereo_volume_info(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_info *info)
+{
+	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	info->count = 2;
+	info->value.integer.min = 0;
+	info->value.integer.max = 255;
+	return 0;
+}
+
+static int xonar_dg_dac_stereo_volume_get(struct snd_kcontrol *ctl,
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
+}
+
+static int xonar_dg_dac_stereo_volume_put(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	if ((val->value.integer.value[0] > 255) ||
+		(val->value.integer.value[0] < 0) ||
+		(val->value.integer.value[1] > 255) ||
+		(val->value.integer.value[1] < 0)) {
+		return -EINVAL;
+	}
+	mutex_lock(&chip->mutex);
+	data->cs4245_shadow[CS4245_DAC_A_CTRL] = ~val->value.integer.value[0];
+	data->cs4245_shadow[CS4245_DAC_B_CTRL] = ~val->value.integer.value[1];
+	cs4245_write_spi(chip, CS4245_DAC_A_CTRL);
+	cs4245_write_spi(chip, CS4245_DAC_B_CTRL);
+	mutex_unlock(&chip->mutex);
+	return 0;
+}
+
+/* CS4245 DAC Mute */
+static int xonar_dg_dac_mute_get(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = ((data->cs4245_shadow[CS4245_DAC_CTRL_1]
+		& CS4245_MUTE_DAC) == 0);
+	mutex_unlock(&chip->mutex);
+	return 0;
+}
+
+static int xonar_dg_dac_mute_put(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	if (val->value.integer.value[0] > 1)
+		return -EINVAL;
+	mutex_lock(&chip->mutex);
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] &= ~CS4245_MUTE_DAC;
+	data->cs4245_shadow[CS4245_DAC_CTRL_1] |=
+		(~val->value.integer.value[0] << 2) & CS4245_MUTE_DAC;
+	cs4245_write_spi(chip, CS4245_DAC_CTRL_1);
+	mutex_unlock(&chip->mutex);
+	return 0;
+}
+
+/* Xonar DG Output Select */
+static int xonar_dg_pcm_route_apply(struct oxygen *chip)
+{
+	struct dg *data = chip->model_data;
+
+	data->cs4245_shadow[CS4245_SIGNAL_SEL] &=
+		~CS4245_A_OUT_SEL_MASK;
+	if (data->pcm_output == PLAYBACK_DST_HP) {
+		/* Mute FP (aux output) amplifier, switch rear jack to CS4245 */
+		oxygen_set_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+	} else if (data->pcm_output == PLAYBACK_DST_HP_FP) {
+		/*
+		 * Unmute FP amplifier, switch rear jack to CS4361,
+		 * I2S ports 2,3,4 should be inactive
+		 */
+		oxygen_clear_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+		data->cs4245_shadow[CS4245_SIGNAL_SEL] |= CS4245_A_OUT_SEL_DAC;
+	} else {
+		/*
+		 * 2.0, 4.0, 5.1: switch to CS4361, mute FP amp.,
+		 * and change playback routing / DMA channels
+		 */
+		oxygen_clear_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+	}
+	cs4245_write_spi(chip, CS4245_SIGNAL_SEL);
+	return 0;
+}
+
+static int xonar_dg_pcm_route_info(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_info *info)
+{
+	static const char *const names[3] = {
+		"Stereo Headphones",
+		"Stereo Headphones FP",
+		"Multichannel",
+	};
+
+	return snd_ctl_enum_info(info, 1, 3, names);
+}
+
+static int xonar_dg_pcm_route_get(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = data->pcm_output;
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+}
+
+static int xonar_dg_pcm_route_put(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+	int ret;
+
+	mutex_lock(&chip->mutex);
+	data->pcm_output = val->value.integer.value[0];
+	ret = xonar_dg_pcm_route_apply(chip);
+	oxygen_update_dac_routing(chip);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+/* CS4245 PGA Source */
+static int xonar_dg_pga_mute_reg_toggle(struct oxygen *chip, bool mute);
+static int xonar_dg_pga_volume_reg_write(struct oxygen *chip, char left,
+	char right);
+
+static int xonar_dg_pga_source_apply(struct oxygen *chip)
+{
+	struct dg *data = chip->model_data;
+
+	data->cs4245_shadow[CS4245_ANALOG_IN] &= ~CS4245_SEL_MASK;
+	if (data->pga_source == CAPTURE_SRC_FP_MIC)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_2;
+	else if (data->pga_source == CAPTURE_SRC_LINE)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_4;
+	else if (data->pga_source != CAPTURE_SRC_MIC)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_1;
+	oxygen_set_bits16(chip, OXYGEN_GPIO_DATA, GPIO_INPUT_ROUTE);
+	return cs4245_write_spi(chip, CS4245_ANALOG_IN);
+}
+
+static int xonar_dg_pga_source_info(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_info *info)
+{
+	static const char *const ps_names[4] = {
+		"Microphone",
+		"Microphone FP",
+		"Line In",
+		"Aux"
+	};
+
+	return snd_ctl_enum_info(info, 1, 4, ps_names);
+}
+
+static int xonar_dg_pga_source_get(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = data->pga_source;
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+}
+
+/* Switch the source and change volume/mute */
+static int xonar_dg_pga_source_put(struct snd_kcontrol *ctl,
+			struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+	long route = val->value.integer.value[0];
+	int ret;
+
+	if ((route > CAPTURE_SRC_AUX) || (route < 0))
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+	data->pga_source = route;
+	ret = xonar_dg_pga_source_apply(chip);
+	if (ret < 0)
+		goto err;
+	ret = xonar_dg_pga_mute_reg_toggle(chip, data->cap_mute[route]);
+	if (ret < 0)
+		goto err;
+	ret = xonar_dg_pga_volume_reg_write(chip,
+		data->cap_vol[route][0],
+		data->cap_vol[route][1]);
+	if (ret < 0)
+		goto err;
+err:
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+/* Common routines to access capture volume register - Mic, Line, Aux */
+static int xonar_dg_pga_volume_reg_write(struct oxygen *chip, char left,
+							char right)
+{
+	struct dg *data = chip->model_data;
+	int ret;
+
+	data->cs4245_shadow[CS4245_PGA_A_CTRL] = left;
+	data->cs4245_shadow[CS4245_PGA_B_CTRL] = right;
+	ret = cs4245_write_spi(chip, CS4245_PGA_A_CTRL);
+	if (ret < 0)
+		return ret;
+	return cs4245_write_spi(chip, CS4245_PGA_B_CTRL);
+}
+
+static int xonar_dg_pga_volume_info(struct snd_kcontrol *ctl,
+	struct snd_ctl_elem_info *info)
+{
+	info->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	info->count = 2;
+	info->value.integer.min = -24;
+	info->value.integer.max = 24;
+	return 0;
+}
+
+static int xonar_dg_pga_volume_get(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = data->cap_vol[ctl->private_value][0];
+	val->value.integer.value[1] = data->cap_vol[ctl->private_value][1];
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+}
+
+static int xonar_dg_pga_volume_put(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+	long left = val->value.integer.value[0];
+	long right = val->value.integer.value[1];
+	int ret = 0;
+
+	if ((left > 24) || (left < -24) || (right > 24) || (right < -24))
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+	data->cap_vol[ctl->private_value][0] = left;
+	data->cap_vol[ctl->private_value][1] = right;
+	ret = xonar_dg_pga_volume_reg_write(chip,
+		data->cap_vol[data->pga_source][0],
+		data->cap_vol[data->pga_source][1]);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+/* Common routines to access capture mute register - Mic, Line, Aux */
+static int xonar_dg_pga_mute_reg_toggle(struct oxygen *chip, bool mute)
+{
+	struct dg *data = chip->model_data;
+
+	data->cs4245_shadow[CS4245_ADC_CTRL] &= ~CS4245_MUTE_ADC;
+	data->cs4245_shadow[CS4245_ADC_CTRL] |= ((mute == 0) << 2) &
+		CS4245_MUTE_ADC;
+	return cs4245_write_spi(chip, CS4245_ADC_CTRL);
+}
+
+static int xonar_dg_pga_mute_get(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+
+	mutex_lock(&chip->mutex);
+	val->value.integer.value[0] = (long)data->cap_mute[ctl->private_value];
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+}
+
+static int xonar_dg_pga_mute_put(struct snd_kcontrol *ctl,
+				struct snd_ctl_elem_value *val)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct dg *data = chip->model_data;
+	long tmp = val->value.integer.value[0];
+	int ret = 0;
+
+	if ((tmp > 1) || (tmp < 0))
+		return -EINVAL;
+
+	mutex_lock(&chip->mutex);
+	data->cap_mute[ctl->private_value] = tmp != 0;
+	ret = xonar_dg_pga_mute_reg_toggle(chip,
+		data->cap_mute[data->pga_source]);
+	mutex_unlock(&chip->mutex);
+
+	return ret;
+}
+
+#define CAPTURE_VOLUME(xname, private) { \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
+		.info = xonar_dg_pga_volume_info, \
+		.get = xonar_dg_pga_volume_get, \
+		.put = xonar_dg_pga_volume_put, \
+		.tlv = { .p = xonar_dg_pga_db_scale, }, \
+		.private_value = private, \
+	}
+#define CAPTURE_SWITCH(xname, private) { \
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+		.name = xname, \
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+		.info = snd_ctl_boolean_mono_info, \
+		.get = xonar_dg_pga_mute_get, \
+		.put = xonar_dg_pga_mute_put, \
+		.private_value = private, \
+	}
+
+static const DECLARE_TLV_DB_MINMAX(xonar_dg_hp_db_scale, -12550, 0);
+static const DECLARE_TLV_DB_MINMAX(xonar_dg_pga_db_scale, -1200, 1200);
+static const struct snd_kcontrol_new xonar_dg_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Headphone Playback Volume",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_TLV_READ,
+		.info = xonar_dg_dac_stereo_volume_info,
+		.get = xonar_dg_dac_stereo_volume_get,
+		.put = xonar_dg_dac_stereo_volume_put,
+		.tlv = { .p = xonar_dg_hp_db_scale, },
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Headphone Playback Switch",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = snd_ctl_boolean_mono_info,
+		.get = xonar_dg_dac_mute_get,
+		.put = xonar_dg_dac_mute_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Output Playback Enum",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = xonar_dg_pcm_route_info,
+		.get = xonar_dg_pcm_route_get,
+		.put = xonar_dg_pcm_route_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Capture Enum",
+		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.info = xonar_dg_pga_source_info,
+		.get = xonar_dg_pga_source_get,
+		.put = xonar_dg_pga_source_put,
+	},
+	CAPTURE_VOLUME("Mic Capture Volume", CAPTURE_SRC_MIC),
+	CAPTURE_SWITCH("Mic Capture Switch", CAPTURE_SRC_MIC),
+	CAPTURE_VOLUME("FP Mic Capture Volume", CAPTURE_SRC_FP_MIC),
+	CAPTURE_SWITCH("FP Mic Capture Switch", CAPTURE_SRC_FP_MIC),
+	CAPTURE_VOLUME("Line Capture Volume", CAPTURE_SRC_LINE),
+	CAPTURE_SWITCH("Line Capture Switch", CAPTURE_SRC_LINE),
+	CAPTURE_VOLUME("Aux Capture Volume", CAPTURE_SRC_AUX),
+	CAPTURE_SWITCH("Aux Capture Switch", CAPTURE_SRC_AUX),
+};
+
+int xonar_dg_mixer_init(struct oxygen *chip)
+{
+	unsigned int i;
+	int ret;
+	for (i = 0; i < ARRAY_SIZE(xonar_dg_controls); i++) {
+		ret = snd_ctl_add(chip->card,
+			snd_ctl_new1(&xonar_dg_controls[i], chip));
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+/* Disable built-in volume control, we have only headphone volume */
+static int xonar_control_filter(struct snd_kcontrol_new *template)
+{
+	if (!strncmp(template->name, "Master Playback ", 16))
+		return 1;
+	return 0;
+}
+
+struct oxygen_model model_xonar_dg = {
+	.longname = "C-Media Oxygen HD Audio",
+	.chip = "CMI8786",
+	.init = dg_init,
+	.control_filter = xonar_control_filter,
+	.mixer_init = xonar_dg_mixer_init,
+	.cleanup = dg_cleanup,
+	.suspend = dg_suspend,
+	.resume = dg_resume,
+	.set_dac_params = set_cs4245_dac_params,
+	.set_adc_params = set_cs4245_adc_params,
+	.adjust_dac_routing = adjust_dg_dac_routing,
+	.dump_registers = dump_cs4245_registers,
+	.model_data_size = sizeof(struct dg),
+	.device_config = PLAYBACK_0_TO_I2S |
+			 PLAYBACK_1_TO_SPDIF |
+			 CAPTURE_0_FROM_I2S_1 |
+			 CAPTURE_1_FROM_SPDIF,
+	.dac_channels_pcm = 6,
+	.dac_channels_mixer = 0,
+	.function_flags = OXYGEN_FUNCTION_SPI,
+	.dac_mclks = OXYGEN_MCLKS(256, 128, 128),
+	.adc_mclks = OXYGEN_MCLKS(256, 128, 128),
+	.dac_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
+	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
+};
-- 
1.7.10.4
