From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Enable i915 binding for gen3/4
	HDMI/DP
Date: Wed, 30 Mar 2016 17:46:01 +0200
Message-ID: <1459352762-28681-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 92B9226501B
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 17:46:04 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7BB11AC8D
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 15:46:03 +0000 (UTC)
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

This patch fills the holes and now all i915 HDMI/DP codecs are managed
over the audio ELD notifier, finally.  The old gen3/gen4 chips have
usually only a single pin/converter pair, and the digital port mapping
is fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_i915.c      | 11 +++++++++++
 sound/pci/hda/patch_hdmi.c | 21 +++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index d0da2508823e..c62a9f830b84 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -128,6 +128,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_get_display_clk);
  * Pin Widget 4 - PORT B (port = 1 in i915 driver)
  * Pin Widget 5 - PORT C (port = 2 in i915 driver)
  * Pin Widget 6 - PORT D (port = 3 in i915 driver)
+ *
+ * on earlier models:
+ * Pin Widget 3 - PORT B
  */
 static int pin2port(struct hdac_device *codec, hda_nid_t pin_nid)
 {
@@ -139,6 +142,14 @@ static int pin2port(struct hdac_device *codec, hda_nid_t pin_nid)
 	case 0x80862882: /* VLV */
 		base_nid = 3;
 		break;
+	case 0x80862801: /* Bearlake */
+	case 0x80862802: /* Cantiga */
+	case 0x80862803: /* Eaglelake */
+	case 0x80862880: /* CedarTrail */
+	case 0x808629fb: /* Crestline HDMI */
+		if (WARN_ON(pin_nid != 0x03))
+			return -1;
+		return 1; /* only port B */
 	default:
 		base_nid = 4;
 		break;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4833c7bdd1e8..2a3bf1584f3b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2286,6 +2286,15 @@ static void intel_pin_eld_notify(void *audio_ptr, int port)
 	case 0x80862882: /* VLV */
 		pin_nid = port + 0x03;
 		break;
+	case 0x80862801: /* Bearlake */
+	case 0x80862802: /* Cantiga */
+	case 0x80862803: /* Eaglelake */
+	case 0x80862880: /* CedarTrail */
+	case 0x808629fb: /* Crestline HDMI */
+		if (WARN_ON(port != 1)) /* assume only port B */
+			return;
+		pin_nid = 0x03;
+		break;
 	default:
 		pin_nid = port + 0x04;
 		break;
@@ -2424,7 +2433,7 @@ static int patch_i915_byt_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
-/* Intel IronLake, SandyBridge and IvyBridge; with eld notifier */
+/* Intel Gen3/Gen4, IronLake, SandyBridge and IvyBridge; with eld notifier */
 static int patch_i915_cpt_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -3627,9 +3636,9 @@ HDA_CODEC_ENTRY(0x11069f81, "VX900 HDMI/DP",	patch_via_hdmi),
 HDA_CODEC_ENTRY(0x11069f84, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x11069f85, "VX11 HDMI/DP",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80860054, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
-HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_generic_hdmi),
-HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x80862801, "Bearlake HDMI",	patch_i915_cpt_hdmi),
+HDA_CODEC_ENTRY(0x80862802, "Cantiga HDMI",	patch_i915_cpt_hdmi),
+HDA_CODEC_ENTRY(0x80862803, "Eaglelake HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862804, "IbexPeak HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862805, "CougarPoint HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862806, "PantherPoint HDMI", patch_i915_cpt_hdmi),
@@ -3638,10 +3647,10 @@ HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
-HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_i915_cpt_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-HDA_CODEC_ENTRY(0x808629fb, "Crestline HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x808629fb, "Crestline HDMI",	patch_i915_cpt_hdmi),
 /* special ID for generic HDMI */
 HDA_CODEC_ENTRY(HDA_CODEC_ID_GENERIC_HDMI, "Generic HDMI", patch_generic_hdmi),
 {} /* terminator */
-- 
2.7.4
