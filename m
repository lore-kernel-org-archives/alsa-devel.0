From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - fix DigEn for Valleyview2 display
	codec
Date: Thu, 24 Oct 2013 18:02:40 -0400
Message-ID: <1382652160-13279-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 420A12625EF
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 07:00:02 +0200 (CEST)
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

On some Baytrail/Vallleyview platforms, DigEn is disabled on convertors.
Thus audio data is blocked from passing through the node and no sound can
be heard over HDMI/DP.

This patch fixes the covertor's DigEn when setting up a stream.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e332db8..f619732 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -45,6 +45,7 @@ module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
 #define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
+#define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
 
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
@@ -1061,6 +1062,20 @@ static void haswell_verify_D0(struct hda_codec *codec,
 	}
 }
 
+static void vlv_verify_digen(struct hda_codec *codec, hda_nid_t cvt_nid)
+{
+	unsigned int digi1;
+
+	digi1 = snd_hda_codec_read(codec, cvt_nid, 0,
+				  AC_VERB_GET_DIGI_CONVERT_1, 0);
+
+	if (!(digi1 & AC_DIG1_ENABLE))
+		snd_hda_codec_write_cache(codec, cvt_nid, 0,
+			AC_VERB_SET_DIGI_CONVERT_1,
+			(digi1 | AC_DIG1_ENABLE) & 0xff);
+
+}
+
 /*
  * Callbacks
  */
@@ -1078,6 +1093,9 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	if (is_haswell(codec))
 		haswell_verify_D0(codec, cvt_nid, pin_nid);
 
+	if (is_valleyview(codec))
+		vlv_verify_digen(codec, cvt_nid);
+
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
 					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-- 
1.8.1.2
