From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
Date: Tue, 3 Dec 2013 12:04:20 +0000
Message-ID: <20131203120420.GC12031@lee--X1>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
 <529DC6BE.3080607@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <529DC6BE.3080607@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, broonie@kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Dec 2013, Lars-Peter Clausen wrote:

> On 12/03/2013 11:27 AM, Lee Jones wrote:
> > If booting with full DT support (i.e. DMA too, the last piece of th=
e
> > puzzle), then we don't need to use the compatible_request_channel c=
all
> > back or require some of the historical bumph which probably isn't
> > required by a platform data start-up now either. This will also be
> > ripped out in upcoming commits.
> >=20
> > Cc: alsa-devel@alsa-project.org
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> Strictly speaking you do not need the second config, but well conside=
ring
> that this will all hopefully be removed soon anyway it should be fine=
=2E

That's true it will, but why don't we need the second config? I won't
want the compat function to be called in the DT case.

> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
