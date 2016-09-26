From: libin.yang@linux.intel.com
Subject: [RFC PATCH 3/3] ALSA: hda - add DP mst audio support
Date: Mon, 26 Sep 2016 16:35:38 +0800
Message-ID: <1474878938-10260-4-git-send-email-libin.yang@linux.intel.com>
References: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D910266D1A
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 10:40:10 +0200 (CEST)
In-Reply-To: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patch adds the DP mst audio support.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.c  |   4 +
 sound/pci/hda/patch_hdmi.c | 226 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 174 insertions(+), 56 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 57c25b7..d624d77 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -482,6 +482,10 @@ static int read_pin_defaults(struct hda_codec *codec)
 		pin->nid = nid;
 		pin->cfg = snd_hda_codec_read(codec, nid, 0,
 					      AC_VERB_GET_CONFIG_DEFAULT, 0);
+		/*
+		 * all device entries are the same widget control so far
+		 * fixme: if any codec is different, need fix here
+		 */
 		pin->ctrl = snd_hda_codec_read(codec, nid, 0,
 					       AC_VERB_GET_PIN_WIDGET_CONTROL,
 					       0);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8a20cf4..e584c5a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -76,6 +76,7 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	int dev_id;
 	/* pin idx, different device entries on the same pin use the same idx */
 	int pin_nid_idx;
 	int num_mux_nids;
@@ -130,7 +131,23 @@ struct hdmi_spec {
 	struct snd_array cvts; /* struct hdmi_spec_per_cvt */
 	hda_nid_t cvt_nids[4]; /* only for haswell fix */
 
+	/*
+	 * num_pins is the number of virtual pins
+	 * for example, there are 3 pins, and each pin
+	 * has 4 device entries, then the num_pins is 12
+	 */
 	int num_pins;
+	/*
+	 * num_nids is the number of real pins
+	 * In the above example, num_nids is 3
+	 */
+	int num_nids;
+	/*
+	 * dev_num is the number of device entries
+	 * on each pin.
+	 * In the above example, dev_num is 4
+	 */
+	int dev_num;
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hdmi_pcm pcm_rec[16];
 	struct mutex pcm_lock;
@@ -217,14 +234,26 @@ union audio_infoframe {
 /* obtain hda_pcm object assigned to idx */
 #define get_pcm_rec(spec, idx)	(get_hdmi_pcm(spec, idx)->pcm)
 
-static int pin_nid_to_pin_index(struct hda_codec *codec, hda_nid_t pin_nid)
+static int pin_id_to_pin_index(struct hda_codec *codec,
+			       hda_nid_t pin_nid, int dev_id)
 {
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx;
+	struct hdmi_spec_per_pin *per_pin;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++)
-		if (get_pin(spec, pin_idx)->pin_nid == pin_nid)
+	/*
+	 * (dev_id == -1) means it is NON-MST pin
+	 * return the first virtual pin on this port
+	 */
+	if (dev_id == -1)
+		dev_id = 0;
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		per_pin = get_pin(spec, pin_idx);
+		if ((per_pin->pin_nid == pin_nid) &&
+			(per_pin->dev_id == dev_id))
 			return pin_idx;
+	}
 
 	codec_warn(codec, "HDMI: pin nid %d not registered\n", pin_nid);
 	return -EINVAL;
@@ -724,10 +753,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
 
-static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
+static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid,
+				      int dev_id)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int pin_idx = pin_nid_to_pin_index(codec, nid);
+	int pin_idx = pin_id_to_pin_index(codec, nid, dev_id);
 
 	if (pin_idx < 0)
 		return;
@@ -738,7 +768,8 @@ static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid)
 static void jack_callback(struct hda_codec *codec,
 			  struct hda_jack_callback *jack)
 {
-	check_presence_and_report(codec, jack->nid);
+	/* hda_jack don't support DP MST */
+	check_presence_and_report(codec, jack->nid, 0);
 }
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -747,6 +778,12 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 	struct hda_jack_tbl *jack;
 	int dev_entry = (res & AC_UNSOL_RES_DE) >> AC_UNSOL_RES_DE_SHIFT;
 
