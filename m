From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 7/9] ALSA: hiface: Add sanity checks for invalid EPs
Date: Wed, 11 Oct 2017 12:36:44 +0200
Message-ID: <20171011103646.11879-8-tiwai@suse.de>
References: <20171011103646.11879-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171011103646.11879-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

hiface usb-audio driver sets up URBs containing the fixed endpoints
without validation.  This may end up with an oops-like kernel warning
when submitted.

For avoiding it, this patch adds the calls of the new sanity-check
helper for URBs.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
---
 sound/usb/hiface/pcm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 175d8d6b7f59..396c317115b1 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -541,6 +541,8 @@ static int hiface_pcm_init_urb(struct pcm_urb *urb,
 	usb_fill_bulk_urb(&urb->instance, chip->dev,
 			  usb_sndbulkpipe(chip->dev, ep), (void *)urb->buffer,
 			  PCM_PACKET_SIZE, handler, urb);
+	if (usb_urb_ep_type_check(&urb->instance))
+		return -EINVAL;
 	init_usb_anchor(&urb->submitted);
 
 	return 0;
@@ -599,9 +601,12 @@ int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq)
 	mutex_init(&rt->stream_mutex);
 	spin_lock_init(&rt->playback.lock);
 
-	for (i = 0; i < PCM_N_URBS; i++)
-		hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
+	for (i = 0; i < PCM_N_URBS; i++) {
+		ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
 				    hiface_pcm_out_urb_handler);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
 	if (ret < 0) {
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
