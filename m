From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable audio component for old
	Intel PCH devices
Date: Fri,  4 Dec 2015 16:17:50 +0100
Message-ID: <1449242270-5617-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B15C261B0E
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 16:17:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E6A74AD20
 for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2015 15:17:52 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

As i915 graphics driver provides the notification via audio component,
not only the currently implemented HSW+ and VLV+ platforms but also
all other PCH-based platforms (e.g. Cougar Point, Panther  Point, etc)
can use this infrastructure.  It'll improve the reliability and the
power consumption significantly, especially once when we implement the
ELD notification via component.  As a preliminary, this patch enables
the usage of audio component for all PCH platforms.

The HDA controller just needs to set AZX_DCAPS_I915_POWERWELL flag
appropriately.  The name of the flag is a bit confusing, but this
actually works even on the chips without the powerwell but accesses
only the other component ops.

In the HDMI/DP codec driver side, we just need to register/unregister
the notifier for such chips.  This can be identified by checking the
audio_component field in the assigned hdac_bus.

One caveat is that PCH for Haswell and Broadwell must not be bound
with i915 audio component, as there are dedicated HD-audio HDMI
controllers on these platforms.  Ditto for Poulsbo and Oaktrail as
they use gma500 graphics, not i915.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c  | 14 ++++++++++----
 sound/pci/hda/patch_hdmi.c |  6 ++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 963f82430938..ee0e316401f9 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -284,13 +284,19 @@ enum {
 	(AZX_DCAPS_OLD_SSYNC | AZX_DCAPS_NO_ALIGN_BUFSIZE)
 
 /* quirks for Intel PCH */
-#define AZX_DCAPS_INTEL_PCH_NOPM \
+#define AZX_DCAPS_INTEL_PCH_BASE \
 	(AZX_DCAPS_NO_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_REVERSE_ASSIGN | AZX_DCAPS_SNOOP_TYPE(SCH))
 
+/* PCH up to IVB; bound with i915 audio component for HDMI, no runtime PM */
+#define AZX_DCAPS_INTEL_PCH_NOPM \
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_POWERWELL)
+
+/* PCH for HSW/BDW; with runtime PM, but no i915 binding */
 #define AZX_DCAPS_INTEL_PCH \
-	(AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME)
 
+/* HSW HDMI */
 #define AZX_DCAPS_INTEL_HASWELL \
 	(/*AZX_DCAPS_ALIGN_BUFSIZE |*/ AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_PM_RUNTIME | AZX_DCAPS_I915_POWERWELL |\
@@ -2146,10 +2152,10 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* Poulsbo */
 	{ PCI_DEVICE(0x8086, 0x811b),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE },
 	/* Oaktrail */
 	{ PCI_DEVICE(0x8086, 0x080a),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_BASE },
 	/* BayTrail */
 	{ PCI_DEVICE(0x8086, 0x0f04),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_BAYTRAIL },
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a918377d3e9b..85342d261043 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -152,6 +152,8 @@ struct hdmi_spec {
 	struct i915_audio_component_audio_ops i915_audio_ops;
 };
 
+#define codec_has_acomp(codec) \
+	((codec)->bus->core.audio_component != NULL)
 
 struct hdmi_audio_infoframe {
 	u8 type; /* 0x84 */
@@ -2218,7 +2220,7 @@ static void generic_hdmi_free(struct hda_codec *codec)
 	struct hdmi_spec *spec = codec->spec;
 	int pin_idx;
 
-	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
+	if (codec_has_acomp(codec))
 		snd_hdac_i915_register_notifier(NULL);
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
@@ -2390,7 +2392,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 			is_broxton(codec))
 		codec->core.link_power_control = 1;
 
-	if (is_haswell_plus(codec) || is_valleyview_plus(codec)) {
+	if (codec_has_acomp(codec)) {
 		codec->depop_delay = 0;
 		spec->i915_audio_ops.audio_ptr = codec;
 		spec->i915_audio_ops.pin_eld_notify = intel_pin_eld_notify;
-- 
2.6.3
