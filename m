From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] ALSA: usb: initial USB Audio Device Class 3.0 support
Date: Thu, 9 Nov 2017 09:04:58 +0100
Message-ID: <20171109080458.GC17098@kroah.com>
References: <1510020080-15849-1-git-send-email-ruslan.bilovol@gmail.com>
 <1510020080-15849-2-git-send-email-ruslan.bilovol@gmail.com>
 <s5h1sl8hm38.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1sl8hm38.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 08, 2017 at 03:38:35PM +0100, Takashi Iwai wrote:
> On Tue, 07 Nov 2017 03:01:20 +0100,
> Ruslan Bilovol wrote:
> > 
> > Recently released USB Audio Class 3.0 specification
> > introduces many significant changes comparing to
> > previous versions, like
> >  - new Power Domains, support for LPM/L1
> >  - new Cluster descriptor
> >  - changed layout of all class-specific descriptors
> >  - new High Capability descriptors
> >  - New class-specific String descriptors
> >  - new and removed units
> >  - additional sources for interrupts
> >  - removed Type II Audio Data Formats
> >  - ... and many other things (check spec)
> > 
> > It also provides backward compatibility through
> > multiple configurations, as well as requires
> > mandatory support for BADD (Basic Audio Device
> > Definition) on each ADC3.0 compliant device
> > 
> > This patch adds initial support of UAC3 specification
> > that is enough for Generic I/O Profile (BAOF, BAIF)
> > device support from BADD document.
> > 
> > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> 
> The patch looks good, but the timing is fairly late for merging to
> 4.15.

Isn't kbuild barfing all over these?  Is that because of the cross-tree
changes needed?

> So from my side, the primary question is whether the changes in USB
> (audio) header files are OK for USB guys.
> 
> Greg, could you check these changes and give an ack if it's OK to
> merge?  Or if you prefer postpone, just let me know.

I don't object to the USB header changes, as long as the fixes you point
out are made :)

thanks,

greg k-h
