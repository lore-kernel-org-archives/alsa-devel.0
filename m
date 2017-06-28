From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: hda - Bind with i915 component
	before codec binding
Date: Wed, 28 Jun 2017 14:58:53 +0200
Message-ID: <20170628125854.13022-4-tiwai@suse.de>
References: <20170628125854.13022-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F33A62670EC
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:58:55 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9E9ADAEED
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 12:58:55 +0000 (UTC)
In-Reply-To: <20170628125854.13022-1-tiwai@suse.de>
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

We used a on-demand i915 component binding for IvyBridge and
SandyBridge HDMI codecs, but it has a potential problem of the nested
module loading.  For avoiding that situation, assure the i915 binding
happening at the controller driver level for PCH controller devices,
where the initialization is performed in a detached work, instead of
calling from the codec driver probe.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c  |  4 ++--
 sound/pci/hda/patch_hdmi.c | 17 +++++------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 01eb1dc7b5b3..2db3203090ed 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -294,11 +294,11 @@ enum {
 
 /* PCH up to IVB; no runtime PM */
 #define AZX_DCAPS_INTEL_PCH_NOPM \
-	(AZX_DCAPS_INTEL_PCH_BASE)
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_I915_POWERWELL)
 
 /* PCH for HSW/BDW; with runtime PM */
 #define AZX_DCAPS_INTEL_PCH \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME)
+	(AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
 
 /* HSW HDMI */
 #define AZX_DCAPS_INTEL_HASWELL \
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 90e4ff87445e..feed8e8de2af 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -174,7 +174,6 @@ struct hdmi_spec {
 	/* i915/powerwell (Haswell+/Valleyview+) specific */
 	bool use_acomp_notifier; /* use i915 eld_notify callback for hotplug */
 	struct i915_audio_component_audio_ops i915_audio_ops;
-	bool i915_bound; /* was i915 bound in this driver? */
 
 	struct hdac_chmap chmap;
 	hda_nid_t vendor_nid;
@@ -2234,8 +2233,6 @@ static void generic_spec_free(struct hda_codec *codec)
 	struct hdmi_spec *spec = codec->spec;
 
 	if (spec) {
-		if (spec->i915_bound)
-			snd_hdac_i915_exit(&codec->bus->core);
 		hdmi_array_free(spec);
 		kfree(spec);
 		codec->spec = NULL;
@@ -2607,21 +2604,17 @@ static int patch_i915_cpt_hdmi(struct hda_codec *codec)
 	struct hdmi_spec *spec;
 	int err;
 
-	/* no i915 component should have been bound before this */
-	if (WARN_ON(codec->bus->core.audio_component))
-		return -EBUSY;
+	/* requires i915 binding */
+	if (!codec->bus->core.audio_component) {
+		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
+		return -ENODEV;
+	}
 
 	err = alloc_generic_hdmi(codec);
 	if (err < 0)
 		return err;
 	spec = codec->spec;
 
-	/* Try to bind with i915 now */
-	err = snd_hdac_i915_init(&codec->bus->core);
-	if (err < 0)
-		goto error;
-	spec->i915_bound = true;
-
 	err = hdmi_parse_codec(codec);
 	if (err < 0)
 		goto error;
-- 
2.13.2
