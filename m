From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - rename function
	not_share_unassigned_cvt()
Date: Mon,  4 Nov 2013 01:13:13 -0500
Message-ID: <de4ffa239982a24442d51ebe62ce79c85a76d7a6.1383545538.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA37261AEC
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 14:10:17 +0100 (CET)
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

The function name not_share_unassigned_cvt() is opposite to what it does.
This patch renames it to intel_not_share_assigned_cvt(), and addes comments
to explain why some Intel display codecs need this workaround.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bcf764f..1b1fe68 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1149,7 +1149,16 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
 	return 0;
 }
 
-static void not_share_unassigned_cvt(struct hda_codec *codec,
+/* Intel HDMI workaround to fix audio routing issue:
+ * For some Intel display codecs, pins share the same connection list.
+ * So a conveter can be selected by multiple pins and playback on any of these
+ * pins will generate sound on the external display, because audio flows from
+ * the same converter to the display pipeline. Also muting one pin may make
+ * other pins have no sound output.
+ * So this function assures that an assigned converter for a pin is not selected
+ * by any other pins.
+ */
+static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 			hda_nid_t pin_nid, int mux_idx)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1228,7 +1237,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 
 	/* configure unused pins to choose other converters */
 	if (is_haswell(codec) || is_valleyview(codec))
-		not_share_unassigned_cvt(codec, per_pin->pin_nid, mux_idx);
+		intel_not_share_assigned_cvt(codec, per_pin->pin_nid, mux_idx);
 
 	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
 
-- 
1.8.1.2
