From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - add codec support for Kabylake
	display audio codec
Date: Thu, 14 Jan 2016 14:09:00 +0800
Message-ID: <1452751740-4416-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BE4E2604D8
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 07:12:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

This patch adds codec ID (0x8086280b) for Kabylake display codec
and apply the hsw fix-ups to Kabylake.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index cd9b0ff..426a29a 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -51,8 +51,10 @@ MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 #define is_broadwell(codec)    ((codec)->core.vendor_id == 0x80862808)
 #define is_skylake(codec) ((codec)->core.vendor_id == 0x80862809)
 #define is_broxton(codec) ((codec)->core.vendor_id == 0x8086280a)
+#define is_kabylake(codec) ((codec)->core.vendor_id == 0x8086280b)
 #define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec) \
-				|| is_skylake(codec) || is_broxton(codec))
+				|| is_skylake(codec) || is_broxton(codec) \
+				|| is_kabylake(codec))
 
 #define is_valleyview(codec) ((codec)->core.vendor_id == 0x80862882)
 #define is_cherryview(codec) ((codec)->core.vendor_id == 0x80862883)
@@ -3667,6 +3669,7 @@ HDA_CODEC_ENTRY(0x80862807, "Haswell HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862808, "Broadwell HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862809, "Skylake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x8086280a, "Broxton HDMI",	patch_generic_hdmi),
+HDA_CODEC_ENTRY(0x8086280b, "Kabylake HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_generic_hdmi),
-- 
1.9.1
