From: libin.yang@linux.intel.com
Subject: [PATCH v4 5/5] ALSA: hda - hdmi setup pin when monitor
	hotplug in pcm dynamic assignment mode
Date: Wed, 16 Dec 2015 13:42:45 +0800
Message-ID: <1450244565-77041-6-git-send-email-libin.yang@linux.intel.com>
References: <1450244565-77041-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D935D265132
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 06:45:24 +0100 (CET)
In-Reply-To: <1450244565-77041-1-git-send-email-libin.yang@linux.intel.com>
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
 sound/pci/hda/patch_hdmi.c | 87 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 10edab8..b285988 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -144,6 +144,11 @@ struct hdmi_spec {
 	/* pcm_bitmap means which pcms have been assigned to pins*/
 	unsigned long pcm_bitmap;
 	int pcm_used;	/* counter of pcm_rec[] */
+	/* bitmap shows whether the pcm is opened in user space
+	 * bit 0 means the first playback PCM (PCM3);
+	 * bit 1 means the second playback PCM, and so on.
+	 */
+	unsigned long pcm_in_use;
 	unsigned int channels_max; /* max over all cvts */
 
 	struct hdmi_eld temp_eld;
@@ -1523,10 +1528,14 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
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
@@ -1537,6 +1546,7 @@ static int hdmi_pcm_open_no_pin(struct hda_pcm_stream *hinfo,
 
 	intel_not_share_assigned_cvt_nid(codec, 0, per_cvt->cvt_nid);
 
+	set_bit(pcm_idx, &spec->pcm_in_use);
 	/* todo: setup spdif ctls assign */
 
 	/* Initially set the converter's capabilities */
@@ -1605,7 +1615,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	/* Claim converter */
 	per_cvt->assigned = 1;
 
-
+	set_bit(pcm_idx, &spec->pcm_in_use);
 	per_pin = get_pin(spec, pin_idx);
 	per_pin->cvt_nid = per_cvt->cvt_nid;
 	hinfo->nid = per_cvt->cvt_nid;
@@ -1726,6 +1736,71 @@ static void update_eld(struct hda_codec *codec,
 			       &per_pin->eld_ctl->id);
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
+
+static void hdmi_pcm_setup_pin(struct hdmi_spec *spec,
+			   struct hdmi_spec_per_pin *per_pin)
+{
+	struct hda_codec *codec = per_pin->codec;
+	struct hda_pcm *pcm;
+	struct hda_pcm_stream *hinfo;
+	struct snd_pcm_substream *substream;
+	int mux_idx;
+	bool non_pcm;
+
+	if (per_pin->pcm_idx >= 0 && per_pin->pcm_idx < spec->pcm_used)
+		pcm = spec->pcm_rec[per_pin->pcm_idx];
+	else
+		return;
+	if (!test_bit(per_pin->pcm_idx, &spec->pcm_in_use))
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
 /* update ELD and jack state via HD-audio verbs */
 static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 					 int repoll)
@@ -1876,10 +1951,13 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
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
 
 	update_eld(codec, per_pin, eld);
@@ -2152,6 +2230,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		hinfo->nid = 0;
 
 		mutex_lock(&spec->pcm_lock);
+		clear_bit(pcm_idx, &spec->pcm_in_use);
 		pin_idx = hinfo_to_pin_index(codec, hinfo);
 		if (spec->dyn_pcm_assign && pin_idx < 0) {
 			mutex_unlock(&spec->pcm_lock);
-- 
1.9.1
