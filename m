From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda: hdmi - add Icelake support
Date: Wed, 13 Mar 2019 17:09:23 +0100
Message-ID: <20190313160923.10471-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3652F8961E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 17:09:37 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard liao <bard.liao@intel.com>
List-Id: alsa-devel@alsa-project.org

This is just a port of the ASoC Icelake HDMI codec code to the legacy
HDA driver with some cleanups.

ASoC commit 019033c854a20e10f691f6cc0e897df8817d9521:
  "ASoC: Intel: hdac_hdmi: add Icelake support"

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: Bard liao <bard.liao@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 67 +++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 73d7042ff884..8b3ac690efa3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -57,10 +57,11 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 #define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
 				((codec)->core.vendor_id == 0x80862800))
 #define is_cannonlake(codec) ((codec)->core.vendor_id == 0x8086280c)
+#define is_icelake(codec) ((codec)->core.vendor_id == 0x8086280f)
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
 				|| is_skylake(codec) || is_broxton(codec) \
-				|| is_kabylake(codec)) || is_geminilake(codec) \
-				|| is_cannonlake(codec)
+				|| is_kabylake(codec) || is_geminilake(codec) \
+				|| is_cannonlake(codec) || is_icelake(codec))
 #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
 #define is_valleyview_plus(codec) (is_valleyview(codec) || is_cherryview(codec))
@@ -181,6 +182,8 @@ struct hdmi_spec {
 
 	struct hdac_chmap chmap;
 	hda_nid_t vendor_nid;
+	const int *port_map;
+	int port_num;
 };
 
 #ifdef CONFIG_SND_HDA_COMPONENT
@@ -2418,12 +2421,11 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 	snd_hda_override_conn_list(codec, nid, spec->num_cvts, spec->cvt_nids);
 }
 
-#define INTEL_VENDOR_NID 0x08
-#define INTEL_GLK_VENDOR_NID 0x0B
-#define INTEL_GET_VENDOR_VERB 0xf81
-#define INTEL_SET_VENDOR_VERB 0x781
-#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
-#define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
+#define INTEL_GET_VENDOR_VERB	0xf81
+#define INTEL_GET_VENDOR_VERB	0xf81
+#define INTEL_SET_VENDOR_VERB	0x781
+#define INTEL_EN_DP12		0x02	/* enable DP 1.2 features */
+#define INTEL_EN_ALL_PIN_CVTS	0x01	/* enable 2nd & 3rd pins and convertors */
 
 static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 					  bool update_tree)
@@ -2503,11 +2505,29 @@ static int intel_base_nid(struct hda_codec *codec)
 
 static int intel_pin2port(void *audio_ptr, int pin_nid)
 {
-	int base_nid = intel_base_nid(audio_ptr);
+	struct hda_codec *codec = audio_ptr;
+	struct hdmi_spec *spec = codec->spec;
+	int base_nid, i;
 
-	if (WARN_ON(pin_nid < base_nid || pin_nid >= base_nid + 3))
-		return -1;
-	return pin_nid - base_nid + 1; /* intel port is 1-based */
+	if (!spec->port_num) {
+		base_nid = intel_base_nid(codec);
+		if (WARN_ON(pin_nid < base_nid || pin_nid >= base_nid + 3))
+			return -1;
+		return pin_nid - base_nid + 1; /* intel port is 1-based */
+	}
+
+	/*
+	 * looking for the pin number in the mapping table and return
+	 * the index which indicate the port number
+	 */
+	for (i = 0; i < spec->port_num; i++) {
+		if (pin_nid == spec->port_map[i])
+			return i + 1;
+	}
+
+	/* return -1 if pin number exceeds our expectation */
+	codec_info(codec, "Can't find the HDMI/DP port for pin %d\n", pin_nid);
+	return -1;
 }
 
 static void intel_pin_eld_notify(void *audio_ptr, int port, int pipe)
@@ -2608,7 +2628,8 @@ static int parse_intel_hdmi(struct hda_codec *codec)
 }
 
 /* Intel Haswell and onwards; audio component with eld notifier */
-static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
+static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
+				 const int *port_map, int port_num)
 {
 	struct hdmi_spec *spec;
 	int err;
@@ -2620,6 +2641,8 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 	codec->dp_mst = true;
 	spec->dyn_pcm_assign = true;
 	spec->vendor_nid = vendor_nid;
+	spec->port_map = port_map;
+	spec->port_num = port_num;
 
 	intel_haswell_enable_all_pins(codec, true);
 	intel_haswell_fixup_enable_dp12(codec);
@@ -2638,12 +2661,23 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid)
 
 static int patch_i915_hsw_hdmi(struct hda_codec *codec)
 {
-	return intel_hsw_common_init(codec, INTEL_VENDOR_NID);
+	return intel_hsw_common_init(codec, 0x08, NULL, 0);
 }
 
 static int patch_i915_glk_hdmi(struct hda_codec *codec)
 {
-	return intel_hsw_common_init(codec, INTEL_GLK_VENDOR_NID);
+	return intel_hsw_common_init(codec, 0x0b, NULL, 0);
+}
+
+static int patch_i915_icl_hdmi(struct hda_codec *codec)
+{
+	/*
+	 * pin to port mapping table where the value indicate the pin number and
+	 * the index indicate the port number with 1 base.
+	 */
+	static const int map[] = {0x4, 0x6, 0x8, 0xa, 0xb};
+
+	return intel_hsw_common_init(codec, 0x02, map, ARRAY_SIZE(map));
 }
 
 /* Intel Baytrail and Braswell; with eld notifier */
@@ -3886,6 +3920,7 @@ HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x11069f85, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
+HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_generic_hdmi),
@@ -3899,7 +3934,7 @@ HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280c, "Cannonlake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
-HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
+HDA_CODEC_ENTRY(0x8086280f, "Icelake HDMI",	patch_i915_icl_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.20.1
