From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] ASoC : dwc : add quirk for dwc controller instances
Date: Fri, 23 Oct 2015 00:05:04 +0900
Message-ID: <20151022150504.GS8232@sirena.org.uk>
References: <1444320760-21936-1-git-send-email-alexander.deucher@amd.com>
 <1444320760-21936-4-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1654425124=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1444320760-21936-4-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1654425124==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s9pXJW6w71JX4l3T"
Content-Disposition: inline


--s9pXJW6w71JX4l3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2015 at 12:12:36PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> Added a qurik to assign different base addresses for different
> dwc controllers present on platform for playback and capture.

I don't understand what the above means, sorry.  Normally the address
ranges for devices are supplied via resources when the device is
registered.

> +	if (dev->quirks & DW_I2S_QUIRK_MULTI_DWC) {
> +		if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
> +			i2s_write_reg(dev->i2s_pbase, CER, 0);
> +			i2s_write_reg(dev->i2s_pbase, IER, 0);
> +		} else {
> +			i2s_write_reg(dev->i2s_cbase, CER, 0);
> +			i2s_write_reg(dev->i2s_cbase, IER, 0);
> +		}

This looks like it might be part of the previous change to merge
separate playback and capture instances of the controller into one
device rather than a separate change?  But perhaps what this is saying
is also that the controller instances aren't actually totally separate
after all and the prior change maps well onto the hardware...

--s9pXJW6w71JX4l3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKPsgAAoJECTWi3JdVIfQUVQH/jDKTjyfxtI5aqqj+ueCEpia
DUoLdSJFQNUGeXPZ7xtplyJAZ31ksAho9G7yrEBB/VgsZ81bc4Gn68lrWx8x8ieh
8+WAgjW97QRcl/nMPj/kzC5VhNpvUyf+5mejtFFfFEDiDVV5E88ROJmP+ikRllt5
Ywg9myuvsb+iLVSaBLP0Z7vAjwPwKDoVQovln3BdfSr9UAfhq2ke5TmTrZ51Vemo
/j+A2jdgP3ATAiwDg3rmn/aBRZ8cigi7M3nF+p2Vw6aIyojWbF2EbOZgAOCV+MzS
aDp5pnWJ3AAqWvcaN1L3PX9y1KwHPXSUBMtgtcQJdZIyJvpcUpItg/vHjph3a5M=
=1Nxj
-----END PGP SIGNATURE-----

--s9pXJW6w71JX4l3T--

--===============1654425124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1654425124==--
