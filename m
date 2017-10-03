From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb/sound/bcd2000: warning in bcd2000_init_device
Date: Tue, 3 Oct 2017 12:50:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1710031248320.1500-100000@iolanthe.rowland.org>
References: <s5hh8vgut9l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh8vgut9l.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Oct 2017, Takashi Iwai wrote:

> > It's a dev_WARN because it indicates a potentially serious error in the 
> > driver: The driver has submitted an interrupt URB to a bulk endpoint.  
> > That may not sound bad, but the same check gets triggered if a driver 
> > submits a bulk URB to an isochronous endpoint, or any other invalid 
> > combination.
> > 
> > Most likely the explanation here is that the driver doesn't bother to
> > check the endpoint type because it expects the endpoint will always be
> > interrupt.  But that is not a safe strategy.  USB devices and their
> > firmware should not be trusted unnecessarily.
> > 
> > The best fix is, like you said, to add a sanity check in the caller.
> 
> OK, but then do we have some handy helper for the check?
> As other bug reports by syzkaller suggest, there are a few other
> drivers that do the same, submitting a urb with naive assumption of
> the fixed EP for specific devices.  In the end we'll need to put the
> very same checks there in multiple places.

Perhaps we could add a helper routine that would take a list of 
expected endpoint types and check that the actual endpoints match the 
types.  But of course, all the drivers you're talking about would have 
to add a call to this helper routine.

Alan Stern
