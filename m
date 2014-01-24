From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 17/19] ALSA: Oxygen: Modify input select
	functions
Date: Fri, 24 Jan 2014 16:18:18 +0400
Message-ID: <1390565900-3337-17-git-send-email-v1ron@mail.ru>
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

First of all, we should not touch the GPIOs. They are not
for selecting the capture source, but they seems just enable
the whole audio input curcuit. The 'put' function calls the
'apply' functions to change register values. Change the order
of capture sources.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.h       |    3 ++-
 sound/pci/oxygen/xonar_dg_mixer.c |   52 ++++++++++++++++++++-----------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index eb16592..79192a5 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -30,7 +30,8 @@ struct dg {
 	unsigned char output_sel;
 	/* The volumes for all capture sources */
 	char input_vol[4][2];
-	unsigned int input_sel;
+	/* Input select: mic/fp mic/line/aux */
+	unsigned char input_sel;
 	u8 hp_vol_att;
 };
 
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index c23cdde..d6ececb 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -262,11 +262,27 @@ static int input_vol_put(struct snd_kcontrol *ctl,
 	return changed;
 }
 
+/* Capture Source */
+
+static int input_source_apply(struct oxygen *chip)
+{
+	struct dg *data = chip->model_data;
+
+	data->cs4245_shadow[CS4245_ANALOG_IN] &= ~CS4245_SEL_MASK;
+	if (data->input_sel == CAPTURE_SRC_FP_MIC)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_2;
+	else if (data->input_sel == CAPTURE_SRC_LINE)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_4;
+	else if (data->input_sel != CAPTURE_SRC_MIC)
+		data->cs4245_shadow[CS4245_ANALOG_IN] |= CS4245_SEL_INPUT_1;
+	return cs4245_write_spi(chip, CS4245_ANALOG_IN);
+}
+
 static int input_sel_info(struct snd_kcontrol *ctl,
 			  struct snd_ctl_elem_info *info)
 {
 	static const char *const names[4] = {
-		"Mic", "Aux", "Front Mic", "Line"
+		"Mic", "Front Mic", "Line", "Aux"
 	};
 
 	return snd_ctl_enum_info(info, 1, 4, names);
@@ -287,15 +303,10 @@ static int input_sel_get(struct snd_kcontrol *ctl,
 static int input_sel_put(struct snd_kcontrol *ctl,
 			 struct snd_ctl_elem_value *value)
 {
-	static const u8 sel_values[4] = {
-		CS4245_SEL_MIC,
-		CS4245_SEL_INPUT_1,
-		CS4245_SEL_INPUT_2,
-		CS4245_SEL_INPUT_4
-	};
 	struct oxygen *chip = ctl->private_data;
 	struct dg *data = chip->model_data;
 	int changed;
+	int ret;
 
 	if (value->value.enumerated.item[0] > 3)
 		return -EINVAL;
@@ -305,19 +316,12 @@ static int input_sel_put(struct snd_kcontrol *ctl,
 	if (changed) {
 		data->input_sel = value->value.enumerated.item[0];
 
-		cs4245_write(chip, CS4245_ANALOG_IN,
-			     (data->cs4245_shadow[CS4245_ANALOG_IN] &
-							~CS4245_SEL_MASK) |
-			     sel_values[data->input_sel]);
-
-		cs4245_write_cached(chip, CS4245_PGA_A_CTRL,
-				    data->input_vol[data->input_sel][0]);
-		cs4245_write_cached(chip, CS4245_PGA_B_CTRL,
-				    data->input_vol[data->input_sel][1]);
-
-		oxygen_write16_masked(chip, OXYGEN_GPIO_DATA,
-				      data->input_sel ? 0 : GPIO_INPUT_ROUTE,
-				      GPIO_INPUT_ROUTE);
+		ret = input_source_apply(chip);
+		if (ret >= 0)
+			ret = input_volume_apply(chip,
+				data->input_vol[data->input_sel][0],
+				data->input_vol[data->input_sel][1]);
+		changed = ret >= 0 ? 1 : ret;
 	}
 	mutex_unlock(&chip->mutex);
 	return changed;
@@ -397,10 +401,10 @@ static const struct snd_kcontrol_new dg_controls[] = {
 		.get = hp_mute_get,
 		.put = hp_mute_put,
 	},
-	INPUT_VOLUME("Mic Capture Volume", 0),
-	INPUT_VOLUME("Aux Capture Volume", 1),
-	INPUT_VOLUME("Front Mic Capture Volume", 2),
-	INPUT_VOLUME("Line Capture Volume", 3),
+	INPUT_VOLUME("Mic Capture Volume", CAPTURE_SRC_MIC),
+	INPUT_VOLUME("Front Mic Capture Volume", CAPTURE_SRC_FP_MIC),
+	INPUT_VOLUME("Line Capture Volume", CAPTURE_SRC_LINE),
+	INPUT_VOLUME("Aux Capture Volume", CAPTURE_SRC_AUX),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		.name = "Capture Source",
-- 
1.7.10.4
