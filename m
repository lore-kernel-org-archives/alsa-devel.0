From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3 2/3] ALSA: mts64: assignment in if
Date: Thu,  4 Feb 2016 22:16:33 +0530
Message-ID: <1454604394-16055-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1454604394-16055-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454604394-16055-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

It is not general practice to assign some values inside if statement.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

v3: no change
v2: no change

 sound/drivers/mts64.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index f7d938d..ee6a87f 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -943,7 +943,9 @@ static int snd_mts64_probe(struct platform_device *pdev)
 		return -ENODEV;
 	if (!enable[dev])
 		return -ENOENT;
-	if ((err = snd_mts64_probe_port(p)) < 0)
+
+	err = snd_mts64_probe_port(p);
+	if (err < 0)
 		return err;
 
 	err = snd_card_new(&pdev->dev, index[dev], id[dev], THIS_MODULE,
@@ -970,7 +972,8 @@ static int snd_mts64_probe(struct platform_device *pdev)
 		goto __err;
 	}
 
-	if ((err = snd_mts64_create(card, pardev, &mts)) < 0) {
+	err = snd_mts64_create(card, pardev, &mts);
+	if (err < 0) {
 		snd_printd("Cannot create main component\n");
 		parport_unregister_device(pardev);
 		goto __err;
@@ -978,7 +981,8 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	card->private_data = mts;
 	card->private_free = snd_mts64_card_private_free;
 
-	if ((err = snd_mts64_rawmidi_create(card)) < 0) {
+	err = snd_mts64_rawmidi_create(card);
+	if (err < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
 		goto __err;
 	}
@@ -992,13 +996,15 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	mts->pardev_claimed = 1;
 
 	/* init device */
-	if ((err = mts64_device_init(p)) < 0)
+	err = mts64_device_init(p);
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
@@ -1050,7 +1056,8 @@ static int __init snd_mts64_module_init(void)
 {
 	int err;
 
-	if ((err = platform_driver_register(&snd_mts64_driver)) < 0)
+	err = platform_driver_register(&snd_mts64_driver);
+	if (err < 0)
 		return err;
 
 	if (parport_register_driver(&mts64_parport_driver) != 0) {
-- 
1.9.1
