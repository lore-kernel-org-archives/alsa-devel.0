From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/7] ALSA: hda - Use eld notifier for Intel
	SandyBridge and IvyBridge HDMI/DP
Date: Tue, 22 Mar 2016 12:29:31 +0100
Message-ID: <1458646173-14520-6-git-send-email-tiwai@suse.de>
References: <1458646173-14520-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C640265834
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

Intel SandyBridge and IvyBridge (CougarPoint and PantherPoint
platforms) have also the same digital port vs audio widget mapping
(from port B = NID 0x05 to port D = NID 0x07) as Haswell & co.
So, we can reuse the existing functions for HSW+ for these platforms
without changing there, but just by re-adding the on-demand i915
binding in HDMI codec driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 3481b43476dc..09eb26c5730c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -157,6 +157,7 @@ struct hdmi_spec {
 	/* i915/powerwell (Haswell+/Valleyview+) specific */
 	bool use_acomp_notifier; /* use i915 eld_notify callback for hotplug */
 	struct i915_audio_component_audio_ops i915_audio_ops;
+	bool i915_bound; /* was i915 bound in this driver? */
 
 	struct hdac_chmap chmap;
 };
@@ -2077,6 +2078,8 @@ static void generic_spec_free(struct hda_codec *codec)
 	struct hdmi_spec *spec = codec->spec;
 
 	if (spec) {
+		if (spec->i915_bound)
+			snd_hdac_i915_exit(&codec->bus->core);
 		hdmi_array_free(spec);
 		kfree(spec);
 		codec->spec = NULL;
@@ -2409,6 +2412,40 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
+/* Intel SandyBridge and IvyBridge; with i915 eld notifier */
+static int patch_i915_cpt_hdmi(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec;
+	int err;
+
+	/* no i915 component should have been bound before this */
+	if (WARN_ON(codec->bus->core.audio_component))
+		return -EBUSY;
+
+	err = alloc_generic_hdmi(codec);
+	if (err < 0)
+		return err;
+	spec = codec->spec;
+
+	/* Try to bind with i915 now */
+	err = snd_hdac_i915_init(&codec->bus->core);
+	if (err < 0)
+		goto error;
+	spec->i915_bound = true;
+
+	err = hdmi_parse_codec(codec);
+	if (err < 0)
+		goto error;
+
+	generic_hdmi_init_per_pins(codec);
+	register_i915_notifier(codec);
+	return 0;
+
+ error:
+	generic_spec_free(codec);
+	return err;
+}
+
 /*
  * Shared non-generic implementations
  */
@@ -3582,8 +3619,8 @@ HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862804, "IbexPeak HDMI",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80862805, "CougarPoint HDMI",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80862806, "PantherPoint HDMI", patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x80862805, "CougarPoint HDMI",	patch_i915_cpt_hdmi),
+HDA_CODEC_ENTRY(0x80862806, "PantherPoint HDMI", patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862807, "Haswell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
-- 
2.7.4
