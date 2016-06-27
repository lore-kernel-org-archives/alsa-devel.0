From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 4/6] ASoC: max98504: Add max98504 speaker amplifier
 driver
Date: Mon, 27 Jun 2016 17:33:12 +0100
Message-ID: <20160627163312.GB17217@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-5-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466678715-19962-5-git-send-email-s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2016 at 12:45:13PM +0200, Sylwester Nawrocki wrote:

> +	/* Select analog input by default */
> +	regmap_write(map, MAX98504_REG_SPEAKER_SOURCE_SELECT, 0x1);

This should be done by userspace configuration, just leave the chip at
power on defaults.  This is policy so that we don't have people trying
to patch their configurations into the kernel.

> +	/* Brownout protection enable */
> +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_ENABLE, 0x1);
> +	/* Threshold 2.9V, 3dB speaker attenuation*/
> +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(1), 0x33);
> +	/* Attack hold time 10 ms */
> +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(2), 0x0a);
> +	/* Brownout hold time 255 ms, brownout release time 255 ms */
> +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(3), 0xff);
> +	regmap_write(map, MAX98504_REG_PVDD_BROWNOUT_CONFIG(4), 0xff);

Should these be DT properties?

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcVVHAAoJECTWi3JdVIfQbaMH/0DhY1a5e1xSY6ha+04KNm2V
tTO3HF6X8qcMQuPn7nrF2K69lr9vO0Pd5z0v0lNf3Fk719uEuP+L4X9GWRgp7JgI
VbFTgwqA5Sd9hy1hWu9P1R52EHcvxJf3I9gMyDY2wyuXvlPRq9jNfJrYSKPbuJU3
pJp1Oo8gfy6TnIAL7T8dm/YrjWWcA590rgmVd3ELklf1fTMTkStUkaY78DHijN4G
0BUmE5/sc1a30onom/CMO6jJnr5GFgynGTyHhHPZuKqosJFz1/btjqtj7nX5w1FW
jcexU1vbbu4ijBsvstcQmBC26gZH4BgKTG7UkwF58NwkooCkVJAk1I4QjXdVKpQ=
=8xJo
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
