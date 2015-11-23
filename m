From: libin.yang@linux.intel.com
Subject: [RFC V2 PATCH 2/5] ALSA: hda - hdmi operate spdif
	based on pcm
Date: Mon, 23 Nov 2015 22:09:31 +0800
Message-ID: <1448287774-146673-4-git-send-email-libin.yang@linux.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E0E50265453
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:12:26 +0100 (CET)
In-Reply-To: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
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

Currently, the driver operates the spdif based on pin.
This is ok for the current driver as pcm is statically
bound to the pin.

However, if the driver uses dynamically pcm assignment,
this will cause confusion for user space.

The patch changes spdif operation from pin based to pcm based.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index d0294bf..de22ac2 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -136,6 +136,7 @@ struct hdmi_spec {
 	struct snd_array pins; /* struct hdmi_spec_per_pin */
 	struct hda_pcm *pcm_rec[16];
 	struct mutex pcm_lock;
+	int pcm_used;	/* counter of pcm_rec[] */
 	unsigned int channels_max; /* max over all cvts */
 
 	struct hdmi_eld temp_eld;
@@ -376,6 +377,20 @@ static int pin_nid_to_pin_index(struct hda_codec *codec, hda_nid_t pin_nid)
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
@@ -1538,13 +1553,17 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
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
@@ -1586,7 +1605,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
 		intel_not_share_assigned_cvt(codec, per_pin->pin_nid, mux_idx);
 
-	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
+	snd_hda_spdif_ctls_assign(codec, pcm_idx, per_cvt->cvt_nid);
 
 	/* Initially set the converter's capabilities */
 	hinfo->channels_min = per_cvt->channels_min;
@@ -1603,7 +1622,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 		    !hinfo->rates || !hinfo->formats) {
 			per_cvt->assigned = 0;
 			hinfo->nid = 0;
-			snd_hda_spdif_ctls_unassign(codec, pin_idx);
+			snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 			mutex_unlock(&spec->pcm_lock);
 			return -ENODEV;
 		}
@@ -1996,12 +2015,15 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
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
@@ -2032,7 +2054,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 					    pinctl & ~PIN_OUT);
 		}
 
-		snd_hda_spdif_ctls_unassign(codec, pin_idx);
+		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 
 		mutex_lock(&per_pin->lock);
 		per_pin->chmap_set = false;
@@ -2230,6 +2252,7 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 			per_pin->pcm = info;
 		}
 		spec->pcm_rec[pin_idx] = info;
+		spec->pcm_used++;
 		info->pcm_type = HDA_PCM_TYPE_HDMI;
 		info->own_chmap = true;
 
@@ -2277,6 +2300,7 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 						  HDA_PCM_TYPE_HDMI);
 		if (err < 0)
 			return err;
+		/* pin number is the same with pcm number so far */
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
 
 		/* add control for ELD Bytes */
-- 
1.9.1
