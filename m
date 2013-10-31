From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - not choose assigned converters for
	unused pins of Valleyview
Date: Thu, 31 Oct 2013 18:31:51 -0400
Message-ID: <1383258711-28218-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D0C1A261B2F
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 06:29:00 +0100 (CET)
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

For Valleyview display codec, if an unused pin chooses an assgined converter
selected by a used pin, playback on the unused pin can also give sound to the
output device of the used pin. It's because data flows from the same convertor
to the display port of the used pin. This issue is same as Haswell.

So this patch avoids using assinged convertors for unused pins.
The related function haswell_config_cvts() is renamed for code reuse.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e332db8..bcf764f 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -45,6 +45,7 @@ module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
 #define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
+#define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
 
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
@@ -1148,7 +1149,7 @@ static int hdmi_choose_cvt(struct hda_codec *codec,
 	return 0;
 }
 
-static void haswell_config_cvts(struct hda_codec *codec,
+static void not_share_unassigned_cvt(struct hda_codec *codec,
 			hda_nid_t pin_nid, int mux_idx)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1226,8 +1227,8 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 			    mux_idx);
 
 	/* configure unused pins to choose other converters */
-	if (is_haswell(codec))
-		haswell_config_cvts(codec, per_pin->pin_nid, mux_idx);
+	if (is_haswell(codec) || is_valleyview(codec))
+		not_share_unassigned_cvt(codec, per_pin->pin_nid, mux_idx);
 
 	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
 
-- 
1.8.1.2
