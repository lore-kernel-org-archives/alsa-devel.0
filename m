From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 4/6] ASoC: max98504: Add max98504 speaker
 amplifier driver
Date: Tue, 28 Jun 2016 20:31:43 +0100
Message-ID: <20160628193143.GA17217@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-5-git-send-email-s.nawrocki@samsung.com>
 <20160627163312.GB17217@sirena.org.uk>
 <5772BB07.4000609@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bWJzwVwZrZVVyQvz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5772BB07.4000609-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--bWJzwVwZrZVVyQvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 07:59:35PM +0200, Sylwester Nawrocki wrote:
> On 06/27/2016 06:33 PM, Mark Brown wrote:
> > On Thu, Jun 23, 2016 at 12:45:13PM +0200, Sylwester Nawrocki wrote:

> >> > +	/* Brownout protection enable */
> >> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_ENABLE, 0x1);
> >> > +	/* Threshold 2.9V, 3dB speaker attenuation*/
> >> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(1), 0x33);
> >> > +	/* Attack hold time 10 ms */
> >> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(2), 0x0a);
> >> > +	/* Brownout hold time 255 ms, brownout release time 255 ms */
> >> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(3), 0xff);
> >> > +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(4), 0xff);

> > Should these be DT properties?

> I'm not sure, these properties define the speaker gain decrease pattern
> during VBAT brownout, it seems a system integration detail and will most
> likely differ from board to board.  I'd assume it's acceptable to put
> these in DT, looking at other bindings.  I've prepared something like
> this:

Exactly, yes - it depends on the characteristics of the speaker which is
hardware.  Your proposals look OK.

--bWJzwVwZrZVVyQvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXctCeAAoJECTWi3JdVIfQ7AoH/3lfeqMgbw8bXiy4M43euDkV
P79RywbR4uAS2LLKVqISbKFU9Cuw/RYOTXLANBfrbAOiWe9MbJN9/Ufj3BVf0xPm
iKVig8hO7M2+V2dC293JV84eiY9lRon5c/kWG1XzyTODl3WW1ucQnms90snEU0dI
OKgGZYdD5sAIkDKrUOOvLtbDy5vFCAXucW7yjiXSBrBVK1KwnliLt6jod6qgr+Py
FXe3PT4Zh04ZUG9skVgTSDgNcCUbYwXe5qFHVuBb9e/1o1mW2E55Z0Vv8NQMl58x
CeeRfcM/dcbkIEKhgXuLJ3M0YvvXtHfFdgPuFK2hNDytxJM+l7xXinvKAxNSlXw=
=3jhd
-----END PGP SIGNATURE-----

--bWJzwVwZrZVVyQvz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
