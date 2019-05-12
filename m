From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
 when pause release after resume
Date: Sun, 12 May 2019 17:07:56 +0900
Message-ID: <20190512080756.GI21483@sirena.org.uk>
References: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
 <aa0c6eea81a721f340dd1362801e49049a6620dd.camel@linux.intel.com>
 <s5htve4mymn.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952838E47@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6435712641589738662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6E1FF896B9
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2019 19:05:44 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D1952838E47@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "Yang, Libin" <libin.yang@intel.com>
Cc: "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "Wang,
 Rander" <rander.wang@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6435712641589738662==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2019 at 02:30:39AM +0000, Yang, Libin wrote:

> I think this may be a ASoC FE-BE defect.
> In this case, ASoC will call FE dai prepare(), but it will not call=20
> BE dai prepare() because of the judgement. This is why I made the patch.

If it's calling only the front end but not the back end that definitely
sounds like DPCM is causing trouble again.

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX1FsACgkQJNaLcl1U
h9DW3Qf+N4/X6mvAmda7LVaF3udDZiG5YNm2xceAXi7Jj99GDH779doij4YfA1BN
pcjw7hft1eNyna3WnGrin8XozWk5/bD6KXwQVQ4iliMKHomitFhjwtjgw/S2XB5w
whnL9oksQ1IWVwoGVorbRTA1abQ1Mc8iN65zMxiZtVZ9zABKoKgGOWy1R18xhbKZ
x308W5iDjOYJpHAxfqIR8yJ+sfqK6JInU3NsPuNjs89jnwwIHDXCQZiLIkuyuvpo
dpwe8Q3/bO6HK23EQqIjxadRG78sNZI8WAZACbeY0vwdRfJtalzvvbdt+Wo7+Rvt
VdXz8EZdCZvDQpLSoInclD5hwq4eMA==
=UKiG
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--

--===============6435712641589738662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6435712641589738662==--
