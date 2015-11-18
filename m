From: libin.yang@linux.intel.com
Subject: [RFC PATCH 2/2] ALSA: hda - hdmi dynamically bind PCM
	to pin when monitor hotplug
Date: Wed, 18 Nov 2015 16:46:59 +0800
Message-ID: <1447836419-34336-3-git-send-email-libin.yang@linux.intel.com>
References: <1447836419-34336-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 46FD72605A1
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 09:48:52 +0100 (CET)
In-Reply-To: <1447836419-34336-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: libin.yang@intel.com, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Dynamically bind/unbind the PCM to pin when HDMI/DP monitor hotplug.

When monitor is connected, find a proper PCM for the monitor.
If PCM is already open, set the correct configuration for the pin.

When monitor is disconnected, unbind the PCM from the pin if
PCM is not open. Otherwise unbind the PCM when pcm closes.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.h  |   1 +
 sound/pci/hda/patch_hdmi.c | 197 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 188 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..ee97401 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -167,6 +167,7 @@ enum {
 /* for PCM creation */
 struct hda_pcm {
 	char *name;
+	bool in_use;
 	struct hda_pcm_stream stream[2];
 	unsigned int pcm_type;	/* HDA_PCM_TYPE_XXX */
 	int device;		/* device number to assign */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 12fc506..77d6701 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -72,6 +72,8 @@ struct hdmi_spec_per_cvt {
 
 struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
+	/* pin idx, different device entries on the same pin use the same idx */
+	int pin_nid_idx;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	int mux_idx;
@@ -83,6 +85,7 @@ struct hdmi_spec_per_pin {
 	struct delayed_work work;
 	struct snd_kcontrol *eld_ctl;
 	struct hda_pcm *pcm; /* pointer to spec->pcm_rec[n] dynamically*/
+	int pcm_idx; /* which pcm is attached. -1 means no pcm is attached */
 	int repoll_count;
 	bool setup; /* the stream has been set up by prepare callback */
 	int channels; /* current number of channels */
@@ -136,6 +139,8 @@ struct hdmi_spec {
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hda_pcm *pcm_rec[16];
 	struct mutex pcm_lock;
+	unsigned long pcm_bitmap;
+	int pcm_used;	/* counter of pcm_rec[] */
 	unsigned int channels_max; /* max over all cvts */
 
 	struct hdmi_eld temp_eld;
@@ -376,6 +381,20 @@ static int pin_nid_to_pin_index(struct hda_codec *codec, hda_nid_t pin_nid)
 	return -EINVAL;
 }
 
+static int hinfo_to_pcm_index(struct hda_codec *codec,
+			struct hda_pcm_stream *hinfo)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int pcm_idx;
+
+	for (pcm_idx = 0; pcm_idx < spec->pcm_used; pcm_idx++)
+		if (get_pcm_rec(spec, pcm_idx)->stream == hinfo)
+			return pcm_idx;
+
+	codec_warn(codec, "HDMI: hinfo %p not registered\n", hinfo);
+	return -EINVAL;
+}
+
 static int hinfo_to_pin_index(struct hda_codec *codec,
 			      struct hda_pcm_stream *hinfo)
 {
@@ -1486,10 +1505,14 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
 {
 	struct hdmi_spec *spec = codec->spec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int cvt_idx, mux_idx;
+	int cvt_idx, pcm_idx, mux_idx;
 	struct hdmi_spec_per_cvt *per_cvt = NULL;
 	int err;
 
+	pcm_idx = hinfo_to_pcm_index(codec, hinfo);
+	if (pcm_idx < 0)
+		return -EINVAL;
+
 	err = hdmi_find_available_cvt(codec, &cvt_idx);
 	if (err)
 		return err;
@@ -1497,11 +1520,11 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
 	per_cvt = get_cvt(spec, cvt_idx);
 	per_cvt->assigned = 1;
 	hinfo->nid = per_cvt->cvt_nid;
-
 	mux_idx = intel_cvt_id_to_mux_idx(spec, per_cvt->cvt_nid);
 	/* unshare converter from all pins */
 	intel_not_share_assigned_cvt(codec, 0, mux_idx);
 
+	spec->pcm_rec[pcm_idx]->in_use = true;
 	/* todo: setup spdif ctls assign */
 
 	/* Initially set the converter's capabilities */
@@ -1531,13 +1554,17 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 {
 	struct hdmi_spec *spec = codec->spec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int pin_idx, cvt_idx, mux_idx = 0;
+	int pin_idx, cvt_idx, pcm_idx, mux_idx = 0;
 	struct hdmi_spec_per_pin *per_pin;
 	struct hdmi_eld *eld;
 	struct hdmi_spec_per_cvt *per_cvt = NULL;
 	int err;
 
 	/* Validate hinfo */
+	pcm_idx = hinfo_to_pcm_index(codec, hinfo);
+	if (pcm_idx < 0)
+		return -EINVAL;
+
 	mutex_lock(&spec->pcm_lock);
 	pin_idx = hinfo_to_pin_index(codec, hinfo);
 	if (!spec->dyn_pcm_assign) {
@@ -1566,7 +1593,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	/* Claim converter */
 	per_cvt->assigned = 1;
 
-
+	spec->pcm_rec[pcm_idx]->in_use = true;
 	per_pin = get_pin(spec, pin_idx);
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
@@ -1579,7 +1606,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
 		intel_not_share_assigned_cvt(codec, per_pin->pin_nid, mux_idx);
 
-	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
+	snd_hda_spdif_ctls_assign(codec, pcm_idx, per_cvt->cvt_nid);
 
 	/* Initially set the converter's capabilities */
 	hinfo->channels_min = per_cvt->channels_min;
@@ -1596,7 +1623,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 		    !hinfo->rates || !hinfo->formats) {
 			per_cvt->assigned = 0;
 			hinfo->nid = 0;
-			snd_hda_spdif_ctls_unassign(codec, pin_idx);
+			snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 			mutex_unlock(&spec->pcm_lock);
 			return -ENODEV;
 		}
@@ -1637,6 +1664,135 @@ static int hdmi_read_pin_conn(struct hda_codec *codec, int pin_idx)
 	return 0;
 }
 
+static int get_preferred_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	if ((spec->pcm_bitmap & (1 << per_pin->pin_nid_idx)) == 0)
+		return per_pin->pin_nid_idx;
+	return -1;
+}
+
+static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int slot;
+	int i;
+
+	/* try the prefer PCM */
+	slot = get_preferred_pcm_slot(spec, per_pin);
+	if (slot != -1)
+		return slot;
+
+	/* have a second try */
+	for (i = spec->num_pins; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+
+	/* the last try */
+	for (i = 0; i < spec->pcm_used; i++) {
+		if ((spec->pcm_bitmap & (1 << i)) == 0)
+			return i;
+	}
+	return -ENODEV;
+}
+
+static void hdmi_attach_hda_pcm(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int idx;
+
+	/* pcm already be attached to the pin */
+	if (per_pin->pcm)
+		return;
+	idx = hdmi_find_pcm_slot(spec, per_pin);
+	if (idx == -ENODEV)
+		return;
+	per_pin->pcm_idx = idx;
+	per_pin->pcm = spec->pcm_rec[idx];
+	set_bit(idx, &spec->pcm_bitmap);
+}
+
+static void hdmi_detach_hda_pcm(struct hdmi_spec *spec,
+				struct hdmi_spec_per_pin *per_pin)
+{
+	int idx;
+
+	/* pcm already be detached from the pin */
+	if (!per_pin->pcm)
+		return;
+	idx = per_pin->pcm_idx;
+	per_pin->pcm_idx = -1;
+	per_pin->pcm = NULL;
+	if (idx >= 0 && idx < spec->pcm_used)
+		clear_bit(idx, &spec->pcm_bitmap);
+}
+
+static int hdmi_get_pin_cvt_mux(struct hdmi_spec *spec,
+		struct hdmi_spec_per_pin *per_pin, hda_nid_t cvt_nid)
+{
+	int mux_idx;
+
+	for (mux_idx = 0; mux_idx < per_pin->num_mux_nids; mux_idx++)
+		if (per_pin->mux_nids[mux_idx] == cvt_nid)
+			break;
+	return mux_idx;
+}
+
+static bool check_non_pcm_per_cvt(struct hda_codec *codec, hda_nid_t cvt_nid);
+static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
+			   struct hdmi_spec_per_pin *per_pin)
+{
+	struct hda_codec *codec = per_pin->codec;
+	struct hda_pcm *pcm;
+	struct hda_pcm_stream *hinfo;
+	struct snd_pcm_substream *substream;
+
+	int mux_idx;
+	bool non_pcm;
+
+	if (per_pin->pcm_idx >= 0 && per_pin->pcm_idx < spec->pcm_used)
+		pcm = spec->pcm_rec[per_pin->pcm_idx];
+	else
+		return;
+	if (!pcm->in_use)
+		return;
+
+	/* hdmi audio only uses playback and one substream */
+	hinfo = pcm->stream;
+	substream = pcm->pcm->streams[0].substream;
+
+	per_pin->cvt_nid = hinfo->nid;
+
+	mux_idx = hdmi_get_pin_cvt_mux(spec, per_pin, hinfo->nid);
+	if (mux_idx < per_pin->num_mux_nids)
+		snd_hda_codec_write_cache(codec, per_pin->pin_nid, 0,
+				AC_VERB_SET_CONNECT_SEL,
+				mux_idx);
+	snd_hda_spdif_ctls_assign(codec, per_pin->pcm_idx, hinfo->nid);
+
+	non_pcm = check_non_pcm_per_cvt(codec, hinfo->nid);
+	if (substream->runtime)
+		per_pin->channels = substream->runtime->channels;
+	per_pin->setup = true;
+	per_pin->mux_idx = mux_idx;
+
+	hdmi_setup_audio_infoframe(codec, per_pin, non_pcm);
+}
+
+static void hdmi_pcm_reset_pin(struct hdmi_spec *spec,
+			   struct hdmi_spec_per_pin *per_pin)
+{
+	if (per_pin->pcm_idx >= 0 && per_pin->pcm_idx < spec->pcm_used)
+		snd_hda_spdif_ctls_unassign(per_pin->codec, per_pin->pcm_idx);
+
+	per_pin->chmap_set = false;
+	memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
+
+	per_pin->setup = false;
+	per_pin->channels = 0;
+}
+
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_jack_tbl *jack;
@@ -1661,6 +1817,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	snd_hda_power_up_pm(codec);
 	present = snd_hda_pin_sense(codec, pin_nid);
 
+	mutex_lock(&spec->pcm_lock);
 	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
 	if (pin_eld->monitor_present)
@@ -1694,6 +1851,16 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		}
 	}
 
+	if (spec->dyn_pcm_assign) {
+		if (eld->eld_valid) {
+			hdmi_attach_hda_pcm(spec, per_pin);
+			hdmi_pcm_setup_pin(spec, per_pin);
+		} else {
+			hdmi_pcm_reset_pin(spec, per_pin);
+			hdmi_detach_hda_pcm(spec, per_pin);
+		}
+	}
+
 	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
 
@@ -1744,6 +1911,7 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		jack->block_report = !ret;
 
 	mutex_unlock(&per_pin->lock);
+	mutex_unlock(&spec->pcm_lock);
 	snd_hda_power_down_pm(codec);
 	return ret;
 }
