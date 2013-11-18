From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] ASoC: simple-card: add Device Tree support
Date: Mon, 18 Nov 2013 14:31:35 +0000
Message-ID: <20131118143135.GA24408@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
 <87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
 <20131115155028.GE24831@e106331-lin.cambridge.arm.com>
 <CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2013 at 08:12:06AM -0600, Rob Herring wrote:

> Can both sub-nodes really have different clocks? Seems like that would
> exceed the definition of simple.

In theory, though it would be unusual.  What is more normal that the
clock is only connected to one of the nodes and we need to know which it
is.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSiiTDAAoJELSic+t+oim9UEAP/3khHZVH7eCryvuFFq4rn1tL
ub7446l0CapKkJX1WoZtov/Aq6PoWjxFQL2XMtS7uQ+KunnyrOG6B1zFUrpTSy5/
ULPjdX/Bm10JO3EHtKlORnBWWP2czkpHWC9PCDrC2tn934ZoiCHoFv4kZ/EoUjf/
88X7nCZLNkMwO4baLfmSZp71/hxw+D5FYhjuiSTlRcJ0J6LyNn8JTYJjC5Rc1IIO
GDjNqYCK6fROjP8aZSRPmpUMwi4/HpaT6iICOXAmGTX2KinCdoslSbHdxLaG/Fc/
bHEIpsbfnDWsytdN2uEmJbmXOuV2Bugg7CJueO+AvzNM/oW8CGb1jIA/hKSpctYu
6v3n3VFICd3pMOm0xblImhmBizXaSIM7A1oIIhJ7vD5vFDnuPSoTEuszcEDBJs+Z
K4/ssrTO8CPvrWwvpOKDltx3/7Za5DdvhPiTjpL1noSZHHxjuZnsNKJ2iUgzRW/N
Rc9PCVwzSVVmQ2bnEozSnXrjiBXAxoZ/9qedzFH9nxVrRcLKuhs75c5RsUgGO8E3
hNJq4db1/fpOlkWopc9H03Ta3Ufh3OS9u2GMED3Lq9dHCPQzEdJFex52ruULfCRT
Dq5Ta++BssYzqK3V9h2DWEQwMhq72seNKGjBEyW15Kwfqb9QlMj+lFJPQPVSmi7i
akqbmOWtc8Iw6bK2nqDl
=efQr
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
