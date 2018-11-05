From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8996: fix small typo
Date: Mon, 5 Nov 2018 10:36:57 +0000
Message-ID: <20181105103657.GA5365@sirena.org.uk>
References: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1648711149099712301=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CB622678DF
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 11:36:59 +0100 (CET)
In-Reply-To: <CADnCVLz__D9n+UpFLChVcZkjmFZxKZacCCgufRx8y0_03OGgSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sh liu <liush.damon@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1648711149099712301==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 09:30:06AM +0800, sh liu wrote:
> From e9b923690675ca8fa883fd25dcead5b457856735 Mon Sep 17 00:00:00 2001
> From: liush <liush@allwinnertech.com>
> Date: Fri, 2 Nov 2018 08:57:00 +0800
> Subject: [PATCH] ASoC: wm8996: fix small typo
>=20
> atleast -> at least
>=20
> Change-Id: Icc970b438166daef13518b7d1a62b13eb8752f5f
> Signed-off-by: liush <liush@allwinnertech.com>

This patch is corrupted and can't be applied:

> *codec, int fll_id, int source,
>   if (i2c->irq)
>   timeout *=3D 10;
>   else
> - /* ensure timeout of atleast 1 jiffies */
> + /* ensure timeout of at least 1 jiffies */
>   timeout =3D timeout/2 ? : 1;
>=20

It looks like tabs have been replaced by spaces in whatever you're using
to send it.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvgHUgACgkQJNaLcl1U
h9DPNQf8DyEl8ZqUljGGgyyP48lIp5J+gF2eNUOVP+ebotrVxn197W3Fgp2BU0eU
FVcPNAUqBoRdjN0r9CWjL+2+9xCdHyJHbCCE9OnZrNxwY7CFG2RpchJPTyg/K3FC
Z9ZJkItrmsb615X2elTQbtLu3UipFYk4+BZ4/eQLTSOr3SiAGlxDbTNtqkxFdL0q
ktHpqHlIDhIrrBTNGikjCAkrU5vkkrydY53wVyJhDhz0ljsVh8b1rbMEdgXKlYzv
po1CSPMjprfpx4PGIOKRLHv/+3yNJ/KdFOAYpdPe6y3ca95QA80zZ72s5Rs5XXDg
yL+F8NmbSCoCrOZMED5nLhrIjkrSYw==
=1xwh
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--===============1648711149099712301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1648711149099712301==--
