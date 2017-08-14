From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: rme9652: Use common error handling code
 in two functions
Date: Mon, 14 Aug 2017 22:10:10 +0200
Message-ID: <fefeea4b-68a2-5b4c-2cfc-cb05383b5474@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E1707267390
 for <alsa-devel@alsa-project.org>; Mon, 14 Aug 2017 22:10:23 +0200 (CEST)
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
Date: Mon, 14 Aug 2017 22:00:40 +0200

Add a jump target so that a bit of exception handling can be better reused
in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme9652/hdsp.c    | 13 ++++++-------
 sound/pci/rme9652/rme9652.c | 14 ++++++--------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fe36d44d16c6..4750d14555bc 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5381,17 +5381,16 @@ static int snd_hdsp_probe(struct pci_dev *pci,
 	card->private_free = snd_hdsp_card_free;
 	hdsp->dev = dev;
 	hdsp->pci = pci;
-
-	if ((err = snd_hdsp_create(card, hdsp)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_hdsp_create(card, hdsp);
+	if (err)
+		goto free_card;
 
 	strcpy(card->shortname, "Hammerfall DSP");
 	sprintf(card->longname, "%s at 0x%lx, irq %d", hdsp->card_name,
 		hdsp->port, hdsp->irq);
-
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err) {
+free_card:
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 150d08898db8..b36ba7f9a7bf 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2618,19 +2618,17 @@ static int snd_rme9652_probe(struct pci_dev *pci,
 	card->private_free = snd_rme9652_card_free;
 	rme9652->dev = dev;
 	rme9652->pci = pci;
-
-	if ((err = snd_rme9652_create(card, rme9652, precise_ptr[dev])) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_rme9652_create(card, rme9652, precise_ptr[dev]);
+	if (err)
+		goto free_card;
 
 	strcpy(card->shortname, rme9652->card_name);
 
 	sprintf(card->longname, "%s at 0x%lx, irq %d",
 		card->shortname, rme9652->port, rme9652->irq);
-
-	
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err) {
+free_card:
 		snd_card_free(card);
 		return err;
 	}
-- 
2.14.0
