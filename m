From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Check leaf nodes to find aamix amps
Date: Thu, 28 Nov 2013 11:34:45 +0100
Message-ID: <1385634885-15491-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4049A2652DA
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:34:45 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 22D15A7D46
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 11:34:45 +0100 (CET)
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

The current generic parser assumes blindly that the volume and mute
amps are found in the aamix node itself.  But on some codecs,
typically Analog Devices ones, the aamix amps are separately
implemented in each leaf node of the aamix node, and the current
driver can't establish the correct amp controls.  This is a regression
compared with the previous static quirks.

This patch extends the search for the amps to the leaf nodes for
allowing the aamix controls again on such codecs.
In this implementation, I didn't code to loop through the whole paths,
since usually one depth should suffice, and we can't search too
deeply, as it may result in the conflicting control assignments.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=65641
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 57 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index faefff1d3e81..c4671d00babd 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2808,6 +2808,42 @@ static int add_loopback_list(struct hda_gen_spec *spec, hda_nid_t mix, int idx)
 	return 0;
 }
 
+/* return true if either a volume or a mute amp is found for the given
+ * aamix path; the amp has to be either in the mixer node or its direct leaf
+ */
+static bool look_for_mix_leaf_ctls(struct hda_codec *codec, hda_nid_t mix_nid,
+				   hda_nid_t pin, unsigned int *mix_val,
+				   unsigned int *mute_val)
+{
+	int idx, num_conns;
+	const hda_nid_t *list;
+	hda_nid_t nid;
+
+	idx = snd_hda_get_conn_index(codec, mix_nid, pin, true);
+	if (idx < 0)
+		return false;
+
+	*mix_val = *mute_val = 0;
+	if (nid_has_volume(codec, mix_nid, HDA_INPUT))
+		*mix_val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+	if (nid_has_mute(codec, mix_nid, HDA_INPUT))
+		*mute_val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+	if (*mix_val && *mute_val)
+		return true;
+
+	/* check leaf node */
+	num_conns = snd_hda_get_conn_list(codec, mix_nid, &list);
+	if (num_conns < idx)
+		return false;
+	nid = list[idx];
+	if (!*mix_val && nid_has_volume(codec, nid, HDA_OUTPUT))
+		*mix_val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+	if (!*mute_val && nid_has_mute(codec, nid, HDA_OUTPUT))
+		*mute_val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+
+	return *mix_val || *mute_val;
+}
+
 /* create input playback/capture controls for the given pin */
 static int new_analog_input(struct hda_codec *codec, int input_idx,
 			    hda_nid_t pin, const char *ctlname, int ctlidx,
@@ -2815,12 +2851,11 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 {
 	struct hda_gen_spec *spec = codec->spec;
 	struct nid_path *path;
-	unsigned int val;
+	unsigned int mix_val, mute_val;
 	int err, idx;
 
-	if (!nid_has_volume(codec, mix_nid, HDA_INPUT) &&
-	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
-		return 0; /* no need for analog loopback */
+	if (!look_for_mix_leaf_ctls(codec, mix_nid, pin, &mix_val, &mute_val))
+		return 0;
 
 	path = snd_hda_add_new_path(codec, pin, mix_nid, 0);
 	if (!path)
@@ -2829,20 +2864,18 @@ static int new_analog_input(struct hda_codec *codec, int input_idx,
 	spec->loopback_paths[input_idx] = snd_hda_get_path_idx(codec, path);
 
 	idx = path->idx[path->depth - 1];
-	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
-		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
-		err = __add_pb_vol_ctrl(spec, HDA_CTL_WIDGET_VOL, ctlname, ctlidx, val);
+	if (mix_val) {
+		err = __add_pb_vol_ctrl(spec, HDA_CTL_WIDGET_VOL, ctlname, ctlidx, mix_val);
 		if (err < 0)
 			return err;
-		path->ctls[NID_PATH_VOL_CTL] = val;
+		path->ctls[NID_PATH_VOL_CTL] = mix_val;
 	}
 
-	if (nid_has_mute(codec, mix_nid, HDA_INPUT)) {
-		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
-		err = __add_pb_sw_ctrl(spec, HDA_CTL_WIDGET_MUTE, ctlname, ctlidx, val);
+	if (mute_val) {
+		err = __add_pb_sw_ctrl(spec, HDA_CTL_WIDGET_MUTE, ctlname, ctlidx, mute_val);
 		if (err < 0)
 			return err;
-		path->ctls[NID_PATH_MUTE_CTL] = val;
+		path->ctls[NID_PATH_MUTE_CTL] = mute_val;
 	}
 
 	path->active = true;
-- 
1.8.4.4
