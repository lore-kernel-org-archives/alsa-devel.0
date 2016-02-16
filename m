From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4] portman2x4 - use new parport device model
Date: Tue, 16 Feb 2016 23:03:31 +0530
Message-ID: <1455644011-1148-1-git-send-email-sudipm.mukherjee@gmail.com>
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

v4: temporary device to probe is removed.
v3: changed commit message
v2:
 1. pardev_cb is initialized while declaring, thus removing the use of
memset.
 2. used pdev->id.
 3. v1 did not have the parport probe callback, but
we will need the probe callback for binding as the name of the driver
and the name of the device is different.
 4. in v1 I missed modifying snd_portman_probe_port().

 sound/drivers/portman2x4.c | 79 +++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 464385a..0741a3b 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -648,30 +648,6 @@ static void snd_portman_interrupt(void *userdata)
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
@@ -705,10 +681,20 @@ static void snd_portman_detach(struct parport *p)
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
@@ -736,6 +722,12 @@ static int snd_portman_probe(struct platform_device *pdev)
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
@@ -745,9 +737,6 @@ static int snd_portman_probe(struct platform_device *pdev)
 	if (!enable[dev]) 
 		return -ENOENT;
 
-	if ((err = snd_portman_probe_port(p)) < 0)
-		return err;
-
 	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
 			   0, &card);
 	if (err < 0) {
@@ -759,23 +748,33 @@ static int snd_portman_probe(struct platform_device *pdev)
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
 
+	if (parport_claim(pardev)) {
+		err = -EIO;
+		goto free_pardev;
+	}
+
+	err = portman_probe(p);
+	parport_release(pardev);
+
+	if (err) {
+		err = -EIO;
+		goto free_pardev;
+	}
+
 	if ((err = portman_create(card, pardev, &pm)) < 0) {
 		snd_printd("Cannot create main component\n");
-		parport_unregister_device(pardev);
-		goto __err;
+		goto free_pardev;
 	}
 	card->private_data = pm;
 	card->private_free = snd_portman_card_private_free;
@@ -808,6 +807,8 @@ static int snd_portman_probe(struct platform_device *pdev)
 	snd_printk(KERN_INFO "Portman 2x4 on 0x%lx\n", p->base);
 	return 0;
 
+free_pardev:
+	parport_unregister_device(pardev);
 __err:
 	snd_card_free(card);
 	return err;
-- 
1.9.1
