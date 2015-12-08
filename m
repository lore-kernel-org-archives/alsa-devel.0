From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 01/13] ASoC: wm_adsp: Fixup some minor
	formatting and checkpatch errors
Date: Tue, 8 Dec 2015 16:08:25 +0000
Message-ID: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 263D7260440
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 27 +++++++++++++--------------
 sound/soc/codecs/wm_adsp.h |  4 ++--
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 905ae99..3808190 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -544,10 +544,10 @@ static void wm_adsp2_show_fw_status(struct wm_adsp *dsp)
 		 be16_to_cpu(scratch[3]));
 }
 
-static int wm_coeff_info(struct snd_kcontrol *kcontrol,
+static int wm_coeff_info(struct snd_kcontrol *kctl,
 			 struct snd_ctl_elem_info *uinfo)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
 	uinfo->count = ctl->len;
@@ -593,10 +593,10 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 	return 0;
 }
 
-static int wm_coeff_put(struct snd_kcontrol *kcontrol,
+static int wm_coeff_put(struct snd_kcontrol *kctl,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
 
 	memcpy(ctl->cache, p, ctl->len);
@@ -647,10 +647,10 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	return 0;
 }
 
-static int wm_coeff_get(struct snd_kcontrol *kcontrol,
+static int wm_coeff_get(struct snd_kcontrol *kctl,
 			struct snd_ctl_elem_value *ucontrol)
 {
-	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kcontrol->private_value;
+	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
@@ -829,8 +829,7 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		break;
 	}
 
-	list_for_each_entry(ctl, &dsp->ctl_list,
-			    list) {
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
 		if (!strcmp(ctl->name, name)) {
 			if (!ctl->enabled)
 				ctl->enabled = 1;
@@ -1109,7 +1108,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		goto out_fw;
 	}
 
-	header = (void*)&firmware->data[0];
+	header = (void *)&firmware->data[0];
 
 	if (memcmp(&header->magic[0], "WMFW", 4) != 0) {
 		adsp_err(dsp, "%s: invalid magic\n", file);
@@ -1189,7 +1188,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		offset = le32_to_cpu(region->offset) & 0xffffff;
 		type = be32_to_cpu(region->type) & 0xff;
 		mem = wm_adsp_find_region(dsp, type);
-		
+
 		switch (type) {
 		case WMFW_NAME_TEXT:
 			region_name = "Firmware name";
@@ -1646,7 +1645,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		goto out_fw;
 	}
 
-	hdr = (void*)&firmware->data[0];
+	hdr = (void *)&firmware->data[0];
 	if (memcmp(hdr->magic, "WMDR", 4) != 0) {
 		adsp_err(dsp, "%s: invalid magic\n", file);
 		goto out_fw;
@@ -1672,7 +1671,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 	blocks = 0;
 	while (pos < firmware->size &&
 	       pos - firmware->size > sizeof(*blk)) {
-		blk = (void*)(&firmware->data[pos]);
+		blk = (void *)(&firmware->data[pos]);
 
 		type = le16_to_cpu(blk->type);
 		offset = le16_to_cpu(blk->offset);
@@ -1816,7 +1815,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	struct wm_adsp_alg_region *alg_region;
 	struct wm_coeff_ctl *ctl;
 	int ret;
-	int val;
+	unsigned int val;
 
 	dsp->card = codec->component.card;
 
@@ -1829,7 +1828,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		 * For simplicity set the DSP clock rate to be the
 		 * SYSCLK rate rather than making it configurable.
 		 */
-		if(dsp->sysclk_reg) {
+		if (dsp->sysclk_reg) {
 			ret = regmap_read(dsp->regmap, dsp->sysclk_reg, &val);
 			if (ret != 0) {
 				adsp_err(dsp, "Failed to read SYSCLK state: %d\n",
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 2d117cf..89b7d71 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -45,8 +45,8 @@ struct wm_adsp {
 
 	struct list_head alg_regions;
 
-	int fw_id;
-	int fw_id_version;
+	unsigned int fw_id;
+	unsigned int fw_id_version;
 
 	const struct wm_adsp_region *mem;
 	int num_mems;
-- 
2.1.4
