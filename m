From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 6/6] [ALSA] portman2x4 - use new parport device model
Date: Thu,  7 Jan 2016 12:45:51 +0530
Message-ID: <1452150951-1571-6-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Modify portman driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 5fcde7d..88b25ca 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -704,9 +704,10 @@ static void snd_portman_detach(struct parport *p)
 }
 
 static struct parport_driver portman_parport_driver = {
-	.name   = "portman2x4",
-	.attach = snd_portman_attach,
-	.detach = snd_portman_detach
+	.name		= "portman2x4",
+	.match_port	= snd_portman_attach,
+	.detach		= snd_portman_detach,
+	.devmodel	= true,
 };
 
 /*********************************************************************
@@ -734,6 +735,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 	struct snd_card *card = NULL;
 	struct portman *pm = NULL;
 	int err;
+	struct pardev_cb portman_cb;
 
 	p = platform_get_drvdata(pdev);
 	platform_set_drvdata(pdev, NULL);
@@ -758,13 +760,15 @@ static int snd_portman_probe(struct platform_device *pdev)
 	sprintf(card->longname,  "%s at 0x%lx, irq %i",
 		card->shortname, p->base, p->irq);
 
-	pardev = parport_register_device(p,                     /* port */
-					 DRIVER_NAME,           /* name */
-					 NULL,                  /* preempt */
-					 NULL,                  /* wakeup */
-					 snd_portman_interrupt, /* ISR */
-					 PARPORT_DEV_EXCL,      /* flags */
-					 (void *)card);         /* private */
+	memset(&portman_cb, 0, sizeof(portman_cb));
+	portman_cb.private = card;                      /* private */
+	portman_cb.irq_func = snd_portman_interrupt;    /* ISR */
+	portman_cb.flags = PARPORT_DEV_EXCL;            /* flags */
+
+	pardev = parport_register_dev_model(p,		   /* port */
+					    DRIVER_NAME,   /* name */
+					    &portman_cb,   /* callbacks */
+					    device_count); /* device number */
 	if (!pardev) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
-- 
1.9.1
