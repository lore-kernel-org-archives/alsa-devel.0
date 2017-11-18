From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: sonicvibes: Use common error
 handling code in snd_sonic_probe()
Date: Sat, 18 Nov 2017 16:32:16 +0100
Message-ID: <89664efb-8306-cd4f-a217-bf0a2ddba142@users.sourceforge.net>
References: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 9845026698E
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 16:32:54 +0100 (CET)
In-Reply-To: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 16:10:34 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/sonicvibes.c | 54 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 7c238d908031..75fc64839df0 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1478,17 +1478,15 @@ static int snd_sonic_probe(struct pci_dev *pci,
 	for (idx = 0; idx < 5; idx++) {
 		if (pci_resource_start(pci, idx) == 0 ||
 		    !(pci_resource_flags(pci, idx) & IORESOURCE_IO)) {
-			snd_card_free(card);
-			return -ENODEV;
+			err = -ENODEV;
+			goto free_card;
 		}
 	}
 
 	err = snd_sonicvibes_create(card, pci, reverb[dev] ? 1 : 0,
 				    mge[dev] ? 1 : 0, &sonic);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "SonicVibes");
 	strcpy(card->shortname, "S3 SonicVibes");
@@ -1499,48 +1497,44 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		sonic->irq);
 
 	err = snd_sonicvibes_pcm(sonic, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_sonicvibes_mixer(sonic);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_mpu401_uart_new(card, 0, MPU401_HW_SONICVIBES,
 				  sonic->midi_port,
 				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
 				  -1, &midi_uart);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	snd_sonicvibes_midi(sonic, midi_uart);
 	err = snd_opl3_create(card, sonic->synth_port,
 			      sonic->synth_port + 2,
 			      OPL3_HW_OPL3_SV, 1, &opl3);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	snd_sonicvibes_create_gameport(sonic);
 
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
 
 static void snd_sonic_remove(struct pci_dev *pci)
-- 
2.15.0
