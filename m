From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Apply quirks to Broxton-T, too
Date: Fri, 16 Jun 2017 11:05:19 +0200
Message-ID: <20170616090520.9879-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C67DF2669F3
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 11:05:23 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Broxton-T was a forgotten child and we didn't apply the quirks for
Skylake+ properly.  Meanwhile, a quirk for reducing the DMA latency
seems specific to the early Broxton model, so we leave as is.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e3c696c46a21..01eb1dc7b5b3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -370,11 +370,12 @@ enum {
 #define IS_KBL_LP(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x9d71)
 #define IS_KBL_H(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa2f0)
 #define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
+#define IS_BXT_T(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x1a98)
 #define IS_GLK(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x3198)
 #define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
-#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci)) || \
-			IS_KBL(pci) || IS_KBL_LP(pci) || IS_KBL_H(pci)	|| \
-			IS_GLK(pci) || IS_CFL(pci)
+#define IS_SKL_PLUS(pci) (IS_SKL(pci) || IS_SKL_LP(pci) || IS_BXT(pci) || \
+			  IS_BXT_T(pci) || IS_KBL(pci) || IS_KBL_LP(pci) || \
+			  IS_KBL_H(pci)	|| IS_GLK(pci) || IS_CFL(pci))
 
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
-- 
2.13.1
