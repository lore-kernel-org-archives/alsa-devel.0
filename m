From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Look for boost controls more
	deeply
Date: Fri, 18 Jan 2013 11:24:03 +0100
Message-ID: <1358504643-13593-5-git-send-email-tiwai@suse.de>
References: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26D08265E90
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:05 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E5046A3E1C
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:04 +0100 (CET)
In-Reply-To: <1358504643-13593-1-git-send-email-tiwai@suse.de>
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

In the current generic parser code, we look for the (mic) boost
controls only on input pins.  But many codecs assign the boost volume
to a widget connected to each input pin instead of the input amp of
the pin itself.

In this patch, the parser tries to look through more widgets connected
to the pin and find a boost amp.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 101 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index edec98f..cadfe65 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3056,39 +3056,92 @@ static int create_capture_mixers(struct hda_codec *codec)
 /*
  * add mic boosts if needed
  */
+
+/* check whether the given amp is feasible as a boost volume */
+static bool check_boost_vol(struct hda_codec *codec, hda_nid_t nid,
+			    int dir, int idx)
+{
+	unsigned int step;
+
+	if (!nid_has_volume(codec, nid, dir) ||
+	    is_ctl_associated(codec, nid, dir, idx, NID_PATH_VOL_CTL) ||
+	    is_ctl_associated(codec, nid, dir, idx, NID_PATH_BOOST_CTL))
+		return false;
+
+	step = (query_amp_caps(codec, nid, dir) & AC_AMPCAP_STEP_SIZE)
+		>> AC_AMPCAP_STEP_SIZE_SHIFT;
+	if (step < 0x20)
+		return false;
+	return true;
+}
+
+/* look for a boost amp in a widget close to the pin */
+static unsigned int look_for_boost_amp(struct hda_codec *codec,
+				       struct nid_path *path)
+{
+	unsigned int val = 0;
+	hda_nid_t nid;
+	int depth;
+
+	for (depth = 0; depth < 3; depth++) {
+		if (depth >= path->depth - 1)
+			break;
+		nid = path->path[depth];
+		if (depth && check_boost_vol(codec, nid, HDA_OUTPUT, 0)) {
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+			break;
+		} else if (check_boost_vol(codec, nid, HDA_INPUT,
+					   path->idx[depth])) {
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, path->idx[depth],
+						  HDA_INPUT);
+			break;
+		}
+	}
+
+	return val;
+}
+
 static int parse_mic_boost(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
+	struct hda_input_mux *imux = &spec->input_mux;
 	int i, err;
-	hda_nid_t nid;
 
-	for (i = 0; i < cfg->num_inputs; i++) {
-		if (cfg->inputs[i].type > AUTO_PIN_MIC)
-			break;
-		nid = cfg->inputs[i].pin;
-		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
-			char boost_label[44];
-			struct nid_path *path;
-			unsigned int val;
+	if (!spec->num_adc_nids)
+		return 0;
 
-			if (!nid_has_volume(codec, nid, HDA_INPUT))
-				continue;
+	for (i = 0; i < imux->num_items; i++) {
+		struct nid_path *path;
+		unsigned int val;
+		int idx;
+		char boost_label[44];
 
-			snprintf(boost_label, sizeof(boost_label),
-				 "%s Boost Volume",
-				 spec->input_labels[i]);
-			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
-			err = add_control(spec, HDA_CTL_WIDGET_VOL,
-					  boost_label,
-					  spec->input_label_idxs[i], val);
-			if (err < 0)
-				return err;
+		idx = imux->items[i].index;
+		if (idx >= imux->num_items)
+			continue;
 
-			path = snd_hda_get_nid_path(codec, nid, 0);
-			if (path)
-				path->ctls[NID_PATH_BOOST_CTL] = val;
-		}
+		/* check only line-in and mic pins */
+		if (cfg->inputs[idx].type > AUTO_PIN_MIC)
+			continue;
+
+		path = get_input_path(codec, 0, i);
+		if (!path)
+			continue;
+
+		val = look_for_boost_amp(codec, path);
+		if (!val)
+			continue;
+
+		/* create a boost control */
+		snprintf(boost_label, sizeof(boost_label),
+			 "%s Boost Volume", spec->input_labels[idx]);
+		err = add_control(spec, HDA_CTL_WIDGET_VOL, boost_label,
+				  spec->input_label_idxs[idx], val);
+		if (err < 0)
+			return err;
+
+		path->ctls[NID_PATH_BOOST_CTL] = val;
 	}
 	return 0;
 }
-- 
1.8.1
