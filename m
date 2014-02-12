From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/24] [media] Convert to snd_card_new() with a
	device pointer
Date: Wed, 12 Feb 2014 11:35:36 +0100
Message-ID: <1392201340-27113-21-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 07251265044
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 96C3BAC95
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/media/pci/cx18/cx18-alsa-main.c   | 9 +++++----
 drivers/media/pci/cx23885/cx23885-alsa.c  | 5 ++---
 drivers/media/pci/cx25821/cx25821-alsa.c  | 7 +++----
 drivers/media/pci/cx88/cx88-alsa.c        | 6 ++----
 drivers/media/pci/ivtv/ivtv-alsa-main.c   | 9 +++++----
 drivers/media/pci/saa7134/saa7134-alsa.c  | 6 ++----
 drivers/media/usb/cx231xx/cx231xx-audio.c | 5 ++---
 drivers/media/usb/em28xx/em28xx-audio.c   | 5 ++---
 drivers/media/usb/stk1160/stk1160-ac97.c  | 6 ++----
 drivers/media/usb/tlg2300/pd-alsa.c       | 3 ++-
 drivers/media/usb/tm6000/tm6000-alsa.c    | 4 ++--
 11 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-alsa-main.c b/drivers/media/pci/cx18/cx18-alsa-main.c
index b2c8c3439fea..ea272bcb38df 100644
--- a/drivers/media/pci/cx18/cx18-alsa-main.c
+++ b/drivers/media/pci/cx18/cx18-alsa-main.c
@@ -145,11 +145,12 @@ static int snd_cx18_init(struct v4l2_device *v4l2_dev)
 	/* This is a no-op for us.  We'll use the cx->instance */
 
 	/* (2) Create a card instance */
-	ret = snd_card_create(SNDRV_DEFAULT_IDX1, /* use first available id */
-			      SNDRV_DEFAULT_STR1, /* xid from end of shortname*/
-			      THIS_MODULE, 0, &sc);
+	ret = snd_card_new(&cx->pci_dev->dev,
+			   SNDRV_DEFAULT_IDX1, /* use first available id */
+			   SNDRV_DEFAULT_STR1, /* xid from end of shortname*/
+			   THIS_MODULE, 0, &sc);
 	if (ret) {
-		CX18_ALSA_ERR("%s: snd_card_create() failed with err %d\n",
+		CX18_ALSA_ERR("%s: snd_card_new() failed with err %d\n",
 			      __func__, ret);
 		goto err_exit;
 	}
diff --git a/drivers/media/pci/cx23885/cx23885-alsa.c b/drivers/media/pci/cx23885/cx23885-alsa.c
index c6c9bd58f8be..554798dcedd0 100644
--- a/drivers/media/pci/cx23885/cx23885-alsa.c
+++ b/drivers/media/pci/cx23885/cx23885-alsa.c
@@ -489,7 +489,8 @@ struct cx23885_audio_dev *cx23885_audio_register(struct cx23885_dev *dev)
 		return NULL;
 	}
 
-	err = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+	err = snd_card_new(&dev->pci->dev,
+			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			THIS_MODULE, sizeof(struct cx23885_audio_dev), &card);
 	if (err < 0)
 		goto error;
@@ -500,8 +501,6 @@ struct cx23885_audio_dev *cx23885_audio_register(struct cx23885_dev *dev)
 	chip->card = card;
 	spin_lock_init(&chip->lock);
 
-	snd_card_set_dev(card, &dev->pci->dev);
-
 	err = snd_cx23885_pcm(chip, 0, "CX23885 Digital");
 	if (err < 0)
 		goto error;
diff --git a/drivers/media/pci/cx25821/cx25821-alsa.c b/drivers/media/pci/cx25821/cx25821-alsa.c
index b1e08c3e55cd..2dd5bcaa7e53 100644
--- a/drivers/media/pci/cx25821/cx25821-alsa.c
+++ b/drivers/media/pci/cx25821/cx25821-alsa.c
@@ -645,8 +645,9 @@ static int cx25821_audio_initdev(struct cx25821_dev *dev)
 		return -ENOENT;
 	}
 
-	err = snd_card_create(index[devno], id[devno], THIS_MODULE,
-			sizeof(struct cx25821_audio_dev), &card);
+	err = snd_card_new(&dev->pci->dev, index[devno], id[devno],
+			   THIS_MODULE,
+			   sizeof(struct cx25821_audio_dev), &card);
 	if (err < 0) {
 		pr_info("DEBUG ERROR: cannot create snd_card_new in %s\n",
 			__func__);
@@ -682,8 +683,6 @@ static int cx25821_audio_initdev(struct cx25821_dev *dev)
 		goto error;
 	}
 
