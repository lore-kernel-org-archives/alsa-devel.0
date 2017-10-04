From: Johan Hovold <johan@kernel.org>
Subject: Re: usb/sound/bcd2000: warning in bcd2000_init_device
Date: Wed, 4 Oct 2017 14:03:25 +0200
Message-ID: <20171004120325.GH3404@localhost>
References: <s5hh8vgut9l.wl-tiwai@suse.de>
 <Pine.LNX.4.44L0.1710031248320.1500-100000@iolanthe.rowland.org>
 <20171003174221.GA13006@kroah.com>
 <s5h1smjv3ws.wl-tiwai@suse.de>
 <20171004092442.GF3404@localhost>
 <s5ha8171b6x.wl-tiwai@suse.de>
 <20171004102311.GG3404@localhost>
 <s5h4lrf19fw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h4lrf19fw.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Andrey Konovalov <andreyknvl@google.com>, alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 04, 2017 at 12:41:55PM +0200, Takashi Iwai wrote:
> On Wed, 04 Oct 2017 12:23:11 +0200,
> Johan Hovold wrote:
> > 
> > On Wed, Oct 04, 2017 at 12:04:06PM +0200, Takashi Iwai wrote:
> > > On Wed, 04 Oct 2017 11:24:42 +0200, Johan Hovold wrote:
> > > > On Wed, Oct 04, 2017 at 08:10:59AM +0200, Takashi Iwai wrote:
> > 
> > > > > Well, what I had in my mind is just a snippet from usb_submit_urb(),
> > > > > something like:
> > > > > 
> > > > > bool usb_sanity_check_urb_pipe(struct urb *urb)
> > > > > {
> > > > > 	struct usb_host_endpoint *ep;
> > > > > 	int xfertype;
> > > > > 	static const int pipetypes[4] = {
> > > > > 		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
> > > > > 	};
> > > > > 
> > > > > 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
> > > > > 	xfertype = usb_endpoint_type(&ep->desc);
> > > > > 	return usb_pipetype(urb->pipe) != pipetypes[xfertype];
> > > > > }
> > > > > 
> > > > > And calling this before usb_submit_urb() in each place that assigns
> > > > > the fixed EP as device-specific quirks.
> > > > > Does it make sense?
> > > > 
> > > > Not really. Your driver should not even bind to an interface which lacks
> > > > the expected endpoints (rather than check this at a potentially later
> > > > point in time when URBs are submitted).
> > > 
> > > The endpoint may exist but it may be invalid, as the problem is
> > > triggered by a VM.  It doesn't parse but tries a fixed EP as it's no
> > > compliant device.
> > 
> > Yes, that's why a driver should verify that the endpoints it expects are
> > indeed present (and of the right type) already at probe.
> > 
> > In Andrey's fuzzing it's triggered by in a VM using the dummy_hcd
> > driver, but this could just as well be a (malicious) physical device
> > with unexpected descriptors.
> > 
> > > > The new helper which Greg mentioned would allow this to implemented with
> > > > just a few lines of code. Just add it to bcd2000_init_midi() or similar.  
> > > 
> > > Could you give an example?  Then I can ask Andrey whether such a call
> > > really addresses the issue.
> > 
> > If you grep for usb_find_common_endpoints you'll find a few examples
> > of how that function may be used (e.g. in drivers/usb/misc/usblcd.c).
> > 
> > The helper iterates of the endpoint descriptors of an interface
> > alt-setting and returns a descriptor for each requested type if found.
> > After a vetting of our current drivers I concluded that this would
> > cover the needs of the vast majority of drivers.
> > 
> > So for the driver in question you'd only need to add something like:
> > 
> > 	struct usb_endpoint_descriptor *int_in, *int_out;
> > 	int ret;
> > 
> > 	ret = usb_find_common_endpoints(interface->cur_altsetting,
> > 					NULL, NULL, &int_in, &int_out);
> > 	if (ret) {
> > 		dev_err(&interface->dev, "required endpoints not found\n");
> > 		return -ENODEV;
> > 	}
> > 
> > Then you can use int_in->bEndpointAddress etc. when initialising your
> > URBs.
> 
> OK, but in our cases, it's not about using the returned one but
> checking whether it's the expected address, right?  The device is
> non-compliant and that's the reason the driver takes the fixed EP.

There's nothing preventing you from verifying that the returned
descriptors have the expected addresses if tightening the constraints
this ways makes sense for your application.

Or you can implement your own sanity checks, just do it at probe.

But note that you'd introduce NULL-deref that can be triggered by a
malicious device with your outlined helper above, as

	ep = usb_pipe_endpoint(urb->dev, urb->pipe);

will be NULL when the corresponding descriptor is missing.

> In anyway, the check will be shortly before the URB submission because
> the EP is often determined a late stage of probe, as most of errors
> happened for the MIDI interface that are device-specific.

As long as you do the check during probe and refuse to bind to a
non-compliant device you should be fine. Some drivers do not submit URBs
until the user tries to use whatever interface the driver exposes (e.g.
when opening a character device), which IMO is too late for such sanity
checks.

Johan
