From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: mixart: Adjust 23 function calls
 together with a variable assignment
Date: Thu, 16 Nov 2017 16:33:46 +0100
Message-ID: <83b24b8b-b794-08ef-8234-c6a6b8e5bf24@users.sourceforge.net>
References: <6f8ce522-66ac-9740-41fb-2df6ab6f3aec@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F115266F1D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 16:33:54 +0100 (CET)
In-Reply-To: <6f8ce522-66ac-9740-41fb-2df6ab6f3aec@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 15:26:12 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/mixart/mixart.c       | 29 ++++++++++++++++-----------
 sound/pci/mixart/mixart_hwdep.c | 17 +++++++++++-----
 sound/pci/mixart/mixart_mixer.c | 44 ++++++++++++++++++++++++++++++-----------
 3 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index a74f1ad7e7b8..ff90a06f775e 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -972,9 +972,10 @@ static int snd_mixart_pcm_analog(struct snd_mixart *chip)
 	char name[32];
 
 	sprintf(name, "miXart analog %d", chip->chip_idx);
-	if ((err = snd_pcm_new(chip->card, name, MIXART_PCM_ANALOG,
-			       MIXART_PLAYBACK_STREAMS,
-			       MIXART_CAPTURE_STREAMS, &pcm)) < 0) {
+	err = snd_pcm_new(chip->card, name, MIXART_PCM_ANALOG,
+			  MIXART_PLAYBACK_STREAMS,
+			  MIXART_CAPTURE_STREAMS, &pcm);
+	if (err < 0) {
 		dev_err(chip->card->dev,
 			"cannot create the analog pcm %d\n", chip->chip_idx);
 		return err;
@@ -1005,9 +1006,10 @@ static int snd_mixart_pcm_digital(struct snd_mixart *chip)
 	char name[32];
 
 	sprintf(name, "miXart AES/EBU %d", chip->chip_idx);
-	if ((err = snd_pcm_new(chip->card, name, MIXART_PCM_DIGITAL,
-			       MIXART_PLAYBACK_STREAMS,
-			       MIXART_CAPTURE_STREAMS, &pcm)) < 0) {
+	err = snd_pcm_new(chip->card, name, MIXART_PCM_DIGITAL,
+			  MIXART_PLAYBACK_STREAMS,
+			  MIXART_CAPTURE_STREAMS, &pcm);
+	if (err < 0) {
 		dev_err(chip->card->dev,
 			"cannot create the digital pcm %d\n", chip->chip_idx);
 		return err;
@@ -1059,7 +1061,8 @@ static int snd_mixart_create(struct mixart_mgr *mgr, struct snd_card *card, int
 	chip->chip_idx = idx;
 	chip->mgr = mgr;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_mixart_chip_free(chip);
 		return err;
 	}
@@ -1262,7 +1265,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	}
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	pci_set_master(pci);
 
@@ -1286,7 +1290,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 	mgr->irq = -1;
 
 	/* resource assignment */
-	if ((err = pci_request_regions(pci, CARD_NAME)) < 0) {
+	err = pci_request_regions(pci, CARD_NAME);
+	if (err < 0) {
 		kfree(mgr);
 		pci_disable_device(pci);
 		return err;
@@ -1351,7 +1356,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 			"Digigram miXart at 0x%lx & 0x%lx, irq %i [PCM #%d]",
 			mgr->mem[0].phys, mgr->mem[1].phys, mgr->irq, i);
 
-		if ((err = snd_mixart_create(mgr, card, i)) < 0) {
+		err = snd_mixart_create(mgr, card, i);
+		if (err < 0) {
 			snd_card_free(card);
 			snd_mixart_free(mgr);
 			return err;
@@ -1362,7 +1368,8 @@ static int snd_mixart_probe(struct pci_dev *pci,
 			snd_mixart_proc_init(mgr->chip[i]);
 		}
 
-		if ((err = snd_card_register(card)) < 0) {
+		err = snd_card_register(card);
+		if (err < 0) {
 			snd_mixart_free(mgr);
 			return err;
 		}
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 5bfd3ac80db5..61ad356a249d 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -318,9 +318,13 @@ static int mixart_first_init(struct mixart_mgr *mgr)
 	int err;
 	struct mixart_msg request;
 
-	if((err = mixart_enum_connectors(mgr)) < 0) return err;
+	err = mixart_enum_connectors(mgr);
+	if (err < 0)
+		return err;
 
-	if((err = mixart_enum_physio(mgr)) < 0) return err;
+	err = mixart_enum_physio(mgr);
+	if (err < 0)
+		return err;
 
 	/* send a synchro command to card (necessary to do this before first MSG_STREAM_START_STREAM_GRP_PACKET) */
 	/* though why not here */
@@ -540,15 +544,18 @@ static int mixart_dsp_load(struct mixart_mgr* mgr, int index, const struct firmw
         for (card_index = 0; card_index < mgr->num_cards; card_index++) {
 		struct snd_mixart *chip = mgr->chip[card_index];
 
-		if ((err = snd_mixart_create_pcm(chip)) < 0)
+		err = snd_mixart_create_pcm(chip);
+		if (err < 0)
 			return err;
 
 		if (card_index == 0) {
-			if ((err = snd_mixart_create_mixer(chip->mgr)) < 0)
+			err = snd_mixart_create_mixer(chip->mgr);
+			if (err < 0)
 	        		return err;
 		}
 
-		if ((err = snd_card_register(chip->card)) < 0)
+		err = snd_card_register(chip->card);
+		if (err < 0)
 			return err;
 	}
 
diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 2b9496a66c77..4b3043ffbb43 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -1127,10 +1127,14 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 		temp = mixart_control_analog_level;
 		temp.name = "Master Playback Volume";
 		temp.private_value = 0; /* playback */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+		err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip));
+		if (err < 0)
 			return err;
 		/* output mute controls */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixart_control_output_switch, chip))) < 0)
+		err = snd_ctl_add(chip->card,
+				  snd_ctl_new1(&mixart_control_output_switch,
+					       chip));
+		if (err < 0)
 			return err;
 
 		/* analog input level control only on first two chips !*/
@@ -1138,7 +1142,9 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 			temp = mixart_control_analog_level;
 			temp.name = "Master Capture Volume";
 			temp.private_value = 1; /* capture */
-			if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+			err = snd_ctl_add(chip->card,
+					  snd_ctl_new1(&temp, chip));
+			if (err < 0)
 				return err;
 		}
 
@@ -1146,45 +1152,61 @@ int snd_mixart_create_mixer(struct mixart_mgr *mgr)
 		temp.name = "PCM Playback Volume";
 		temp.count = MIXART_PLAYBACK_STREAMS;
 		temp.private_value = 0; /* playback analog */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+		err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip));
