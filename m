From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 1/9] usb: core: Add a helper function to check the
 validity of EP type in URB
Date: Tue, 10 Oct 2017 15:53:49 +0200
Message-ID: <20171010135349.GH6418@kroah.com>
References: <20171010133819.10567-1-tiwai@suse.de>
 <20171010133819.10567-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171010133819.10567-2-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 10, 2017 at 03:38:11PM +0200, Takashi Iwai wrote:
> This patch adds a new helper function to perform a sanity check of the
> given URB to see whether it contains a valid endpoint.  It's a light-
> weight version of what usb_submit_urb() does, but without the kernel
> warning followed by the stack trace, just returns an error code.
> 
> Especially for a driver that doesn't parse the descriptor but fills
> the URB with the fixed endpoint (e.g. some quirks for non-compliant
> devices), this kind of check is preferable at the probe phase before
> actually submitting the urb.
> 
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/usb/core/urb.c | 28 +++++++++++++++++++++++++---
>  include/linux/usb.h    |  2 ++
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> index 47903d510955..580dfaec8af7 100644
> --- a/drivers/usb/core/urb.c
> +++ b/drivers/usb/core/urb.c
> @@ -187,6 +187,31 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
>  
>  /*-------------------------------------------------------------------*/
>  
> +static const int pipetypes[4] = {
> +	PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> +};
> +
> +/**
> + * usb_urb_ep_check_type - sanity check of endpoint in the given urb
> + * @urb: urb to be checked
> + *
> + * This performs a light-weight sanity check for the endpoint in the
> + * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
> + * a negative error code.
> + */
> +int usb_urb_ep_check_type(const struct urb *urb)
> +{
> +	const struct usb_host_endpoint *ep;
> +
> +	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> +	if (!ep)
> +		return -EINVAL;
> +	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
> +		return -EINVAL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_urb_ep_check_type);
> +
>  /**
>   * usb_submit_urb - issue an asynchronous transfer request for an endpoint
>   * @urb: pointer to the urb describing the request
> @@ -326,9 +351,6 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
>   */
>  int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
>  {
> -	static int			pipetypes[4] = {
> -		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> -	};
>  	int				xfertype, max;
>  	struct usb_device		*dev;
>  	struct usb_host_endpoint	*ep;

Can you also call usb_urb_ep_check_type() in usb_submit_urb()?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
