From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ALSA: mts64: fix NULL pointer dereference
Date: Mon, 29 Feb 2016 17:43:30 +0530
Message-ID: <1456748010-17038-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

While registering pardev, the irq_func was also registered. As a
result when we tried to probe for the card, an interrupt was generated
and in the ISR we tried to dereference private_data. But private_data
is still NULL as we have not yet done snd_mts64_create(). Lets probe
for the card after mts64 is created.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Fixes: 94a573500d48 ("ALSA: mts64: use new parport device model")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/drivers/mts64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index c76bd87..fd4d18d 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -964,11 +964,6 @@ static int snd_mts64_probe(struct platform_device *pdev)
 		err = -EIO;
 		goto free_pardev;
 	}
-	err = mts64_probe(p);
-	if (err) {
-		err = -EIO;
-		goto release_pardev;
-	}
 
 	if ((err = snd_mts64_create(card, pardev, &mts)) < 0) {
 		snd_printd("Cannot create main component\n");
@@ -976,6 +971,12 @@ static int snd_mts64_probe(struct platform_device *pdev)
 	}
 	card->private_data = mts;
 	card->private_free = snd_mts64_card_private_free;
+
+	err = mts64_probe(p);
+	if (err) {
+		err = -EIO;
+		goto __err;
+	}
 	
 	if ((err = snd_mts64_rawmidi_create(card)) < 0) {
 		snd_printd("Creating Rawmidi component failed\n");
-- 
1.9.1
