From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - verify pin:cvt connection on
	preparing a stream for Intel HDMI codec
Date: Tue, 18 Mar 2014 17:35:02 +0800
Message-ID: <c8336299f64f1fda9e0d0488fbef5e90a67e287b.1395135128.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 388AC261ACE
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 10:35:46 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

The pin:converter connection may get reset after S3 on Intel Broadwell HDMI
codec. And this can cause multiple pins share a same convertor and mute control
will affect each other. We observed a resumed audio playback become silent
after S3.

This patch verifies pin:cvt connection on preparing a stream, to assure the pin
selects the right convetor and an assigned convertor is not shared by other
unused pins. Apply this fix-up on Haswell, Broadwell and Baytrail.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3ab7063..6000ce9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -68,6 +68,7 @@ struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+	int mux_idx;
 	hda_nid_t cvt_nid;
 
 	struct hda_codec *codec;
@@ -1342,6 +1343,8 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
 	if (cvt_idx == spec->num_cvts)
 		return -ENODEV;
 
+	per_pin->mux_idx = mux_idx;
+
 	if (cvt_id)
 		*cvt_id = cvt_idx;
 	if (mux_id)
@@ -1350,6 +1353,22 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
 	return 0;
 }
 
+/* Assure the pin select the right convetor */
+static void intel_verify_pin_cvt_connect(struct hda_codec *codec,
+			struct hdmi_spec_per_pin *per_pin)
+{
+	hda_nid_t pin_nid = per_pin->pin_nid;
+	int mux_idx, curr;
+
+	mux_idx = per_pin->mux_idx;
+	curr = snd_hda_codec_read(codec, pin_nid, 0,
+					  AC_VERB_GET_CONNECT_SEL, 0);
+	if (curr != mux_idx)
+		snd_hda_codec_write_cache(codec, pin_nid, 0,
+					    AC_VERB_SET_CONNECT_SEL,
+					    mux_idx);
+}
+
 /* Intel HDMI workaround to fix audio routing issue:
  * For some Intel display codecs, pins share the same connection list.
  * So a conveter can be selected by multiple pins and playback on any of these
@@ -1751,6 +1770,12 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	bool non_pcm;
 	int pinctl;
 
+	if (is_haswell_plus(codec) || is_valleyview(codec)) {
+		/* the pin:cvt connection may get reset after S3 */
+		intel_verify_pin_cvt_connect(codec, per_pin);
+		intel_not_share_assigned_cvt(codec, pin_nid, per_pin->mux_idx);
+	}
+
 	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
 	mutex_lock(&per_pin->lock);
 	per_pin->channels = substream->runtime->channels;
-- 
1.8.1.2
