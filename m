From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH] ALSA: hda - Add vendor id for Cannonlake HDMI
	codec
Date: Thu,  7 Dec 2017 18:06:20 +0530
Message-ID: <20171207123620.25640-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DB258266E0E
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 13:36:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>
List-Id: alsa-devel@alsa-project.org

Cannonlake HDMI codec has the same nid as Geminilake. This adds the
codec entry for it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c19c81d230bd..b4f1b6e88305 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -55,10 +55,11 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 #define is_kabylake(codec) ((codec)->core.vendor_id == 0x8086280b)
 #define is_geminilake(codec) (((codec)->core.vendor_id == 0x8086280d) || \
 				((codec)->core.vendor_id == 0x80862800))
+#define is_cannonlake(codec) ((codec)->core.vendor_id == 0x8086280c)
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
 				|| is_skylake(codec) || is_broxton(codec) \
-				|| is_kabylake(codec)) || is_geminilake(codec)
-
+				|| is_kabylake(codec)) || is_geminilake(codec) \
+				|| is_cannonlake(codec)
 #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
 #define is_valleyview_plus(codec) (is_valleyview(codec) || is_cherryview(codec))
@@ -3841,6 +3842,7 @@ HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_i915_hsw_hdmi),
 HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_i915_hsw_hdmi),
+HDA_CODEC_ENTRY(0x8086280c, "Cannonlake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x8086280d, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862800, "Geminilake HDMI",	patch_i915_glk_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
-- 
2.15.1
