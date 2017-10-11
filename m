From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/9] ALSA: caiaq: Add a sanity check for invalid EPs
Date: Wed, 11 Oct 2017 16:49:10 +0200
Message-ID: <20171011144910.GD4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-4-tiwai@suse.de>
 <20171011142031.GY4269@localhost>
 <s5ha80x928r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5ha80x928r.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 04:40:36PM +0200, Takashi Iwai wrote:
> On Wed, 11 Oct 2017 16:20:31 +0200,
> Johan Hovold wrote:

> > Unrelated to this patch, but this driver fails to kill the ep1_in_urb
> > (which is submitted in this function) in case of later probe errors.
> > This can lead to use-after-free or crashes in the completion callback.
> 
> Yes, a good catch.  Below is the fix patch.

> -- 8< --
> From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> Subject: [PATCH] ALSA: caiaq: Fix stray URB at probe error path
> 
> caiaq driver doesn't kill the URB properly at its error path during
> the probe, which may lead to a use-after-free error later.  This patch
> addresses it.
> 
> Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>

Looks good to me:

Reviewed-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  sound/usb/caiaq/device.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index a29674bf96e5..d55ca48de3ea 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -476,10 +476,12 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
>  
>  	err = snd_usb_caiaq_send_command(cdev, EP1_CMD_GET_DEVICE_INFO, NULL, 0);
>  	if (err)
> -		return err;
> +		goto err_kill_urb;
>  
> -	if (!wait_event_timeout(cdev->ep1_wait_queue, cdev->spec_received, HZ))
> -		return -ENODEV;
> +	if (!wait_event_timeout(cdev->ep1_wait_queue, cdev->spec_received, HZ)) {
> +		err = -ENODEV;
> +		goto err_kill_urb;
> +	}
>  
>  	usb_string(usb_dev, usb_dev->descriptor.iManufacturer,
>  		   cdev->vendor_name, CAIAQ_USB_STR_LEN);
> @@ -514,6 +516,10 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
>  
>  	setup_card(cdev);
>  	return 0;
> +
> + err_kill_urb:
> +	usb_kill_urb(&cdev->ep1_in_urb);
> +	return err;
>  }
>  
>  static int snd_probe(struct usb_interface *intf,
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
