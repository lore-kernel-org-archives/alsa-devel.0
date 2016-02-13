From: Andrey Konovalov <andreyknvl@gmail.com>
Subject: [PATCH] midi: avoid freeing umidi object twice
Date: Sat, 13 Feb 2016 11:08:06 +0300
Message-ID: <1455350886-21126-1-git-send-email-andreyknvl@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: dvyukov@google.com, kcc@google.com, glider@google.com, Andrey Konovalov <andreyknvl@gmail.com>
List-Id: alsa-devel@alsa-project.org

The 'umidi' object will be free'd on the error path by snd_usbmidi_free()
when tearing down the rawmidi interface. So we shouldn't try to free it
in snd_usbmidi_create() after having registered the rawmidi interface.

Found by KASAN.

Acked-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 sound/usb/midi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index cc39f63..007cf58 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2455,7 +2455,6 @@ int snd_usbmidi_create(struct snd_card *card,
 	else
 		err = snd_usbmidi_create_endpoints(umidi, endpoints);
 	if (err < 0) {
-		snd_usbmidi_free(umidi);
 		return err;
 	}
 
-- 
1.9.1
