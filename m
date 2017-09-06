From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: 6Fire: Use common error handling code in
 usb6fire_chip_probe()
Date: Wed, 6 Sep 2017 16:38:25 +0200
Message-ID: <6b3e5ec7-557c-4330-4fa4-221530d6c811@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 97532266B60
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 16:38:37 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Torsten Schenk <torsten.schenk@zoho.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 16:26:29 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/usb/6fire/chip.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index bc2a24f7a791..c7641cb50616 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -143,37 +143,32 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 	chip->card = card;
 
 	ret = usb6fire_comm_init(chip);
-	if (ret < 0) {
-		usb6fire_chip_destroy(chip);
-		return ret;
-	}
+	if (ret < 0)
+		goto destroy_chip;
 
 	ret = usb6fire_midi_init(chip);
-	if (ret < 0) {
-		usb6fire_chip_destroy(chip);
-		return ret;
-	}
+	if (ret < 0)
+		goto destroy_chip;
 
 	ret = usb6fire_pcm_init(chip);
-	if (ret < 0) {
-		usb6fire_chip_destroy(chip);
-		return ret;
-	}
+	if (ret < 0)
+		goto destroy_chip;
 
 	ret = usb6fire_control_init(chip);
-	if (ret < 0) {
-		usb6fire_chip_destroy(chip);
-		return ret;
-	}
+	if (ret < 0)
+		goto destroy_chip;
 
 	ret = snd_card_register(card);
 	if (ret < 0) {
 		dev_err(&intf->dev, "cannot register card.");
-		usb6fire_chip_destroy(chip);
-		return ret;
+		goto destroy_chip;
 	}
 	usb_set_intfdata(intf, chip);
 	return 0;
+
+destroy_chip:
+	usb6fire_chip_destroy(chip);
+	return ret;
 }
 
 static void usb6fire_chip_disconnect(struct usb_interface *intf)
-- 
2.14.1
