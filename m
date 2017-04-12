From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/3] ALSA: hda: Move common haswell init to a
	helper
Date: Wed, 12 Apr 2017 09:53:58 +0530
Message-ID: <1491971040-6039-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3269426684C
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 06:36:44 +0200 (CEST)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Geminilake vendor nid is different from other Skylake variants, but rest
of the initialization code is same.

So a variable is added in hdmi_spec to store the platform specific vendor
nid and move the initialization code to a helper function to be used by
both platform specific init.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 48 ++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 37f11560186a..7413fff06d70 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -177,6 +177,7 @@ struct hdmi_spec {
 	bool i915_bound; /* was i915 bound in this driver? */
 
 	struct hdac_chmap chmap;
+	hda_nid_t vendor_nid;
 };
 
 #ifdef CONFIG_SND_HDA_I915
@@ -2381,14 +2382,15 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 					  bool update_tree)
 {
 	unsigned int vendor_param;
+	struct hdmi_spec *spec = codec->spec;
 
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hda_codec_read(codec, spec->vendor_nid, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
 		return;
 
 	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hda_codec_read(codec, spec->vendor_nid, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 	if (vendor_param == -1)
 		return;
@@ -2400,8 +2402,9 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 {
 	unsigned int vendor_param;
+	struct hdmi_spec *spec = codec->spec;
 
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hda_codec_read(codec, spec->vendor_nid, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
 		return;
@@ -2409,7 +2412,7 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
 	snd_hdac_regmap_add_vendor_verb(&codec->core, INTEL_SET_VENDOR_VERB);
-	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
+	snd_hda_codec_write_cache(codec, spec->vendor_nid, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
@@ -2502,22 +2505,11 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 	}
 }
 
-/* Intel Haswell and onwards; audio component with eld notifier */
-static int patch_i915_hsw_hdmi(struct hda_codec *codec)
+static int intel_haswell_common_init(struct hda_codec *codec)
 {
-	struct hdmi_spec *spec;
+	struct hdmi_spec *spec = codec->spec;
 	int err;
 
-	/* HSW+ requires i915 binding */
-	if (!codec->bus->core.audio_component) {
-		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
-		return -ENODEV;
-	}
-
-	err = alloc_generic_hdmi(codec);
-	if (err < 0)
-		return err;
-	spec = codec->spec;
 	codec->dp_mst = true;
 	spec->dyn_pcm_assign = true;
 
@@ -2548,6 +2540,28 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
+/* Intel Haswell and onwards; audio component with eld notifier */
+static int patch_i915_hsw_hdmi(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec;
+	int err;
+
+	/* HSW+ requires i915 binding */
+	if (!codec->bus->core.audio_component) {
+		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
+		return -ENODEV;
+	}
+
+	err = alloc_generic_hdmi(codec);
+	if (err < 0)
+		return err;
+
+	spec = codec->spec;
+	spec->vendor_nid = INTEL_VENDOR_NID;
+
+	return intel_haswell_common_init(codec);
+}
+
 /* Intel Baytrail and Braswell; with eld notifier */
 static int patch_i915_byt_hdmi(struct hda_codec *codec)
 {
-- 
1.9.1
