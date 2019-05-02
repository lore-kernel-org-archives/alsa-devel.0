From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Add support for high power analog
 output
Date: Thu, 2 May 2019 11:09:22 +0900
Message-ID: <20190502020922.GA1602@sirena.org.uk>
References: <20190430200118.13014-1-sravanhome@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430200118.13014-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravanan Sekar <sravanhome@gmail.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2019 at 10:01:18PM +0200, Saravanan Sekar wrote:
> Add support to output level control for the analog high power output
> drivers HPOUT and HPCOM.
>=20
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>

This doesn't build with current code:

  CC      sound/soc/codecs/tlv320aic3x.o
sound/soc/codecs/tlv320aic3x.c:428:20: error: expected =E2=80=98}=E2=80=99 =
before =E2=80=98;=E2=80=99 token
    4, 9, 0, hp_tlv);
                    ^
sound/soc/codecs/tlv320aic3x.c:330:61: note: to match this =E2=80=98{=E2=80=
=99
 static const struct snd_kcontrol_new aic3x_snd_controls[] =3D {
                                                             ^

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzKUVEACgkQJNaLcl1U
h9COAgf/bEXTHlf3176QpGpGHCWyhIp2dGCP6gMgr0PXVEVWSMHxsgsy+VoB9x/n
lApLY1dU5su1ZFAIfrgKw50lYRcplng82rn9ucAWXaU/mRh5siPAvHoNajCauI8n
6mjjlv4gngHg8ctQQ2y0vNyzs96MlMcs9aYnIBYnLDOthFBbcai8IBRcgxw2pWp7
dqJK+je2hIFMyJN3ChvgU0h9/C0OFWraSShvMEZRmQJJQ04IxjjuCUXKqHUYoqcZ
QkGa/zyYw/rrD4XlTp0dQF3aVwe+b4SuytbQ6Hf0bd6Z8G2ze70jSXuArQpLa/Tq
jx6FAB963mIStEewayY4z0zmNbQqzQ==
=WLwu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
