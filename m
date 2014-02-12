From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/24] ALSA: drivers: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:19 +0100
Message-ID: <1392201340-27113-4-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF2E6264F34
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 7C0CFABB2
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
 sound/drivers/aloop.c         |  4 ++--
 sound/drivers/dummy.c         |  6 ++----
 sound/drivers/ml403-ac97cr.c  |  5 ++---
 sound/drivers/mpu401/mpu401.c | 12 ++++++------
 sound/drivers/mtpav.c         |  4 ++--
 sound/drivers/mts64.c         |  5 ++---
 sound/drivers/pcsp/pcsp.c     |  4 +---
 sound/drivers/portman2x4.c    |  5 ++---
 sound/drivers/serial-u16550.c |  5 ++---
 sound/drivers/virmidi.c       |  6 ++----
 10 files changed, 23 insertions(+), 33 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index f7589923effa..2a16c86a60b3 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1142,8 +1142,8 @@ static int loopback_probe(struct platform_device *devptr)
 	int dev = devptr->id;
 	int err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct loopback), &card);
+	err = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct loopback), &card);
 	if (err < 0)
 		return err;
 	loopback = card->private_data;
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 915b4d7fbb23..fab90bd2bd51 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1054,8 +1054,8 @@ static int snd_dummy_probe(struct platform_device *devptr)
 	int idx, err;
 	int dev = devptr->id;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_dummy), &card);
+	err = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_dummy), &card);
 	if (err < 0)
 		return err;
 	dummy = card->private_data;
@@ -1114,8 +1114,6 @@ static int snd_dummy_probe(struct platform_device *devptr)
 
 	dummy_proc_init(dummy);
 
-	snd_card_set_dev(card, &devptr->dev);
-
 	err = snd_card_register(card);
 	if (err == 0) {
 		platform_set_drvdata(devptr, card);
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 95ea4a153ea4..33ed76530d0b 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1280,7 +1280,8 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 	if (!enable[dev])
 		return -ENOENT;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pfdev->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	err = snd_ml403_ac97cr_create(card, pfdev, &ml403_ac97cr);
@@ -1310,8 +1311,6 @@ static int snd_ml403_ac97cr_probe(struct platform_device *pfdev)
 		(unsigned long)ml403_ac97cr->port, ml403_ac97cr->irq,
 		ml403_ac97cr->capture_irq, dev + 1);
 
-	snd_card_set_dev(card, &pfdev->dev);
-
 	err = snd_card_register(card);
 	if (err < 0) {
 		snd_card_free(card);
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index 90a3a7b38a2a..83014b83a44e 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -64,7 +64,8 @@ static struct platform_device *platform_devices[SNDRV_CARDS];
 static int pnp_registered;
 static unsigned int snd_mpu401_devices;
 
-static int snd_mpu401_create(int dev, struct snd_card **rcard)
+static int snd_mpu401_create(struct device *devptr, int dev,
+			     struct snd_card **rcard)
 {
 	struct snd_card *card;
 	int err;
@@ -73,7 +74,8 @@ static int snd_mpu401_create(int dev, struct snd_card **rcard)
 		snd_printk(KERN_ERR "the uart_enter option is obsolete; remove it\n");
 
 	*rcard = NULL;
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(devptr, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0)
 		return err;
 	strcpy(card->driver, "MPU-401 UART");
@@ -114,10 +116,9 @@ static int snd_mpu401_probe(struct platform_device *devptr)
 		snd_printk(KERN_ERR "specify or disable IRQ\n");
 		return -EINVAL;
 	}
-	err = snd_mpu401_create(dev, &card);
+	err = snd_mpu401_create(&devptr->dev, dev, &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &devptr->dev);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -194,14 +195,13 @@ static int snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 		err = snd_mpu401_pnp(dev, pnp_dev, id);
 		if (err < 0)
 			return err;
-		err = snd_mpu401_create(dev, &card);
+		err = snd_mpu401_create(&pnp_dev->dev, dev, &card);
 		if (err < 0)
 			return err;
 		if ((err = snd_card_register(card)) < 0) {
 			snd_card_free(card);
 			return err;
 		}
-		snd_card_set_dev(card, &pnp_dev->dev);
 		pnp_set_drvdata(pnp_dev, card);
 		snd_mpu401_devices++;
 		++dev;
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index e5ec7eb27dec..4b66c7f22af7 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -697,7 +697,8 @@ static int snd_mtpav_probe(struct platform_device *dev)
 	int err;
 	struct mtpav *mtp_card;
 
-	err = snd_card_create(index, id, THIS_MODULE, sizeof(*mtp_card), &card);
+	err = snd_card_new(&dev->dev, index, id, THIS_MODULE,
+			   sizeof(*mtp_card), &card);
 	if (err < 0)
 		return err;
 
@@ -732,7 +733,6 @@ static int snd_mtpav_probe(struct platform_device *dev)
 
 	snd_mtpav_portscan(mtp_card);
 
-	snd_card_set_dev(card, &dev->dev);
 	err = snd_card_register(mtp_card->card);
 	if (err < 0)
 		goto __error;
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 4e0dd22ba08e..f5fd448dbc57 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -959,7 +959,8 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	if ((err = snd_mts64_probe_port(p)) < 0)
 		return err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printd("Cannot create card\n");
 		return err;
@@ -1009,8 +1010,6 @@ static int snd_mts64_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, card);
 
