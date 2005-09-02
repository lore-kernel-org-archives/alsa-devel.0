From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH] fix some warnings in sound
Date: Sat, 3 Sep 2005 00:43:53 +0200
Message-ID: <200509022243.j82MhrAZ002660@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDF5E171
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 00:43:56 +0200 (MEST)
In-reply-to: 
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: alsa-devel@alsa-project.org, perex@suse.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Some drivers don't control return values, that can fail.

Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 ali5451/ali5451.c   |    3 ++-
 cs46xx/cs46xx_lib.c |    6 ++++--
 via82xx.c           |    8 +++++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2067,7 +2067,8 @@ static int ali_resume(snd_card_t *card)
 	if (! im)
 		return 0;
 
-	pci_enable_device(chip->pci);
+	if ((i = pci_enable_device(chip->pci)))
+		return i;
 
 	spin_lock_irq(&chip->reg_lock);
 	
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3722,9 +3722,11 @@ static int snd_cs46xx_suspend(snd_card_t
 static int snd_cs46xx_resume(snd_card_t *card)
 {
 	cs46xx_t *chip = card->pm_private_data;
-	int amp_saved;
+	int amp_saved, err;
+
+	if ((err = pci_enable_device(chip->pci)))
+		return err;
 
-	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
 	amp_saved = chip->amplifier;
 	chip->amplifier = 0;
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1977,7 +1977,8 @@ static int snd_via82xx_suspend(snd_card_
 		chip->capture_src_saved[1] = inb(chip->port + VIA_REG_CAPTURE_CHANNEL + 0x10);
 	}
 
-	pci_set_power_state(chip->pci, 3);
+	if ((i = pci_set_power_state(chip->pci, 3)))
+		return i;
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1987,8 +1988,9 @@ static int snd_via82xx_resume(snd_card_t
 	via82xx_t *chip = card->pm_private_data;
 	int i;
 
-	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	if ((i = pci_enable_device(chip->pci)) ||
+			(i = pci_set_power_state(chip->pci, 0)))
+		return i;
 
 	snd_via82xx_chip_init(chip);
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
