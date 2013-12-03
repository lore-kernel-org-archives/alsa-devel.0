From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8731: fix dsp mode configuration
Date: Tue, 3 Dec 2013 15:05:29 +0000
Message-ID: <20131203150529.GX27568@sirena.org.uk>
References: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8QEjIIRQMK54tiVT"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386065094-26018-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--8QEjIIRQMK54tiVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 06:04:54PM +0800, Bo Shen wrote:
> According to WM8731 "PD, Rev 4.9 October 2012" datasheet, when it
> works in DSP mode A, LRP = 1, while works in DSP mode B, LRP = 0.
> So, fix LRP for DSP mode as the datesheet specification.

Applied, thanks.  Please do remember to CC maintainers on things, you've
missed the Wolfson guys.

--8QEjIIRQMK54tiVT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnfM2AAoJELSic+t+oim9js0P/2B0ZIf9M0GLr8hVpa8Y/gg0
9iqGP1elYLifsKAYhUr0YWMseCcs12+voLiSMLxiiadbEtPLN4kaZcuC5hFGBuC4
ujW1NsL9FMij/2DR4JEtcI1FcHKTY8GLv5phd/qSiJwbfoZK+RlS+IHjWfjjAW+X
ADN3GQ9udnisnnX2Zc4V/Q2oYF/utkbnTzjE6LrSfmQmEyJF/0CEXJJ8bE6G8SHP
MXAn0iDZfr2Zf9Ivj14pDYnOTfAyF6Wl0av4bhSvTR+OuEJZgWMpOThD3u31xgQ+
Q09XHxwLHq7/UQ/SnlMbpmdPCuulvQvdqMix68yvkqJnstKmljzCLqYNeUH/PqEd
gogWKTMH1Nv0wAdUXZZu2VB/Qx6ciq8/u2ZgxDviUaspgZwOWoFEimq0RaFISwpp
/B5Pa0EJvzzK+QyIwWiYCLELbESVu9PeVcxqkbvsRDKxJniXl6RHriUpyzsD0NB6
6NIDtrxDutDqURa3hYxC8VhEzpb9BTBCVnvh2P4ybabL58vRTXaHtRM4J+BLjpe1
xyNSkkaUVencO7oM6ps86LxnxlrpgSTPP6g7WFvbOy25aDn0b7rvoY9muCTaUIdG
RWUBb1XNVAhUX+X0z/aAAv0lxkt1Xu1amdJSBvv9MApcak4CAvPUwkyP/TDGW9uv
cP9yhuSgFHgAL0fXGzqr
=DToB
-----END PGP SIGNATURE-----

--8QEjIIRQMK54tiVT--
