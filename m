From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 2/3] ALSA: hda: Add Geminilake vendor nid
Date: Wed, 12 Apr 2017 09:53:59 +0530
Message-ID: <1491971040-6039-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1491971040-6039-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CC5DE266E00
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 06:36:46 +0200 (CEST)
In-Reply-To: <1491971040-6039-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>

Separate out the Geminilake platform init and add vendor nid for it.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Ander Conselvan De Oliveira <ander.conselvan.de.oliveira@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 7413fff06d70..843f5fe1dfb5 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2373,6 +2373,7 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 }
 
 #define INTEL_VENDOR_NID 0x08
+#define INTEL_GLK_VENDOR_NID 0x0B
 #define INTEL_GET_VENDOR_VERB 0xf81
 #define INTEL_SET_VENDOR_VERB 0x781
 #define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
@@ -2562,6 +2563,27 @@ static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 	return intel_haswell_common_init(codec);
 }
 
+static int patch_i915_glk_hdmi(struct hda_codec *codec)
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
+	spec->vendor_nid = INTEL_GLK_VENDOR_NID;
+
+	return intel_haswell_common_init(codec);
+}
+
 /* Intel Baytrail and Braswell; with eld notifier */
 static int patch_i915_byt_hdmi(struct hda_codec *codec)
 {
@@ -3814,7 +3836,7 @@ static int patch_via_hdmi(struct hda_codec *codec)
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
