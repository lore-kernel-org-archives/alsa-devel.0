From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 15:08:43 +0200
Message-ID: <201107071508.43988.oliver@neukum.org>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com> <201107071433.42081.oliver@neukum.org> <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, florian@mickler.org, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 7. Juli 2011, 14:38:51 schrieb Daniel Mack:
> On Thu, Jul 7, 2011 at 2:33 PM, Oliver Neukum <oliver@neukum.org> wrote:
> 
> > PS:  Do you still see this if you enable 64bit DMA for EHCI?
> 
> The problem is that I personally don't see that issue at all. I even
> installed 4GB of RAM to my development machine last year to be able to
> reproduce this, but I can't, even when the memory allocator is under
> heavy load. The only people who see this effect are Pedro Ribeiro and
> William Light (both in Cc:), and both have been very helpful in trying
> patches and reporting back in detail. Which instructions could we
> probably give to these people to finally hunt this issue down?

Do they have an IOMMU or are they using bounce buffers?
If the latter, you might be able to reproduce it if you disable your
IOMMU.

	Regards
		Oliver
