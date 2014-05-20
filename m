From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
Date: Tue, 20 May 2014 23:13:59 +0100
Message-ID: <20140520221359.GF12304@sirena.org.uk>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-6-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SKnaiO/TCj3ZfC7z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399141819-23924-6-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--SKnaiO/TCj3ZfC7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 03, 2014 at 08:30:15PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.

This doesn't apply against current code, can you please check and
resend?

--SKnaiO/TCj3ZfC7z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTe9OjAAoJELSic+t+oim90zwP/3cNFdU4GRF0FcSPQqNM6Uqc
QHEFCYczoyAj9lVpGEFZ8wEej/lE3Zlu333bSpi8BWf77xQi1vWldycjrdfRegqJ
Q2f/+r1QgCED/OkUgXG+vyTsuZ3jvbr49eTQIKF9+Uzw1XcT/3j/kJtGh9PbCTFq
jGsc7TvJ6dLwpL+PJyKAhmI4ZHPU+45sgXTKA4xf1ian9igBcD8pwOMK7DPRlF0x
olNJnPKz6wyByfgT3Ay4BbtC2rh+Hm+/+prgvjO/4A833PiEmCXPXXDJQ06P9D+u
weN0qsV/AV/QAqCJjhDX9sQb6k3NSNAirxR3EIG5RDiGX8bv0ZeU183AHgLjS9AJ
dHGA/tUb4qgS2dtlc/2Ol9GmRY8yEUysY4SlujPGnX30QuvcHVj14unbGWNgKfLQ
3zwLrWwU0aQBKijCV9iZgAmj4mDGSwJSQ9ui5LLdcL0pVEtsdEX7yh49lT/ZtU23
KRDIbtIeVUf9udUaAqTAWZDX1hHPVx/Ph29gRW0qPIaRGjh9PNrlKTnSFBRJ5jMX
xE2bnN3G/+Mhnl3Nb6wi0txMSBIFYPdt2wDykU6eK97oFTwKkihPNhO5JzzTbm7L
VVyT4LWc3t2nIaHQkX2GWuheux10qd2AGMTBsKMrJ0yDim4UtC/m4WYnSTU9Bxcg
HBEYw+aiXyQ4oa4Smo3i
=rumL
-----END PGP SIGNATURE-----

--SKnaiO/TCj3ZfC7z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