-	snd_card_set_dev(card, &pdev->dev);
-
 	/* At this point card will be usable */
 	if ((err = snd_card_register(card)) < 0) {
 		snd_printd("Cannot register card\n");
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index 328bd29264ce..36808cdab06f 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -105,7 +105,7 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 	hrtimer_init(&pcsp_chip.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	pcsp_chip.timer.function = pcsp_do_timer;
 
-	err = snd_card_create(index, id, THIS_MODULE, 0, &card);
+	err = snd_card_new(dev, index, id, THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
@@ -127,8 +127,6 @@ static int snd_card_pcsp_probe(int devnum, struct device *dev)
 		return err;
 	}
 
-	snd_card_set_dev(pcsp_chip.card, dev);
-
 	strcpy(card->driver, "PC-Speaker");
 	strcpy(card->shortname, "pcsp");
 	sprintf(card->longname, "Internal PC-Speaker at port 0x%x",
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 991018df7131..78ccfa455527 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -748,7 +748,8 @@ static int snd_portman_probe(struct platform_device *pdev)
 	if ((err = snd_portman_probe_port(p)) < 0)
 		return err;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
+			   0, &card);
 	if (err < 0) {
 		snd_printd("Cannot create card\n");
 		return err;
@@ -798,8 +799,6 @@ static int snd_portman_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, card);
 
-	snd_card_set_dev(card, &pdev->dev);
-
 	/* At this point card will be usable */
 	if ((err = snd_card_register(card)) < 0) {
 		snd_printd("Cannot register card\n");
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index e0bf5e77b43a..9ad4414fa25c 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -942,7 +942,8 @@ static int snd_serial_probe(struct platform_device *devptr)
 		return -ENODEV;
 	}
 
-	err  = snd_card_create(index[dev], id[dev], THIS_MODULE, 0, &card);
+	err  = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+			    0, &card);
 	if (err < 0)
 		return err;
 
@@ -969,8 +970,6 @@ static int snd_serial_probe(struct platform_device *devptr)
 		uart->base,
 		uart->irq);
 
-	snd_card_set_dev(card, &devptr->dev);
-
 	if ((err = snd_card_register(card)) < 0)
 		goto _err;
 
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index ace3879e8d96..b178724295f3 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -90,8 +90,8 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 	int idx, err;
 	int dev = devptr->id;
 
-	err = snd_card_create(index[dev], id[dev], THIS_MODULE,
-			      sizeof(struct snd_card_virmidi), &card);
+	err = snd_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
+			   sizeof(struct snd_card_virmidi), &card);
 	if (err < 0)
 		return err;
 	vmidi = card->private_data;
@@ -118,8 +118,6 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 	strcpy(card->shortname, "VirMIDI");
 	sprintf(card->longname, "Virtual MIDI Card %i", dev + 1);
 
-	snd_card_set_dev(card, &devptr->dev);
-
 	if ((err = snd_card_register(card)) == 0) {
 		platform_set_drvdata(devptr, card);
 		return 0;
-- 
1.8.5.2
