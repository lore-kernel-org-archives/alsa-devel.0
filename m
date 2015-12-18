From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] ALSA: fm801: store struct device
	instead of pci_dev
Date: Fri, 18 Dec 2015 21:14:13 +0200
Message-ID: <1450466053-52170-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450466053-52170-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B488E265DC3
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 20:14:47 +0100 (CET)
In-Reply-To: <1450466053-52170-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There is no need to store struct pci_dev in struct fm801. Generic struct device
can be easily translated to struct pci_dev whenever it's needed, in particular
for one user for now.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/fm801.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c24cb04..e4e610c 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -163,6 +163,7 @@ MODULE_PARM_DESC(radio_nr, "Radio device numbers");
  * @cap_ctrl:		capture control
  */
 struct fm801 {
+	struct device *dev;
 	int irq;
 
 	unsigned long port;
@@ -190,7 +191,6 @@ struct fm801 {
 	struct snd_ac97 *ac97;
 	struct snd_ac97 *ac97_sec;
 
-	struct pci_dev *pci;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_rawmidi *rmidi;
@@ -715,6 +715,7 @@ static struct snd_pcm_ops snd_fm801_capture_ops = {
 
 static int snd_fm801_pcm(struct fm801 *chip, int device)
 {
+	struct pci_dev *pdev = to_pci_dev(chip->dev);
 	struct snd_pcm *pcm;
 	int err;
 
@@ -730,7 +731,7 @@ static int snd_fm801_pcm(struct fm801 *chip, int device)
 	chip->pcm = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-					      snd_dma_pci_data(chip->pci),
+					      snd_dma_pci_data(pdev),
 					      chip->multichannel ? 128*1024 : 64*1024, 128*1024);
 
 	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
@@ -1182,7 +1183,7 @@ static int snd_fm801_free(struct fm801 *chip)
 	cmdw |= 0x00c3;
 	fm801_writew(chip, IRQ_MASK, cmdw);
 
-	devm_free_irq(&chip->pci->dev, chip->irq, chip);
+	devm_free_irq(chip->dev, chip->irq, chip);
 
       __end_hw:
 #ifdef CONFIG_SND_FM801_TEA575X_BOOL
@@ -1220,7 +1221,7 @@ static int snd_fm801_create(struct snd_card *card,
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
 	chip->card = card;
-	chip->pci = pci;
+	chip->dev = &pci->dev;
 	chip->irq = -1;
 	chip->tea575x_tuner = tea575x_tuner;
 	if ((err = pci_request_regions(pci, "FM801")) < 0)
-- 
2.6.4
