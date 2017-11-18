From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: trident: Adjust 34 function calls
 together with a variable assignment
Date: Sat, 18 Nov 2017 20:11:20 +0100
Message-ID: <24183956-fd10-73d5-f821-b11aa0f7b871@users.sourceforge.net>
References: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 898E6266EFA
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 20:11:27 +0100 (CET)
In-Reply-To: <498d6d73-2c62-178a-3c7a-b0fcb092d81e@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 18:50:22 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/trident/trident.c      |  24 +++++----
 sound/pci/trident/trident_main.c | 113 ++++++++++++++++++++++++++-------------
 2 files changed, 90 insertions(+), 47 deletions(-)

diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index cedf13b64803..fd35f7826845 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -94,11 +94,13 @@ static int snd_trident_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	if ((err = snd_trident_create(card, pci,
-				      pcm_channels[dev],
-				      ((pci->vendor << 16) | pci->device) == TRIDENT_DEVICE_ID_SI7018 ? 1 : 2,
-				      wavetable_size[dev],
-				      &trident)) < 0) {
+	err = snd_trident_create(card, pci,
+				 pcm_channels[dev],
+				 ((pci->vendor << 16) | pci->device)
+				 == TRIDENT_DEVICE_ID_SI7018 ? 1 : 2,
+				 wavetable_size[dev],
+				 &trident);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -127,21 +129,24 @@ static int snd_trident_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s PCI Audio at 0x%lx, irq %d",
 		card->shortname, trident->port, trident->irq);
 
