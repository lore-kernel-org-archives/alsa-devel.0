From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Mon, 12 Apr 2010 14:54:21 +0200
Message-ID: <20100412125421.GX30801@buzzloop.caiaq.de>
References: <20100407090623.GN30807@buzzloop.caiaq.de>
	<Pine.LNX.4.44L0.1004071036060.1779-100000@iolanthe.rowland.org>
	<87sk719hbm.fsf@basil.nowhere.org>
	<20100412111439.GU30801@buzzloop.caiaq.de>
	<20100412115300.GM18855@one.firstfloor.org>
	<q2z74fd948d1004120511hebf19eaauc41ee9ed25dea19e@mail.gmail.com>
	<20100412121243.GN18855@one.firstfloor.org>
	<20100412123238.GW30801@buzzloop.caiaq.de>
	<20100412124708.GO18855@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ADDE10380B
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 14:54:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100412124708.GO18855@one.firstfloor.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andi Kleen <andi@firstfloor.org>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Pedro Ribeiro <pedrib@gmail.com>, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 12, 2010 at 02:47:08PM +0200, Andi Kleen wrote:
> On Mon, Apr 12, 2010 at 02:32:38PM +0200, Daniel Mack wrote:
> > Another detail I can't explain is that on his machine, the kernel oopses
> > when kmalloc() with GFP_DMA32 is used. The patch to try this also only
> > touched the allocation in sound/usb/caiaq/audio.c.
> =

> Where did it oops?

Pedro sent me an image:

  http://caiaq.de/download/tmp/GFP_DMA32.JPG

The patch I sent him for testing and that lead to this Oops was:

> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c           =
                                                                   =

> index 4328cad..26013be 100644                                            =
                                                                   =

> --- a/sound/usb/caiaq/audio.c                                            =
                                                                   =

> +++ b/sound/usb/caiaq/audio.c                                            =
                                                                   =

> @@ -560,7 +560,7 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqde=
v *dev, int dir, int *ret)                                         =

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}                                         =
                                                                           =
        =

>                                                                          =
                                                                   =

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urbs[i]->transfer_buffer =3D              =
                                                                           =
          =

> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB * BY=
TES_PER_FRAME, GFP_KERNEL);                                                =
              =

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB * BY=
TES_PER_FRAME, GFP_KERNEL | GFP_DMA32);                                    =
              =

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!urbs[i]->transfer_buffer) {          =
                                                                           =
        =

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0log("unable to kmalloc() t=
ransfer buffer, OOM!?\n");                                                 =
                =

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ret =3D -ENOMEM;         =
                                                                           =
                  =

>                                                                          =
                                                                   =



> >   http://caiaq.de/download/tmp/pedro-dmesg
> =

> The system seems to set up the soft iotlb correctly.
> =

> [    0.468472] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.468539] Placing 64MB software IO TLB between ffff880020000000 - ff=
ff880024000000
> [    0.468610] software IO TLB at phys 0x20000000 - 0x24000000
> =

> Also if that was wrong a lot more things would go wrong.
> =

> I would suspect the driver. Are you sure:
> =

> - it sets up it's dma_masks correctly?
> - it uses pci_map_single/sg correctly for all transferred data?

Well, the sound driver itself doesn't care for any of those things, just
like any other USB driver doesn't. The USB core itself of the host
controller driver should do, and as far as I can see, it does that, yes.

Daniel
