From: Andi Kleen <andi@firstfloor.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 17:43:23 +0200
Message-ID: <20100412154323.GP18855@one.firstfloor.org>
References: <20100407090623.GN30807@buzzloop.caiaq.de> <Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org> <87sk719hbm.fsf@basil.nowhere.org> <20100412111439.GU30801@buzzloop.caiaq.de> <20100412115300.GM18855@one.firstfloor.org> <q2z74fd948d1004120511hebf19eaauc41ee9ed25dea19e@mail.gmail.com> <20100412121243.GN18855@one.firstfloor.org> <20100412123238.GW30801@buzzloop.caiaq.de> <20100412124708.GO18855@one.firstfloor.org> <20100412125421.GX30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100412125421.GX30801@buzzloop.caiaq.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Andi Kleen <andi@firstfloor.org>, Pedro Ribeiro <pedrib@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urbs[i]->transfer_buffer =3D        =
                                                                       =
                   =20
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_UR=
B * BYTES_PER_FRAME, GFP_KERNEL);                                      =
                       =20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_UR=
B * BYTES_PER_FRAME, GFP_KERNEL | GFP_DMA32);                          =
                       =20

Ah you can't use GFP_DMA32 with kmalloc, only GFP_DMA.

Actually there should be a WARN_ON for this when slab debugging=20
is enabled.

Slab needs separate caches for dma, and it only has them for GFP_DMA,
but not DMA32.  Use __get_free_pages() for GFP_DMA32

> Well, the sound driver itself doesn't care for any of those things, j=
ust
> like any other USB driver doesn't. The USB core itself of the host
> controller driver should do, and as far as I can see, it does that, y=
es.

Hmm, still things must go wrong somewhere. Perhaps need some instrument=
ation
to see if all the transfer buffers really hit the PCI mapping functions=
=2E

It might be interesting to test if the device works with enabled
IOMMU. That would trigger any failures to properly map the buffers
earlier.

-Andi

--=20
ak@linux.intel.com -- Speaking for myself only.
