From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 7/7] ALSA: hda - Enable i915 ELD notifier for
	Intel IronLake and Baytrail
Date: Tue, 22 Mar 2016 12:29:33 +0100
Message-ID: <1458646173-14520-8-git-send-email-tiwai@suse.de>
References: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BE072652EE
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 12:29:36 +0100 (CET)
In-Reply-To: <1458646173-14520-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Since we have the fixed pin-port mapping for Intel IronLake (IbexPeak)
and Baytrail (ValleyView) platforms in the code side, now it's time to
add the support in the codec driver side.  This patch simply enables
the i915 ELD notifier for these in addition with the fix of the
mapping from the port to NID in the callback.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7e09f5e584c6..4833c7bdd1e8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2274,12 +2274,23 @@ static void haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 static void intel_pin_eld_notify(void *audio_ptr, int port)
 {
 	struct hda_codec *codec = audio_ptr;
-	int pin_nid = port + 0x04;
+	int pin_nid;
 
 	/* we assume only from port-B to port-D */
 	if (port < 1 || port > 3)
 		return;
 
+	switch (codec->core.vendor_id) {
+	case 0x80860054: /* ILK */
+	case 0x80862804: /* ILK */
+	case 0x80862882: /* VLV */
+		pin_nid = port + 0x03;
+		break;
+	default:
+		pin_nid = port + 0x04;
+		break;
+	}
+
 	/* skip notification during system suspend (but not in runtime PM);
 	 * the state will be updated at resume
 	 */
@@ -2375,7 +2386,7 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
-/* Intel Baytrail and Braswell; without get_eld notifier */
+/* Intel Baytrail and Braswell; with eld notifier */
 static int patch_i915_byt_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -2409,10 +2420,11 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 	}
 
 	generic_hdmi_init_per_pins(codec);
+	register_i915_notifier(codec);
 	return 0;
 }
 
-/* Intel SandyBridge and IvyBridge; with i915 eld notifier */
+/* Intel IronLake, SandyBridge and IvyBridge; with eld notifier */
 static int patch_i915_cpt_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -3614,11 +3626,11 @@ HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x11069f85, "VX11 HDMI/DP",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80862804, "IbexPeak HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x80862804, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862805, "CougarPoint HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862806, "PantherPoint HDMI", patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862807, "Haswell HDMI",	patch_i915_hsw_hdmi),
-- 
2.7.4