+		if (err < 0)
 			return err;
 
 		temp.name = "PCM Capture Volume";
 		temp.count = 1;
 		temp.private_value = MIXART_VOL_REC_MASK; /* capture analog */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+		err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip));
+		if (err < 0)
 			return err;
 
 		if(mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
 			temp.name = "AES Playback Volume";
 			temp.count = MIXART_PLAYBACK_STREAMS;
 			temp.private_value = MIXART_VOL_AES_MASK; /* playback AES/EBU */
-			if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+			err = snd_ctl_add(chip->card,
+					  snd_ctl_new1(&temp, chip));
+			if (err < 0)
 				return err;
 
 			temp.name = "AES Capture Volume";
 			temp.count = 0;
 			temp.private_value = MIXART_VOL_REC_MASK | MIXART_VOL_AES_MASK; /* capture AES/EBU */
-			if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+			err = snd_ctl_add(chip->card,
+					  snd_ctl_new1(&temp, chip));
+			if (err < 0)
 				return err;
 		}
 		temp = mixart_control_pcm_switch;
 		temp.name = "PCM Playback Switch";
 		temp.private_value = 0; /* playback analog */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+		err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip));
+		if (err < 0)
 			return err;
 
 		if(mgr->board_type == MIXART_DAUGHTER_TYPE_AES) {
 			temp.name = "AES Playback Switch";
 			temp.private_value = MIXART_VOL_AES_MASK; /* playback AES/EBU */
-			if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&temp, chip))) < 0)
+			err = snd_ctl_add(chip->card,
+					  snd_ctl_new1(&temp, chip));
+			if (err < 0)
 				return err;
 		}
 
 		/* monitoring */
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixart_control_monitor_vol, chip))) < 0)
+		err = snd_ctl_add(chip->card,
+				  snd_ctl_new1(&mixart_control_monitor_vol,
+					       chip));
+		if (err < 0)
 			return err;
-		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&mixart_control_monitor_sw, chip))) < 0)
+
+		err = snd_ctl_add(chip->card,
+				  snd_ctl_new1(&mixart_control_monitor_sw,
+					       chip));
+		if (err < 0)
 			return err;
 
 		/* init all mixer data and program the master volumes/switches */
-- 
2.15.0
