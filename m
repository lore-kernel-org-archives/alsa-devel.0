From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Wed, 10 Aug 2011 16:15:52 -0700
Message-ID: <20110810231552.GA7194@xanatos>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
 <4E42A4AE.4020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4E42A4AE.4020008@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Florian Mickler <florian@mickler.org>, Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
> On 08/10/2011 04:32 PM, Alan Stern wrote:
> >Looking at the driver's current code, it appears that your patch
> >does not fix the bug properly.  Using discontiguous regions in the
> >transfer buffer is perfectly okay.  The real problem is later on,
> >where you do:
> >
> >if (send_it) { out->number_of_packets = FRAMES_PER_URB;
> >
> >This should be
> >
> >out->number_of_packets = outframe;
> >
> >The way it is now, the USB stack will try to use data from all the
> >frame descriptors, and the last few will be stale because the loop
> >doesn't set them.
> 
> That's actually true, even though it doesn't seem to cause any trouble.
> I tested everything here of course, and the output URBs return back from
> the USB stack with their length fields zeroed out, which then
> causes the stack to send packets with zero-length fields at the end.

Actually, it causes system hangs when the driver is loaded on a device
attached to a USB 3.0 port, as Alan Stern pointed out:

https://bugzilla.kernel.org/show_bug.cgi?id=40702

Please don't submit zero-length transfers.  The xHCI driver just isn't
able to handle it.  Arguably, it probably should have just rejected your
URB when it found a zero length buffer, so I'll probably be submitting a
patch to fix that.

Sarah Sharp
