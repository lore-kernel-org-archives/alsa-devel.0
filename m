From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/5] ALSA: mts64: use new parport device model
Date: Thu,  7 Jan 2016 14:02:49 +0530
Message-ID: <1452155569-6763-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452155569-6763-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Modify mts64 driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/mts64.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index ee6a87f..4d393ea 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -905,9 +905,10 @@ static void snd_mts64_detach(struct parport *p)
 }
 
 static struct parport_driver mts64_parport_driver = {
-	.name   = "mts64",
-	.attach = snd_mts64_attach,
-	.detach = snd_mts64_detach
+	.name		= "mts64",
+	.match_port	= snd_mts64_attach,
+	.detach		= snd_mts64_detach,
+	.devmodel	= true,
 };
 
 /*********************************************************************
@@ -935,6 +936,7 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	struct snd_card *card = NULL;
 	struct mts64 *mts = NULL;
 	int err;
+	struct pardev_cb mts64_cb;
 
 	p = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
@@ -959,14 +961,16 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	sprintf(card->longname,  "%s at 0x%lx, irq %i",
 		card->shortname, p->base, p->irq);
 
-	pardev = parport_register_device(p,                   /* port */
-					 DRIVER_NAME,         /* name */
-					 NULL,                /* preempt */
-					 NULL,                /* wakeup */
-					 snd_mts64_interrupt, /* ISR */
-					 PARPORT_DEV_EXCL,    /* flags */
-					 (void *)card);       /* private */
-	if (pardev == NULL) {
+	memset(&mts64_cb, 0, sizeof(mts64_cb));
+	mts64_cb.private = card;			/* private */
+	mts64_cb.irq_func = snd_mts64_interrupt;	/* ISR */
+	mts64_cb.flags = PARPORT_DEV_EXCL;		/* flags */
+
+	pardev = parport_register_dev_model(p,		   /* port */
+					    DRIVER_NAME,   /* name */
+					    &mts64_cb,   /* callbacks */
+					    device_count); /* device number */
+	if (!pardev) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
 		goto __err;
-- 
1.9.1