@@ -1789,6 +1957,11 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
 	per_pin->pin_nid = pin_nid;
 	per_pin->non_pcm = false;
+	if (spec->dyn_pcm_assign)
+		per_pin->pcm_idx = -1;
+	else
+		per_pin->pcm_idx = pin_idx;
+	per_pin->pin_nid_idx = pin_idx;
 
 	err = hdmi_read_pin_conn(codec, pin_idx);
 	if (err < 0)
@@ -1994,22 +2167,25 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 			  struct snd_pcm_substream *substream)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int cvt_idx, pin_idx;
+	int cvt_idx, pin_idx, pcm_idx;
 	struct hdmi_spec_per_cvt *per_cvt;
 	struct hdmi_spec_per_pin *per_pin;
 	int pinctl;
 
 	if (hinfo->nid) {
+		pcm_idx = hinfo_to_pcm_index(codec, hinfo);
+		if (snd_BUG_ON(pcm_idx < 0))
+			return -EINVAL;
 		cvt_idx = cvt_nid_to_cvt_index(codec, hinfo->nid);
 		if (snd_BUG_ON(cvt_idx < 0))
 			return -EINVAL;
 		per_cvt = get_cvt(spec, cvt_idx);
-
 		snd_BUG_ON(!per_cvt->assigned);
 		per_cvt->assigned = 0;
 		hinfo->nid = 0;
 
 		mutex_lock(&spec->pcm_lock);
+		spec->pcm_rec[pcm_idx]->in_use = false;
 		pin_idx = hinfo_to_pin_index(codec, hinfo);
 		if (spec->dyn_pcm_assign && pin_idx < 0) {
 			mutex_unlock(&spec->pcm_lock);
@@ -2021,7 +2197,6 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 			return -EINVAL;
 		}
 		per_pin = get_pin(spec, pin_idx);
-
 		if (spec->dyn_pin_out) {
 			pinctl = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
 					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
@@ -2030,7 +2205,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 					    pinctl & ~PIN_OUT);
 		}
 
-		snd_hda_spdif_ctls_unassign(codec, pin_idx);
+		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 
 		mutex_lock(&per_pin->lock);
 		per_pin->chmap_set = false;
@@ -2228,6 +2403,7 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 			per_pin->pcm = info;
 		}
 		spec->pcm_rec[pin_idx] = info;
+		spec->pcm_used++;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
 
@@ -2275,6 +2451,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 						  HDA_PCM_TYPE_HDMI);
 		if (err < 0)
 			return err;
+		/* pin number is the same with pcm number so far */
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
 
 		/* add control for ELD Bytes */
-- 
1.9.1
