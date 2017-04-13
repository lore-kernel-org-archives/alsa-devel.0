From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 2/2] ALSA: hda: Add Geminilake id to SKL_PLUS
Date: Thu, 13 Apr 2017 13:05:36 +0530
Message-ID: <1492068936-8991-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1492068936-8991-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9127426710D
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 09:48:24 +0200 (CEST)
In-Reply-To: <1492068936-8991-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Geminilake is Skylake family platform. So add it's id to skl_plus check.

Fixes: 126cfa2f5e15 ("ALSA: hda: Add Geminilake HDMI codec ID")
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Cc: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 64db6698214c..5b9ffd70ae52 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -370,8 +370,10 @@ enum {
 #define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
 #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
 #define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
-			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)
+			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
+			IS_GLK(pci)
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
-- 
1.9.1
