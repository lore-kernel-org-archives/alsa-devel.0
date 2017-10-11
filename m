From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 6/9] ALSA: usx2y: Add sanity checks for invalid EPs
Date: Wed, 11 Oct 2017 16:33:37 +0200
Message-ID: <20171011143337.GA4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171011103646.11879-7-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 12:36:43PM +0200, Takashi Iwai wrote:
> usx2y driver sets up URBs containing the fixed endpoints without
> validation.  This may end up with an oops-like kernel warning when
> submitted.
> 
> For avoiding it, this patch adds the calls of the new sanity-check
> helper for URBs.
> 
> Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> ---
>  sound/usb/usx2y/usbusx2y.c      | 8 ++++++++
>  sound/usb/usx2y/usbusx2yaudio.c | 3 +++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
> index 4569c0efac0a..55a631ccfa25 100644
> --- a/sound/usb/usx2y/usbusx2y.c
> +++ b/sound/usb/usx2y/usbusx2y.c
> @@ -244,6 +244,9 @@ static void i_usX2Y_In04Int(struct urb *urb)
>  								  usb_sndbulkpipe(usX2Y->dev, 0x04), &p4out->val.vol,
>  								  p4out->type == eLT_Light ? sizeof(struct us428_lights) : 5,
>  								  i_usX2Y_Out04Int, usX2Y);
> +						err = usb_urb_ep_type_check(usX2Y->AS04.urb[j]);
> +						if (err < 0)
> +							break;

It doesn't make much sense to add this check to the completion handler,
where, if you ever get here, you already know that endpoint check at
first submission succeeded.

>  						err = usb_submit_urb(usX2Y->AS04.urb[j], GFP_ATOMIC);
>  						us428ctls->p4outSent = send;
>  						break;

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
