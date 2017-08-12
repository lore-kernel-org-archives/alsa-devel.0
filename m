From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: rme96: Use common error handling
 code in snd_rme96_probe()
Date: Sat, 12 Aug 2017 15:41:23 +0200
Message-ID: <2b3be152-3594-cab8-1949-99754e593e18@users.sourceforge.net>
References: <b38ee17e-f2ed-2bd7-6bc1-524ab4b3eb02@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB4F2669F6
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 15:41:31 +0200 (CEST)
In-Reply-To: <b38ee17e-f2ed-2bd7-6bc1-524ab4b3eb02@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 14:50:33 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme96.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 82e8c78e48ca..0cdfd53b7796 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2481,21 +2481,20 @@ snd_rme96_probe(struct pci_dev *pci,
 	rme96 = card->private_data;
 	rme96->card = card;
 	rme96->pci = pci;
-	if ((err = snd_rme96_create(rme96)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_rme96_create(rme96);
+	if (err)
+		goto free_card;
 	
 #ifdef CONFIG_PM_SLEEP
 	rme96->playback_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
 	if (!rme96->playback_suspend_buffer) {
-		snd_card_free(card);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_card;
 	}
 	rme96->capture_suspend_buffer = vmalloc(RME96_BUFFER_SIZE);
 	if (!rme96->capture_suspend_buffer) {
-		snd_card_free(card);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_card;
 	}
 #endif
 
@@ -2521,14 +2520,16 @@ snd_rme96_probe(struct pci_dev *pci,
 	}
 	sprintf(card->longname, "%s at 0x%lx, irq %d", card->shortname,
 		rme96->port, rme96->irq);
-	
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;	
-	}
+	err = snd_card_register(card);
+	if (err)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_rme96_remove(struct pci_dev *pci)
-- 
2.14.0
