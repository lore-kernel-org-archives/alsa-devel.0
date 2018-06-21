From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 5/9] ALSA: usb: caiaq: audio: use irqsave()
 in USB's complete callback
Date: Thu, 21 Jun 2018 22:18:48 +0200
Message-ID: <29d196d2-f901-4bf7-24a0-1c994ff2d583@zonque.org>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-6-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C171267610
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 22:18:50 +0200 (CEST)
In-Reply-To: <20180619215521.13688-6-bigeasy@linutronix.de>
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
Cc: John Ogness <john.ogness@linutronix.de>, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Daniel Mack <zonque@gmail.com>, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

On Tuesday, June 19, 2018 11:55 PM, Sebastian Andrzej Siewior wrote:
> From: John Ogness <john.ogness@linutronix.de>
> 
> The USB completion callback does not disable interrupts while acquiring
> the lock. We want to remove the local_irq_disable() invocation from
> __usb_hcd_giveback_urb() and therefore it is required for the callback
> handler to disable the interrupts while acquiring the lock.
> The callback may be invoked either in IRQ or BH context depending on the
> USB host controller.
> Use the _irqsave() variant of the locking primitives.
Acked-by: Daniel Mack <zonque@gmail.com>


> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   sound/usb/caiaq/audio.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
> index f35d29f49ffe..15344d39a6cd 100644
> --- a/sound/usb/caiaq/audio.c
> +++ b/sound/usb/caiaq/audio.c
> @@ -636,6 +636,7 @@ static void read_completed(struct urb *urb)
>   	struct device *dev;
>   	struct urb *out = NULL;
>   	int i, frame, len, send_it = 0, outframe = 0;
> +	unsigned long flags;
>   	size_t offset = 0;
>   
>   	if (urb->status || !info)
> @@ -672,10 +673,10 @@ static void read_completed(struct urb *urb)
>   		offset += len;
>   
>   		if (len > 0) {
> -			spin_lock(&cdev->spinlock);
> +			spin_lock_irqsave(&cdev->spinlock, flags);
>   			fill_out_urb(cdev, out, &out->iso_frame_desc[outframe]);
>   			read_in_urb(cdev, urb, &urb->iso_frame_desc[frame]);
> -			spin_unlock(&cdev->spinlock);
> +			spin_unlock_irqrestore(&cdev->spinlock, flags);
>   			check_for_elapsed_periods(cdev, cdev->sub_playback);
>   			check_for_elapsed_periods(cdev, cdev->sub_capture);
>   			send_it = 1;
> 
