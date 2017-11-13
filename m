From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: cs4281: Use common error handling
 code in snd_cs4281_create()
Date: Mon, 13 Nov 2017 13:53:52 +0100
Message-ID: <c6e82722-df16-6781-be3f-eba6e9e0fd08@users.sourceforge.net>
References: <ac9d010b-7a26-1f2d-5034-15abe603c6fd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 119C4266D86
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 13:54:33 +0100 (CET)
In-Reply-To: <ac9d010b-7a26-1f2d-5034-15abe603c6fd@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 13:34:57 +0100

* Add jump targets so that a bit of exception handling can be better reused
  at the end of this function.

* Delete the local variable "tmp" which was unnecessary
  because the variable "err" could be used at this place again.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/cs4281.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ed6b97dbd1cc..6cd7300a0182 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1347,7 +1347,6 @@ static int snd_cs4281_create(struct snd_card *card,
 			     int dual_codec)
 {
 	struct cs4281 *chip;
-	unsigned int tmp;
 	int err;
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_cs4281_dev_free,
@@ -1359,8 +1358,8 @@ static int snd_cs4281_create(struct snd_card *card,
 		return err;
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&chip->reg_lock);
 	chip->card = card;
@@ -1376,43 +1375,45 @@ static int snd_cs4281_create(struct snd_card *card,
 	err = pci_request_regions(pci, "CS4281");
 	if (err < 0) {
 		kfree(chip);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 	chip->ba0_addr = pci_resource_start(pci, 0);
 	chip->ba1_addr = pci_resource_start(pci, 1);
 
 	chip->ba0 = pci_ioremap_bar(pci, 0);
 	chip->ba1 = pci_ioremap_bar(pci, 1);
-	if (!chip->ba0 || !chip->ba1) {
-		snd_cs4281_free(chip);
-		return -ENOMEM;
-	}
+	if (!chip->ba0 || !chip->ba1)
+		goto e_nomem;
 	
 	if (request_irq(pci->irq, snd_cs4281_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_cs4281_free(chip);
-		return -ENOMEM;
+		goto e_nomem;
 	}
 	chip->irq = pci->irq;
 
-	tmp = snd_cs4281_chip_init(chip);
-	if (tmp) {
-		snd_cs4281_free(chip);
-		return tmp;
-	}
+	err = snd_cs4281_chip_init(chip);
+	if (err)
+		goto free_sound_chip;
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
-	if (err < 0) {
-		snd_cs4281_free(chip);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	snd_cs4281_proc_init(chip);
 
 	*rchip = chip;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_nomem:
+	err = -ENOMEM;
+free_sound_chip:
+	snd_cs4281_free(chip);
+	return err;
 }
 
 static int snd_cs4281_chip_init(struct cs4281 *chip)
-- 
2.15.0
