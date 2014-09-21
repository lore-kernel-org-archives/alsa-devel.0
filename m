From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ALSA: snd-usb-caiaq: Fix LED commands for Kore
	controller
Date: Sun, 21 Sep 2014 23:55:38 +0200
Message-ID: <1411336538-17923-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id B54BA2625DB
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 23:55:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: brad.wilson.00@gmail.com, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

KoreController and KoreController2 need an EP1_CMD_DIMM_LEDS command to set
their LEDs, not EP1_CMD_WRITE_IO.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-and-tested-by: Brad Wilson <brad.wilson.00@gmail.com>
---
This bug is acutally ancient, but given that nobody actually noticed it
for so long makes me believe it's not worth flagging the patch for
stable@. Still, it would be good to have it for 3.17.

Thanks,
Daniel

 sound/usb/caiaq/control.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
index f65fc09..b7a7c80 100644
--- a/sound/usb/caiaq/control.c
+++ b/sound/usb/caiaq/control.c
@@ -100,15 +100,19 @@ static int control_put(struct snd_kcontrol *kcontrol,
 	struct snd_usb_caiaqdev *cdev = caiaqdev(chip->card);
 	int pos = kcontrol->private_value;
 	int v = ucontrol->value.integer.value[0];
-	unsigned char cmd = EP1_CMD_WRITE_IO;
+	unsigned char cmd;
 
-	if (cdev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1))
-		cmd = EP1_CMD_DIMM_LEDS;
-
-	if (cdev->chip.usb_id ==
-		USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER))
+	switch (cdev->chip.usb_id) {
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_MASCHINECONTROLLER):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
+	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
 		cmd = EP1_CMD_DIMM_LEDS;
+		break;
+	default:
+		cmd = EP1_CMD_WRITE_IO;
+		break;
+	}
 
 	if (pos & CNT_INTVAL) {
 		int i = pos & ~CNT_INTVAL;
-- 
2.1.0
