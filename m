From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 9/9] ALSA: line6: Add yet more sanity checks for
 invalid EPs
Date: Wed, 11 Oct 2017 16:39:52 +0200
Message-ID: <20171011143952.GB4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-10-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171011103646.11879-10-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 12:36:46PM +0200, Takashi Iwai wrote:
> There are a few other places calling usb_submit_urb() with the URB
> composed from the fixed endpoint without validation.  For avoiding the
> spurious kernel warnings, add the sanity checks to appropriate
> places.
> 
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> ---
>  sound/usb/line6/driver.c | 23 +++++++++++++++--------
>  sound/usb/line6/midi.c   | 17 +++++++++++------
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
> index 0da6f68761e3..7c682b219584 100644
> --- a/sound/usb/line6/driver.c
> +++ b/sound/usb/line6/driver.c
> @@ -175,17 +175,24 @@ static int line6_send_raw_message_async_part(struct message *msg,
>  	}
>  
>  	msg->done += bytes;
> -	retval = usb_submit_urb(urb, GFP_ATOMIC);
>  
> -	if (retval < 0) {
> -		dev_err(line6->ifcdev, "%s: usb_submit_urb failed (%d)\n",
> -			__func__, retval);
> -		usb_free_urb(urb);
> -		kfree(msg);
> -		return retval;
> -	}
> +	/* sanity checks of EP before actually submitting */
> +	retval = usb_urb_ep_type_check(urb);
> +	if (retval < 0)
> +		goto error;

This also seems like something which should have been done once at urb
allocation time, rather than on every submission (just like the URB
initialisation should have been).

> +
> +	retval = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (retval < 0)
> +		goto error;
>  
>  	return 0;
> +
> + error:
> +	dev_err(line6->ifcdev, "%s: usb_submit_urb failed (%d)\n",
> +		__func__, retval);
> +	usb_free_urb(urb);
> +	kfree(msg);
> +	return retval;

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
