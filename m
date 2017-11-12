From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: au88x0: Adjust 40 function calls
 together with a variable assignment
Date: Sun, 12 Nov 2017 22:38:26 +0100
Message-ID: <732e88bb-16c9-c192-1b91-5c4364479b4f@users.sourceforge.net>
References: <e42f1434-f1d7-a43b-d887-a82b50158280@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id ECF40267239
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 22:38:34 +0100 (CET)
In-Reply-To: <e42f1434-f1d7-a43b-d887-a82b50158280@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 12 Nov 2017 21:48:44 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/au88x0/au88x0.c        | 56 +++++++++++++++++++++++-----------------
 sound/pci/au88x0/au88x0_a3d.c    | 28 +++++++++++---------
 sound/pci/au88x0/au88x0_core.c   | 52 ++++++++++++++++++++-----------------
 sound/pci/au88x0/au88x0_eq.c     | 21 +++++++++------
 sound/pci/au88x0/au88x0_mixer.c  |  3 ++-
 sound/pci/au88x0/au88x0_mpu401.c | 14 +++++-----
 sound/pci/au88x0/au88x0_pcm.c    | 16 +++++++-----
 7 files changed, 109 insertions(+), 81 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 32092184bbf2..fc5c47ace64f 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -46,13 +46,13 @@ MODULE_DEVICE_TABLE(pci, snd_vortex_ids);
 
 static void vortex_fix_latency(struct pci_dev *vortex)
 {
-	int rc;
-	if (!(rc = pci_write_config_byte(vortex, 0x40, 0xff))) {
-			dev_info(&vortex->dev, "vortex latency is 0xff\n");
-	} else {
+	int rc = pci_write_config_byte(vortex, 0x40, 0xff);
+
+	if (rc)
 		dev_warn(&vortex->dev,
 			 "could not set vortex latency: pci error 0x%x\n", rc);
-	}
+	else
+		dev_info(&vortex->dev, "vortex latency is 0xff\n");
 }
 
 static void vortex_fix_agp_bridge(struct pci_dev *via)
