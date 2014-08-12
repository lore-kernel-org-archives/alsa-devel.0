From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] sound: pci: es1968: use pci_device_id
Date: Tue, 12 Aug 2014 17:45:40 +0530
Message-ID: <1407845740-3524-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Uses the struct pci_device_id instead of the depreciated macro DEFINE_PCI_DEVICE_TABLE.


Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/es1968.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 5bb1cf6..a9956a7 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -570,7 +570,7 @@ struct es1968 {
 
 static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id);
 
-static DEFINE_PCI_DEVICE_TABLE(snd_es1968_ids) = {
+static const struct pci_device_id snd_es1968_ids[] = {
 	/* Maestro 1 */
         { 0x1285, 0x0100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_MULTIMEDIA_AUDIO << 8, 0xffff00, TYPE_MAESTRO },
 	/* Maestro 2 */
-- 
1.8.1.2
