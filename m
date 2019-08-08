From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Thu, 8 Aug 2019 23:22:01 +0100
Message-ID: <20190808222201.GQ3795@sirena.co.uk>
References: <20190808095715.29713-1-tiwai@suse.de>
 <ae7d32fe-a279-8309-2370-1832edcce413@linux.intel.com>
 <s5hr25vhg22.wl-tiwai@suse.de> <20190808190343.GK3795@sirena.co.uk>
 <s5hftmbie9i.wl-tiwai@suse.de> <20190808213311.GN3795@sirena.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4111359268216482010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E5B7F800E3
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2019 00:22:07 +0200 (CEST)
In-Reply-To: <20190808213311.GN3795@sirena.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4111359268216482010==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
Content-Disposition: inline


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 10:33:11PM +0100, Mark Brown wrote:
> On Thu, Aug 08, 2019 at 10:38:33PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
>=20
> > > I can do that easily enough.
>=20
> > OK, I pushed out the branch topic/hda-bus-ops-cleanup.
> > Please merge this one and topic/hda-dmic branch into yours.
>=20
> There were some conflicts which hopefully I resolved OK, it compiles and
> everything so it can't be that bad right?

Had to rebuild this since git has a bug with recording merge conflicts,
just pushing out a new version now - c2f16a94a80497e4b28c27f9ca2cd6cd60706f=
b6.

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MoIgACgkQJNaLcl1U
h9A+Lgf+OjT474QET27zAxnAHq9J7rgyNL2aZYt8Vll6YO1QtIqx4dbatRIf35b8
dHL7Kr/B2SZJ9sFNQ7uG7CkoQ6awlQ2EODz8evfYbX+QpxdVPwg8ZYkxelNWm8Tj
BWlVvXvRg5qo3jEfiJcrnD6X7lpkJ4i5VACSwhF1gEUp+/BqHv2/5tF93t/usedL
8Z92n4cwswHf1Od1T8oIBzYgTS9GJixbs0loxgAKSODl33gKE51UVPJ9E+qpF5bP
GrmVjI3PXiVM3wD2AvYdQiUc2UVsKL3IujupYSmpBmXaHZ9iedyewaQq12FVnEXS
dvVDRNz6Puk6qi3osip0+E6OWZsrlw==
=wmA5
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--

--===============4111359268216482010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4111359268216482010==--
