From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH REPOST 2/2] ALSA: usb-midi: use irqsave() in
	USB's complete callback
Date: Sun,  1 Jul 2018 17:28:08 +0200
Message-ID: <20180701152808.8041-3-bigeasy@linutronix.de>
References: <20180701152808.8041-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (galois.linutronix.de [146.0.238.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 882FF2676EE
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 17:28:32 +0200 (CEST)
In-Reply-To: <20180701152808.8041-1-bigeasy@linutronix.de>
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
Cc: John Ogness <john.ogness@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

From: John Ogness <john.ogness@linutronix.de>

The USB completion callback does not disable interrupts while acquiring
the lock. We want to remove the local_irq_disable() invocation from
__usb_hcd_giveback_urb() and therefore it is required for the callback
handler to disable the interrupts while acquiring the lock.
The callback may be invoked either in IRQ or BH context depending on the
USB host controller.
Use the _irqsave() variant of the locking primitives.

Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/usb/midi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2c1aaa3292bf..dcfc546d81b9 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -281,15 +281,16 @@ static void snd_usbmidi_out_urb_complete(struct urb *urb)
 	struct out_urb_context *context = urb->context;
 	struct snd_usb_midi_out_endpoint *ep = context->ep;
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
 		int err = snd_usbmidi_urb_error(urb);
 		if (err < 0) {
-- 
2.18.0
