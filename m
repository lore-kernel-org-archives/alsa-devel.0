From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v1] sound: pci: ymfpci: ymfpci_main:- Handle return NULL error from ioremap_nocache
Date: Mon, 23 Jan 2017 12:40:13 +0530
Message-ID: <1485155413-23672-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: Julia.Lawall@lip6.fr, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Here, If ioremap_nocache will fail. It will return NULL.
Kernel can run into a NULL-pointer dereference.
This error check will avoid NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/ymfpci/ymfpci_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index ffee284..8590c3f 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2392,6 +2392,10 @@ int snd_ymfpci_create(struct snd_card *card,
 	chip->rev = pci->revision;
 	chip->reg_area_phys = pci_resource_start(pci, 0);
 	chip->reg_area_virt = ioremap_nocache(chip->reg_area_phys, 0x8000);
+	if (!chip->reg_area_virt) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
 	pci_set_master(pci);
 	chip->src441_used = -1;
 
-- 
1.9.1
