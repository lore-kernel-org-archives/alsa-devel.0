From: Thomas Pfaff <tpfaff@gmx.net>
Subject: [PATCH] usb-audio: Check for possible chip NULL
 pointer before clearing probing flag
Date: Mon, 26 Sep 2011 15:43:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1109261529160.10952@lxtpfaff.pcs.ditec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id 47D85243F0
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:44:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, gregkh@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Before clearing the probing flag in the error exit path, check that the 
chip pointer is not NULL.

Signed-off-by: Thomas Pfaff <tpfaff@gmx.net>

---
diff -urp a/sound/usb/card.c b/sound/usb/card.c
--- a/sound/usb/card.c	2011-09-26 14:58:02.468672118 +0200
+++ b/sound/usb/card.c	2011-09-26 15:00:30.313110086 +0200
@@ -530,9 +530,11 @@ snd_usb_audio_probe(struct usb_device *d
 	return chip;
 
  __error:
-	if (chip && !chip->num_interfaces)
-		snd_card_free(chip->card);
-	chip->probing = 0;
+	if (chip) {
+		if (!chip->num_interfaces)
+			snd_card_free(chip->card);
+		chip->probing = 0;
+	}
 	mutex_unlock(&register_mutex);
  __err_val:
 	return NULL;
