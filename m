From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix probing and stuttering on
	CMI8888 HD-audio controller
Date: Wed,  6 Aug 2014 14:39:14 +0200
Message-ID: <1407328755-1021-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 743E32608EC
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 14:39:15 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 33953AD83
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 12:39:15 +0000 (UTC)
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

ASUS Phoebus with CMI8888 HD-audio chip (PCI id 13f6:5011) doesn't
work with HD-audio driver as is because of some weird nature.  For
making DMA properly working, we need to disable MSI.  The position
report buffer doesn't work, thus we need to force reading LPIB
instead.  And yet, the codec CORB/RIRB communication gives errors
unless we disable the snooping (caching).

In this patch, all these workarounds are added as a quirk for the
device.  The HD-audio *codec* chip needs yet another workaround, but
it'll be provided in the succeeding patch.

Reported-and-tested-by: Vincent Lejeune <vljn@ovi.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5db1948699d8..aa302fb03fc5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -265,6 +265,7 @@ enum {
 	AZX_DRIVER_TERA,
 	AZX_DRIVER_CTX,
 	AZX_DRIVER_CTHDA,
+	AZX_DRIVER_CMEDIA,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -330,6 +331,7 @@ static char *driver_short_names[] = {
 	[AZX_DRIVER_TERA] = "HDA Teradici", 
 	[AZX_DRIVER_CTX] = "HDA Creative", 
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
+	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -1373,6 +1375,7 @@ static void azx_check_snoop_available(struct azx *chip)
 		snoop = false;
 		break;
 	case AZX_DRIVER_CTHDA:
+	case AZX_DRIVER_CMEDIA:
 		snoop = false;
 		break;
 	}
@@ -2154,6 +2157,10 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
 	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
 #endif
+	/* CM8888 */
+	{ PCI_DEVICE(0x13f6, 0x5011),
+	  .driver_data = AZX_DRIVER_CMEDIA |
+	  AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB },
 	/* Vortex86MX */
 	{ PCI_DEVICE(0x17f3, 0x3010), .driver_data = AZX_DRIVER_GENERIC },
 	/* VMware HDAudio */
-- 
2.0.3
