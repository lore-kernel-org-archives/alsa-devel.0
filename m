From: Roman Volkov <v1ron@mail.ru>
Subject: [PATCH v4 16/19] ALSA: Oxygen: Modify capture volume
	functions
Date: Fri, 24 Jan 2014 16:18:17 +0400
Message-ID: <1390565900-3337-16-git-send-email-v1ron@mail.ru>
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

Modify the input_vol_* functions to use the new SPI routines,
There is a new applying function that will be called when
the capture source changed.

Signed-off-by: Roman Volkov <v1ron@mail.ru>
---
 sound/pci/oxygen/xonar_dg.h       |    3 ++-
 sound/pci/oxygen/xonar_dg_mixer.c |   32 +++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/sound/pci/oxygen/xonar_dg.h b/sound/pci/oxygen/xonar_dg.h
index c278809..eb16592 100644
--- a/sound/pci/oxygen/xonar_dg.h
+++ b/sound/pci/oxygen/xonar_dg.h
@@ -28,7 +28,8 @@ struct dg {
 	unsigned char cs4245_shadow[17];
 	/* Output select: headphone/speakers */
 	unsigned char output_sel;
-	s8 input_vol[4][2];
+	/* The volumes for all capture sources */
+	char input_vol[4][2];
 	unsigned int input_sel;
 	u8 hp_vol_att;
 };
diff --git a/sound/pci/oxygen/xonar_dg_mixer.c b/sound/pci/oxygen/xonar_dg_mixer.c
index 56e0db1..c23cdde 100644
--- a/sound/pci/oxygen/xonar_dg_mixer.c
+++ b/sound/pci/oxygen/xonar_dg_mixer.c
@@ -191,6 +191,22 @@ static int hp_mute_put(struct snd_kcontrol *ctl,
 	return changed;
 }
 
+/* Capture volume for all sources */
+
+static int input_volume_apply(struct oxygen *chip, char left,
+				char right)
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
 static int input_vol_info(struct snd_kcontrol *ctl,
 			  struct snd_ctl_elem_info *info)
 {
@@ -222,6 +238,7 @@ static int input_vol_put(struct snd_kcontrol *ctl,
 	struct dg *data = chip->model_data;
 	unsigned int idx = ctl->private_value;
 	int changed = 0;
+	int ret = 0;
 
 	if (value->value.integer.value[0] < 2 * -12 ||
 	    value->value.integer.value[0] > 2 * 12 ||
@@ -235,18 +252,16 @@ static int input_vol_put(struct snd_kcontrol *ctl,
 		data->input_vol[idx][0] = value->value.integer.value[0];
 		data->input_vol[idx][1] = value->value.integer.value[1];
 		if (idx == data->input_sel) {
-			cs4245_write_cached(chip, CS4245_PGA_A_CTRL,
-					    data->input_vol[idx][0]);
-			cs4245_write_cached(chip, CS4245_PGA_B_CTRL,
-					    data->input_vol[idx][1]);
+			ret = input_volume_apply(chip,
+				data->input_vol[idx][0],
+				data->input_vol[idx][1]);
 		}
+		changed = ret >= 0 ? 1 : ret;
 	}
 	mutex_unlock(&chip->mutex);
 	return changed;
 }
 
-static DECLARE_TLV_DB_SCALE(cs4245_pga_db_scale, -1200, 50, 0);
-
 static int input_sel_info(struct snd_kcontrol *ctl,
 			  struct snd_ctl_elem_info *info)
 {
@@ -346,13 +361,16 @@ static int hpf_put(struct snd_kcontrol *ctl, struct snd_ctl_elem_value *value)
 #define INPUT_VOLUME(xname, index) { \
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
 	.name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
+		SNDRV_CTL_ELEM_ACCESS_TLV_READ, \
 	.info = input_vol_info, \
 	.get = input_vol_get, \
 	.put = input_vol_put, \
-	.tlv = { .p = cs4245_pga_db_scale }, \
+	.tlv = { .p = pga_db_scale }, \
 	.private_value = index, \
 }
 static const DECLARE_TLV_DB_MINMAX(hp_db_scale, -12550, 0);
+static const DECLARE_TLV_DB_MINMAX(pga_db_scale, -1200, 1200);
 static const struct snd_kcontrol_new dg_controls[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-- 
1.7.10.4
