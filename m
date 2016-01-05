From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: Intel: Skylake: fix
	memory leak"
Date: Tue, 5 Jan 2016 17:24:17 +0530
Message-ID: <20160105115417.GL2940@localhost>
References: <1451994364-29338-1-git-send-email-vinod.koul@intel.com>
 <20160105114622.GY16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7222253525222279430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4822606C9
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 12:50:49 +0100 (CET)
In-Reply-To: <20160105114622.GY16023@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7222253525222279430==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 11:46:22AM +0000, Mark Brown wrote:
> On Tue, Jan 05, 2016 at 05:16:03PM +0530, Vinod Koul wrote:
> > This reverts commit 87b5ed8ecb9fe05a696e1c0b53c7a49ea66432c1 ("ASoC: In=
tel:
> > Skylake: fix memory leak") as it causes regression on Skylake devices
>=20
> Please use subject lines matching the style for the subsystem.

Is this an automated mail :) but its signed!

Btw am not sure why this is not proper, isn't revert followed by old patch
title the right style for revert patches..? what did i miss...

--=20
~Vinod

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWi67pAAoJEHwUBw8lI4NHOYIP/2BaMZi022EseyPMcQVg7duE
mw8wJrEYprKWqYq3DjVBU+2rjvP84lS9hsvZrvan+Y26gZTGR518daLOI8Xo4XLp
pN/nseevn8zFzMHQhJcyC2G5lDfkqCDvztJgaHpQXOXePm4TUMEaS7/nHfGZ4elg
iEZURrd48+qyvJeGY4Mxd21CU/exSn2BeAB+kUuOkkK4xkNsSz7JmD06sXMMM1gh
6WNvKOBgtBmSpp0b07hyLFArCusV4ao6QGNnmZ3cARe0BgCAcz193rI0ygLHdKN8
sHGcDpZVG5pz0LaoqvXbA0TEG0p+URBEMU/atvpA2JigWHndYdFJY1F/srMe1N25
RLium43ZVfYNiWPsGr+o3lx81jKHKmjx3uS/LSLG49E+0FMWpg6b+xmC4Wo0IERb
lzz/jH3F34neKTwNWW9nLLfvsxirZ6KMSKHbMVUISLkepM79tV9aOoqbkIdxSYwU
aGYjRsMENAt6SoHWXqu5DcFu6ElMDdx15MfbFaVqSPIowR1jUXVMpCl8x+CMdGg2
6ZOtwQbGjsNYjPozoF+TfSgY4TOX8www+gmS5lswiizKKOqJVSYxdxgcBAMXaHEi
t/lIEcCFiSpWwKlRcQ+Cwu6FgJFhkF3x+b+CXR5Ki0BFdvtr0+dYfRMxsTDIimg9
VRKqSPeENi7xF17AccAJ
=uyk7
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

--===============7222253525222279430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7222253525222279430==--
