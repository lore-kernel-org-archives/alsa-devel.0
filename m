From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: cs4281: Use common error handling
 code in snd_cs4281_probe()
Date: Mon, 13 Nov 2017 13:52:41 +0100
Message-ID: <79d61453-352c-c5a7-a306-4c4304a74195@users.sourceforge.net>
References: <ac9d010b-7a26-1f2d-5034-15abe603c6fd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 34379266D86
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 13:53:16 +0100 (CET)
In-Reply-To: <ac9d010b-7a26-1f2d-5034-15abe603c6fd@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 13:10:11 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs4281.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index cf0bcab2a36b..ed6b97dbd1cc 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1934,40 +1934,34 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 		return err;
 
 	err = snd_cs4281_create(card, pci, &chip, dual_codec[dev]);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	err = snd_cs4281_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_cs4281_pcm(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_cs4281_midi(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_opl3_new(card, OPL3_HW_OPL3_CS4281, &opl3);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	opl3->private_data = chip;
 	opl3->command = snd_cs4281_opl3_command;
 	snd_opl3_init(opl3);
 	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	snd_cs4281_create_gameport(chip);
 	strcpy(card->driver, "CS4281");
 	strcpy(card->shortname, "Cirrus Logic CS4281");
@@ -1977,14 +1971,16 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 		chip->irq);
 
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
 
 static void snd_cs4281_remove(struct pci_dev *pci)
-- 
2.15.0