@@ -148,7 +148,8 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	*rchip = NULL;
 
 	// check PCI availability (DMA).
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(32)) < 0 ||
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(32)) < 0) {
@@ -176,7 +177,8 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	// (1) PCI resource allocation
 	// Get MMIO area
 	//
-	if ((err = pci_request_regions(pci, CARD_NAME_SHORT)) != 0)
+	err = pci_request_regions(pci, CARD_NAME_SHORT);
+	if (err)
 		goto regions_out;
 
 	chip->mmio = pci_ioremap_bar(pci, 0);
@@ -189,14 +191,15 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	/* Init audio core.
 	 * This must be done before we do request_irq otherwise we can get spurious
 	 * interrupts that we do not handle properly and make a mess of things */
-	if ((err = vortex_core_init(chip)) != 0) {
+	err = vortex_core_init(chip);
+	if (err) {
 		dev_err(card->dev, "hw core init failed\n");
 		goto core_out;
 	}
 
-	if ((err = request_irq(pci->irq, vortex_interrupt,
-			       IRQF_SHARED, KBUILD_MODNAME,
-	                       chip)) != 0) {
+	err = request_irq(pci->irq, vortex_interrupt,
+			  IRQF_SHARED, KBUILD_MODNAME, chip);
+	if (err) {
 		dev_err(card->dev, "cannot grab irq\n");
 		goto irq_out;
 	}
@@ -206,9 +209,9 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	// End of PCI setup.
 
 	// Register alsa root device.
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
 		goto alloc_out;
-	}
 
 	*rchip = chip;
 
@@ -253,7 +256,8 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 		return err;
 
 	// (3)
-	if ((err = snd_vortex_create(card, pci, &chip)) < 0) {
+	err = snd_vortex_create(card, pci, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -279,12 +283,14 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	}
 #ifndef CHIP_AU8820
 	// ADB SPDIF
-	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_SPDIF, 1)) < 0) {
+	err = snd_vortex_new_pcm(chip, VORTEX_PCM_SPDIF, 1);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	// A3D
-	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_A3D, NR_A3D)) < 0) {
+	err = snd_vortex_new_pcm(chip, VORTEX_PCM_A3D, NR_A3D);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -298,12 +304,14 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	 */
 #ifndef CHIP_AU8810
 	// WT pcm.
-	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_WT, NR_WT)) < 0) {
+	err = snd_vortex_new_pcm(chip, VORTEX_PCM_WT, NR_WT);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 #endif
-	if ((err = snd_vortex_midi(chip)) < 0) {
+	err = snd_vortex_midi(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -328,13 +336,14 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 #endif
 
 	// (5)
-	if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
-				  &(chip->device))) < 0) {
+	err = pci_read_config_word(pci, PCI_DEVICE_ID, &(chip->device));
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}	
-	if ((err = pci_read_config_word(pci, PCI_VENDOR_ID,
-				  &(chip->vendor))) < 0) {
+
+	err = pci_read_config_word(pci, PCI_VENDOR_ID, &(chip->vendor));
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -353,7 +362,8 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 #endif
 
 	// (6)
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/au88x0/au88x0_a3d.c b/sound/pci/au88x0/au88x0_a3d.c
index 7a4558a70fb9..df8227274914 100644
--- a/sound/pci/au88x0/au88x0_a3d.c
+++ b/sound/pci/au88x0/au88x0_a3d.c
@@ -862,46 +862,50 @@ static int vortex_a3d_register_controls(vortex_t *vortex)
 	int err, i;
 	/* HRTF controls. */
 	for (i = 0; i < NR_A3D; i++) {
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+		kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+		if (!kcontrol)
 			return -ENOMEM;
 		kcontrol->id.numid = CTRLID_HRTF;
 		kcontrol->info = snd_vortex_a3d_hrtf_info;
 		kcontrol->put = snd_vortex_a3d_hrtf_put;
-		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+		err = snd_ctl_add(vortex->card, kcontrol);
+		if (err < 0)
 			return err;
 	}
 	/* ITD controls. */
 	for (i = 0; i < NR_A3D; i++) {
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+		kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+		if (!kcontrol)
 			return -ENOMEM;
 		kcontrol->id.numid = CTRLID_ITD;
 		kcontrol->info = snd_vortex_a3d_itd_info;
 		kcontrol->put = snd_vortex_a3d_itd_put;
-		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+		err = snd_ctl_add(vortex->card, kcontrol);
+		if (err < 0)
 			return err;
 	}
 	/* ILD (gains) controls. */
 	for (i = 0; i < NR_A3D; i++) {
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+		kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+		if (!kcontrol)
 			return -ENOMEM;
 		kcontrol->id.numid = CTRLID_GAINS;
 		kcontrol->info = snd_vortex_a3d_ild_info;
 		kcontrol->put = snd_vortex_a3d_ild_put;
-		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+		err = snd_ctl_add(vortex->card, kcontrol);
+		if (err < 0)
 			return err;
 	}
 	/* Filter controls. */
 	for (i = 0; i < NR_A3D; i++) {
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i])) == NULL)
+		kcontrol = snd_ctl_new1(&vortex_a3d_kcontrol, &vortex->a3d[i]);
+		if (!kcontrol)
 			return -ENOMEM;
 		kcontrol->id.numid = CTRLID_FILTER;
 		kcontrol->info = snd_vortex_a3d_filter_info;
 		kcontrol->put = snd_vortex_a3d_filter_put;
-		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+		err = snd_ctl_add(vortex->card, kcontrol);
+		if (err < 0)
 			return err;
 	}
 	return 0;
diff --git a/sound/pci/au88x0/au88x0_core.c b/sound/pci/au88x0/au88x0_core.c
index 4083c8b01619..cdb1c227442b 100644
--- a/sound/pci/au88x0/au88x0_core.c
+++ b/sound/pci/au88x0/au88x0_core.c
@@ -2126,9 +2126,9 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 				      VORTEX_RESOURCE_DMA);
 	} else {
 		en = 1;
-		if ((dma =
-		     vortex_adb_checkinout(vortex, NULL, en,
-					   VORTEX_RESOURCE_DMA)) < 0)
+		dma = vortex_adb_checkinout(vortex, NULL, en,
+					    VORTEX_RESOURCE_DMA);
+		if (dma < 0)
 			return -EBUSY;
 	}
 
