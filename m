From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: rme96: Adjust 11 function calls
 together with a variable assignment
Date: Sat, 18 Nov 2017 13:52:41 +0100
Message-ID: <f25f087a-71d5-4bdb-1847-d0077803b899@users.sourceforge.net>
References: <7b7da9a6-64e1-bde5-99aa-de21f0665323@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E56126698E
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 13:53:19 +0100 (CET)
In-Reply-To: <7b7da9a6-64e1-bde5-99aa-de21f0665323@users.sourceforge.net>
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
Date: Sat, 18 Nov 2017 13:23:20 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/rme96.c | 78 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 32 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index dcfa4d7a73e2..fd8a62ceffde 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -1065,29 +1065,33 @@ snd_rme96_capture_hw_params(struct snd_pcm_substream *substream,
 	runtime->dma_bytes = RME96_BUFFER_SIZE;
 
 	spin_lock_irq(&rme96->lock);
-	if ((err = snd_rme96_capture_setformat(rme96, params_format(params))) < 0) {
+	err = snd_rme96_capture_setformat(rme96, params_format(params));
+	if (err < 0) {
 		spin_unlock_irq(&rme96->lock);
 		return err;
 	}
 	if (snd_rme96_getinputtype(rme96) == RME96_INPUT_ANALOG) {
-		if ((err = snd_rme96_capture_analog_setrate(rme96,
-							    params_rate(params))) < 0)
-		{
+		err = snd_rme96_capture_analog_setrate(rme96,
+						       params_rate(params));
+		if (err < 0) {
 			spin_unlock_irq(&rme96->lock);
 			return err;
 		}
-	} else if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
-                if ((int)params_rate(params) != rate) {
-			spin_unlock_irq(&rme96->lock);
-			return -EIO;                    
-                }
-                if ((isadat && runtime->hw.channels_min == 2) ||
-                    (!isadat && runtime->hw.channels_min == 8))
-                {
-			spin_unlock_irq(&rme96->lock);
-			return -EIO;
-                }
-        }
+	} else {
+		rate = snd_rme96_capture_getrate(rme96, &isadat);
+		if (rate > 0) {
+			if ((int)params_rate(params) != rate) {
+				spin_unlock_irq(&rme96->lock);
+				return -EIO;
+			}
+			if ((isadat && runtime->hw.channels_min == 2) ||
+			    (!isadat && runtime->hw.channels_min == 8)) {
+				spin_unlock_irq(&rme96->lock);
+				return -EIO;
+			}
+		}
+	}
+
 	snd_rme96_setframelog(rme96, params_channels(params), 0);
 	if (rme96->playback_periodsize != 0) {
 		if (params_period_size(params) << rme96->capture_frlog !=
@@ -1305,7 +1309,9 @@ snd_rme96_capture_adat_open(struct snd_pcm_substream *substream)
                    expension cards AEB4/8-I are RME96_INPUT_INTERNAL */
                 return -EIO;
         }
-        if ((rate = snd_rme96_capture_getrate(rme96, &isadat)) > 0) {
+
+	rate = snd_rme96_capture_getrate(rme96, &isadat);
+	if (rate > 0) {
                 if (!isadat) {
                         return -EIO;
                 }
@@ -1626,10 +1632,12 @@ snd_rme96_create(struct rme96 *rme96)
 	rme96->irq = -1;
 	spin_lock_init(&rme96->lock);
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
-	if ((err = pci_request_regions(pci, "RME96")) < 0)
+	err = pci_request_regions(pci, "RME96");
+	if (err < 0)
 		return err;
 	rme96->port = pci_resource_start(rme96->pci, 0);
 
@@ -1652,11 +1660,11 @@ snd_rme96_create(struct rme96 *rme96)
 	pci_read_config_byte(pci, 8, &rme96->rev);	
 	
 	/* set up ALSA pcm device for S/PDIF */
-	if ((err = snd_pcm_new(rme96->card, "Digi96 IEC958", 0,
-			       1, 1, &rme96->spdif_pcm)) < 0)
-	{
+	err = snd_pcm_new(rme96->card, "Digi96 IEC958",
+			  0, 1, 1, &rme96->spdif_pcm);
+	if (err < 0)
 		return err;
-	}
+
 	rme96->spdif_pcm->private_data = rme96;
 	rme96->spdif_pcm->private_free = snd_rme96_free_spdif_pcm;
 	strcpy(rme96->spdif_pcm->name, "Digi96 IEC958");
@@ -1670,11 +1678,11 @@ snd_rme96_create(struct rme96 *rme96)
 		/* ADAT is not available on the base model */
 		rme96->adat_pcm = NULL;
 	} else {
-		if ((err = snd_pcm_new(rme96->card, "Digi96 ADAT", 1,
-				       1, 1, &rme96->adat_pcm)) < 0)
-		{
+		err = snd_pcm_new(rme96->card, "Digi96 ADAT",
+				  1, 1, 1, &rme96->adat_pcm);
+		if (err < 0)
 			return err;
-		}		
+
 		rme96->adat_pcm->private_data = rme96;
 		rme96->adat_pcm->private_free = snd_rme96_free_adat_pcm;
 		strcpy(rme96->adat_pcm->name, "Digi96 ADAT");
@@ -1723,9 +1731,9 @@ snd_rme96_create(struct rme96 *rme96)
 	}
 	
 	/* init switch interface */
-	if ((err = snd_rme96_create_switches(rme96->card, rme96)) < 0) {
+	err = snd_rme96_create_switches(rme96->card, rme96);
+	if (err < 0)
 		return err;
-	}
 
         /* init proc interface */
 	snd_rme96_proc_init(rme96);
@@ -2361,16 +2369,22 @@ snd_rme96_create_switches(struct snd_card *card,
 	struct snd_kcontrol *kctl;
 
 	for (idx = 0; idx < 7; idx++) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_rme96_controls[idx], rme96))) < 0)
+		kctl = snd_ctl_new1(&snd_rme96_controls[idx], rme96);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 		if (idx == 1)	/* IEC958 (S/PDIF) Stream */
 			rme96->spdif_ctl = kctl;
 	}
 
 	if (RME96_HAS_ANALOG_OUT(rme96)) {
-		for (idx = 7; idx < 10; idx++)
-			if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_rme96_controls[idx], rme96))) < 0)
+		for (idx = 7; idx < 10; idx++) {
+			err = snd_ctl_add(card,
+					  snd_ctl_new1(&snd_rme96_controls[idx],
+						       rme96));
+			if (err < 0)
 				return err;
+		}
 	}
 	
 	return 0;
-- 
2.15.0
