From: Oliver Neukum <oliver@neukum.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Thu, 8 Apr 2010 08:09:11 +0200
Message-ID: <201004080809.11756.oliver@neukum.org>
References: <20100407090623.GN30807@buzzloop.caiaq.de> <20100407153154.GC13425@kroah.com> <20100407153551.GK30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100407153551.GK30801@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Greg KH <greg@kroah.com>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 7. April 2010 17:35:51 schrieb Daniel Mack:
> > Alan, any objection to just using usb_buffer_alloc() for every driver?
> > Or is that too much overhead?
> 
> FWIW, most drivers I've seen in the past hours use a wild mix of
> kmalloc(), kzalloc(), kcalloc() and usb_buffer_alloc(). That should
> really be unified.

kmalloc() & friends != usb_buffer_alloc(). They do different things.
It makes no sense to unify them. If you really need an ordinary
buffer DMA will surely work on, this needs a third primitive.

	Regards
		Oliver
