From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mfd: arizona: Add DT binding for irq-gpios property
Date: Fri, 6 Nov 2015 09:49:20 +0000
Message-ID: <20151106094920.GE3378@x1>
References: <1446559806-3315-1-git-send-email-sjan@baylibre.com>
 <20151103150450.GP20228@sirena.org.uk>
 <20151103165247.GC2549@ck-lbox>
 <563AF241.5030404@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <563AF241.5030404-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastien Jan <sjan-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, 05 Nov 2015, Sebastien Jan wrote:

> On 03/11/2015 17:52, Charles Keepax wrote:
> >On Tue, Nov 03, 2015 at 03:04:50PM +0000, Mark Brown wrote:
> >>On Tue, Nov 03, 2015 at 03:10:06PM +0100, Sebastien Jan wrote:
> >>
> >>>+  - irq-gpios : GPIO specifier for the GPIO connected to /IRQ
> >>The platform data this is providing is essentially a workaround for=
 the
> >>lack of an irq_to_gpio() function and the use of it is a workaround=
 for
> >>the lack of level triggered IRQ emulation in genirq...  do we reall=
y
> >>want this in the ABI (especially as a generic thing)?
> >Personally I would rather not add this to the DT unless we really
> >had to.
> >
> >Also are you sure this is necessary on your system? Specifically
> >you only need this entry if the CODEC is connected to an IRQ line
> >that only supports edge triggered IRQs.
>=20
> Mark, Charles, thanks for pointing me to this information.
>=20
> I don't have this specific constraint on my system and could finally
> also have it working using the regular interrupts / interrup-parent
> properties.
>=20
> So this new binding is not required for my case. I suppose we can
> forget about it.

My favourite kind of property. ;)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
