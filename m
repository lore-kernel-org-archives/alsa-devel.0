From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: usb/sound/bcd2000: warning in bcd2000_init_device
Date: Wed, 4 Oct 2017 10:26:07 +0200
Message-ID: <20171004082607.GA18449@kroah.com>
References: <s5hh8vgut9l.wl-tiwai@suse.de>
 <Pine.LNX.4.44L0.1710031248320.1500-100000@iolanthe.rowland.org>
 <20171003174221.GA13006@kroah.com>
 <s5h1smjv3ws.wl-tiwai@suse.de>
 <20171004075236.GA23771@kroah.com>
 <s5htvzftjwn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <s5htvzftjwn.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andrey Konovalov <andreyknvl-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Kostya Serebryany <kcc-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, syzkaller <syzkaller-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 04, 2017 at 10:08:24AM +0200, Takashi Iwai wrote:
> On Wed, 04 Oct 2017 09:52:36 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > On Wed, Oct 04, 2017 at 08:10:59AM +0200, Takashi Iwai wrote:
> > > On Tue, 03 Oct 2017 19:42:21 +0200,
> > > Greg Kroah-Hartman wrote:
> > > > 
> > > > On Tue, Oct 03, 2017 at 12:50:08PM -0400, Alan Stern wrote:
> > > > > On Tue, 3 Oct 2017, Takashi Iwai wrote:
> > > > > 
> > > > > > > It's a dev_WARN because it indicates a potentially serious error in the 
> > > > > > > driver: The driver has submitted an interrupt URB to a bulk endpoint.  
> > > > > > > That may not sound bad, but the same check gets triggered if a driver 
> > > > > > > submits a bulk URB to an isochronous endpoint, or any other invalid 
> > > > > > > combination.
> > > > > > > 
> > > > > > > Most likely the explanation here is that the driver doesn't bother to
> > > > > > > check the endpoint type because it expects the endpoint will always be
> > > > > > > interrupt.  But that is not a safe strategy.  USB devices and their
> > > > > > > firmware should not be trusted unnecessarily.
> > > > > > > 
> > > > > > > The best fix is, like you said, to add a sanity check in the caller.
> > > > > > 
> > > > > > OK, but then do we have some handy helper for the check?
> > > > > > As other bug reports by syzkaller suggest, there are a few other
> > > > > > drivers that do the same, submitting a urb with naive assumption of
> > > > > > the fixed EP for specific devices.  In the end we'll need to put the
> > > > > > very same checks there in multiple places.
> > > > > 
> > > > > Perhaps we could add a helper routine that would take a list of 
> > > > > expected endpoint types and check that the actual endpoints match the 
> > > > > types.  But of course, all the drivers you're talking about would have 
> > > > > to add a call to this helper routine.
> > > > 
> > > > We have almost this type of function, usb_find_common_endpoints(),
> > > > what's wrong with using that?  Johan has already swept the tree and
> > > > added a lot of these checks, odds are no one looked at the sound/
> > > > subdir...
> > > 
> > > Well, what I had in my mind is just a snippet from usb_submit_urb(),
> > > something like:
> > > 
> > > bool usb_sanity_check_urb_pipe(struct urb *urb)
> > > {
> > > 	struct usb_host_endpoint *ep;
> > > 	int xfertype;
> > > 	static const int pipetypes[4] = {
> > > 		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> > > 	};
> > > 
> > > 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> > > 	xfertype = usb_endpoint_type(&ep->desc);
> > > 	return usb_pipetype(urb->pipe) != pipetypes[xfertype];
> > > }
> > > 
> > > And calling this before usb_submit_urb() in each place that assigns
> > > the fixed EP as device-specific quirks.
> > > Does it make sense?
> > 
> > Yes, kind of, but checking the endpoint type/direction is what you are
> > expecting it to be as you "know" what the type should be for each
> > driver as it is unique.
> 
> Yes, it can be simplified, but if we want a common helper function,
> this style would have an advantage that it can be used generically for
> all drivers.
> 
> > Anyway, a "real" patch might make more sense to me.
> 
> I can cook up a patch if you find it a good idea to add such a common
> function to usb core side.  OTOH, if each driver should open-code this
> in each place, I can work on that, too.  Which would you prefer?

A common function is good, open-coding is bad :)

Try it with a driver or two to see what it looks like?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
