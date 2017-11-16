From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: pcxhr: Adjust six function calls
 together with a variable assignment
Date: Thu, 16 Nov 2017 22:26:08 +0100
Message-ID: <41a0e34c-d3b5-c9d9-1827-9977e084bd0f@users.sourceforge.net>
References: <c110ba76-d99d-9f80-d927-14d437115004@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D1128266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 22:26:15 +0100 (CET)
In-Reply-To: <c110ba76-d99d-9f80-d927-14d437115004@users.sourceforge.net>
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
Date: Thu, 16 Nov 2017 21:50:21 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/pcxhr/pcxhr.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index f9ae72f28ddc..c490d7e57ff7 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1166,9 +1166,10 @@ int pcxhr_create_pcm(struct snd_pcxhr *chip)
 	char name[32];
 
 	snprintf(name, sizeof(name), "pcxhr %d", chip->chip_idx);
-	if ((err = snd_pcm_new(chip->card, name, 0,
-			       chip->nb_streams_play,
-			       chip->nb_streams_capt, &pcm)) < 0) {
+	err = snd_pcm_new(chip->card, name, 0,
+			  chip->nb_streams_play,
+			  chip->nb_streams_capt, &pcm);
+	if (err < 0) {
 		dev_err(chip->card->dev, "cannot create pcm %s\n", name);
 		return err;
 	}
@@ -1233,7 +1234,8 @@ static int pcxhr_create(struct pcxhr_mgr *mgr,
 			chip->nb_streams_capt = 1;	/* or 1 stereo stream */
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		pcxhr_chip_free(chip);
 		return err;
 	}
@@ -1530,7 +1532,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 	}
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	pci_set_master(pci);
 
@@ -1575,7 +1578,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 		mgr->granularity = PCXHR_GRANULARITY;
 
 	/* resource assignment */
-	if ((err = pci_request_regions(pci, card_name)) < 0) {
+	err = pci_request_regions(pci, card_name);
+	if (err < 0) {
 		kfree(mgr);
 		pci_disable_device(pci);
 		return err;
@@ -1646,7 +1650,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 		snprintf(card->longname, sizeof(card->longname),
 			 "%s [PCM #%d]", mgr->name, i);
 
-		if ((err = pcxhr_create(mgr, card, i)) < 0) {
+		err = pcxhr_create(mgr, card, i);
+		if (err < 0) {
 			snd_card_free(card);
 			pcxhr_free(mgr);
 			return err;
@@ -1656,7 +1661,8 @@ static int pcxhr_probe(struct pci_dev *pci,
 			/* init proc interface only for chip0 */
 			pcxhr_proc_init(mgr->chip[i]);
 
-		if ((err = snd_card_register(card)) < 0) {
+		err = snd_card_register(card);
+		if (err < 0) {
 			pcxhr_free(mgr);
 			return err;
 		}
-- 
2.15.0
