From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH] ALSA: hda - Haswell converter power state D0
	verify
Date: Tue, 18 Jun 2013 10:41:53 +0800
Message-ID: <1371523313-25751-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FB762650C2
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 05:10:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, david.henningsson@canonical.com
Cc: daniel.vetter@ffwll.ch, alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@linux.intel.com>, intel-gfx@lists.freedesktop.org, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Haswell converters maybe in wrong power state before usage.
i.e. only converter 0 is in D0, converter 1/2 are in D3.
When pin choose converter 1/2, there's no audio output, this
cause dependency when playing differnt stream on pins.

AUD_PWRST  ConvertorA_Widget_Power_State_Current        D0
AUD_PWRST  ConvertorA_Widget_Power_State_Requsted       D0
AUD_PWRST  ConvertorB_Widget_Power_State_Current        D3
AUD_PWRST  ConvertorB_Widget_Power_State_Requested      D3
AUD_PWRST  ConvC_Widget_PwrSt_Curr                      D3
AUD_PWRST  ConvC_Widget_PwrSt_Req                       D3

This patch check converter's power state and set D0 if it's in D3 mode.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index e12f7a0..760eeb1 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1018,10 +1018,19 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 		hdmi_non_intrinsic_event(codec, res);
 }
 
-static void haswell_verify_pin_D0(struct hda_codec *codec, hda_nid_t nid)
+static void haswell_verify_pin_D0(struct hda_codec *codec,
+		hda_nid_t cvt_nid, hda_nid_t nid)
 {
 	int pwr, lamp, ramp;
 
+	/* For Haswell, the converter 1/2 may keep in D3 state after bootup,
+	 * thus pins could only choose converter 0 for use. Make sure the
+	 * converters are in correct power state */
+	pwr = snd_hda_codec_read(codec, cvt_nid, 0, AC_VERB_GET_POWER_STATE, 0);
+	pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+	if (pwr != AC_PWRST_D0)
+		snd_hda_codec_write(codec, cvt_nid, 0, AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+
 	pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
 	pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
 	if (pwr != AC_PWRST_D0) {
@@ -1068,7 +1077,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	int new_pinctl = 0;
 
 	if (codec->vendor_id == 0x80862807)
-		haswell_verify_pin_D0(codec, pin_nid);
+		haswell_verify_pin_D0(codec, cvt_nid, pin_nid);
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
-- 
1.8.1.2