@@ -2146,18 +2146,24 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 		/* Get SRC and MIXER hardware resources. */
 		if (stream->type != VORTEX_PCM_SPDIF) {
 			for (i = 0; i < nr_ch; i++) {
-				if ((src[i] = vortex_adb_checkinout(vortex,
-							   stream->resources, en,
-							   VORTEX_RESOURCE_SRC)) < 0) {
+				src[i] = vortex_adb_checkinout(vortex,
+							       stream
+							       ->resources,
+							       en,
+							       VORTEX_RESOURCE_SRC);
+				if (src[i] < 0) {
 					memset(stream->resources, 0,
 					       sizeof(stream->resources));
 					return -EBUSY;
 				}
 				if (stream->type != VORTEX_PCM_A3D) {
-					if ((mix[i] = vortex_adb_checkinout(vortex,
-								   stream->resources,
-								   en,
-								   VORTEX_RESOURCE_MIXIN)) < 0) {
+					mix[i] =
+					      vortex_adb_checkinout(vortex,
+								    stream
+								    ->resources,
+								    en,
+								    VORTEX_RESOURCE_MIXIN);
+					if (mix[i] < 0) {
 						memset(stream->resources,
 						       0,
 						       sizeof(stream->resources));
@@ -2168,10 +2174,10 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 		}
 #ifndef CHIP_AU8820
 		if (stream->type == VORTEX_PCM_A3D) {
-			if ((a3d =
-			     vortex_adb_checkinout(vortex,
-						   stream->resources, en,
-						   VORTEX_RESOURCE_A3D)) < 0) {
+			a3d = vortex_adb_checkinout(vortex,
+						    stream->resources, en,
+						    VORTEX_RESOURCE_A3D);
+			if (a3d < 0) {
 				memset(stream->resources, 0,
 				       sizeof(stream->resources));
 				dev_err(vortex->card->dev,
@@ -2284,19 +2290,19 @@ vortex_adb_allocroute(vortex_t *vortex, int dma, int nr_ch, int dir,
 
 		/* Get SRC and MIXER hardware resources. */
 		for (i = 0; i < nr_ch; i++) {
-			if ((mix[i] =
-			     vortex_adb_checkinout(vortex,
-						   stream->resources, en,
-						   VORTEX_RESOURCE_MIXOUT))
-			    < 0) {
+			mix[i] = vortex_adb_checkinout(vortex,
+						       stream->resources, en,
+						       VORTEX_RESOURCE_MIXOUT);
+			if (mix[i] < 0) {
 				memset(stream->resources, 0,
 				       sizeof(stream->resources));
 				return -EBUSY;
 			}
-			if ((src[i] =
-			     vortex_adb_checkinout(vortex,
-						   stream->resources, en,
-						   VORTEX_RESOURCE_SRC)) < 0) {
+
+			src[i] = vortex_adb_checkinout(vortex,
+						       stream->resources, en,
+						       VORTEX_RESOURCE_SRC);
+			if (src[i] < 0) {
 				memset(stream->resources, 0,
 				       sizeof(stream->resources));
 				return -EBUSY;
diff --git a/sound/pci/au88x0/au88x0_eq.c b/sound/pci/au88x0/au88x0_eq.c
index b566b44e4da7..4b0b99972a36 100644
--- a/sound/pci/au88x0/au88x0_eq.c
+++ b/sound/pci/au88x0/au88x0_eq.c
@@ -885,29 +885,34 @@ static int vortex_eq_init(vortex_t *vortex)
 
 	vortex_Eqlzr_init(vortex);
 
-	if ((kcontrol =
-	     snd_ctl_new1(&vortex_eqtoggle_kcontrol, vortex)) == NULL)
+	kcontrol = snd_ctl_new1(&vortex_eqtoggle_kcontrol, vortex);
+	if (!kcontrol)
 		return -ENOMEM;
 	kcontrol->private_value = 0;
-	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+	err = snd_ctl_add(vortex->card, kcontrol);
+	if (err < 0)
 		return err;
 
 	/* EQ gain controls */
 	for (i = 0; i < 10; i++) {
-		if ((kcontrol =
-		     snd_ctl_new1(&vortex_eq_kcontrol, vortex)) == NULL)
+		kcontrol = snd_ctl_new1(&vortex_eq_kcontrol, vortex);
+		if (!kcontrol)
 			return -ENOMEM;
 		snprintf(kcontrol->id.name, sizeof(kcontrol->id.name),
 			"%s Playback Volume", EqBandLabels[i]);
 		kcontrol->private_value = i;
-		if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+		err = snd_ctl_add(vortex->card, kcontrol);
+		if (err < 0)
 			return err;
 		//vortex->eqctrl[i] = kcontrol;
 	}
 	/* EQ band levels */
-	if ((kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex)) == NULL)
+	kcontrol = snd_ctl_new1(&vortex_levels_kcontrol, vortex);
+	if (!kcontrol)
 		return -ENOMEM;
-	if ((err = snd_ctl_add(vortex->card, kcontrol)) < 0)
+
+	err = snd_ctl_add(vortex->card, kcontrol);
+	if (err < 0)
 		return err;
 
 	return 0;
diff --git a/sound/pci/au88x0/au88x0_mixer.c b/sound/pci/au88x0/au88x0_mixer.c
index a58298cfe7e0..b7659403bad0 100644
--- a/sound/pci/au88x0/au88x0_mixer.c
+++ b/sound/pci/au88x0/au88x0_mixer.c
@@ -29,7 +29,8 @@ static int snd_vortex_mixer(vortex_t *vortex)
 		.read = vortex_codec_read,
 	};
 
-	if ((err = snd_ac97_bus(vortex->card, 0, &ops, NULL, &pbus)) < 0)
+	err = snd_ac97_bus(vortex->card, 0, &ops, NULL, &pbus);
+	if (err < 0)
 		return err;
 	memset(&ac97, 0, sizeof(ac97));
 	// Initialize AC97 codec stuff.
diff --git a/sound/pci/au88x0/au88x0_mpu401.c b/sound/pci/au88x0/au88x0_mpu401.c
index 1025e55ca854..e0dc058d4ca0 100644
--- a/sound/pci/au88x0/au88x0_mpu401.c
+++ b/sound/pci/au88x0/au88x0_mpu401.c
@@ -82,9 +82,9 @@ static int snd_vortex_midi(vortex_t *vortex)
 
 	/* Create MPU401 instance. */
 #ifdef VORTEX_MPU401_LEGACY
-	if ((temp =
-	     snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_MPU401, 0x330,
-				 MPU401_INFO_IRQ_HOOK, -1, &rmidi)) != 0) {
+	temp = snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_MPU401, 0x330,
+				   MPU401_INFO_IRQ_HOOK, -1, &rmidi);
+	if (temp != 0) {
 		hwwrite(vortex->mmio, VORTEX_CTRL,
 			(hwread(vortex->mmio, VORTEX_CTRL) &
 			 ~CTRL_MIDI_PORT) & ~CTRL_MIDI_EN);
@@ -92,10 +92,10 @@ static int snd_vortex_midi(vortex_t *vortex)
 	}
 #else
 	port = (unsigned long)(vortex->mmio + VORTEX_MIDI_DATA);
-	if ((temp =
-	     snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
-				 MPU401_INFO_INTEGRATED | MPU401_INFO_MMIO |
-				 MPU401_INFO_IRQ_HOOK, -1, &rmidi)) != 0) {
+	temp = snd_mpu401_uart_new(vortex->card, 0, MPU401_HW_AUREAL, port,
+				   MPU401_INFO_INTEGRATED | MPU401_INFO_MMIO |
+				   MPU401_INFO_IRQ_HOOK, -1, &rmidi);
+	if (temp != 0) {
 		hwwrite(vortex->mmio, VORTEX_CTRL,
 			(hwread(vortex->mmio, VORTEX_CTRL) &
 			 ~CTRL_MIDI_PORT) & ~CTRL_MIDI_EN);
diff --git a/sound/pci/au88x0/au88x0_pcm.c b/sound/pci/au88x0/au88x0_pcm.c
index 53714e0bf598..06e92db600e5 100644
--- a/sound/pci/au88x0/au88x0_pcm.c
+++ b/sound/pci/au88x0/au88x0_pcm.c
@@ -142,14 +142,14 @@ static int snd_vortex_pcm_open(struct snd_pcm_substream *substream)
 	int err;
 	
 	/* Force equal size periods */
-	if ((err =
-	     snd_pcm_hw_constraint_integer(runtime,
-					   SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+	err = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
 		return err;
 	/* Avoid PAGE_SIZE boundary to fall inside of a period. */
-	if ((err =
-	     snd_pcm_hw_constraint_pow2(runtime, 0,
-					SNDRV_PCM_HW_PARAM_PERIOD_BYTES)) < 0)
+	err = snd_pcm_hw_constraint_pow2(runtime, 0,
+					 SNDRV_PCM_HW_PARAM_PERIOD_BYTES);
+	if (err < 0)
 		return err;
 
 	snd_pcm_hw_constraint_step(runtime, 0,
@@ -681,7 +681,9 @@ static int snd_vortex_new_pcm(vortex_t *chip, int idx, int nr)
 			kctl = snd_ctl_new1(&snd_vortex_mixer_spdif[i], chip);
 			if (!kctl)
 				return -ENOMEM;
-			if ((err = snd_ctl_add(chip->card, kctl)) < 0)
+
+			err = snd_ctl_add(chip->card, kctl);
+			if (err < 0)
 				return err;
 		}
 	}
-- 
2.15.0
