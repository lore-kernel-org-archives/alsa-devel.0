From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 024/112] ALSA: hda/realtek - Add boost volumes
	to path list
Date: Tue,  8 Jan 2013 12:38:17 +0100
Message-ID: <1357645185-7645-25-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D253A2651A9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 60157A520C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Don't forget to take boost volumes into account in the managed path
list.  Since it's an additional volume, we need to extend the ctls[]
array.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 398b25b..eadf326d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -95,6 +95,13 @@ struct alc_multi_io {
 
 #define MAX_NID_PATH_DEPTH	5
 
+enum {
+	NID_PATH_VOL_CTL,
+	NID_PATH_MUTE_CTL,
+	NID_PATH_BOOST_CTL,
+	NID_PATH_NUM_CTLS
+};
+
 /* Widget connection path
  *
  * For output, stored in the order of DAC -> ... -> pin,
@@ -111,12 +118,10 @@ struct nid_path {
 	hda_nid_t path[MAX_NID_PATH_DEPTH];
 	unsigned char idx[MAX_NID_PATH_DEPTH];
 	unsigned char multi[MAX_NID_PATH_DEPTH];
-	unsigned int ctls[2]; /* 0 = volume, 1 = mute */
+	unsigned int ctls[NID_PATH_NUM_CTLS]; /* NID_PATH_XXX_CTL */
 	bool active;
 };
 
-enum { NID_PATH_VOL_CTL = 0, NID_PATH_MUTE_CTL = 1 };
-
 struct alc_spec {
 	struct hda_gen_spec gen;
 
@@ -3809,7 +3814,7 @@ static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
 		struct nid_path *p = snd_array_elem(&spec->paths, i);
 		if (p->depth <= 0)
 			continue;
-		for (type = 0; type < 2; type++) {
+		for (type = 0; type < NID_PATH_NUM_CTLS; type++) {
 			unsigned int val = p->ctls[type];
 			if (get_amp_nid_(val) == nid &&
 			    get_amp_direction_(val) == dir &&
@@ -4388,6 +4393,8 @@ static int alc_auto_add_mic_boost(struct hda_codec *codec)
 		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
 			const char *label;
 			char boost_label[32];
+			struct nid_path *path;
+			unsigned int val;
 
 			label = hda_get_autocfg_input_label(codec, cfg, i);
 			if (spec->shared_mic_hp && !strcmp(label, "Misc"))
@@ -4400,11 +4407,15 @@ static int alc_auto_add_mic_boost(struct hda_codec *codec)
 
 			snprintf(boost_label, sizeof(boost_label),
 				 "%s Boost Volume", label);
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
 			err = add_control(spec, ALC_CTL_WIDGET_VOL,
-					  boost_label, type_idx,
-				  HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT));
+					  boost_label, type_idx, val);
 			if (err < 0)
 				return err;
+
+			path = get_nid_path(codec, nid, 0);
+			if (path)
+				path->ctls[NID_PATH_BOOST_CTL] = val;
 		}
 	}
 	return 0;
-- 
1.8.0.1
