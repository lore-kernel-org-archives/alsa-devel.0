From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Register irq handler after the
	chip initialization
Date: Tue, 30 Apr 2019 12:30:57 +0200
Message-ID: <20190430103057.20370-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98B05F8065C
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 12:31:18 +0200 (CEST)
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
Cc: Liwei Song <liwei.song@windriver.com>
List-Id: alsa-devel@alsa-project.org

Currently the IRQ handler in HD-audio controller driver is registered
before the chip initialization.  That is, we have some window opened
between the azx_acquire_irq() call and the CORB/RIRB setup.  If an
interrupt is triggered in this small window, the IRQ handler may
access to the uninitialized RIRB buffer, which leads to a NULL
dereference Oops.

This is usually no big problem since most of Intel chips do register
the IRQ via MSI, and we've already fixed the order of the IRQ
enablement and the CORB/RIRB setup in the former commit b61749a89f82
("sound: enable interrupt after dma buffer initialization"), hence the
IRQ won't be triggered in that room.  However, some platforms use a
shared IRQ, and this may allow the IRQ trigger by another source.

Another possibility is the kdump environment: a stale interrupt might
be present in there, the IRQ handler can be falsely triggered as well.

For covering this small race, let's move the azx_acquire_irq() call
after hda_intel_init_chip() call.  Although this is a bit radical
change, it can cover more widely than checking the CORB/RIRB setup
locally in the callee side.

Reported-by: Liwei Song <liwei.song@windriver.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2ec91085fa3e..789308f54785 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1788,9 +1788,6 @@ static int azx_first_init(struct azx *chip)
 			chip->msi = 0;
 	}
 
-	if (azx_acquire_irq(chip, 0) < 0)
-		return -EBUSY;
-
 	pci_set_master(pci);
 	synchronize_irq(bus->irq);
 
@@ -1904,6 +1901,9 @@ static int azx_first_init(struct azx *chip)
 		return -ENODEV;
 	}
 
+	if (azx_acquire_irq(chip, 0) < 0)
+		return -EBUSY;
+
 	strcpy(card->driver, "HDA-Intel");
 	strlcpy(card->shortname, driver_short_names[chip->driver_type],
 		sizeof(card->shortname));
-- 
2.16.4
