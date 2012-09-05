From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Fix compilation error due to leftover
 code
Date: Wed, 5 Sep 2012 14:48:07 +1000
Message-ID: <20120905144807.8daf3637d5937917d423b32a@canb.auug.org.au>
References: <1346335575-1592-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__5_Sep_2012_14_48_07_+1000_uybSYvVVuQ8aePvJ"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1346335575-1592-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--Signature=_Wed__5_Sep_2012_14_48_07_+1000_uybSYvVVuQ8aePvJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Thu, 30 Aug 2012 17:06:15 +0300 Peter Ujfalusi <peter.ujfalusi@ti.com> w=
rote:
>
> Part of commit (which patches sound/soc/omap/mcbsp.c file):
> 8fef626 ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
>=20
> since the tree where it has been applied did not had the earlier patch:
> d0db84e ASoC: omap-mcbsp: Fix 6pin mux configuration
> which changed code around omap_mcbsp_6pin_src_mux().
>=20
> Because of the missing part from 8fef626 the sound/soc/omap/mcbsp.c does
> not compile in linux-next.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

I used this as a merge fix patch when I merged the sound-asoc tree today.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Wed__5_Sep_2012_14_48_07_+1000_uybSYvVVuQ8aePvJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQRtmHAAoJEECxmPOUX5FENM8QAJpxvGAPijNbTN9joldPun6Q
EIsHlDgxevKx/xHzwiiThsOWP9iCDAHcVdfOBJ+Zbx0W9ygylRvwmbpp4F4yAUNM
RqihHYt+wVgas4IY3TffalMs1etirure2wmEYyWsLrNY4VdxFqnj/3B5sx28dsLo
lyuQUctlQzFNEWaVOM+3BZsPEyHoBqCnDncgaV3n2dYc4aGcWFhu7eXKg2vL2ZSG
vp2DeyOl28I+326GxD62qATbC+3hVuVvFNSsV6s0oSCN5UNN6ZMPsrWW31hCs+y8
YTlc/tLDSsuMODJkNKmsW22MHB9sKKA0lGyHMwUFMmas6BEz6rtSN+lLkMdIJlKr
EPD1hUgj+SKFjf0sjnitTAXNI7Si1c8gtUb6QAYQUWMZSRxxx7ouXyR+8R+9MZHB
sAFNH2rZupTMt+VgZ1D/CizLxWnzStU5gu8qsw+GXAl3/aRtniNnEu7L0ltXeB+F
xog+LA2SOaCoOETeuuN2jdqKnpwqvdE3Q9BGRaNS5k9oEJ1zCZ0o9yNM/Koe/K99
ruzsw+FmFeVx/kJiztQWRklDn0LAU74l8AFXiFIJE3EGjH2fA5y4XN8thSQ/D/c0
gPmq0t9swBTmgglQCvppMDsyQLXWUoe1fpnRZUDev8njI5C6UNUu4dGy8esnBIDQ
sPoQJ2oYxOSB1jCaAUQ5
=z/El
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Sep_2012_14_48_07_+1000_uybSYvVVuQ8aePvJ--
