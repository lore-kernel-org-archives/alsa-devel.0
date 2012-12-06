From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 09/20] ALSA: ad1889: remove __dev* attributes
Date: Thu,  6 Dec 2012 12:35:18 -0500
Message-ID: <1354815329-20221-10-git-send-email-wfp5p@virginia.edu>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-parisc-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz, gregkh@linuxfoundation.org, Thibaut Varene <T-Bone@parisc-linux.org>, linux-parisc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
and __devexit.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Thibaut Varene <T-Bone@parisc-linux.org>
Cc: linux-parisc@vger.kernel.org
---
 sound/pci/ad1889.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index e672ff4..ad8a311 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -624,7 +624,7 @@ snd_ad1889_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit
+static int
 snd_ad1889_pcm_init(struct snd_ad1889 *chip, int device, struct snd_pcm **rpcm)
 {
 	int err;
@@ -747,7 +747,7 @@ snd_ad1889_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffe
 	snd_iprintf(buffer, "Resampler samplerate: %u Hz\n", reg);
 }
 
-static void __devinit
+static void
 snd_ad1889_proc_init(struct snd_ad1889 *chip)
 {
 	struct snd_info_entry *entry;
@@ -767,7 +767,7 @@ static struct ac97_quirk ac97_quirks[] = {
 	{ } /* terminator */
 };
 
-static void __devinit
+static void
 snd_ad1889_ac97_xinit(struct snd_ad1889 *chip)
 {
 	u16 reg;
@@ -805,7 +805,7 @@ snd_ad1889_ac97_free(struct snd_ac97 *ac97)
 	chip->ac97 = NULL;
 }
 
-static int __devinit
+static int
 snd_ad1889_ac97_init(struct snd_ad1889 *chip, const char *quirk_override)
 {
 	int err;
@@ -878,7 +878,7 @@ snd_ad1889_dev_free(struct snd_device *device)
 	return snd_ad1889_free(chip);
 }
 
-static int __devinit
+static int
 snd_ad1889_init(struct snd_ad1889 *chip) 
 {
 	ad1889_writew(chip, AD_DS_CCS, AD_DS_CCS_CLKEN); /* turn on clock */
@@ -892,7 +892,7 @@ snd_ad1889_init(struct snd_ad1889 *chip)
 	return 0;
 }
 
-static int __devinit
+static int
 snd_ad1889_create(struct snd_card *card,
 		  struct pci_dev *pci,
 		  struct snd_ad1889 **rchip)
@@ -978,7 +978,7 @@ free_and_ret:
 	return err;
 }
 
-static int __devinit
+static int
 snd_ad1889_probe(struct pci_dev *pci,
 		 const struct pci_device_id *pci_id)
 {
@@ -1042,7 +1042,7 @@ free_and_ret:
 	return err;
 }
 
-static void __devexit
+static void
 snd_ad1889_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
@@ -1059,7 +1059,7 @@ static struct pci_driver ad1889_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ad1889_ids,
 	.probe = snd_ad1889_probe,
-	.remove = __devexit_p(snd_ad1889_remove),
+	.remove = snd_ad1889_remove,
 };
 
 module_pci_driver(ad1889_pci_driver);
-- 
1.8.0.1

