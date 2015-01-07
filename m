From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] ALSA: fm801: PCI core handles power state
	for us
Date: Thu,  8 Jan 2015 00:38:37 +0200
Message-ID: <1420670317-7298-1-git-send-email-andy.shevchenko@gmail.com>
References: <Takashi Iwai <tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
 [195.197.172.115])
 by alsa0.perex.cz (Postfix) with ESMTP id CA79226525B
 for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2015 23:38:41 +0100 (CET)
In-Reply-To: <Takashi Iwai <tiwai@suse.de>
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
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no need to repeat the work that is already done in the PCI
driver core. The patch removes excerpts from suspend and resume
callbacks.

Note that there is no more calls performed to enable or disable a PCI
device during suspend-resume cycle. Nowadays they seems to be
superflous. Someone can read more in [1].

[1] https://www.kernel.org/doc/ols/2009/ols2009-pages-319-330.pdf

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 sound/pci/fm801.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c383eec..557c19c 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1369,7 +1369,6 @@ static unsigned char saved_regs[] = {
 
 static int snd_fm801_suspend(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct fm801 *chip = card->private_data;
 	int i;
@@ -1381,29 +1380,15 @@ static int snd_fm801_suspend(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
 		chip->saved_regs[i] = inw(chip->port + saved_regs[i]);
 	/* FIXME: tea575x suspend */
-
-	pci_disable_device(pci);
-	pci_save_state(pci);
-	pci_set_power_state(pci, PCI_D3hot);
 	return 0;
 }
 
 static int snd_fm801_resume(struct device *dev)
 {
-	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct fm801 *chip = card->private_data;
 	int i;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
-	if (pci_enable_device(pci) < 0) {
-		dev_err(dev, "pci_enable_device failed, disabling device\n");
-		snd_card_disconnect(card);
-		return -EIO;
-	}
-	pci_set_master(pci);
-
 	snd_fm801_chip_init(chip, 1);
 	snd_ac97_resume(chip->ac97);
 	snd_ac97_resume(chip->ac97_sec);
-- 
1.8.3.101.g727a46b
