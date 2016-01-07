From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/6] [ALSA] portman2x4 - assignment in if
Date: Thu,  7 Jan 2016 12:45:50 +0530
Message-ID: <1452150951-1571-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

It is not general practice to assign some values inside if statement.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 985cf67..5fcde7d 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -743,7 +743,8 @@ static int snd_portman_probe(struct platform_device *pdev)
 	if (!enable[dev])
 		return -ENOENT;
 
-	if ((err = snd_portman_probe_port(p)) < 0)
+	err = snd_portman_probe_port(p);
+	if (err < 0)
 		return err;
 
 	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
@@ -770,7 +771,8 @@ static int snd_portman_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
-	if ((err = portman_create(card, pardev, &pm)) < 0) {
+	err = portman_create(card, pardev, &pm);
+	if (err < 0) {
 		snd_printd("Cannot create main component\n");
 		parport_unregister_device(pardev);
 		goto __err;
@@ -778,7 +780,8 @@ static int snd_portman_probe(struct platform_device *pdev)
 	card->private_data = pm;
 	card->private_free = snd_portman_card_private_free;
 
-	if ((err = snd_portman_rawmidi_create(card)) < 0) {
+	err = snd_portman_rawmidi_create(card);
+	if (err < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
 		goto __err;
 	}
@@ -792,13 +795,15 @@ static int snd_portman_probe(struct platform_device *pdev)
 	pm->pardev_claimed = 1;
 
 	/* init device */
-	if ((err = portman_device_init(pm)) < 0)
+	err = portman_device_init(pm);
+	if (err < 0)
 		goto __err;
 
 	platform_set_drvdata(pdev, card);
 
 	/* At this point card will be usable */
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_printd("Cannot register card\n");
 		goto __err;
 	}
@@ -850,7 +855,8 @@ static int __init snd_portman_module_init(void)
 {
 	int err;
 
-	if ((err = platform_driver_register(&snd_portman_driver)) < 0)
+	err = platform_driver_register(&snd_portman_driver);
+	if (err < 0)
 		return err;
 
 	if (parport_register_driver(&portman_parport_driver) != 0) {
-- 
1.9.1
