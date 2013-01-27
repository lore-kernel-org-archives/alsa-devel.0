From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: Fix data rotation for playback.
 Enables 24bit audio playback
Date: Sun, 27 Jan 2013 14:16:12 +0800
Message-ID: <20130127061602.GE8952@opensource.wolfsonmicro.com>
References: <1358500620-24480-1-git-send-email-michal.bachraty@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358500620-24480-1-git-send-email-michal.bachraty@streamunlimited.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: tiwai@suse.de, perex@perex.cz, lrg@ti.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2013 at 10:17:00AM +0100, Michal Bachraty wrote:
> u32 rotate = (32 - word_length) / 4;
> This implementation is wrong, but it works only for 16, or 32 bit audio data.

Applied, thanks.

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBMXlAAoJELSic+t+oim9YioP/A6PGZp7mNDVYu6PC+KhTvzP
W4tccBBdqwEEuv7EX3rlBa1Sb8v4Peeix4XppXc8ol/e0AsfDr4uBjguhI8jrFJl
DgpHKp195aKsZXCsjcT4vFmtSDkTxJF7AI4jMvQh5zfuOUKF/XSyOuctuDDO1hrQ
WqnietiG88HJcdR5v/DyuawQWpccnNbPR0KHYVFaiRXqzWR59nmBR/Adp6Vny5qb
HwUNe8TjMQFqcQRj7RKbg0BlRg5WH/QXbbECa+LwBNB9XvgzH5tt2zsNqszjgsMz
UBhS/eVNpHcdFmfeLq3bMpLPqI0UgzWSARS7ILJBWI1BmtOtRbv65LPI/qcTM31n
CdBFrVtJTZ3LuOAKaJ10C4HDpLqR0UwZhAJXkE2fNtqEKk8wss025u/I/qLVJhuf
vdrvBhXJ5Fwpkhfk25PngXu4pxCCs5QDAAE+5uvL/fZrAxE08wzw8qwJ7xACuXgj
Jyuuv0BjVDLPhWRdGl+Xa2cx2wZCMUqfxPoGx5hXw11KKTASTEhGcj8ZsugEtLsn
Sdx1PdnLtMD6R+6wbEbs5ajdgN+NoH4E8XPwveCvS1EyPJPUwBO9GMGdYfHlZbMc
Gr2wVQBM6G7B1tJ6Cl+NlvLthpkjQ7hMwRr+8oBQm8tQvFi/UnDxhkTogJxKTP/0
+9JucBLqtsxdUc8/WEcJ
=A+Ib
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
