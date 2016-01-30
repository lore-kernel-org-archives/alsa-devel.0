From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 3/3] ALSA: mts64: use new parport device
	model
Date: Sat, 30 Jan 2016 15:48:25 +0530
Message-ID: <1454149105-17474-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1454149105-17474-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D01C12619D0
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2016 11:18:40 +0100 (CET)
Received: by mail-pf0-f193.google.com with SMTP id x125so5020612pfb.0
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2016 02:18:40 -0800 (PST)
In-Reply-To: <1454149105-17474-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Modify mts64 driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v2:
 1. pardev_cb is initialized while declaring, thus removing the use of
 memset.
 2. used pdev->id.
 3. v1 did not have the parport probe callback, but we will need the probe
 callback for binding as the name of the driver and the name of the device
 is different.
 4. in v1 I missed modifying snd_mts64_dev_probe().

 sound/drivers/mts64.c | 52 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index ee6a87f..01da990 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -851,10 +851,21 @@ static int snd_mts64_probe_port(struct parport *p)
 {
 	struct pardevice *pardev;
 	int res;
+	struct pardev_cb pdev_cb = {
+		.preempt = NULL,
+		.wakeup = NULL,
+		.private = NULL,
+		.irq_func = NULL,
+		.flags = 0,
+	};
 
-	pardev = parport_register_device(p, DRIVER_NAME,
-					 NULL, NULL, NULL,
-					 0, NULL);
+	/*
+	* Specify the device number as SNDRV_CARDS + 1 so that the
+	* device id alloted to this temporary device will never clash
+	* with an actual device already registered.
+	*/
+	pardev = parport_register_dev_model(p, DRIVER_NAME, &pdev_cb,
+					    SNDRV_CARDS + 1);
 	if (!pardev)
 		return -EIO;
 
@@ -904,10 +915,20 @@ static void snd_mts64_detach(struct parport *p)
 	/* nothing to do here */
 }
 
+static int snd_mts64_dev_probe(struct pardevice *pardev)
+{
+	if (strcmp(pardev->name, DRIVER_NAME))
+		return -ENODEV;
+
+	return 0;
+}
+
 static struct parport_driver mts64_parport_driver = {
-	.name   = "mts64",
-	.attach = snd_mts64_attach,
-	.detach = snd_mts64_detach
+	.name		= "mts64",
+	.probe		= snd_mts64_dev_probe,
+	.match_port	= snd_mts64_attach,
+	.detach		= snd_mts64_detach,
+	.devmodel	= true,
 };
 
 /*********************************************************************
@@ -935,6 +956,12 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	struct snd_card *card = NULL;
 	struct mts64 *mts = NULL;
 	int err;
+	struct pardev_cb mts64_cb = {
+		.preempt = NULL,
+		.wakeup = NULL,
+		.irq_func = snd_mts64_interrupt,	/* ISR */
+		.flags = PARPORT_DEV_EXCL,		/* flags */
+	};
 
 	p = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
@@ -959,13 +986,12 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	sprintf(card->longname,  "%s at 0x%lx, irq %i",
 		card->shortname, p->base, p->irq);
 
-	pardev = parport_register_device(p,                   /* port */
-					 DRIVER_NAME,         /* name */
-					 NULL,                /* preempt */
-					 NULL,                /* wakeup */
-					 snd_mts64_interrupt, /* ISR */
-					 PARPORT_DEV_EXCL,    /* flags */
-					 (void *)card);       /* private */
+	mts64_cb.private = card;			 /* private */
+
+	pardev = parport_register_dev_model(p,		 /* port */
+					    DRIVER_NAME, /* name */
+					    &mts64_cb,	 /* callbacks */
+					    pdev->id);	 /* device number */
 	if (pardev == NULL) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
-- 
1.9.1
