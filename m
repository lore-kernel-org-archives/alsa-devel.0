From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Sound, 6fire: Don't leak firmware in error path
Date: Mon, 30 May 2011 12:49:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105301245060.6250@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Torsten Schenk <torsten.schenk@zoho.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

One of the error paths in 
sound/usb/6fire/firmware.c::usb6fire_fw_ezusb_upload() neglects to free 
the memory allocated for the firmware before returning, thus leaking the 
memory.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 firmware.c |    1 +
 1 file changed, 1 insertion(+)

  patch against 3.0-rc1
  compile tested only

diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
index d47beff..a91719d 100644
--- a/sound/usb/6fire/firmware.c
+++ b/sound/usb/6fire/firmware.c
@@ -227,6 +227,7 @@ static int usb6fire_fw_ezusb_upload(
 	ret = usb6fire_fw_ihex_init(fw, rec);
 	if (ret < 0) {
 		kfree(rec);
+		release_firmware(fw);
 		snd_printk(KERN_ERR PREFIX "error validating ezusb "
 				"firmware %s.\n", fwname);
 		return ret;


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
