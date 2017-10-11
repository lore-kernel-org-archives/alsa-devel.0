From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/9] usb: core: Add a helper function to check the
 validity of EP type in URB
Date: Wed, 11 Oct 2017 16:58:00 +0200
Message-ID: <20171011145800.GF4269@localhost>
References: <20171011103646.11879-1-tiwai@suse.de>
 <20171011103646.11879-2-tiwai@suse.de>
 <20171011141455.GX4269@localhost>
 <s5hbmld92ok.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5hbmld92ok.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 11, 2017 at 04:31:07PM +0200, Takashi Iwai wrote:
> On Wed, 11 Oct 2017 16:14:55 +0200,
> Johan Hovold wrote:
> > 
> > On Wed, Oct 11, 2017 at 12:36:38PM +0200, Takashi Iwai wrote:
> > > This patch adds a new helper function to perform a sanity check of the
> > > given URB to see whether it contains a valid endpoint.  It's a light-
> > > weight version of what usb_submit_urb() does, but without the kernel
> > > warning followed by the stack trace, just returns an error code.
> > > 
> > > Especially for a driver that doesn't parse the descriptor but fills
> > > the URB with the fixed endpoint (e.g. some quirks for non-compliant
> > > devices), this kind of check is preferable at the probe phase before
> > > actually submitting the urb.
> > > 
> > > Tested-by: Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> > > Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
> > > ---
> > > v1->v2:
> > > * Fix function name typos
> > > * Call usb_urb_ep_type_check() in usb_submit_urb(), too
> > > 
> > >  drivers/usb/core/urb.c | 30 ++++++++++++++++++++++++++----
> > >  include/linux/usb.h    |  2 ++
> > >  2 files changed, 28 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
> > > index 47903d510955..8b800e34407b 100644
> > > --- a/drivers/usb/core/urb.c
> > > +++ b/drivers/usb/core/urb.c
> > > @@ -187,6 +187,31 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
> > >  
> > >  /*-------------------------------------------------------------------*/
> > >  
> > > +static const int pipetypes[4] = {
> > > +	PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> > > +};
> > 
> > No this one is no longer used outside of usb_urb_ep_type_check().
> 
> It is used in the error message, so I kept it here.

Ah, my bad, sorry.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
