From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: rme32: Use common error handling
 code in snd_rme32_probe()
Date: Fri, 17 Nov 2017 22:18:04 +0100
Message-ID: <aedb599c-d980-8b82-f8b6-ff9cbac99619@users.sourceforge.net>
References: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 61D21266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 22:18:12 +0100 (CET)
In-Reply-To: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 21:14:48 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme32.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index e58e9873c514..9e6e0fe3a285 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1972,10 +1972,8 @@ snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		rme32->fullduplex_mode = 1;
 
 	err = snd_rme32_create(rme32);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "Digi32");
 	switch (rme32->pci->device) {
@@ -1993,13 +1991,16 @@ snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		card->shortname, rme32->rev, rme32->port, rme32->irq);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_rme32_remove(struct pci_dev *pci)
-- 
2.15.0
