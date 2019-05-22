From: Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/1] ALSA: usb-audio: Fix UAF decrement if card has no live
 interfaces in card.c
Date: Wed, 22 May 2019 10:26:55 -0700
Message-ID: <20190522172655.183977-1-surenb@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: surenb@google.com
Cc: perex@perex.cz, tiwai@suse.de, mathias.payer@nebelwelt.net, benquike@gmail.com, kdeus@google.com, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 5f8cf712582617d523120df67d392059eaf2fc4b upstream.

This is a backport to stable 3.18.y. Implementation in 3.18 differs using
chip->probing flag instead of chip->active atomic but it still has the UAF
issue.

If a USB sound card reports 0 interfaces, an error condition is triggered
and the function usb_audio_probe errors out. In the error path, there was a
use-after-free vulnerability where the memory object of the card was first
freed, followed by a decrement of the number of active chips. Moving the
decrement above the atomic_dec fixes the UAF.

[ The original problem was introduced in 3.1 kernel, while it was
  developed in a different form.  The Fixes tag below indicates the
  original commit but it doesn't mean that the patch is applicable
  cleanly. -- tiwai ]

Fixes: 362e4e49abe5 ("ALSA: usb-audio - clear chip->probing on error exit")
Reported-by: Hui Peng <benquike@gmail.com>
Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
Signed-off-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Mathias Payer <mathias.payer@nebelwelt.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[surenb@google.com: resolve 3.18 differences]
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Analysis for 3.18 codebase:
snd_usb_audio_create() sets card->device_data = chip
snd_usb_audio_probe() calls snd_card_free() and then resets chip->probing
snd_card_free() results in the following call chain:
 snd_card_free_when_closed() which waits on release_completion
 snd_card_do_free() calls snd_device_free_all() and signals release_completion
 snd_card_do_free() calls __snd_device_free()
 __snd_device_free() calls dev->ops->dev_free() == snd_usb_audio_dev_free()
 snd_usb_audio_dev_free() calls snd_usb_audio_free(chip) and frees "chip"
chip->probing = 0 results in UAF

 sound/usb/card.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index f7dbdc10bf77..59fb1ef3cd55 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -593,9 +593,12 @@ snd_usb_audio_probe(struct usb_device *dev,
 
  __error:
 	if (chip) {
+		/* chip->probing is inside the chip->card object,
+		 * reset before memory is possibly returned.
+		 */
+		chip->probing = 0;
 		if (!chip->num_interfaces)
 			snd_card_free(chip->card);
-		chip->probing = 0;
 	}
 	mutex_unlock(&register_mutex);
  __err_val:
-- 
2.21.0.1020.gf2820cf01a-goog
