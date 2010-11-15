From: Joe Perches <joe@perches.com>
Subject: [PATCH 11/11] sound/pci/asihpi/hpioctl.c: Remove unnecessary casts of pci_get_drvdata
Date: Mon, 15 Nov 2010 12:14:02 -0800
Message-ID: <1741bc5f7050b5ebb7014b8d93fdb70490ec7f06.1289851770.git.joe@perches.com>
References: <cover.1289851770.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1289851770.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <trivial@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/pci/asihpi/hpioctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 62895a7..22dbd91 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -435,7 +435,7 @@ void __devexit asihpi_adapter_remove(struct pci_dev *pci_dev)
 	struct hpi_message hm;
 	struct hpi_response hr;
 	struct hpi_adapter *pa;
-	pa = (struct hpi_adapter *)pci_get_drvdata(pci_dev);
+	pa = pci_get_drvdata(pci_dev);
 
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_SUBSYSTEM,
 		HPI_SUBSYS_DELETE_ADAPTER);
-- 
1.7.3.1.g432b3.dirty
