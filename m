From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3 3/3] portman2x4 - use new parport device model
Date: Thu,  4 Feb 2016 22:08:23 +0530
Message-ID: <1454603903-15967-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1454603903-15967-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454603903-15967-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Modify portman driver to use the new parallel port device model.
The advantage of using the device model is that the device gets binded
to the hardware, we get the feature of hotplug, we can bind/unbind
the driver at runtime.
The only change is in the way the driver gets registered with the
parallel port subsystem and so as a result there is no user visible
change or any chance of regression.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: changed commit message
v2:
 1. pardev_cb is initialized while declaring, thus removing the use of
memset.
 2. used pdev->id.
 3. v1 did not have the parport probe callback, but
we will need the probe callback for binding as the name of the driver
and the name of the device is different.
 4. in v1 I missed modifying snd_portman_probe_port().

 sound/drivers/portman2x4.c | 53 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 172685d..a22f56c 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -650,10 +650,21 @@ static int snd_portman_probe_port(struct parport *p)
 {
 	struct pardevice *pardev;
 	int res;
-
-	pardev = parport_register_device(p, DRIVER_NAME,
-					 NULL, NULL, NULL,
-					 0, NULL);
+	struct pardev_cb pdev_cb = {
+		.preempt = NULL,
+		.wakeup = NULL,
+		.private = NULL,
+		.irq_func = NULL,
+		.flags = 0,
+	};
+
+	/*
+	 * Specify the device number as SNDRV_CARDS + 1 so that the
+	 * device id alloted to this temporary device will never clash
+	 * with an actual device already registered.
+	 */
+	pardev = parport_register_dev_model(p, DRIVER_NAME, &pdev_cb,
+					    SNDRV_CARDS + 1);
 	if (!pardev)
 		return -EIO;
 
@@ -703,10 +714,20 @@ static void snd_portman_detach(struct parport *p)
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
@@ -734,6 +755,12 @@ static int snd_portman_probe(struct platform_device *pdev)
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
@@ -758,13 +785,11 @@ static int snd_portman_probe(struct platform_device *pdev)
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
-- 
1.9.1
