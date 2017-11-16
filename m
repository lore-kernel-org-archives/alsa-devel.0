From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: korg1212: Adjust eight function
 calls together with a variable assignment
Date: Thu, 16 Nov 2017 12:51:27 +0100
Message-ID: <029bd28a-1691-58d8-e1e8-56ae4f189439@users.sourceforge.net>
References: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E1AC266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 12:52:04 +0100 (CET)
In-Reply-To: <3f68211d-51f0-2990-d711-44eaeb85ba4d@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 09:42:45 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/korg1212/korg1212.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index c7b007164c99..6dde8c215b48 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -1542,7 +1542,8 @@ static int snd_korg1212_hw_params(struct snd_pcm_substream *substream,
 	        return 0;
 	}
 
-        if ((err = snd_korg1212_SetRate(korg1212, params_rate(params))) < 0) {
+	err = snd_korg1212_SetRate(korg1212, params_rate(params));
+	if (err < 0) {
                 spin_unlock_irqrestore(&korg1212->lock, flags);
                 return err;
         }
@@ -2174,8 +2175,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
         };
 
         * rchip = NULL;
-        if ((err = pci_enable_device(pci)) < 0)
-                return err;
+	err = pci_enable_device(pci);
+	if (err < 0)
+		return err;
 
         korg1212 = kzalloc(sizeof(*korg1212), GFP_KERNEL);
         if (korg1212 == NULL) {
@@ -2211,7 +2213,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
         for (i=0; i<kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
-	if ((err = pci_request_regions(pci, "korg1212")) < 0) {
+	err = pci_request_regions(pci, "korg1212");
+	if (err < 0) {
 		kfree(korg1212);
 		pci_disable_device(pci);
 		return err;
@@ -2235,7 +2238,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 		   korg1212->iomem2, iomem2_size,
 		   stateName[korg1212->cardState]);
 
-        if ((korg1212->iobase = ioremap(korg1212->iomem, iomem_size)) == NULL) {
+	korg1212->iobase = ioremap(korg1212->iomem, iomem_size);
+	if (!korg1212->iobase) {
 		snd_printk(KERN_ERR "korg1212: unable to remap memory region 0x%lx-0x%lx\n", korg1212->iomem,
                            korg1212->iomem + iomem_size - 1);
                 snd_korg1212_free(korg1212);
@@ -2375,7 +2379,8 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
 	if (rc)
 		K1212_DEBUG_PRINTK("K1212_DEBUG: Reboot Card - RC = %d [%s]\n", rc, stateName[korg1212->cardState]);
 
-        if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, korg1212, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, korg1212, &ops);
+	if (err < 0) {
                 snd_korg1212_free(korg1212);
                 return err;
         }
@@ -2400,8 +2405,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci,
                korg1212->RoutingTablePhy, LowerWordSwap(korg1212->RoutingTablePhy),
                korg1212->AdatTimeCodePhy, LowerWordSwap(korg1212->AdatTimeCodePhy));
 
-        if ((err = snd_pcm_new(korg1212->card, "korg1212", 0, 1, 1, &korg1212->pcm)) < 0)
-                return err;
+	err = snd_pcm_new(korg1212->card, "korg1212", 0, 1, 1, &korg1212->pcm);
+	if (err < 0)
+		return err;
 
 	korg1212->pcm->private_data = korg1212;
         korg1212->pcm->private_free = snd_korg1212_free_pcm;
@@ -2451,7 +2457,8 @@ snd_korg1212_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-        if ((err = snd_korg1212_create(card, pci, &korg1212)) < 0) {
+	err = snd_korg1212_create(card, pci, &korg1212);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2463,7 +2470,8 @@ snd_korg1212_probe(struct pci_dev *pci,
 
         K1212_DEBUG_PRINTK("K1212_DEBUG: %s\n", card->longname);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
