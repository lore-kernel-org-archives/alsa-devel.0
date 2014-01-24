From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 14/19] ALSA: Oxygen: Modify playback output
	select
Date: Fri, 24 Jan 2014 16:18:15 +0400
Message-ID: <1390565900-3337-14-git-send-email-v1ron@mail.ru>
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

Change the order of elements in the output select control. This will
reduce the number of relay switches. Change 'put' function to call the
oxygen_update_dac_routing() function. Otherwise multichannel playback
does not work. Also there is a new function to apply settings, this
prevents from duplicating the code.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.c       |    2 +-
 sound/pci/oxygen/xonar_dg.h       |    3 +-
 sound/pci/oxygen/xonar_dg_mixer.c |   76 ++++++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.c b/sound/pci/oxygen/xonar_dg.c
index d0ca6c2..f504f4f 100644
--- a/sound/pci/oxygen/xonar_dg.c
+++ b/sound/pci/oxygen/xonar_dg.c
@@ -277,7 +277,7 @@ unsigned int adjust_dg_dac_routing(struct oxygen *chip,
 	struct dg *data = chip->model_data;
 	unsigned int routing = 0;
 
-	switch (data->pcm_output) {
+	switch (data->output_sel) {
 	case PLAYBACK_DST_HP:
 	case PLAYBACK_DST_HP_FP:
 		oxygen_write8_masked(chip, OXYGEN_PLAY_ROUTING,
diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index 35c8ec7..c278809 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -27,8 +27,7 @@ struct dg {
 	/* The shadow copy of the CS4245 register space */
 	unsigned char cs4245_shadow[17];
 	/* Output select: headphone/speakers */
-	unsigned char pcm_output;
-	unsigned int output_sel;
+	unsigned char output_sel;
 	s8 input_vol[4][2];
 	unsigned int input_sel;
 	u8 hp_vol_att;
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index 7e9fc4a..1cc82a7 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -27,17 +27,47 @@
 #include "xonar_dg.h"
 #include "cs4245.h"
 
-static int output_switch_info(struct snd_kcontrol *ctl,
+/* Analog output select */
+
+static int output_select_apply(struct oxygen *chip)
+{
+	struct dg *data = chip->model_data;
+
+	data->cs4245_shadow[CS4245_SIGNAL_SEL] &=
+		~CS4245_A_OUT_SEL_MASK;
+	if (data->output_sel == PLAYBACK_DST_HP) {
+		/* Mute FP (aux output) amplifier, switch rear jack to CS4245 */
+		oxygen_set_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+	} else if (data->output_sel == PLAYBACK_DST_HP_FP) {
+		/*
+		 * Unmute FP amplifier, switch rear jack to CS4361,
+		 * I2S channels 2,3,4 should be inactive
+		 */
+		oxygen_clear_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+		data->cs4245_shadow[CS4245_SIGNAL_SEL] |= CS4245_A_OUT_SEL_DAC;
+	} else {
+		/*
+		 * 2.0, 4.0, 5.1: switch to CS4361, mute FP amp.,
+		 * and change playback routing
+		 */
+		oxygen_clear_bits8(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR);
+	}
+	return cs4245_write_spi(chip, CS4245_SIGNAL_SEL);
+}
+
+static int output_select_info(struct snd_kcontrol *ctl,
 			      struct snd_ctl_elem_info *info)
 {
 	static const char *const names[3] = {
-		"Speakers", "Headphones", "FP Headphones"
+		"Stereo Headphones",
+		"Stereo Headphones FP",
+		"Multichannel",
 	};
 
 	return snd_ctl_enum_info(info, 1, 3, names);
 }
 
-static int output_switch_get(struct snd_kcontrol *ctl,
+static int output_select_get(struct snd_kcontrol *ctl,
 			     struct snd_ctl_elem_value *value)
 {
 	struct oxygen *chip = ctl->private_data;
@@ -49,38 +79,24 @@ static int output_switch_get(struct snd_kcontrol *ctl,
 	return 0;
 }
 
-static int output_switch_put(struct snd_kcontrol *ctl,
+static int output_select_put(struct snd_kcontrol *ctl,
 			     struct snd_ctl_elem_value *value)
 {
 	struct oxygen *chip = ctl->private_data;
 	struct dg *data = chip->model_data;
-	u8 reg;
-	int changed;
-
-	if (value->value.enumerated.item[0] > 2)
-		return -EINVAL;
+	unsigned int new = value->value.enumerated.item[0];
+	int changed = 0;
+	int ret;
 
 	mutex_lock(&chip->mutex);
-	changed = value->value.enumerated.item[0] != data->output_sel;
-	if (changed) {
-		data->output_sel = value->value.enumerated.item[0];
-
-		reg = data->cs4245_shadow[CS4245_SIGNAL_SEL] &
-						~CS4245_A_OUT_SEL_MASK;
-		reg |= data->output_sel == 2 ?
-				CS4245_A_OUT_SEL_DAC : CS4245_A_OUT_SEL_HIZ;
-		cs4245_write_cached(chip, CS4245_SIGNAL_SEL, reg);
-
-		cs4245_write_cached(chip, CS4245_DAC_A_CTRL,
-				    data->output_sel ? data->hp_vol_att : 0);
-		cs4245_write_cached(chip, CS4245_DAC_B_CTRL,
-				    data->output_sel ? data->hp_vol_att : 0);
-
-		oxygen_write16_masked(chip, OXYGEN_GPIO_DATA,
-				      data->output_sel == 1 ? GPIO_HP_REAR : 0,
-				      GPIO_HP_REAR);
+	if (data->output_sel != new) {
+		data->output_sel = new;
+		ret = output_select_apply(chip);
+		changed = ret >= 0 ? 1 : ret;
+		oxygen_update_dac_routing(chip);
 	}
 	mutex_unlock(&chip->mutex);
+
 	return changed;
 }
 
@@ -301,9 +317,9 @@ static const struct snd_kcontrol_new dg_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Analog Output Playback Enum",
-		.info = output_switch_info,
-		.get = output_switch_get,
-		.put = output_switch_put,
+		.info = output_select_info,
+		.get = output_select_get,
+		.put = output_select_put,
 	},
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-- 
1.7.10.4
