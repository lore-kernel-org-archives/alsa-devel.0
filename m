From: Oliver Neukum <oliver@neukum.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Fri, 9 Apr 2010 08:04:35 +0200
Message-ID: <201004090804.36213.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1004081817230.21642-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1004081817230.21642-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Freitag, 9. April 2010 00:20:36 schrieb Alan Stern:
> > > That would work, but it doesn't match the way existing drivers use the
> > > interface.  For example, the audio driver allocates a 16-byte coherent
> > > buffer and then uses four bytes from it for each of four different 
> > > URBs.
> > 
> > That will not work with any fallback that does not yield a coherent buffer.
> 
> What you mean isn't entirely clear.  But it certainly does work in 
> various circumstances that don't yield coherent buffers.  For example, 
> it works if the controller uses PIO instead of DMA.  It also works if 
> the controller uses DMA and the URBs have to be bounced.

It'll work on x86. On incoherent architectures this violates the cacheline
rules for DMA-mapping if you have to bounce. So it seems to me that
if you want to share a buffer between URBs, it must be coherent.

	Regards
		Oliver
