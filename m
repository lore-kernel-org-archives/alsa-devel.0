From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 1/2] ALSA: hda: Move common haswell init to
	a helper
Date: Thu, 13 Apr 2017 13:05:35 +0530
Message-ID: <1492068936-8991-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 82FC826710B
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 09:48:21 +0200 (CEST)
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
Cc: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>, tiwai@suse.de, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>

Geminilake vendor nid is different from other Skylake variants, but rest
of the initialization code is same.

So a variable is added in hdmi_spec to store the platform specific vendor
nid and move the initialization code to a helper function to be used by
both platform specific init.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 37f11560186a..90e4ff87445e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -177,6 +177,7 @@ struct hdmi_spec {
 	bool i915_bound; /* was i915 bound in this driver? */
 
 	struct hdac_chmap chmap;
+	hda_nid_t vendor_nid;
 };
 
 #ifdef CONFIG_SND_HDA_I915
@@ -2372,6 +2373,7 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 }
 
 #define INTEL_VENDOR_NID 0x08
+#define INTEL_GLK_VENDOR_NID 0x0B
 #define INTEL_GET_VENDOR_VERB 0xf81
 #define INTEL_SET_VENDOR_VERB 0x781
 #define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
@@ -2381,14 +2383,15 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
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
@@ -2400,8 +2403,9 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 {
 	unsigned int vendor_param;
+	struct hdmi_spec *spec = codec->spec;
 
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+	vendor_param = snd_hda_codec_read(codec, spec->vendor_nid, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
 		return;
@@ -2409,7 +2413,7 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 	/* enable DP1.2 mode */
 	vendor_param |= INTEL_EN_DP12;
 	snd_hdac_regmap_add_vendor_verb(&codec->core, INTEL_SET_VENDOR_VERB);
-	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
+	snd_hda_codec_write_cache(codec, spec->vendor_nid, 0,
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
@@ -2503,7 +2507,7 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 }
 
 /* Intel Haswell and onwards; audio component with eld notifier */
-static int patch_i915_hsw_hdmi(struct hda_codec *codec)
+static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 {
 	struct hdmi_spec *spec;
 	int err;
@@ -2520,6 +2524,7 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	spec = codec->spec;
 	codec->dp_mst = true;
 	spec->dyn_pcm_assign = true;
+	spec->vendor_nid = vendor_nid;
 
 	intel_haswell_enable_all_pins(codec, true);
 	intel_haswell_fixup_enable_dp12(codec);
@@ -2548,6 +2553,16 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
+static int patch_i915_hsw_hdmi(struct hda_codec *codec)
+{
+	return intel_hsw_common_init(codec, INTEL_VENDOR_NID);
+}
+
+static int patch_i915_glk_hdmi(struct hda_codec *codec)
+{
+	return intel_hsw_common_init(codec, INTEL_GLK_VENDOR_NID);
+}
+
 /* Intel Baytrail and Braswell; with eld notifier */
 static int patch_i915_byt_hdmi(struct hda_codec *codec)
 {
@@ -3800,7 +3815,7 @@ static int patch_via_hdmi(struct hda_codec *codec)
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
-HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_hsw_hdmi),
+HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
1.9.1
