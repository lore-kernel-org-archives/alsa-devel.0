From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: fsl_sai: add sai master mode
 support
Date: Wed, 13 May 2015 12:43:21 +0100
Message-ID: <20150513114321.GK3066@sirena.org.uk>
References: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6652779368483651051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B2D8265AD8
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 14:16:22 +0200 (CEST)
In-Reply-To: <e6293a2408ccd8390fa2999df2af26b6de20f933.1431500729.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============6652779368483651051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ljn2+zwPkKedfiv/"
Content-Disposition: inline


--ljn2+zwPkKedfiv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:12:59PM +0800, Zidan Wang wrote:
> When sai works on master mode, set its bit clock and frame clock.
>=20
> SAI has 4 MCLK source, bus clock, MCLK1, MCLK2 and MCLK3. fsl_sai_set_bclk
> will select proper MCLK source, then calculate and set the bit clock divi=
der.

This looks like a patch I've already applied?  If there are any changes
needed please send incremental fixes.

--ljn2+zwPkKedfiv/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzjYAAoJECTWi3JdVIfQO+oH/i54BuaZgM2RreWpI3PTmABP
b9YBqj/V1AZIgEXjJltESwjIAK8VQhoV7+X+UzuIAQomLr1b3PWDQlwbutNTWtCC
JYM596ewKG8clk4W2C0UjfnT3lMBwuRRuGsOJ/yzilOZZYov2Gx+qEK6TdNLbn1L
BTVt29gGbGN6avYB5J3D6bCsz8gVAZpYPBbw9Q7Mux8IjzAGPjdIWxcQu4omE4hF
KF45V397gqe0AwHmVsqkKCANYsbRgwk6mGR6yrDjaSIqvg4FSv8aEV1rotvEGFCF
AGZB8SOszZza1Al4ThMxwhIZw9DfHf1H8xOXlL2dHGOM0lfAsyEULwebFjtkUTk=
=BZ2a
-----END PGP SIGNATURE-----

--ljn2+zwPkKedfiv/--

--===============6652779368483651051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6652779368483651051==--
