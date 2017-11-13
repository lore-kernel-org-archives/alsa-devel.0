From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: cs4281: Adjust 18 function calls
 together with a variable assignment
Date: Mon, 13 Nov 2017 13:51:43 +0100
Message-ID: <9b21d539-1545-4b7f-4adb-0aa3d3f43c1d@users.sourceforge.net>
References: <ac9d010b-7a26-1f2d-5034-15abe603c6fd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 785C2266D86
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 13:51:50 +0100 (CET)
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
Date: Mon, 13 Nov 2017 12:52:53 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs4281.c | 59 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ec4247638fa1..cf0bcab2a36b 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1102,23 +1102,31 @@ static int snd_cs4281_mixer(struct cs4281 *chip)
 		.read = snd_cs4281_ac97_read,
 	};
 
-	if ((err = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus)) < 0)
+	err = snd_ac97_bus(card, 0, &ops, chip, &chip->ac97_bus);
+	if (err < 0)
 		return err;
 	chip->ac97_bus->private_free = snd_cs4281_mixer_free_ac97_bus;
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	ac97.private_free = snd_cs4281_mixer_free_ac97;
-	if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97)) < 0)
+	err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97);
+	if (err < 0)
 		return err;
 	if (chip->dual_codec) {
 		ac97.num = 1;
-		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_secondary)) < 0)
+		err = snd_ac97_mixer(chip->ac97_bus, &ac97,
+				     &chip->ac97_secondary);
+		if (err < 0)
 			return err;
 	}
-	if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_fm_vol, chip))) < 0)
+
+	err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_fm_vol, chip));
+	if (err < 0)
 		return err;
-	if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_pcm_vol, chip))) < 0)
+
+	err = snd_ctl_add(card, snd_ctl_new1(&snd_cs4281_pcm_vol, chip));
+	if (err < 0)
 		return err;
 	return 0;
 }
@@ -1346,7 +1354,8 @@ static int snd_cs4281_create(struct snd_card *card,
 	};
 
 	*rchip = NULL;
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
@@ -1364,7 +1373,8 @@ static int snd_cs4281_create(struct snd_card *card,
 	}
 	chip->dual_codec = dual_codec;
 
-	if ((err = pci_request_regions(pci, "CS4281")) < 0) {
+	err = pci_request_regions(pci, "CS4281");
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
@@ -1393,7 +1403,8 @@ static int snd_cs4281_create(struct snd_card *card,
 		return tmp;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_cs4281_free(chip);
 		return err;
 	}
@@ -1432,12 +1443,15 @@ static int snd_cs4281_chip_init(struct cs4281 *chip)
          * space between 0e4h and 0ffh to be written. */	
 	snd_cs4281_pokeBA0(chip, BA0_CWPR, 0x4281);
 	
-	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC1)) != (BA0_SERC1_SO1EN | BA0_SERC1_AC97)) {
+	tmp = snd_cs4281_peekBA0(chip, BA0_SERC1);
+	if (tmp != (BA0_SERC1_SO1EN | BA0_SERC1_AC97)) {
 		dev_err(chip->card->dev,
 			"SERC1 AC'97 check failed (0x%x)\n", tmp);
 		return -EIO;
 	}
-	if ((tmp = snd_cs4281_peekBA0(chip, BA0_SERC2)) != (BA0_SERC2_SI1EN | BA0_SERC2_AC97)) {
+
+	tmp = snd_cs4281_peekBA0(chip, BA0_SERC2);
+	if (tmp != (BA0_SERC2_SI1EN | BA0_SERC2_AC97)) {
 		dev_err(chip->card->dev,
 			"SERC2 AC'97 check failed (0x%x)\n", tmp);
 		return -EIO;
@@ -1784,9 +1798,9 @@ static const struct snd_rawmidi_ops snd_cs4281_midi_input =
 static int snd_cs4281_midi(struct cs4281 *chip, int device)
 {
 	struct snd_rawmidi *rmidi;
-	int err;
+	int err = snd_rawmidi_new(chip->card, "CS4281", device, 1, 1, &rmidi);
 
-	if ((err = snd_rawmidi_new(chip->card, "CS4281", device, 1, 1, &rmidi)) < 0)
+	if (err < 0)
 		return err;
 	strcpy(rmidi->name, "CS4281");
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_cs4281_midi_output);
@@ -1919,32 +1933,38 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	if ((err = snd_cs4281_create(card, pci, &chip, dual_codec[dev])) < 0) {
+	err = snd_cs4281_create(card, pci, &chip, dual_codec[dev]);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	card->private_data = chip;
 
-	if ((err = snd_cs4281_mixer(chip)) < 0) {
+	err = snd_cs4281_mixer(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs4281_pcm(chip, 0)) < 0) {
+	err = snd_cs4281_pcm(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs4281_midi(chip, 0)) < 0) {
+	err = snd_cs4281_midi(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3_new(card, OPL3_HW_OPL3_CS4281, &opl3)) < 0) {
+	err = snd_opl3_new(card, OPL3_HW_OPL3_CS4281, &opl3);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	opl3->private_data = chip;
 	opl3->command = snd_cs4281_opl3_command;
 	snd_opl3_init(opl3);
-	if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1956,7 +1976,8 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 		chip->ba0_addr,
 		chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
