From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Force buffer alignment for
	Haswell HDMI controllers
Date: Tue,  5 Nov 2013 18:00:30 +0100
Message-ID: <1383670831-12067-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 65AF3261A3C
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:00:32 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BFD98A6772
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:00:31 +0100 (CET)
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

Haswell HDMI audio controllers seem to get stuck when unaligned buffer
size is used.  Let's enable the buffer alignment for the corresponding
entries.

Since AZX_DCAPS_INTEL_PCH contains AZX_DCAPS_BUFSIZE that disables the
buffer alignment forcibly, define AZX_DCAPS_INTEL_HASWELL and put the
necessary AZX_DCAPS bits there.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=60769
Reported-by: Alexander E. Patrakov <patrakov@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d6dcec768594..9cbd1259a5be 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -613,6 +613,11 @@ enum {
 #define AZX_DCAPS_INTEL_PCH \
 	(AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
 
+#define AZX_DCAPS_INTEL_HASWELL \
+	(AZX_DCAPS_SCH_SNOOP | AZX_DCAPS_ALIGN_BUFSIZE | \
+	 AZX_DCAPS_COUNT_LPIB_DELAY | AZX_DCAPS_PM_RUNTIME | \
+	 AZX_DCAPS_I915_POWERWELL)
+
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
 	(AZX_DCAPS_ATI_SNOOP | AZX_DCAPS_NO_TCSEL | \
@@ -3992,14 +3997,11 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Haswell */
 	{ PCI_DEVICE(0x8086, 0x0a0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
-	  AZX_DCAPS_I915_POWERWELL },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
 	{ PCI_DEVICE(0x8086, 0x0c0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
-	  AZX_DCAPS_I915_POWERWELL },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
 	{ PCI_DEVICE(0x8086, 0x0d0c),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH |
-	  AZX_DCAPS_I915_POWERWELL },
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_HASWELL },
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
-- 
1.8.4.2
