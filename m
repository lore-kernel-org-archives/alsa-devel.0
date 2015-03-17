From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9] ASoC: dapm: add code to configure dai link parameters
Date: Tue, 17 Mar 2015 22:55:33 +0000
Message-ID: <20150317225533.GT28806@sirena.org.uk>
References: <1422896805-18135-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cX6v06kgJwdgCvne"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422896805-18135-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--cX6v06kgJwdgCvne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 02, 2015 at 05:06:44PM +0000, Nikesh Oswal wrote:
> dai-link params for codec-codec links were fixed. The fixed
> link between codec and another chip which may be another codec,
> baseband, bluetooth codec etc may require run time configuaration
> changes. This change provides an optional alsa control to select
> one of the params from a list of params.

Applied, thanks!

--cX6v06kgJwdgCvne
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCLDkAAoJECTWi3JdVIfQipIH/2xHR5tKQf8e/BILLMXTLeEn
J4xCTpCbsEGJ8+SOzCdgh1PZrrEqBbl3A47OeaIWzhVNnxnpfY6Zmzi8Cdl4l1DW
nDZ3Y+eYv7SbX0hOT6tkYvL46itreok4hy5O6vzL9OqjOjFY+vABmldxHNDkZqAz
EeV6V+3zLMokgNz0V4uy8Ft3z5fwGm4jqFMyL0cyp3u/S8/7LJpDOBVlXCJMwzTp
MsNIFv1N3IX+UBcoccaFWVl5zWhOt2t6mbU0EKVfkbIWxPKIvR2m/xkodYp/WcEf
hFFcK91EQSwNXLOu/pkyvVhbcVuv2DdpL1bneiWN46DVJoDS6GZcVOD/5pYFHUE=
=zKuA
-----END PGP SIGNATURE-----

--cX6v06kgJwdgCvne--
