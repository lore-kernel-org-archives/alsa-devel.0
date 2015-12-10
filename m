From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Allow i915 binding later in
	codec driver
Date: Thu, 10 Dec 2015 13:11:48 +0100
Message-ID: <1449749508-1118-2-git-send-email-tiwai@suse.de>
References: <1449749508-1118-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E016265238
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 13:11:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 519D1AC3B
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:11:51 +0000 (UTC)
In-Reply-To: <1449749508-1118-1-git-send-email-tiwai@suse.de>
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

Due to the recent change, HDA controller driver for Intel PCH tries to
bind i915 audio component always at the probe time no matter whether
HDMI/DP codec is found.  This is, however, superflulous for old
chipsets (e.g. on IVB) where they don't have always the HDMI/DP codecs
but  often have only a discrete GPU instead.

For the newer chipsets, we need already the i915 binding from the
beginning due to power well control.  Meanwhile, for older chipsets
where we don't need power well, we don't need the i915 binding at the
controller level.

This patch removes again the i915 binding in the HDA controller driver
for old Intel PCHs, but adds the binding in HDMI/DP codec driver
instead.  This allows still the use of the direct notification from
the graphics driver while we can avoid the unnecessary load of i915
driver for machines only with another GPU.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c  |  6 +++---
 sound/pci/hda/patch_hdmi.c | 11 +++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b49547f3c2e9..fe9bef339cea 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -288,11 +288,11 @@ enum {
 	(AZX_DCAPS_NO_ALIGN_BUFSIZE | AZX_DCAPS_COUNT_LPIB_DELAY |\
 	 AZX_DCAPS_REVERSE_ASSIGN | AZX_DCAPS_SNOOP_TYPE(SCH))
 
-/* PCH up to IVB; bound with i915 audio component for HDMI, no runtime PM */
+/* PCH up to IVB; no runtime PM */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_POWERWELL)
+	(AZX_DCAPS_INTEL_PCH_BASE)
 
-/* PCH for HSW/BDW; with runtime PM, but no i915 binding */
+/* PCH for HSW/BDW; with runtime PM */
 #define AZX_DCAPS_INTEL_PCH \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME)
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 44d0d2374bb6..35a78a6f87a6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -150,6 +150,7 @@ struct hdmi_spec {
 
 	/* i915/powerwell (Haswell+/Valleyview+) specific */
 	struct i915_audio_component_audio_ops i915_audio_ops;
+	bool i915_bound; /* was i915 bound in this driver? */
 };
 
 #ifdef CONFIG_SND_HDA_I915
@@ -2234,6 +2235,8 @@ static void generic_hdmi_free(struct hda_codec *codec)
 		eld_proc_free(per_pin);
 	}
 
+	if (spec->i915_bound)
+		snd_hdac_i915_exit(&codec->bus->core);
 	hdmi_array_free(spec);
 	kfree(spec);
 }
@@ -2381,6 +2384,12 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
+	/* Try to bind with i915 for any Intel codecs (if not done yet) */
+	if (!codec_has_acomp(codec) &&
+	    (codec->core.vendor_id >> 16) == 0x8086)
+		if (!snd_hdac_i915_init(&codec->bus->core))
+			spec->i915_bound = true;
+
 	if (is_haswell_plus(codec)) {
 		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
@@ -2404,6 +2413,8 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	}
 
 	if (hdmi_parse_codec(codec) < 0) {
+		if (spec->i915_bound)
+			snd_hdac_i915_exit(&codec->bus->core);
 		codec->spec = NULL;
 		kfree(spec);
 		return -EINVAL;
-- 
2.6.3
