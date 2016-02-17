From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v5] portman2x4 - use new parport device model
Date: Wed, 17 Feb 2016 18:26:27 +0530
Message-ID: <1455713787-13382-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Modify portman driver to use the new parallel port device model.
The advantage of using the device model is that the device gets binded
to the hardware, we get the feature of hotplug, we can bind/unbind
the driver at runtime.
The changes are in the way the driver gets registered with the
parallel port subsystem and the temporary device to probe portman card
is removed and portman_probe() is used in the probe callback.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v5: claimed flag and one call to parport_claim() removed.
v4: temporary device to probe is removed.
v3: changed commit message
v2:
 1. pardev_cb is initialized while declaring, thus removing the use of
 memset.
 2. used pdev->id.
 3. v1 did not have the parport probe callback, but we will need the
 probe callback for binding as the name of the driver and the name of
 the device is different.
 4. in v1 I missed modifying snd_portman_probe_port().

 sound/drivers/portman2x4.c | 93 +++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 464385a..362533f 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -83,8 +83,6 @@ struct portman {
 	struct snd_card *card;
 	struct snd_rawmidi *rmidi;
 	struct pardevice *pardev;
-	int pardev_claimed;
-
 	int open_count;
 	int mode[PORTMAN_NUM_INPUT_PORTS];
 	struct snd_rawmidi_substream *midi_input[PORTMAN_NUM_INPUT_PORTS];
@@ -648,30 +646,6 @@ static void snd_portman_interrupt(void *userdata)
 	spin_unlock(&pm->reg_lock);
 }
 
-static int snd_portman_probe_port(struct parport *p)
-{
-	struct pardevice *pardev;
-	int res;
-
-	pardev = parport_register_device(p, DRIVER_NAME,
-					 NULL, NULL, NULL,
-					 0, NULL);
-	if (!pardev)
-		return -EIO;
-	
-	if (parport_claim(pardev)) {
-		parport_unregister_device(pardev);
-		return -EIO;
-	}
-
-	res = portman_probe(p);
-
-	parport_release(pardev);
-	parport_unregister_device(pardev);
-
-	return res ? -EIO : 0;
-}
-
 static void snd_portman_attach(struct parport *p)
 {
 	struct platform_device *device;
@@ -705,10 +679,20 @@ static void snd_portman_detach(struct parport *p)
 	/* nothing to do here */
 }
 
+static int snd_portman_dev_probe(struct pardevice *pardev)
+{
+	if (strcmp(pardev->name, DRIVER_NAME))
+		return -ENODEV;
+
+	return 0;
+}
+
 static struct parport_driver portman_parport_driver = {
-	.name   = "portman2x4",
-	.attach = snd_portman_attach,
-	.detach = snd_portman_detach
+	.name		= "portman2x4",
+	.probe		= snd_portman_dev_probe,
+	.match_port	= snd_portman_attach,
+	.detach		= snd_portman_detach,
+	.devmodel	= true,
 };
 
 /*********************************************************************
@@ -720,8 +704,7 @@ static void snd_portman_card_private_free(struct snd_card *card)
 	struct pardevice *pardev = pm->pardev;
 
 	if (pardev) {
-		if (pm->pardev_claimed)
-			parport_release(pardev);
+		parport_release(pardev);
 		parport_unregister_device(pardev);
 	}
 
@@ -736,6 +719,12 @@ static int snd_portman_probe(struct platform_device *pdev)
 	struct snd_card *card = NULL;
 	struct portman *pm = NULL;
 	int err;
+	struct pardev_cb portman_cb = {
+		.preempt = NULL,
+		.wakeup = NULL,
+		.irq_func = snd_portman_interrupt,	/* ISR */
+		.flags = PARPORT_DEV_EXCL,		/* flags */
+	};
 
 	p = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
@@ -745,9 +734,6 @@ static int snd_portman_probe(struct platform_device *pdev)
 	if (!enable[dev]) 
 		return -ENOENT;
 
-	if ((err = snd_portman_probe_port(p)) < 0)
-		return err;
-
 	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
 			   0, &card);
 	if (err < 0) {
@@ -759,23 +745,32 @@ static int snd_portman_probe(struct platform_device *pdev)
 	sprintf(card->longname,  "%s at 0x%lx, irq %i", 
 		card->shortname, p->base, p->irq);
 
-	pardev = parport_register_device(p,                     /* port */
-					 DRIVER_NAME,           /* name */
-					 NULL,                  /* preempt */
-					 NULL,                  /* wakeup */
-					 snd_portman_interrupt, /* ISR */
-					 PARPORT_DEV_EXCL,      /* flags */
-					 (void *)card);         /* private */
+	portman_cb.private = card;			   /* private */
+	pardev = parport_register_dev_model(p,		   /* port */
+					    DRIVER_NAME,   /* name */
+					    &portman_cb,   /* callbacks */
+					    pdev->id);	   /* device number */
 	if (pardev == NULL) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
 		goto __err;
 	}
 
+	/* claim parport */
+	if (parport_claim(pardev)) {
+		snd_printd("Cannot claim parport 0x%lx\n", pardev->port->base);
+		err = -EIO;
+		goto free_pardev;
+	}
+	err = portman_probe(p);
+	if (err) {
+		err = -EIO;
+		goto release_pardev;
+	}
+
 	if ((err = portman_create(card, pardev, &pm)) < 0) {
 		snd_printd("Cannot create main component\n");
-		parport_unregister_device(pardev);
-		goto __err;
+		goto release_pardev;
 	}
 	card->private_data = pm;
 	card->private_free = snd_portman_card_private_free;
@@ -785,14 +780,6 @@ static int snd_portman_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
-	/* claim parport */
-	if (parport_claim(pardev)) {
-		snd_printd("Cannot claim parport 0x%lx\n", pardev->port->base);
-		err = -EIO;
-		goto __err;
-	}
-	pm->pardev_claimed = 1;
-
 	/* init device */
 	if ((err = portman_device_init(pm)) < 0)
 		goto __err;
@@ -808,6 +795,10 @@ static int snd_portman_probe(struct platform_device *pdev)
 	snd_printk(KERN_INFO "Portman 2x4 on 0x%lx\n", p->base);
 	return 0;
 
+release_pardev:
+	parport_release(pardev);
+free_pardev:
+	parport_unregister_device(pardev);
 __err:
 	snd_card_free(card);
 	return err;
-- 
1.9.1
