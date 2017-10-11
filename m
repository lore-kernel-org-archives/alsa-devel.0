From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 3/9] ALSA: caiaq: Add a sanity check for
	invalid EPs
Date: Wed, 11 Oct 2017 16:20:31 +0200
Message-ID: <20171011142031.GY4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 0114B266CA1
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 16:20:29 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id 75so2290838lfx.1
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 07:20:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171011103646.11879-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 12:36:40PM +0200, Takashi Iwai wrote:
> As syzkaller spotted, currently caiaq driver submits a URB with the
> fixed EP without checking whether it's actually available, which may
> result in a kernel warning like:
>   usb 1-1: BOGUS urb xfer, pipe 3 != type 1
>   ------------[ cut here ]------------
>   WARNING: CPU: 1 PID: 1150 at drivers/usb/core/urb.c:449
>   usb_submit_urb+0xf8a/0x11d0
>   Modules linked in:
>   CPU: 1 PID: 1150 Comm: kworker/1:1 Not tainted
>   4.14.0-rc2-42660-g24b7bd59eec0 #277
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>   Workqueue: usb_hub_wq hub_event
>   Call Trace:
>    init_card sound/usb/caiaq/device.c:467
>    snd_probe+0x81c/0x1150 sound/usb/caiaq/device.c:525
>    usb_probe_interface+0x35d/0x8e0 drivers/usb/core/driver.c:361
>    ....
> 
> This patch adds a sanity check of validity of EPs at the device
> initialization phase for avoiding the call with an invalid EP.
> 
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/caiaq/device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index 0fb6b1b79261..a29674bf96e5 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -461,6 +461,13 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
>  			  cdev->midi_out_buf, EP1_BUFSIZE,
>  			  snd_usb_caiaq_midi_output_done, cdev);
>  
> +	/* sanity checks of EPs before actually submitting */
> +	if (usb_urb_ep_type_check(&cdev->ep1_in_urb) ||
> +	    usb_urb_ep_type_check(&cdev->midi_out_urb)) {
> +		dev_err(dev, "invalid EPs\n");
> +		return -EINVAL;
> +	}
> +

Unrelated to this patch, but this driver fails to kill the ep1_in_urb
(which is submitted in this function) in case of later probe errors.
This can lead to use-after-free or crashes in the completion callback.

>  	init_waitqueue_head(&cdev->ep1_wait_queue);
>  	init_waitqueue_head(&cdev->prepare_wait_queue);

Johan