-	if ((err = snd_trident_pcm(trident, pcm_dev++)) < 0) {
+	err = snd_trident_pcm(trident, pcm_dev++);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	switch (trident->device) {
 	case TRIDENT_DEVICE_ID_DX:
 	case TRIDENT_DEVICE_ID_NX:
-		if ((err = snd_trident_foldback_pcm(trident, pcm_dev++)) < 0) {
+		err = snd_trident_foldback_pcm(trident, pcm_dev++);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
 		break;
 	}
 	if (trident->device == TRIDENT_DEVICE_ID_NX || trident->device == TRIDENT_DEVICE_ID_SI7018) {
-		if ((err = snd_trident_spdif_pcm(trident, pcm_dev++)) < 0) {
+		err = snd_trident_spdif_pcm(trident, pcm_dev++);
+		if (err < 0) {
 			snd_card_free(card);
 			return err;
 		}
@@ -158,7 +163,8 @@ static int snd_trident_probe(struct pci_dev *pci,
 
 	snd_trident_create_gameport(trident);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index eabd84d9ffee..88d666cb3300 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -822,9 +822,10 @@ static int snd_trident_allocate_pcm_mem(struct snd_pcm_substream *substream,
 	struct snd_trident *trident = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_trident_voice *voice = runtime->private_data;
-	int err;
+	int err = snd_pcm_lib_malloc_pages(substream,
+					   params_buffer_bytes(hw_params));
 
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
+	if (err < 0)
 		return err;
 	if (trident->tlb.entries) {
 		if (err > 0) { /* change */
@@ -1142,12 +1143,11 @@ static int snd_trident_capture_prepare(struct snd_pcm_substream *substream)
 static int snd_trident_si7018_capture_hw_params(struct snd_pcm_substream *substream,
 						struct snd_pcm_hw_params *hw_params)
 {
-	int err;
-
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
+	int err = snd_pcm_lib_malloc_pages(substream,
+					   params_buffer_bytes(hw_params));
 
-	return snd_trident_allocate_evoice(substream, hw_params);
+	return (err < 0) ? err : snd_trident_allocate_evoice(substream,
+							     hw_params);
 }
 
 /*---------------------------------------------------------------------------
@@ -2174,9 +2174,10 @@ static const struct snd_pcm_ops snd_trident_spdif_7018_ops = {
 int snd_trident_pcm(struct snd_trident *trident, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(trident->card, "trident_dx_nx",
+			      device, trident->ChanPCM, 1, &pcm);
 
-	if ((err = snd_pcm_new(trident->card, "trident_dx_nx", device, trident->ChanPCM, 1, &pcm)) < 0)
+	if (err < 0)
 		return err;
 
 	pcm->private_data = trident;
@@ -2233,7 +2234,10 @@ int snd_trident_foldback_pcm(struct snd_trident *trident, int device)
 
 	if (trident->device == TRIDENT_DEVICE_ID_NX)
 		num_chan = 4;
-	if ((err = snd_pcm_new(trident->card, "trident_dx_nx", device, 0, num_chan, &foldback)) < 0)
+
+	err = snd_pcm_new(trident->card, "trident_dx_nx", device,
+			  0, num_chan, &foldback);
+	if (err < 0)
 		return err;
 
 	foldback->private_data = trident;
@@ -2279,9 +2283,10 @@ int snd_trident_foldback_pcm(struct snd_trident *trident, int device)
 int snd_trident_spdif_pcm(struct snd_trident *trident, int device)
 {
 	struct snd_pcm *spdif;
-	int err;
+	int err = snd_pcm_new(trident->card, "trident_dx_nx IEC958",
+			      device, 1, 0, &spdif);
 
-	if ((err = snd_pcm_new(trident->card, "trident_dx_nx IEC958", device, 1, 0, &spdif)) < 0)
+	if (err < 0)
 		return err;
 
 	spdif->private_data = trident;
@@ -2973,7 +2978,8 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 	if (!uctl)
 		return -ENOMEM;
 
-	if ((err = snd_ac97_bus(trident->card, 0, &ops, NULL, &trident->ac97_bus)) < 0)
+	err = snd_ac97_bus(trident->card, 0, &ops, NULL, &trident->ac97_bus);
+	if (err < 0)
 		goto __out;
 
 	memset(&_ac97, 0, sizeof(_ac97));
@@ -2981,9 +2987,11 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 	trident->ac97_detect = 1;
 
       __again:
-	if ((err = snd_ac97_mixer(trident->ac97_bus, &_ac97, &trident->ac97)) < 0) {
+	err = snd_ac97_mixer(trident->ac97_bus, &_ac97, &trident->ac97);
+	if (err < 0) {
 		if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
-			if ((err = snd_trident_sis_reset(trident)) < 0)
+			err = snd_trident_sis_reset(trident);
+			if (err < 0)
 				goto __out;
 			if (retries-- > 0)
 				goto __again;
@@ -3014,10 +3022,14 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 	trident->ac97_detect = 0;
 
 	if (trident->device != TRIDENT_DEVICE_ID_SI7018) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_vol_wave_control, trident))) < 0)
+		kctl = snd_ctl_new1(&snd_trident_vol_wave_control, trident);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 		kctl->put(kctl, uctl);
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_vol_music_control, trident))) < 0)
+		kctl = snd_ctl_new1(&snd_trident_vol_music_control, trident);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 		kctl->put(kctl, uctl);
 		outl(trident->musicvol_wavevol = 0x00000000, TRID_REG(trident, T4D_MUSICVOL_WAVEVOL));
@@ -3031,28 +3043,45 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		tmix = &trident->pcm_mixer[idx];
 		tmix->voice = NULL;
 	}
-	if ((trident->ctl_vol = snd_ctl_new1(&snd_trident_pcm_vol_control, trident)) == NULL)
+
+	trident->ctl_vol = snd_ctl_new1(&snd_trident_pcm_vol_control, trident);
+	if (!trident->ctl_vol)
 		goto __nomem;
-	if ((err = snd_ctl_add(card, trident->ctl_vol)))
+
+	err = snd_ctl_add(card, trident->ctl_vol);
+	if (err)
 		goto __out;
 		
-	if ((trident->ctl_pan = snd_ctl_new1(&snd_trident_pcm_pan_control, trident)) == NULL)
+	trident->ctl_pan = snd_ctl_new1(&snd_trident_pcm_pan_control, trident);
+	if (!trident->ctl_pan)
 		goto __nomem;
-	if ((err = snd_ctl_add(card, trident->ctl_pan)))
+
+	err = snd_ctl_add(card, trident->ctl_pan);
+	if (err)
 		goto __out;
 
-	if ((trident->ctl_rvol = snd_ctl_new1(&snd_trident_pcm_rvol_control, trident)) == NULL)
+	trident->ctl_rvol = snd_ctl_new1(&snd_trident_pcm_rvol_control,
+					 trident);
+	if (!trident->ctl_rvol)
 		goto __nomem;
-	if ((err = snd_ctl_add(card, trident->ctl_rvol)))
+
+	err = snd_ctl_add(card, trident->ctl_rvol);
+	if (err)
 		goto __out;
 
-	if ((trident->ctl_cvol = snd_ctl_new1(&snd_trident_pcm_cvol_control, trident)) == NULL)
+	trident->ctl_cvol = snd_ctl_new1(&snd_trident_pcm_cvol_control,
+					 trident);
+	if (!trident->ctl_cvol)
 		goto __nomem;
-	if ((err = snd_ctl_add(card, trident->ctl_cvol)))
+
+	err = snd_ctl_add(card, trident->ctl_cvol);
+	if (err)
 		goto __out;
 
 	if (trident->device == TRIDENT_DEVICE_ID_NX) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_ac97_rear_control, trident))) < 0)
+		kctl = snd_ctl_new1(&snd_trident_ac97_rear_control, trident);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 		kctl->put(kctl, uctl);
 	}
@@ -3068,7 +3097,8 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		if (trident->ac97_sec && (trident->ac97_sec->ext_id & AC97_EI_SPDIF))
 			kctl->id.index++;
 		idx = kctl->id.index;
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 		kctl->put(kctl, uctl);
 
@@ -3079,7 +3109,8 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		}
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_mask, trident);
@@ -3089,7 +3120,8 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		}
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 
 		kctl = snd_ctl_new1(&snd_trident_spdif_stream, trident);
@@ -3099,7 +3131,8 @@ static int snd_trident_mixer(struct snd_trident *trident, int pcm_spdif_device)
 		}
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			goto __out;
 		trident->spdif_pcm_ctl = kctl;
 	}
@@ -3499,9 +3532,9 @@ static int snd_trident_4d_nx_init(struct snd_trident *trident)
  */
 static int snd_trident_sis_init(struct snd_trident *trident)
 {
-	int err;
+	int err = snd_trident_sis_reset(trident);
 
-	if ((err = snd_trident_sis_reset(trident)) < 0)
+	if (err < 0)
 		return err;
 
 	snd_trident_stop_all_voices(trident);
@@ -3546,7 +3579,8 @@ int snd_trident_create(struct snd_card *card,
 	*rtrident = NULL;
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 30 bits */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(30)) < 0 ||
@@ -3580,8 +3614,8 @@ int snd_trident_create(struct snd_card *card,
 
 	trident->midi_port = TRID_REG(trident, T4D_MPU401_BASE);
 	pci_set_master(pci);
-
-	if ((err = pci_request_regions(pci, "Trident Audio")) < 0) {
+	err = pci_request_regions(pci, "Trident Audio");
+	if (err < 0) {
 		kfree(trident);
 		pci_disable_device(pci);
 		return err;
@@ -3600,7 +3634,8 @@ int snd_trident_create(struct snd_card *card,
 	trident->tlb.entries = NULL;
 	trident->tlb.buffer.area = NULL;
 	if (trident->device == TRIDENT_DEVICE_ID_NX) {
-		if ((err = snd_trident_tlb_alloc(trident)) < 0) {
+		err = snd_trident_tlb_alloc(trident);
+		if (err < 0) {
 			snd_trident_free(trident);
 			return err;
 		}
@@ -3628,12 +3663,14 @@ int snd_trident_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, trident, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, trident, &ops);
+	if (err < 0) {
 		snd_trident_free(trident);
 		return err;
 	}
 
-	if ((err = snd_trident_mixer(trident, pcm_spdif_device)) < 0)
+	err = snd_trident_mixer(trident, pcm_spdif_device);
+	if (err < 0)
 		return err;
 	
 	/* initialise synth voices */
-- 
2.15.0
