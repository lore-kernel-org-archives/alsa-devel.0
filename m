From: Pedro Ribeiro <pedrib-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB transfer_buffer allocations on 64bit systems
Date: Wed, 14 Apr 2010 00:46:42 +0100
Message-ID: <k2o74fd948d1004131646k1e0e1897z7594f77a580c6b9f@mail.gmail.com>
References: <20100412162947.GQ18855@one.firstfloor.org>
	 <Pine.LNX.4.44L0.1004121252310.1702-100000@iolanthe.rowland.org>
	 <20100413182233.GR30807@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100413182233.GR30807-ahpEBR4enfnCULTFXS99ULNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 13 April 2010 19:22, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org> wrote:
> On Mon, Apr 12, 2010 at 12:57:16PM -0400, Alan Stern wrote:
>> On Mon, 12 Apr 2010, Andi Kleen wrote:
>> > On Mon, Apr 12, 2010 at 12:17:22PM -0400, Alan Stern wrote:
>> > > On Mon, 12 Apr 2010, Andi Kleen wrote:
>> > >
>> > > > > Well, the sound driver itself doesn't care for any of those =
things, just
>> > > > > like any other USB driver doesn't. The USB core itself of th=
e host
>> > > > > controller driver should do, and as far as I can see, it doe=
s that, yes.
>> > > >
>> > > > Hmm, still things must go wrong somewhere. Perhaps need some i=
nstrumentation
>> > > > to see if all the transfer buffers really hit the PCI mapping =
functions.
>> > >
>> > > Such a test has already been carried out earlier in this thread:
>> > >
>> > > =A0 http://marc.info/?l=3Dlinux-usb&m=3D127074587029353&w=3D2
>> > > =A0 http://marc.info/?l=3Dlinux-usb&m=3D127076841801051&w=3D2
>> > > =A0 http://marc.info/?l=3Dlinux-usb&m=3D127082890510415&w=3D2
>> >
>> > Hmm, thanks. But things must still go wrong somewhere, otherwise
>> > the GFP_DMA32 wouldn't be needed?
>>
>> Indeed, something must go wrong somewhere. =A0Since Daniel's patch f=
ixed
>> the problem by changing the buffer from a streaming mapping to a
>> coherent mapping, it's logical to assume that bad DMA addresses have
>> something to do with it. =A0But we don't really know for certain.
>
> Some more ideas to nail this down would be to boot the machine with
> mem=3D4096M and mem=3D2048M to see whether this makes any difference.=
 Also,
> I think it would be interesting to know whether the patch below helps=
=2E
>
> As the real reason seems entirely obfuscated, there's unfortunately n=
eed
> for some trial error approach. Pedro, as you're the only one who can
> actually reproduce the problem, do you see any chance to do that?
>
> Thanks,
> Daniel
>
>
> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
> index 4328cad..26013be 100644
> --- a/sound/usb/caiaq/audio.c
> +++ b/sound/usb/caiaq/audio.c
> @@ -560,7 +560,7 @@ static struct urb **alloc_urbs(struct snd_usb_cai=
aqdev *dev, int dir, int *ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0urbs[i]->transfer_buffer =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB =
* BYTES_PER_FRAME, GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(FRAMES_PER_URB =
* BYTES_PER_FRAME, GFP_KERNEL | GFP_DMA);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!urbs[i]->transfer_buffer) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0log("unable to kmalloc=
() transfer buffer, OOM!?\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*ret =3D -ENOMEM;
>
>

Good news, I can't trigger the interference with either:
- mem=3D2048m
- mem=3D4096m
- your patch

Any idea why is mem=3D4096m different than a regular boot since I have =
4GB anyway?

Regards,
Pedro
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
