From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda_intel: add AZX_DCAPS_I915_POWERWELL
	for skl
Date: Fri, 27 Mar 2015 15:10:04 +0800
Message-ID: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AC96A260410
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 08:16:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

HDMI/DP codec on SKL is in the power well.
The power well must be turned on before probing the
HDMI/DP codec.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 15a8299..4744a96 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -298,7 +298,8 @@ enum {
 	 AZX_DCAPS_SNOOP_TYPE(SCH))
 
 #define AZX_DCAPS_INTEL_SKYLAKE \
-	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG)
+	(AZX_DCAPS_INTEL_PCH | AZX_DCAPS_SEPARATE_STREAM_TAG |\
+	 AZX_DCAPS_I915_POWERWELL)
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
-- 
1.9.1