+	/*
+	 * assume DP MST uses dyn_pcm_assign and acomp and
+	 * never comes here
+	 * if DP MST supports unsol event, below code need
+	 * consider dev_entry
+	 */
 	jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
 	if (!jack)
 		return;
@@ -757,7 +794,8 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 		codec->addr, jack->nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
-	check_presence_and_report(codec, jack->nid);
+	/* hda_jack don't support DP MST */
+	check_presence_and_report(codec, jack->nid, 0);
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -970,28 +1008,55 @@ static int intel_cvt_id_to_mux_idx(struct hdmi_spec *spec,
  * by any other pins.
  */
 static void intel_not_share_assigned_cvt(struct hda_codec *codec,
-			hda_nid_t pin_nid, int mux_idx)
+					 hda_nid_t pin_nid,
+					 int dev_id, int mux_idx)
 {
 	struct hdmi_spec *spec = codec->spec;
 	hda_nid_t nid;
 	int cvt_idx, curr;
 	struct hdmi_spec_per_cvt *per_cvt;
+	struct hdmi_spec_per_pin *per_pin;
+	int pin_idx;
 
 	/* configure all pins, including "no physical connection" ones */
-	for_each_hda_codec_node(nid, codec) {
-		unsigned int wid_caps = get_wcaps(codec, nid);
-		unsigned int wid_type = get_wcaps_type(wid_caps);
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		int dev_id_saved;
+		int dev_num;
+
+		per_pin = get_pin(spec, pin_idx);
+		/*
+		 * pin not connected to monitor
+		 * no need to operate on it
+		 */
+		if (!per_pin->pcm)
+			continue;
 
-		if (wid_type != AC_WID_PIN)
+		if ((per_pin->pin_nid == pin_nid) &&
+			(per_pin->dev_id == dev_id))
 			continue;
 
-		if (nid == pin_nid)
+		/*
+		 * if per_pin->dev_id >= dev_num,
+		 * snd_hda_get_dev_select() will fail,
+		 * and the following operation is unpredictable.
+		 * So skip this situation.
+		 */
+		dev_num = snd_hda_get_num_devices(codec, per_pin->pin_nid) + 1;
+		if (per_pin->dev_id >= dev_num)
 			continue;
 
+		nid = per_pin->pin_nid;
+
+		/* save the dev id for each pin, and restore it when return */
+		dev_id_saved = snd_hda_get_dev_select(codec, nid);
+		snd_hda_set_dev_select(codec, nid, per_pin->dev_id);
 		curr = snd_hda_codec_read(codec, nid, 0,
 					  AC_VERB_GET_CONNECT_SEL, 0);
-		if (curr != mux_idx)
+		if (curr != mux_idx) {
+			snd_hda_set_dev_select(codec, nid, dev_id_saved);
 			continue;
+		}
+
 
 		/* choose an unassigned converter. The conveters in the
 		 * connection list are in the same order as in the codec.
@@ -1008,12 +1073,13 @@ static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 				break;
 			}
 		}
+		snd_hda_set_dev_select(codec, nid, dev_id_saved);
 	}
 }
 
 /* A wrapper of intel_not_share_asigned_cvt() */
 static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
-			hda_nid_t pin_nid, hda_nid_t cvt_nid)
+			hda_nid_t pin_nid, int dev_id, hda_nid_t cvt_nid)
 {
 	int mux_idx;
 	struct hdmi_spec *spec = codec->spec;
@@ -1025,7 +1091,7 @@ static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
 	 */
 	mux_idx = intel_cvt_id_to_mux_idx(spec, cvt_nid);
 	if (mux_idx >= 0)
-		intel_not_share_assigned_cvt(codec, pin_nid, mux_idx);
+		intel_not_share_assigned_cvt(codec, pin_nid, dev_id, mux_idx);
 }
 
 /* skeleton caller of pin_cvt_fixup ops */
@@ -1140,6 +1206,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
 
