From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3 1/5] sound: pci: ctxfi: added reference of snd_card
Date: Sun, 21 Sep 2014 21:33:37 +0530
Message-ID: <1411315421-24138-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

added and initialized a pointer of snd_card in the struct hw to get a reference of
the card in other functions

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/ctxfi/ctatc.c      | 1 +
 sound/pci/ctxfi/cthardware.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index d92a08c..b21eda4 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1333,6 +1333,7 @@ static int atc_create_hw_devs(struct ct_atc *atc)
 		pr_err("Failed to create hw obj!!!\n");
 		return err;
 	}
+	hw->card = atc->card;
 	atc->hw = hw;
 
 	/* Initialize card hardware. */
diff --git a/sound/pci/ctxfi/cthardware.h b/sound/pci/ctxfi/cthardware.h
index 5977e9a..940bbd0 100644
--- a/sound/pci/ctxfi/cthardware.h
+++ b/sound/pci/ctxfi/cthardware.h
@@ -20,6 +20,7 @@
 
 #include <linux/types.h>
 #include <linux/pci.h>
+#include <sound/core.h>
 
 enum CHIPTYP {
 	ATC20K1,
@@ -184,6 +185,7 @@ struct hw {
 	void *irq_callback_data;
 
 	struct pci_dev *pci;	/* the pci kernel structure of this card */
+	struct snd_card *card; /* pointer to this card */
 	int irq;
 	unsigned long io_base;
 	unsigned long mem_base;
-- 
1.8.1.2
