From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: fm801: Adjust 17 function calls
 together with a variable assignment
Date: Wed, 15 Nov 2017 13:46:30 +0100
Message-ID: <5db5ffad-1bb7-d713-6bce-c4ca8ab8cbc6@users.sourceforge.net>
References: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FB3F266D11
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 13:46:39 +0100 (CET)
In-Reply-To: <86b94d9c-77fb-fed5-b55c-a0565f619dc7@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 13:20:49 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/fm801.c | 75 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 73a67bc3586b..3648af4581a0 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -655,9 +655,10 @@ static int snd_fm801_playback_open(struct snd_pcm_substream *substream)
 					   SNDRV_PCM_HW_PARAM_CHANNELS,
 					   &hw_constraints_channels);
 	}
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
-		return err;
-	return 0;
+
+	err = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	return (err < 0) ? err : 0;
 }
 
 static int snd_fm801_capture_open(struct snd_pcm_substream *substream)
@@ -670,9 +671,9 @@ static int snd_fm801_capture_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_fm801_capture;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &hw_constraints_rates);
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
-		return err;
-	return 0;
+	err = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	return (err < 0) ? err : 0;
 }
 
 static int snd_fm801_playback_close(struct snd_pcm_substream *substream)
@@ -717,9 +718,9 @@ static int snd_fm801_pcm(struct fm801 *chip, int device)
 {
 	struct pci_dev *pdev = to_pci_dev(chip->dev);
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "FM801", device, 1, 1, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "FM801", device, 1, 1, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_fm801_playback_ops);
@@ -986,10 +987,10 @@ static int snd_fm801_put_mux(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct fm801 *chip = snd_kcontrol_chip(kcontrol);
-        unsigned short val;
+	unsigned short val = ucontrol->value.enumerated.item[0];
  
-        if ((val = ucontrol->value.enumerated.item[0]) > 4)
-                return -EINVAL;
+	if (val > 4)
+		return -EINVAL;
 	return snd_fm801_update_bits(chip, FM801_REC_SRC, 7, val);
 }
 
@@ -1053,19 +1054,22 @@ static int snd_fm801_mixer(struct fm801 *chip)
 		.read = snd_fm801_codec_read,
 	};
 
-	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &chip->ac97_bus)) < 0)
+	err = snd_ac97_bus(chip->card, 0, &ops, chip, &chip->ac97_bus);
+	if (err < 0)
 		return err;
 	chip->ac97_bus->private_free = snd_fm801_mixer_free_ac97_bus;
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
 	ac97.private_free = snd_fm801_mixer_free_ac97;
-	if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97)) < 0)
+	err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97);
+	if (err < 0)
 		return err;
 	if (chip->secondary) {
 		ac97.num = 1;
 		ac97.addr = chip->secondary_addr;
-		if ((err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_sec)) < 0)
+		err = snd_ac97_mixer(chip->ac97_bus, &ac97, &chip->ac97_sec);
+		if (err < 0)
 			return err;
 	}
 	for (i = 0; i < FM801_CONTROLS; i++)
@@ -1208,7 +1212,8 @@ static int snd_fm801_create(struct snd_card *card,
 	};
 
 	*rchip = NULL;
-	if ((err = pcim_enable_device(pci)) < 0)
+	err = pcim_enable_device(pci);
+	if (err < 0)
 		return err;
 	chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
@@ -1218,7 +1223,8 @@ static int snd_fm801_create(struct snd_card *card,
 	chip->dev = &pci->dev;
 	chip->irq = -1;
 	chip->tea575x_tuner = tea575x_tuner;
-	if ((err = pci_request_regions(pci, "FM801")) < 0)
+	err = pci_request_regions(pci, "FM801");
+	if (err < 0)
 		return err;
 	chip->port = pci_resource_start(pci, 0);
 
@@ -1248,7 +1254,8 @@ static int snd_fm801_create(struct snd_card *card,
 
 	snd_fm801_chip_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_fm801_free(chip);
 		return err;
 	}
@@ -1321,7 +1328,10 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 			   0, &card);
 	if (err < 0)
 		return err;
-	if ((err = snd_fm801_create(card, pci, tea575x_tuner[dev], radio_nr[dev], &chip)) < 0) {
+
+	err = snd_fm801_create(card, pci, tea575x_tuner[dev], radio_nr[dev],
+			       &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1336,35 +1346,40 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 	if (chip->tea575x_tuner & TUNER_ONLY)
 		goto __fm801_tuner_only;
 
-	if ((err = snd_fm801_pcm(chip, 0)) < 0) {
+	err = snd_fm801_pcm(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_fm801_mixer(chip)) < 0) {
+	err = snd_fm801_mixer(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_FM801,
-				       chip->port + FM801_MPU401_DATA,
-				       MPU401_INFO_INTEGRATED |
-				       MPU401_INFO_IRQ_HOOK,
-				       -1, &chip->rmidi)) < 0) {
+	err = snd_mpu401_uart_new(card, 0, MPU401_HW_FM801,
+				  chip->port + FM801_MPU401_DATA,
+				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
+				  -1, &chip->rmidi);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3_create(card, chip->port + FM801_OPL3_BANK0,
-				   chip->port + FM801_OPL3_BANK1,
-				   OPL3_HW_OPL3_FM801, 1, &opl3)) < 0) {
+	err = snd_opl3_create(card, chip->port + FM801_OPL3_BANK0,
+			      chip->port + FM801_OPL3_BANK1,
+			      OPL3_HW_OPL3_FM801, 1, &opl3);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
       __fm801_tuner_only:
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
