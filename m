From: libin.yang@linux.intel.com
Subject: [PATCH v3 5/5] ALSA: hda - hdmi setup pin when monitor
	hotplug in pcm dynamic assignment mode
Date: Thu, 10 Dec 2015 09:52:12 +0800
Message-ID: <1449712332-106365-6-git-send-email-libin.yang@linux.intel.com>
References: <1449712332-106365-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DE238261563
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 02:54:42 +0100 (CET)
In-Reply-To: <1449712332-106365-1-git-send-email-libin.yang@linux.intel.com>
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

Setup pin configuration when monitor is hotplugged
in pcm dynamic assignment if the PCM is in open state.

When monitor is disconnect, The pin will be reset.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.h  |  1 +
 sound/pci/hda/patch_hdmi.c | 82 +++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 79 insertions(+), 4 deletions(-)

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
index 5f71459..7c53dd8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1516,10 +1516,14 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
 {
 	struct hdmi_spec *spec = codec->spec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int cvt_idx;
+	int cvt_idx, pcm_idx;
 	struct hdmi_spec_per_cvt *per_cvt = NULL;
 	int err;
 
+	pcm_idx = hinfo_to_pcm_index(codec, hinfo);
+	if (pcm_idx < 0)
+		return -EINVAL;
+
 	err = hdmi_choose_cvt(codec, -1, &cvt_idx, NULL);
 	if (err)
 		return err;
@@ -1530,6 +1534,7 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
 
 	intel_not_share_assigned_cvt_nid(codec, 0, per_cvt->cvt_nid);
 
+	spec->pcm_rec[pcm_idx]->in_use = true;
 	/* todo: setup spdif ctls assign */
 
 	/* Initially set the converter's capabilities */
@@ -1598,7 +1603,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	/* Claim converter */
 	per_cvt->assigned = 1;
 
-
+	spec->pcm_rec[pcm_idx]->in_use = true;
 	per_pin = get_pin(spec, pin_idx);
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
@@ -1773,6 +1778,71 @@ static void hdmi_detach_hda_pcm(struct hdmi_spec *spec,
 		clear_bit(idx, &spec->pcm_bitmap);
 }
 
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
@@ -1819,10 +1889,13 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	}
 
 	if (spec->dyn_pcm_assign) {
-		if (eld->eld_valid)
+		if (eld->eld_valid) {
 			hdmi_attach_hda_pcm(spec, per_pin);
-		else
+			hdmi_pcm_setup_pin(spec, per_pin);
+		} else {
+			hdmi_pcm_reset_pin(spec, per_pin);
 			hdmi_detach_hda_pcm(spec, per_pin);
+		}
 	}
 
 	if (!eld->eld_valid && repoll)
@@ -2108,6 +2181,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		hinfo->nid = 0;
 
 		mutex_lock(&spec->pcm_lock);
+		spec->pcm_rec[pcm_idx]->in_use = false;
 		pin_idx = hinfo_to_pin_index(codec, hinfo);
 		if (spec->dyn_pcm_assign && pin_idx < 0) {
 			mutex_unlock(&spec->pcm_lock);
-- 
1.9.1
