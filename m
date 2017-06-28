From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Minor code refactoring for
	Intel HDMI codec parsers
Date: Wed, 28 Jun 2017 14:58:54 +0200
Message-ID: <20170628125854.13022-5-tiwai@suse.de>
References: <20170628125854.13022-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 006BA2670F9
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 14:58:55 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id A817AAEEE
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

No functional change, just a slight reduction of lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 87 ++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index feed8e8de2af..8704ea43381e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2503,19 +2503,41 @@ static void i915_pin_cvt_fixup(struct hda_codec *codec,
 	}
 }
 
-/* Intel Haswell and onwards; audio component with eld notifier */
-static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
+/* precondition and allocation for Intel codecs */
+static int alloc_intel_hdmi(struct hda_codec *codec)
 {
-	struct hdmi_spec *spec;
-	int err;
-
-	/* HSW+ requires i915 binding */
+	/* requires i915 binding */
 	if (!codec->bus->core.audio_component) {
 		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
 		return -ENODEV;
 	}
 
-	err = alloc_generic_hdmi(codec);
+	return alloc_generic_hdmi(codec);
+}
+
+/* parse and post-process for Intel codecs */
+static int parse_intel_hdmi(struct hda_codec *codec)
+{
+	int err;
+
+	err = hdmi_parse_codec(codec);
+	if (err < 0) {
+		generic_spec_free(codec);
+		return err;
+	}
+
+	generic_hdmi_init_per_pins(codec);
+	register_i915_notifier(codec);
+	return 0;
+}
+
+/* Intel Haswell and onwards; audio component with eld notifier */
+static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
+{
+	struct hdmi_spec *spec;
+	int err;
+
+	err = alloc_intel_hdmi(codec);
 	if (err < 0)
 		return err;
 	spec = codec->spec;
@@ -2539,15 +2561,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 	spec->ops.setup_stream = i915_hsw_setup_stream;
 	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
 
-	err = hdmi_parse_codec(codec);
-	if (err < 0) {
-		generic_spec_free(codec);
-		return err;
-	}
-
-	generic_hdmi_init_per_pins(codec);
-	register_i915_notifier(codec);
-	return 0;
+	return parse_intel_hdmi(codec);
 }
 
 static int patch_i915_hsw_hdmi(struct hda_codec *codec)
@@ -2566,13 +2580,7 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 	struct hdmi_spec *spec;
 	int err;
 
-	/* requires i915 binding */
-	if (!codec->bus->core.audio_component) {
-		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
-		return -ENODEV;
-	}
-
-	err = alloc_generic_hdmi(codec);
+	err = alloc_intel_hdmi(codec);
 	if (err < 0)
 		return err;
 	spec = codec->spec;
@@ -2587,45 +2595,18 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 
 	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
 
-	err = hdmi_parse_codec(codec);
-	if (err < 0) {
-		generic_spec_free(codec);
-		return err;
-	}
-
-	generic_hdmi_init_per_pins(codec);
-	register_i915_notifier(codec);
-	return 0;
+	return parse_intel_hdmi(codec);
 }
 
 /* Intel IronLake, SandyBridge and IvyBridge; with eld notifier */
 static int patch_i915_cpt_hdmi(struct hda_codec *codec)
 {
-	struct hdmi_spec *spec;
 	int err;
 
-	/* requires i915 binding */
-	if (!codec->bus->core.audio_component) {
-		codec_info(codec, "No i915 binding for Intel HDMI/DP codec\n");
-		return -ENODEV;
-	}
-
-	err = alloc_generic_hdmi(codec);
+	err = alloc_intel_hdmi(codec);
 	if (err < 0)
 		return err;
-	spec = codec->spec;
-
-	err = hdmi_parse_codec(codec);
-	if (err < 0)
-		goto error;
-
-	generic_hdmi_init_per_pins(codec);
-	register_i915_notifier(codec);
-	return 0;
-
- error:
-	generic_spec_free(codec);
-	return err;
+	return parse_intel_hdmi(codec);
 }
 
 /*
-- 
2.13.2
