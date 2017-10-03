From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: usb/sound/bcd2000: warning in bcd2000_init_device
Date: Tue, 3 Oct 2017 19:42:21 +0200
Message-ID: <20171003174221.GA13006@kroah.com>
References: <s5hh8vgut9l.wl-tiwai@suse.de>
 <Pine.LNX.4.44L0.1710031248320.1500-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1710031248320.1500-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 03, 2017 at 12:50:08PM -0400, Alan Stern wrote:
> On Tue, 3 Oct 2017, Takashi Iwai wrote:
> 
> > > It's a dev_WARN because it indicates a potentially serious error in the 
> > > driver: The driver has submitted an interrupt URB to a bulk endpoint.  
> > > That may not sound bad, but the same check gets triggered if a driver 
> > > submits a bulk URB to an isochronous endpoint, or any other invalid 
> > > combination.
> > > 
> > > Most likely the explanation here is that the driver doesn't bother to
> > > check the endpoint type because it expects the endpoint will always be
> > > interrupt.  But that is not a safe strategy.  USB devices and their
> > > firmware should not be trusted unnecessarily.
> > > 
> > > The best fix is, like you said, to add a sanity check in the caller.
> > 
> > OK, but then do we have some handy helper for the check?
> > As other bug reports by syzkaller suggest, there are a few other
> > drivers that do the same, submitting a urb with naive assumption of
> > the fixed EP for specific devices.  In the end we'll need to put the
> > very same checks there in multiple places.
> 
> Perhaps we could add a helper routine that would take a list of 
> expected endpoint types and check that the actual endpoints match the 
> types.  But of course, all the drivers you're talking about would have 
> to add a call to this helper routine.

We have almost this type of function, usb_find_common_endpoints(),
what's wrong with using that?  Johan has already swept the tree and
added a lot of these checks, odds are no one looked at the sound/
subdir...

thanks,

greg k-h
