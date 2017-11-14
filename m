From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: ens1370: Adjust 15 function calls
 together with a variable assignment
Date: Tue, 14 Nov 2017 18:44:32 +0100
Message-ID: <fb6f7313-8e1f-06de-3212-9576727211e3@users.sourceforge.net>
References: <8bcf1ada-f44c-cb83-0890-adc8ae8edda0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 695CC266F70
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 18:44:43 +0100 (CET)
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
Date: Tue, 14 Nov 2017 18:08:57 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ens1370.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 39f79a6b5283..7cd7cacdcc28 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -694,7 +694,8 @@ static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 			}
 			/* now wait for the stinkin' data (RDY) */
 			for (t = 0; t < POLL_COUNT; t++) {
-				if ((x = inl(ES_REG(ensoniq, 1371_CODEC))) & ES_1371_CODEC_RDY) {
+				x = inl(ES_REG(ensoniq, 1371_CODEC));
+				if (x & ES_1371_CODEC_RDY) {
 					if (is_ev1938(ensoniq)) {
 						for (t = 0; t < 100; t++)
 							inl(ES_REG(ensoniq, CONTROL));
@@ -1636,7 +1637,8 @@ static int snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
 		.wait = snd_es1371_codec_wait,
 	};
 
-	if ((err = snd_ac97_bus(card, 0, &ops, NULL, &pbus)) < 0)
+	err = snd_ac97_bus(card, 0, &ops, NULL, &pbus);
+	if (err < 0)
 		return err;
 
 	memset(&ac97, 0, sizeof(ac97));
@@ -1644,7 +1646,8 @@ static int snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
 	ac97.private_free = snd_ensoniq_mixer_free_ac97;
 	ac97.pci = ensoniq->pci;
 	ac97.scaps = AC97_SCAP_AUDIO;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &ensoniq->u.es1371.ac97)) < 0)
+	err = snd_ac97_mixer(pbus, &ac97, &ensoniq->u.es1371.ac97);
+	if (err < 0)
 		return err;
 	if (has_spdif > 0 ||
 	    (!has_spdif && es1371_quirk_lookup(ensoniq, es1371_spdif_present))) {
@@ -1764,7 +1767,8 @@ static int snd_ensoniq_1370_mixer(struct ensoniq *ensoniq)
 	ak4531.write = snd_es1370_codec_write;
 	ak4531.private_data = ensoniq;
 	ak4531.private_free = snd_ensoniq_mixer_free_ak4531;
-	if ((err = snd_ak4531_mixer(card, &ak4531, &ensoniq->u.es1370.ak4531)) < 0)
+	err = snd_ak4531_mixer(card, &ak4531, &ensoniq->u.es1370.ak4531);
+	if (err < 0)
 		return err;
 	for (idx = 0; idx < ES1370_CONTROLS; idx++) {
 		err = snd_ctl_add(card, snd_ctl_new1(&snd_es1370_controls[idx], ensoniq));
@@ -2088,7 +2092,8 @@ static int snd_ensoniq_create(struct snd_card *card,
 	};
 
 	*rensoniq = NULL;
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	ensoniq = kzalloc(sizeof(*ensoniq), GFP_KERNEL);
 	if (ensoniq == NULL) {
@@ -2100,7 +2105,8 @@ static int snd_ensoniq_create(struct snd_card *card,
 	ensoniq->card = card;
 	ensoniq->pci = pci;
 	ensoniq->irq = -1;
-	if ((err = pci_request_regions(pci, "Ensoniq AudioPCI")) < 0) {
+	err = pci_request_regions(pci, "Ensoniq AudioPCI");
+	if (err < 0) {
 		kfree(ensoniq);
 		pci_disable_device(pci);
 		return err;
@@ -2143,8 +2149,8 @@ static int snd_ensoniq_create(struct snd_card *card,
 #endif
 
 	snd_ensoniq_chip_init(ensoniq);
-
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops);
+	if (err < 0) {
 		snd_ensoniq_free(ensoniq);
 		return err;
 	}
@@ -2333,9 +2339,10 @@ static const struct snd_rawmidi_ops snd_ensoniq_midi_input =
 static int snd_ensoniq_midi(struct ensoniq *ensoniq, int device)
 {
 	struct snd_rawmidi *rmidi;
-	int err;
+	int err = snd_rawmidi_new(ensoniq->card, "ES1370/1",
+				  device, 1, 1, &rmidi);
 
-	if ((err = snd_rawmidi_new(ensoniq->card, "ES1370/1", device, 1, 1, &rmidi)) < 0)
+	if (err < 0)
 		return err;
 	strcpy(rmidi->name, CHIP_NAME);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_ensoniq_midi_output);
@@ -2406,7 +2413,8 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	if ((err = snd_ensoniq_create(card, pci, &ensoniq)) < 0) {
+	err = snd_ensoniq_create(card, pci, &ensoniq);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2414,26 +2422,31 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 
 	pcm_devs[0] = 0; pcm_devs[1] = 1;
 #ifdef CHIP1370
-	if ((err = snd_ensoniq_1370_mixer(ensoniq)) < 0) {
+	err = snd_ensoniq_1370_mixer(ensoniq);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
 #ifdef CHIP1371
-	if ((err = snd_ensoniq_1371_mixer(ensoniq, spdif[dev], lineio[dev])) < 0) {
+	err = snd_ensoniq_1371_mixer(ensoniq, spdif[dev], lineio[dev]);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
-	if ((err = snd_ensoniq_pcm(ensoniq, 0)) < 0) {
+	err = snd_ensoniq_pcm(ensoniq, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ensoniq_pcm2(ensoniq, 1)) < 0) {
+	err = snd_ensoniq_pcm2(ensoniq, 1);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_ensoniq_midi(ensoniq, 0)) < 0) {
+	err = snd_ensoniq_midi(ensoniq, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2449,7 +2462,8 @@ static int snd_audiopci_probe(struct pci_dev *pci,
 		ensoniq->port,
 		ensoniq->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
