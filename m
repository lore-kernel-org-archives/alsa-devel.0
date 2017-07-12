From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2] ALSA: hda - Add hdmi id for a Geminilake
	variant
Date: Wed, 12 Jul 2017 20:12:04 +0530
Message-ID: <1499870524-6376-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ED292266C21
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 16:57:48 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Few GLK platform variants report a different vendor id. Add it.
Also add the missing check for GLK in is_haswell_plus().

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---

v1 -> v2:
	Fix a typo in commit message
	update the commit message to add glk check in is_haswell_plus()

 sound/pci/hda/patch_hdmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 76c85f08bea6..d549f35f39d3 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -53,9 +53,11 @@
 #define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
 #define is_broxton(codec) ((codec)->core.vendor_id == 0x8086280a)
 #define is_kabylake(codec) ((codec)->core.vendor_id == 0x8086280b)
+#define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
+				((codec)->core.vendor_id == 0x80862800))
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
 				|| is_skylake(codec) || is_broxton(codec) \
-				|| is_kabylake(codec))
+				|| is_kabylake(codec)) || is_geminilake(codec)
 
 #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
@@ -3790,6 +3792,7 @@ static int patch_via_hdmi(struct hda_codec *codec)
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
+HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
1.9.1