+	snd_hda_set_dev_select(codec, per_pin->pin_nid, per_pin->dev_id);
 	snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
 			    AC_VERB_SET_CONNECT_SEL,
 			    per_pin->mux_idx);
@@ -1215,13 +1282,13 @@ static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
 		return per_pin->pin_nid_idx;
 
 	/* have a second try; check the "reserved area" over num_pins */
-	for (i = spec->num_pins; i < spec->pcm_used; i++) {
+	for (i = spec->num_nids; i < spec->pcm_used; i++) {
 		if (!test_bit(i, &spec->pcm_bitmap))
 			return i;
 	}
 
 	/* the last try; check the empty slots in pins */
-	for (i = 0; i < spec->num_pins; i++) {
+	for (i = 0; i < spec->num_nids; i++) {
 		if (!test_bit(i, &spec->pcm_bitmap))
 			return i;
 	}
@@ -1296,10 +1363,13 @@ static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
 	per_pin->cvt_nid = hinfo->nid;
 
 	mux_idx = hdmi_get_pin_cvt_mux(spec, per_pin, hinfo->nid);
-	if (mux_idx < per_pin->num_mux_nids)
+	if (mux_idx < per_pin->num_mux_nids) {
+		snd_hda_set_dev_select(codec, per_pin->pin_nid,
+				   per_pin->dev_id);
 		snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
 				AC_VERB_SET_CONNECT_SEL,
 				mux_idx);
+	}
 	snd_hda_spdif_ctls_assign(codec, per_pin->pcm_idx, hinfo->nid);
 
 	non_pcm = check_non_pcm_per_cvt(codec, hinfo->nid);
@@ -1467,6 +1537,7 @@ static struct snd_jack *pin_idx_to_jack(struct hda_codec *codec,
 	if (per_pin->pcm_idx >= 0 && spec->dyn_pcm_assign)
 		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
 	else if (!spec->dyn_pcm_assign) {
+		//jack tbl not support mst
 		jack_tbl = snd_hda_jack_tbl_get(codec, per_pin->pin_nid);
 		if (jack_tbl)
 			jack = jack_tbl->jack;
@@ -1485,9 +1556,9 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 
 	mutex_lock(&per_pin->lock);
 	eld->monitor_present = false;
-	size = snd_hdac_acomp_get_eld(&codec->core, per_pin->pin_nid, -1,
-				      &eld->monitor_present, eld->eld_buffer,
-				      ELD_MAX_SIZE);
+	size = snd_hdac_acomp_get_eld(&codec->core, per_pin->pin_nid,
+				      per_pin->dev_id, &eld->monitor_present,
+				      eld->eld_buffer, ELD_MAX_SIZE);
 	if (size > 0) {
 		size = min(size, ELD_MAX_SIZE);
 		if (snd_hdmi_parse_eld(codec, &eld->info,
@@ -1556,7 +1627,7 @@ static void hdmi_repoll_eld(struct work_struct *work)
 }
 
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
-					     hda_nid_t nid);
+					     hda_nid_t nid, int dev_id);
 
 static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
@@ -1565,38 +1636,64 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	int pin_idx;
 	struct hdmi_spec_per_pin *per_pin;
 	int err;
+	int dev_num, i;
 
 	caps = snd_hda_query_pin_caps(codec, pin_nid);
 	if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
 		return 0;
 
+	/*
+	 * For DP MST audio, Configuration Default is the same for
+	 * all device entries on the same pin
+	 */
 	config = snd_hda_codec_get_pincfg(codec, pin_nid);
 	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
 		return 0;
 
-	if (is_haswell_plus(codec))
-		intel_haswell_fixup_connect_list(codec, pin_nid);
-
-	pin_idx = spec->num_pins;
-	per_pin = snd_array_new(&spec->pins);
-	if (!per_pin)
-		return -ENOMEM;
-
-	per_pin->pin_nid = pin_nid;
-	per_pin->non_pcm = false;
-	if (spec->dyn_pcm_assign)
-		per_pin->pcm_idx = -1;
-	else {
-		per_pin->pcm = get_hdmi_pcm(spec, pin_idx);
-		per_pin->pcm_idx = pin_idx;
+	if (is_haswell_plus(codec)) {
+		dev_num = 3;
+		spec->dev_num = 3;
+	} else if (spec->dyn_pcm_assign && codec->dp_mst) {
+		dev_num = snd_hda_get_num_devices(codec, pin_nid) + 1;
+		/*
+		 * spec->dev_num is the maxinum number of device entries
+		 * among all the pins
+		 */
+		spec->dev_num = (spec->dev_num > dev_num) ?
+			spec->dev_num : dev_num;
+	} else {
+		dev_num = 1;
+		spec->dev_num = 1;
 	}
-	per_pin->pin_nid_idx = pin_idx;
 
-	err = hdmi_read_pin_conn(codec, pin_idx);
-	if (err < 0)
-		return err;
+	for (i = 0; i < dev_num; i++) {
+		pin_idx = spec->num_pins;
+		per_pin = snd_array_new(&spec->pins);
+
+		if (!per_pin)
+			return -ENOMEM;
 
-	spec->num_pins++;
+		if (spec->dyn_pcm_assign) {
+			per_pin->pcm = NULL;
+			per_pin->pcm_idx = -1;
+		} else {
+			per_pin->pcm = get_hdmi_pcm(spec, pin_idx);
+			per_pin->pcm_idx = pin_idx;
+		}
+		per_pin->pin_nid = pin_nid;
+		per_pin->pin_nid_idx = spec->num_nids;
+		per_pin->dev_id = i;
+		per_pin->non_pcm = false;
+		snd_hda_set_dev_select(codec, pin_nid, i);
+		if (is_haswell_plus(codec))
+			intel_haswell_fixup_connect_list(codec, pin_nid, i);
+		//need check here
+		err = hdmi_read_pin_conn(codec, pin_idx);
+		if (err < 0)
+			return err;
+		spec->num_pins++;
+	}
+	spec->num_nids++;
 
 	return 0;
 }
@@ -1744,7 +1841,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	/* Call sync_audio_rate to set the N/CTS/M manually if necessary */
 	/* Todo: add DP1.2 MST audio support later */
 	if (codec_has_acomp(codec))
-		snd_hdac_sync_audio_rate(&codec->core, pin_nid, -1,
+		snd_hdac_sync_audio_rate(&codec->core, pin_nid, per_pin->dev_id,
 					 runtime->rate);
 
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
@@ -1762,6 +1859,7 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 				    pinctl | PIN_OUT);
 	}
 
+	//need call snd_hda_set_dev_select()???
 	err = spec->ops.setup_stream(codec, cvt_nid, pin_nid,
 				 stream_tag, format);
 	mutex_unlock(&spec->pcm_lock);
@@ -1897,17 +1995,23 @@ static bool is_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 static int generic_hdmi_build_pcms(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int pin_idx;
+	int idx;
 
-	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+	/*
+	 * for non-mst mode, pcm number is the same as before
+	 * for DP MST mode, pcm number is (nid number + dev_num - 1)
+	 *  dev_num is the device entry number in a pin
+	 *
+	 */
+	for (idx = 0; idx < spec->num_nids + spec->dev_num - 1; idx++) {
 		struct hda_pcm *info;
 		struct hda_pcm_stream *pstr;
 
-		info = snd_hda_codec_pcm_new(codec, "HDMI %d", pin_idx);
+		info = snd_hda_codec_pcm_new(codec, "HDMI %d", idx);
 		if (!info)
 			return -ENOMEM;
 
-		spec->pcm_rec[pin_idx].pcm = info;
+		spec->pcm_rec[idx].pcm = info;
 		spec->pcm_used++;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
@@ -1915,6 +2019,9 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 		pstr = &info->stream[SNDRV_PCM_STREAM_PLAYBACK];
 		pstr->substreams = 1;
 		pstr->ops = generic_ops;
+		/* pcm number is less than 16 */
+		if (spec->pcm_used >= 16)
+			break;
 		/* other pstr fields are set in open */
 	}
 
@@ -2070,7 +2177,9 @@ static int generic_hdmi_init(struct hda_codec *codec)
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 		hda_nid_t pin_nid = per_pin->pin_nid;
+		int dev_id = per_pin->dev_id;
 
+		snd_hda_set_dev_select(codec, pin_nid, dev_id);
 		hdmi_init_pin(codec, pin_nid);
 		if (!codec_has_acomp(codec))
 			snd_hda_jack_detect_enable_callback(codec, pin_nid,
@@ -2178,6 +2287,7 @@ static int alloc_generic_hdmi(struct hda_codec *codec)
 		return -ENOMEM;
 
 	spec->ops = generic_standard_hdmi_ops;
+	spec->dev_num = 1;	/* initialize to 1 */
 	mutex_init(&spec->pcm_lock);
 	snd_hdac_register_chmap_ops(&codec->core, &spec->chmap);
 
@@ -2218,21 +2328,21 @@ static int patch_generic_hdmi(struct hda_codec *codec)
  */
 
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
-					     hda_nid_t nid)
+					     hda_nid_t nid, int dev_id)
 {
 	struct hdmi_spec *spec = codec->spec;
 	hda_nid_t conns[4];
 	int nconns;
 
-	nconns = snd_hda_get_connections(codec, nid, 0, conns,
-					 ARRAY_SIZE(conns));
+	nconns = snd_hda_get_connections(codec, nid, dev_id,
+					 conns, ARRAY_SIZE(conns));
 	if (nconns == spec->num_cvts &&
 	    !memcmp(conns, spec->cvt_nids, spec->num_cvts * sizeof(hda_nid_t)))
 		return;
 
 	/* override pins connection list */
 	codec_dbg(codec, "hdmi: haswell: override pin connection 0x%x\n", nid);
-	snd_hda_override_conn_list(codec, nid, 0, spec->num_cvts,
+	snd_hda_override_conn_list(codec, nid, dev_id, spec->num_cvts,
 				   spec->cvt_nids);
 }
 
@@ -2297,6 +2407,7 @@ static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 {
 	struct hda_codec *codec = audio_ptr;
 	int pin_nid;
+	int dev_id = pipe;
 
 	/* we assume only from port-B to port-D */
 	if (port < 1 || port > 3)
@@ -2323,7 +2434,7 @@ static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
 		return;
 
 	snd_hdac_i915_set_bclk(&codec->bus->core);
-	check_presence_and_report(codec, pin_nid);
+	check_presence_and_report(codec, pin_nid, dev_id);
 }
 
 /* register i915 component pin_eld_notify callback */
@@ -2356,11 +2467,13 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 			       hda_nid_t cvt_nid)
 {
 	if (per_pin) {
+		snd_hda_set_dev_select(codec, per_pin->pin_nid,
+			       per_pin->dev_id);
 		intel_verify_pin_cvt_connect(codec, per_pin);
 		intel_not_share_assigned_cvt(codec, per_pin->pin_nid,
-					     per_pin->mux_idx);
+				     per_pin->dev_id, per_pin->mux_idx);
 	} else {
-		intel_not_share_assigned_cvt_nid(codec, 0, cvt_nid);
+		intel_not_share_assigned_cvt_nid(codec, 0, 0, cvt_nid);
 	}
 }
 
@@ -2380,6 +2493,8 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 	spec = codec->spec;
+	codec->dp_mst = true;
+	spec->dyn_pcm_assign = true;
 
 	intel_haswell_enable_all_pins(codec, true);
 	intel_haswell_fixup_enable_dp12(codec);
@@ -2391,7 +2506,6 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 		codec->core.link_power_control = 1;
 
 	codec->patch_ops.set_power_state = haswell_set_power_state;
-	codec->dp_mst = true;
 	codec->depop_delay = 0;
 	codec->auto_runtime_pm = 1;
 
-- 
1.9.1
