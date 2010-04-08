From: Oliver Neukum <oliver@neukum.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 08:12:04 +0200
Message-ID: <201004080812.04419.oliver@neukum.org>
References: <Pine.LNX.4.44L0.1004071120200.1779-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1004071120200.1779-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 7. April 2010 17:46:17 schrieb Alan Stern:
> Or alternatively, instead of allocating regular memory the routine
> could simply fail.  Then the caller would be responsible for checking
> and using regular memory instead of dma-consistent memory.  Of course,
> that would put an even larger burden on the caller than just forcing it
> to keep track of what flag to use.

Then it would be sensible to pass it a filled URB, modify it or return
an error code.

	Regards
		Oliver
