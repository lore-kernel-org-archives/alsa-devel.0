From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: topology: fix get control data
 return type and arguments
Date: Wed, 21 Aug 2019 13:08:44 +0100
Message-ID: <20190821120844.GH5128@sirena.co.uk>
References: <20190820034331.38171-1-jaska.uimonen@intel.com>
 <2dc34431-7302-85c7-8215-472c7d994f7f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6689198127121539000=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com
 [209.85.128.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 618B4F802E0
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 14:08:45 +0200 (CEST)
Received: by mail-wm1-f100.google.com with SMTP id 10so1856980wmp.3
 for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2019 05:08:45 -0700 (PDT)
In-Reply-To: <2dc34431-7302-85c7-8215-472c7d994f7f@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Jaska Uimonen <jaska.uimonen@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6689198127121539000==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 07:30:25AM -0500, Pierre-Louis Bossart wrote:
> Added Mark and Takashi in Cc.
>=20
> On 8/19/19 10:43 PM, Jaska Uimonen wrote:
> > sof_get_control_data returns negative values even though the return
> > value is defined unsigned (size_t). So change the return value type
> > to int.

Please send me the actual patch, I can't apply quoted material.

--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dNEsACgkQJNaLcl1U
h9AOMQf+IXUqh+tEdDG3vJ/gD7+IKOUXG6qfezuU4lbM/r2AOc0z8qdM8SEtAnaZ
TzO3Q8M5qYWzo7zmtM9Fpv6k1FOd4dTylRpYI8QvALg7D0+8zyONEPFp1kHipaph
3SBkgRf6nIJZi80cZklOaiipCejC6X3Gl/ndDrpNJt86hg8Lj4PMcBuCN+qBRHBt
f8cyCGDAI6hjGedQtdR+PXiJFdBvMZJnOrbnh5b7fPFVpED5FI0lyAij6JZ2o7Pc
tw+5kpyfcEj2sogx0vZBkgexZFzP29I/dvDb6aPUFwKryqIlfUmzWAelZgh3d8FB
NW1SYAP7pCM0N82py/UByzOnkYcvAA==
=Xssx
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--

--===============6689198127121539000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6689198127121539000==--
