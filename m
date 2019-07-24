From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix intermittent CORB/RIRB stall
	on Intel chips
Date: Wed, 24 Jul 2019 20:15:44 +0200
Message-ID: <20190724181544.27164-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8744AF8026F
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 20:15:48 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 45497ADE6
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2019 18:15:48 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It turned out that the recent Intel HD-audio controller chips show a
significant stall during the system PM resume intermittently.  It
doesn't happen so often and usually it may read back successfully
after one or more seconds, but in some rare worst cases the driver
went into fallback mode.

After trial-and-error, we found out that the communication stall seems
covered by issuing the sync after each verb write, as already done for
AMD and other chipsets.  So this patch enables the write-sync flag for
the recent Intel chips, Skylake and onward, as a workaround.

Also, since Broxton and co have the very same driver flags as Skylake,
refer to the Skylake driver flags instead of defining the same
contents again for simplification.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201901
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cb8b0945547c..1e14d7270adf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -313,11 +313,10 @@ enum {
 
 #define AZX_DCAPS_INTEL_SKYLAKE \
 	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
+	 AZX_DCAPS_SYNC_WRITE |\
 	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT)
 
-#define AZX_DCAPS_INTEL_BROXTON \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SEPARATE_STREAM_TAG | AZX_DCAPS_I915_COMPONENT)
+#define AZX_DCAPS_INTEL_BROXTON		AZX_DCAPS_INTEL_SKYLAKE
 
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
-- 
2.16.4
