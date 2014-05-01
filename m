From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: work around corrupted TEAC UD-H01 feedback data
Date: Thu,  1 May 2014 12:20:22 +0200
Message-ID: <1398939622-29451-1-git-send-email-zonque@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: clemens@ladisch.de, mick37@gmx.de, andr.messa@tiscali.it, tiwai@suse.de, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Clemens Ladisch <clemens@ladisch.de>

The TEAC UD-H01 firmware sends wrong feedback frequency values, thus
causing the PC to send the samples at a wrong rate, which results in
clicks and crackles in the output.

Add a workaround to detect and fix the corruption.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
[mick37@gmx.de: use sender->udh01_fb_quirk rather than
 ep->udh01_fb_quirk in snd_usb_handle_sync_urb()]
Reported-and-tested-by: Mick <mick37@gmx.de>
Reported-and-tested-by: Andrea Messa <andr.messa@tiscali.it>
Cc: <stable@vger.kernel.org>
---
Clemens, I hope you're ok that I resend this patch. With Mick's minor
amendment (use sender->udh01_fb_quirk rather than ep->udh01_fb_quirk),
Andrea Messa also reported success with the same hardware model.


Thanks,
Daniel

 sound/usb/card.h     |  1 +
 sound/usb/endpoint.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.h b/sound/usb/card.h
index 9867ab8..97acb90 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -92,6 +92,7 @@ struct snd_usb_endpoint {
 	unsigned int curframesize;      /* current packet size in frames (for capture) */
 	unsigned int syncmaxsize;	/* sync endpoint packet size */
 	unsigned int fill_max:1;	/* fill max packet size always */
+	unsigned int udh01_fb_quirk:1;	/* corrupted feedback data */
 	unsigned int datainterval;      /* log_2 of data packet interval */
 	unsigned int syncinterval;	/* P for adaptive mode, 0 otherwise */
 	unsigned char silence_value;
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index e70a87e..289f582 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -471,6 +471,10 @@ struct snd_usb_endpoint *snd_usb_add_endpoint(struct snd_usb_audio *chip,
 			ep->syncinterval = 3;
 
 		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
+
+		if (chip->usb_id == USB_ID(0x0644, 0x8038) /* TEAC UD-H01 */ &&
+		    ep->syncmaxsize == 4)
+			ep->udh01_fb_quirk = 1;
 	}
 
 	list_add_tail(&ep->list, &chip->ep_list);
@@ -1105,7 +1109,16 @@ void snd_usb_handle_sync_urb(struct snd_usb_endpoint *ep,
 	if (f == 0)
 		return;
 
-	if (unlikely(ep->freqshift == INT_MIN)) {
+	if (unlikely(sender->udh01_fb_quirk)) {
+		/*
+		 * The TEAC UD-H01 firmware sometimes changes the feedback value
+		 * by +/- 0x1.0000.
+		 */
+		if (f < ep->freqn - 0x8000)
+			f += 0x10000;
+		else if (f > ep->freqn + 0x8000)
+			f -= 0x10000;
+	} else if (unlikely(ep->freqshift == INT_MIN)) {
 		/*
 		 * The first time we see a feedback value, determine its format
 		 * by shifting it left or right until it matches the nominal
-- 
1.9.0
