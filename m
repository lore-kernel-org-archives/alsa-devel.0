From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/16] mfd: madera: Add register definitions for Cirrus
 Logic Madera codecs
Date: Fri, 7 Apr 2017 12:14:58 +0100
Message-ID: <20170407111458.vw7oxemasqhcfepq@sirena.org.uk>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1491386884-30689-2-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdaYzPSVqqhbi2Zop7J9vzCqZZiN=9pAEw1vcWy_ove9Tg@mail.gmail.com>
 <CACRpkdY=cOhw59O8EE6J82aq897YKZkLsmUzeEnzkC5jtT6yyA@mail.gmail.com>
 <20170407084823.GB3412@localhost.localdomain>
 <CACRpkdZLfL+dxMN-uaRp57u4yW4cLfLFoZVkNWFZL4eECOyR1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k4nxp35gqq27j42m"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZLfL+dxMN-uaRp57u4yW4cLfLFoZVkNWFZL4eECOyR1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--k4nxp35gqq27j42m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2017 at 11:12:53AM +0200, Linus Walleij wrote:
> On Fri, Apr 7, 2017 at 10:48 AM, Charles Keepax
> > On Fri, Apr 07, 2017 at 10:30:12AM +0200, Linus Walleij wrote:

> >> > Get included in all subdrivers I suppose?

> >> > So you are broadcasting 8800+ lines into every subdriver across the
> >> > entire kernel.

> >> > Just the time spent in the preprocessor parsing this will affect compilation
> >> > time.

> >> Or maybe this is a necessary sacrifice to get the regmap cache
> >> centralized in MFD. I don't know. I feel stupid.

> >> I guess I should focus on "my" subsystems...

> > This only gets included in files that are part of this driver, it
> > shouldn't affect compilation time for anyone not building the
> > madera driver and even then it should only affect compilation
> > times for the 10 or so C files that make up the driver. Also I
> > don't really see any other way to specify the registers for the
> > device.

> No when using regmap cache this seems necessary.
> I was just wrong.

Right.  The other thing to bear in mind with things like this is that
often if it's the chip vendor they've got mechanisms to generate the
register definitions directly from the chip design so if we take the
complete thing with minimal edits it's a great way of ensuring we've got
information about the chip in the upstream kernel to support future
development.

--k4nxp35gqq27j42m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljndK4ACgkQJNaLcl1U
h9AcrQf/fG+V7Yqvtyj+A9tD0Pa38YObImkcpc/f14hebTVi+wnwaAb31NfjLeZx
MTN45CwPQBj80UhTFhFaYKeOOPAmtmH7QWr0PqW33f99e/Qcvv2nyQOTaw6Mqef8
p8JwoPBdrejXb+sftbbMhMt1Ti6ZIOGvV/v64REmHwxNp/nL5DkiqjEjHD2DgoKl
ZrE4ayBB5w6YQgaWruaEuTEJQRL5R3HK9v8AyFtdY12iMlTsd+UTevqoJmi0vrLW
hx2AdajwjehAC/n8rSY9vE+Gc+KAKcEHjYCNVWClP4hQ1y4vecVE6/bLsKDlze9C
RTA+TF7mDZWi2Vokx9b+JqAZXk4NaQ==
=4XT0
-----END PGP SIGNATURE-----

--k4nxp35gqq27j42m--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
