From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 04/11] ASoC: davinci-mcasp: Extract DMA
 channels directly from DT
Date: Wed, 18 Sep 2013 15:51:06 +0100
Message-ID: <20130918145106.GX21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <dc7012e1c2ae59c35eedd9328139f1060048b395.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rVbcdceMkFY6fDyG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dc7012e1c2ae59c35eedd9328139f1060048b395.1379409268.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jsarha-l0cyMroinI0@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, joelf-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--rVbcdceMkFY6fDyG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 12:26:03PM +0300, jsarha-l0cyMroinI0@public.gmane.org wrote:
> From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
>=20
> Extract DMA channels directly from DT as they can not be found from
> platform resources anymore. This is a work-around until davinci audio
> driver is updated to use dmaengine.

Looks good to me but again should get the DT maintainers to check out
this lot.

--rVbcdceMkFY6fDyG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOb3XAAoJELSic+t+oim97SAP/1EqTSuNuUD2WIK9LQ9ewUD1
aQYQLjQ6bXPyzY/xg/hWJnGapDuJ7qOHGTvxJ1wgjZXBAd9n68dx0GS5MCc8jvPH
aPPPuXtm2021EgSpSerHOwTIABS/ZLIkIBhsko1rr0454tkBoJWFytQ86Ch+uT3c
ZqWSWkaSbnZ8jluVzFixO5DL+8RhzSyWEONqT0Ok27zSk9OL+58dCV/tlLhupuQI
/4noBML3pKyodO1TuSPOrbiEFjRR2+igbRezgYNg3uzvFlRTlC15WJowJkA2OQpQ
8y2H7fnvmBkDpYy9V15GZUv3piZXhOl6P8sa5ra9JsDO+o6pNLjphtJCsmG0brCU
bE3/wIU9LAtmw788r5EeKST94FohN4rON6srfu2qHe5k5kWdHIo9hnIbuUFtap+W
2eELcrqCsnWsWQWbW5j2WPFO19ydKuM7rBE1uYAqpUHFpHhPSiccgZVukJlo/AeO
5/CbFunx3fzBqcQwLJpCHITxngIgsopCPvFEuGLSckFqe3wZGVkqTO7r3e5LMcf5
51k7iMDnaehbve1d5dFIG9udsBlC5bS/nGIUwwAx4hJwzD1uIfnUsjJ/tkWmw+LE
N9rt1LmxanSbRzepE8qGwjVIq79pv3N0+mKh/OIjaZ21hwqovRcEZhzHka9LoYLa
plToN7yZbTVh73fI60Fz
=4CPE
-----END PGP SIGNATURE-----

--rVbcdceMkFY6fDyG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
