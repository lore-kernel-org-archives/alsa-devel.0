From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: rme32: Adjust 15 function calls
 together with a variable assignment
Date: Fri, 17 Nov 2017 22:16:02 +0100
Message-ID: <85f2946e-1155-2db2-6bd8-04eeea067178@users.sourceforge.net>
References: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id A52D9266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 22:16:40 +0100 (CET)
In-Reply-To: <67820e63-aed9-c775-8417-b0f531a9b305@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 21:00:37 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme32.c | 65 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index f0906ba416d4..e58e9873c514 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -691,11 +691,16 @@ snd_rme32_playback_hw_params(struct snd_pcm_substream *substream,
 			spin_unlock_irq(&rme32->lock);
 			return -EIO;
 		}
-	} else if ((err = snd_rme32_playback_setrate(rme32, params_rate(params))) < 0) {
-		spin_unlock_irq(&rme32->lock);
-		return err;
+	} else {
+		err = snd_rme32_playback_setrate(rme32, params_rate(params));
+		if (err < 0) {
+			spin_unlock_irq(&rme32->lock);
+			return err;
+		}
 	}
-	if ((err = snd_rme32_setformat(rme32, params_format(params))) < 0) {
+
+	err = snd_rme32_setformat(rme32, params_format(params));
+	if (err < 0) {
 		spin_unlock_irq(&rme32->lock);
 		return err;
 	}
@@ -743,15 +748,18 @@ snd_rme32_capture_hw_params(struct snd_pcm_substream *substream,
 	rme32->wcreg |= RME32_WCR_AUTOSYNC;
 	writel(rme32->wcreg, rme32->iobase + RME32_IO_CONTROL_REGISTER);
 
-	if ((err = snd_rme32_setformat(rme32, params_format(params))) < 0) {
+	err = snd_rme32_setformat(rme32, params_format(params));
+	if (err < 0) {
 		spin_unlock_irq(&rme32->lock);
 		return err;
 	}
-	if ((err = snd_rme32_playback_setrate(rme32, params_rate(params))) < 0) {
+	err = snd_rme32_playback_setrate(rme32, params_rate(params));
+	if (err < 0) {
 		spin_unlock_irq(&rme32->lock);
 		return err;
 	}
-	if ((rate = snd_rme32_capture_getrate(rme32, &isadat)) > 0) {
+	rate = snd_rme32_capture_getrate(rme32, &isadat);
+	if (rate > 0) {
                 if ((int)params_rate(params) != rate) {
 			spin_unlock_irq(&rme32->lock);
                         return -EIO;                    
@@ -923,7 +931,9 @@ static int snd_rme32_capture_spdif_open(struct snd_pcm_substream *substream)
 		runtime->hw.rates |= SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000;
 		runtime->hw.rate_max = 96000;
 	}
-	if ((rate = snd_rme32_capture_getrate(rme32, &isadat)) > 0) {
+
+	rate = snd_rme32_capture_getrate(rme32, &isadat);
+	if (rate > 0) {
 		if (isadat) {
 			return -EIO;
 		}
@@ -983,7 +993,9 @@ snd_rme32_capture_adat_open(struct snd_pcm_substream *substream)
 		runtime->hw = snd_rme32_adat_fd_info;
 	else
 		runtime->hw = snd_rme32_adat_info;
-	if ((rate = snd_rme32_capture_getrate(rme32, &isadat)) > 0) {
+
+	rate = snd_rme32_capture_getrate(rme32, &isadat);
+	if (rate > 0) {
 		if (!isadat) {
 			return -EIO;
 		}
@@ -1357,10 +1369,12 @@ static int snd_rme32_create(struct rme32 *rme32)
 	rme32->irq = -1;
 	spin_lock_init(&rme32->lock);
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	if ((err = pci_request_regions(pci, "RME32")) < 0)
+	err = pci_request_regions(pci, "RME32");
+	if (err < 0)
 		return err;
 	rme32->port = pci_resource_start(rme32->pci, 0);
 
@@ -1383,9 +1397,11 @@ static int snd_rme32_create(struct rme32 *rme32)
 	pci_read_config_byte(pci, 8, &rme32->rev);
 
 	/* set up ALSA pcm device for S/PDIF */
-	if ((err = snd_pcm_new(rme32->card, "Digi32 IEC958", 0, 1, 1, &rme32->spdif_pcm)) < 0) {
+	err = snd_pcm_new(rme32->card, "Digi32 IEC958",
+			  0, 1, 1, &rme32->spdif_pcm);
+	if (err < 0)
 		return err;
-	}
+
 	rme32->spdif_pcm->private_data = rme32;
 	rme32->spdif_pcm->private_free = snd_rme32_free_spdif_pcm;
 	strcpy(rme32->spdif_pcm->name, "Digi32 IEC958");
@@ -1413,11 +1429,11 @@ static int snd_rme32_create(struct rme32 *rme32)
 		rme32->adat_pcm = NULL;
 	}
 	else {
-		if ((err = snd_pcm_new(rme32->card, "Digi32 ADAT", 1,
-				       1, 1, &rme32->adat_pcm)) < 0)
-		{
+		err = snd_pcm_new(rme32->card, "Digi32 ADAT",
+				  1, 1, 1, &rme32->adat_pcm);
+		if (err < 0)
 			return err;
-		}		
+
 		rme32->adat_pcm->private_data = rme32;
 		rme32->adat_pcm->private_free = snd_rme32_free_adat_pcm;
 		strcpy(rme32->adat_pcm->name, "Digi32 ADAT");
@@ -1460,9 +1476,9 @@ static int snd_rme32_create(struct rme32 *rme32)
 
 
 	/* init switch interface */
-	if ((err = snd_rme32_create_switches(rme32->card, rme32)) < 0) {
+	err = snd_rme32_create_switches(rme32->card, rme32);
+	if (err < 0)
 		return err;
-	}
 
 	/* init proc interface */
 	snd_rme32_proc_init(rme32);
@@ -1908,7 +1924,9 @@ static int snd_rme32_create_switches(struct snd_card *card, struct rme32 * rme32
 	struct snd_kcontrol *kctl;
 
 	for (idx = 0; idx < (int)ARRAY_SIZE(snd_rme32_controls); idx++) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_rme32_controls[idx], rme32))) < 0)
+		kctl = snd_ctl_new1(&snd_rme32_controls[idx], rme32);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 		if (idx == 1)	/* IEC958 (S/PDIF) Stream */
 			rme32->spdif_ctl = kctl;
@@ -1952,7 +1970,9 @@ snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	rme32->pci = pci;
         if (fullduplex[dev])
 		rme32->fullduplex_mode = 1;
-	if ((err = snd_rme32_create(rme32)) < 0) {
+
+	err = snd_rme32_create(rme32);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1972,7 +1992,8 @@ snd_rme32_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	sprintf(card->longname, "%s (Rev. %d) at 0x%lx, irq %d",
 		card->shortname, rme32->rev, rme32->port, rme32->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
