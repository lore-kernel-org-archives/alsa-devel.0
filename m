From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: cmipci: Use common error handling code
 in snd_cmipci_probe()
Date: Tue, 22 Aug 2017 20:03:50 +0200
Message-ID: <1d40ad45-3841-d25b-064a-011c6de5287e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B4FD266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 20:04:33 +0200 (CEST)
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Julia Lawall <Julia.Lawall@lip6.fr>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 19:58:30 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cmipci.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index a460cb63e971..27817c84f6ef 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3295,20 +3295,23 @@ static int snd_cmipci_probe(struct pci_dev *pci,
 		break;
 	}
 
-	if ((err = snd_cmipci_create(card, pci, dev, &cm)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_cmipci_create(card, pci, dev, &cm);
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = cm;
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
 
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_cmipci_remove(struct pci_dev *pci)
-- 
2.14.0
