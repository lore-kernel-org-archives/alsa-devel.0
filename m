From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: AMD: add AMD ASoC ACP-I2S driver
	[v4]
Date: Thu, 20 Aug 2015 14:13:05 -0700
Message-ID: <20150820211305.GU12027@sirena.org.uk>
References: <1440101361-9912-1-git-send-email-alexander.deucher@amd.com>
 <1440101361-9912-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5833709445070535002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26DD1265388
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 23:13:19 +0200 (CEST)
In-Reply-To: <1440101361-9912-3-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5833709445070535002==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iytlPraCFSCqrfnM"
Content-Disposition: inline


--iytlPraCFSCqrfnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2015 at 04:09:21PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> ACP IP block consists of dedicated DMA and I2S blocks. The PCM driver
> provides the DMA and CPU DAI components to ALSA core.
>=20
> v2: squash in Kconfig fix
> v3: squash additional commits, convert to mfd, drop rt286 changes
> v4: squash in naming fixes

To repeat what I said last time:

| Please follow the patch submission process in SubmittingPatches: put any
| versioning in the subject line inside the [] and put noise like inter
| version changelogs after the ---.

> +/*
> + * AMD ALSA SoC PCM Driver
> + *
> + * Copyright 2014-2015 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.

I also remain very concerned about this non-GPL license you are using.
Please do not ignore review comments like this :(

--iytlPraCFSCqrfnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1kLgAAoJECTWi3JdVIfQ3KQH/ig3zPrPlrqK5LMtAdRPE7t2
l6ZcjLtgVl9K8eBGjC1dxBe1so3XFAXlE+1mNubml22LcEJ+A56pQt8XBO2wUy/y
EhwxkAWmq7eqbaG152CUYlGbsas+iJks00tLR8Y3mlv0DjQJdfPdaZb8Nh4yvFhj
WZ7Y/SKvFnA+eqaR92hU/vL0VYDwYsGz1H8BBJneb3jXtheg39EFmMzyXqbD6x+q
/0Rcfem2FQ2lpUCGhoWWMwj0d2kZ6ro3MT82b/Yhs0EpC41ZlWCuJmOxOQ0btql+
41zaSBkFsTqzG9C4lw8iIr0hx4TxNZpqudE7a8tFKL5ynMcE7JieYmg2cQaH1pk=
=44Ij
-----END PGP SIGNATURE-----

--iytlPraCFSCqrfnM--

--===============5833709445070535002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5833709445070535002==--
