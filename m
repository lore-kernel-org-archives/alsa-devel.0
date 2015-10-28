From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable 64bit address for Creative
	HDA controllers
Date: Wed, 28 Oct 2015 06:30:39 +0100
Message-ID: <1446010239-15584-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE1CD2614FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 06:30:40 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 98954AC0B
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 05:30:53 +0000 (UTC)
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

We've had many reports that some Creative sound cards with CA0132
don't work well.  Some reported that it starts working after reloading
the module, while some reported it starts working when a 32bit kernel
is used.  All these facts seem implying that the chip fails to
communicate when the buffer is located in 64bit address.

This patch addresses these issues by just adding AZX_DCAPS_NO_64BIT
flag to the corresponding PCI entries.  I casually had a chance to
test an SB Recon3D board, and indeed this seems helping.

Although this hasn't been tested on all Creative devices, it's safer
to assume that this restriction applies to the rest of them, too.  So
the flag is applied to all Creative entries.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c38c68f57938..61b8b75a3c80 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -334,6 +334,7 @@ enum {
 
 #define AZX_DCAPS_PRESET_CTHDA \
 	(AZX_DCAPS_NO_MSI | AZX_DCAPS_POSFIX_LPIB |\
+	 AZX_DCAPS_NO_64BIT |\
 	 AZX_DCAPS_4K_BDLE_BOUNDARY | AZX_DCAPS_SNOOP_OFF)
 
 /*
@@ -2284,11 +2285,13 @@ static const struct pci_device_id azx_ids[] = {
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
+	  AZX_DCAPS_NO_64BIT |
 	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
 #else
 	/* this entry seems still valid -- i.e. without emu20kx chip */
 	{ PCI_DEVICE(0x1102, 0x0009),
 	  .driver_data = AZX_DRIVER_CTX | AZX_DCAPS_CTX_WORKAROUND |
+	  AZX_DCAPS_NO_64BIT |
 	  AZX_DCAPS_RIRB_PRE_DELAY | AZX_DCAPS_POSFIX_LPIB },
 #endif
 	/* CM8888 */
-- 
2.6.2
