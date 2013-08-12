From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [alsa-devel] Buffer size for ALSA USB PCM audio
Date: Mon, 12 Aug 2013 10:53:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308121036460.1489-100000@iolanthe.rowland.org>
References: <s5h7gfryrgh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5h7gfryrgh.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, Eldad Zack <eldad-v6AqZgAe4C4dvzyIwGCCOg@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Aug 2013, Takashi Iwai wrote:

> > Here's what I've got.  In turns out the predicting the optimum number
> > of URBs needed is extremely difficult.  I decided it would be better to
> > make an overestimate and then to submit URBs as needed, rather than
> > keeping all of them active all the time.
> > 
> > I ended up with this patch (untested).  It is certainly incomplete 
> > because it doesn't address endpoints with implicit sync.  It also 
> > suffers from a race between snd_submit_urbs() and deactivate_urbs():
> > an URB may be resubmitted after it has been deactivated.
> 
> What's the reason to clear ep->active_mask at the beginning of
> snd_complete_urb()?

In order to keep ep->active_mask accurate.  snd_complete_urb() might
not resubmit the URB.

> >  (In all 
> > fairness, I think this race probably exists in the current code too -- 
> > there are no spinlocks for synchronization.)
> 
> The calls of usb_submit_urb() and usb_unlink_urb() might race indeed.
> The current code somehow assumed that the USB accepts such concurrent
> calls.

The USB API does indeed allow concurrent calls of usb_submit_urb() and
usb_unlink_urb().  They are serialized by a spinlock in the host
controller driver, and if the usb_unlink_urb() call ends up coming
first, it will fail.

(Ironically, in the EHCI driver, trying to unlink an isochronous URB
doesn't do anything at all.  The URB will complete in the usual way,
when all its time slots expire.)

>  deactivate_urbs() just kills the pending urbs and it doesn't
> change ep->active_mask bit by itself, and the synchronization is done
> in wait_clear_urbs().

Oh, so that's where ep->active_mask gets used.  Why call 
bitmap_weight()?  Why not simply see if the mask value is equal to 0?

>  So, if the concurrent calls of usb_submit_urb()
> and usb_unlink_urbs() were allowed, it should work as is (in the worst
> case, the complete will be called once again, but then it goes to
> exit_clear).

I see.  Assuming there's always at least one active URB while the
endpoint is running, wait_clear_urbs() should work okay.  The patch
won't violate this assumption, so it's good.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
