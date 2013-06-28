From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: Replace the magic number 44 with
	const
Date: Fri, 28 Jun 2013 12:23:18 +0200
Message-ID: <1372414998-7618-2-git-send-email-tiwai@suse.de>
References: <1372414998-7618-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E00D82656A9
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 12:22:27 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B0E0CA535B
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2013 12:22:27 +0200 (CEST)
In-Reply-To: <1372414998-7618-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The char arrays with size 44 are for the name string of
snd_ctl_elem_id.  Define the constant and replace the raw numbers with
it for clarifying better.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/asound.h  |  2 ++
 sound/pci/ac97/ac97_codec.c  |  2 +-
 sound/pci/asihpi/asihpi.c    |  2 +-
 sound/pci/hda/hda_generic.c  | 12 ++++++------
 sound/pci/hda/hda_jack.c     |  2 +-
 sound/pci/hda/patch_ca0132.c |  8 ++++----
 6 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index e3983d5..041203f 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -817,6 +817,8 @@ typedef int __bitwise snd_ctl_elem_iface_t;
 #define SNDRV_CTL_POWER_D3hot		(SNDRV_CTL_POWER_D3|0x0000)	/* Off, with power */
 #define SNDRV_CTL_POWER_D3cold		(SNDRV_CTL_POWER_D3|0x0001)	/* Off, without power */
 
+#define SNDRV_CTL_ELEM_ID_NAME_MAXLEN	44
+
 struct snd_ctl_elem_id {
 	unsigned int numid;		/* numeric identifier, zero = invalid */
 	snd_ctl_elem_iface_t iface;	/* interface identifier */
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index d37c683..445ca48 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1296,7 +1296,7 @@ static int snd_ac97_cmix_new_stereo(struct snd_card *card, const char *pfx,
 				    struct snd_ac97 *ac97)
 {
 	int err;
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	unsigned char lo_max, hi_max;
 
 	if (! snd_ac97_valid_reg(ac97, reg))
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index fbc1720..185d54a 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1278,7 +1278,7 @@ struct hpi_control {
 	u16 dst_node_type;
 	u16 dst_node_index;
 	u16 band;
-	char name[44]; /* copied to snd_ctl_elem_id.name[44]; */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* copied to snd_ctl_elem_id.name[44]; */
 };
 
 static const char * const asihpi_tuner_band_names[] = {
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 6460fc5..8e77cbb 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -854,7 +854,7 @@ static int add_control_with_pfx(struct hda_gen_spec *spec, int type,
 				const char *pfx, const char *dir,
 				const char *sfx, int cidx, unsigned long val)
 {
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	snprintf(name, sizeof(name), "%s %s %s", pfx, dir, sfx);
 	if (!add_control(spec, type, name, cidx, val))
 		return -ENOMEM;
@@ -1931,7 +1931,7 @@ static int create_extra_outs(struct hda_codec *codec, int num_pins,
 
 	for (i = 0; i < num_pins; i++) {
 		const char *name;
-		char tmp[44];
+		char tmp[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 		int err, idx = 0;
 
 		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker"))
@@ -2484,7 +2484,7 @@ static int create_out_jack_modes(struct hda_codec *codec, int num_pins,
 		}
 		if (get_out_jack_num_items(codec, pin) > 1) {
 			struct snd_kcontrol_new *knew;
-			char name[44];
+			char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 			get_jack_mode_name(codec, pin, name, sizeof(name));
 			knew = snd_hda_gen_add_kctl(spec, name,
 						    &out_jack_mode_enum);
@@ -2616,7 +2616,7 @@ static int create_in_jack_mode(struct hda_codec *codec, hda_nid_t pin)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct snd_kcontrol_new *knew;
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	unsigned int defcfg;
 
 	if (pin == spec->hp_mic_pin)
@@ -3316,7 +3316,7 @@ static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
 			      bool inv_dmic)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	char tmpname[44];
+	char tmpname[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = is_switch ? HDA_CTL_WIDGET_MUTE : HDA_CTL_WIDGET_VOL;
 	const char *sfx = is_switch ? "Switch" : "Volume";
 	unsigned int chs = inv_dmic ? 1 : 3;
@@ -3578,7 +3578,7 @@ static int parse_mic_boost(struct hda_codec *codec)
 		struct nid_path *path;
 		unsigned int val;
 		int idx;
-		char boost_label[44];
+		char boost_label[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 
 		idx = imux->items[i].index;
 		if (idx >= imux->num_items)
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 9e0a952..3fd2973 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -398,7 +398,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 			 const char *base_name)
 {
 	unsigned int def_conf, conn;
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int idx, err;
 	bool phantom_jack;
 
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 90ff7a3..6e9876f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -139,7 +139,7 @@ enum {
 #define DSP_SPEAKER_OUT_LATENCY         7
 
 struct ct_effect {
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	hda_nid_t nid;
 	int mid; /*effect module ID*/
 	int reqs[EFFECT_VALS_MAX_COUNT]; /*effect module request*/
@@ -270,7 +270,7 @@ enum {
 };
 
 struct ct_tuning_ctl {
-	char name[44];
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	hda_nid_t parent_nid;
 	hda_nid_t nid;
 	int mid; /*effect module ID*/
@@ -3103,7 +3103,7 @@ static int add_tuning_control(struct hda_codec *codec,
 				hda_nid_t pnid, hda_nid_t nid,
 				const char *name, int dir)
 {
-	char namestr[44];
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_VOLUME_MONO(namestr, nid, 1, 0, type);
@@ -3935,7 +3935,7 @@ static int ca0132_volume_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 static int add_fx_switch(struct hda_codec *codec, hda_nid_t nid,
 			 const char *pfx, int dir)
 {
-	char namestr[44];
+	char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		CA0132_CODEC_MUTE_MONO(namestr, nid, 1, type);
-- 
1.8.3.1
