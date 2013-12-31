From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 2/2] ASoC: atmel: sam9x5_wm8731: remove
 platform_set_drvdata
Date: Tue, 31 Dec 2013 12:27:26 +0000
Message-ID: <20131231122726.GP31886@sirena.org.uk>
References: <1385546710-11308-1-git-send-email-voice.shen@atmel.com>
 <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H5oeNUPfJ0vte6JU"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385546710-11308-2-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, richard.genoud@gmail.com, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--H5oeNUPfJ0vte6JU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2013 at 06:05:10PM +0800, Bo Shen wrote:
> When call snd_soc_register_card, it will set driver data to this
> device through dev_set_drvdata, then in driver, no need to call
> platform_set_drvdata again, so remove it.

Applied, thanks.

--H5oeNUPfJ0vte6JU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrgrAAoJELSic+t+oim9QxYP/R/3ZyBjRVNGdReUVmSJultC
vF3bNDvAdYrqx/L4S01Qnnw7RuZe42SWc+XMLhEkOWuVBxogYSiF9nxiUkOkW0aH
nol/luQIrHYXDS/pvG9XLGnku0FdNEKanwM5UDESV2LQBAkzGJpksHyK0K+MEAbo
pDnN19TUA+KLVLZnuBEPpLrlrSVThxpHrcQst+HwjcdGL6ekxR8mjYkuIdVYI6pl
bHGEKb2M2OheoJ0egepzpsi2xG8MQtbKnJuVzUGQCes0wPCnVEgJ1q1nGL6l7HvT
ZAySgYcnVTuXpYATjE0CdNhlK6TrRgGKAZwvLwczfTZ0KavtvfF+BiFmdtlWAvxF
yVwhAhCIvWl73Yy+2hrM0MnZXZNcDQfRJtBMyv5EM3Al/cdLF9gj/lpzjagRY7I5
HMfHxhY2RtBmvSjrk2NnT4PAQMauuMarzkT1IVGodnbV44TsPhWFiRmkRZvSonkA
7H/ZP330rd5PTxMP0Bbom57odMemMQdl6shd3u6HALJwOVqouWO6JvTwmlVHWjNl
koVRuMWTLG2rqvi7b3tbLfusNfzv65T9vblph0GmU4dENDOV/Uxoh+WKEo7NkVvX
NcQj6qngKqEODUCP0lULkQgENM0Jqc8FtLKpzsWowEIrGry9tnHWjjItUl9uERqq
/qDt5nlWhGC3ur65vI8e
=XQZp
-----END PGP SIGNATURE-----

--H5oeNUPfJ0vte6JU--
