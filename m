From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 11:06:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107071100250.2186-100000@iolanthe.rowland.org>
References: <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, florian@mickler.org, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 7 Jul 2011, Daniel Mack wrote:

> On Thu, Jul 7, 2011 at 2:33 PM, Oliver Neukum <oliver@neukum.org> wro=
te:
>=20
> > PS: =A0Do you still see this if you enable 64bit DMA for EHCI?
>=20
> The problem is that I personally don't see that issue at all. I even
> installed 4GB of RAM to my development machine last year to be able t=
o
> reproduce this, but I can't, even when the memory allocator is under
> heavy load. The only people who see this effect are Pedro Ribeiro and
> William Light (both in Cc:), and both have been very helpful in tryin=
g
> patches and reporting back in detail. Which instructions could we
> probably give to these people to finally hunt this issue down?

Oliver is perfectly right; this problem needs to be solved at the=20
source.

One thing you might be able to do is put together a debugging patch
that would print out the bus address corresponding to the DMA handle
after the DMA mapping takes place, i.e., after the second
dma_map_single() call in usb_hcd_map_urb_for_dma() returns.  Or at
least, check the bus address to see if it is below the 4 GB limit and
print out an error message if it isn't.

(I don't know how one translates a DMA address to a bus address.  You'd=
=20
have to ask somebody who knows or figure it out.)

Alan Stern
