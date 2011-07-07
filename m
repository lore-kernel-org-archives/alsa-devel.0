From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 14:33:42 +0200
Message-ID: <201107071433.42081.oliver@neukum.org>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, florian@mickler.org, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 7. Juli 2011, 13:53:46 schrieb Daniel Mack:
> Takashi recently posted a patch to the bugzilla entry which uses a
> different approach: it introduces a function to determine suitable GFP
> flags for USB devices, and passes __DMA32 to kmalloc() eventually.
> However, using this flags directly with the SLUB allocator is illegal
> and causes a BUG() in mm/slub.c, cache_grow().
> 
> The question now is how to proceed. I see three possible ways.
> 
> 1. Find a way to allocate 32bit-aware memory with kmalloc(), following
> Takashi's idea

That is not really a good idea, because many drivers have to deal with buffers
another subsystem has allocated.

> 2. Find out exactly why these machines fail to install bounce buffers
> or set up their IOMMU correctly

This is still the correct approach. Given the cause this cannot be a problem
only for audio. We need the root cause.

> 3. re-activate the currently disabled functions
> usb_buffer_{map,unmap,sync} functions and let the USB stack do the
> memory mapping

The USB stack does call the DMA mapping operations.

	Regards
		Oliver

PS:  Do you still see this if you enable 64bit DMA for EHCI?
