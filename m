From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
Date: Tue, 3 Dec 2013 12:29:17 +0000
Message-ID: <20131203122917.GD12031@lee--X1>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
 <529DC6BE.3080607@metafoo.de>
 <20131203120420.GC12031@lee--X1>
 <529DCB76.4070705@metafoo.de>
 <529DCD8A.30600@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529DCD8A.30600@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Dec 2013, Lars-Peter Clausen wrote:

> On 12/03/2013 01:15 PM, Lars-Peter Clausen wrote:
> > On 12/03/2013 01:04 PM, Lee Jones wrote:
> >> On Tue, 03 Dec 2013, Lars-Peter Clausen wrote:
> >>
> >>> On 12/03/2013 11:27 AM, Lee Jones wrote:
> >>>> If booting with full DT support (i.e. DMA too, the last piece of=
 the
> >>>> puzzle), then we don't need to use the compatible_request_channe=
l call
> >>>> back or require some of the historical bumph which probably isn'=
t
> >>>> required by a platform data start-up now either. This will also =
be
> >>>> ripped out in upcoming commits.
> >>>>
> >>>> Cc: alsa-devel@alsa-project.org
> >>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>>
> >>> Strictly speaking you do not need the second config, but well con=
sidering
> >>> that this will all hopefully be removed soon anyway it should be =
fine.
> >>
> >> That's true it will, but why don't we need the second config? I wo=
n't
> >> want the compat function to be called in the DT case.
> >=20
> > It will only be called if it was not possible to request the DMA ch=
annel
> > from the DT.
>=20
> The logic used to request the channel is basically this (in pseudo co=
de).
>=20
> chan =3D NULL.
>=20
> if (of_node && !(flags & NO_DT))
> 	chan =3D dma_request_slave_channel(...)
>=20
> if (!chan && (flags & COMPAT))
> 	chan =3D dma_request_channel(compat_filter_fn, compat_filter_data);

Okay, fair enough.

But as you say, this should be fine for now. I'll tend to the
left-over cruft when I convert the driver to DT only.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
