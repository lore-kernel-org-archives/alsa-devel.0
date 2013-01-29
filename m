From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable LPIB delay count for
	Poulsbo / Oaktrail
Date: Tue, 29 Jan 2013 15:16:43 +0100
Message-ID: <1359469003-32065-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 44F7B261619
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 15:16:44 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id ADBBAA524D
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2013 15:16:43 +0100 (CET)
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

Currently we use LPIB forcibly for both playback and capture for
Poulsbo and Oaktrail devices, and this seems rather problematic.
The recent fix for LPIB delay count seems working well with these
devices, so let's enable it instead.

Reported-by: Martin Weishart <martin.weishart@telosalliance.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 0b6aeba..bf0a004 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3613,13 +3613,12 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* 5 Series/3400 */
 	{ PCI_DEVICE(0x8086, 0x3b56),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH },
-	/* SCH */
+	/* Poulsbo */
 	{ PCI_DEVICE(0x8086, 0x811b),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Poulsbo */
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
+	/* Oaktrail */
 	{ PCI_DEVICE(0x8086, 0x080a),
-	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
-	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Oaktrail */
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_INTEL_PCH_NOPM },
 	/* ICH */
 	{ PCI_DEVICE(0x8086, 0x2668),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
-- 
1.8.1.1
