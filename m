From: Kyle Chamberlin <kylechamberlin@project20million.org>
Subject: [PATCH] Sound: drivers: virmidi: fixed code style issues
Date: Fri, 28 Nov 2014 13:59:56 -0500
Message-ID: <1417201196-12392-1-git-send-email-KyleChamberlin@project20million.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kyle Chamberlin <KyleChamberlin@project20million.org>
List-Id: alsa-devel@alsa-project.org

Fixed some minor code style issues and also removed some
assignments inside of if conditionals.

Signed-off-by: Kyle Chamberlin <KyleChamberlin@project20million.org>
---
 sound/drivers/virmidi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index b17872429..0af88d9 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -99,30 +99,33 @@ static int snd_virmidi_probe(struct platform_device *devptr)
 
 	if (midi_devs[dev] > MAX_MIDI_DEVICES) {
 		snd_printk(KERN_WARNING
-			   "too much midi devices for virmidi %d: "
-			   "force to use %d\n", dev, MAX_MIDI_DEVICES);
+			   "too much midi devices for virmidi %d: force to use %d\n",
+			   dev, MAX_MIDI_DEVICES);
 		midi_devs[dev] = MAX_MIDI_DEVICES;
 	}
 	for (idx = 0; idx < midi_devs[dev]; idx++) {
 		struct snd_rawmidi *rmidi;
 		struct snd_virmidi_dev *rdev;
-		if ((err = snd_virmidi_new(card, idx, &rmidi)) < 0)
+
+		err = snd_virmidi_new(card, idx, &rmidi);
+		if (err < 0)
 			goto __nodev;
 		rdev = rmidi->private_data;
 		vmidi->midi[idx] = rmidi;
 		strcpy(rmidi->name, "Virtual Raw MIDI");
 		rdev->seq_mode = SNDRV_VIRMIDI_SEQ_DISPATCH;
 	}
-	
+
 	strcpy(card->driver, "VirMIDI");
 	strcpy(card->shortname, "VirMIDI");
 	sprintf(card->longname, "Virtual MIDI Card %i", dev + 1);
 
-	if ((err = snd_card_register(card)) == 0) {
+	err = snd_card_register(card);
+	if (err) {
 		platform_set_drvdata(devptr, card);
 		return 0;
 	}
-      __nodev:
+__nodev:
 	snd_card_free(card);
 	return err;
 }
@@ -157,13 +160,15 @@ static int __init alsa_card_virmidi_init(void)
 {
 	int i, cards, err;
 
-	if ((err = platform_driver_register(&snd_virmidi_driver)) < 0)
+	err = platform_driver_register(&snd_virmidi_driver);
+	if (err < 0)
 		return err;
 
 	cards = 0;
 	for (i = 0; i < SNDRV_CARDS; i++) {
 		struct platform_device *device;
-		if (! enable[i])
+
+		if (!enable[i])
 			continue;
 		device = platform_device_register_simple(SND_VIRMIDI_DRIVER,
 							 i, NULL, 0);
-- 
2.1.3
