From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: cs5530: Use common error handling code
 in snd_cs5530_probe()
Date: Sat, 18 Nov 2017 22:15:57 +0100
Message-ID: <a2cb6494-a01c-668a-cd9b-1a8428a0d4c9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 90F2A266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 22:16:18 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 22:10:19 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs5530.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 0a8cf94c4858..674572edf2d2 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -269,23 +269,24 @@ static int snd_cs5530_probe(struct pci_dev *pci,
 		return err;
 
 	err = snd_cs5530_create(card, pci, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "CS5530");
 	strcpy(card->shortname, "CS5530 Audio");
 	sprintf(card->longname, "%s at 0x%lx", card->shortname, chip->pci_base);
 
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
 
 static struct pci_driver cs5530_driver = {
-- 
2.15.0
