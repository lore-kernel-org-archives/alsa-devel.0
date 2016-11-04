From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/17] ASoC: soc-core: snd_soc_get_dai_name() become non
 static
Date: Fri, 4 Nov 2016 14:24:32 -0600
Message-ID: <20161104202432.sz7jlkhh32oqrahd@sirena.org.uk>
References: <87pomhba6r.wl%kuninori.morimoto.gx@renesas.com>
 <87ins9ba2c.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6xtutlgqos3vhvb2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ins9ba2c.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--6xtutlgqos3vhvb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2016 at 01:17:09AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>=20
> snd_soc_get_dai_name() is used from snd_soc_of_get_dai_name(),
> and it is assuming that DT is using "sound-dai" / "#sound-dai-cells".
> But graph base DT is using "remote-endpoint". This patch makes
> snd_soc_get_dai_name() non static for graph support.

I was going to apply these first few patches but unless I'm missing
something they don't seem to apply against current code - can you please
check and resend?

--6xtutlgqos3vhvb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHO59AAoJECTWi3JdVIfQvnMH/Al4aoLCKeG5bW87GVsKr1Kg
z0+A+xEgPQ6JFryKtgVEzFDnQcDRwdWH/zBSR5BlseY3qMEEw/VvvvgVZjgJln4w
/zjE8+hl+oNysP6648LoMrJfTkjjpRuRWg6pW6S5HtOgCDE0VAbnKPZyVo7s7+p7
+jwk+n47wV9CNqCbq4jXroeAaoHzhsCwNf+N3aTdxZ0vk9Hm9ffrI5Sac3dZDFdB
r2XtUpsN/ueunr3rDskWCXDalCfbSAKgATnEKCpReUa/qqfHD/jIFPGiVd1afrkg
hFmglP8/V8W11EFk6x4QT6Ps5BL9P5z0krIkYlgWKRTiZy9C4PlCr2J0aj7g8VM=
=QEYi
-----END PGP SIGNATURE-----

--6xtutlgqos3vhvb2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
