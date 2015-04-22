From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/8] mfd: arizona: Add support for WM8998 and WM1814
Date: Wed, 22 Apr 2015 12:08:08 +0100
Message-ID: <20150422110808.GU22845@sirena.org.uk>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-4-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429619636-25478-4-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 21, 2015 at 01:33:51PM +0100, Richard Fitzgerald wrote:

> +	switch (arizona->type) {
> +	case WM8998:
> +	case WM1814:
> +		/* Some bits are shifted on WM8998,
> +		 * rearrange to match the standard bit layout
> +		 */
> +		val[0] = ((val[0] & 0x60e0) >> 1) |
> +			 ((val[0] & 0x1e00) >> 2) |
> +			 (val[0] & 0x000f);
> +		break;

Are you sure this approach is going to scale (and avoid confusion)?

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN4EXAAoJECTWi3JdVIfQiD8H/i+Mcwpq04o9WCn7i2ImOUZJ
tpjx1mQNwrCU6fTGW8T82VAEEhUxVyjWGmFC27GziGny0mzhxtCvEJBVEnTprr8y
GXJ0ZXJRriAajV6jKuCc2PkziJlOZgfQ1pkIUlGedwf7h4AVKmKPxdhTze8+c5r1
TIrp//fAQLd8Z3O8ebuZabHcW7s2oITGeeb3S8+E39ub1reNZASrkZhuyk2j1K7m
8VKf63pbM1cCLQ0L/nsL8z+lsV+6jxLlHUYsaWkkFRQvrIoTnenB5zWXVD9I7I/A
Xl04PYcaQ5qCddW6ROzapsmIuHxe0P1tpSZVig6AyvcMwfN5og2kmHX21FW/Mfs=
=YKQo
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
