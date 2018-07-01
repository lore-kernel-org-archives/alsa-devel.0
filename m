From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH REPOST 2/2] ALSA: usb-midi: use irqsave()
 in USB's complete callback
Date: Sun, 1 Jul 2018 22:12:14 +0200
Message-ID: <7ccf71b7-cf45-33f3-c08a-14ac847287e2@ladisch.de>
References: <20180701152808.8041-1-bigeasy@linutronix.de>
 <20180701152808.8041-3-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 730462676B4
 for <alsa-devel@alsa-project.org>; Sun,  1 Jul 2018 22:12:18 +0200 (CEST)
In-Reply-To: <20180701152808.8041-3-bigeasy@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, alsa-devel@alsa-project.org
Cc: tglx@linutronix.de, Takashi Iwai <tiwai@suse.com>, John Ogness <john.ogness@linutronix.de>
List-Id: alsa-devel@alsa-project.org

Sebastian Andrzej Siewior wrote:
> From: John Ogness <john.ogness@linutronix.de>
>
> The USB completion callback does not disable interrupts while acquiring
> the lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave() variant of the locking primitives.
>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/usb/midi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index 2c1aaa3292bf..dcfc546d81b9 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -281,15 +281,16 @@ static void snd_usbmidi_out_urb_complete(struct urb *urb)
>  	struct out_urb_context *context = urb->context;
>  	struct snd_usb_midi_out_endpoint *ep = context->ep;
>  	unsigned int urb_index;
> +	unsigned long flags;
>
> -	spin_lock(&ep->buffer_lock);
> +	spin_lock_irqsave(&ep->buffer_lock, flags);
>  	urb_index = context - ep->urbs;
>  	ep->active_urbs &= ~(1 << urb_index);
>  	if (unlikely(ep->drain_urbs)) {
>  		ep->drain_urbs &= ~(1 << urb_index);
>  		wake_up(&ep->drain_wait);
>  	}
> -	spin_unlock(&ep->buffer_lock);
> +	spin_unlock_irqrestore(&ep->buffer_lock, flags);
>  	if (urb->status < 0) {
>  		int err = snd_usbmidi_urb_error(urb);
>  		if (err < 0) {
