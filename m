From: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: [PATCH v1 44/49] sound: usb: midi: prepare for enabling irq in complete()
Date: Sun, 18 Aug 2013 00:25:09 +0800
Message-ID: <1376756714-25479-45-git-send-email-ming.lei@canonical.com>
References: <1376756714-25479-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376756714-25479-1-git-send-email-ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Complete() will be run with interrupt enabled, so change to
spin_lock_irqsave().

Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Signed-off-by: Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
---
 sound/usb/midi.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index b901f46..86af276 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -279,15 +279,16 @@ static void snd_usbmidi_out_urb_complete(struct urb* urb)
 	struct out_urb_context *context = urb->context;
 	struct snd_usb_midi_out_endpoint* ep = context->ep;
 	unsigned int urb_index;
+	unsigned long flags;
 
-	spin_lock(&ep->buffer_lock);
+	spin_lock_irqsave(&ep->buffer_lock, flags);
 	urb_index = context - ep->urbs;
 	ep->active_urbs &= ~(1 << urb_index);
 	if (unlikely(ep->drain_urbs)) {
 		ep->drain_urbs &= ~(1 << urb_index);
 		wake_up(&ep->drain_wait);
 	}
-	spin_unlock(&ep->buffer_lock);
+	spin_unlock_irqrestore(&ep->buffer_lock, flags);
 	if (urb->status < 0) {
 		int err = snd_usbmidi_urb_error(urb->status);
 		if (err < 0) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