-	snd_card_set_dev(card, &chip->pci->dev);
-
 	strcpy(card->shortname, "cx25821");
 	sprintf(card->longname, "%s at 0x%lx irq %d", chip->dev->name,
 		chip->iobase, chip->irq);
diff --git a/drivers/media/pci/cx88/cx88-alsa.c b/drivers/media/pci/cx88/cx88-alsa.c
index d014206e7176..a72579a9f67f 100644
--- a/drivers/media/pci/cx88/cx88-alsa.c
+++ b/drivers/media/pci/cx88/cx88-alsa.c
@@ -852,8 +852,6 @@ static int snd_cx88_create(struct snd_card *card, struct pci_dev *pci,
 	chip->irq = pci->irq;
 	synchronize_irq(chip->irq);
 
-	snd_card_set_dev(card, &pci->dev);
-
 	*rchip = chip;
 	*core_ptr = core;
 
@@ -876,8 +874,8 @@ static int cx88_audio_initdev(struct pci_dev *pci,
 		return (-ENOENT);
 	}
 
-	err = snd_card_create(index[devno], id[devno], THIS_MODULE,
-			      sizeof(snd_cx88_card_t), &card);
+	err = snd_card_new(&pci->dev, index[devno], id[devno], THIS_MODULE,
+			   sizeof(snd_cx88_card_t), &card);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/media/pci/ivtv/ivtv-alsa-main.c b/drivers/media/pci/ivtv/ivtv-alsa-main.c
index e970cface70e..39b52929755a 100644
--- a/drivers/media/pci/ivtv/ivtv-alsa-main.c
+++ b/drivers/media/pci/ivtv/ivtv-alsa-main.c
@@ -145,11 +145,12 @@ static int snd_ivtv_init(struct v4l2_device *v4l2_dev)
 	/* This is a no-op for us.  We'll use the itv->instance */
 
 	/* (2) Create a card instance */
-	ret = snd_card_create(SNDRV_DEFAULT_IDX1, /* use first available id */
-			      SNDRV_DEFAULT_STR1, /* xid from end of shortname*/
-			      THIS_MODULE, 0, &sc);
+	ret = snd_card_new(&itv->pdev->dev,
+			   SNDRV_DEFAULT_IDX1, /* use first available id */
+			   SNDRV_DEFAULT_STR1, /* xid from end of shortname*/
+			   THIS_MODULE, 0, &sc);
 	if (ret) {
-		IVTV_ALSA_ERR("%s: snd_card_create() failed with err %d\n",
+		IVTV_ALSA_ERR("%s: snd_card_new() failed with err %d\n",
 			      __func__, ret);
 		goto err_exit;
 	}
diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index dd67c8a400cc..e04a4d5d6672 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -1072,8 +1072,8 @@ static int alsa_card_saa7134_create(struct saa7134_dev *dev, int devnum)
 	if (!enable[devnum])
 		return -ENODEV;
 
-	err = snd_card_create(index[devnum], id[devnum], THIS_MODULE,
-			      sizeof(snd_card_saa7134_t), &card);
+	err = snd_card_new(&dev->pci->dev, index[devnum], id[devnum],
+			   THIS_MODULE, sizeof(snd_card_saa7134_t), &card);
 	if (err < 0)
 		return err;
 
@@ -1115,8 +1115,6 @@ static int alsa_card_saa7134_create(struct saa7134_dev *dev, int devnum)
 	if ((err = snd_card_saa7134_pcm(chip, 0)) < 0)
 		goto __nodev;
 
-	snd_card_set_dev(card, &chip->pci->dev);
-
 	/* End of "creation" */
 
 	strcpy(card->shortname, "SAA7134");
diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/cx231xx/cx231xx-audio.c
index 81a1d971d797..9b925874d392 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -665,8 +665,8 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	cx231xx_info("cx231xx-audio.c: probing for cx231xx "
 		     "non standard usbaudio\n");
 
-	err = snd_card_create(index[devnr], "Cx231xx Audio", THIS_MODULE,
-			      0, &card);
+	err = snd_card_new(&dev->udev->dev, index[devnr], "Cx231xx Audio",
+			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -682,7 +682,6 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	pcm->info_flags = 0;
 	pcm->private_data = dev;
 	strcpy(pcm->name, "Conexant cx231xx Capture");
-	snd_card_set_dev(card, &dev->udev->dev);
 	strcpy(card->driver, "Cx231xx-Audio");
 	strcpy(card->shortname, "Cx231xx Audio");
 	strcpy(card->longname, "Conexant cx231xx Audio");
diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index 05e9bd11a3ff..1a28897af183 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -900,8 +900,8 @@ static int em28xx_audio_init(struct em28xx *dev)
 	printk(KERN_INFO
 	       "em28xx-audio.c: Copyright (C) 2007-2014 Mauro Carvalho Chehab\n");
 
-	err = snd_card_create(index[devnr], "Em28xx Audio", THIS_MODULE, 0,
-			      &card);
+	err = snd_card_new(&dev->udev->dev, index[devnr], "Em28xx Audio",
+			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -918,7 +918,6 @@ static int em28xx_audio_init(struct em28xx *dev)
 	pcm->private_data = dev;
 	strcpy(pcm->name, "Empia 28xx Capture");
 
-	snd_card_set_dev(card, &dev->udev->dev);
 	strcpy(card->driver, "Em28xx-Audio");
 	strcpy(card->shortname, "Em28xx Audio");
 	strcpy(card->longname, "Empia Em28xx Audio");
diff --git a/drivers/media/usb/stk1160/stk1160-ac97.c b/drivers/media/usb/stk1160/stk1160-ac97.c
index c8583c262c3d..c46c8be89602 100644
--- a/drivers/media/usb/stk1160/stk1160-ac97.c
+++ b/drivers/media/usb/stk1160/stk1160-ac97.c
@@ -98,13 +98,11 @@ int stk1160_ac97_register(struct stk1160 *dev)
 	 * Just want a card to access ac96 controls,
 	 * the actual capture interface will be handled by snd-usb-audio
 	 */
-	rc = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			      THIS_MODULE, 0, &card);
+	rc = snd_card_new(dev->dev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			  THIS_MODULE, 0, &card);
 	if (rc < 0)
 		return rc;
 
-	snd_card_set_dev(card, dev->dev);
-
 	/* TODO: I'm not sure where should I get these names :-( */
 	snprintf(card->shortname, sizeof(card->shortname),
 		 "stk1160-mixer");
diff --git a/drivers/media/usb/tlg2300/pd-alsa.c b/drivers/media/usb/tlg2300/pd-alsa.c
index 3f3e141f70fb..dd8fe100590f 100644
--- a/drivers/media/usb/tlg2300/pd-alsa.c
+++ b/drivers/media/usb/tlg2300/pd-alsa.c
@@ -300,7 +300,8 @@ int poseidon_audio_init(struct poseidon *p)
 	struct snd_pcm *pcm;
 	int ret;
 
-	ret = snd_card_create(-1, "Telegent", THIS_MODULE, 0, &card);
+	ret = snd_card_new(&p->interface->dev, -1, "Telegent",
+			   THIS_MODULE, 0, &card);
 	if (ret != 0)
 		return ret;
 
diff --git a/drivers/media/usb/tm6000/tm6000-alsa.c b/drivers/media/usb/tm6000/tm6000-alsa.c
index 813c1ec53608..3239cd62e452 100644
--- a/drivers/media/usb/tm6000/tm6000-alsa.c
+++ b/drivers/media/usb/tm6000/tm6000-alsa.c
@@ -431,7 +431,8 @@ static int tm6000_audio_init(struct tm6000_core *dev)
 	if (!enable[devnr])
 		return -ENOENT;
 
-	rc = snd_card_create(index[devnr], "tm6000", THIS_MODULE, 0, &card);
+	rc = snd_card_new(&dev->udev->dev, index[devnr], "tm6000",
+			  THIS_MODULE, 0, &card);
 	if (rc < 0) {
 		snd_printk(KERN_ERR "cannot create card instance %d\n", devnr);
 		return rc;
@@ -445,7 +446,6 @@ static int tm6000_audio_init(struct tm6000_core *dev)
 		le16_to_cpu(dev->udev->descriptor.idVendor),
 		le16_to_cpu(dev->udev->descriptor.idProduct));
 	snd_component_add(card, component);
-	snd_card_set_dev(card, &dev->udev->dev);
 
 	chip = kzalloc(sizeof(struct snd_tm6000_card), GFP_KERNEL);
 	if (!chip) {
-- 
1.8.5.2
