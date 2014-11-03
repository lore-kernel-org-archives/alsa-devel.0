From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: usb-audio: Use strim() instead of
	open code
Date: Mon,  3 Nov 2014 14:02:06 +0100
Message-ID: <1415019726-25710-4-git-send-email-tiwai@suse.de>
References: <1415019726-25710-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9869F26049A
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 14:02:08 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6A67CACEE
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:02:08 +0000 (UTC)
In-Reply-To: <1415019726-25710-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index fa6c0972aa23..69725d5fa2d6 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -321,16 +321,6 @@ static int snd_usb_audio_dev_free(struct snd_device *device)
 	return snd_usb_audio_free(chip);
 }
 
-static void remove_trailing_spaces(char *str)
-{
-	char *p;
-
-	if (!*str)
-		return;
-	for (p = str + strlen(str) - 1; p >= str && isspace(*p); p--)
-		*p = 0;
-}
-
 /*
  * create a chip instance and set its names.
  */
@@ -414,7 +404,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 				USB_ID_PRODUCT(chip->usb_id));
 		}
 	}
-	remove_trailing_spaces(card->shortname);
+	strim(card->shortname);
 
 	/* retrieve the vendor and device strings as longname */
 	if (quirk && quirk->vendor_name && *quirk->vendor_name) {
@@ -428,7 +418,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 		/* we don't really care if there isn't any vendor string */
 	}
 	if (len > 0) {
-		remove_trailing_spaces(card->longname);
+		strim(card->longname);
 		if (*card->longname)
 			strlcat(card->longname, " ", sizeof(card->longname));
 	}
-- 
2.1.3
