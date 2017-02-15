From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 1/2] ALSA: hda - fix Lewisburg audio issue
Date: Wed, 15 Feb 2017 17:09:42 +0100
Message-ID: <20170215160943.26504-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD33265142
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 17:10:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Like for Sunrise Point, the total stream number of Lewisburg's
input and output stream exceeds 15 (GCAP is 0x9701), which will
cause some streams do not work because of the overflow on
SDxCTL.STRM field if using the legacy stream tag allocation method.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index faf99cc..7d77bb5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2214,9 +2214,9 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
 	/* Lewisburg */
 	{ PCI_DEVICE(0x8086, 0xa1f0),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	{ PCI_DEVICE(0x8086, 0xa270),
-	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
+	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_SKYLAKE },
 	/* Lynx Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
-- 
2.9.3
