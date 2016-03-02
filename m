From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ALSA: portman2x4: fix NULL pointer dereference
Date: Wed,  2 Mar 2016 17:10:30 +0530
Message-ID: <1456918830-2675-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

While registering pardev, the irq_func was also registered. As a result
when we tried to probe for the card, an interrupt was generated and in
the ISR we tried to dereference private_data. But private_data is still
NULL as we have not yet done portman_create(). Lets probe for the device
after card is created.

Fixes: e6a1b7e88046 ("ALSA: portman2x4 - use new parport device model")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/drivers/portman2x4.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 362533f..189e3e7 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -762,11 +762,6 @@ static int snd_portman_probe(struct platform_device *pdev)
 		err = -EIO;
 		goto free_pardev;
 	}
-	err = portman_probe(p);
-	if (err) {
-		err = -EIO;
-		goto release_pardev;
-	}
 
 	if ((err = portman_create(card, pardev, &pm)) < 0) {
 		snd_printd("Cannot create main component\n");
@@ -774,6 +769,12 @@ static int snd_portman_probe(struct platform_device *pdev)
 	}
 	card->private_data = pm;
 	card->private_free = snd_portman_card_private_free;
+
+	err = portman_probe(p);
+	if (err) {
+		err = -EIO;
+		goto __err;
+	}
 	
 	if ((err = snd_portman_rawmidi_create(card)) < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
-- 
1.9.1
