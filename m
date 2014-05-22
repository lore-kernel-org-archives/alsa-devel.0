From: Benoit Taine <benoit.taine@lip6.fr>
Subject: [PATCH] ALSA: Replace DEFINE_PCI_DEVICE_TABLE macro use
Date: Thu, 22 May 2014 17:08:54 +0200
Message-ID: <1400771334-25112-1-git-send-email-benoit.taine@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: benoit.taine@lip6.fr, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We should prefer `const struct pci_device_id` over
`DEFINE_PCI_DEVICE_TABLE` to meet kernel coding style guidelines.
This issue was reported by checkpatch.

A simplified version of the semantic patch that makes this change is as
follows (http://coccinelle.lip6.fr/):

// <smpl>

@@
identifier i;
declarer name DEFINE_PCI_DEVICE_TABLE;
initializer z;
@@

- DEFINE_PCI_DEVICE_TABLE(i)
+ const struct pci_device_id i[]
= z;

// </smpl>

It has been tested by compilation.

Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>
---
 sound/pci/hda/hda_intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2c54629..ab0fd6d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1730,7 +1730,7 @@ static void azx_remove(struct pci_dev *pci)
 }
 
 /* PCI IDs */
-static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
+static const struct pci_device_id azx_ids[] = {
 	/* CPT */
 	{ PCI_DEVICE(0x8086, 0x1c20),
 	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH_NOPM },
