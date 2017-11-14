From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: ens1370: Use common error handling
 code in snd_audiopci_probe()
Date: Tue, 14 Nov 2017 18:45:39 +0100
Message-ID: <528a9443-b098-4815-6996-83524286e55c@users.sourceforge.net>
References: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D7B1266F61
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 18:45:47 +0100 (CET)
In-Reply-To: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 18:15:36 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ens1370.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 7cd7cacdcc28..55c5173036d3 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2414,42 +2414,33 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 		return err;
 
 	err = snd_ensoniq_create(card, pci, &ensoniq);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = ensoniq;
 
 	pcm_devs[0] = 0; pcm_devs[1] = 1;
 #ifdef CHIP1370
 	err = snd_ensoniq_1370_mixer(ensoniq);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #endif
 #ifdef CHIP1371
 	err = snd_ensoniq_1371_mixer(ensoniq, spdif[dev], lineio[dev]);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 #endif
 	err = snd_ensoniq_pcm(ensoniq, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_ensoniq_pcm2(ensoniq, 1);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_ensoniq_midi(ensoniq, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	snd_ensoniq_create_gameport(ensoniq, dev);
 
@@ -2463,14 +2454,16 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 		ensoniq->irq);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_audiopci_remove(struct pci_dev *pci)
-- 
2.15.0
